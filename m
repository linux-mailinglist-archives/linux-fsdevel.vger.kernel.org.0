Return-Path: <linux-fsdevel+bounces-19257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A67A8C230D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35ADD283116
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C37173329;
	Fri, 10 May 2024 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZbcdF7iu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2636172BCA
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339965; cv=none; b=mvUMubdFcpGPzAZiQ6FZleiR0i6PWE5WPZHGFHnnTS2qYlMkcvZqdOli/gxwWFQfzbDkB6FryHtpeSk7eHyVd9xDSGpd0m/inaJ9MhEp9QBQo38Q6wEn1RlLynnKesbhurZWyuFrwSsUEcNXxhfRMBJ2RzlxZT13jQpyGX/Ar+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339965; c=relaxed/simple;
	bh=Zy8QCTGPTpb3aG4PVo2SX/wAY2HiJVOT9XtEi8yTZs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkDhcguxZSvwBtHhBG6lFMfOPpcqVnrkXUpqwFY5sPjVihJfpcgTQGSjFGrraqmtuKu01GI7Uj3ZEbtqhbDiUY8rzGezlBHJ6PuiFaK/TjVuFFR4Scv2bM9rQYO/5eoWV0604ph/0hGI7rZALWse70SjhSxFtwCvHff8tOm7qLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZbcdF7iu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a9d66a51so437291266b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715339962; x=1715944762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy8QCTGPTpb3aG4PVo2SX/wAY2HiJVOT9XtEi8yTZs8=;
        b=ZbcdF7iu8bIrvgMLOQta4T9Y+U5I9JgVINUWO0XB2M7Z4L4P++obh44eLEeNM4yyP9
         +c6xBt9h0d2hchQ2TWMNJ2EYsLlgKwQo+35mnG1vrWys6b3fksHJwoR4d7Dfbg3alOnK
         qmkqPbcLg8Sc4wV7P6j4h8UIQAlE/xxU7Ae2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339962; x=1715944762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zy8QCTGPTpb3aG4PVo2SX/wAY2HiJVOT9XtEi8yTZs8=;
        b=TPsoJfF2DyUB2vrPXLrZDsNHcsSkwd/ulEzqzN7GFfzeJp6s//H6V+feOQGcXWntbJ
         XFZivf51IIBO4qt2PkQgwDIxKKC3ZOrVrbgQy9PdiylmskxFcDqBMVjCnyi+j5XNHYf1
         Q7Fdskb1CITP0MaU8vOjGJGIFFCspF/KP4tAFDJOeBWh8oIREVMq7nkJts5jtBrWEbuI
         K6MFJvf9jhNM6dcZQ0GxaZj2hrqFsQbBlJ9vyEHhdkUGpaoxyMRqymhlDiV7jcpxQrSO
         e8Sl7sgM91cIrTPJrvb/DEvivzcD+4qDC6I9ZYNYD9WK5fOColdUsC00GcZ5Zi0H8A44
         pQtQ==
X-Gm-Message-State: AOJu0YzgzAbMB3TKdXX/Y5nXHnN7qhLEQC9wFpNG+VCnTYMeFvuZDADj
	0KWRKdU3QLuyHZbFlNtan1Fl+d4iLiC/pfQpD/A+G/jhF+cHMSxrF5bFsbbX6JEoTHXlPElYq8Q
	e6LNe/Ns0XYC54nhLOxJd1PT8MbU8YumMlfrz1w==
X-Google-Smtp-Source: AGHT+IGKsBIPJJ9WHMUW2Ol0JPt0EF7hmOG42JnEwNCGtO8DczTfZu1nx6w0sFbvbgFYUwaCCDAhH+FVcSNI+grzrFk=
X-Received: by 2002:a17:906:f592:b0:a5a:1562:518d with SMTP id
 a640c23a62f3a-a5a2d53b998mr199022566b.14.1715339961830; Fri, 10 May 2024
 04:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426143903.1305919-1-houtao@huaweicloud.com> <20240426143903.1305919-3-houtao@huaweicloud.com>
In-Reply-To: <20240426143903.1305919-3-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 13:19:10 +0200
Message-ID: <CAJfpegv5GCiF6PDguR7FyCJ_9osytFuy1UDtJnqwu6WDUCU+jg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] virtiofs: use GFP_NOFS when enqueuing request
 through kworker
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Benjamin Coddington <bcodding@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Apr 2024 at 16:38, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> When invoking virtio_fs_enqueue_req() through kworker, both the
> allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
> Considering the size of the sg array may be greater than PAGE_SIZE, use
> GFP_NOFS instead of GFP_ATOMIC to lower the possibility of memory
> allocation failure and to avoid unnecessarily depleting the atomic
> reserves. GFP_NOFS is not passed to virtio_fs_enqueue_req() directly,
> GFP_KERNEL and memalloc_nofs_{save|restore} helpers are used instead.

Makes sense.

However, I don't understand why the GFP_NOFS behavior is optional. It
should work when queuing the request for the first time as well, no?

Thanks,
Miklos

