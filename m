Return-Path: <linux-fsdevel+bounces-31161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B38E9929CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEC11F22B16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C21D175F;
	Mon,  7 Oct 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii3JlSB7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091D1AB51F;
	Mon,  7 Oct 2024 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298930; cv=none; b=CZWFVBydv4QDbUHb1pBRe1UXgNsZ5Apd7mEr7Ap98ZdqUOQ/62vfLwhmTlXCHVi3GnP2jiHrcbnhBnfwHtqLo54BRlme1VYhnYEMFEItu0ChI0MlDMC/2cJxhkIAxp8Yyahi1TGQRThB/Xtj5JNwooyNB2E5s6LVR9OT2vOyBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298930; c=relaxed/simple;
	bh=x0XMAhxdJcqJh6lyhyMwHpYIegB7eFV4To1CVwHMbLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcKN7PLv5tKVOWr3SMJ/XJKQlp5Vj03sRCQwco5b7TbEr0bTAtJ+K6Rjs9TgAvxf4eryW3GAq7bXXCg1DVmX6PlaP8J8XnxrJJzVo7TzhMXgfy4PsMU3XPDXcGMct60OiTSfcsbl/YPtpf9VZ2vDTOhxiQ1HoUeEulf6CFOWPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii3JlSB7; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9ab721058so449107085a.1;
        Mon, 07 Oct 2024 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728298928; x=1728903728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jBU1B3c4Xtk6xVi6h5PIiFMEYdlpnr0VgQhAVUNZz0=;
        b=Ii3JlSB7sQ27mgaFsEZTSPoZHODCfTDgfmEG535i0AnxPndw5VFiN36U2ZmHpfsDsU
         yZqrRRxyEhg8/vnV4uVrnrOnc7+i0Lx1GOKCSTqQeMC73A/38aopW6VANF+ZQLFehlXR
         WAK1kNTIdT/+hAEA1uCsLtaVpnLG5onohOFzvFUvOgG4rdAeyiv8Q5T7LQaOXaY5vvLZ
         xMJUuVTf1edGbs456/7ns1CDkhnNWUlbOZj/0tydugEJoNQhLWdaEQ7Hze5jdm2qu7P9
         fHQVTkiLhELU/VQeIIx4e3vATFZh4UGodrSHU3XOJJ1va9LFVCqkuhYcYJsxQfQxOFpN
         s7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728298928; x=1728903728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jBU1B3c4Xtk6xVi6h5PIiFMEYdlpnr0VgQhAVUNZz0=;
        b=jTGYQC1VGeLGt3RBPOxlGwV2FtURkYmRTdBB9g0OStqWs/4LJWimfOzFeoGVeChWGV
         G63nNktBBmHRijFvkTaGSBDQu3kP/9DeiBw4iyIWJvZNgF0KgJHNmAz3DG8CInEhZ2BZ
         k9VacTvU2SiXYKgh8XAcn0YTJKRs+j9tkekWriaETnMlBrDn/wC1w4eD1mBljB5Hw4Xi
         KiSlHuaLKvLSEc4wGf997fZ1jrpSur/GCTErFEt92dfCGY/FM9mOHRAup1Cc0gxQ6JJG
         CfreSJOnPI8Cv6huL/D21zb5WHryVnReZdXP5ID0U3XhJLBJF1M3jESQPbdZ0bfhvj6u
         yFzg==
X-Forwarded-Encrypted: i=1; AJvYcCUAFS/OXyOYDVPjcWn9WmwjMs4TGQqX6OqlKBEw4UR1ZqTcT0s78AHHUF2D2EHL3jOZP3dXQDbrB1VD4QRXOg==@vger.kernel.org, AJvYcCWKsnU8zs5GsbFIO3aJNGsvGYZGgOMmJkFJ2NogJbuv7AoDWPuHm3GmH1i1sC/mCyVeZlFg/GhGUhGCzHST@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1YbcPHWMDiWKWZOEZxjs4tcHaQMSnMOsdDs0/nGgPdPYdDeD
	Pgt9InnEhFd+8Kp60qlBRl8z2xdpPSqfTYrYmXbNTvweTcESNWUNfTxjuNDBtKdSao8gG9bAH1y
	NJ5Qs74GWtQoO+7kDZqFBrHPa4cc=
