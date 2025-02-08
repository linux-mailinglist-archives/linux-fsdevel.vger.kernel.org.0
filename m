Return-Path: <linux-fsdevel+bounces-41287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A7A2D725
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808A0167100
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E95D259483;
	Sat,  8 Feb 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya+202k1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4D3BBF2;
	Sat,  8 Feb 2025 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031035; cv=none; b=gsbTOARGDhtDdKXISZLMg+ymMeHVOtXyXkZhkdaQ5N0r3tKU0sxaODuhBz4gYdeGkAe5CtbYHYz+tZ7CKzTjnYckO5gEtYm3ND7ScGrFwORJfMESObj+gLHJyDVwz4QSxkM41vW8XXl37ujKN6MN5NaVzhxzeJMLDcHhAF1E1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031035; c=relaxed/simple;
	bh=uxlOIXd790Ngz7+dljk+Ezn3RxiHllpYgaaLQVtMjAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pj1iFMEPF9BYxkxmTxF+Ufkhjxpws3ialKoQax7V4okAAdiuQYVl/gT5oSD8iIiXNdpechf9WZX/IhbRtfZAvVjJhk5KokuVgLqPAQhBuftr5f0VGZHUVXBmvbpcsiyxbEiwU1rc5vqYJzYvb8bQwOG2FFMcDvwrsAE8m06nbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya+202k1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de4d3bbc76so2690236a12.3;
        Sat, 08 Feb 2025 08:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739031032; x=1739635832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBLnxZ1ozA+XEB56sUiAJI57+VN5W/v/I+eHH6SLTIA=;
        b=Ya+202k1ZkJpVCE5fqRVUHcdObeEoZ+YfehGjLaDWq3amAMlC7/sZ4CJdMhHuHxeTC
         cm5mpnvUIZMdS8M4at55AW2lU9AztLI0CzhZzrysfV9UEyWdmwb/BTdsuGvDzDEgngVe
         q0BlgXh3lAJ0rQVwZPomeXaKPS2KpQj84RRi1TTPVfiaHKTMcD+N/biwgcX2YfOhhS3J
         PktA8WrBQ9Y/bbk6Mcm0zVjHeB9wqshxhASB6xWXHTHPnIL3zaLa+bo0zDo8wuGp7mhz
         YVZ03GZsLWIkB2ldWnRuoakMUH2D5frfoxcP4lmdtsSDoC2GTJEO8AX5lu8MMjckTs+G
         nARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739031032; x=1739635832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBLnxZ1ozA+XEB56sUiAJI57+VN5W/v/I+eHH6SLTIA=;
        b=KDpSWOU0abgzgmxec32wsUMoVv5XchBT2ogDGLpdgZNzdy9cykD3jNfrLeVX02va0Z
         ZvrnCFvHBZDjtheeI4QDplyx+yaLtCtpWVPx0EBbNXPrYvk7Tjh3hDpDNlPJsqcUgI3w
         mYrDPggRl+a/3QGuhJ01NxQ4Q94lDWe/RayuG4VCGRh0ZhOKIlPwdHaxzTOpUEYB1TrU
         HmEPmymAwbpye0rCbNqOSOarZrUAYOXsx5UM7anQm9/UVmEiwnPA9uMd2Ab0fdPHAJJd
         Yv/4Qkljx6Vl2rLcvpUO0d1iCijXSYpDB6fBac9JRDufRFq/t71mPPOaA/8BAic1YtrI
         XDDw==
X-Forwarded-Encrypted: i=1; AJvYcCVEjLJzwAPXFhsXi2/ltUnQOLMivUq/s/HR7toBAZ4b1OeDtt3LePW5JH5ikhiqKpBBHKQsKw8EK5KeKDMa@vger.kernel.org, AJvYcCXpBuJAatmMO0+FHdDS0eWbO+BIoNYDT1tyaG8UAQtXsoiZSWa994YWxRnrQnRXhXcvR+vLI/yTkVMjA5YA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfqz6XBAllpESZwkPEYDzuhrG8AfDG9ZnrssKIx+N5Bhtjtr9e
	XGiNjBAG3T2oqvx5osFDAY2dMX8THYGWAe++vVKXQciPDVZtVNLq6XDxnT72MOFSW7Jf2qb/kJX
	g04MaRvfHAAXc6lxvPtHnaiAjW5Y=
X-Gm-Gg: ASbGncs7vTaHCOr4Sn4siDNvrbLcbA4M0WvBC+df6t/GfgXTtAYNp13AEC5dTau1Bto
	nMFvNcZun7ABg+L/LrHobfGlnMWe7dXSF1yvTJf3Gdh3Z1Xa6KMa0S1h5gANn5sBRDzwgNi02
X-Google-Smtp-Source: AGHT+IEA0HttUCOzqc8xAKKQT0QnqL2yam2Yj2SWmDuLl/KFgQIuTiNuARThG44nINCFmfgAb/Bq+tFLGILGG+QGs1M=
X-Received: by 2002:a05:6402:1ec2:b0:5dc:cc90:a390 with SMTP id
 4fb4d7f45d1cf-5de4508fbebmr9195397a12.32.1739031031240; Sat, 08 Feb 2025
 08:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206170307.451403-1-mjguzik@gmail.com> <20250206170307.451403-2-mjguzik@gmail.com>
 <k5js2kdu3yufjjbypiwoy5abvmbnmr6ffkkybjs7sdvw4nwipf@za2flx7oe35i>
In-Reply-To: <k5js2kdu3yufjjbypiwoy5abvmbnmr6ffkkybjs7sdvw4nwipf@za2flx7oe35i>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 8 Feb 2025 17:10:17 +0100
X-Gm-Features: AWEUYZmsn-iAeOYL8p_GQlI7vwo3jNAEudR0vOfHUdEUQH9ZG715WPhxX8gck3I
Message-ID: <CAGudoHErwkiwdXHf51CZPYPxhPd8VNFocGFRFQZKJb=9knutgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] vfs: add initial support for CONFIG_VFS_DEBUG
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 2:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 06-02-25 18:03:05, Mateusz Guzik wrote:
> > Small collection of macros taken from mmdebug.h
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> For start this looks good! Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> BTW:
>
> > +/*
> > + * TODO: add a proper inode dumping routine, this is a stub to get deb=
ug off the ground
> > + */
> > +static inline void dump_inode(struct inode *inode, const char *reason)=
 {
> > +     pr_crit("%s failed for inode %px", reason, inode);
> > +}
>
> fs/inode.c:dump_mapping() already has quite a bit of what you'd want here
> so just refactoring dump_mapping() so it can be used in the new asserts
> would get you 90% there I'd think.
>

It looks rather underwhelming.

I was thinking about an equivalent of vn_printf like here:
https://cgit.freebsd.org/src/tree/sys/kern/vfs_subr.c#n4533

Dumps all fields, with spelled out flag names and so on. Also there is
a hook for fs-specific dump routine.

Very useful, but also quite a chore to fully implement and future-proof.
--=20
Mateusz Guzik <mjguzik gmail.com>

