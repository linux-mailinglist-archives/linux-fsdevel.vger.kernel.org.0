Return-Path: <linux-fsdevel+bounces-46741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C26A94A11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 02:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F235216E6A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 00:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB531E531;
	Mon, 21 Apr 2025 00:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZxaIxn+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD108645;
	Mon, 21 Apr 2025 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745196270; cv=none; b=IwTID0aMLMTGPzX6pa0STKYTcLQmmiP4+Pn42JCOg+etK6s49TYA16kZdAD0xaShAy3DVAJopWUCYoctp2+O+2nERByfG7pKPoBbASB4rehB4lrF5I3EpbmeN2bLKBYkSVq5b5Q6EWh7UeAgKnyDG/CCWBuaG1LASuOkJ3DPQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745196270; c=relaxed/simple;
	bh=tpc7JI9zhuZRUMpn8JtVPnErk+zdJMycBNuPABRdwVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJbWUwWLSUAbzsXljaQZxltHqWYh6iQSOd18b5h06ig7fgd6gdW5+KPYfrgvf87nFR/zvpi9l8WdX4e7wyF0pMhLYlAnb/YA4VzFdOR+oKjzU/pxwZz1CxCWE31/+HaPN6SlEqLGK6TUVwF87CLy1epMQ3fNX9+mZV9fryUqKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZxaIxn+F; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vPXublOhMjlOwCfZ5gPbmVGyzTgvlu2iZbOFAWd6GXg=; b=ZxaIxn+Fj20GsHtAKXYV6YKHg5
	Hg3KTBOsCwV699IuUwWg75w2fOCQ3NBhNLsvUHsiPhua0+pvvPLFJa4s8prTVb72R/p7f7YOf7aZp
	Hj5VC/rCJaSWzb/4/8/Cjj2v4WGp+9PA/v2lr9IGDvTyWoyLsfxSAC9Q6GRGjOIviDZ5d+pS6WScS
	bETfBaReHLmCnqR2YlyBe21vtUH3BtPx83fTNjYzGgZyw7YxK9sbR7W/sdPbyrL9aHuJlpytZp5qV
	N0tnXyPaGQnh2DL0qp3p/hkJN6RlXyrrqCyI9OQB4SiO6QHcxsUrCm4o/X7Pvl4eNPRhOn1pze1l5
	A+km/t8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6fGl-0000000GYpw-1WIA;
	Mon, 21 Apr 2025 00:44:19 +0000
Date: Mon, 21 Apr 2025 01:44:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <ikent@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Ian Kent <raven@themaw.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Eric Chanudet <echanude@redhat.com>, Jan Kara <jack@suse.cz>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Alexander Larsson <alexl@redhat.com>,
	Lucas Karpinski <lkarpins@redhat.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250421004419.GU2023217@ZenIV>
References: <20250417-zappeln-angesagt-f172a71839d3@brauner>
 <20250417153126.QrVXSjt-@linutronix.de>
 <20250417-pyrotechnik-neigung-f4a727a5c76b@brauner>
 <39c36187-615e-4f83-b05e-419015d885e6@themaw.net>
 <125df195-5cac-4a65-b8bb-8b1146132667@themaw.net>
 <20250418-razzia-fixkosten-0569cf9f7b9d@brauner>
 <834853f4-10ca-4585-84b2-425c4e9f7d2b@themaw.net>
 <20250419-auftrag-knipsen-6e56b0ccd267@brauner>
 <20250419-floskel-aufmachen-26e327d7334e@brauner>
 <95fc6b43-4e33-4e3f-932f-254ec3734f8c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95fc6b43-4e33-4e3f-932f-254ec3734f8c@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 21, 2025 at 08:12:25AM +0800, Ian Kent wrote:

> > One issue is of course that we need to guarantee that someone will
> > always put the last reference.
> > 
> > Another is that the any scheme that elides the grace period in
> > namespace_unlock() will also mess up the fastpath in mntput_no_expire()
> > such that we either have to take lock_mount_hash() on each
> > mntput_no_expire() which is definitely a no-no or we have to come up
> > with an elaborate scheme where we do a read_seqbegin() and
> > read_seqcount_retry() dance based on mount_lock. Then we still need to
> > fallback on lock_mount_hash() if the sequence count has changed. It's
> > ugly and it will likely be noticable during RCU lookup.
> 
> But the mounts are unhashed before we get to the scu sync, doesn't that
> 
> buy us an opportunity for the seqlock dance to be simpler?

What does being unhashed have to do with anything?  Both unhashing and
(a lot more relevant) clearing ->mnt_ns happens before the delay - the
whole point of mntput_no_expire() fastpath is that the absolute majority
of calls happens when the damn thing is still mounted and we are
definitely not dropping the last reference.

We use "has non-NULL ->mnt_ns" as a cheap way to check that the reference
that pins the mounted stuff is still there.  The race we need to cope with
is

A: mntput_no_expire():
	sees ->mnt_ns != NULL, decides that we can go for fast path
B: umount(2):
	detaches the sucker from mount tree, clears ->mnt_ns, drops the
	reference that used to be there for the sucker being mounted.
	The only reference is one being dropped by A.
A: OK, so we are on the fast path; plain decrement is all we need

... and now mount has zero refcount and no one who would destroy it.

RCU delay between the removal from mount tree (no matter which test
you are using to detect that) and dropping the reference that used
to be due to being mounted avoids that - we have rcu_read_lock()
held over the entire fast path of mntput_no_expire(), both the
test (whichever test we want to use) and decrement.  We get
A: rcu_read_lock()
A: see that victim is still in the tree (again, in whatever way you
want - doesn't matter)
A: OK, we know that grace period between the removal from tree and
dropping the reference couldn't have started before our rcu_read_lock().
Therefore, even if we are seeing stale data and it's being unmounted,
we are still guaranteed that refcount is at least 2 - the one we are
dropping and the one umount() couldn't have gotten around to dropping
yet.  So the last reference will not be gone until we drop rcu_read_lock()
and we can safely decrement refcount without checking for zero.

And yes, that case of mntput() is _MUCH_ hotter than any umount-related
load might ever be.  Many orders of magnitude hotter...

