Return-Path: <linux-fsdevel+bounces-64243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC5BDF428
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86EF3505D64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A472DF6E6;
	Wed, 15 Oct 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihG8eK1/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10A2DECA1
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540445; cv=none; b=VLjXsG5JDR4n9e4/0npike8ZbfDV9RtBs4Mz6kDu0FeNSaGOG7OR4WPLK8zmsxcY2BEZqtFy7Cin4IweiWQJtpQXkpnaoAVVS7xzSEqYLaHt84mae06QWyy+xGg7/hZSIy2RclIv99zssYls6vW3RiAdA/XqIv+NEkqyCMfwOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540445; c=relaxed/simple;
	bh=tSSuv9qd+EGYUQL8vOXHRSPgInZY98O3jOMvDKpPSXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC9csv+m5fMK9y1yZ31FtonZ01Gqi3sCTCfK10zGr4yx88WBoMDKCyZlQnsIpZQDqb9AW9PcSYF5hfDQfwDomzE+ON7DIAVoHnI+G9rqNV1f96yFU5Bg7/e+oCrgLJO1ELuGuqYlLDHQ0pxS9KFIu+mm6vaPyCdnAA+b5B99+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihG8eK1/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760540442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MElpqlEaZ/QL8rOGgLuRvu7r4AErxu8O/kca7UOA8yU=;
	b=ihG8eK1/b0bGMnyca/V/q3rphCRXPnF2Yl8a6MSoU3/SIEnswANtyTwPaBc51ppHLUoXW7
	yPCYMQiW949UpPMRq1pUxAr2dZhlxfbFjHeEKMDh/f34mUSb+87Cy20Ec69C8ImgRHIafI
	ge3zuHvgwit4KrNEdacIBArSXnIBMCU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-MGTBeoRdPiCvVuFG5cGS-A-1; Wed, 15 Oct 2025 11:00:41 -0400
X-MC-Unique: MGTBeoRdPiCvVuFG5cGS-A-1
X-Mimecast-MFC-AGG-ID: MGTBeoRdPiCvVuFG5cGS-A_1760540440
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e41c32209so40552115e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 08:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760540440; x=1761145240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MElpqlEaZ/QL8rOGgLuRvu7r4AErxu8O/kca7UOA8yU=;
        b=LnNKkhbWXxJC+cwtId8G89A1lIcTQh+ZLUlqYiBAmfcDdm9ApHmCXrncBChRswOxEh
         k4/lzFQC2PBqd/WgMFx8pU3PW/zosIOOa+YHdfDu5WJqoPobYT1gTZuqWmfEoeT1xRD0
         h4507XSS/9bPRE2M8lH69WG00FUvkRFDABqjNkgqs05GdlwOnkUgwPLNtsaCgp5HLgKa
         EWalH3Lf0d/xtpFjJ5ERJtyamlHBo/E8jSXcmZfiSFhHfZPQrfpkbikJkejzmx4qeJxT
         dvIkDocDeJfW0BiksXiG9juMivocVwWfTgWy0Hnwtwm6bgBzSt0z8yxTJlIzDHjhWyux
         77Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVy0EZcZygDSUwJuRSkRvljrhvRMs4rlnWn0r35/gjUqZ7YFFg558dI31h1LrNcE/ULWS6uGxdz5hlsvEv1@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1G5zQq0LxbTTvYOY92qpDGZTDinwSs/zYpvTWz9ngPULXQHO
	ApOWLR5WHsxVbjVIVr5KG4n2Hnac4ErwXhXrOATeCbxhkoJDPz1vJT/bUjfKcyXibf+iLVn//5C
	0OEqo6IY17u04LSoUhAnYeinsI/WCV8cq+GjNXyIyLzOmjZ0jbHlQgaJXMfprlq9pcpo=
X-Gm-Gg: ASbGncuvCbETZ0xc+FGFAxT/W0BN1pwE6DIGLXJ7zH/x5ZmkDmGIONQM4JXqmhprAGu
	r4hj/btiirBmdeTOFtHbnqS8Uk1X1KtGks5NxGLfDyWfe6gW5P/dBi2ukCfeJExk9o5xHUL8+xJ
	c8zJyEqZsSXl/f26esAffk06TjQOXVdi6wcJRAjFSmpCuufnH3mpPUhQ6VI/MEKEbZJoxxedDgj
	VC8ojZrO1nSykaXpCNlxTGrzXrTZu4Vz2fQjHba2UFc9ynqleoFsGuHCVfCcLrPs/26WYkbRm22
	eCCBMwVH0lnFtW/2+Iv/0YnPmBm/DBKtuQ==
