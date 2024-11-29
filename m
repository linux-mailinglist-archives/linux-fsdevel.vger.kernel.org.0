Return-Path: <linux-fsdevel+bounces-36164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17809DECCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 22:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0D1282125
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B173B1A302E;
	Fri, 29 Nov 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FZXadmU3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DEF19F40B
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732914408; cv=none; b=NmWvK04EkbVO71IlrGIafR7uIka8HCohQI6hD/VVfJB9BVUvFbnnRvCk6E3l7OooOQiaIRvYWKtjf3WIBN3FN6poWnsH3M9K/zdY2laXW8VbCRLL305w3+neLoe3d0KilAqpKAA0tbt1E+tLFnWivS443AItAs+nO2YoBFumEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732914408; c=relaxed/simple;
	bh=lzNRaVJaJp2dzBZ6WM1499zCj89Aa4u1k1tcAs2WbIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IM/r1/8p30D9XlgPKQvGd3+mvbE50zlPSdTO/cWaG9OZ+LOHilbRZ5k362lkFI5hyjeaH1Mzfrb7B8HxGLU8BcyerF14ur/hTEbyq0zgmyv3Kykrd2jkZHwBb8lDELrmYyiy274KUUXTdV0cza6y0ULwauSjp6eMAZUw7B89yTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FZXadmU3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9e44654ae3so264336766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 13:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732914403; x=1733519203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZSitS3zyNpA94USiEVzv1WV1TBBjL6Dz4RMgR2XZp8=;
        b=FZXadmU3N40Y82gMt1Fpsw79YyeGb9i3okfQTCzZaJtfQb206boSjDMq0l9WMBQati
         adC7avzFt2hpz4oW/HYt+UFXRNCJDyt0lMhNGBcv8+IiH/RP+jKMKisiIdZSL6zxPaev
         6r3HAKJGBHReLSi7c2C0w9WPOfCYV9TTvslort1oIVXeV+vZ1x3NyCTlO52iL9/6qHwP
         cmpGzxqVs1sQOkX+GysBceGzhmWC9FSbOpXnMjLpWQ2H2WYTeQi9HgBBykJ6/zV57hxn
         QJAzJ5YK5lmFDrCh1yWK48lZbxuP9YJJmP9HS7YdkE9DBhugl9ezbX7tAwoGjNjD74Iq
         5RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732914403; x=1733519203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZSitS3zyNpA94USiEVzv1WV1TBBjL6Dz4RMgR2XZp8=;
        b=j5BgqtvfWlZ/PN8J37oQ5R7mucbzBi/jdtEOQAzJNK1escqNAUQ7vtG7MHW8u99QmC
         vDtPLNvSDYMsre+zRrDYCy2VwfFrLA/MUs398Tj0+n+Sb5L9ffnaIHWSe2c4p+wGs0bB
         Q39P9n/oe5BoL5QYOsox1tjcUn6wXmOispr2gjTx1AdojnqeY4MtVyHZTTsf6XTcbRlW
         gQgKByCQMAicjmgTwMmhosNbUTuRC0RMUxbWKrrirVm2xUOUcxgE0sJGezz6X9qr+wZr
         7wAAPJ4ptp9LEVnO6AmZx6Mrsm7GG2X6y3Hv+q2yobAXotqU7bfo0QzR9l1GOcaE2UP1
         BNuw==
X-Forwarded-Encrypted: i=1; AJvYcCVBmWoWoy6Ix530aTi9Az7L/o1RXX2tAvqTNQFc0SNmEefKV7M5NkxjkjMMS2Q1dHi/gWbrjlCMkaBTHurj@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJt3h/6ywslTUsjjlKzKk3fFmm1c6wqSp+iSE2lBWmCF7mwMf
	SOQqCSEabtmeEYc8N0IxE843RarRd4EqVyb2N7vVN1ZrQnFPDjdB2SEE97Qm/KiPdGYXrSvMeXB
	1LSHJv1v3ZeHcihXzIijTaUrPr9fBB1QhqCVcdA==
X-Gm-Gg: ASbGncuLG4LWUjZHT4dyKc8eArT9AqXK4qs9NJ/vXY/IfEYNhMVuQIAYa3Sxn1KTWd5
	9r8bGeeZ2fRQdVn7fQ0URtdivEeqzkx9cwrtDB7OeFgXIKSK3h6OjekJu81AO
X-Google-Smtp-Source: AGHT+IFFQ1ppSleB+5O9jB2zUGGpHTd8sboY4WGdSMJOjNUHLd8vEIxJUbqGBGpA5TJKSfoSypAwnC12VceTC1y4Xjs=
X-Received: by 2002:a17:906:18a1:b0:aa5:48b1:d282 with SMTP id
 a640c23a62f3a-aa58103dde1mr877608766b.37.1732914402947; Fri, 29 Nov 2024
 13:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk>
In-Reply-To: <3990750.1732884087@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 29 Nov 2024 22:06:31 +0100
Message-ID: <CAKPOu+8dBuoCLBAbge+TFCOz4Rtyo2Vx_PbXai+BO19HX-9S+A@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 1:41=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Could you try:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dnetfs-writeback
>
> I think the patches there should fix it.

Confirmed. I have merged this branch on top of 6.12.1, and the problem
no longer occurs. Thanks!

