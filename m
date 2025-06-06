Return-Path: <linux-fsdevel+bounces-50847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AC4AD0407
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700EB3A6469
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254F155326;
	Fri,  6 Jun 2025 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkTDT8Zz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC11805E;
	Fri,  6 Jun 2025 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749220096; cv=none; b=Pbi9DIfzCPmumo/DKwMupBSFT6tfCoVpf1O8vQfoTLNa5ZKbRWUKqZxXvOTuaNJUbqIxrQWq7kGoJJSF4WHBG8jrKCuCkVI5fZpwzr2zkIymytLcPSlpdtQ5gKPkTacx8VAr07kCNkJyHTVXx4XlYZaOwX2yUYzp0asno9FlrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749220096; c=relaxed/simple;
	bh=08Vq20uOgofu8CZCdNlOobGZcEnOMNCeL/M4vYUrAnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL0vrAtZ1wLF2gxv4f4t8QipxmJ+v4O0tlkEC8m6/Ur3+0RrRGlZOJpY6YWtK8bQGH9Luvs9t1qUqvpS+S5GXiGcAh6v618MOhTc81lvCZlqxaa31OiNjBptBYjYZg/9UlGZgWyAyf14maxBSTbhYhR3zaNhqA4ZaZcFMr7uHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkTDT8Zz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22e09f57ed4so30261815ad.0;
        Fri, 06 Jun 2025 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749220094; x=1749824894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ralCqpmIy+3EJB5V6PR2/HbS8cHhfOSaQOQqHRr2GTw=;
        b=MkTDT8Zz4ShzijTklDSj55uYiwgKoF8vuzNAH0YKxRyYA48/nNxmRXLYfMbmCCG2ko
         wR+sdt4lpFjQv0TuLrJHKyIFoVvu0R1P6/cGlq3/frpGg8gAxqB6Vb1Uohz+YwirpC6v
         5gRPd8s0rD0A0db/KRvYo4yRf57C8ja4w6OpmyEHzqsZ6dC3JHzHEEQeekKg+X7cQhOw
         xXyUrYtgbPjMyeUQXDLebmV6DPIWiY7zNZYif/JX78Q1JS4cZTgzhZHwgSAuEsTfMg8r
         gq7SLNnzCOTqTQLi3DgqFh+e7J7B2ClcWfJ6IrUz2Y0+8aQTADCafnY+LnP65/0Fqham
         DaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749220094; x=1749824894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ralCqpmIy+3EJB5V6PR2/HbS8cHhfOSaQOQqHRr2GTw=;
        b=PtJUT8tq6DdgQpQNEJJJ02nUuRg7grxfNdmx44w/jiL5ERcwwW5cV/PGS2J+/daeN1
         Lk4NeqmpKp9uLeUGbQx2MGyuu3iz8V26PsLDb9CaRCBx1HAiOqtffK7i+UYqE7M87Ao6
         wVZg9KcjyxMOwERUCalvkpn0McVYuIhh7g8zxEZAIJHI3WnPJuPNT1k1Jd1FUFBkAoQo
         HtkuzaLjpKybYDf7VaSLQ95GqX4kJP4qLE1tBPZX8jlgWj7s29mcKebHiYGfFHMzrkbR
         CBOlUHKBfa97NswnEvk0bU8deIFG/UhFW/HoH5rLjhhHjXgahlIrTXJcQSaiWw8I7QW8
         pgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN9xzj+FH2e8zaUjpNHxBneHuM1vFrH+Cp+I56ql3SkvtWAw/iJdzGV9n3Pwr9PY3Id7VOnupC@vger.kernel.org, AJvYcCUUEfB3ygTJgVghtlnAj4X/gsvd/C0OExK3sjUBv8ZmEi3q51eOb1QWsR0ti7PlZYE38RXq6buleQ==@vger.kernel.org, AJvYcCW/mXwgQ6LuKo/vSHmqL9spSGgmpZaMfRtdPB6xf2prAQCo4ep1rwIyNkVCQ5mKQzQFzgyeZOwy35IoyzT9@vger.kernel.org, AJvYcCWsv/wv0FrrkAb8nxsSVsnhG2Nda81lmrLm87i/fcoYVIjDrPbpVEaaIrhGmoCuUUymMlqZd03aU+BrokJb@vger.kernel.org, AJvYcCXv+yrv1OIxAPS1QR9VE9MTYS+66R6BWCFJ2s5VCPvEPU+TE4UWssi6C55yQmCEzM1klqAMWwnvrdMN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ZQOtTUPCJb0eluKM2KkF2Xsfy26Z3n4zDPVMEFTmZRKnM/tj
	oUgfKxMpUmtJaBo8/hrvoFGyNbeB4s0jtxUOoNrp4E0slkft2TmzXdzN0+9nUkChvv9ZgVwR64o
	oiDj4/ywRcqzqTkx8CQj/aMvVoGO6R3g=
