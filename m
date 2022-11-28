Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6202263B2CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 21:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiK1UKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 15:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiK1UKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:10:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13824FAD5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 12:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669666193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WD+oeQLh4B1x5wzvULEGlFAwsWW0xKv+aoBTkSWPAzU=;
        b=YGlOqLH/QtaT9/geu2IMxOkFsl0uDrTWLEUq9BHucwsc3WcNjyfxhVo3g1bwqmPpY013rf
        H1wqY/gMS7jUwNNaEPrhB+IcK8wzsEbgCBjVkMLqtIit+h+iyVU/2UPDQzbTv/pWrXL6Ek
        yo3/JV50sE54pCN3se2KAmZ38cnD9wE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-IBnM0iesPDqHdYebJJ80Vg-1; Mon, 28 Nov 2022 15:09:47 -0500
X-MC-Unique: IBnM0iesPDqHdYebJJ80Vg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C680C811E81;
        Mon, 28 Nov 2022 20:09:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.9.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFF0A4A9254;
        Mon, 28 Nov 2022 20:09:46 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
        id DB53CB680E; Mon, 28 Nov 2022 15:09:43 -0500 (EST)
Date:   Mon, 28 Nov 2022 15:09:43 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>,
        syzbot+462da39f0667b357c4b6@syzkaller.appspotmail.com
Subject: Re: [PATCH] fuse: lock inode unconditionally in fuse_fallocate()
Message-ID: <Y4UVhzMHYbigU72b@redhat.com>
References: <20221123104336.1030702-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123104336.1030702-1-mszeredi@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:43:36AM +0100, Miklos Szeredi wrote:
> file_modified() must be called with inode lock held.  fuse_fallocate()
> didn't lock the inode in case of just FALLOC_KEEP_SIZE flags value, which
> resulted in a kernel Warning in notify_change().
> 
> Lock the inode unconditionally, like all other fallocate implementations
> do.
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Reported-and-tested-by: syzbot+462da39f0667b357c4b6@syzkaller.appspotmail.com
> Fixes: 4a6f278d4827 ("fuse: add file_modified() to fallocate")
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/file.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 71bfb663aac5..89f4741728ba 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2963,11 +2963,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
>  		.mode = mode
>  	};
>  	int err;
> -	bool lock_inode = !(mode & FALLOC_FL_KEEP_SIZE) ||
> -			   (mode & (FALLOC_FL_PUNCH_HOLE |
> -				    FALLOC_FL_ZERO_RANGE));
> -
> -	bool block_faults = FUSE_IS_DAX(inode) && lock_inode;
> +	bool block_faults = FUSE_IS_DAX(inode) &&
> +		(!(mode & FALLOC_FL_KEEP_SIZE) ||
> +		 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));

Hi Miklos,

I think that we probably don't need above tests for "block_faults".
Initially, ideas was that I wanted to synchronize truncate/punch_hole
with fault handler path. Fuse did not seem to do it, so I decided to
add it only for fuse DAX code to begin with. Details are in following
commit.

commit 6ae330cad6ef22ab8347ea9e0707dc56a7c7363f
Author: Vivek Goyal <vgoyal@redhat.com>
Date:   Wed Aug 19 18:19:54 2020 -0400

    virtiofs: serialize truncate/punch_hole and dax fault path

I wanted to take following two locks for it to work.
   inode_lock(inode)
     down_write(&fi->i_mmap_sem);

And that's why following condition.

bool block_faults = FUSE_IS_DAX(inode) && lock_inode;

Given that we will now always take inode lock, we could just do.

bool block_faults = FUSE_IS_DAX(inode); instead. Not sure is there really
a benefit in going through different "mode" flags and make this condition
even narrower.

I see that now fi->i_mmap_sem has been replaced by
filemap_invalidate_lock(inode->i_mapping).

At some point of time we should review fuse fault code and see if that
code need to serialize with truncate/punch_hole path as well. If answer
is yes, then we could get rid of this "block_faults" altogether and
always take inode->i_mapping lock in truncate path.

IOW, I think we should be able to simplify above to just for now.

bool block_faults = FUSE_IS_DAX(inode);
 
Thanks
Vivek

>  
>  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
>  		     FALLOC_FL_ZERO_RANGE))
> @@ -2976,22 +2974,20 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
>  	if (fm->fc->no_fallocate)
>  		return -EOPNOTSUPP;
>  
> -	if (lock_inode) {
> -		inode_lock(inode);
> -		if (block_faults) {
> -			filemap_invalidate_lock(inode->i_mapping);
> -			err = fuse_dax_break_layouts(inode, 0, 0);
> -			if (err)
> -				goto out;
> -		}
> +	inode_lock(inode);
> +	if (block_faults) {
> +		filemap_invalidate_lock(inode->i_mapping);
> +		err = fuse_dax_break_layouts(inode, 0, 0);
> +		if (err)
> +			goto out;
> +	}
>  
> -		if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) {
> -			loff_t endbyte = offset + length - 1;
> +	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) {
> +		loff_t endbyte = offset + length - 1;
>  
> -			err = fuse_writeback_range(inode, offset, endbyte);
> -			if (err)
> -				goto out;
> -		}
> +		err = fuse_writeback_range(inode, offset, endbyte);
> +		if (err)
> +			goto out;
>  	}
>  
>  	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
> @@ -3039,8 +3035,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
>  	if (block_faults)
>  		filemap_invalidate_unlock(inode->i_mapping);
>  
> -	if (lock_inode)
> -		inode_unlock(inode);
> +	inode_unlock(inode);
>  
>  	fuse_flush_time_update(inode);
>  
> -- 
> 2.38.1
> 

