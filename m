Return-Path: <linux-fsdevel+bounces-10557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74E784C439
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 05:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96D91C24EE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 04:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A46134AA;
	Wed,  7 Feb 2024 04:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJfNyGAR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE812E68;
	Wed,  7 Feb 2024 04:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281927; cv=none; b=WaZP0wkuUkuQr+dm0WlBgZthZw6l0DcrYwyzY0gbMpGKFBpFMZc7Icna7SZu6RzuMONPsSMF/c3JXl4bnTS+Qv3zNtp9WRyuUOL9IXdA4dHGLiz1nBR49kM5kIFG0etZJYwi5VZb1nKPlWVmNR2QRvxAl3wmgPGa2ZlVqxZvVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281927; c=relaxed/simple;
	bh=u6iQsnuKEsHdUVKtpCKBxs04x9yFeN1zSUYgNQWPxmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3sP+UuAr3ppXi1kZkdQVsBBLW1MJZhYnRbpqp6haDocgYPnkLJjCTp59WH6RRHE1GBC4E8N5ml3mDTi7bJEQ/hkR/6ei55DYtEQC1dqioD9rdK7/XghngAFIo3+d1nkzPr31iAiZxGiCrisrfrWoL+8nuD341jGrGQfKJ7ZRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJfNyGAR; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51032058f17so209421e87.3;
        Tue, 06 Feb 2024 20:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707281924; x=1707886724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtJU8JnmLDFrkXBpW2s0qkwLfi1WTiFDRc6ONQwy2gY=;
        b=lJfNyGARDbsvJdBiQlqXbLq+J+Y/3U3+1Q2hrcO4tEMZBlSkR/iy3jpaj2sVcponHr
         LKWh/8tHursejOf2zVCe+cUAL58JTvUZrKHbl7t6uLH8sZP+z7us0OgpOAb1NyhZcqQH
         gqkb2g1kWxlG7zaXoMLk7gGsnukLlmpVebUn59goYUSPgtnPlMd9xX22ItVOPenLd2qn
         u9TcmwmE06+b6jXrCJIiTzWS/zAIIL+se0xGlB1rOR91hzulHht6fYWw68cUJ6AdJakW
         mtFzvJfECQC/O0FX2jYjGRRoGEjkVguOJ9K+m550uukRLyU7aqmU2QsweLsimzzUN+Yt
         XQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707281924; x=1707886724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtJU8JnmLDFrkXBpW2s0qkwLfi1WTiFDRc6ONQwy2gY=;
        b=QkJRPyBtTbAQai+d+Z+zDgoo+1SMJtCAQIyr9gjB3R6OmvYIMiLA2G6DSreqrDdWTv
         zV1KH0E6Xg14V0ALMHk6w5FpCjya34Or7GyXIvpbQJ6fFins7gcxluOfxe4s/IUvpvaT
         GzIFhEReX6OzpltYcEujEQFazdD9I7OYrazWPeQScaXkhqeu+ntt3f9+LsNQ2QtiZubW
         szQgKG5j5uHKcl8rPLFuCHfKlscfWxPJOTZ5xk9jKoqzy08b2tbd+gpjDqYhvUamnefb
         +6HuLY68fi1VfPHJoP4y6CLccjqqr0kqN0JfLHpuUvFegWSv/yOMbuepS8bzKJn0KVgj
         czYw==
X-Gm-Message-State: AOJu0YySJO50SW12z5jeYiuD8sknN+AMk18uVizgzcMe35Z0BYIKu7fJ
	kF0Kx+jmJjbBfnwuSzy1MxYDEyyJmVr9hDa7YwMmmrfQWi7kPMjOeXAywBl73SDCSu6tNS2ngvL
	0Ja3lWzBZFh54ZfCH5UhzAAVukZ1xCBZ04k8=
X-Google-Smtp-Source: AGHT+IGlasBgbG0X6wFG1GQj7fT+SEexlmOPerqzpFae1rjRU4IvOGEmUGeMUyPcKRJLkevKV0jlKfz0WY2EOMWkQy0=
X-Received: by 2002:ac2:4a8f:0:b0:511:38e6:6b24 with SMTP id
 l15-20020ac24a8f000000b0051138e66b24mr3463290lfp.3.1707281923488; Tue, 06 Feb
 2024 20:58:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com>
In-Reply-To: <20240207034117.20714-1-matthew.ruffell@canonical.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 6 Feb 2024 22:58:32 -0600
Message-ID: <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> his netfslib work looks like quite a big refactor. Is there any plans to =
land this in 6.8? Or will this be 6.9 / later?

I don't object to putting them in 6.8 if there was additional review
(it is quite large), but I expect there would be pushback, and am
concerned that David's status update did still show some TODOs for
that patch series.  I do plan to upload his most recent set to
cifs-2.6.git for-next later in the week and target would be for
merging the patch series would be 6.9-rc1 unless major issues were
found in review or testing

On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
<matthew.ruffell@canonical.com> wrote:
>
> I have bisected the issue, and found the commit that introduces the probl=
em:
>
> commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> Author: David Howells <dhowells@redhat.com>
> Date:   Mon Jan 24 21:13:24 2022 +0000
> Subject: cifs: Change the I/O paths to use an iterator rather than a page=
 list
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
>
> $ git describe --contains d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> v6.3-rc1~136^2~7
>
> David, I also tried your cifs-netfs tree available here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dcifs-netfs
>
> This tree solves the issue. Specifically:
>
> commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Oct 6 18:29:59 2023 +0100
> Subject: cifs: Cut over to using netfslib
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.g=
it/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c2e8a54db119fd0d8
>
> This netfslib work looks like quite a big refactor. Is there any plans to=
 land this in 6.8? Or will this be 6.9 / later?
>
> Do you have any suggestions on how to fix this with a smaller delta in 6.=
3 -> 6.8-rc3 that the stable kernels can use?
>
> Thanks,
> Matthew



--=20
Thanks,

Steve

