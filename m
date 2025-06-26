Return-Path: <linux-fsdevel+bounces-53073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E64AE9B1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 12:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4413E4A6638
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D2E2236F8;
	Thu, 26 Jun 2025 10:22:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE11891A9;
	Thu, 26 Jun 2025 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933363; cv=none; b=oVbOHZ8L8Ajx0zvlButpCtU1YzK/oAbtCDCKmn3tz9jOUM7/lOLbLTIglkxMNtGKXDF5mHTQNTkvy/SWLwiQ6U6SxIF/4/WECQ7WCCK7E53btPqMNbG5SAQPXxE+46DXpqE/RUf+BJPU4mtzgj98dnhfVlZScOiD/0YW8Je+i4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933363; c=relaxed/simple;
	bh=2H+kJL+bS84EB32auPPLkuKNf04DurQZwXhkw/BdWuM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=acaBdbrc5WdG+BHNTTF6+4Aq9ojXh0epr45P5/KzzvAGAhma5AGRwUzJx0ROtV13RleFHt5J8PaWvp8GvTp896RnxDSu0qm9lye4QUACYzZQJDnuZ+kK8Z4yl6psayvbeNcWZE0Dvnlw3u65g74B25BARK8xSrDQ/wJPxuyd3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUjkV-005OrH-U1;
	Thu, 26 Jun 2025 10:22:32 +0000
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
Cc: "Tingmao Wang" <m@maowtm.org>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Song Liu" <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "Kernel Team" <kernel-team@meta.com>, "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,
 =?utf-8?q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
In-reply-to: <9BD19ABC-08B8-4976-912D-DFCC06C29CAA@meta.com>
References: <>, <9BD19ABC-08B8-4976-912D-DFCC06C29CAA@meta.com>
Date: Thu, 26 Jun 2025 20:22:29 +1000
Message-id: <175093334910.2280845.2994364473463803565@noble.neil.brown.name>

On Thu, 26 Jun 2025, Song Liu wrote:
>=20
>=20
> > On Jun 25, 2025, at 6:05=E2=80=AFPM, NeilBrown <neil@brown.name> wrote:
>=20
> [...]
>=20
> >>=20
> >> I can't speak for Micka=C3=ABl, but a callback-based interface is less f=
lexible
> >> (and _maybe_ less performant?).  Also, probably we will want to fallback
> >> to a reference-taking walk if the walk fails (rather than, say, retry
> >> infinitely), and this should probably use Song's proposed iterator.  I'm
> >> not sure if Song would be keen to rewrite this iterator patch series in
> >> callback style (to be clear, it doesn't necessarily seem like a good idea
> >> to me, and I'm not asking him to), which means that we will end up with
> >> the reference walk API being a "call this function repeatedly", and the
> >> rcu walk API taking a callback.  I think it is still workable (after all,
> >> if Landlock wants to reuse the code in the callback it can just call the
> >> callback function itself when doing the reference walk), but it seems a
> >> bit "ugly" to me.
> >=20
> > call-back can have a performance impact (less opportunity for compiler
> > optimisation and CPU speculation), though less than taking spinlock and
> > references.  However Al and Christian have drawn a hard line against
> > making seq numbers visible outside VFS code so I think it is the
> > approach most likely to be accepted.
> >=20
> > Certainly vfs_walk_ancestors() would fallback to ref-walk if rcu-walk
> > resulted in -ECHILD - just like all other path walking code in namei.c.
> > This would be largely transparent to the caller - the caller would only
> > see that the callback received a NULL path indicating a restart.  It
> > wouldn't need to know why.
>=20
> I guess I misunderstood the proposal of vfs_walk_ancestors()=20
> initially, so some clarification:
>=20
> I think vfs_walk_ancestors() is good for the rcu-walk, and some=20
> rcu-then-ref-walk. However, I don=E2=80=99t think it fits all use cases.=20
> A reliable step-by-step ref-walk, like this set, works well with=20
> BPF, and we want to keep it.=20

The distinction between rcu-walk and ref-walk is an internal
implementation detail.  You as a caller shouldn't need to think about
the difference.  You just want to walk.  Note that LOOKUP_RCU is
documented in namei.h as "semi-internal".  The only uses outside of
core-VFS code is in individual filesystem's d_revalidate handler - they
are checking if they are allowed to sleep or not.  You should never
expect to pass LOOKUP_RCU to an VFS API - no other code does.

It might be reasonable for you as a caller to have some control over
whether the call can sleep or not.  LOOKUP_CACHED is a bit like that.
But for dotdot lookup the code will never sleep - so that is not
relevant.

I strongly suggest you stop thinking about rcu-walk vs ref-walk.  Think
about the needs of your code.  If you need a high-performance API, then
ask for a high-performance API, don't assume what form it will take or
what the internal implementation details will be.

I think you already have a clear answer that a step-by-step API will not
be read-only on the dcache (i.e.  it will adjust refcounts) and so will
not be high performance.  If you want high performance, you need to
accept a different style of API.

NeilBrown

