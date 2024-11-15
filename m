Return-Path: <linux-fsdevel+bounces-34927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3FD9CEFCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C6BB3117E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E651D47CB;
	Fri, 15 Nov 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jxekDYFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8916F282
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684301; cv=none; b=VN07Hw5KbLs+Ofv2C0gv+IoKs3PK8Hhl2HLPo5zzt1lPPTJjKZb5H+OkVZ1ReWbx7hDpYrqDtqLxuHcBcFSojCqiMn/C6KsxaJrFXOY4ECGwaCS/r4LrtK+MbhMXLN52N9VsoGqO5o8tRTlZeEu3oxI1a082yr0XM4+WMHIt/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684301; c=relaxed/simple;
	bh=TIZ7Z0awf5cXcxUiF+IISaAkoCwhIcEsKazphLnlfYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUlupuoWpOWmY2RqustItfvg+A/MXlow+KURvnLigrniwX8eabsUKmuDso8Ghiyo116q/qUawVGQFi8IdgbPkViE2jDVYeVXz+rLAzTXj+SFw3HHFLMeRwVLx2WAB0pcnQ1UjAXSvRyD2U3R2ou7o8TEKB7NVp8GEBy0DEog2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jxekDYFj; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4609e784352so13070301cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731684298; x=1732289098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhWRL4SgdQsRHwF3zYRHfFkkTS6N6p8eTQwmpFKTViw=;
        b=jxekDYFjEkjClmziv8L24VOvwcy7vFsFvvQhTkzdnJsT047qyJiOOTvuZBv7yGEA7S
         DhX3a5weIkiUfjNIlUPju0A8+WZg14h2iRJoqsiL/N2Xf/DtyI0FLX3t3IBYDHb76CEx
         LtVLvWE+qWf4HjMVJnu30IX6RJBR0XF9NV7ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684298; x=1732289098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhWRL4SgdQsRHwF3zYRHfFkkTS6N6p8eTQwmpFKTViw=;
        b=b5IGNMXuh3LDlKV0fb9m0O53WekU+hXJ3D50rDkGCxW64Ffp8oZo5VInXwMvcDQWVn
         vBq9buvz1Qjswc07OU150FcShmj6vF33FulFVHt0EvtXh+6h24+Y6Th91kHJTyYQZ3Rh
         miFW4UOIC0jzTnyxl4vHwYbs+b+HOwoWM7AHu6ObHZoEtSSkQwqFNBgrSHW5WrO16Scp
         TBSYcrCEUJxD4sX2mOQdJ+piBhRW84z1ty7doi3pmev8gC0R34EDNbvKdHtTlmAmrMir
         vGJ6SH/zsySDgtzVVnFiSt3KhgOV8ecBoiiQ8LDm+IuMZ5cHKHzbxeNzQEtz+vvYQJ1I
         YWTA==
X-Forwarded-Encrypted: i=1; AJvYcCUzShdMmfxcEWdwFuF4Eq6T4N0DRjOmWMPSBGuLsfx87xrT0FLiAh5rH8/MfZ7GISfU46K5r82FmCoyuHnS@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXo+uIeBPlnZstPxlLOLkxVGhD0i9gjfTvK9lnuTtLIFOp8j2
	GMm75rifrLlDTTSXHa+mxegrp1vzRWRdqr06uFL0g3/M11Ip8jhFPAdsLrW689CHN+OLmYw/F3D
	5EA6nIgPYsjxK7yCk0KniSYRGt6CmsWrN6grMgg==
X-Google-Smtp-Source: AGHT+IEo2rr0odYMw2XFght516xGACmkLA4n6BjOW0bN/+TMAiU5Xyo127jU/d8oAwXbYktURA2Q6cq1rbAEop0XL8I=
X-Received: by 2002:a05:622a:5c8d:b0:460:a9da:42b8 with SMTP id
 d75a77b69052e-46363e11f32mr36945911cf.22.1731684298435; Fri, 15 Nov 2024
 07:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024164726.77485-1-hreitz@redhat.com> <CAJfpeguWjwXtM4VJYP2+-0KK5Jkz80eKpWc-ST+yMuKL6Be0=w@mail.gmail.com>
 <ae437cf6-caa2-4f9a-9ffa-bdc7873a99eb@redhat.com> <CAJfpegvfYhL4-U-4=sSkcne3MSNZk3P3jqBAPYWp5b5o4Ryk6w@mail.gmail.com>
 <ece87ac3-71e2-4c43-a144-659d19b1e75d@redhat.com> <CAJfpegtuVxtf9xoyJPveqA=uXb-wnzPcqD_rXNOV4LMahWqxEQ@mail.gmail.com>
 <2fe45430-a07d-45bb-89b7-1e4a08d1818f@redhat.com>
In-Reply-To: <2fe45430-a07d-45bb-89b7-1e4a08d1818f@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 15 Nov 2024 16:24:47 +0100
Message-ID: <CAJfpegtQhcGNaH8k1XKTSV_9=T4Ayx8oDLUK-0X8CRg6Rhb1vg@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: Query rootmode during mount
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	virtualization@lists.linux.dev, Miklos Szeredi <mszeredi@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Nov 2024 at 15:51, Hanna Czenczek <hreitz@redhat.com> wrote:

> Now that I look at it once again (because I was wondering why to check fm=
, and not fm->fc), do we even need to check fm or fm->fc?  fuse_mount_destr=
oy() assumes both are non-NULL, so I assume sb->s_root || fm->fc->initializ=
ed should be OK, too=E2=80=A6

You're right, fm can't be NULL.  Not sure why I thought it can.

Thanks,
Miklos

