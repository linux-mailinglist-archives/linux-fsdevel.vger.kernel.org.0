Return-Path: <linux-fsdevel+bounces-7139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B7A82227B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 21:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1118A1F23480
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 20:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20B916412;
	Tue,  2 Jan 2024 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmGmFNyi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B416409
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704226897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mf+A2l9BZ4h/BUGC6R/qVkbg+mOP6JOePma0+l5vK88=;
	b=bmGmFNyi+44ScvG/hMRXmauKcCCIgEBh1RiL42GnE+OacBpJgHqz3k6CcK33KpJMZyBSzl
	kFLG+P0mwVJHHORl6SuQWDkzlSheTG9wzehrWWHJ0oWZm4S1w62umO7PeYNCsP1Fg7W2Za
	GPXepQRA0KfIeb47M1Whv6iQCZx5GN8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-UkVYTtcVN_K3sGanpLGXSw-1; Tue,
 02 Jan 2024 15:21:35 -0500
X-MC-Unique: UkVYTtcVN_K3sGanpLGXSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A9413C0E644;
	Tue,  2 Jan 2024 20:21:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.212])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 982691C060AF;
	Tue,  2 Jan 2024 20:21:34 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id A6B1428C5E5; Tue,  2 Jan 2024 15:21:33 -0500 (EST)
Date: Tue, 2 Jan 2024 15:21:33 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/2] virtiofs: Improve error handling in
 virtio_fs_get_tree()
Message-ID: <ZZRwTctKN8h5VCqh@redhat.com>
References: <c5c14b02-660a-46e1-9eb3-1a16d7c84922@web.de>
 <5745d81c-3c06-4871-9785-12a469870934@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5745d81c-3c06-4871-9785-12a469870934@web.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Fri, Dec 29, 2023 at 09:38:47AM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 29 Dec 2023 09:15:07 +0100
> 
> The kfree() function was called in two cases by
> the virtio_fs_get_tree() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> * Thus use another label.
> 
> * Move an error code assignment into an if branch.
> 
> * Delete an initialisation (for the variable “fc”)
>   which became unnecessary with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

As Matthew said that kfree(NULL) is perfectly acceptable usage in kernel,
so I really don't feel that this patch is required. Current code looks
good as it is.

Thanks
Vivek

> ---
>  fs/fuse/virtio_fs.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 2f8ba9254c1e..0746f54ec743 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1415,10 +1415,10 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  {
>  	struct virtio_fs *fs;
>  	struct super_block *sb;
> -	struct fuse_conn *fc = NULL;
> +	struct fuse_conn *fc;
>  	struct fuse_mount *fm;
>  	unsigned int virtqueue_size;
> -	int err = -EIO;
> +	int err;
> 
>  	/* This gets a reference on virtio_fs object. This ptr gets installed
>  	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
> @@ -1431,13 +1431,15 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  	}
> 
>  	virtqueue_size = virtqueue_get_vring_size(fs->vqs[VQ_REQUEST].vq);
> -	if (WARN_ON(virtqueue_size <= FUSE_HEADER_OVERHEAD))
> -		goto out_err;
> +	if (WARN_ON(virtqueue_size <= FUSE_HEADER_OVERHEAD)) {
> +		err = -EIO;
> +		goto lock_mutex;
> +	}
> 
>  	err = -ENOMEM;
>  	fc = kzalloc(sizeof(*fc), GFP_KERNEL);
>  	if (!fc)
> -		goto out_err;
> +		goto lock_mutex;
> 
>  	fm = kzalloc(sizeof(*fm), GFP_KERNEL);
>  	if (!fm)
> @@ -1476,6 +1478,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
> 
>  out_err:
>  	kfree(fc);
> +lock_mutex:
>  	mutex_lock(&virtio_fs_mutex);
>  	virtio_fs_put(fs);
>  	mutex_unlock(&virtio_fs_mutex);
> --
> 2.43.0
> 


