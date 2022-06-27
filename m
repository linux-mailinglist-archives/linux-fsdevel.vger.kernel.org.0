Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1770055C6E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbiF0PGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiF0PGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87D5617592
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656342398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fBes51M+2wr38BVd4ZzSnLeIo2T+7HxUzwOt8bM5avs=;
        b=CLkczHFgRwfElVINKckhd9QDh4/NHwtap5As9Lg+F8Gywp80yIlcX2Ak3aqpYCGenTHDZi
        K3ZbwUpuDqsJTZAhRfsd5u2bTjOYLifXfcHmqYkMIyZQjF6QbvUA8rjx8GpHU+1YYorUcB
        r5GPcx5MxPwozoDroc9HfGsmaDlZd4I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-PsvuwOuVO_i-ReYZdtquMQ-1; Mon, 27 Jun 2022 11:06:35 -0400
X-MC-Unique: PsvuwOuVO_i-ReYZdtquMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C9FE29DD997;
        Mon, 27 Jun 2022 15:06:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82BCE2166B26;
        Mon, 27 Jun 2022 15:06:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 27351220463; Mon, 27 Jun 2022 11:06:34 -0400 (EDT)
Date:   Mon, 27 Jun 2022 11:06:34 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: add FOPEN_INVAL_ATTR
Message-ID: <YrnHeqckLknFleud@redhat.com>
References: <20220608104202.19461-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608104202.19461-1-zhangjiachen.jaycee@bytedance.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 06:42:02PM +0800, Jiachen Zhang wrote:
> So that the fuse daemon can ask kernel to invalidate the attr cache on file
> open.

Will be great if there was a proper context around this. Without any
explanation, how one is supposed to understand how this is useful.

By going through other email threads, looks like, with writeback
cache enabled, you want to invalidate attr cache and data cache
when file is opened next time. Right?

IOW, when file is closed, its changes will be flushed out. And when
file is reopened, server somehow is supposed to determine if file
has changed (on server by another client) and based on that determine
whether to invalidate attr and data cache on next open?

Even without that, on next open, it probably makes sense to being
invalidate attr cache. We have notion to invalidate data cache. So
it will be kind of odd that we can invalidate data but not attrs
on next open. Am I understanding it right?

Thanks
Vivek

> 
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  fs/fuse/file.c            | 4 ++++
>  include/uapi/linux/fuse.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index fdcec3aa7830..9609d13ec351 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -213,6 +213,10 @@ void fuse_finish_open(struct inode *inode, struct file *file)
>  		file_update_time(file);
>  		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
>  	}
> +
> +	if (ff->open_flags & FOPEN_INVAL_ATTR)
> +		fuse_invalidate_attr(inode);
> +
>  	if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
>  		fuse_link_write_file(file);
>  }
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d6ccee961891..0b0b7d308ddb 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -301,6 +301,7 @@ struct fuse_file_lock {
>   * FOPEN_CACHE_DIR: allow caching this directory
>   * FOPEN_STREAM: the file is stream-like (no file position at all)
>   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
> + * FOPEN_INVAL_ATTR: invalidate the attr cache on open
>   */
>  #define FOPEN_DIRECT_IO		(1 << 0)
>  #define FOPEN_KEEP_CACHE	(1 << 1)
> @@ -308,6 +309,7 @@ struct fuse_file_lock {
>  #define FOPEN_CACHE_DIR		(1 << 3)
>  #define FOPEN_STREAM		(1 << 4)
>  #define FOPEN_NOFLUSH		(1 << 5)
> +#define FOPEN_INVAL_ATTR	(1 << 6)
>  
>  /**
>   * INIT request/reply flags
> -- 
> 2.20.1
> 

