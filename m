Return-Path: <linux-fsdevel+bounces-54405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49C0AFF636
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 02:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2C8564179
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFFB149C4A;
	Thu, 10 Jul 2025 00:58:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6EE539A;
	Thu, 10 Jul 2025 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109119; cv=none; b=V+2y7BUZM+ovw3edwXi6cclYalse/XPcM3WYrokHeXyzxz7iPtVvSqxTFM9Vdds+fzQU8Hzeq68eBRhTH1Hti5vNk859g3hT2oeSQByBF0T1nNX5RLwLs0x3/+d5T/ByQbHgwaispW7Eympu8XxNGOeo4xizXFkmkkJCVCT0Jdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109119; c=relaxed/simple;
	bh=/p1RkTj9htAxF4YYBjVTaG3lZPrHnv1Y5eL0IXe/6cM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=B4hYUK4VeVaR2yS31xpm1jcYJXtBrXfS/BYwrmq4A3kQ3Mp2khY2tIgu8ZWfDzaeHbKxW6a9f9ckaxXz9EsDv5MUDlRTwJHlazBTXo6Mx5i+tNbGkRUN3KOkyWlbS9LL4s4W2+XCriz+tKb8m6yo6h7+ZgJQ5PeR5+Agcou53gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uZfcK-001H9h-SZ;
	Thu, 10 Jul 2025 00:58:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Song Liu" <songliubraving@meta.com>
Cc: "Christian Brauner" <brauner@kernel.org>, "Tingmao Wang" <m@maowtm.org>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Song Liu" <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "Kernel Team" <kernel-team@meta.com>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,
 =?utf-8?q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
In-reply-to: <A4F6961B-452E-4B0E-B7AC-866B27FA732A@meta.com>
References: <>, <A4F6961B-452E-4B0E-B7AC-866B27FA732A@meta.com>
Date: Thu, 10 Jul 2025 10:58:30 +1000
Message-id: <175210911012.2234665.6265326943483194812@noble.neil.brown.name>

On Thu, 10 Jul 2025, Song Liu wrote:
>=20
>=20
> > On Jul 9, 2025, at 3:14=E2=80=AFPM, NeilBrown <neil@brown.name> wrote:
> >=20
> > On Tue, 08 Jul 2025, Song Liu wrote:
> >> Hi Christian,=20
> >>=20
> >> Thanks for your comments!=20
> >>=20
> >>> On Jul 7, 2025, at 4:17=E2=80=AFAM, Christian Brauner <brauner@kernel.o=
rg> wrote:
> >>=20
> >> [...]
> >>=20
> >>>>> 3/ Extend vfs_walk_ancestors() to pass a "may sleep" flag to the call=
back.
> >>>>=20
> >>>> I think that's fine.
> >>>=20
> >>> Ok, sorry for the delay but there's a lot of different things going on
> >>> right now and this one isn't exactly an easy thing to solve.
> >>>=20
> >>> I mentioned this before and so did Neil: the lookup implementation
> >>> supports two modes sleeping and non-sleeping. That api is abstracted
> >>> away as heavily as possible by the VFS so that non-core code will not be
> >>> exposed to it other than in exceptional circumstances and doesn't have
> >>> to care about it.
> >>>=20
> >>> It is a conceptual dead-end to expose these two modes via separate APIs
> >>> and leak this implementation detail into non-core code. It will not
> >>> happen as far as I'm concerned.
> >>>=20
> >>> I very much understand the urge to get the refcount step-by-step thing
> >>> merged asap. Everyone wants their APIs merged fast. And if it's
> >>> reasonable to move fast we will (see the kernfs xattr thing).
> >>>=20
> >>> But here are two use-cases that ask for the same thing with different
> >>> constraints that closely mirror our unified approach. Merging one
> >>> quickly just to have something and then later bolting the other one on
> >>> top, augmenting, or replacing, possible having to deprecate the old API
> >>> is just objectively nuts. That's how we end up with a spaghetthi helper
> >>> collection. We want as little helper fragmentation as possible.
> >>>=20
> >>> We need a unified API that serves both use-cases. I dislike
> >>> callback-based APIs generally but we have precedent in the VFS for this
> >>> for cases where the internal state handling is delicate enough that it
> >>> should not be exposed (see __iterate_supers() which does exactly work
> >>> like Neil suggested down to the flag argument itself I added).
> >>>=20
> >>> So I'm open to the callback solution.
> >>>=20
> >>> (Note for really absurd perf requirements you could even make it work
> >>> with static calls I'm pretty sure.)
> >>=20
> >> I guess we will go with Micka=C3=ABl=E2=80=99s idea:
> >>=20
> >>> int vfs_walk_ancestors(struct path *path,
> >>>                      bool (*walk_cb)(const struct path *ancestor, void =
*data),
> >>>                      void *data, int flags)
> >>>=20
> >>> The walk continue while walk_cb() returns true.  walk_cb() can then
> >>> check if @ancestor is equal to a @root, or other properties.  The
> >>> walk_cb() return value (if not bool) should not be returned by
> >>> vfs_walk_ancestors() because a walk stop doesn't mean an error.
> >>=20
> >> If necessary, we hide =E2=80=9Croot" inside @data. This is good.=20
> >>=20
> >>> @path would be updated with latest ancestor path (e.g. @root).
> >>=20
> >> Update @path to the last ancestor and hold proper references.=20
> >> I missed this part earlier. With this feature, vfs_walk_ancestors=20
> >> should work usable with open-codeed bpf path iterator.
> >=20
> > I don't think path should be updated.  That adds complexity which might
> > not be needed.  The original (landlock) requirements were only to look
> > at each ancestor, not to take a reference to any of them.
>=20
> I think this is the ideal case that landlock wants in the long term.=20
> But we may need to take references when the attempt fails. Also,=20
> current landlock code takes reference at each step.=20

Why may be need to?
Yes, current landlock code takes references, but I don't think that is
because it needs references, only because the API requires it to take
references.=20

>=20
> > If the caller needs a reference to any of the ancestors I think that
> > walk_cb() needs to take that reference and store it in data.
> > Note that attempting to take the reference might fail.  See
> > legitimize_path() in fs/namei.c.
> >=20
> > It isn't yet clear to me what would be a good API for requesting the
> > reference.
> > One option would be for vfs_walk_ancestors() to pass another void* to
> > walk_cb(), and it passed it on to vfs_legitimize_path() which extracts
> > the seq numbers from there.
> > Another might be that the path passed to walk_cb is always
> > nameidata.path, and so when that is passed to vfs_legitimize_path() path
> > it can use container_of() to find the seq numbers.
>=20
> Letting walk_cb() call vfs_legitimize_path() seems suboptimal to me.=20
> I think the original goal is to have vfs_walk_ancestors() to:
>   1. Try to walk the ancestors without taking any references;
>   2. Detect when the not-taking-reference walk is not reliable;
>   3. Maybe, retry the walk from beginning, but takes references on=20
>      each step.=20
>=20
> With walk_cb() calling vfs_legitimize_path(), we are moving #2 above=20
> to walk_cb(). I think this is not what we want?=20

I think you are looking at this the wrong way around.  Focus on the
needs for the caller, not on how you think it might be implemented.

If the caller needs a reference, there should be a way for it to get a
reference.  This is quite separate from the choices vfs_walk_ancestors()
makes about how it is going to walk the list of dentries.

NeilBrown

