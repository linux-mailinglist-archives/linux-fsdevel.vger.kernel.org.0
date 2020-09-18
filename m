Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE2E26F597
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 07:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgIRF7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 01:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIRF7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:59:38 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91853C06174A;
        Thu, 17 Sep 2020 22:59:38 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 5EAEFC01B; Fri, 18 Sep 2020 07:59:34 +0200 (CEST)
Date:   Fri, 18 Sep 2020 07:59:19 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mtd@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [V9fs-developer] [PATCH 02/13] 9p: Tell the VFS that readpage
 was synchronous
Message-ID: <20200918055919.GA30929@nautica>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917151050.5363-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917151050.5363-3-willy@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) wrote on Thu, Sep 17, 2020:
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index cce9ace651a2..506ca0ba2ec7 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -280,6 +280,10 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
>  		goto out;
>  
>  	retval = v9fs_fid_readpage(v9inode->writeback_fid, page);
> +	if (retval == AOP_UPDATED_PAGE) {
> +		retval = 0;
> +		goto out;
> +	}

FWIW this is a change of behaviour; for some reason the code used to
loop back to grab_cache_page_write_begin() and bail out on
PageUptodate() I suppose; some sort of race check?
The whole pattern is a bit weird to me and 9p has no guarantee on
concurrent writes to a file with cache enabled (except that it will
corrupt something), so this part is fine with me.

What I'm curious about is the page used to be both unlocked and put, but
now isn't either and the return value hasn't changed for the caller to
make a difference on write_begin / I don't see any code change in the
vfs  to handle that.
What did I miss?


(FWIW at least cifs in the series has the same pattern change; didn't
check all of them)


Thanks,
-- 
Dominique
