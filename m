Return-Path: <linux-fsdevel+bounces-40962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09DFA29997
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FFC18836EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235531FECD1;
	Wed,  5 Feb 2025 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+vSd+lx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5F1FECCE;
	Wed,  5 Feb 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781843; cv=none; b=agk0KiPLMgV4V1RYdd6Xd8dBGcTTOwzW5mGSNXuWL1c9h0RrwHrgWB4G1i26Klf/poNO+QVnxxWIFRP9X3/eTUXg4Yw7ZF7oLmqSzCRCTuoQUuH2qhmH2zVkxupHNeOeGDULBxIgpNxFg+NQDkONwR3FT6y8vzyv6ClmMwg+BEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781843; c=relaxed/simple;
	bh=fdTwdio0b4ebS6keHPjdhFBc8ktdqJWjCMLL5s+h3pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEGUrz6hJO3LMi5jk1gjN007mrfXYZ9KsBzbTDGLkwPYc6shXm2C22WyH5uTWUZfKOOL2l1JswNFvCw9bRnodkn1XXJ6IzfvsrYEeYCeEZjl71c9RHpdRe02RD8MxU7B1kHzSlq3FMDSX5ZfQRv7rHNpbygylSKLOOqsdd4unbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+vSd+lx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dcea56d6e2so244408a12.1;
        Wed, 05 Feb 2025 10:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738781840; x=1739386640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhZbqJ2wPylfTmY4i5OgMuInRC9FcJ6ShJMGMKgKo+w=;
        b=P+vSd+lxE2Q/2CtP+jNuO70QH3/Xy57WqGNXZ8ADBlSrIc/Nokk23yAF+NrYYaRbT1
         5VsrDwGNfNAAGv3bgZ+nH9c/cZYMgxGWBvd81O5BQ5ujqzUrLxCkQHOxa6uUluVJGnNp
         LXGZQOOOHoIKtkNuwHpL5x6td9SGKfbYvAUJ85Rap6Mw1v392b/0nMldF3TZlDRtAkL/
         itOJTORDGXRAHSTZpYAu+K4Fns4Az+ZrwL98hrEtLTMNMkXuZ3DDHWOMW5qZK12mFxr7
         pwjXvTk20ZeMt4mDwfV2gw8qRMbm99ZE2rGX2znBnaR/UDCD/qhrvMuuya7M0VQ/gYSY
         KLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738781840; x=1739386640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhZbqJ2wPylfTmY4i5OgMuInRC9FcJ6ShJMGMKgKo+w=;
        b=hNARNoV5k+ZK0fyo8HUMGngETkh/6WHEFlCH80FW0ZHYldHaw46WOtt4ph5BALeSIu
         YIY3pqaO11CD5xOz1X5GO8Jt2sJCtH/nqBQG+Jw1V8AsN7t3evAldGYlUkD8frhUI1DS
         w96O7leXIDeziflj9sVshI8/lU4PXYLvcBHhKXBDIsZdP4SfK5N4iPPTEXZ6sxAGeSge
         5b45/LbaogrQ+bUTemPe/ifUN6uXsYWSUx7xWpssID0SvLavcFjLa+b8e0eRrB3Gv19c
         BlK8dy4Sk9JuKfysfBN4OyiJYa8IxS0Ht2hI03o7393LBQxMA5uf+ATaLD84Jts8KWJg
         JPxg==
X-Forwarded-Encrypted: i=1; AJvYcCUfJSQEvfsvLzWDxIycjl5SGYLN8ojRC+ua5PgW/8RcAMwUb2B4t93OUYGLkFsoceQHHyUTsuFi3VbZuKIU@vger.kernel.org, AJvYcCVCvWXwB/vo1o+7kBtsfret5tzhWmD573Et0m6AwBQLIunSvq+j/LlOeMKXokOCo7r6oydCFyopUAGTLLqe@vger.kernel.org
X-Gm-Message-State: AOJu0YxiNs0eyp3LONLG99LaW20szMDsfRbEoJ1wwJqXYUUu/QyGonmg
	qtoGLsFX7U+dCBIjaiCIjwiDE7MCjI2gre25IT1EI5Toa1z28KIbrEA1Lcrf4bivLfte6QYjgaG
	ji40RFqMkTAZMp1wKP3ZRuIOSVfQ=
X-Gm-Gg: ASbGncsSdxRVcB98A0SzNUy+nV5o/WHoPLbuO/7YPtFDUr49361NPOcCz/axjhH/uN/
	lpXcJrFnlC1l2n5ESrKlRVnpDfQnGPjG9/1IEAY9Kj+lewNCbv5GmiYL7zEExTuJc9OUjhkg=
X-Google-Smtp-Source: AGHT+IH36PYYvBhB8JMK/k6Q7QFaMq09avD/syrEYDCHPZXnJ4dC/e0kuVU+ExpK5/vLjC6HMIYQljpnuO8btGRr9Vw=
X-Received: by 2002:a05:6402:27cb:b0:5dc:d43c:3a2c with SMTP id
 4fb4d7f45d1cf-5dcdb72d224mr4957712a12.19.1738781839944; Wed, 05 Feb 2025
 10:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205183839.395081-1-mjguzik@gmail.com>
In-Reply-To: <20250205183839.395081-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Feb 2025 19:57:07 +0100
X-Gm-Features: AWEUYZkQ0NJYVuPb65M82YGzU13zRJ3KVhNjvVcwniDR1oPbgnuL4zHSZUfeu2g
Message-ID: <CAGudoHFq2AbuvvKhhY7pOouE_jhJk5ZdkU_Dd1wYnyYHosndpA@mail.gmail.com>
Subject: Re: [PATCH 0/3] CONFIG_VFS_DEBUG at last
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 7:38=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> This adds a super basic version just to get the mechanism going and
> adds sample usage.
>
> The macro set is incomplete (e.g., lack of locking macros) and
> dump_inode routine fails to dump any state yet, to be implemented(tm).
>
> I think despite the primitive state this is complete enough to start
> sprinkling warns as necessary.
>
> Mateusz Guzik (3):
>   vfs: add initial support for CONFIG_VFS_DEBUG
>   vfs: catch invalid modes in may_open
>   vfs: use the new debug macros in inode_set_cached_link()
>
>  fs/namei.c               |  2 ++
>  include/linux/fs.h       | 16 +++----------
>  include/linux/vfsdebug.h | 50 ++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug        |  9 ++++++++
>  4 files changed, 64 insertions(+), 13 deletions(-)
>  create mode 100644 include/linux/vfsdebug.h
>
> --
> 2.43.0
>

The produced warn is ugly as sin:\, for example for that bad size:
[   51.433206] VFS_WARN_ON_INODE(__builtin_choose_expr((sizeof(int) =3D=3D
sizeof(*(8 ? ((void *)((long)(__builtin_strlen(link)) * 0l)) : (int
*)8))), __builtin_strlen(link), __fortify_strlen(link)) !=3D linklen)
failed for inode ff32f7c350c8aec8

maybe there is a way to work it around, the code is literally lifted
out of mmdebug.h so they presumably have the same problem

apart from that the assert in may_open is backwards, the code normally
is not reached.

anyhow I expect to send a v2, but will wait for feedback before I do
--=20
Mateusz Guzik <mjguzik gmail.com>

