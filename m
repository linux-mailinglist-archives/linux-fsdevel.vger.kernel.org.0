Return-Path: <linux-fsdevel+bounces-69709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B5C823EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 20:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D183ABE19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D4B2D46C0;
	Mon, 24 Nov 2025 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjznawnW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0712D24BF
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011701; cv=none; b=MVCy9i4WLcFZKQid4NfF7f7I71jSzdXzjYboKLVNTjOVQKCBtVGCcmjmy3K0i9X8lS64lM/SFnMwFzUPqneOjZVnx4jVHooHvLK47O+egHqMlGLJIAaWPJ7TOJVK89+em367fHkR5uU6LMR+KR+yBXle2W9wZnSRFUoKrUB6MuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011701; c=relaxed/simple;
	bh=DV/XBl1C/vGiq82y4dP4Q2UN6Qxbo1IPdbXo6X8ohWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We/KrvAiyksWobN+Bx5wU0SoM6TaI+JXT7GDLMh9s3XvfCV6QHyvJkUCw844+suV+b1Jy9i5eTHHi306xOcYjJy2D0JJinHumlT7uMcfeFob9ooIsZ89QYHAmd7C97/hHE0oqcU7TyEVQbkTmgEkJQTJItUlMEHIczWSXKzVEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjznawnW; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c7613db390so2101437a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764011698; x=1764616498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV/XBl1C/vGiq82y4dP4Q2UN6Qxbo1IPdbXo6X8ohWU=;
        b=OjznawnWgG6WiOUd4ASktzmLZmyaFj7MXscKyk8nKGDSkQUFtKXJfhZo+KFEKAo2wA
         u6+wCsEzmb/m3E6Uyb8MPk47roFCCeTdNgqvd6Zy2y9SniQiU8YTj+R29Q9PsvGTxkat
         x9pALYWt2VQDOW9WuxuPTzma5wlubCG9y0jpev4GIhT4XY2xlXOugyFRPFouJOLl8rKc
         YBKS2Da4O1PZcFuf5km9kisLTmHeO1fGfwQgaZQTU/vPWS8VNYqJ5wAwI9k3Im9F9VnH
         eLkqwKFS2t48ARGOkRfXsnteew5Do0lxC0TP1jjO2ycjgYG+qrRoPmbL3Q5EJiw4SOG7
         gOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764011699; x=1764616499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DV/XBl1C/vGiq82y4dP4Q2UN6Qxbo1IPdbXo6X8ohWU=;
        b=ikli8OImW9BP6ZgyZYBQRuJq5Q+y6a9uGpHAyp+mRHJ4eSNV7FQG9/K6PbhWYSzhs3
         N/MLGmr3eVPIUzP+qXFBnzLIJ9HQqkxc1wxb4/3hwLGlHUigcGrmmAXDj+7DwYhKzZnK
         8nOefQcgfZPi8AyzdffMVAuNIkBAS+bhzeyXbg9j9Wrs/qNokGObvgqgZbi1iXmYogr6
         BZUnqBMcbAQRTwDK/ow3sGnBsndT3Vj1N/R5y//3/a80f52ke6SGYUPxZZnxuhNCO+hh
         VQ1gI6CwF/y0Yl3o/b871dW3u4X4Ady1wzd3wI/Ezyox5Gi3zFliMYzi5BGzDVZLZ6Yk
         kBIg==
X-Forwarded-Encrypted: i=1; AJvYcCWlKkDxpudFBknUPTbAYXBER6RYNZPP0X3cbHiLYyUKe5IEm4U33rIVfeeuWlTmuQn1AJAeL9GJTPWOE40/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhw3scqEnpXf2Xr2cC8b1I0q9Gt81ko/wbXITb4QKNqPRqK5dn
	576bu1y+W5PaldCPmKSEJeYLGjzoiNOyRHSaatB1QUcC6QCgv6gpRB8mzZ6cYWHXgZmP7SVAr2v
	ooAjcWyXZzsWyNQ1BuO8V1M8Y56LpLS8=
X-Gm-Gg: ASbGncsz05iorgT7EGKdAIMsZn3yhZmmq2PV/pop3DQAF/MgNlcSZuMBuDulBdmic7N
	d8j+7UYYZKZ6giR3WRICIxMPhOTFpPaAD6F6cN1E4fHXIiN2p5WVNqO9b9xJmZ5cAo+ozHRwQ4j
	V4Cc3k8QyqwHgtdnKN4yH7SxtTHWNScwptCouLudWAr7Dso3pV0UItlZc+ctdAcGchFe+mGpeyb
	+q+GpnUo5bBsQsXLFKZwVmER2pn5yJFTG10ML4FUop8NwDi7wQDZA0phctOwIeQtAmaxwP20P8V
	AEL9Rh/4HBTyRJ+OqSk+kbNLdRxI+J3lbaOqTJI=
X-Google-Smtp-Source: AGHT+IEtMS1l6aonQ/j8YSDdVxS0Zd+rig8ZKIXGybj2Vh7SID3lxFHy0S6jQ3vysI6Zy7YM4XyEUBZbPKkRQAd98D8=
X-Received: by 2002:a05:6830:674f:b0:7c5:3013:e50c with SMTP id
 46e09a7af769-7c798e02b85mr5384805a34.33.1764011698588; Mon, 24 Nov 2025
 11:14:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111062815.2546189-1-avagin@google.com> <aSMDTEAih_QgdLBg@sirena.co.uk>
 <CANaxB-wmgGt3Mt+B3LJc4ajVUdTZEQBUaDPcJnDGStgSD0gtbQ@mail.gmail.com> <d689e03e-0f20-4a33-bd74-6cf342f92485@sirena.org.uk>
In-Reply-To: <d689e03e-0f20-4a33-bd74-6cf342f92485@sirena.org.uk>
From: Andrei Vagin <avagin@gmail.com>
Date: Mon, 24 Nov 2025 11:14:46 -0800
X-Gm-Features: AWmQ_bkS1TX91kIm7q6pQLsTdv-5f_HsFXYsGfo-lVMTOysXzpGKlndN0soASzI
Message-ID: <CANaxB-z2hJ3xT7ViA1ERkgFQMaHThgriK_+goMyoNeDtrFBpcQ@mail.gmail.com>
Subject: Re: [PATCH] fs/namespace: correctly handle errors returned by grab_requested_mnt_ns
To: Mark Brown <broonie@kernel.org>
Cc: Andrei Vagin <avagin@google.com>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 3:23=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Sun, Nov 23, 2025 at 07:15:16AM -0800, Andrei Vagin wrote:
> > On Sun, Nov 23, 2025 at 4:51=E2=80=AFAM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: E=
BADF (9)
>
> > The merged patch is slightly different from what you can see on the
> > mailing list, so it's better to look at commit 78f0e33cd6c93
> > ("fs/namespace: correctly handle errors returned by
> > grab_requested_mnt_ns") to understand what is going on here.
>
> > With this patch, the spare field can be used as the `mnt_ns_fd`. EINVAL
> > is returned if both mnt_ns_fd and mnt_ns_id are set. A non-zero
> > mnt_ns_fd (the old spare) is interpreted as a namespace file descriptor=
.
>
> I can see what's happening - the question is if the test failure it
> triggers is a problem in the kernel or in the test.

This is a test problem. The test has to be modified to check cases when
the target mount namespace is specified by mnt_fs_fd.

Thanks,
Andrei

