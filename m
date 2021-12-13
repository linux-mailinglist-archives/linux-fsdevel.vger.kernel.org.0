Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61934733A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 19:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbhLMSJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 13:09:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235859AbhLMSJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639418981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ca50bBUUkhfUlOjht4Y3DUIQT2je/qUoAUxMVRrSQFc=;
        b=WtSljEcoWsan9MvBY7HfuhknekNFKm0EWWDeS0mP+fkHDT3G/4e3intzW9KOqmHLN8MbCb
        vjnLVU/UeHYaXLtt6NmBiT3Kf+1dkyO5qrFVdFkb4laQsZgW4LCVez6Fq+G0n1AwyE8smh
        0v1wZ2WU1N84CW/3ouDG9bolzR8F5o0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-Gt-gAbPXMniFtSB45cAA2g-1; Mon, 13 Dec 2021 13:09:36 -0500
X-MC-Unique: Gt-gAbPXMniFtSB45cAA2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E75AE92500;
        Mon, 13 Dec 2021 18:09:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B48345BE03;
        Mon, 13 Dec 2021 18:09:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BF48D22341B; Mon, 13 Dec 2021 13:09:33 -0500 (EST)
Date:   Mon, 13 Dec 2021 13:09:33 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v8 3/7] fuse: support per inode DAX in fuse protocol
Message-ID: <YbeMXQaUPj0kHxyi@redhat.com>
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
 <20211125070530.79602-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125070530.79602-4-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 03:05:26PM +0800, Jeffle Xu wrote:
> Expand the fuse protocol to support per inode DAX.
> 
> FUSE_HAS_INODE_DAX flag is added indicating if fuse server/client
> supporting per inode DAX. It can be conveyed in both FUSE_INIT request
> and reply.
> 
> FUSE_ATTR_DAX flag is added indicating if DAX shall be enabled for
> corresponding file. It is conveyed in FUSE_LOOKUP reply.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek
> ---
>  include/uapi/linux/fuse.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index a1dc3ee1d17c..63a9a963f4d9 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -187,6 +187,7 @@
>   *
>   *  7.35
>   *  - add FOPEN_NOFLUSH
> + *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -341,6 +342,7 @@ struct fuse_file_lock {
>   *			write/truncate sgid is killed only if file has group
>   *			execute permission. (Same as Linux VFS behavior).
>   * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
> + * FUSE_HAS_INODE_DAX:  use per inode DAX
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -372,6 +374,7 @@ struct fuse_file_lock {
>  #define FUSE_SUBMOUNTS		(1 << 27)
>  #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
>  #define FUSE_SETXATTR_EXT	(1 << 29)
> +#define FUSE_HAS_INODE_DAX	(1 << 30)
>  
>  /**
>   * CUSE INIT request/reply flags
> @@ -454,8 +457,10 @@ struct fuse_file_lock {
>   * fuse_attr flags
>   *
>   * FUSE_ATTR_SUBMOUNT: Object is a submount root
> + * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
>   */
>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
> +#define FUSE_ATTR_DAX		(1 << 1)
>  
>  /**
>   * Open flags
> -- 
> 2.27.0
> 

