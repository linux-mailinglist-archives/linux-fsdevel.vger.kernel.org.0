Return-Path: <linux-fsdevel+bounces-37478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC69F2CC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 10:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92C41884A05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 09:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA332010E2;
	Mon, 16 Dec 2024 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjv1v70A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166420010B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340805; cv=none; b=MPWD+ccesukLMWWWciVE7iGXjx6YGPEqd0hKx7JU/MwEjnV56KwjvG4IZbwAyTlkSm4PAvtOjYcXnglF4owf506efT1NGeUsvZTNGpUeD2jmZViS7MNG4kgzulqBo3POWkNakJqa5zWjovWv33CygOrXsErxwYtWSddtfFlPUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340805; c=relaxed/simple;
	bh=SGBEAsUHACZKRtnAOJcCNoz7Lrs3l/yvocjvK+XS87E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqtd5PpOT4VwL8vI2/QGV7Shy5bZdjAUVvsXcizTLODyIOVJr97rNmkJfK/9x/KY4ug/Ia8yI05kHWX/LJ3DoI4+5v701JkgbKQqk8KKY+rZvh4iAYcl15pgYGJ5tzGlAvm+vGJjUgP3VJsJRLJhQ5UaC65XJoLgagRi8z4v9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjv1v70A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734340802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ezr7V8tPAUqIcpXhm7ZLFTCr7/A1YkJY6xjiiBqkcIY=;
	b=cjv1v70AV5UoPCN4ePqYM8z0tEfyKAzVg9qe0Sm9ZRQAvBiHTDbVMimKJU0ED0wF/02065
	u9LX3fOd0qtoI2nMcKLsVyNgaOZgeyKzuE5iTb7EJPDvAtLdvBIali1p/D8WL7qmQtpfqw
	M9FGrQ+nXVP1/YnhlIc4T16D72jTWG4=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-puWlFLL0MS6mVdyV2QfiBQ-1; Mon, 16 Dec 2024 04:20:00 -0500
X-MC-Unique: puWlFLL0MS6mVdyV2QfiBQ-1
X-Mimecast-MFC-AGG-ID: puWlFLL0MS6mVdyV2QfiBQ
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-84fee7916a9so370673241.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 01:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734340800; x=1734945600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ezr7V8tPAUqIcpXhm7ZLFTCr7/A1YkJY6xjiiBqkcIY=;
        b=iNlKwiUEpIo886goA/kGtBKcYR+z7oflXMJpBrELM/GoY/bRbAQDFESv/G8joOuzEF
         m1ShYO3cDRpr/oKt39DVFu8a0ZOmGcleSUJA6g7zlGR8Si0WtE/BVHKCErrlboPpj7Lm
         x9XBgaW0pz11JQP+xLMu2EJ59PoKpSH9Av/F2YdbPPC3OljcUVAAUjdq+v1Cko/PYq7D
         CcexL5NxJUS+apABpTa6vY8+DyiV3B5JGjtga9w/j2yGyP6pKBf2bNEKXsdS0kMHH4ke
         PZy3S1JqP5sB6opY0XM6O853Y/8GueV2YdC6JPXmvrnUzxx8FHRtXGnEDLwveS3tDTko
         YoYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2vga526ZOteBoWvw+YUawo923F4DFYBbeqCGKdWair0gfP51bCjAHxKOoHBheKvqDNY1hHe+iv2Vo7BAE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Y+zWUTrdckgLk/944/voiZFAgJxTE4iB1pw0QfENVdEAJHea
	36au6lDz9yqYfnB7GPT+BswXgfzWQ9nIUQuMip7ycbKNWSyeNlc9qP+ejT/dUGaFl6qzp8s4iy6
	W5w/LVSfqj5lYjgKTg/U34ElSow0w41aeOD3UCgK7vW0gO+DFo6xpoxz0CTRFKI6CQDjupGqL6j
	mBsS6YHluA2NAJiTWaY6VsTvPJ0HtLLI5S6OLiHg==
X-Gm-Gg: ASbGnctrLr9YfbMvTcGCHY7MCJl5Gl/0LtAaE+x6IyY9+n4ncIQEiYlQ9ksoJjj+E85
	459NNDr8N60/OrP5F/APoFphKy+Ii1ZGXxh2fymQ=
X-Received: by 2002:a05:6102:f08:b0:4af:ba51:a25f with SMTP id ada2fe7eead31-4b25db0b0a1mr10592475137.20.1734340800312;
        Mon, 16 Dec 2024 01:20:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhbzCeU5B+2v+R5K9FoBsbiFBRDBPbH+QRMgzW9zb6TVanCU3eaUlsdbe1uzLeYyZBNEEYYFyZyTin529p1eo=
X-Received: by 2002:a05:6102:f08:b0:4af:ba51:a25f with SMTP id
 ada2fe7eead31-4b25db0b0a1mr10592460137.20.1734340800088; Mon, 16 Dec 2024
 01:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214031050.1337920-1-mcgrof@kernel.org> <20241214031050.1337920-10-mcgrof@kernel.org>
 <9fadee49-b545-440e-b0c9-e552bec1f079@oracle.com>
In-Reply-To: <9fadee49-b545-440e-b0c9-e552bec1f079@oracle.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 16 Dec 2024 17:19:49 +0800
Message-ID: <CAFj5m9J0Lkr9hYx_3Vm2krC9Ja5+-xjmqkqjVjY0jvimjWbmTw@mail.gmail.com>
Subject: Re: [RFC v2 09/11] block/bdev: lift block size restrictions and use
 common definition
To: John Garry <john.g.garry@oracle.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de, hare@suse.de, 
	dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org, 
	ritesh.list@gmail.com, kbusch@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	kernel@pankajraghav.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 4:58=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 14/12/2024 03:10, Luis Chamberlain wrote:
> > index 167d82b46781..b57dc4bff81b 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -157,8 +157,7 @@ int set_blocksize(struct file *file, int size)
> >       struct inode *inode =3D file->f_mapping->host;
> >       struct block_device *bdev =3D I_BDEV(inode);
> >
> > -     /* Size must be a power of two, and between 512 and PAGE_SIZE */
> > -     if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
> > +     if (blk_validate_block_size(size))
> >               return -EINVAL;
>
> I suppose that this can be sent as a separate patch to be merged now.

There have been some bugs found in case that PAGE_SIZE =3D=3D 64K, and I
think it is bad to use PAGE_SIZE for validating many hw/queue limits, we mi=
ght
have to fix them first.

Such as:

1) blk_validate_limits()

- failure if max_segment_size is less than 64K

- max_user_sectors

if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
       return -EINVAL;

2) bio_may_need_split()

- max_segment_size may be less than 64K

Thanks,


