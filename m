Return-Path: <linux-fsdevel+bounces-7143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0158222B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 21:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5162847CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 20:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721541642A;
	Tue,  2 Jan 2024 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVcH99P3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A6E16415
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704228124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbAgTltj/0phRLhEdJ+tD7nQJLUShjq5nTzZeX6dGnA=;
	b=HVcH99P3S/CFUZggVrK7NWL6Ym1EdCHqzLJ7lpU8kD6RRICYUCpD2wf6iXvRP709OErnO6
	DY6Pk9tWs7KTh4b50wVEhNHsjb/3NZB2TFJeafWZMk1d85BBE64kWDrdYKG/pNzsCvs2cN
	27WzzyGJ8FlCGiyndePMh1Yarg+nLis=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-w-0h2nGVNXaaWUPgwAeXig-1; Tue,
 02 Jan 2024 15:42:01 -0500
X-MC-Unique: w-0h2nGVNXaaWUPgwAeXig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EED5938116E3;
	Tue,  2 Jan 2024 20:42:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.212])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4008F2166B31;
	Tue,  2 Jan 2024 20:42:00 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id C273D28C5EF; Tue,  2 Jan 2024 15:41:59 -0500 (EST)
Date: Tue, 2 Jan 2024 15:41:59 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] virtiofs: Improve three size determinations
Message-ID: <ZZR1FxR4cUzuDzLK@redhat.com>
References: <c5c14b02-660a-46e1-9eb3-1a16d7c84922@web.de>
 <02fe18da-55f5-47c5-a297-58411edbb78b@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02fe18da-55f5-47c5-a297-58411edbb78b@web.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Fri, Dec 29, 2023 at 09:36:36AM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 29 Dec 2023 08:42:04 +0100
> 
> Replace the specification of data structures by pointer dereferences
> as the parameter for the operator “sizeof” to make the corresponding size
> determination a bit safer according to the Linux coding style convention.

I had a look at coding-style.rst and it does say that dereferencing the
pointer is preferred form. Primary argument seems to be that somebody
might change the pointer variable type but not the corresponding type
passed to sizeof().

There is some value to the argument. I don't feel strongly about it.

Miklos, if you like this change, feel free to apply. 

Thanks
Vivek
  
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/fuse/virtio_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 5f1be1da92ce..2f8ba9254c1e 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1435,11 +1435,11 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  		goto out_err;
> 
>  	err = -ENOMEM;
> -	fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
> +	fc = kzalloc(sizeof(*fc), GFP_KERNEL);
>  	if (!fc)
>  		goto out_err;
> 
> -	fm = kzalloc(sizeof(struct fuse_mount), GFP_KERNEL);
> +	fm = kzalloc(sizeof(*fm), GFP_KERNEL);
>  	if (!fm)
>  		goto out_err;
> 
> @@ -1495,7 +1495,7 @@ static int virtio_fs_init_fs_context(struct fs_context *fsc)
>  	if (fsc->purpose == FS_CONTEXT_FOR_SUBMOUNT)
>  		return fuse_init_fs_context_submount(fsc);
> 
> -	ctx = kzalloc(sizeof(struct fuse_fs_context), GFP_KERNEL);
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
>  	fsc->fs_private = ctx;
> --
> 2.43.0
> 
> 


