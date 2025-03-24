Return-Path: <linux-fsdevel+bounces-44883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1556CA6E0A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 18:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BEB7A68BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699526461B;
	Mon, 24 Mar 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVAkbcYL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7319263F3E;
	Mon, 24 Mar 2025 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836184; cv=none; b=spNPuZtk9eW84WezLmI5cpCGnRdRy0Y5KGHlJQsQVsM6MI5AhxgsiCgXGlgN59ku94d7WQBgRM3JISH5sfdgDHj8fuPVDMivHVtsG8roalEN9eOF4QQPUeu7jsR7X1sY1ZHcsFW3y+3EGBo/m+ULn8UcyjT3st6jpaHFFdGMdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836184; c=relaxed/simple;
	bh=YtM1xccQ9b4jm0BYJlLYAyhgiwHHbsx3miX3KYmfG5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEtElEaxZcvRx2mpROxizjDgXIya3oTbWg7XS8cP5M+hvTgUXoh2o0QnwN63tGnb79yXO0weB2VmJ3UluxHUwIGmIIe5BR5BUbFvYeFhtqBV5jOKmOauH/k/cggsc7gVK9cN9cs5ps3PyPdZcP2QP5gxg/g5KxnypXt65vgy8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVAkbcYL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso782829166b.1;
        Mon, 24 Mar 2025 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742836180; x=1743440980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkzaRWdI/oLc0o3QPM8pJTyhISa2Grm6xBDcFcXBazs=;
        b=WVAkbcYLjc7Y8lvcMl/VavVQcHgGjsLPIxnFp9ETObTzKXxj4WZWGPz0U4QCrqfhxR
         9ZNyhfUgmg759VROsFitZqw617VKi9OIr+K6WXMcQAkxxhiHexoIU7DoBly+HYjgfh5M
         4CMMn5jL25peoxjCdEYf1x/Iou2cLS/mEhD6W1bLAHcP4XyI+hN49OOIq3d03TIZ1Ra6
         6C27B3x4586ewwdmBTMMg4nc194ONiZRmDEtWvsd+KKrxCYsxsJiFOgOrweKS1lhzawR
         VVjB7vU8W0lEhsE+9fBXuLJVvIiWykYwmFBVAvVYy9JiLB7LgV8GcPExbH5FE3BeIjdh
         oNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742836180; x=1743440980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkzaRWdI/oLc0o3QPM8pJTyhISa2Grm6xBDcFcXBazs=;
        b=U4azpD/KcyRRu2tSivN+S7XJ2wKyvfvcTtstF8FDGotL+iA/FPZKlr3E0n5iX8ZTOm
         hKGX5hdHqyFGbJVL2DeE1ZXexY6HMMDewA+eSoiOl1vGbruZRmof5BDGutx9f5VE3GOg
         I5Rav8VqGVTtTnIV7FQfq3l933ocgaO43OXgl0NHy/r8gh5Ekkic/YY2EOlK4Ht5EqnT
         j/5ma4zYHAvJCzJGziXd014JhQRPgH0puAKDG1azKtWopgwqER6au4BNIp3Qm4Dc5Nqw
         T4iuWYvPsi+h8fd2cA9/gb4UaZxHSQUp/zU982r9GAxepHs52FRLG/XsmLDbzeZ6u8QZ
         HZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCqSf/ZmcfR7NXxr1eMXc5ai/7RalUCQ43l10/kIdpdLgBAbNN57tNSNw/UrheAu9EXhBwH0YzZr4itjgS@vger.kernel.org, AJvYcCWkCCN1DaRRj1+Mli66nfGyydE3BxjR+q2lC/vMqndcMUGJrIMcjScRVQakav9Gs0X6HwOojipxvzxME62R@vger.kernel.org
X-Gm-Message-State: AOJu0YwDTXLnb4PKO7JkEBX79B6EaN2FR9Mog1VXUtvGdASRGNnFpZq9
	0gDhhvUCCc1yqAnkkuvUlYIp+hXnhz1bvkI+gmSOY4e3DKkVoyNIhMzXJHQSEbY58nCfxWb5XUk
	kiRNIOVKtuEbXgx4+96OqFRqkaX4=
X-Gm-Gg: ASbGncuoSAFj7F1rOrlxac+v5XPt43AvB0n3gL1dTig4/X6fV5e4bNyAvb+wOUGOd1I
	1IXQ5lOzvr3JEYQR3CZ9hKRwlrDboqz5ceuq7gQDRE1908n3Kv2NMTISCdMpIT6wwneqnFgRpbT
	Og6MP6pOxgFPYRaS42272X1vZdZw==
X-Google-Smtp-Source: AGHT+IEWWIniopIYLKMSFAkoZXn00ztXTo+NuYLzSRTxqIy8VtPspTFZgF8v7zShU8+voiuALLFpEkuTXNcUjHkY6VQ=
X-Received: by 2002:a17:907:97ce:b0:ac3:3f13:4b98 with SMTP id
 a640c23a62f3a-ac3f251f516mr1448880366b.39.1742836179687; Mon, 24 Mar 2025
 10:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-vfs-misc-77bd9633b854@brauner> <CAHk-=wjNojYGmik93aB5UG1Nd5h2VHcVhKfBoYu9jVv_zh6Zng@mail.gmail.com>
In-Reply-To: <CAHk-=wjNojYGmik93aB5UG1Nd5h2VHcVhKfBoYu9jVv_zh6Zng@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Mar 2025 18:09:27 +0100
X-Gm-Features: AQ5f1JrUKxVxpDn8a0zpEGv_bY9k5PsGe8CVPNBkl-LPY_z5m10EaLygiCD9l1I
Message-ID: <CAGudoHGJ-z2pYw2ydJcu1LnL=C6Lzozw05QEAgBfj7FEn+4dcA@mail.gmail.com>
Subject: Re: [GIT PULL] vfs misc
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 5:20=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 22 Mar 2025 at 03:13, Christian Brauner <brauner@kernel.org> wrot=
e:
> >
> > Merge conflicts with mainline
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >
> > This contains a minor merge conflict for include/linux/fs.h.
>
> Hmm. My resolution here was to just take the plain VFS_WARN_ON_INODE()
> side, which basically drops commit 37d11cfc6360 ("vfs: sanity check
> the length passed to inode_set_cached_link()") entirely, because that
> one had a "TODO" that implies it's now replaced by the new
> VFS_WARN_ON_INODE() interface.
>
> This is just a note to make sure that if anybody was expecting
> something else, you can now speak up and say "can you please do X".
>
> Or, better yet, send a patch.
>

That TODO thing was a temporary fixup for the release and indeed it is
sorted out in this pull request.

If inode_set_cached_link() looks like this:
static inline void inode_set_cached_link(struct inode *inode, char
*link, int linklen)
{
        VFS_WARN_ON_INODE(strlen(link) !=3D linklen, inode);
        VFS_WARN_ON_INODE(inode->i_opflags & IOP_CACHED_LINK, inode);
        inode->i_link =3D link;
        inode->i_linklen =3D linklen;
        inode->i_opflags |=3D IOP_CACHED_LINK;
}

then you got the right version.

--=20
Mateusz Guzik <mjguzik gmail.com>

