Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E34116A108
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 10:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgBXJIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 04:08:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:41408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBXJIr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:08:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 36F58AC92;
        Mon, 24 Feb 2020 09:08:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AA41F1E0E33; Mon, 24 Feb 2020 10:08:46 +0100 (CET)
Date:   Mon, 24 Feb 2020 10:08:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: ext2, possible circular locking dependency detected
Message-ID: <20200224090846.GB27857@quack2.suse.cz>
References: <4946.1582339996@jrobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4946.1582339996@jrobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Sat 22-02-20 11:53:16, J. R. Okajima wrote:
> Hello ext2 maintainers,
> 
> During my local fs stress test, I've encounter this.
> Is it false positive?
> Otherwise, I've made a small patch to stop reclaming recursively into FS
> from ext2_xattr_set().  Please consider taking this.
> 
> Once I've considered about whether it should be done in VFS layer or
> not.  I mean, every i_op->brabra() calls in VFS should be surrounded by
> memalloc_nofs_{save,restore}(), by a macro or something.  But I am
> afraid it may introduce unnecesary overheads, especially when FS code
> doesn't allocate memory.  So it is better to do it in real FS
> operations.

Thanks for debugging this and for the patch. One comment below:

...

> @@ -532,7 +534,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  
>  			unlock_buffer(bh);
>  			ea_bdebug(bh, "cloning");
> +			nofs_flag = memalloc_nofs_save();
>  			header = kmemdup(HDR(bh), bh->b_size, GFP_KERNEL);
> +			memalloc_nofs_restore(nofs_flag);
>  			error = -ENOMEM;
>  			if (header == NULL)
>  				goto cleanup;
> @@ -545,7 +549,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  		}
>  	} else {
>  		/* Allocate a buffer where we construct the new block. */
> +		nofs_flag = memalloc_nofs_save();
>  		header = kzalloc(sb->s_blocksize, GFP_KERNEL);
> +		memalloc_nofs_restore(nofs_flag);
>  		error = -ENOMEM;
>  		if (header == NULL)
>  			goto cleanup;

This is not the right way how memalloc_nofs_save() should be used (you
could just use GFP_NOFS instead of GFP_KERNEL instead of wrapping the
allocation inside memalloc_nofs_save/restore()). The
memalloc_nofs_save/restore() API is created so that you can change the
allocation context at the place which mandates the new context - i.e., in
this case when acquiring / dropping xattr_sem. That way you don't have to
propagate the context information down to function calls and the code is
also future-proof - if you add new allocation, they will use correct
allocation context.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
