Return-Path: <linux-fsdevel+bounces-49189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2877AB90FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 22:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038C0A224F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D4212FAA;
	Thu, 15 May 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnFiUSRC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FFA20CCE4
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342408; cv=none; b=eaz9ZnzgueSrp7CLu8HgxN3ilP9d4mfy5uvnWpQWfZjEbHXXIimM036UcB8v15CFzyU3z6F75zj/1a07I5aI7Nkl3jJWrzmMMzMTdkbwTTr1YvGhpxY6HZ/gV9lZo82aK8czs6X0WaDieReyVabPFaZe5a7QhNBdQ44eu1WppgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342408; c=relaxed/simple;
	bh=5pCpF9Yuf1UDcCT7gPAUn4Hq8S5VWiTUWysqi/yb1qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQO8Gl+sNxlo3UqlcfppwiQQHdkbRuK4AXCDP/Jbfa5pb1t+d0O/7Gbu4wGsuayC4cH+ULGayeZyk8PQ/LjyCflHCUz86z6lx1nUWZLptJ+GhS3FIWY5nCPYckuL2/GBmkDKuLlbBln4Le9fBC7YPngGd44FVQMjUFd4td7am7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BnFiUSRC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso3718a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342405; x=1747947205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XelpmONYxgP7Imej7bNl54Q5ZoJ+oGSV3jQG/SJkBZo=;
        b=BnFiUSRCRvvRZMXoGIYkUuFwpiqsKrXUzq8fsEGfa6gvNQYLYuJlA0RLDgaZ87PZPe
         vITFtBNAFvC2I52mLp2CgAnNgoYcyiNsa53fmIkU8v8E8D3xDRZRt1xHd3SH4To5Zyoc
         xOeNd3CRCdgr5QLOZ90W0+DWJ4nJ9BFbI3h1spiBY64QwePsmAj+egFzF5iz5Rt09FJW
         P6NaM/JGfwLjhw2+noFXIES7lf4bKrIXePl9PhzlgJH3szZyk2+M3Ur/yh05AdkZ/zYO
         GOcLsUz1kdpBWnOcf6pyOuXiqyZGcw+ZvaC0PFNjW542O1KgVPhM5dzbfBe0Xk22f+L2
         LwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342405; x=1747947205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XelpmONYxgP7Imej7bNl54Q5ZoJ+oGSV3jQG/SJkBZo=;
        b=T+GiPnPP7yQcVR0ezAhXu3eev3/cGlbkYoW77K0+5+D9xMJlkdenL2iZ0ayB8Im4GV
         aQjyTHS8uP9FS94+1LR15mLHwSnFmF0o0/UyLwPzF2q6TNrLz7qvNKVV2aIf1WGxEV6k
         HNrdPhet7Cq2XCW6n8ck8B59xbsAY0eHhY595DrtioUlOJX+eEKhpRFx05+IV7wpKG7Q
         jggpN56S8vvzRdlt8Er8/7h4yTY4m0kuQYkhYW2ySNlafKFCjfnrN7qD2pBswRQGgHq3
         ni9j9N/sO6kHU+ve1qLZhdeHqKDskBe40Q0r1o88CnPw7PMrq2D4uHO+j6D1DF+yh38h
         LsCg==
X-Gm-Message-State: AOJu0YzbgGHOffDHdxHitdU+E0wN8P0tfAsC0lGmqcTKSGiGinl96BEj
	TlQZSQJXFpQetO8TfoVWcVrz5r5Zu+hSjezj9SOjxpkReWQ1lpkpdLVc+Xw6JGnn4ekTvHvdSea
	3B92+G4fch/bjH5/tKXOv/MuL9PEb8VKxS089gq4D
X-Gm-Gg: ASbGncuTQgA0xvRS3zy9GxWzxztnTEuiSeRRJHo2kOYXOXZn9X76KiPYaRgmFaKfO0K
	OX9wJPKx++MyzugrVB+RbIPTq9Usut+I0nXY9yUISOb07tUJrj5lIG2l/f0p/3d0VH/7eDc/uLZ
	olANaoIxzVMcE9MTzTwBZvuGUwVre5aWNz0XRrBcRI0m4AkD1k64JrSF63mP74
X-Google-Smtp-Source: AGHT+IHx64/5SjhY+Jp5r3fxcLt1T6qGPXp7Dz58ni3OOjvq0pQ7aI+WX62/iPOT2F5jTxqlOw26E2gq565C77vsxBk=
X-Received: by 2002:aa7:c90e:0:b0:5fd:2041:88f7 with SMTP id
 4fb4d7f45d1cf-5ffc9596c22mr177267a12.2.1747342404819; Thu, 15 May 2025
 13:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-1-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-1-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:52:49 +0200
X-Gm-Features: AX0GCFvCVMOLsRj9rfpO6KSFIi8ldApceL7BotpEEnjFxLmdqfSd7_bhWTENjjU
Message-ID: <CAG48ez3zGnR1-mLTEkG+tO7mVy=yEWDqMGGe2tYkRHGXPfAjdA@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] coredump: massage format_corname()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:04=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> We're going to extend the coredump code in follow-up patches.
> Clean it up so we can do this more easily.

typo nit: format_corename() written wrong in patch title

> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

> @@ -384,12 +393,12 @@ static int format_corename(struct core_name *cn, st=
ruct coredump_params *cprm,
>          * If core_pattern does not include a %p (as is the default)
>          * and core_uses_pid is set, then .%pid will be appended to
>          * the filename. Do not do this for piped commands. */
> -       if (!ispipe && !pid_in_pattern && core_uses_pid) {
> +       if (!(cn->core_type =3D=3D COREDUMP_PIPE) && !pid_in_pattern && c=
ore_uses_pid) {

non-actionable note: "!(cn->core_type =3D=3D COREDUMP_PIPE)" can be
simplified to "cn->core_type !=3D COREDUMP_PIPE"; but patch 4 rewrites
this anyway, so no need to change this

