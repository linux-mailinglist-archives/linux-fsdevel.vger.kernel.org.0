Return-Path: <linux-fsdevel+bounces-1764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E427DE63A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 20:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79DEB20EE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91118E38;
	Wed,  1 Nov 2023 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iezNc87x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CE1944E
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 19:01:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DA4103
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698865255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VV/0JSb4ahQ+qDeA+yAiFldg8WZK/uiwiHB5Saqdh+M=;
	b=iezNc87xgUQjNxVYu7PtLZUfYvi68gtZE16mQs50VA415mrtk1s2NdBCmOXfF9iZHqAPZa
	QRQp3xyHAAzAJlWjWZWuhWyQk57pnZHYwl++ID2Q2Lie5TEQkJnhQ/3St4lf53r789IU0A
	3enPZvbuoEZXJhuW5BvdYR9snLI7LcA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Y8YF_Nq8N7W0wYIgKZ9icA-1; Wed, 01 Nov 2023 15:00:48 -0400
X-MC-Unique: Y8YF_Nq8N7W0wYIgKZ9icA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0CB98314FA;
	Wed,  1 Nov 2023 19:00:47 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.88])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17CA410F52;
	Wed,  1 Nov 2023 19:00:47 +0000 (UTC)
Date: Wed, 1 Nov 2023 15:01:22 -0400
From: Brian Foster <bfoster@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 1/7] bcachefs: Convert to bdev_open_by_path()
Message-ID: <ZUKggpzckTAKkyMl@bfoster>
References: <20231101173542.23597-1-jack@suse.cz>
 <20231101174325.10596-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101174325.10596-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Wed, Nov 01, 2023 at 06:43:06PM +0100, Jan Kara wrote:
> Convert bcachefs to use bdev_open_by_path() and pass the handle around.
> 
> CC: Kent Overstreet <kent.overstreet@linux.dev>
> CC: Brian Foster <bfoster@redhat.com>
> CC: linux-bcachefs@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/bcachefs/super-io.c    | 19 ++++++++++---------
>  fs/bcachefs/super_types.h |  1 +
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
> index 332d41e1c0a3..01a32c41a540 100644
> --- a/fs/bcachefs/super-io.c
> +++ b/fs/bcachefs/super-io.c
...
> @@ -685,21 +685,22 @@ int bch2_read_super(const char *path, struct bch_opts *opts,
>  	if (!opt_get(*opts, nochanges))
>  		sb->mode |= BLK_OPEN_WRITE;
>  
> -	sb->bdev = blkdev_get_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> -	if (IS_ERR(sb->bdev) &&
> -	    PTR_ERR(sb->bdev) == -EACCES &&
> +	sb->bdev_handle = bdev_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> +	if (IS_ERR(sb->bdev_handle) &&
> +	    PTR_ERR(sb->bdev_handle) == -EACCES &&
>  	    opt_get(*opts, read_only)) {
>  		sb->mode &= ~BLK_OPEN_WRITE;
>  
> -		sb->bdev = blkdev_get_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> -		if (!IS_ERR(sb->bdev))
> +		sb->bdev_handle = bdev_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> +		if (!IS_ERR(sb->bdev_handle))
>  			opt_set(*opts, nochanges, true);
>  	}
>  
> -	if (IS_ERR(sb->bdev)) {
> -		ret = PTR_ERR(sb->bdev);
> +	if (IS_ERR(sb->bdev_handle)) {
> +		ret = PTR_ERR(sb->bdev_handle);
>  		goto out;
>  	}
> +	sb->bdev = sb->bdev_handle->bdev;
>  
>  	ret = bch2_sb_realloc(sb, 0);
>  	if (ret) {

Hi Jan,

This all seems reasonable to me, but should bcachefs use sb_open_mode()
somewhere in here to involve use of the restrict writes flag in the
first place? It looks like bcachefs sort of open codes bits of
mount_bdev() so it isn't clear the flag would be used anywhere...

Brian

> diff --git a/fs/bcachefs/super_types.h b/fs/bcachefs/super_types.h
> index 78d6138db62d..b77d8897c9fa 100644
> --- a/fs/bcachefs/super_types.h
> +++ b/fs/bcachefs/super_types.h
> @@ -4,6 +4,7 @@
>  
>  struct bch_sb_handle {
>  	struct bch_sb		*sb;
> +	struct bdev_handle	*bdev_handle;
>  	struct block_device	*bdev;
>  	struct bio		*bio;
>  	void			*holder;
> -- 
> 2.35.3
> 


