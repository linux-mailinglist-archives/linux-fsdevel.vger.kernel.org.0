Return-Path: <linux-fsdevel+bounces-59082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCCFB34228
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F115816AD1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722FA225388;
	Mon, 25 Aug 2025 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KNE+lxgo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9CD20F09C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129569; cv=none; b=TOZt795gJ6zzI7hb0ZclnsfyBbdlvDGi7KYfj5XVutpyHBEUNS6+ck2VDk1Pa7bMU0UOWd6QxgZxdOpDuTrQRy+eVf937GVX2kBQAHalMPaDENVgZSPSYIIpVapTEM8KtJmAbHxjKTMhlDzFQ9R2kFFFilqNVYt82i7YKQw0bJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129569; c=relaxed/simple;
	bh=mFZ4kh7ExsXHa4BivsWXyMFN3/vjrEZrqj4IApF6iC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm+PaUkQax3JcnTkSMBQ2N6LkZ5lPFusCKFpzQZAAT2Wuoa6e5wbnvt+xwpXhijSNLMckyuTCHRMRZZJVCjvK58FuswNSq27fr5ktcGyEgIemMYh4+bJmJosmwbCLMDqiWucPXv9PpXKcCxn0IYEmJf7gc4fnlPTjRMCjOdTZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KNE+lxgo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wTDFHymgMQa907TAu//SLgPvBtT6O6hUnLPcr1GhXq8=; b=KNE+lxgom/UHsLKu2jx5Yr09ft
	ACX9KQs9sUyO9CpWFjsB0qgNeLjWujfqcWD7Y5tsD4pz1G2r3D69ui6TXyCvs54SBbpeqSlYgNK1T
	2zZ8pdRX77uRzhcIk47mGWyycRt83LApucs29f2jwANnnex/v2l+D7E/S0O5eAouWjnM/5U8WhlXk
	EOhaeJLGgGxY9sKs9axboSnZpJI1s26REmUyn6wXTKsqoIc54nznti+dLcm2+cRmPo48B7RzW3FJ7
	0GtBiHF1Uv1adIsaldXHhTMv699L/fzmZvP1LNzBUc2720QW5Avky1M6/UAl3nzAT11l7AtP/OSbq
	iBqs2sSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqXWO-0000000Dxui-2sid;
	Mon, 25 Aug 2025 13:46:04 +0000
Date: Mon, 25 Aug 2025 14:46:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 02/52] introduced guards for mount_lock
Message-ID: <20250825134604.GJ39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-2-viro@zeniv.linux.org.uk>
 <20250825-repressiv-selektiert-7496db0b38aa@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-repressiv-selektiert-7496db0b38aa@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 25, 2025 at 02:32:38PM +0200, Christian Brauner wrote:
> On Mon, Aug 25, 2025 at 05:43:05AM +0100, Al Viro wrote:
> > mount_writer: write_seqlock; that's an equivalent of {un,}lock_mount_hash()
> > mount_locked_reader: read_seqlock_excl; these tend to be open-coded.
> 
> Do we really need the "locked" midfix in there? Doesn't seem to buy any
> clarity. I'd drop it so the naming is nicely consistent.

It's a seqlock.  "Readers" is this context are lockless ones - sample/retry under
rcu_read_lock() kind.  The only difference between writer and locked reader is
that locked reader does not disrupt those sample/retry loops.

Note that for something that is never traversed locklessly (expiry lists,
lists of children, etc.) locked reader is fine for all accesses, including
modifications.

If you have better suggestions re terminology, I'd love to hear those, but
simply "writer"/"reader" is misleadingly similar to rw-semaphors/links/whatnot.

Basically, there are 3 kinds of contexts here:
	1) lockless, must be under RCU, fairly limited in which pointers they
can traverse, read-only access to structures in question.  Must sample
the seqcount side of mount_lock first, then verifying that it has not changed
after everything.

	2) hold the spinlock side of mount_lock, _without_ bumping the seqcount
one.  Can be used for reads and writes, as long as the stuff being modified
is not among the things that is traversed locklessly.  Do not disrupt the previous
class, have full exclusion with calles 2 and 3

	3) hold the spinlock side of mount_lock, and bump the seqcount one on
entry and leave.  Any reads and writes.  Full exclusion with classes 2 and 3,
invalidates the checks for class 1 (i.e. will push it into retries/fallbacks/
whatnot).

I'm used to "lockless reader" for 1, "writer" for 3. "locked reader" kinda
works for 2 - that's what it is wrt things that can be accessed by lockless
readers, but for the things that are *not* traversed without a lock it
can be actually used as a less disruptive form of 3.  Is used that way in
mount locking for some of the data structures.

