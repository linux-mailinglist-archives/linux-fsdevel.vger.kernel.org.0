Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6449138AFFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhETNbq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 09:31:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:36506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238818AbhETNbh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 09:31:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AE25ACAD;
        Thu, 20 May 2021 13:30:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 375151F2C9C; Thu, 20 May 2021 15:30:15 +0200 (CEST)
Date:   Thu, 20 May 2021 15:30:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 6/6] gfs2: Fix mmap + page fault deadlocks (part 2)
Message-ID: <20210520133015.GC18952@quack2.suse.cz>
References: <20210520122536.1596602-1-agruenba@redhat.com>
 <20210520122536.1596602-7-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520122536.1596602-7-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-05-21 14:25:36, Andreas Gruenbacher wrote:
> Now that we handle self-recursion on the inode glock in gfs2_fault and
> gfs2_page_mkwrite, we need to take care of more complex deadlock
> scenarios like the following (example by Jan Kara):
> 
> Two independent processes P1, P2. Two files F1, F2, and two mappings M1,
> M2 where M1 is a mapping of F1, M2 is a mapping of F2. Now P1 does DIO
> to F1 with M2 as a buffer, P2 does DIO to F2 with M1 as a buffer. They
> can race like:
> 
> P1                                      P2
> read()                                  read()
>   gfs2_file_read_iter()                   gfs2_file_read_iter()
>     gfs2_file_direct_read()                 gfs2_file_direct_read()
>       locks glock of F1                       locks glock of F2
>       iomap_dio_rw()                          iomap_dio_rw()
>         bio_iov_iter_get_pages()                bio_iov_iter_get_pages()
>           <fault in M2>                           <fault in M1>
>             gfs2_fault()                            gfs2_fault()
>               tries to grab glock of F2               tries to grab glock of F1
> 
> Those kinds of scenarios are much harder to reproduce than
> self-recursion.
> 
> We deal with such situations by using the LM_FLAG_OUTER flag to mark
> "outer" glock taking.  Then, when taking an "inner" glock, we use the
> LM_FLAG_TRY flag so that locking attempts that don't immediately succeed
> will be aborted.  In case of a failed locking attempt, we "unroll" to
> where the "outer" glock was taken, drop the "outer" glock, and fault in
> the first offending user page.  This will re-trigger the "inner" locking
> attempt but without the LM_FLAG_TRY flag.  Once that has happened, we
> re-acquire the "outer" glock and retry the original operation.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

...

> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 7d88abb4629b..8b26893f8dc6 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -431,21 +431,30 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
>  	vm_fault_t ret = VM_FAULT_LOCKED;
>  	struct gfs2_holder gh;
>  	unsigned int length;
> +	u16 flags = 0;
>  	loff_t size;
>  	int err;
>  
>  	sb_start_pagefault(inode->i_sb);
>  
> -	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
> +	if (current_holds_glock())
> +		flags |= LM_FLAG_TRY;
> +
> +	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, flags, &gh);
>  	if (likely(!outer_gh)) {
>  		err = gfs2_glock_nq(&gh);
>  		if (err) {
>  			ret = block_page_mkwrite_return(err);
> +			if (err == GLR_TRYFAILED) {
> +				set_current_needs_retry(true);
> +				ret = VM_FAULT_SIGBUS;
> +			}

I've checked to make sure but do_user_addr_fault() indeed calls do_sigbus()
which raises the SIGBUS signal. So if the application does not ignore
SIGBUS, your retry will be visible to the application and can cause all
sorts of interesting results... So you probably need to add a new VM_FAULT_
return code that will behave like VM_FAULT_SIGBUS except it will not raise
the signal.

Otherwise it seems to me your approach should work.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
