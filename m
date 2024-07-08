Return-Path: <linux-fsdevel+bounces-23269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C95E929C87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 08:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2261C214DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 06:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4A51C69C;
	Mon,  8 Jul 2024 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXVuP5iC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA919470
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 06:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421576; cv=none; b=iQhtpFO1333J+DdoQfmWGjB/zcFN/R7BM78weAhFkW9DzmIfAVSsiSH3ncZ9T8TMNq5euHHbgRS4zOP+KVioDXjH9M4DJZLubbgeB10wlX1Q3wmDtNsNKXMHQrXV/ehbu5eFYgjFF/cm23Vn86cNnS0U2d+zCmHlcDnaaoFoJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421576; c=relaxed/simple;
	bh=AEvwklKkahMqU5NTDzmQKtCMtYWlnzq3g2SsYFh0OP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJtD0B1C3d1yDX8L0BBGxAG9MCpWJXpuM+IDlve222QsKYozsn2CUfSXsH9A78TEzDgaNvLMMLi9nP34Ss8xeO+TawMXnZqwz9jnslAfL9IiyZ9HGvArzhB5c5uOrxTaQFCyWZXorOOOQRX5iaBu29Yot4IfzPdGJl+2dLYKgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXVuP5iC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso33323a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jul 2024 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720421573; x=1721026373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9whkwrmVJ5LTYmQjDX1Dcp6xV4ICCXH4l+UXuqVSVG8=;
        b=PXVuP5iCT9zjIADZSIEaZQSfq0gMpRTiur0fUk5yhBqZIIfGwh4HoTN517r58sm1Y8
         N4A5eIbabSge6Ntc1p1l3B74qtZhOgBLHHVrQW/necgudNwJtj4XqQU+LQLTREd6/p+i
         xjoYPnF0hYAGeT6/jmSQwANSOcDDT+PsKzHdQn+O0H6Nmn2nz0vxb+3rRTq5iNBfv4OU
         EuUvNyHH0iTSobcQpH7aQanszSxCyPWR9voPYoKtL2mGJWeigvtK9sPPytoVPqx+4GUs
         Wjd+U5hgYmKT1voWkxsofVzZNJy7g9UbenVrUTlL91LurGzWspAx3It2XznLRn6IRN8/
         xmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720421573; x=1721026373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9whkwrmVJ5LTYmQjDX1Dcp6xV4ICCXH4l+UXuqVSVG8=;
        b=wQsMdxalyaeRhqj5y7zozq+Jda6kn3vA7tLNHxgXIRTTFR+Y2b83k88vMmgee7bMvB
         /ETpgLdjiNKU1bFs4KPvYVuRfafrf/5vcS4VWN0L6EIDLuXxkjkbQcWcoUun6+09Eisr
         7wJTKNiSpeLw+Y1BM2P7P0FfcURqRwyFLktx0o2eEV45OXtaRiq3Jc6NeiF7jt+M4cvn
         06vBgEa1cOaSvmBWThqbD0oQxl3sAhpOfFiTKwYU8apFua3A1RmzNmuzb2MsJpMsFFWR
         T5x/OUBnO9wVdrWP2JvZZR86XALccvoU8oECLMpECFN+y6Ue3xjhfA6lwWNkGAuQ9RqU
         hBtw==
X-Forwarded-Encrypted: i=1; AJvYcCWg/zUlAy/ccmZatOR9w3uqiU5EjAIQd7iyYyZQ9nPwWQwq08l6+5hW9bRQ23Ua2vAZTH8JcgaXcEZ4tPV3CL7rcoru7qI8/rftVLgZAg==
X-Gm-Message-State: AOJu0Yzi6VI7Nbd9NUBUJZ+/CZGNWLWsnrPYXhRqkJKbSGDsQqjV4CfT
	STPI2zk4aCi2Qum+/n8CjiU/VFJ8mjIIBY4FgxqB7M0Pfgangv/C0EZx11AwGH38eK4ZlwvrMqV
	k7PyzcQ7SA4+cIAAcxUinih8HcGI5GzTbmIiV
X-Google-Smtp-Source: AGHT+IFN5kJ6GOce4aE1Yj+jUNSNYIaA8MJOELU5iBuuDRasF2YS08Shp8PeHvRwpV6zyoqz/feShY8ANBbLonjV3cc=
X-Received: by 2002:a50:8d1a:0:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-58e28e6929fmr420362a12.1.1720421572714; Sun, 07 Jul 2024
 23:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000037162f0618b6fefb@google.com> <tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com>
 <172021445223.2844396.7059951310501602233.b4-ty@kernel.org> <20240706-wucher-gegossen-ed347171f1f0@brauner>
In-Reply-To: <20240706-wucher-gegossen-ed347171f1f0@brauner>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 8 Jul 2024 08:52:41 +0200
Message-ID: <CACT4Y+aZ=pBg7sOMmMojM6-gOsxk-e7Z91VaqS9cyjN40ZFirA@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: fix uninit-value in copy_name
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>, syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com, 
	Edward Adam Davis <eadavis@qq.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jul 2024 at 09:20, Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Jul 05, 2024 at 02:20:54PM GMT, Kees Cook wrote:
> > On Tue, 21 May 2024 13:21:46 +0800, Edward Adam Davis wrote:
> > > [syzbot reported]
> > > BUG: KMSAN: uninit-value in sized_strscpy+0xc4/0x160
> > >  sized_strscpy+0xc4/0x160
> > >  copy_name+0x2af/0x320 fs/hfsplus/xattr.c:411
> > >  hfsplus_listxattr+0x11e9/0x1a50 fs/hfsplus/xattr.c:750
> > >  vfs_listxattr fs/xattr.c:493 [inline]
> > >  listxattr+0x1f3/0x6b0 fs/xattr.c:840
> > >  path_listxattr fs/xattr.c:864 [inline]
> > >  __do_sys_listxattr fs/xattr.c:876 [inline]
> > >  __se_sys_listxattr fs/xattr.c:873 [inline]
> > >  __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
> > >  x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > [...]
> >
> > I've taken some security-related hfsplus stuff before, so:
>
> It's in #vfs.fixes to go out with the next vfs fixes pr.

Oops, sorry for creating a mess.
It's just really hard to understand a random patch status.

