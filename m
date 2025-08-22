Return-Path: <linux-fsdevel+bounces-58708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86AB30A01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6F12A033B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CE1373;
	Fri, 22 Aug 2025 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLjKzT8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1A18D
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755820875; cv=none; b=YNC5XuAJO4+YI/BnvbJfU8/4elsAB12z/sTV94Ml5BWY63wRjPLh2AXE8hicm7LZghrgmxpRo8HobqG4gLpp0wR0sLhVLBIclfLkImsdQDZ2Qs85ZnCv5E04Jl+mkYY4jzmkuXg2k7AfUXa/7EOwval4/CocaiaMP/IIldQ+nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755820875; c=relaxed/simple;
	bh=AL6s514d6XsGX3O4KHS+1YsySbNUf7+WlSWAUtkMfc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRLBnrl2BvFgbILNXiMUzoOry0zjmOGGVQ/4KD85q2+t8jO4bWAmn6cek5279DIt1klzFrmhoVk6C5JcAdd2V6rOvVxukiGvp10IRMc58faMupmj1NYjMkL3cRIFa0ttWzqseX/hdD3AAZnDQdCJYfZUlnmITUrcuJaWNMP/zpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLjKzT8p; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e8706a6863so188429085a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 17:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755820872; x=1756425672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAIuwRnFRDmQrHJUcu6js+zMr5ZyX8Xb7y1nWZeeUIM=;
        b=NLjKzT8ptQpbYdllxJ2amuEL12QEHLZ9oUYpjQLiaVJ9AOC4H7L4M4H2DdmFVdo3QH
         8vdREMN+VkofYe9PL8tYLCyDbFD0CDSlafZSsP7IJ0IKvdon+4kHJ8198TQxncDfiXtL
         KPySUVl+gGQ2VvBPIbQiROawz8NyUBlaatZ+svXzsClZC+VWhCmcAs6J3nnYCTnOZnbD
         8azuRI7B+bl3PNhExWcVr4GTJVOBA/MgGzikyO6gAO2pJfz2qM6PGT6/g3KM+/0/PW2r
         mASBP94C8TMnOT+NvQwVEqVQy87/gWO0dBGiDo9k7D5fmIj6KqASNGpMScYaFwI8dL0j
         9Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755820872; x=1756425672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAIuwRnFRDmQrHJUcu6js+zMr5ZyX8Xb7y1nWZeeUIM=;
        b=WOWYM0oi34uPvekLd74g30Y7qnsGzNBh6tOPkG2k1qDmQ0K8MQsGx4iFTcTdxG6ivW
         s5nsIdO3GAtZsVlt5wOJwMAjotzksQyZiCdXZCSyoyapb2EpGRY6+s2UbdTN9j1Yx2ew
         7qf6lLV4D9QoNPl/KafV7z/BkfC7hou8jfc88aK9f5F/ZVdxnT5m6BYVYH6x1EUwRLk0
         8iH+i4dDj57AzpNHDDaYPgqV65tplb34S+KMnxGZjRYruh1F5rmdg7wCMFtf4APfhbcd
         YNMWup9D1vNKlCYqhp5V9/fSd3vsf4IXk9Q9pHtpEp3am2g8RLn83KlRvqahpo27fjdD
         Wspg==
X-Forwarded-Encrypted: i=1; AJvYcCWvgV00PfI02UjStPL67p/GnOUHSh08Qj1aUcBD690i0D2Wg4z/iGvmEWXRsW9szK883DZ08tPgpeVavo/d@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3yn8iRDVX2J+JwBwx4/3PcpmWmeuGvgNXIOm2+L4pX0g5f+H
	Svqp3AQ0B++IWUWxwiXroNIaXqJGLohBmpqENU0Sb/GnDC5lH4BZsSkBXafx1IxoslZSjZLKvOE
	hX8lH7LpJGfQ96zcqAKmLmF+ppDrpZXg=
X-Gm-Gg: ASbGncs8aF3hSjLnoH1jZyyN6vWlQYESwtTtRfXH4x5SbhL36Q4WATBoQvUzL/NeLnQ
	XvZHyjUJMHRrB5tl1v52o3SCq2r896pDBXfSIxVRUl3ayh8x79JQZkfLxS7o8Akc5j7HtvLTFQE
	to35KIZB+3MRzO5/2pOwsf6Dk3cZssAA5/GG79iP1bW0036YhSK4GYfPQtF4xK1U3neQYxNpUm2
	x4iYurr
X-Google-Smtp-Source: AGHT+IFV44IIzr206VNfIK7/mDKwLn7vOZwP5IhOTNEmSWyL51IYhoz/qX+NTTvrso8RF/CzKyMHsWR8CiKS0Iot8Pw=
X-Received: by 2002:a05:622a:453:b0:4b0:6d53:a0fc with SMTP id
 d75a77b69052e-4b2aaa55de5mr16730811cf.7.1755820872290; Thu, 21 Aug 2025
 17:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs> <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 21 Aug 2025 17:01:01 -0700
X-Gm-Features: Ac12FXzeWJuZtbKj72un5kQsnbXHnZkXCAmcMnJYK70B5hDJiKGBSSPGy_iSdkQ
Message-ID: <CAJnrk1bOE3g_wtBtYhGBGPL_sDXPZgAwo6pgVOhadFoPuDeHZQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:51=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Actually copy the attributes/attributes_mask from userspace.

This makes sense to me.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h |    4 ++++
>  fs/fuse/dir.c    |    4 ++++
>  fs/fuse/inode.c  |    3 +++
>  3 files changed, 11 insertions(+)
>

