Return-Path: <linux-fsdevel+bounces-48120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA10FAA9C28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 21:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875D0189B58F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD8F262FD3;
	Mon,  5 May 2025 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oZaeoKpF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3A1C84A4
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471740; cv=none; b=F8G/MeBFi85V3Z09M57hUw5/3ylMs+GIhfolHp1UStc2W9KNJpR+3K2tMFdjCj8Kg7LQi7EFpG7I5F8VW3qUOkBJ5CZ2Bg+gttZz6eiRw0XTj+bTesNlSdgEZIU7wfpbmgWxowxZyvnTv635fOymA+egOQcgfbbTJMtVgqgcTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471740; c=relaxed/simple;
	bh=/9cs4nkZxZ/vLRDsPdEOyh00M0nVr8Rj2Mpb5JyJdtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX9GWqw/9b0foH4VF4OnUnUPlLHy47RN2Ptzzj67pCpIr5SA9712y+BcCYHELaGzrLVtgdzhpLl4Gsi1avk7Ul2eXjo+8R5IDYTT4IAVLTko4AUZ0FUDm0LCZQqe1kqSGA9o2farRUyLO8noZrYcw1w2WoWDZ5aH2gRUujW/q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oZaeoKpF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VB4GNeJHnMYkW3fg/QFVk+ePJUDpqnlYuoBn/mFVhl0=; b=oZaeoKpFVpbcZZ1nBqxzx9fDjw
	W7lMHvYCZgXVX4xLLIW1Hw8Ll1I/x3JZthDbtY7PGydXrx2EQhpvP+y/QqzN1QOEbTEUC5CTCk1mZ
	LAFoLgjscWRL+shU13qXhXeyHc1k1wDEDyxOYEwXZhTH25xBrUzgbtowUt7GbOYEZjUotstGEKGc7
	hTt7sC4WgGH4IEOha3EWKayy3+34cxmXAVBelJwu/MyvfwZ9C4WNcbpZLsnWLAEtcZIfuD/R3H1ZH
	Djf2fuN//ZtXN7ZxFE8sd5ypRpayJHuJwvD2IfQNTemFEt7T2UUzoT4JWwS+W3i6qMKpyr9CEtQ3V
	/R8dLolQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC14x-00000005zhU-1LQ3;
	Mon, 05 May 2025 19:02:15 +0000
Date: Mon, 5 May 2025 20:02:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] MNT_LOCKED vs. finish_automount()
Message-ID: <20250505190215.GG2023217@ZenIV>
References: <20250501201506.GS2023217@ZenIV>
 <87plgq8igd.fsf@email.froward.int.ebiederm.org>
 <20250504232441.GC2023217@ZenIV>
 <877c2v88rz.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c2v88rz.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 05, 2025 at 08:52:16AM -0500, Eric W. Biederman wrote:

> How would you deal with this in attach_recursive_mnt?  The problem case
> appears to be an automount on top of a recursive mount.  So I don't
> see the recursive mount code path being involved at all.
> 
> 
> 
> Given that only new mounts explicitly specified by a user and
> finish_automount call do_add_mount this looks safe.  Having
> MNT_LOCKED set will always be inappropriate in these two
> cases.

do_add_mount() -> graft_tree() -> attach_recursive_mnt()

and the last one is where we actually attach them to mount tree.
And that's really where all subtrees are attached, except for the very
local surgery in pivot_root().

Said that, from digging I'd done last night there might be a different
long-term approach; the thing is, there are very few places where we
ever look at MNT_LOCKED for mounts with !mnt_has_parent():
	do_umount()
	can_umount()
	do_move_mount()
	pivot_root()
and two of those four are of dubious use - can_umount() will be followed
by rechecking in do_umount(), so there's not much point in bailing out
early in a very pathological case.  And do_move_mount() might check
MNT_LOCKED on such, but only in move-from-anon case, where we do *NOT*
set MNT_LOCKED on namespace root.