X-Google-Smtp-Source: AGHT+IHHtgT3lfmWv8nu5wik20N2JeGOKj62WY3oenGtrFmKfzoXJjut7rpOqYYXpQ4kyKYEZebmadWMzttCcEF9fFc=
X-Received: by 2002:a05:620a:280a:b0:7a9:b80b:81e with SMTP id
 af79cd13be357-7ae6fb4064cmr1498241785a.10.1728298927821; Mon, 07 Oct 2024
 04:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082359.263755-1-amir73il@gmail.com> <CAJfpegsrwq8GCACdqCG3jx5zBVWC4DRp4+uvQjYAsttr5SuqQw@mail.gmail.com>
 <CAOQ4uxjxLRuVEXhY1z_7x-u=Yui4sC8m0NU83e0dLggRLSXHRA@mail.gmail.com> <CAJfpegvbAsRu-ncwZcr-FTpst4Qq_ygrp3L7T5X4a2YiODZ4yg@mail.gmail.com>
In-Reply-To: <CAJfpegvbAsRu-ncwZcr-FTpst4Qq_ygrp3L7T5X4a2YiODZ4yg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Oct 2024 13:01:56 +0200
Message-ID: <CAOQ4uxi0LKDi0VaYzDq0ja-Qn0D=Zg_wxraqnVomat29Z1QVuw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Stash overlay real upper file in backing_file
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:38=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Mon, 7 Oct 2024 at 12:22, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Maybe it is more straightforward, I can go with that, but it
> > feels like a waste not to use the space in backing_file,
> > so let me first try to convince you otherwise.
>
> Is it not a much bigger waste to allocate backing_file with kmalloc()
> instead of kmem_cache_alloc()?

Yes, much bigger...

Christian is still moving things around wrt lifetime of file and
backing_file, so I do not want to intervene in the file_table.c space.

>
> > IMO, this is not a layer violation at all.
> > The way I perceive struct backing_file is as an inheritance from struct=
 file,
> > similar to the way that ovl_inode is an inheritance from vfs_inode.
>
> That sounds about right.
>
> > You can say that backing_file_user_path() is the layer violation, havin=
g
> > the vfs peek into the ovl layer above it, but backing_file_private_ptr(=
)
> > is the opposite - it is used only by the layer that allocated backing_f=
ile,
> > so it is just like saying that a struct file has a single private_data,=
 while
> > the inherited generic backing_file can store two private_data pointers.
> >
> > What's wrong with that?
>
> It feels wrong to me, because lowerfile's backing_file is just a
> convenient place to stash a completely unrelated pointer into.

Funny, that's like saying that a ->next member in a struct is
completely unrelated.

What I see after my patch is that ->private_data points to a singly
linked list of length 1 to 2 of backing files.

>
> Furthermore private_data pointers lack type safety with all the
> problems that entails.

Well, this is not any worth that current ->private_data, but I could
also make it, if you like it better:

 struct backing_file {
        struct file file;
        struct path user_path;
+       struct file *next;
 };

+struct file **backing_file_private_ptr(struct file *f)
+{
+       return &backing_file(f)->next;
+}
+EXPORT_SYMBOL_GPL(backing_file_next_ptr);

Again, I am not terribly opposed to allocating struct ovl_file as we do
with directory - it is certainly more straight forward to read, so that
is a good enough argument in itself, and "personal dislike" is also a fair
argument, just arguing for the sake of argument so you understand my POV.

Let me know your decision.

Thanks,
Amir.

