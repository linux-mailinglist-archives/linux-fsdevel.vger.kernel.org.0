Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9735A44DC48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 20:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhKKTs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 14:48:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhKKTsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 14:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636659934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GkZj9SZJeeiaIFWlpKJ5Jx8G0MJxiQRMpXTr3SR8wVk=;
        b=TV2yIQR7rGkBVUSyAdRY7RXiRw1AKL3Wci0Dyno43EZkxIMAaSWb/MJvDAui1hMUdIfx12
        Yq24iNUOR7TUTF1OMiHBY+bxwehwRm0gJq/EhPN27rA/c7n5MX0OMR3DUZNUAEZ4RLbjh1
        oNDIGLboRb74wck0yNEOtKcbJR8M/1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-2F_aehypP1yTMh_AzMgOnA-1; Thu, 11 Nov 2021 14:45:31 -0500
X-MC-Unique: 2F_aehypP1yTMh_AzMgOnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A169804141;
        Thu, 11 Nov 2021 19:45:30 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3444660936;
        Thu, 11 Nov 2021 19:45:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6EA67220EED; Thu, 11 Nov 2021 14:45:17 -0500 (EST)
Date:   Thu, 11 Nov 2021 14:45:17 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v7 5/7] fuse: negotiate per inode DAX in FUSE_INIT
Message-ID: <YY1yzRcX6u60zYAl@redhat.com>
References: <20211102052604.59462-1-jefflexu@linux.alibaba.com>
 <20211102052604.59462-6-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102052604.59462-6-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 01:26:02PM +0800, Jeffle Xu wrote:
> Among the FUSE_INIT phase, client shall advertise per inode DAX if it's
> mounted with "dax=inode". Then server is aware that client is in per
> inode DAX mode, and will construct per-inode DAX attribute accordingly.
> 
> Server shall also advertise support for per inode DAX. If server doesn't
> support it while client is mounted with "dax=inode", client will
> silently fallback to "dax=never" since "dax=inode" is advisory only.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c    |  2 +-
>  fs/fuse/fuse_i.h |  3 +++
>  fs/fuse/inode.c  | 16 +++++++++++++---
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 8a328fb20dcb..c8ee601b94b8 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1350,7 +1350,7 @@ static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
>  		return true;
>  
>  	/* dax_mode is FUSE_DAX_INODE or FUSE_DAX_NONE */
> -	return flags & FUSE_ATTR_DAX;
> +	return fc->inode_dax && (flags & FUSE_ATTR_DAX);
>  }
>  
>  void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 055b39430540..58e54b5a4d65 100644
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
> index acba14002d04..0512d8cb36c3 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1136,11 +1136,19 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  					min_t(unsigned int, fc->max_pages_limit,
>  					max_t(unsigned int, arg->max_pages, 1));
>  			}
> -			if (IS_ENABLED(CONFIG_FUSE_DAX) &&
> -			    arg->flags & FUSE_MAP_ALIGNMENT &&
> +#ifdef CONFIG_FUSE_DAX
> +			if ((arg->flags & FUSE_HAS_INODE_DAX) &&
> +			    fuse_is_inode_dax_mode(fc->dax_mode)) {

Why do we call fuse_is_inode_dax_mode() here? While sending INIT request
we set FUSE_HAS_INODE_DAX only if fuse_is_inode_dax_mode() is true. So
we should not have to call it again when server replies.?

> +				fc->inode_dax = 1;
> +			}
> +			if (arg->flags & FUSE_MAP_ALIGNMENT &&
>  			    !fuse_dax_check_alignment(fc, arg->map_alignment)) {
> -				ok = false;
> +				if (fuse_is_inode_dax_mode(fc->dax_mode))
> +					fc->inode_dax = 0;

If mapping alignment is not right, I guess we can fail (even in case
of dax=inode). In this case client wants per dax inode, server supports
it but alignment is wrong. I think that should be an error and user should
fix it. IMHO, just leave this code path in place and we will error out.

Thanks
Vivek

> +				else
> +					ok = false;
>  			}
> +#endif
>  			if (arg->flags & FUSE_HANDLE_KILLPRIV_V2) {
>  				fc->handle_killpriv_v2 = 1;
>  				fm->sb->s_flags |= SB_NOSEC;
> @@ -1194,6 +1202,8 @@ void fuse_send_init(struct fuse_mount *fm)
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

