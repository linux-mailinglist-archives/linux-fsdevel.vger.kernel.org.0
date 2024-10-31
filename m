Return-Path: <linux-fsdevel+bounces-33311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B420D9B711E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 01:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63D81C214E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 00:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38134642D;
	Thu, 31 Oct 2024 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf4K0k17"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE617C7C;
	Thu, 31 Oct 2024 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730334194; cv=none; b=r8mEceAb5pSxg9n/glODE71eFWUMjmX2TB1a2SqD5YlsBkjKRB4ivubxfb8pAhL0/q/W6Tnd/hfP1tI9LVdFqqqkN2Ale3u/RAx7XpmINGN5B3AsalPpz4ExTsochE6SZQmEmX5Mi3xqFkAhROz5J5D31yRLNlL8T2Dje1G9dK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730334194; c=relaxed/simple;
	bh=mKf/hEPMwc/jLqf3HBq9mRvqTO+tlZ8H3qrguKAlDOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iW4WwzzgrcCWyU1Df+54Y7b1mnju+7c4FTPY+oR9puJ6sTnGUNi69VRMkayN43DUZkPnCIwSA5O0oaYfCHpTo19NmGUj7SVpC6aqor+HKXhZvyjm/Z9tVRwXNmFKdBxsR0DP+H8MZar/dTGBZuRTOdBzkQ4v7wnRvY3/nS74IaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf4K0k17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18F6C4CECE;
	Thu, 31 Oct 2024 00:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730334193;
	bh=mKf/hEPMwc/jLqf3HBq9mRvqTO+tlZ8H3qrguKAlDOE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Zf4K0k17wKkjMKmfVhkD25lVVrReqEEkIAE/OtAyzIxzEAonus1C7ZX6n5gdSw7IB
	 JOEjLc2x39F2QQ2LtRs5PEKn69MDsPu30xof5Wc3/F7k+pUlpdOdLIC3uBoDJ7IPCH
	 gzPU9qspKRGRAULpGyGtW4WItQL0FYlHxXdMWVE1e0oK1QSu+FEPNdHTqSugzHlvR3
	 c7sOsSSBGmnd6iDjcWsMNVVHfefCiABMIrH6jImw1ffq1l1SsRgma5Xh2W4hixvK/I
	 7r7LSiXYhwET6btyLo3lljoVKWUfBL+hiAqlX3Nj0H3LDlcbIh3fQt5oql0wWzLzy/
	 YvTkUcwGzcvDw==
Message-ID: <22c12708ceadcdc3f1a5c9cc9f6a540797463311.camel@kernel.org>
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
From: Jeff Layton <jlayton@kernel.org>
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, Linux-Fsdevel	
 <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman	 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Al Viro	 <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara	 <jack@suse.cz>, KP Singh
 <kpsingh@kernel.org>, Matt Bobrowski	 <mattbobrowski@google.com>, Amir
 Goldstein <amir73il@gmail.com>,  "repnop@google.com"	 <repnop@google.com>,
 Josef Bacik <josef@toxicpanda.com>
Date: Wed, 30 Oct 2024 20:23:10 -0400
In-Reply-To: <D21DC5F6-A63A-4D94-A73D-408F640FD075@fb.com>
References: <20241029231244.2834368-1-song@kernel.org>
	 <20241029231244.2834368-3-song@kernel.org>
	 <5b8318018dd316f618eea059f610579a205c05db.camel@kernel.org>
	 <D21DC5F6-A63A-4D94-A73D-408F640FD075@fb.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41app1) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-30 at 20:30 +0000, Song Liu wrote:
> Hi Jeff,=20
>=20
> Thanks for your review!
>=20
> I will update 1/2 based on the feedback. (Replying here to save everyone=
=20
> an email..)
>=20
> > On Oct 30, 2024, at 6:03=E2=80=AFAM, Jeff Layton <jlayton@kernel.org> w=
rote:
>=20
> [...]
>=20
> > > +
> > > +static int sample_fp_handler(struct fsnotify_group *group,
> > > +     struct fanotify_fastpath_hook *fp_hook,
> > > +     struct fanotify_fastpath_event *fp_event)
> > > +{
> > > + const struct qstr *file_name =3D fp_event->file_name;
> > > + struct sample_fp_data *fp_data;
> > > + struct prefix_item *item;
> > > +
> > > + if (!file_name)
> > > + return FAN_FP_RET_SEND_TO_USERSPACE;
> > > + fp_data =3D fp_hook->data;
> > > +
> > > + list_for_each_entry(item, &fp_data->item_list, list) {
> > > + if (strstr(file_name->name, item->prefix) =3D=3D (char *)file_name-=
>name)
> > > + return FAN_FP_RET_SKIP_EVENT;
> > > + }
> > > +
> > > + return FAN_FP_RET_SEND_TO_USERSPACE;
> > > +}
> >=20
> > The sample is a little underwhelming and everyone hates string parsing
> > in the kernel ;). It'd be nice to see a more real-world use-case for
> > this.
> >=20
> > Could this be used to implement subtree filtering? I guess you'd have
> > to walk back up the directory tree and see whether it had a given
> > ancestor?
>=20
> If the subtree is all in the same file system, we can attach fanotify to=
=20
> the whole file system, and then use some dget_parent() and follow_up()=
=20
> to walk up the directory tree in the fastpath handler. However, if there
> are other mount points in the subtree, we will need more logic to handle
> these mount points.=20
>=20

My 2 cents...

I'd just confine it to a single vfsmount. If you want to monitor in
several submounts, then you need to add new fanotify watches.

Alternately, maybe there is some way to designate that an entire
vfsmount is a child of a watched (or ignored) directory?

> @Christian, I would like to know your thoughts on this (walking up the=
=20
> directory tree in fanotify fastpath handler). It can be expensive for=20
> very very deep subtree.=20
>=20

I'm not Christian, but I'll make the case for it. It's basically a
bunch of pointer chasing. That's probably not "cheap", but if you can
do it under RCU it might not be too awful. It might still suck with
really deep paths, but this is a sample module. It's not expected that
everyone will want to use it anyway.

> How should we pass in the subtree? I guess we can just use full path in
> a string as the argument.
>=20

I'd stay away from string parsing. How about this instead?

Allow a process to open a directory fd, and then hand that fd to an
fanotify ioctl that says that you want to ignore everything that has
that directory as an ancestor. Or, maybe make it so that you only watch
dentries that have that directory as an ancestor? I'm not sure what
makes the most sense.

Then, when you get a dentry-based event, you just walk the d_parent
pointers back up to the root of the vfsmount. If one of them matches
the dentry in your fd then you're done. If you hit the root of the
vfsmount, then you're also done (and know that it's not a child of that
dentry).
--=20
Jeff Layton <jlayton@kernel.org>

