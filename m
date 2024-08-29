Return-Path: <linux-fsdevel+bounces-27827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28149645CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA40286F16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209441AAE1E;
	Thu, 29 Aug 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JukeghlL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D11946CA
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936842; cv=none; b=f8yFYt75nffv1CsjZCOJAek9uI4kvqWmf0U78glQAuH/rm+DQeLUxnQ7SjY/iTQZ1r1aji4Kc7xURSrscq+hxyUWuJyUIjqvI3VcqiuoJ+pyj1KgZvvzwnTUHAqo28HsLv8mg1qiVR+SuMKjeQa8q/NrOnQMU0+iBHgROtZRt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936842; c=relaxed/simple;
	bh=vhpdpTfvOWpq4BkpAeiQWNqUpz5BcVonWLnhkaxRaQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqMLDOa53C0LJF2G+We/c9TFBdMOFFSYftNjsAUks2H2xEr6+MDglJa/xXmzfoA4+T3Q5rHhGmAoLPKQsMvOpW/DEnP5BmaOxk87yipwpEITs54qliHTeVi5WYft2UL1bHDEx072rLxknbIp37EWP5K2We/r61k0bYtNvGOi1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JukeghlL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f3e071eb64so7717911fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724936839; x=1725541639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0TbsUu6WIFtUI0I/cmrO4B5vqQGbNpEnL8oQNR8OvE=;
        b=JukeghlLBK/lzpMdmTmuX0QRHVNvXFFbvE1U9X4DdctwndIWNfKsPJ7RcRRXTm1fFQ
         9zSqUWJuIoiQTWXn69t1NvhjTYIEmq1LYIDAiObJuQRerDSCPXsoprl3E8i5G5UZSR4l
         pNkcrCCVehg+uobEn5JdIjRNz0c/vb5CAOcfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724936839; x=1725541639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0TbsUu6WIFtUI0I/cmrO4B5vqQGbNpEnL8oQNR8OvE=;
        b=dfp261+puC5tmHKD6xuOaFslQDhDz0AqU8hNPyR8WkIxn5SrMLaBD4wgWrAmZcju9d
         BkrJNS73J/pckf8JcOF+AnLZKTTOEwmK2JF3lFWaTPLVMfuazKxSvh76nHlAFRh/24sL
         WliSIkm67c9Uaf9ulL1X7/URq1IOdISGkK5/dwAojeJ8jxfudp4R4etHMYVu1wQIUeOx
         wn0duhDkBQl1TSwjISYu7tSPam38wxMZFAbALEnvj4zrdP5kKbaNXhO3ZdTGYPMWxi0X
         XoSR+0mngePjToGmZDfc0IwB8NeJ8OylqOQb+jRuztvPESrW9/jjl9QA5gf/K07QlNgW
         v9NA==
X-Forwarded-Encrypted: i=1; AJvYcCVCEA+fcp1SdZKjVZRZWdQkJo12ruTvO8oW1DDEBuEhZtBig3pGaoF/F+a4Vxm3hr4obawi3CS5NoZcLvCw@vger.kernel.org
X-Gm-Message-State: AOJu0YwtoYhmDFIjjFWlSRTkaHvJ5N2XjmHHByVPZHuYUD9AknpGCfP3
	sFz3EgIXv9K7zPBhfGJWqOr6H9xB/zQSbO+f2l4790YYtfIViurrbs3owsnYjao4iTdRAMy4M8K
	HVniFTiWH1nZx8OpteHF/KYGWnz2DrxSvH6DR0A==
X-Google-Smtp-Source: AGHT+IGSRqyXut7tytiqq+Fv/FSdxZOLBx6kvkri+Nl7nKT6LJzc0hkeK3IT0QDDU6jjqcTAQkTG+kIWkupBmiQV4tM=
X-Received: by 2002:a05:6512:4003:b0:533:4620:ebec with SMTP id
 2adb3069b0e04-5353e543459mr2692053e87.3.1724936838878; Thu, 29 Aug 2024
 06:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709111918.31233-1-hreitz@redhat.com> <CAJfpegv6T_5fFCEMcHWgLQy5xT8Dp-O5KVOXiKsh2Gd-AJHwcg@mail.gmail.com>
 <19017a78-b14a-4998-8ebb-f3ffdbfae5b8@redhat.com>
In-Reply-To: <19017a78-b14a-4998-8ebb-f3ffdbfae5b8@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 15:07:05 +0200
Message-ID: <CAJfpegs0Y3bmsw3jThaV+PboQEsWWoQYBLZwkqx9sLMAdqCa6Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	Miklos Szeredi <mszeredi@redhat.com>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 at 14:37, Hanna Czenczek <hreitz@redhat.com> wrote:

> I honestly have no idea how to go about it on a technical level,
> though.  Na=C3=AFvely, I think we=E2=80=99d need to split off the tail of
> fuse_fill_super_common() (everything starting from the
> fuse_get_root_inode() call) into a separate function, which in case of
> virtio-fs we=E2=80=99d call once we get the FUSE_INIT reply.  (For
> non-virtio-fs, we could just call it immediately after
> fuse_fill_super_common().)

Yes, except I'm not sure it needs to be split, that depends on whether
sending a request relies on any initialization in that function or
not.

> But we can=E2=80=99t return from fuse_fill_super() until that root node i=
s set
> up, can we?  If so, we=E2=80=98d need to await that FUSE_INIT reply in th=
at
> function.  Can we do that?

Sure, just need to send FUSE_INIT with fuse_simple_request() instead
of fuse_simple_background().

Thanks,
Miklos

