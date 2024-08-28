Return-Path: <linux-fsdevel+bounces-27555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B625096256E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84C81C2174C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4AF16BE29;
	Wed, 28 Aug 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0KrvSvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBF0537F5
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842939; cv=none; b=hLu2wFreFYJiGdO43JNmQ3rZh2BqKIcw5xQvhY6+o6sROXHh7aXxdRBImvsrkCa160kb7v28w0im9gazP3Appj+MfJKqpNwuDOY0W4r9c3kuwx865/lnDgW53mfxlijhNEGb+Gz4n2UDTEMLWUivZ0gelf8PNiyC6ulEFMbJFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842939; c=relaxed/simple;
	bh=oC40dDaCHkTS72c+DC2OxD+YIlXdBb46QF3ohLunLS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saksLPP3gF+YUx38xGSvhbqkuhsUd9CsqITOF/niTLvUDQ4NRda3AmZ+HtdfYq4UhcrAnKnG+AOkWCc0/W9zgLcjhmC5BV+UtrMV+2ywJUQaiFld69YkazA8VBMQP3aXCocoW0Clm93Bp6eWER/OI02a7SlhMXoR1/HPC/9S5fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0KrvSvO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7bb75419123so4175192a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724842937; x=1725447737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMQUho8c873CgcndsYLNW0w29zjZ6+0m3FnwgA4bMBo=;
        b=L0KrvSvOa5AAQ4uwoGpNPxZ3cRN0ebbUzgvcXi5q4ZCa7QqwIZkQgqIh16MLANRUrC
         9zJMBlc9lFMgY0le8cEpipHNZijc9pVhjOAqH3aHTky9SlqqD6lR1RuKqf2cZRCzvJXg
         hPedsi6dcMEOi59OLvHnFH1AdyuFWgd4fCRG3GNaHry3WotxjfAXS/UwQreav4lJDcrd
         Tf+bf3KP1MkN1oXPvVWsw3dR/P2pkORL1lCD9EB2F/cn6VTCbUR2iK280OxUepRdxEyH
         coB/+e54wnq5eoIHdiCP2p2dhgiQ5UmHKyhEJG1EkkA9QxHaBmowri2Xq7z/Gj3AlSi7
         BoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724842937; x=1725447737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMQUho8c873CgcndsYLNW0w29zjZ6+0m3FnwgA4bMBo=;
        b=Ku3ePtEPNVSMi87qFHQjK/iccBgArMa749aBFwy7uBI18d4MbO7m0eyORP2V/KpWZ5
         usNJ96zxL9WA4AUNBGB7EuB68w8kq/jMbO8n6HOwjc+NNEWnU2u3U8rfJyNzIEmUKgCm
         YA9dvnADPXk0VhBMCuzGGnvT96sn8jQzwVSk3WgOyrlxnRN/yhsqyVeGI1o82Whry9rV
         2TOBNCXtD08LdH1l4/gz/wHhVqPGnH1+0ydBh5CBiVYamZ+UbpSxCB9xpvk8rGDm8vqa
         gFywI4k5ffUKIrn7LnWvIM4RCTBhfdZxZ+nnKt/r6T0cCJxbnu/qiTpPHEOuDeKMe1GT
         D5Dw==
X-Gm-Message-State: AOJu0YxCxKezZnGzUR8TqsRP3VCDAnl9IrP3fHFOBsBKdJLhtT1QIMFQ
	Ce5pZMk5t1bMKKNLyb6M6endoJSdkMsPzh1harpFZSCkFNsOkM0PCmfdaU0Ji7oO3uO20uOlHRH
	w2qVIzVcvtTWubJT7HfBH1+TO9Gi3MyNv
X-Google-Smtp-Source: AGHT+IH6gt0gp8T8nyj1DHO0h1bXpnrt/MPDM1P6UlZfru4gYFNSMbQw/fhUD3sPhpOmYN2P3OWMfiT6fP/d9jke6Rs=
X-Received: by 2002:a17:90b:38d1:b0:2d3:bb9b:ce64 with SMTP id
 98e67ed59e1d1-2d646d0c4e2mr15526395a91.30.1724842937159; Wed, 28 Aug 2024
 04:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
 <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com>
 <CAOw_e7YnJwTioM-98CoXWf7AOmTcY29Jgtqz4uTGQFQgY+b1kg@mail.gmail.com>
 <CAOQ4uxhApT09b45snk=ssgrfUU4UOimRH+3xTeA5FJyX6qL07w@mail.gmail.com>
 <CAOw_e7axjatL=dwd2HAVcgC4j8_6A393kBj7kL_VHPUKfZJaqg@mail.gmail.com> <CAOQ4uxgFbBCRLFM4QdQYK3xESMixWqxtC1Q9Hk4p=bjWeWk1ZQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgFbBCRLFM4QdQYK3xESMixWqxtC1Q9Hk4p=bjWeWk1ZQ@mail.gmail.com>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 28 Aug 2024 13:02:05 +0200
Message-ID: <CAOw_e7YD6f4aOAr6cuOGQOzhPtOwsNWv7-CqTE1iaF8qq-eR4w@mail.gmail.com>
Subject: Re: FUSE passthrough: fd lifetime?
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:48=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:

> > Similarly, it looks like the first backing ID is usually 1. Is it
> > guaranteed that 0 is never a valid backing ID? I am not sure, and it
> > would certainly help implementation on my side.
>
> No guarantee.
> There was some suggestion about special use for value 0,
> but I don't remember what it was right now.

In a file system, not all inodes are backed by a file. If 0 would not
be handed out as an ID, then backing ID=3D0 could mean: this node is not
backed by a file (and doesn't need to unregister the ID on
forget/release). If 0 is a valid ID, I either have to add another
boolean to the inode, or keep calling the ioctl until I get a non-zero
value.

Reading, the code, the call is

        id =3D idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATOMI=
C);

ie. start=3D1. In other words, if the counter wraps, it will start at 1
again, and 0 is not handed out.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen

