Return-Path: <linux-fsdevel+bounces-42333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD9A40684
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 10:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5949619C6924
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30972066FE;
	Sat, 22 Feb 2025 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9y8gvgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00441FF7BE;
	Sat, 22 Feb 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740214934; cv=none; b=JOdek9+ihbcdiRozghY0KLSg8dbmmBu/D4V1ZxJzz9yOng1ehP2qBZde+hiVVT/umMLGUMTn10Yw7cpzRooDKOYMl4KXDx83Z+sr6EZcetbcieA/tGW3iEFEKa4+zbtLCcpCdmlW+u4fOCpKj6W5kp2kHz7VmUT4asfcRE0d2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740214934; c=relaxed/simple;
	bh=U1Y3QCiccIy2Bc3YWo1Ckf9aCUTnMXxllH24aDN4AeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZaIlbiENF4pduC2QMaYLlpX5soNZqAicmhw4TlXCYnduu+kKr5ljhX9I3ee8UQmuYVBaryVIn/OVofNKtcdEVTmxLS9g/Tcqi2uQ+2/eTaN3cj+KQcicRwWqoboI9kp4zEAClCSVOtKO9tLV+Ra1MgTemmSu0bo56XcKOSrW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9y8gvgU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43989226283so19596695e9.1;
        Sat, 22 Feb 2025 01:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740214931; x=1740819731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc4Exa6FAddDAbtlvd2fqBlbQffGYT9nB3xGilwSryg=;
        b=h9y8gvgUf9rCExtFzbsT4oCOQzLS11DhZRC5NjgFaaj/pkdGgBBPpLnvAJhBqE0hyF
         aCJTtq1fqfTLsFhL/tCN3I/+tTHkwdMCLj8FngqWsZihka8xkn+9fxxQgasydMLPA8Za
         1HsDwuUTQ397twuBN0iv9M6UOrGatUMVKAXYqJNn0EE3zYxpdXAaXlNiSMBjUhwU8U2h
         p3/ZlCvxPKpdCK/iTpHC6ihAu9XhRVjxYjf4c3+3JJkalpnn7iaE8T8K/SSAf6RH6v1U
         OuN+HRhnsU65mZRLF9+4E4vC5Wg0rrF3Ae9seXvDcr6QB63wnDWt7ntCnNHSUTU4178D
         XWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740214931; x=1740819731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cc4Exa6FAddDAbtlvd2fqBlbQffGYT9nB3xGilwSryg=;
        b=aJn/UacoeKU4q/knOeKaybU4dkC/GUDfDgo1ZQcFNqKda4Yyz/y4OHmi+g91JVSGLp
         PVoOyBaqez2GCv8OzfDolLHcUSMuqKufkWHOdcT2yl47SNQr29Wp8JRrJBTkRMtSE8mS
         wCzxuM/pP+T+aNfMpK7nLvFKArr5jWLBjWm4frpeXje2egHU4e+LxS9qlX4J0Lo+ActU
         1SETn+Et+MKDh6XUJariyrElT4s+9pI6Zjh6/JTmLA131MSB1qjrqrWfjWlufrMXffIo
         gcZwfc8HjoSAFQuvH66TmuVdPOxzTH/rFxhiBUyzLNDD053z8CpgR/z3YmW56HhQG56k
         /Y7A==
X-Forwarded-Encrypted: i=1; AJvYcCV7DhCtYi2Z+yejK/ZXRZsBvbwaObCpYxs9Of1mLwm3noDP53Ag0Vec67P8NA/Bs/kVmtQu4DzohRnrF9+zOJccf8PB@vger.kernel.org, AJvYcCVYGer2JM2iREc8ZOHKWbU8bxiQlX+QVZTVbKAAh/NVbIwRcpK2WWl01fOD+iEY1eBBFn6SRBu2e5tg6X/V@vger.kernel.org, AJvYcCWm1qRl+8DXhbDGkOGfb6WG/IlrIXDXgbpModUFOnV2nRUaU7ikSQp+BimwL3MhrMW4oVRXf8Y3NtXj6ugsvw==@vger.kernel.org, AJvYcCXDkCBK2EqTF3vCWyEHDKSVCNOJ294RxUGQuh8LpQktc/qWQPkLD8eAPRyQu5ZRUoW4UmV/0O8+wac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrczsJFnXZNQEsXhS5zo+AN8ZwmRIHJRahaR6QCnAxiHwr3U8e
	/+PfEU1Xgch88KrGVwME+/95g8099fq24uY9NU2fwvReVWCa3MZA
X-Gm-Gg: ASbGnctw4jPd5iSkHx//pbeSOtw5iO0T80+A2uOQz7tCFCMNWmci8CJV49GcMN0l9FN
	Yrs7GxI/kBngyfsSo43YZZ/2K8AcRxDngkH0i/vLWJBJe7iDqtD75Tyq658AFGhn9re8mH0bBld
	jGDy+nl8gt5nbgz+HaRhWhN/CNJu5eEohtNFNVBCbI/4wf19Kdz5dC9vb3CaTAtbqT5v3/HxpVb
	IMwYALrZAiypXSS+m1Y8zmQr2q+BSmEPVdTHrpX9bRsZSq75apHXiI0KqPX0bBrCGsxMPkVZGF4
	azC2YtJ6sMOhAHIldPNCALAv1yLBW6BDiBQxzInFc90c+O7208cXxPzs00EmVQFB
X-Google-Smtp-Source: AGHT+IGgwQsHaCz1wE9iK2C5QOgZJkgw5pU/qb/Udfdou4Zdzj7nBzMomCJ1PT4g6dRXg8sa3K1YLg==
X-Received: by 2002:a05:600c:4fd3:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-439ae21cdfcmr52749815e9.19.1740214930566;
        Sat, 22 Feb 2025 01:02:10 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d6837sm40159295e9.13.2025.02.22.01.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 01:02:09 -0800 (PST)
Date: Sat, 22 Feb 2025 09:02:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>, Christian Brauner
 <brauner@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/2] pid: Optional first-fit pid allocation
Message-ID: <20250222090208.2b7aa864@pumpkin>
In-Reply-To: <20250221161854.8ea0dd0b2da05d38574cefc4@linux-foundation.org>
References: <20250221170249.890014-1-mkoutny@suse.com>
	<20250221170249.890014-3-mkoutny@suse.com>
	<20250221161854.8ea0dd0b2da05d38574cefc4@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 16:18:54 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 21 Feb 2025 18:02:49 +0100 Michal Koutn=C3=BD <mkoutny@suse.com> =
wrote:
>=20
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -1043,6 +1043,8 @@ The last pid allocated in the current (the one ta=
sk using this sysctl
> >  lives in) pid namespace. When selecting a pid for a next task on fork
> >  kernel tries to allocate a number starting from this one.
> > =20
> > +When set to -1, first-fit pid numbering is used instead of the next-fi=
t.
> > + =20
>=20
> This seems thin.  Is there more we can tell our users?  What are the
> visible effects of this?  What are the benefits?  Why would they want
> to turn it on?
>=20
> I mean, there are veritable paragraphs in the changelogs, but just a
> single line in the user-facing docs.  Seems there could be more...

It also seems a good way of being able to predict the next pid and
doing all the 'nasty' things that allows because there is no guard
time on pid reuse.

Both first-fit and next-fit have the same issue.
Picking a random pid is better.

Or pick the pid after finding an empty slot in the 'hash' table.
Then you guarantee O(1) lookup and can easily stop pids being reused
quickly.

	David

