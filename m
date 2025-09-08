Return-Path: <linux-fsdevel+bounces-60476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA31B48426
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 08:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE9C1633AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 06:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F1237A4F;
	Mon,  8 Sep 2025 06:25:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423D2376EB
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312739; cv=none; b=OW3EK6MhhTMyLmd3Pt/pH2ynAu88jn77Fi1s+lTKkuA1txYwum2BAc4RhQGIi/IDah4WpLOirHRoc8sxg/pYLECnn+I6HZL8CJJyAqS8pbi/tQc4iMHKpVRN7gW9XMNQ0QKabSM9d4yRdwr+LrTE1kjjhZiovK70mmWO/Ni5Tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312739; c=relaxed/simple;
	bh=1v/mOpfZKBKLs/68dB6yx7kqFWY7QQCIcRakfdgaPiE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=trSL9RBfADxlO6U13f6h22YDhxnbmIdLcYVEomzhdoeHoj8PL6Zt/NVE18/IrB8hDMYSJjNY9l9Yw5/SLQrNfMD56ct+CUFJ0Je3VuAtB7Qh63uObhdpG61sgo7zSBa2F+M07aLBvBTo5DTVqL3552dy6ZJ5D3d1KduNL3kfJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uvVJe-008ewX-7d;
	Mon, 08 Sep 2025 06:25:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Jan Kara" <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
In-reply-to: <20250908051951.GI31600@ZenIV>
References: <>, <20250908051951.GI31600@ZenIV>
Date: Mon, 08 Sep 2025 16:25:26 +1000
Message-id: <175731272688.2850467.5386978241813293277@noble.neil.brown.name>

On Mon, 08 Sep 2025, Al Viro wrote:
> On Mon, Sep 08, 2025 at 02:50:10PM +1000, NeilBrown wrote:
> > On Mon, 08 Sep 2025, Al Viro wrote:
> > > That way xfs hits will be down to that claim_stability() and the obscen=
ity in
> > > trace.h - until the users of the latter get wrapped into something that=
 would
> > > take snapshots and pass those instead of messing with ->d_name.  Consid=
ering
> > > the fun quoted above, not having to repeat that digging is something I'd
> > > count as a win...
> > >=20
> >=20
> > What would you think of providing an accessor function and insisting
> > everyone use it - and have some sort of lockdep_assert_held() to that
> > function so that developers who test their code will see these problem?
> >=20
> > Then a simple grep can find any unapproved uses.
>=20
> Really?  Consider ->link().  Both arguments *are* stable, but the reasons
> are not just different - they don't even intersect.

Might the locking rules be too complex?  Are they even documented?

As you know I want to change directory locking so that a ->d_flags bit
locks a dentry in much the same way that locking the parent directory
currently does.

I had wondered why vfs_link() locks the inode being linked and thought it was
only to protect ->i_nlink.  If it is needed to protect against rename
too, that could usefully be documented - or we could use the same
->d_flags bit to ensure that lock.

I guess I'm a bit concerned that your goal here is to transition from
"lots of auditing" to "much less auditing" and I would rather it was "no
auditing needed" - one day you won't want to (or be able to) audit any
more.

Fudging some type-state with C may well be useful but I suspect it is at
most part of a solution.  Simplification, documentation, run-time checks
might also be important parts.  As the type-state flag-day is a big
thing, maybe it shouldn't be first.

Thanks,
NeilBrown

