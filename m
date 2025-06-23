Return-Path: <linux-fsdevel+bounces-52518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89600AE3CDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4761897613
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7075241105;
	Mon, 23 Jun 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ameovWbR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96C19D884;
	Mon, 23 Jun 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674700; cv=none; b=IBMoFFRHnp+BafAkPc/u8rhylhHhOVDcRN9PVIH5D9nYz4Sbf383msxOMaqZfzoO+uIReiyCBL8c1FcvNykDnp0cr4phOCva40TRz+i6GHfiPrxrbfOIa192VicmgnYmNtwC099X2g8cNp6BmB9tktU2V+ckbhNd/GA5b52QeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674700; c=relaxed/simple;
	bh=zR14Sx+DV7BezGwBN7A3uclQOZtBEScNi9Dy45H0Leo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4gCP8wZGChGSKoL68wksNNRe+NgQk/plDaLDomZrrbfFGOmqLK2zWUqXSN215Ofmu0spJXewzUloTmYcHz0AfGlV7Ffc28phD/1k7/Fx0iOKIh4WJqKgg67tOiELbz14ZyuYtCfDrlmzVDRLEvAmbXV2Px/EQH9F0yta8I4E+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ameovWbR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-609c6afade7so9293944a12.1;
        Mon, 23 Jun 2025 03:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750674697; x=1751279497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzc5aGq2nd6xkbCCMdYCK+R1xGiBpmTNhQcRaPuhm7s=;
        b=ameovWbRje1qlc8gBuBzrMrG4eLl2UNMVes0Vs+rH3es28zUg1n1dZE1Oe55YiMHuk
         ZW+soz5pZGzaOyASadO9F6CivpU7izE+Uy+gLjzFvbC8OaazhvrHrXM8BB83S+AThPKW
         y+rak9sd5acp0tzwMRuJ+i+1rkbc0fL0t4f6y7VTA4xVsV078xAeSbN4QMbZEFniZxzA
         s4iwH0fLvUgIBxfTLK3tFk4p/f7sBI0C9YNUDHImaWgUnRxayOiLtufgqRTzMrFsmLkZ
         /1kuxAyze9OjmKFAYD7JXGVOpjr4rfWN0Z14NnARI6eOgV5ofR+6wqwMDV2tMi6a4Ion
         P3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750674697; x=1751279497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzc5aGq2nd6xkbCCMdYCK+R1xGiBpmTNhQcRaPuhm7s=;
        b=jsMAoIvfPoEmWdn+t3M2MnQNauBxD5RDvPNMG9PF6pyh4Kk1lWNR9EtStNRPUG0QuA
         6qZ11lyM++dfVbvFKmlQHSdgKspuLrxMXdMysiqYk9lkh78/u1dZVi/M7XqJ5FV5QKrD
         0yc/TzGwY2R3KjPYGQ8U14fAz8GY5V6Yhem2/qx1nILJKE+ZJ6RgIyH/97jhWNBF2G/q
         uzWMSOd9zFeujKuOAZp2HByaHit/TyVEfrXQJUMjoar8rL+x6TuJXYu0bxPTFaCsxakL
         HR27K/YYICR42YMnF8vKC3L94aAq4y+hSTk+RLb4BLNKY5VqkX2HmQJ5kOISF79DtyhL
         PI+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjc45iM+w8hcNxDzncL5V0md97Lv2igL4I4Y8iLd1kKKm7GOALXgc9FcyGLuBuSXxv1zm5LCZZ03Gp5sXc@vger.kernel.org, AJvYcCXVr0XaleZJ2Mh39MGnzGLST3qBrm6pYmtv4taC8LCM1E99hNiseAQPlZEdsFr9p/Mj54ftxiYZryuU6O6MZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydPbcI9retLiRwjP7SR1MxDFt3xBNDvb2BiOk78r7zBYC9zHgg
	7kippeUuZZZTD8WQpMfxvR4gaN7QeX8OlMHK8ceDidwcISGT0awoTFFjrOK1lqNlYKKpYFjuJvh
	G1ip7RYCGKZV6oVALOU2SWi6sNOQxlnU=
X-Gm-Gg: ASbGncuBL97CZKNZD9OYGH5zrWQ2cmL7PD6kswAjOhsfRrp5KtYghp65xKjRriXbAxH
	Rsk1mbbRPeYXDKTHfHSPjBfVHbKcwLvmuh5f+ybcQkZfjAQdD3fKFw7Q+uMDjTUADnWTS0QlWcp
	olbN+Hn4Gcht5gJB5i97lp6HcwQzda1Djcyi6uI13+33Y=
