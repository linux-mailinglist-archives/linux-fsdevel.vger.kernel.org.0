Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53723431F26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhJROQ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233608AbhJROQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634566449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3txbciglAV32xZf1xLsmwaoxOA2TV/QDyEV0YDl4rBo=;
        b=O76nlEEJg7t0J+9lY7xh0Py1c1/4ST3SfXERXuAB2MHv47NI0/cOJESF5AsC9hHLCG6ZTA
        46988W6Dwz01lpfx0MQP0KlFL2J53n7az5OhBDfH5H1V9ei0pEEJp9WyOK0ZePRcJNx2+9
        mbqPhBRns9DmtJNWAxLdpKigE7XoB5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-b_8ykzhfMd61heMem7aQ6A-1; Mon, 18 Oct 2021 10:14:06 -0400
X-MC-Unique: b_8ykzhfMd61heMem7aQ6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00E1010168D6;
        Mon, 18 Oct 2021 14:14:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D045060657;
        Mon, 18 Oct 2021 14:14:04 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 691AD224B9C; Mon, 18 Oct 2021 10:14:04 -0400 (EDT)
Date:   Mon, 18 Oct 2021 10:14:04 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hub,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 3/7] fuse: support per-file DAX in fuse protocol
Message-ID: <YW2BLCtThkdrEs3K@redhat.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011030052.98923-4-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 11:00:48AM +0800, Jeffle Xu wrote:
> Expand the fuse protocol to support per-file DAX.
> 
> FUSE_PERFILE_DAX flag is added indicating if fuse server/client

Should we call this flag FUSE_INODE_DAX instead? It is per inode property?

Vivek

> supporting per-file DAX. It can be conveyed in both FUSE_INIT request
> and reply.
> 
> FUSE_ATTR_DAX flag is added indicating if DAX shall be enabled for
> corresponding file. It is conveyed in FUSE_LOOKUP reply.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  include/uapi/linux/fuse.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 36ed092227fa..15a1f5fc0797 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -184,6 +184,9 @@
>   *
>   *  7.34
>   *  - add FUSE_SYNCFS
> + *
> + *  7.35
> + *  - add FUSE_PERFILE_DAX, FUSE_ATTR_DAX
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -219,7 +222,7 @@
>  #define FUSE_KERNEL_VERSION 7
>  
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 34
> +#define FUSE_KERNEL_MINOR_VERSION 35
>  
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -336,6 +339,7 @@ struct fuse_file_lock {
>   *			write/truncate sgid is killed only if file has group
>   *			execute permission. (Same as Linux VFS behavior).
>   * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
> + * FUSE_PERFILE_DAX:	kernel supports per-file DAX
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -367,6 +371,7 @@ struct fuse_file_lock {
>  #define FUSE_SUBMOUNTS		(1 << 27)
>  #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
>  #define FUSE_SETXATTR_EXT	(1 << 29)
> +#define FUSE_PERFILE_DAX	(1 << 30)
>  
>  /**
>   * CUSE INIT request/reply flags
> @@ -449,8 +454,10 @@ struct fuse_file_lock {
>   * fuse_attr flags
>   *
>   * FUSE_ATTR_SUBMOUNT: Object is a submount root
> + * FUSE_ATTR_DAX: Enable DAX for this file in per-file DAX mode
>   */
>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
> +#define FUSE_ATTR_DAX		(1 << 1)
>  
>  /**
>   * Open flags
> -- 
> 2.27.0
> 

