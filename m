Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3724733AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 19:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbhLMSLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 13:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236073AbhLMSLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639419066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7AAkHHgl2O1V7/wMjIG1/yB255nuxgGI8OwajxUKTI=;
        b=VFWg7aThF6RC0X2JovBwV4RkeC3w5j/6kDfo7VFMlJ/v8Ttd10kaznzviZR7w0LYOCzP7V
        oYSkz27LOe499B8iksgAoVVJy8UhN7IcLmSTJ7zO3f3oTpaldC91ZKYBBxRWVP/eNJ1Z7W
        3tz5JNLKG7w0/NqcX+CUdl101o80Tp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-q_QhufIwOjGMrwzM9uHBVA-1; Mon, 13 Dec 2021 13:11:03 -0500
X-MC-Unique: q_QhufIwOjGMrwzM9uHBVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 489049251D;
        Mon, 13 Dec 2021 18:11:02 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 377DF610A7;
        Mon, 13 Dec 2021 18:10:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C457D2233DF; Mon, 13 Dec 2021 13:10:24 -0500 (EST)
Date:   Mon, 13 Dec 2021 13:10:24 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v8 5/7] fuse: negotiate per inode DAX in FUSE_INIT
Message-ID: <YbeMkISPOnD10nOZ@redhat.com>
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
 <20211125070530.79602-6-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125070530.79602-6-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 03:05:28PM +0800, Jeffle Xu wrote:
> Among the FUSE_INIT phase, client shall advertise per inode DAX if it's
> mounted with "dax=inode". Then server is aware that client is in per
> inode DAX mode, and will construct per-inode DAX attribute accordingly.
> 
> Server shall also advertise support for per inode DAX. If server doesn't
> support it while client is mounted with "dax=inode", client will
> silently fallback to "dax=never" since "dax=inode" is advisory only.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek
> ---
>  fs/fuse/dax.c    |  2 +-
>  fs/fuse/fuse_i.h |  3 +++
>  fs/fuse/inode.c  | 13 +++++++++----
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 1550c3624414..234c2278420f 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1351,7 +1351,7 @@ static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
>  		return true;
>  
>  	/* dax_mode is FUSE_DAX_INODE* */
> -	return flags & FUSE_ATTR_DAX;
> +	return fc->inode_dax && (flags & FUSE_ATTR_DAX);
>  }
>  
>  void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f03ea7cb74b0..83970723314a 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -777,6 +777,9 @@ struct fuse_conn {
>  	/* Propagate syncfs() to server */
>  	unsigned int sync_fs:1;
>  
> +	/* Does the filesystem support per inode DAX? */
> +	unsigned int inode_dax:1;
> +
>  	/** The number of requests waiting for completion */
>  	atomic_t num_waiting;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 0669e41a9645..b26612fce6d0 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1169,10 +1169,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  					min_t(unsigned int, fc->max_pages_limit,
>  					max_t(unsigned int, arg->max_pages, 1));
>  			}
> -			if (IS_ENABLED(CONFIG_FUSE_DAX) &&
> -			    arg->flags & FUSE_MAP_ALIGNMENT &&
> -			    !fuse_dax_check_alignment(fc, arg->map_alignment)) {
> -				ok = false;
> +			if (IS_ENABLED(CONFIG_FUSE_DAX)) {
> +				if (arg->flags & FUSE_MAP_ALIGNMENT &&
> +				    !fuse_dax_check_alignment(fc, arg->map_alignment)) {
> +					ok = false;
> +				}
> +				if (arg->flags & FUSE_HAS_INODE_DAX)
> +					fc->inode_dax = 1;
>  			}
>  			if (arg->flags & FUSE_HANDLE_KILLPRIV_V2) {
>  				fc->handle_killpriv_v2 = 1;
> @@ -1227,6 +1230,8 @@ void fuse_send_init(struct fuse_mount *fm)
>  #ifdef CONFIG_FUSE_DAX
>  	if (fm->fc->dax)
>  		ia->in.flags |= FUSE_MAP_ALIGNMENT;
> +	if (fuse_is_inode_dax_mode(fm->fc->dax_mode))
> +		ia->in.flags |= FUSE_HAS_INODE_DAX;
>  #endif
>  	if (fm->fc->auto_submounts)
>  		ia->in.flags |= FUSE_SUBMOUNTS;
> -- 
> 2.27.0
> 