X-Google-Smtp-Source: AGHT+IEms52oEr3JVkL1IOacj3hEWp8ZrHLCxAZMd3KVqRI2s6S2JpBt5EJcu8qAIZhvf6e2XDGFkCM7+EaRCHL2EYA=
X-Received: by 2002:a17:907:1c27:b0:ad2:2fdb:b0ab with SMTP id
 a640c23a62f3a-ae05b03812dmr1015299766b.29.1750674696190; Mon, 23 Jun 2025
 03:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602171702.1941891-1-amir73il@gmail.com> <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
 <CAOQ4uxicRiha+EV+Fv9iAbWqBJzqarZhCa3OjuTr93NpT+wW-Q@mail.gmail.com>
 <CAOQ4uxiNjZKonPKh7Zbz89TmSE67BVHmAtLMZGz=CazNAYRmGQ@mail.gmail.com> <20250623-analog-kolossal-4eee589ebb08@brauner>
In-Reply-To: <20250623-analog-kolossal-4eee589ebb08@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Jun 2025 12:31:24 +0200
X-Gm-Features: AX0GCFsMwK-59QADWkE1qGMtJqkYYbAWCaH0CgJZOBmBb1nRGu-k8DwEQCSgY4U
Message-ID: <CAOQ4uxjT9ffYX0gFPJw9_+ZtJL_-CaJik=v+rT7tek==hd4apQ@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 12:26=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Sun, Jun 22, 2025 at 09:20:24AM +0200, Amir Goldstein wrote:
> > On Mon, Jun 16, 2025 at 10:06=E2=80=AFAM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > >
> > > On Sun, Jun 15, 2025 at 9:20=E2=80=AFPM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > On Mon, Jun 02, 2025 at 07:17:02PM +0200, Amir Goldstein wrote:
> > > > > Case folding is often applied to subtrees and not on an entire
> > > > > filesystem.
> > > > >
> > > > > Disallowing layers from filesystems that support case folding is =
over
> > > > > limiting.
> > > > >
> > > > > Replace the rule that case-folding capable are not allowed as lay=
ers
> > > > > with a rule that case folded directories are not allowed in a mer=
ged
> > > > > directory stack.
> > > > >
> > > > > Should case folding be enabled on an underlying directory while
> > > > > overlayfs is mounted the outcome is generally undefined.
> > > > >
> > > > > Specifically in ovl_lookup(), we check the base underlying direct=
ory
> > > > > and fail with -ESTALE and write a warning to kmsg if an underlyin=
g
> > > > > directory case folding is enabled.
> > > > >
> > > > > Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > > Link: https://lore.kernel.org/linux-fsdevel/20250520051600.190331=
9-1-kent.overstreet@linux.dev/
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >
> > > > > Miklos,
> > > > >
> > > > > This is my solution to Kent's request to allow overlayfs mount on
> > > > > bcachefs subtrees that do not have casefolding enabled, while oth=
er
> > > > > subtrees do have casefolding enabled.
> > > > >
> > > > > I have written a test to cover the change of behavior [1].
> > > > > This test does not run on old kernel's where the mount always fai=
ls
> > > > > with casefold capable layers.
> > > > >
> > > > > Let me know what you think.
> > > > >
> > > > > Kent,
> > > > >
> > > > > I have tested this on ext4.
> > > > > Please test on bcachefs.
> > > >
> > > > Where are we at with getting this in? I've got users who keep askin=
g, so
> > > > hoping we can get it backported to 6.15
> > >
> > > I'm planning to queue this for 6.17, but hoping to get an ACK from Mi=
klos first.
> > >
> >
> > Hi Christian,
> >
> > I would like to let this change soak in next for 6.17.
> > I can push to overlayfs-next, but since you have some changes on vfs.fi=
le,
> > I wanted to consult with you first.
> >
> > The changes are independent so they could go through different trees,
> > but I don't like that so much, so I propose a few options.
> >
> > 1. make vfs.file a stable branch, so I can base overlayfs-next on it
> > 2. rename to vfs.backing_file and make stable
> > 3. take this single ovl patch via your tree, as I don't currently have
> >     any other ovl patches queued to 6.17
>
> Let's start with 3. and switch to a stable branch on demand?

works for me

Thanks,
Amir.

