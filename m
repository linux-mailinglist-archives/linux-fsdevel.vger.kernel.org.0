Return-Path: <linux-fsdevel+bounces-41106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3198A2AEF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08AC1888219
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C59183CB0;
	Thu,  6 Feb 2025 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8PgQjVn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8323958D;
	Thu,  6 Feb 2025 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863217; cv=none; b=bA/oZ9YFCWui1vmIm58uai45Y6kWyUS8Gtv+h8QiuYcA+fe10lVLdSskkQXImsce86IbBk9vQe3msjkjQC/wDG1qfB7oJf8/nUM00mic/YhS1YHoueKAL5IeLFZtNIUz8TNlZezn9NOvvvAVsnhhUmSPMLNg9J5SqvvDdwNRqY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863217; c=relaxed/simple;
	bh=rmyUVqDV0Dd6+V/sY8D5DcgMwUBbzomMg++afH4Z45k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5ejoELVo4lDI0niFcOk84V268HFWkkeBvPDo2S6nwzVl0mdWZi1ybpt4ym8oIZMelEi3gvOxYIl00TW6nbf1dWnuAFUfTxA6Olg1Y9ifNQeM0MbM9zaL+qrIucH3UcdiHG/1Drx0I+hSCpkaX5goifgymDA/DBfDntCNvTNPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8PgQjVn; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eba0f09c3aso374568b6e.1;
        Thu, 06 Feb 2025 09:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738863215; x=1739468015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2T8qPWHLAVuFW9JkcOBDXxo93BC/anexNkzeETso0c=;
        b=b8PgQjVnrqGc/8ZGZJUZMlg4OkfdXQO7tWjeQN4PpnrIrG9f6O6SueDcsm7/LCbHkj
         hQgdVFDZ6/cs8zG1JirapzVprhHr4XWXW6V1pXyYVyKWQ+0Ac1CKUU6gv4pZFfQpMBGA
         1KVjwJLtA0nku5629ZeNYtVpc+U/MZyhE901QwexWFBfd1kSlyPj7yYkiUr+QnkbwR3+
         depl1grnC00prKH26lgpJqTGtNFyrjkI4pSBJIcgLuSkp0sB8qDJefpxnqQ5e64jdBgv
         GlmBOdIDLvRhqEe9am49rlAsT+BbygOD/bYzLw6WfubR4t7hU7YLHHxWCgbzzHaZMcIp
         v+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738863215; x=1739468015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2T8qPWHLAVuFW9JkcOBDXxo93BC/anexNkzeETso0c=;
        b=vAuBv8CgqvE8i/anl7HHJy2IJdZ4bF6zMIWiiikLpH9qhDJdpz1I34qjSw3kEiQl1n
         9+pBO2YNsfK6NQiUs7fDVFfwwYS29ABYscWnqeQXkx6H0r/EOAtkNUrmq4zWZ6CIySOy
         ep7YYSS9ikGF+WVACWy2YqCHB4oCqa+4sAZjrtjN3FxrQ7UKrZzHpQokCdeAHYl6a0fX
         SqoBm4IECbEvvCuGDTcaYfEvPIVz3RBfuliiVL3KwVgoC4fGoj36r40saJP6s7ktCsOr
         2tc69+WzBvkV/G1xhLNPTipp9rIkaUZ71Hxnpk3crztmyYaIGMyRvqypcHjXgTkALYVo
         lXtw==
X-Forwarded-Encrypted: i=1; AJvYcCW8TT4wfz52ZPyEOy08/W5P+tRPmUgME6ltQuFgYS5dPWk6OqbG3Pz0Ryy/1zUyOdDPXPq0FUEXfiGgZaaf@vger.kernel.org, AJvYcCWg8De901W/h5hCtOBn5QkbOwLW6MsugCGhgLTglFygZ3rSDRs4Hb6C1f+WkZyBIZS11zYotNT4P5yEh/Jl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+FXIvxjiuo/mlXuo8tCyvtVHsB2XnMTDcgem9eBQcy54uni1B
	iYlB55VW9y0MWzV+qDBF1w71l6IuAyB6f1ssbvMb5F+AdViQHngk83PmT29D5P+vgaiR1a62r6m
	GtmC0S8OeJKd5Fz35/eej6y9SiFpXnLjt
X-Gm-Gg: ASbGncsUO/vWmldCzwkHI1Y63BWR/5vmVOGQO2QOoadVahmZX1AYnj9CIn0rk/y/Fl6
	2AUlCwxy8P/xieCn2+08W9sg7uTvdzQ8+vhKnX70r6fH4k9i04Ath/82T7OfR2BwNCxqAsO4=
X-Google-Smtp-Source: AGHT+IHi9dLQuoI1fel4aPQz1hBkIlLQ6dQM/fvNm6pw/w01ORPppKmQG5v7muFffAbwf2kXGMQMN9GqmUEwIGTra+0=
X-Received: by 2002:a05:6808:2e8e:b0:3f3:1ca8:96b with SMTP id
 5614622812f47-3f39231a58bmr88929b6e.21.1738863214996; Thu, 06 Feb 2025
 09:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206170307.451403-1-mjguzik@gmail.com>
In-Reply-To: <20250206170307.451403-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Feb 2025 18:33:20 +0100
X-Gm-Features: AWEUYZm9-_915UUWg8F38hjRbsunffre-kyyd1_IEjk61gxUUot0w7K8GIImmGE
Message-ID: <CAGudoHGiHTZVMmP2eS0ePNL=KHGEssU5NeME7Ofr5pwUGtjFFw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] CONFIG_VFS_DEBUG at last
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 6:03=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
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
> v2:
> - correct may_open
> - fixed up condition reporting:
> before:
> VFS_WARN_ON_INODE(__builtin_choose_expr((sizeof(int) =3D=3D
> sizeof(*(8 ? ((void *)((long)(__builtin_strlen(link)) * 0l)) : (int
> *)8))), __builtin_strlen(link), __fortify_strlen(link)) !=3D linklen)
> failed for inode ff32f7c350c8aec8
> after:
> VFS_WARN_ON_INODE(strlen(link) !=3D linklen) failed for inode ff2b81ddca1=
3f338
>

welp, the BSD asserts fire when the condition is false, while Linux
when it is true, so the *text* is backwards. should:
VFS_WARN_ON_INODE(strlen(link) !=3D linklen) encountered for inode
ff2b81ddca13f338

modulo this bit I think this is fine for now

> Mateusz Guzik (3):
>   vfs: add initial support for CONFIG_VFS_DEBUG
>   vfs: catch invalid modes in may_open()
>   vfs: use the new debug macros in inode_set_cached_link()
>
>  fs/namei.c               |  2 ++
>  include/linux/fs.h       | 16 +++----------
>  include/linux/vfsdebug.h | 49 ++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug        |  9 ++++++++
>  4 files changed, 63 insertions(+), 13 deletions(-)
>  create mode 100644 include/linux/vfsdebug.h
>
> --
> 2.43.0
>


--=20
Mateusz Guzik <mjguzik gmail.com>