X-Gm-Gg: ASbGncvdRig4xkAKwFrqVa3KIcK/UqRMUQsm/mH3tm3i2JRHe/yGL/AKV63Lb1OkvQ0
	apsIfOuqbDG6p+9e9E23cK7rpwmTRBdWOoXslvctKAqAmPZsUjVI4rofQHnR/E1gnlnBfXm37RX
	+6HwO92GeruTBr1JMHq3nw2gDKGFhfsZVG98IIeHiPVLg=
X-Google-Smtp-Source: AGHT+IGHvaPfG0+HpV+ht/ZksV0or0KV3mn59t6Z00XO5UHbDk9SfQ3Vtr3w5WebYdPMjG8RFTO1SGBROVNg+vl67bY=
X-Received: by 2002:a17:902:da48:b0:233:d3e7:6fd6 with SMTP id
 d9443c01a7336-23603a467eamr42749185ad.19.1749220094008; Fri, 06 Jun 2025
 07:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <49730b18-605f-4194-8f93-86f832f4b8f8@swemel.ru>
In-Reply-To: <49730b18-605f-4194-8f93-86f832f4b8f8@swemel.ru>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Jun 2025 10:28:02 -0400
X-Gm-Features: AX0GCFt8v2wBKzn1NQGbVueq_d16kQDnTqZtsxchgiVnzbBvdY-HnKnaHyqWKgg
Message-ID: <CAEjxPJ5KoTBB18_7+fWL+GWY4N5Vp2=Kn=9FJR2GewFRcMgzPQ@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 9:38=E2=80=AFAM Konstantin Andreev <andreev@swemel.r=
u> wrote:
>
> Stephen Smalley, 28/04/2025:
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
> >
> > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.sma=
lley.work@gmail.com/
>
> Sorry for being late to the party.
>
> Your approach assumes that every fs-specific xattr lister
> called like
>
> | vfs_listxattr() {
> |    if (inode->i_op->listxattr)
> |        error =3D inode->i_op->listxattr(dentry, list, size)
> |   ...
>
> must call LSM to integrate LSM's xattr(s) into fs-specific list.
> You did this for tmpfs:
>
> | simple_xattr_list() {
> |   security_inode_listsecurity()
> |   // iterate real xatts list
>
>
> Well, but what about other filesystems in the linux kernel?
> Should all of them also modify their xattr listers?
>
> To me, taking care of security xattrs is improper responsibility
> for filesystem code.
>
> May it be better to merge LSM xattrs
> and fs-backed xattrs at the vfs level (vfs_listxattr)?

This patch and the preceding one on which it depends were specifically
to address a regression in the handling of listxattr() for tmpfs/shmem
and similar filesystems.
Originally they had no xattr handler at the filesystem level and
vfs_listxattr() already has a fallback to ensure inclusion of the
security.* xattr for that case.
For filesystems like ext4 that have always (relative to first
introduction of security.* xattrs) provided handlers, they already
return the fs-backed xattr value and we don't need to ask the LSM for
it.
That said, you may be correct that it would be better to introduce
some additional handling in vfs_listxattr() but I would recommend
doing that as a follow-up.

