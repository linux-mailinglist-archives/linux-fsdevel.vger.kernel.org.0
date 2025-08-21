Return-Path: <linux-fsdevel+bounces-58635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 823DEB302F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 21:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5427B406C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1642EA720;
	Thu, 21 Aug 2025 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LVbo7EzD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD82C21E8
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804792; cv=none; b=AgiFJkRWXwjzm1tBGZ7jR7jrju3elQDGTCOaUAhUuL/wqXSOqhOOrkhLeSNn9/jaL2lfdHCfL4z80Tb+4rXkBkympBfvWazkGjB5eFx4lWXRMBnnIX1k5XNqQnfPTtbVAwy36lsiWmr2UOfxOz/fdv+HpvtPsaE1HvTE0OymdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804792; c=relaxed/simple;
	bh=FNKdQ2Q9j36mgXRTTKI7GXB4mhjWXXIWbw7majwblus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeqYBbQ6M3EC9ac6RTIYPArRvr3zL3AUf4ctqsJS+sSKKjrDbU2K2w0O7zoMKWjByjdrsQ1tV70GRZ9cQhDMMgceo6toCvAdC8WTRdHdlI8sy6Ej9LQiUTGwjaYg1m98PulLeBSthN2XF1SbcLtabkYzEZ2Z5nfkMmpes3sCcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LVbo7EzD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326e71c31so1109025a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 12:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755804789; x=1756409589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpJ1JUIhWo3zxoVLim9BIZbHFtWsNpYjF3/W08jmiX8=;
        b=LVbo7EzDlmxLzkUHkEkta7XVamX764NCABUuYBQJrJMzTZn00cA8KYPydNuasEiMs9
         wDe2u8m24gK0hDSO1mjYTKNARMYFR98rQiqWgAqT8VJn5uNVK9/Lg2CHDHrrwIjPdTiK
         NkMkbQIHOgMH3M0Iw+yNn25j1EXJg5bSU6MchRiLmBBYyqpSmjrr7AT9U4k354PEsyOx
         u5zK70PX2trYw1JFkqjSMx/naqD4fI7o4B33p55HDWoC+B7Q3rJ/tK3a1ze9mUqODZN2
         qjLXPIDyrjYc/zg6frHm76P0nWuOuyYM59Uinvj/smGCJNDHN5g7XPiMVS7/J2oa2twm
         JDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755804789; x=1756409589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpJ1JUIhWo3zxoVLim9BIZbHFtWsNpYjF3/W08jmiX8=;
        b=FZqDOO7De9rvvcDGWUIAiNin+ToqZVNhvX/Oc/SQt8BGWO0ggS/8ZNVydprryrX2J4
         XFKWlNKR5Y8h5JVtDOszNbbb72AiBDmX6522NQvW32SLmmXFlX9pL5OIPJIa73IPMtAH
         w6rUqTY6jkhx91ISNlvKTEpwtuDAziM2GIDQBtXSq9G5zdPv4VKbC+Q02SfKzkjk7lKW
         UGwQlu811KDf4jBvddruZ4UkEn2FVHPJPd/j6DjW6LpJ6gPBIk6I9y/nKWklNs9YNeqE
         1GiEWBJ/trrfcQCaBVqqsZ+TW6grOP/8+Yczv9NJ6eZfclRgbzz728xmwF9E3g5Bbqew
         OEFw==
X-Forwarded-Encrypted: i=1; AJvYcCWVq5J1Y8qquu8tS5UtG0L/bGYfm44v7wua0PvYS5mYWQCRaDX3g4koEhKXIkYn8cbkjE6gw5RIZSd/ITOD@vger.kernel.org
X-Gm-Message-State: AOJu0YyyrecUUtb7Ya3Z7ABtYEcFaJaShq1WNYIv0mxbl3l2rKbIK9PA
	Cfh0D0iTwIh6CY5lj8rHNzHvtQg4lgouoAQHT/zy1gqHl7FS1/B89tA1bVjUoZXAKNke2t02AgZ
	IWnhKUOWg56pj8oCu3fiALhG+1UR5AIvUPjbo92rb
X-Gm-Gg: ASbGncsR8jyRrHa9Rt0C2GcbitArhS6z6YqnVuu+szU8rFwoKF2zb/TGh3XIHO277LM
	cqf+olv8LS1f+/NaXWMPkmMvwS7b2T1gqff6xTtdSbGtTQStWtUpW28RBb1n3zhmmjOlqy2Ecap
	MOHxpPoN0eUimxbzGbgHArZn4UkMW1M4jhqikXUI52hTEbP50NWpCcKSwww8kkgKT1EFlnec92t
	7u8VnBTYupFwxkfGw==
X-Google-Smtp-Source: AGHT+IE3rSz/S9joHsxzgn3nqrAjaVgh+JNeXVJWaeHVu8UKpssEwvNF8sTjGNJifciDTputJMBgY0zCaDMpzHhVtr0=
X-Received: by 2002:a17:90b:2752:b0:325:1548:f0f with SMTP id
 98e67ed59e1d1-32515ee0104mr777322a91.14.1755804788711; Thu, 21 Aug 2025
 12:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
 <20250821122750.66a2b101@gandalf.local.home>
In-Reply-To: <20250821122750.66a2b101@gandalf.local.home>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 Aug 2025 15:32:56 -0400
X-Gm-Features: Ac12FXyBGe0rSMh1OHfkwA4myJIJvSYM_gON_hNIj_jpU_PMzU1SrEYwDaM3olM
Message-ID: <CAHC9VhRoFb0xmmfzqqMhHqABLnnP0vCiPJHiVgLPbrVzi6djDw@mail.gmail.com>
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
To: Steven Rostedt <rostedt@goodmis.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 12:35=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> Perhaps we should have a maintainer mentorship program. I try to work wit=
h
> others to help them become a new maintainer. I was doing that with Daniel
> Bristot, and I've done it for Masami Hiramatsu and I'm currently helping
> others to become maintainers for the trace and verification tooling.

I realize this wasn't the original focus of James' mail, my apologies
for continuing on the tangent, but I do think some form of a
maintainer/reviewer/developer/etc. mentorship program is a good idea.
Like Steven, and surely many others (staging tree?), I've done similar
things in the security space, and even in the most informal
arrangements I believe it has helped people get up to speed with our
somewhat unusual development practices and not-always-documented
processes.

I would expect the program to be fairly informal, especially at first,
with perhaps an hour every week or two where an existing maintainer
could work with a mentee off-list to answer questions, explain
process, code, or anything else relevant to kernel
development/maintenance.  Time zones would be a challenge for any
interactive discussions, but that's a common problem for community
development these days, and finding ways to resolve that would be an
important part of the mentorship.

--
paul-moore.com

