Return-Path: <linux-fsdevel+bounces-52813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B3BAE71A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CA35A61BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 21:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBB425B1EF;
	Tue, 24 Jun 2025 21:39:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381DF25A2B1;
	Tue, 24 Jun 2025 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801146; cv=none; b=fbExkdWgD+/kFg4ryPeQcgsv8GQ892NWqL+IXAX9RkgZiC9zJVfQ5z8cgTh1MWfmF1CxSyD2wmv1K2Qfkabf0Kc7NhzRlr5r09BxSZtErglFFdaesOKwn9UdruKC0Jk7rfdm/jhI5ATjoJEzWzfAWML36/nTQKtJ32CNoEx4MeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801146; c=relaxed/simple;
	bh=Y4l0bh8VQKBCsky1AfAt+0j/ZyivsMcPWV96H9WTLso=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OldBsxGRXT5bZbpfl80R/FiGSRG6a84zwOOGEnWD1M6kUHWXCECwlyy0hwmi7cHxDxqOKcMqAg+KG5/Nx0NMNjChP44EqNpz6WnWWWHWpcxnW61PZdEgezEslvmL4C3OBmI2oUMaHvCAx0gxq8VqtBzY34RArfDvNvqevoCq110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUBLy-0042q4-5A;
	Tue, 24 Jun 2025 21:38:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: "Song Liu" <song@kernel.org>, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, brauner@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, m@maowtm.org,
 =?utf-8?q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
In-reply-to: <20250624.xahShi0iCh7t@digikod.net>
References: <>, <20250624.xahShi0iCh7t@digikod.net>
Date: Wed, 25 Jun 2025 07:38:53 +1000
Message-id: <175080113326.2280845.18404947256630567790@noble.neil.brown.name>

On Wed, 25 Jun 2025, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Jun 20, 2025 at 02:59:17PM -0700, Song Liu wrote:
> > Hi Christian, Micka=C3=ABl, and folks,
> >=20
> > Could you please share your comments on this version? Does this
> > look sane?
>=20
> This looks good to me but we need to know what is the acceptable next
> step to support RCU.  If we can go with another _rcu helper, I'm good
> with the current approach, otherwise we need to figure out a way to
> leverage the current helper to make it compatible with callers being in
> a RCU read-side critical section while leveraging safe path walk (i.e.
> several calls to path_walk_parent).

Can you spell out the minimum that you need?

My vague impression is that you want to search up from a given strut path,
no further then some other given path, looking for a dentry that matches
some rule.  Is that correct?

In general, the original dentry could be moved away from under the
dentry you find moments after the match is reported.  What mechanisms do
you have in place to ensure this doesn't happen, or that it doesn't
matter?

Would it be sufficient to have an iterator which reported successive
ancestors in turn, or reported that you need to restart because something
changed?  Would you need to know that a restart happened or would it be
acceptable to transparently start again at the parent of the starting
point?

Or do you really need a "one step at a time" interface?

Do you need more complex movements around the tree, or is just walking
up sufficient?

If this has been discussed or documented elsewhere I'd be happy for you
just to provide a reference, and I can come back with follow-up
questions if needed.

Thanks,
NeilBrown


>=20
> >=20
> > Thanks,
> > Song
> >=20
> > On Mon, Jun 16, 2025 at 11:11=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > >
> > > In security use cases, it is common to apply rules to VFS subtrees.
> > > However, filtering files in a subtree is not straightforward [1].
> > >
> > > One solution to this problem is to start from a path and walk up the VFS
> > > tree (towards the root). Among in-tree LSMs, Landlock uses this solutio=
n.
> > >
> >=20
> > [...]
> >=20
>=20