IOW, looking at the way things are now, I'm no longer sure that the trick
you've done in da362b09e42 "umount: Do not allow unmounting rootfs"
had been a good idea long-term - it certainly made for smaller fix,
but it overloaded semantics of MNT_LOCKED, making it not just about
protecting the mountpoint against exposure.

What if we add explicit checks for mnt_has_parent() in do_umount() and
pivot_root() next to existing checks for MNT_LOCKED?  Then we can
	* have clone_mnt() treat that flag as "internal, ignore" (matter
of fact, I would simply add MNT_LOCKED to MNT_INTERNAL_FLAGS and have
clone_mnt() strip that, same as we do in do_add_mount()).
	* have copy_tree() set it right next to attach_mnt(), if the source
had it.  Yes, leaving it clear for root of copied tree.
	* no need to clear it in the end of __do_loopback() (racy at the
moment, BTW - no mount_lock held there, so race with mount -o remount,ro
for the original is possible, so something is needed there)
	* have lock_mnt_tree() skip the MNT_LOCKED not just for the expirable
but for the root of subtree as well.
	* don't bother stripping MNT_LOCKED for roots of propagation copies
(or anyone, for that matter) in attach_recursive_mnt()
	* don't bother setting it on absolute root of initial namespace

Looks like we end up with overall simpler code that way; it's certainly
conceptually simpler - MNT_LOCKED is set only on the mounts that do
have parent we care to protect, with that being done atomically wrt
mount becoming reachable (lock_mnt_tree() is in the same lock_mount_hash()
scope where we call commit_tree() that makes the entire subtree reachable).

Your argument in "mnt: Move the clear of MNT_LOCKED from copy_tree to
it's callers" about wanting to keep it in collect_mounts() for audit
purposes is wrong, AFAICS - audit does not see or care about MNT_LOCKED;
the only thing we use the result of collect_mounts() for is passing
it to iterate_mounts(), which literally "apply this callback to each
vfsmount in the set", completely ignoring anything else.  What's more,
all callbacks audit is passing to it actually look only at the inode of
that mount's root...

Anyway, that's longer-term stuff; I'll put together a patch along those
lines on top of this one.  Do you have any objections to the minimal
fix as posted?  Or, for that matter, to a variant that simply adds
MNT_LOCKED to MNT_INTERNAL_FLAGS (not used anywhere outside of
do_add_mount()):

[PATCH] finish_automount(): don't leak MNT_LOCKED from parent to child

Intention for MNT_LOCKED had always been to protect the internal
mountpoints within a subtree that got copied across the userns boundary,
not the mountpoint that tree got attached to - after all, it _was_
exposed before the copying.

For roots of secondary copies that is enforced in attach_recursive_mnt() -
MNT_LOCKED is explicitly stripped for those.  For the root of primary
copy we are almost always guaranteed that MNT_LOCKED won't be there,
so attach_recursive_mnt() doesn't bother.  Unfortunately, one call
chain got overlooked - triggering e.g. NFS referral will have the
submount inherit the public flags from parent; that's fine for such
things as read-only, nosuid, etc., but not for MNT_LOCKED.

This is particularly pointless since the mount attached by finish_automount()
is usually expirable, which makes any protection granted by MNT_LOCKED
null and void; just wait for a while and that mount will go away on its own.

Include MNT_LOCKED into the set of flags to be ignored by do_add_mount() - it
really is an internal flag.

Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
---
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 5b69f8ede215..c1bb278b475c 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -49,8 +49,8 @@ struct path;
 				 | MNT_READONLY | MNT_NOSYMFOLLOW)
 #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
 
-#define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
-			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED)
+#define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_DOOMED | MNT_MARKED | MNT_LOCKED \
+			    | MNT_WRITE_HOLD | MNT_SYNC_UMOUNT | MNT_INTERNAL)
 
 #define MNT_INTERNAL	0x4000
 

