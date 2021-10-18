Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D91243225A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhJRPNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233594AbhJRPNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5bcXVhCSgmfoL1hBJhvkBctTXiNXtHjcm3bxLuf2Zkw=;
        b=IoJeF1sPTxk4D00pcIpUm/AqYINooCLu1RkGPdfSyQ4RLEIQYEGxSWuO6jc5Xx+OkzGhUb
        VQwrLZKyeaXlf2iFkMSy4XGRwUq2aF2VlV5D9pmPqLrQSyB387GPqADOCyPU3yY99O70WF
        9VP0ZRM41p7erVT8sIV9tEzQRVuswAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-0wGNrIwTPwW2v9khfA_aRg-1; Mon, 18 Oct 2021 11:11:35 -0400
X-MC-Unique: 0wGNrIwTPwW2v9khfA_aRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81222809CDB;
        Mon, 18 Oct 2021 15:11:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B22ED60C82;
        Mon, 18 Oct 2021 15:11:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 47E8E2256EE; Mon, 18 Oct 2021 11:11:11 -0400 (EDT)
Date:   Mon, 18 Oct 2021 11:11:11 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hub,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 5/7] fuse: enable per-file DAX
Message-ID: <YW2Oj4FrIB8do3zX@redhat.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-6-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011030052.98923-6-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 11:00:50AM +0800, Jeffle Xu wrote:
> DAX may be limited in some specific situation. When the number of usable
> DAX windows is under watermark, the recalim routine will be triggered to
> reclaim some DAX windows. It may have a negative impact on the
> performance, since some processes may need to wait for DAX windows to be
> recalimed and reused then. To mitigate the performance degradation, the
> overall DAX window need to be expanded larger.
> 
> However, simply expanding the DAX window may not be a good deal in some
> scenario. To maintain one DAX window chunk (i.e., 2MB in size), 32KB
> (512 * 64 bytes) memory footprint will be consumed for page descriptors
> inside guest, which is greater than the memory footprint if it uses
> guest page cache when DAX disabled. Thus it'd better disable DAX for
> those files smaller than 32KB, to reduce the demand for DAX window and
> thus avoid the unworthy memory overhead.
> 
> Per-file DAX feature is introduced to address this issue, by offering a
> finer grained control for dax to users, trying to achieve a balance
> between performance and memory overhead.
> 
> The FUSE_ATTR_DAX flag in FUSE_LOOKUP reply is used to indicate whether
> DAX should be enabled or not for corresponding file. Currently the state
> whether DAX is enabled or not for the file is initialized only when
> inode is instantiated.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c    | 8 ++++----
>  fs/fuse/file.c   | 4 ++--
>  fs/fuse/fuse_i.h | 4 ++--
>  fs/fuse/inode.c  | 2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 4c6c64efc950..15bde36829b8 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1335,7 +1335,7 @@ static const struct address_space_operations fuse_dax_file_aops  = {
>  	.invalidatepage	= noop_invalidatepage,
>  };
>  
> -static bool fuse_should_enable_dax(struct inode *inode)
> +static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
>  {
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  	unsigned int dax_mode = fc->dax_mode;
> @@ -1352,12 +1352,12 @@ static bool fuse_should_enable_dax(struct inode *inode)
>  		return true;
>  
>  	/* dax_mode == FUSE_DAX_INODE */
> -	return true;
> +	return flags & FUSE_ATTR_DAX;
>  }
>  
> -void fuse_dax_inode_init(struct inode *inode)
> +void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
							      ^^^^
These are attr->flags. May be call this variable attr_flags so that
it is more clear.

Vivek

>  {
> -	if (!fuse_should_enable_dax(inode))
> +	if (!fuse_should_enable_dax(inode, flags))
>  		return;
>  
>  	inode->i_flags |= S_DAX;
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 11404f8c21c7..40c667a48cf6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3163,7 +3163,7 @@ static const struct address_space_operations fuse_file_aops  = {
>  	.write_end	= fuse_write_end,
>  };
>  
> -void fuse_init_file_inode(struct inode *inode)
> +void fuse_init_file_inode(struct inode *inode, unsigned int flags)
>  {
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  
> @@ -3177,5 +3177,5 @@ void fuse_init_file_inode(struct inode *inode)
>  	fi->writepages = RB_ROOT;
>  
>  	if (IS_ENABLED(CONFIG_FUSE_DAX))
> -		fuse_dax_inode_init(inode);
> +		fuse_dax_inode_init(inode, flags);
>  }
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 5abf9749923f..0270a41c31d7 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1016,7 +1016,7 @@ int fuse_notify_poll_wakeup(struct fuse_conn *fc,
>  /**
>   * Initialize file operations on a regular file
>   */
> -void fuse_init_file_inode(struct inode *inode);
> +void fuse_init_file_inode(struct inode *inode, unsigned int flags);
>  
>  /**
>   * Initialize inode operations on regular files and special files
> @@ -1268,7 +1268,7 @@ int fuse_dax_conn_alloc(struct fuse_conn *fc, enum fuse_dax_mode mode,
>  			struct dax_device *dax_dev);
>  void fuse_dax_conn_free(struct fuse_conn *fc);
>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
> -void fuse_dax_inode_init(struct inode *inode);
> +void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
>  void fuse_dax_inode_cleanup(struct inode *inode);
>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
>  void fuse_dax_cancel_work(struct fuse_conn *fc);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index f4ad99e2415b..73f19cd6e702 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -280,7 +280,7 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
>  	inode->i_ctime.tv_nsec = attr->ctimensec;
>  	if (S_ISREG(inode->i_mode)) {
>  		fuse_init_common(inode);
> -		fuse_init_file_inode(inode);
> +		fuse_init_file_inode(inode, attr->flags);
>  	} else if (S_ISDIR(inode->i_mode))
>  		fuse_init_dir(inode);
>  	else if (S_ISLNK(inode->i_mode))
> -- 
> 2.27.0
> 

