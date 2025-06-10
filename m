Return-Path: <linux-fsdevel+bounces-51120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9AAD2FB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241511891681
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A3F25F797;
	Tue, 10 Jun 2025 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wQH5Fm/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F821578D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543484; cv=none; b=tt1Pt/0p+IEFs1vZj6SjbHhQAkTQm5y3sMvvzvp372yLpNXaUBqRqvQwyYk3Y8XWiTLw2bOJ9YPGAlAbvTZE3k/+xo9wTLCf3DTdhiOOJWoCsVoglk/Tf0X9tgt07+BMYw9US0cX87ICsoXSy+zRRJhJG9PbhzerLSPowI9hd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543484; c=relaxed/simple;
	bh=PIBIh6pxDEnzOV0iWuIkKZNjEhRc9NxBswI/ob8XAIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JRcbkk3H290BJOvZtq67sNsOfQhU+mqtNaiBFoNDHTuvzBTauyd1tk3fdmRWRUlSPIUGiXSwodRUKpdRYQE5OCn8IqyvcqUSXre/H5kt99abYdI72VLB6WJNKdszPWtKnfD9zVkWD+9w5XnelydWZ5ytX9msTnviPRVkFA34hV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wQH5Fm/p; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1CO+1QCNNeJRwT4twOxqvDjGI0mQd/4SY9k+tGuMmkY=; b=wQH5Fm/p7C0UIWQz7oM62Ze4sO
	emQiiKbG1cEU1dv+N8OK7GNtCrMqhLm9yPEIGDLyLfL3qwTLh4PNvkjq0Um+ho96uNRGLG6B1jyZq
	WADRQ1v1ktlTTByLsOphV4sj6soqNkj1adZBJPqU1Dy6jtgaE7plJI+yEN1AdJoOPqu2djA1209aV
	Rmeaij7+8gxYIwVvK/39fyKvF+ZU2zND98PXypib0rA+1vTHzRnJc2izXmzNgCUXfj6JLKaPcKbhw
	UR+ocsY0tX0EjMQN1/e34WRshOb+RvYqOEPfApH5BSUQmieG58VCmI4nbhIm2o1xpMhQOyExHG8sg
	MMlzfmNg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuBC-00000004h93-3XTi;
	Tue, 10 Jun 2025 08:17:58 +0000
Date: Tue, 10 Jun 2025 09:17:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCHES][RFC][CFR] mount-related stuff
Message-ID: <20250610081758.GE299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	The next pile of mount massage; it will grow - there will be
further modifications, as well as fixes and documentation, but this is
the subset I've got in more or less settled form right now.

	Review and testing would be very welcome.

	This series (-rc1-based) sits in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
individual patches in followups.

	Rough overview:

Part 1: trivial cleanups and helpers:

1) copy_tree(): don't set ->mnt_mountpoint on the root of copy
	Ancient bogosity, fortunately harmless, but confusing.
2) constify mnt_has_parent()
3) pnode: lift peers() into pnode.h
4) new predicate: mount_is_ancestor()
	Incidentally, I wonder if the "early bail out on move
of anon into the same anon" was not due to (now eliminated)
corner case in loop detection...  Christian?
5) constify is_local_mountpoint()
6) new predicate: anon_ns_root(mount)
7) dissolve_on_fput(): use anon_ns_root()
8) don't set MNT_LOCKED on parentless mounts
	Simplify the rules for MNT_LOCKED
9) clone_mnt(): simplify the propagation-related logics
	... making it somewhat easier to verify correctness wrt
propagation graph invariants.
10) do_umount(): simplify the "is it still mounted" checks
	it needs to check that mount is ours and it has gradually
grown an equivalent of such check, but it's badly obfuscated.

Part 2: (somewhat of a side story) restore the machinery for long-term
mounts from accumulated bitrot.

11) sanitize handling of long-term internal mounts

Part 3: propagate_umount() rewrite (posted last cycle)

12) Rewrite of propagate_umount()

Part 4: untangling do_move_mount()/attach_recursive_mnt().  This is one area that
will definitely grow - reliable avoidance of having multiple mounts with the same
parent/mountpoint pair will go in there.

13) attach_mnt(): expand in attach_recursive_mnt(), then lose the flag argument
14) do_move_mount(): take dropping the old mountpoint into attach_recursive_mnt()
15) get rid of mnt_set_mountpoint_beneath()
16) make commit_tree() usable in same-namespace move case
17) attach_recursive_mnt(): unify the mnt_change_mountpoint() logics
18) attach_recursive_mnt(): pass destination mount in all cases
19) attach_recursive_mnt(): get rid of flags entirely
20) do_move_mount(): get rid of 'attached' flag

Part 5: change locking for expiry lists.
21) attach_recursive_mnt(): remove from expiry list on move
22) take ->mnt_expire handling under mount_lock [read_seqlock_excl]

Part 6: struct mountpoint massage.
23) pivot_root(): reorder tree surgeries, collapse unhash_mnt() and put_mountpoint()
24) combine __put_mountpoint() with unhash_mnt()
25) get rid of mountpoint->m_count

Part 7: regularize mount refcounting a bit
26) don't have mounts pin their parents

