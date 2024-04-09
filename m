Return-Path: <linux-fsdevel+bounces-16439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8089DA68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 15:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EF928D438
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195A131186;
	Tue,  9 Apr 2024 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OR1Q/p7p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560012F5AE
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669617; cv=none; b=rzav3BldYGJ1BIUdUlJ/4pzSTYc62ck/yCdTpkmXQ1eNVgNNB6bq+4An0kR5RSzM7sxHBpfXhKByf5MJjHuyX8N8iP44G4lq29zuymVtIWecjjD8PUcq+xbvRyFHHXFQPjkaltNrww7OtEZeA3GqhapmvD9zTAQXm40dSPsXmhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669617; c=relaxed/simple;
	bh=HgSuXptHVTlnU+tCyvSEGQreI/Mh+a3w1MGGaBiS5AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giNul+HmGmzMIBgFR/iapgWznlDX811eVBRG9s+9rZR2d2dWnsG6LyRm6j2VZFacgDdWZXc5jTWkG7x4M340Y1EIDZsY7/dejcUTktJGwLGl95KcqXGQvlTP8xPU8vZ9J9SkL6C3VW+7Cj8O1jd8kzErWOrGUlLAz+Ipxwfd9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OR1Q/p7p; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4644bde1d4so772206966b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712669612; x=1713274412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YSUa5BX8vXoQUHinuYmD5ha+KfE0rhiZ+aIvlN25Cq0=;
        b=OR1Q/p7p1mLHIa/CGJjo46BXJKLU0o32x29lbgCbmdWGm2qzv3FyL1WhEsxlibGt0W
         lPCbb42k4PNE11m3ZQGQ5idaVL9YUGvGZ5k2a736obZSBNPZr8Nf/pWFu5yHiLxl3HOP
         Isn+Ca8IMvQXbWFNGgFcqU1z9uGBPulYRhOPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712669612; x=1713274412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSUa5BX8vXoQUHinuYmD5ha+KfE0rhiZ+aIvlN25Cq0=;
        b=Bb4+w7b/SQsi6O5bKgSQiCiTLxunT3hQKhgpuQN5ToFD8sih2eNZKpei6YVyCLAhqP
         LAXqKesObFyDta7CDXVmb1vNpLKpFepLXeLdFk1kNWAEZ0Afeu7LMTPZIakvE6zesDuW
         USSA8Eb4RBQPva/Xc7mv88it0iDCntbiNz01s8LcrMucALzrwwhBZHZEqlWVhljwmp8b
         GBhLFFaydgTPV6RoZyMRIURmgtFjdvSA22HcxfxjTww6MXJdjFLHq69gkpQHeM6iw6ot
         O1uABgU9FPHLFfzMzihY5GEPw/iesnnGvnLUqGza5RiBroiRW0syOhyt2UcodrPk2FKO
         amRg==
X-Forwarded-Encrypted: i=1; AJvYcCW1UbHTls9BiWVc634NQcWenMy/4q0Lz9TJdCvxtszr+uv99d+mhpNTVEheGJgwQs8c7LssDQ3WQeNOLZeoOaRVk01+jbdEpIjmrfSaTQ==
X-Gm-Message-State: AOJu0YzCbEoyWt8zGqwJsjKfyK3WU/j8c/nI4RQuGJHX78ooCpe+Gwb+
	yzx+E32jdZq8jGEJAjQJuaMb4Vxy0fDLeM0hqeAvFnZjHp/RmhqIkKnP/B5WuaCNf/3DcyAUgmI
	7k3JAoJeNa/R+s63hqG8WHHbEKTvYdaq+hE0y7g==
X-Google-Smtp-Source: AGHT+IEB8WqrGxxco+2n/xVqeKS+AqmnbUDhz7C4nkBDIrNtL3DNUlhnAe1txp5T0aCuP5OIhwRushxhE0z42BVg/u8=
X-Received: by 2002:a17:906:4a81:b0:a50:e069:55ab with SMTP id
 x1-20020a1709064a8100b00a50e06955abmr8035629eju.55.1712669612554; Tue, 09 Apr
 2024 06:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407155758.575216-1-amir73il@gmail.com> <20240407155758.575216-2-amir73il@gmail.com>
In-Reply-To: <20240407155758.575216-2-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 9 Apr 2024 15:33:21 +0200
Message-ID: <CAJfpegs+Uc=hrE508Wkif6BbYOMTp3wjQwrbo==FkL2r6sr0Uw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: fix wrong ff->iomode state changes from
 parallel dio write
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Apr 2024 at 17:58, Amir Goldstein <amir73il@gmail.com> wrote:
>
> There is a confusion with fuse_file_uncached_io_{start,end} interface.
> These helpers do two things when called from passthrough open()/release():
> 1. Take/drop negative refcount of fi->iocachectr (inode uncached io mode)
> 2. State change ff->iomode IOM_NONE <-> IOM_UNCACHED (file uncached open)
>
> The calls from parallel dio write path need to take a reference on
> fi->iocachectr, but they should not be changing ff->iomode state,
> because in this case, the fi->iocachectr reference does not stick around
> until file release().

Okay.

>
> Factor out helpers fuse_inode_uncached_io_{start,end}, to be used from
> parallel dio write path and rename fuse_file_*cached_io_{start,end}
> helpers to fuse_file_*cached_io_{open,release} to clarify the difference.
>
> Add a check of ff->iomode in mmap(), so that fuse_file_cached_io_open()
> is called only on first mmap of direct_io file.

Is this supposed to be an optimization?  AFAICS it's wrong, because it
moves the check outside of any relevant locks.


> @@ -56,8 +57,7 @@ int fuse_file_cached_io_start(struct inode *inode, struct fuse_file *ff)
>                 return -ETXTBSY;
>         }
>
> -       WARN_ON(ff->iomode == IOM_UNCACHED);
> -       if (ff->iomode == IOM_NONE) {
> +       if (!WARN_ON(ff->iomode != IOM_NONE)) {

This double negation is ugly.  Just let the compiler optimize away the
second comparison.

Thanks,
Miklos

