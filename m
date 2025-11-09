Return-Path: <linux-fsdevel+bounces-67617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE452C447BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 22:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FECF3AB2F2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1D255E43;
	Sun,  9 Nov 2025 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OxWIsBJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D778F2B
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762723789; cv=none; b=oiQG+fYjmI8CEXVkNAlaeq4qJQEe5ybm93UzpB8hP1O/aNOD6R98JzXidDCCYaOLocwRLYf9CnBeRY+qeOYtT7Qgogx8PTZRPbIoSEbXwA1xu9QBfk5aIm78pdv9u8YY17kg4fVOGgPsSPr1iTsW5rHRqwjcGtdKzJJWu3TmmWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762723789; c=relaxed/simple;
	bh=JrigkIGSgV9JIr0Y27hJlw0LIABya4VUB00KUecvaio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfwRvFKHgPZs/Bh3S12+8wugz23Etzm5Q60gNZn2WXIhTRoPveYm2HqbFB42TJ67Nfi8JYpi+fRvNrVuP/kn04S3Y+sDXXzJvu1no7sRniArIUsmxD9CJgZQNsMeI3I5uh3TfbT4teJqqYvSFO1fyRQgbdxVT/r2mDtnUDyb7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OxWIsBJo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3439e1b6f72so198258a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 13:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762723787; x=1763328587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCpmNG4HaDD27+nahLSdV0GLwVqvHMVSI5yLttqUzTY=;
        b=OxWIsBJoHlvIzNzd6IBOGvRRz1c6QKTV/yvr2GLR+QUqgtJ9lKPa87KsZdupWerixO
         zVrvXaXpNv9HhdHCHEqmcaCqWaLVyy8+a/wYXhNlXxjBjbjAGr7s1IXDEuYILfM8FoiR
         DyiRINY5kpwHTiYKX9BX2RjG/Sf42BTQOpBIht6DFy/24wBr3LVkFIA58/zHODe58506
         w729xa9HYmR1XD6B+DI50BvgBlgNzNe6A2eW5eUWSlIr1EwVzak3aH1r8fp/XdtvJjqZ
         DJsjepZjcE+bekhrdPH60KmoR9/nylo1JSj0pIDaH+fFfKaEcs1NxA9ELandcxh/s6Xc
         jZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762723787; x=1763328587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lCpmNG4HaDD27+nahLSdV0GLwVqvHMVSI5yLttqUzTY=;
        b=m5z1Guw/q5YRMNDXLA95HzjpQbIT814L3743i5I9l9BY9ozwbsdA1ahGlM845boti6
         VtA7SAqSzs2T2pFxJsCdUBdiH9Rf/lFRUjRrpyecEv4V1lW3/GGJBvfqA3WymqtHMpvW
         z/QAkoVxZ3745IqVSjMTBOM8YCDpdyrB52vD1rcV8/iw265PL6LnJzTIfu6E0+e+LZn3
         TDH0jA5AUOeAR0K4IB1LKZeauX8hE5oyG/vhIiaGpTDWWg0CRBxrteim8vYak3FFdIRT
         0QdihxLTs4lDQW3TGWzwXjRsZPmVbRUOipoORGVduqPFjjUr+dYn7WXjvOrDalslmrwN
         LBMg==
X-Forwarded-Encrypted: i=1; AJvYcCUVyQcPkqpGO5sH7ZoEAjr3K8UupIkeyKz5jzSA7czDS6ihkwSxiZNAX1E0o1Q1ccoaASBwJm1x+q5Dy9Dd@vger.kernel.org
X-Gm-Message-State: AOJu0YzWHapQQaP9P76aOfk83K31ryDSNygmrK3OAIXEBxZr2VcRLF5L
	ythZV1BGsJeE0zAuCn41gA0SadqxSBYqeqPgcji6cO4jdwNgVRZKZt0AEXwyhdQl3h5m+gV4rra
	z/c3/MMde8XFuXW8wvUbZiHHZ07Fypr6Hcl1ZB+g4
X-Gm-Gg: ASbGncv174UJKxAS66j0CSXUSl3y6gLcSpVqt/ICIcBkn68lz5Bu1gP8IlgWRCDRFDw
	gm7OwmfM/FSiZbkKFTEABpiD7ltinSVbHkE9Y1xMigawgQo0EzQWwb4CTmebaUP8fdfZ3+urpFA
	JSLU9WW/xayPA7kDSBniZ+3cWpb8GLBlBVl1sqdw9w9cd1P8xV5FNCJGXQGoGtQd7vLbSqZ0ZRQ
	yHtag9J3jd+QP3VxIDa1d1sWjglT0vQ7/byARqevrhEsC6QxgZy2fXyohVCUhX/+JN265o=
X-Google-Smtp-Source: AGHT+IHQURL9arEF85Xkv8L1+bVtKSsyFyQE9v4YKONDepS09vRsAyNwdyCGR5zutC8ImL3+GPy9CjT7M/xiyteZdi4=
X-Received: by 2002:a17:90b:4c07:b0:341:abdc:8ea2 with SMTP id
 98e67ed59e1d1-3436cd0f053mr7880146a91.37.1762723787291; Sun, 09 Nov 2025
 13:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109192940.1334775-1-mjguzik@gmail.com>
In-Reply-To: <20251109192940.1334775-1-mjguzik@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 9 Nov 2025 16:29:35 -0500
X-Gm-Features: AWmQ_blvWeHspBMm4bMAdUMJG2fZcKCHI3qaL-nFDjha9t3_WwcCVdZIlbe5Ro8
Message-ID: <CAHC9VhRCvoXrUESCjbxz5Bcxjq8GXLj4GvSoXq+sukdP1cuXNg@mail.gmail.com>
Subject: Re: [PATCH] security: provide an inlined static branch for security_inode_permission()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: casey@schaufler-ca.com, keescook@chromium.org, song@kernel.org, 
	andrii@kernel.org, kpsingh@kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 2:29=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> The routine is executing for every path component during name resolution =
in
> vfs and shows up on the profile to the tune of 2% of CPU time in my
> tests.
>
> The only LSMs which install hoooks there are selinux and smack, meaning
> most installs don't have it and this ends up being a call to do nothing.

Unless you have a reputable survey or analysis to back up claims like
this, please refrain from making comments like these in commit
messages.  I can't speak to Smack's adoption numbers, but last I
looked in 2023, and considering only Android since numbers were easy
to source, SELinux was deployed in enforcing mode on over 3 billion
systems.  Of course I don't have numbers handy for *all* Linux
systems, and there are some numbers that simply are never going to be
public, but given the +3 billion Android systems alone, I think there
is a very real likelihood that there are more systems running SELinux
than those that are not.

> While perhaps a more generic mechanism covering all hoooks would be
> preferred, I implemented a bare minimum version which gets out of the
> way for my needs.

I'd much rather see a generalized solution than hacks for a small
number of hooks.

--=20
paul-moore.com

