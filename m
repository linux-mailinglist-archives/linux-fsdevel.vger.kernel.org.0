Return-Path: <linux-fsdevel+bounces-50258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C6AC9CC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 22:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E40318933EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 20:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29551A5B99;
	Sat, 31 May 2025 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vph3jmPF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E718DB1D
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 May 2025 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748725025; cv=none; b=f4lB+1pk/ctJvBSJ9sgCk7RYx9Ehss8B3a7M84WOkOMwjbGe+q2PWwD1odn7fsya8h1c+SVeSqtGtk2xSaAtwGewyBps53ndorJN9YBDs3Y8ywZ/CMiiE7mX+kblULckwzFyCWjMzH11RD0cHSmT/WODW8HPlGJGrBlskSGFRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748725025; c=relaxed/simple;
	bh=LOePQK1nl/Aktxr1Tno+Zq9NrVH8xCBuLArwtsOPB74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TNR669soNBYZaDzQfr/BVnF5fuk1PYiy9NfvFYIBv1x2FkwDOJR3F09XswS8ogdGoK0cIn7wCW4bwahX+LnVgwspUB3l+rfKvsUbHrTusotGwYvNrnJ2pgD8oDvC3Ig7J2MH8da9DPnqkj5/HdMrhb9lz9IT3PoVBZSo9FfFMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vph3jmPF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=f4wpRwMf3+PpMqnzJ1YHj01W0oXwE3r5DJ3F+L4fFWQ=; b=vph3jmPFd9tGaTi/Sjp1mDhuMD
	r5iWPzaZLIYsYK+fNpe7/RFdEPnWdDY5axIRRNhSpBfpAZAxpx/B20qXwEjxwuWBRcui+idsejEeH
	AhRRaeX3wot3oF5V39mp/kEMhd9HU2SxY8NbXoLeNE+v9Ex3ZXJ+fJPpFwDbl/cXoNNdwLFJoBgCa
	DJJi6R1tAbowTVvXzxWpGuQRCqaIqOnOVYmRje41ErGAhqfmYjxwYdkLlQBEtFAHKJlLA24GMrtYZ
	VXVbJ+58+Ks1RO7uoAOmfmSyyXIjr9pf/5s3uWTSkUZFpQ2nNevG1QD4E+4RpDlxwYNedqMUO+S5D
	K/aDOaTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLTGG-0000000BXpx-2uXD;
	Sat, 31 May 2025 20:57:00 +0000
Date: Sat, 31 May 2025 21:57:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [BUG][RFC] broken use of __lookup_mnt() in path_overmounted()
Message-ID: <20250531205700.GD3574388@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

	More audit fallout.

Rules for using mount hash (will go into the docs I'm putting together):
	* all insertions are under EXCL(namespace_sem) and write_seqlock(mount_lock)
	* all removals are under write_seqlock(mount_lock)
	* all removals are either under EXCL(namespace_sem) or have parent's
refcount equal to zero.
	* since all changes to hash chains are under write_seqlock(mount_lock),
hash seatch is safe if you have at least read_seqlock_excl(mount_lock).  In
that case the result is guaranteed to be accurate.
	* removals are done with hlist_del_init_rcu(); freeing of the removed
object is always RCU-delayed, so holding rcu_read_lock() over traversal is
memory safe.  HOWEVER, it is entirely possible to step into an object being
removed from hash chain at the time of search and get a false negative.
If you are not holding at least read_seqlock_excl(mount_lock), you *must*
sample mount_lock seqcount component before the search and check it afterwards.
	* acquiring a reference to object found as the result of traversal needs
to be done carefully - it is safe under mount_lock, but when used under rcu_read_lock()
alone we do need __legitimize_mnt(); otherwise we are risking a race with
final mntput() and/or busy mount checks in sync umount.

Search is done by __lookup_mnt().
Callers under write_seqlock(mount_lock):
	* all callers in fs/pnode.c and one in attach_recursive_mnt().
Callers under rcu_read_lock():
	* lookup_mnt() - seqcount component of mount_lock used to deal
with races.  Check is done by legitimize_mnt().
	* path_overmounted() - the callers are under EXCL(namespace_sem)
and they are holding a reference to parent, so removal of the object we
are searching for is excluded.  Reference to child is not acquired, so
the questions about validity of that do not arise.  Unfortunately, removals
of objects in the same hash chain are *not* excluded, so a false negative
is possible there.

Bug in path_overmounted() appears to have come from the corresponding
chunk of finish_automount(), which had the same race (and got turned
into a call of path_overmounted()).

One possibility is to wrap the use of __lookup_mnt() into a sample-and-recheck
loop there; for the call of path_overmounted() in finish_automount() it'll
give the right behaviour.

The other one, though...  The thing is, it's not really specific to
"move beneath" case - the secondary copies always have to deal with the
possibility of "slip under existing mount" situation.  And yes, it can
lead to problems - for all attach_recursive_mnt() callers.

Note that do_loopback() can race with mount(2) on top of the old_path
- it might've happened between the pathname resolution for source and
lock_mount() for mountpoint.  We *can't* hold namespace_sem over the
pathname resolution - it'd be very easy to deadlock.

One possibility would be to have all of them traverse the chain of
overmounts on top of the thing we are going to copy/move, basically
pretending that we'd lost the race to whatever had done the overmount.
The problem with that is there might have been no race at all - it
might've come from "." or a descriptor + empty path.  In this case
we currently copy/move the entire thing and it just might be used
deliberately.

Another possibility is to teach attach_recursive_mnt() to cope with the
possibility of overmounts in source - it's not that hard, all we need is
to find the top of overmount chain there in the very beginning and in all
"slip under existing mount" cases have the existing mount reparented to
the top of that chain.

I'm not sure which one gives better semantics, TBH.  I'd be more inclined
towards the second option - on the theory that we can combine it with
the first one in cases where that's applicable.

Comments?

