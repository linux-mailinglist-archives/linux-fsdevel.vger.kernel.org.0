Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E894733A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 19:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbhLMSKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 13:10:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236073AbhLMSKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639419023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bkTXlAxjpUMN9ROvU9HyidRRvaYLz97A1f1Rn9U9Zmo=;
        b=O4WhFbortgoQqdGxYcLpa65sgbtWAkxWE6UBY/X97d65XMq1siPfnOLtv9QjApX2iDJbSb
        vaL6KZ19eve0bJSRARbX3ff+8UFCo1dmdTW0O+dqK/izY04yizgVvjyFCUlGsXVjLO1wUC
        O78/1o0t56g49vRAg2IN02rklFSRzjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-PCW2oPcLMU23WahrYaNDoA-1; Mon, 13 Dec 2021 13:10:19 -0500
X-MC-Unique: PCW2oPcLMU23WahrYaNDoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9E8D192FDA1;
        Mon, 13 Dec 2021 18:10:18 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D9315E272;
        Mon, 13 Dec 2021 18:10:00 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 35C0A2233DF; Mon, 13 Dec 2021 13:10:00 -0500 (EST)
Date:   Mon, 13 Dec 2021 13:10:00 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v8 4/7] fuse: enable per inode DAX
Message-ID: <YbeMeGrZ/ipQKM2/@redhat.com>
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
 <20211125070530.79602-5-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125070530.79602-5-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 03:05:27PM +0800, Jeffle Xu wrote:
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
> Per inode DAX feature is introduced to address this issue, by offering a
> finer grained control for dax to users, trying to achieve a balance
> between performance and memory overhead.
> 
> The FUSE_ATTR_DAX flag in FUSE_LOOKUP reply is used to indicate whether
> DAX should be enabled or not for corresponding file. Currently the state
> whether DAX is enabled or not for the file is initialized only when
> inode is instantiated.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviwed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  fs/fuse/dax.c    | 12 ++++++++----
>  fs/fuse/file.c   |  4 ++--
>  fs/fuse/fuse_i.h |  4 ++--
>  fs/fuse/inode.c  |  2 +-
>  4 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index b9a031a82934..1550c3624414 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1332,7 +1332,7 @@ static const struct address_space_operations fuse_dax_file_aops  = {
>  	.invalidatepage	= noop_invalidatepage,
>  };
>  
> -static bool fuse_should_enable_dax(struct inode *inode)
> +static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
>  {
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  	enum fuse_dax_mode dax_mode = fc->dax_mode;
> @@ -1347,12 +1347,16 @@ static bool fuse_should_enable_dax(struct inode *inode)
>  	if (!fc->dax)
>  		return false;
>  
> -	return true;
> +	if (dax_mode == FUSE_DAX_ALWAYS)
> +		return true;
> +
> +	/* dax_mode is FUSE_DAX_INODE* */
> +	return flags & FUSE_ATTR_DAX;
>  }
>  
> -void fuse_dax_inode_init(struct inode *inode)
> +void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
>  {
> -	if (!fuse_should_enable_dax(inode))
> +	if (!fuse_should_enable_dax(inode, flags))
>  		return;
>  
>  	inode->i_flags |= S_DAX;
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 9d6c5f6361f7..90067584e103 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3169,7 +3169,7 @@ static const struct address_space_operations fuse_file_aops  = {
>  	.write_end	= fuse_write_end,
>  };
>  
> -void fuse_init_file_inode(struct inode *inode)
> +void fuse_init_file_inode(struct inode *inode, unsigned int flags)
>  {
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  
> @@ -3183,5 +3183,5 @@ void fuse_init_file_inode(struct inode *inode)
>  	fi->writepages = RB_ROOT;
>  
>  	if (IS_ENABLED(CONFIG_FUSE_DAX))
> -		fuse_dax_inode_init(inode);
> +		fuse_dax_inode_init(inode, flags);
>  }
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 19ded93cfc49..f03ea7cb74b0 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1022,7 +1022,7 @@ int fuse_notify_poll_wakeup(struct fuse_conn *fc,
>  /**
>   * Initialize file operations on a regular file
>   */
> -void fuse_init_file_inode(struct inode *inode);
> +void fuse_init_file_inode(struct inode *inode, unsigned int flags);
>  
>  /**
>   * Initialize inode operations on regular files and special files
> @@ -1288,7 +1288,7 @@ int fuse_dax_conn_alloc(struct fuse_conn *fc, enum fuse_dax_mode mode,
>  			struct dax_device *dax_dev);
>  void fuse_dax_conn_free(struct fuse_conn *fc);
>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
> -void fuse_dax_inode_init(struct inode *inode);
> +void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
>  void fuse_dax_inode_cleanup(struct inode *inode);
>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
>  void fuse_dax_cancel_work(struct fuse_conn *fc);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 4a41e6a73f3f..0669e41a9645 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -313,7 +313,7 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
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

