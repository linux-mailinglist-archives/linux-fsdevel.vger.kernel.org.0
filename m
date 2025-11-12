Return-Path: <linux-fsdevel+bounces-68038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A694C51BAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 975634F466D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C59D3064AB;
	Wed, 12 Nov 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbxRRbWo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F09303A0C
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943517; cv=none; b=gt1ERpuwaR0y6Qz45CRODUeFk6zzg/tlj1g+W4qu97zXzb/qSlWJJ3H4MOfWsAzjE03sMqRYJCyCBq2UQSJXY/gqyxer0IRp+d9FiQH/5W17puuf1jHuvlH+Jif1vcsNsXAPDWElNx1ZQRitBZG1xHuJBEQFNvz9gnMsaMCHF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943517; c=relaxed/simple;
	bh=hTiR7gME9diwEPlbbmudB9vKlvbylWB6Ycsv9PWANY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mq9Vlmh7VxFHJilYtNZeZhjo8i1rL3xbqOTGqn16p52PCmad/9EVDm/Gq8LDoMoOYqJ1M7jA2nDab+9a8tmgrgWREPPhRk0WBQiyGr0eOl5kn25EF+qYNugRIqKW0cLIkhLlo1y/Rz001Ek0SnVdMoZDZsclqvNwIAWRMY7Fluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbxRRbWo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so1109490a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 02:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762943514; x=1763548314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5KYsB/xGiFO8Ch1ObOukAbrFTRdbE6vFKr6OLCIdZU=;
        b=TbxRRbWo4ic+8c+oQLM5nnRi8iOH+gwIcITrQc5Wvp47tPhxzpp/JtTp7QbgjebDfo
         TAxsO6G009EfwiqWDh3Vkpr3bSmn6urNRHAuyG1AfjDDHG15BGk5zUfjFDgET43JI1Cd
         t9m+0aUG0k1TRfnR6TMOuRWPZ7Tp7FFns0V9Kqb3LO6OSux/VfBZvEI+MODnvw3ve9Ud
         QodH98uFSRI5NyjK2CLqV//wwKtLj8WeB9s7Xcl5o0Wiqs8i5B2ocmiCbZFebir4DpLo
         sKsc03rOSuIMOiSPy/sWNSHbNWUWfUL7qE1SHE2tOIK87vcHUT26aLCu9+xzb1DRtKwU
         /vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943514; x=1763548314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C5KYsB/xGiFO8Ch1ObOukAbrFTRdbE6vFKr6OLCIdZU=;
        b=TtIn/s0gJ162EJd6KKpLcu8+gSkhimUiGeJuMWy8xbGVIGUyoc6QtMh8j19dRjRNhi
         jqqSWKcm3OjpVll+neq/letPVCgvZOPVET3U8+ImirtMJ6ajyITp+dzMa45ZVkwlK6l/
         TKKKRyouOjfVpPa+sD+oEp1QDbdkTvyVM4n7hgZwDZGJ2RwE+bTNbw33HcRczehOvxkQ
         Z5e3SUv6RwgWYR+3EH2TSO7NcTPBU0Ng25GwRAtgHcoFnQeBjF4HWQ/nYWOOQheGoap7
         13nDWErej4U/xb1HJuoDt2xb0LEXLOmveeI38Cn8SvgmdsYuB8H6UBRSx5l4ST02f8yo
         uVGA==
X-Forwarded-Encrypted: i=1; AJvYcCWY7hlOPOvy+ZRkbe4Ebd5RV6iKt2PkA3nCnog+62tEWJWYQfZ8n6vOVmTJT1CyGy0RvDJv742JAd85vQcs@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfB4Y2nnuzyn89VYzKgFYKW20HGZCFwccsCy1f9cJoXMXYmXf
	L/7XkASThjW7AvzSxnDLCadkBktZWR7Y8VZb2uxTdunhZBpq91Rl0E8PBDzS28EFfoOWAKCwFVz
	NQp/yyN0hUCm9QvK9M+wwEDa4WsUWa9jA8GQ2
X-Gm-Gg: ASbGncuBTZXlgJyq1WkAjgMH+eiES4y2/pLXdWvGJ1hc4x+Ek/ozivkX6030kSsP7PP
	i29ctUlvBL6DsefG1wJMKZ/iMd/A3UlPcU/tJax0zj5/ZJVql7I61/yWbVsa4N95NumTnY1VRzp
	VyWD0ioLrv1TmhKYOjecTtG8CP1E0Pa26HWxB9ZKFJUS8TAQN61BO5/aT/O9RzOE9KOYzY+t/bV
	PzOHrmxcbNstVC9hTpxIF+8/FuhXbDA+iexaTmdHuKpaasqZI6otPy3LjFbQlwOhl4hPxbJztFW
	AZyt7CbckL0RouM=
X-Google-Smtp-Source: AGHT+IHYbSz+Y+ITaul58aAUNyOjKF8K0I08raTjfUAizetAQOHgPirCyxIcU5MJfQljhtodoSounsHIDJBAg0bKeTI=
X-Received: by 2002:a05:6402:2082:10b0:640:be87:a862 with SMTP id
 4fb4d7f45d1cf-6431a561bc3mr1768337a12.24.1762943514401; Wed, 12 Nov 2025
 02:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095634.1433061-1-mjguzik@gmail.com> <20251112-mondfinsternis-rednerpult-f3efbf92cf8a@brauner>
In-Reply-To: <20251112-mondfinsternis-rednerpult-f3efbf92cf8a@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 12 Nov 2025 11:31:42 +0100
X-Gm-Features: AWmQ_bmee1SeKAl3NlBlETUlo3-v4Pt3rAK-dj5ohMsS4GxQXL5eLWQ5IebIgyU
Message-ID: <CAGudoHGTOLXH=BtiU+ja9vbdR=cMCLFTDmtHtCNa32yka6huRg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: move fd_install() slowpath into a dedicated
 routine and provide commentary
To: Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

this may get the dreaded missing arg description working, how about this on=
 top:
diff --git a/fs/file.c b/fs/file.c
index 3f56890068aa..022e98525c65 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -641,8 +641,10 @@ void put_unused_fd(unsigned int fd)

 EXPORT_SYMBOL(put_unused_fd);

-/*
- * Install a file pointer in the fd array while it is being resized.
+/**
+ * fd_install_slowpath - install a file pointer in the fd array while
it is being resized
+ * @fd: file descriptor to install the file in
+ * @file: the file to install
  *
  * We need to make sure our update to the array does not get lost as
the resizing
  * thread can be copying the content as we modify it.

On Wed, Nov 12, 2025 at 10:30=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, 10 Nov 2025 10:56:34 +0100, Mateusz Guzik wrote:
> > On stock kernel gcc 14 emits avoidable register spillage:
> >       endbr64
> >       call   ffffffff81374630 <__fentry__>
> >       push   %r13
> >       push   %r12
> >       push   %rbx
> >       sub    $0x8,%rsp
> >       [snip]
> >
> > [...]
>
> Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.19.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.19.misc
>
> [1/1] fs: move fd_install() slowpath into a dedicated routine and provide=
 commentary
>       https://git.kernel.org/vfs/vfs/c/6ecf5292038e

