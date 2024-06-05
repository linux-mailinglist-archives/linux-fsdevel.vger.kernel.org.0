Return-Path: <linux-fsdevel+bounces-21009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4362F8FC1D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 04:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A1A1F25D1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2513338DD6;
	Wed,  5 Jun 2024 02:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oot3Z9pq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB517C79
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554541; cv=none; b=iNcR8mKDmhQJoqKPtHpuHYozsruF76d6Dex244zDZSHXJPejwbuxnA865NfzZNg0UNN//YaIIqRGm5Dhm7ilZFjcOWqdXCwbNTnkFWwFVAEPPjHpxrThCddS9+6iumozjtWUVVZWg0EOQjrQdKcb01Hs/P45iamNi+Hk+GSU7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554541; c=relaxed/simple;
	bh=oRv51QDrfR15x8fhd924ttSzeBhShT4rloOreFzTVRM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bItwlr7zzG54oN4jGFDmTsBFzFghiFPkFX0LW9SyVXwLIkIqxFlD/2CLlZItunrtti1uhMTd4gJM9D/7iug93GP+2J1xFxgBQ0oA+ftFY+futLw32AXqbpMY2kJ2wJa5vVdUcqEwlUucMJNYO8b3Y7NOWze5r+Q0VXvxgRXWObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oot3Z9pq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=D7AlNzLH/LpoGZ1P9hnhJE7k7x9gv+IAhslVeil8X+4=; b=oot3Z9pq/IFU5oipp18VhW42jI
	XivbM67WM/s/QbG54eWFNHyUhZ8B/tOgFMERTA0Vp4iH2NydcgZDZshXmRDJ8PHsrJpilNtSy6o+c
	Ds77q5cxvv2/CXopT7n61EnWoQFeixlvbN+qGsVr7gllaWB1B7iSU9pT4ocJscwOHYidzzBkDtx7v
	JaLzzYY/06WqamGrN233qs4KeVcgh09AN8pV0pqL56WnOrVsbAvJXyeDO8nfDuC9jaV9n0OcbY38L
	14zOT19KLtEJtUySsbI649COIfwnsm/qbjHgZi/xwOnxaYIsS6wZ1Ws9MK/T0eT1rtherP0UalvDy
	9br2IqjQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sEgOV-00Evij-2j;
	Wed, 05 Jun 2024 02:28:55 +0000
Date: Wed, 5 Jun 2024 03:28:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [RFC] possible way to deal with dup2() vs. allocated but still not
 opened descriptors
Message-ID: <20240605022855.GV1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	dup2(old, new) has an unpleasant corner case - when new has been
already reserved by e.g. open() from another thread, but that open()
still didn't get to installing an opened file to that descriptor.

	It's outside of POSIX scope and any userland code that might
run into it is buggy.  However, we need to make sure that nothing breaks
kernel-side.  We used to have interesting bugs in that area and so did
*BSD kernels.

	Current solution is to have dup2() fail with -EBUSY.  However,
there's an approach that might avoid that wart.  I'm not sure whether
it's worth bothering with - it will have a cost, but then it might reduce
the pingpong on current->files->file_lock.

	Here's what we could do:
* have alloc_fd() insert (struct file *)((unsigned long)current | 1)
into the array of files.
* have fget() et.al. check if the value they'd fetched is even and
treat odd ones as NULL.
* have fd_install() check if the value being replaced is
(struct file *)((unsigned long)current | 1) and quitely do fput()
otherwise.  That, AFAICS, can be done without ->file_lock, just
with cmpxchg().
* have dup2() skip the "is it claimed, but still not open" logics
and skip the "filp_close() whatever we had there" if the old value
had been odd.
* have file_close_fd_locked() treat odd values as 0.
* have put_unused_fd() check if the value currently there is
(struct file *)((unsigned long)current | 1) and quitely do nothing
otherwise.

That, AFAICS, would treat dup2() racing with open() as if open() has won
the race - the end result is that open() succeeds, returns the descriptor
it would've returned but does not do anything to whatever dup2() has
put there.  Same as if open() had finished first, then lost CPU on the
way out to userland and didn't regain it until dup2() has succeeded.

The tasty part (and the only reason why that might be worth considering)
is that we don't need to grab ->file_lock twice per open() that way -
we do have the second atomic operation on fd_install(), but that's going
to be in the cacheline where the file pointer ends up being installed.

The question is whether that outweights the cost of check LSB and branch
not taken on a bunch of hot paths.

Comments?

