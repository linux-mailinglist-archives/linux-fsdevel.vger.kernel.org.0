Return-Path: <linux-fsdevel+bounces-73749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E398BD1F829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67F8030101E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B52523504B;
	Wed, 14 Jan 2026 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qzms4aOJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588B2BFC85
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401490; cv=none; b=YpTXSPcGVJRDAAQSBW7aFsxb9Vv6as+f+t5yxxifP5M2yF98nprm1TFhmIryReHyasP5cBg1by9IYhESPAj34DMusUYwpqt/F0lJWdFy8lQt89Z3aXc++XexM4B5uuqEdJJRUfDFnsdtCi4unMJO0DtUI+3OzomH5G0fjGBBKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401490; c=relaxed/simple;
	bh=N3NyuhV/JvPd1pHoHeJFTXaQ8/5D703ByX/j56nM+a8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Lzt+8qNzprICCYIfrvTLXAyV2LmyZCeEh3ITsDLevx1fxTYlJt9+X6/rAjr/lQLo3+z8pjYmDpR3j9sPpStqnQy1xvsB/2//eFl82cMOgZDaVE0IEzsqqdVcpNpFNvo6BDcm0J2FXYq7a1aInb2v/IW4SzeBo67vUlQMfhkmyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qzms4aOJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so65990375e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 06:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768401487; x=1769006287; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXuxpCB+C200gDac6NFfMYpeaCyypHjDHET7hpKl7Hg=;
        b=Qzms4aOJvGHAbLMHemv7yyyamV55sBWHx4NSCriVXopiHUy/FJ+W65GPyRlh2niZYl
         NT6RzscwZv2aoDSW4jHXMv+AkFjuFK0WCs+ESv001erBoXPVqtW0Qgvj/Gx5WxXfVY0/
         CH1Xi/JVsHVxZNUd29C44edqU9DBfSi2npXYW73TURjUhceYLc2GV7BA1WrKRBNnybOe
         6wkBug1N4r6tIfAmDpgRtpdNE3plSTnOXYmGWclNkP4bjg80alwTyMXKUTLXOYbOV3v1
         hEyja2X88zkNvAMPtbdsGGeVg0DN8RYmxMOTpBObybcWHr+R7lLSt7VwBb2ODoGbcSNs
         uARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768401487; x=1769006287;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXuxpCB+C200gDac6NFfMYpeaCyypHjDHET7hpKl7Hg=;
        b=tlzE9LzQzZC/xSbCiL28YLKKpjGfkKkIx3icVQuTOD0J+sSwIM4OH/lByWKef3EV3/
         7lJUEdCX007YkC21TRlVB1ejMQbEcv0Tw+LUJ0ejIOUn3O08xvgIHUb/dhjqsvAFxyYH
         kEOVv8JTCb0tMuI5/FR/YTc4RgYE0zppZw3v5fdwhCUsKEIdWKpGEhVtfZz/8OaHaHne
         t3dGDXzC2q5aqVfuncTfL+FePy+Z39EtsfiPdQIKpn1AiDRw0rF6QOtouZudfLcJvHpd
         C1uU9+LMK3fp0dv9N0PkzozhCYw+UfQNYwGbdbbfZZKL5Rb5oZ2Q9OrRI1woKPyDcX0w
         J9OA==
X-Forwarded-Encrypted: i=1; AJvYcCWb/fuxdjFczM73dMzKFX+VFFvDaD1NIsL4fQCqNbB5odr0Lw9OZDzodMeW/YIoH8Y6T2TLcY9jvadymS6M@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+MyhWfaXUHkm11Kqu/Og1ijMNwgttj2bk5Mf8kQg3UTrQ4rS
	oZPD6u1BrtzBXIzmEFg5h5Ch6z1KZlKNA0753opZvaEBTad1+kcvlFMVK/NLaK6mBqZekcGD6ej
	zsfdq+gE=
X-Gm-Gg: AY/fxX41tceXJyWb4kPhs7fmH5ciTfPQK0Xn6UwDYOJlAQnbtGPjDcwa0/Zilz1PXpO
	YZgTlIgewOxrI8+POO+9j/9Em+60gFbwgWmPXuck/oY7fqzhvd37lLf7/TOedP7CMBEtD1KYiI6
	K3K1rj7HVGEBIROlQelwDCjSkKMItbrWVFbI3EBPptOhPEnX7Zcdn2mi+gNEdcoGqdEn/zNu9vC
	GANT+fsjDTuGX6S3hkm2XSvwnI0C3XnK8iuSH+PxN8bZdcf6Ts5N180JJ04tnb7daxgooxstVau
	8GCDWKQcktzQ/IHcq2wwRhzDbG+KLOg26OKQ/rsk8+BJunT2ZksfQYc5ViiR+kEFU7U/9GKe+YS
	I6SjPRKvHAF+9NOiLctulkbBPUyptUMsS2O6p8q+UyEWTieeT2FyPzxsCzKbXTe/KmDDETkXa7d
	0NH6rN4UYaee39pKafg2PrjqlirrPv29yt6oZQAxhzKj2zG3eIBlI8xXWLNBw9omFBMtHGDDvUe
	akV
X-Received: by 2002:a05:600d:17:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-47ee8de7443mr9820425e9.22.1768401486562;
        Wed, 14 Jan 2026 06:38:06 -0800 (PST)
Received: from localhost (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de. [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee2a5e48asm20271865e9.20.2026.01.14.06.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 06:38:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jan 2026 15:38:05 +0100
Message-Id: <DFOE0BC22OI4.1TO4CKB63W9M0@suse.com>
Cc: <ltp@lists.linux.it>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [LTP] [PATCH] lack of ENAMETOOLONG testcases for pathnames
 longer than PATH_MAX
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Al Viro" <viro@zeniv.linux.org.uk>
X-Mailer: aerc 0.18.2
References: <20260113194936.GQ3634291@ZenIV>
 <DFO6AXBPYYE4.2BD108FK6ACXE@suse.com> <20260114143021.GU3634291@ZenIV>
In-Reply-To: <20260114143021.GU3634291@ZenIV>

>
> Er...  Intent was to verify two things: that anything longer than PATH_MA=
X triggers
> ENAMETOOLONG, but anything up to PATH_MAX does not.  Having a pathname of=
 exactly
> 4095 '/' (or interleaved . and / in the same amount, etc.) be rejected wi=
th ENAMETOOLONG
> is just as much of a failure as not triggering ENAMETOOLONG on anything l=
onger...

In this case we need a new test verifying that PATH_MAX is actually
handled well, as Cyril suggested. But in this test we should only
verifying errors.

>
> FWIW, I considered something like
> 	mkdir("subdirectory", 0700);
> concatenating enough copies of "subdirectory/../" to get just under PATH_=
MAX and appending
> "././././././././" to the end, so that truncation to PATH_MAX and to PATH=
_MAX-1 would
> both be otherwise valid paths; decided that it's better to keep it simple=
r - a pile of
> slashes is easier to produce and would resolve to a valid directory if no=
t for the
> total length restrictions.

It's up to you how you create the string that will trigger the error.
Also, you probably need to take a look at tst_test.needs_tmpdir.

--=20
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


