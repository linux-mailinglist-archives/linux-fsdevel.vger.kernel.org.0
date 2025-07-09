Return-Path: <linux-fsdevel+bounces-54402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6172AFF4BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 00:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5753B4597
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 22:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A732475CD;
	Wed,  9 Jul 2025 22:34:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB6156237;
	Wed,  9 Jul 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100481; cv=none; b=OqoHub95zpLLIMx0JoJbcwM8Mi6nccfxuc4pBoZAhx2Ls+cKU+7xhylOqA7DK5EtqPSCp164tRPrurpA/079XjyRpgUHj/cwKl8yV01DuuorC0RIzamgfme0XjdkD967I+yir+3A+FZnnPV8LwlZrJENMm32Wmso4Q9Tx/2ZgmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100481; c=relaxed/simple;
	bh=MY2Vx9zpExNRGPVZnEiH82ov0uFOe4OTJxBtVTuPRIg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aos+ih7+Nxw2h/uOrgTKoAI7NmU/Z1yiCizEu4CTFetOknu8wc7wTLKEXJzvegTLisfnngQWNJHOqGp2hAI8ZF/kJgk/jyzEjVgMhQk57oLWeDNDySb2FQETtsQMDZ2mFPoeQghtwWaV30bcSr5wG+aUy3beA826pl7OYkP7lVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uZd3M-001GCq-6w;
	Wed, 09 Jul 2025 22:14:13 +0000
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
In-reply-to: <40D24586-5EC7-462A-9940-425182F2972A@meta.com>
References: <>, <40D24586-5EC7-462A-9940-425182F2972A@meta.com>
Date: Thu, 10 Jul 2025 08:14:13 +1000
Message-id: <175209925346.2234665.15385484299365186166@noble.neil.brown.name>

On Tue, 08 Jul 2025, Song Liu wrote:
> Hi Christian,=20
>=20
> Thanks for your comments!=20
>=20
> > On Jul 7, 2025, at 4:17=E2=80=AFAM, Christian Brauner <brauner@kernel.org=
> wrote:
>=20
> [...]
>=20
> >>> 3/ Extend vfs_walk_ancestors() to pass a "may sleep" flag to the callba=
ck.
> >>=20
> >> I think that's fine.
> >=20
> > Ok, sorry for the delay but there's a lot of different things going on
> > right now and this one isn't exactly an easy thing to solve.
> >=20
> > I mentioned this before and so did Neil: the lookup implementation
> > supports two modes sleeping and non-sleeping. That api is abstracted
> > away as heavily as possible by the VFS so that non-core code will not be
> > exposed to it other than in exceptional circumstances and doesn't have
> > to care about it.
> >=20
> > It is a conceptual dead-end to expose these two modes via separate APIs
> > and leak this implementation detail into non-core code. It will not
> > happen as far as I'm concerned.
> >=20
> > I very much understand the urge to get the refcount step-by-step thing
> > merged asap. Everyone wants their APIs merged fast. And if it's
> > reasonable to move fast we will (see the kernfs xattr thing).
> >=20
> > But here are two use-cases that ask for the same thing with different
> > constraints that closely mirror our unified approach. Merging one
> > quickly just to have something and then later bolting the other one on
> > top, augmenting, or replacing, possible having to deprecate the old API
> > is just objectively nuts. That's how we end up with a spaghetthi helper
> > collection. We want as little helper fragmentation as possible.
> >=20
> > We need a unified API that serves both use-cases. I dislike
> > callback-based APIs generally but we have precedent in the VFS for this
> > for cases where the internal state handling is delicate enough that it
> > should not be exposed (see __iterate_supers() which does exactly work
> > like Neil suggested down to the flag argument itself I added).
> >=20
> > So I'm open to the callback solution.
> >=20
> > (Note for really absurd perf requirements you could even make it work
> > with static calls I'm pretty sure.)
>=20
> I guess we will go with Micka=C3=ABl=E2=80=99s idea:
>=20
> > int vfs_walk_ancestors(struct path *path,
> >                       bool (*walk_cb)(const struct path *ancestor, void *=
data),
> >                       void *data, int flags)
> >=20
> > The walk continue while walk_cb() returns true.  walk_cb() can then
> > check if @ancestor is equal to a @root, or other properties.  The
> > walk_cb() return value (if not bool) should not be returned by
> > vfs_walk_ancestors() because a walk stop doesn't mean an error.
>=20
> If necessary, we hide =E2=80=9Croot" inside @data. This is good.=20
>=20
> > @path would be updated with latest ancestor path (e.g. @root).
>=20
> Update @path to the last ancestor and hold proper references.=20
> I missed this part earlier. With this feature, vfs_walk_ancestors=20
> should work usable with open-codeed bpf path iterator.=20

I don't think path should be updated.  That adds complexity which might
not be needed.  The original (landlock) requirements were only to look
at each ancestor, not to take a reference to any of them.

If the caller needs a reference to any of the ancestors I think that
walk_cb() needs to take that reference and store it in data.
Note that attempting to take the reference might fail.  See
legitimize_path() in fs/namei.c.

It isn't yet clear to me what would be a good API for requesting the
reference.
One option would be for vfs_walk_ancestors() to pass another void* to
walk_cb(), and it passed it on to vfs_legitimize_path() which extracts
the seq numbers from there.
Another might be that the path passed to walk_cb is always
nameidata.path, and so when that is passed to vfs_legitimize_path() path
it can use container_of() to find the seq numbers.

If vfs_legitimize_path() fail, walk_cb() might want to ask for the walk
to be restarted.

>=20
> I have a question about this behavior with RCU walk. IIUC, RCU=20
> walk does not hold reference to @ancestor when calling walk_cb().
> If walk_cb() returns false, shall vfs_walk_ancestors() then
> grab a reference on @ancestor? This feels a bit weird to me.=20
> Maybe =E2=80=9Cupdating @path to the last ancestor=E2=80=9D should only app=
ly to
> LOOKUP_RCU=3D=3Dfalse case?=20
>=20
> > @flags could contain LOOKUP_RCU or not, which enables us to have
> > walk_cb() not-RCU compatible.
> >=20
> > When passing LOOKUP_RCU, if the first call to vfs_walk_ancestors()
> > failed with -ECHILD, the caller can restart the walk by calling
> > vfs_walk_ancestors() again but without LOOKUP_RCU.
>=20
>=20
> Given we want callers to handle -ECHILD and call vfs_walk_ancestors
> again without LOOKUP_RCU, I think we should keep @path not changed
> With LOOKUP_RCU=3D=3Dtrue, and only update it to the last ancestor=20
> when LOOKUP_RCU=3D=3Dfalse.=20

No, we really don't want to pass a LOOKUP_RCU() flag to
vfs_walk_ancestors().
vfs_walk_ancestors() might choose to pass that flag to walk_cb().

NeilBrown