X-Received: by 2002:a05:600c:609b:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-46fa9b106cbmr224296955e9.31.1760540439782;
        Wed, 15 Oct 2025 08:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG83tZOYf92UjJrUkzfuJBKvYnViUzT9/EFd7GjBiFY3LwsTllALB98FeXxGE98+Djg54Lo+Q==
X-Received: by 2002:a05:600c:609b:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-46fa9b106cbmr224296395e9.31.1760540439138;
        Wed, 15 Oct 2025 08:00:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab5250ddsm175452285e9.6.2025.10.15.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:00:37 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:00:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Gong <gongwei833x@gmail.com>, vgoyal@redhat.com, miklos@szeredi.hu,
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Wei Gong <gongwei09@baidu.com>
Subject: Re: [PATCH] virtiofs: remove max_pages_limit in indirect descriptor
 mode
Message-ID: <20251015105830-mutt-send-email-mst@kernel.org>
References: <20251011033018.75985-1-gongwei833x@gmail.com>
 <20251014185356.GB18850@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014185356.GB18850@fedora>

On Tue, Oct 14, 2025 at 02:53:56PM -0400, Stefan Hajnoczi wrote:
> On Sat, Oct 11, 2025 at 11:30:18AM +0800, Wei Gong wrote:
> > From: Wei Gong <gongwei09@baidu.com>
> > 
> > Currently, indirect descriptor mode unnecessarily restricts the maximum
> > IO size based on virtqueue vringsize. However, the indirect descriptor
> > mechanism inherently supports larger IO operations by chaining descriptors.
> > 
> > This patch removes the artificial constraint, allowing indirect descriptor
> > mode to utilize its full potential without being limited by vringsize.
> > The maximum supported descriptors per IO is now determined by the indirect
> > descriptor capability rather than the virtqueue size.
> > 
> > Signed-off-by: Wei Gong <gongwei09@baidu.com>
> > ---
> >  fs/fuse/virtio_fs.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 76c8fd0bfc75..c0d5db7d7504 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/memremap.h>
> >  #include <linux/module.h>
> >  #include <linux/virtio.h>
> > +#include <linux/virtio_ring.h>
> >  #include <linux/virtio_fs.h>
> >  #include <linux/delay.h>
> >  #include <linux/fs_context.h>
> > @@ -1701,9 +1702,11 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
> >  	fc->sync_fs = true;
> >  	fc->use_pages_for_kvec_io = true;
> >  
> > -	/* Tell FUSE to split requests that exceed the virtqueue's size */
> > -	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
> > -				    virtqueue_size - FUSE_HEADER_OVERHEAD);
> > +	if (!virtio_has_feature(fs->vqs[VQ_REQUEST].vq->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
> > +		/* Tell FUSE to split requests that exceed the virtqueue's size */
> > +		fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
> > +						virtqueue_size - FUSE_HEADER_OVERHEAD);
> > +	}
> 
> The VIRTIO 1.3 specification defines the maximum descriptor chain length
> as follows
> (https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-9200019):
> 
>   The number of descriptors in the table is defined by the queue size for this virtqueue: this is the maximum possible descriptor chain length.
> 
> The driver requirements for indirect descriptors say
> (https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-9200019):
> 
>   A driver MUST NOT create a descriptor chain longer than allowed by the device.
> 
> My interpretation is that this patch violates the specification because
> it allows descriptor chains that exceed the maximum possible descriptor
> chain length.
> 
> Device implementations are not required to enforce this limit, so you
> may not see issues when testing. Nevertheless, this patch has the
> potential to break other device implementations though that work fine
> today, so it doesn't seem safe to merge this patch in its current form.
> 
> I have CCed Michael Tsirkin in case he has thoughts. It would be nice to
> boost performance by allowing longer I/O requests, but the driver must
> comply with the VIRTIO specification.
> 
> Thanks,
> Stefan

This request is not uncommon. We wanted a field for max s/g supported as
separate from the VQ depth for a while now, and for various device
types. No one yet bothered implementing this or even adding the
description to the spec yet.


-- 
MST


