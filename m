Return-Path: <linux-fsdevel+bounces-54069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD93AFAE87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57695188DFF8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5659289340;
	Mon,  7 Jul 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz9HYMRU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD725B1CB
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876660; cv=none; b=PS3f69PUNHwWuFmDOITDhctkLFsUU8QaaCeRQQtcVCHqAAx/1STMy0aC0nXad4LG/xZfR83msmCMM0FrUMoWgcMCWfYlhhnCGUeoIxo+aQ0lT+vScFNADUxKIgTQ+MFD0Gd7RtyBimMW+QQaAVm5AMrtXY8Ujo7OCLJr6NAhNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876660; c=relaxed/simple;
	bh=XKcyVUHE/3+So0ivNv3FXK500Agx7Ru2Ll+Xxt/5+B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi5TxwJ4ipVlyQbx9GI5JWtUyBqVOZ3gikOInnInR+u+Oax3kNle5U+xi6bmm5xivfH+xaysneHra/HQKAXDy/eqbpNR7mf6WxKZHPT/PX+I1EiVgY+aaLXQk6FjlFmDcSITjnlEXAL5d6F+uLG+oV6jnYRQrgMPA2f1WQYt3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz9HYMRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0179C4CEE3;
	Mon,  7 Jul 2025 08:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751876659;
	bh=XKcyVUHE/3+So0ivNv3FXK500Agx7Ru2Ll+Xxt/5+B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tz9HYMRUH6WTXHAkZCL/5yWKl9AmtgR4mNIuAKY/CPU2XclNZBgIATASMpbLs0g51
	 RSa3wAg/598Bm9NPXLuVQm7wUEmqQOW0QSwg4XbwW5TrBEjfJlgE6gG5yAWNZc3rPH
	 4rbKLc9XNumUHg4hFjU8w2jpGnw1rCv5HRS/mT+OIf66P2gs+pXUef6mmj9Pc0jJtI
	 x64dz2K5zyx/deX9k+xvcrhrqETAe73XLmArjgSKkGyEPqQFHl8ytHTiYxUzvL0Wvo
	 dcxvTroNR5mvtK91uuRZeg5WW+Gqcl6wa/XfJCLfT8NccRfut80bpbcp21NppWvpdk
	 f4PZ1IUKH89mQ==
Date: Mon, 7 Jul 2025 10:24:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC] MNT_WRITE_HOLD mess
Message-ID: <20250707-blaupausen-lustspiel-309ff16df111@brauner>
References: <20250704194414.GR1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250704194414.GR1880847@ZenIV>

On Fri, Jul 04, 2025 at 08:44:14PM +0100, Al Viro wrote:
> 	Scalable handling of writers count on a mount had been added
> back in 2009, when the counter got split into per-cpu components.
> The tricky part, of course, was on the "make it read-only" side and the
> way it had been done was to add a flag for "we are adding that shit up,
> feel free to increment, but don't get through the mnt_get_write_access()
> until we are finished".
> 
> 	Details are in mnt_get_write_access() and mnt_{,un}hold_writers().
> Current rules:
> 	* mnt_hold_writers()/mnt_unhold_writers() should be in the same
> mount_lock scope.
> 	* any successful mnt_hold_writers() must be followed by mnt_unhold_writers()
> within the same scope.
> 	* mnt_get_write_access() *MAY* take and release mount_lock, but only
> if there's somebody currently playing with mnt_hold_writers() on the same mount.
> 
> 	The non-obvious trouble came in 2011 (in 4ed5e82fe77f "vfs: protect
> remounting superblock read-only") when we got sb_prepare_remount_readonly(),
> esssentially doing mnt_hold_writers() for each mount over given superblock.
> I hadn't realized the implications until this year ;-/

We had issues here before. I fixed a bug where ->mnt_flags was written
back incompletely due to the sb_prepare_remount_readonly() last year.

> 
> 	The trouble is, as soon as mount has been added to ->s_mounts
> (currently in vfs_create_mount() and clone_mnt()) it becomes accessible
> to other threads, even if only in a very limited way.
> 
> 	That breaks very natural assumptions, just lightly enough to make
> the resulting races hard to detect.  Note, for example, this in ovl_get_upper():
> 	upper_mnt = clone_private_mount(upperpath);
> 	err = PTR_ERR(upper_mnt);
> 	if (IS_ERR(upper_mnt)) {
> 		pr_err("failed to clone upperpath\n");
> 		goto out;
> 	}
> 
> 	/* Don't inherit atime flags */
> 	upper_mnt->mnt_flags &= ~(MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME);
> See the problem?  upper_mnt has been returned by clone_private_mount() and at
> the moment it has no references to it anywhere other than this local variable.
> It is not a part of any mount tree, it is not hashed, it is not reachable via
> propagation graph, it is not on any expiry lists, etc.  Except that it *is*
> on ->s_mounts of underlying superblock (linked via ->mnt_instance) and should
> anybody try to call sb_prepare_remount_readonly(), we may end up fucking
> the things up in all kinds of interesting ways - e.g.
> 	mnt_hold_writers() sets MNT_WRITE_HOLD
> 	we fetch ->mnt_flags
> 	mnt_unhold_writers() clears MNT_WRITE_HOLD
> 	we remove the atime bits and store ->mnt_flags, bringing MNT_WRITE_HOLD
> back.  Makes for a very unhappy mnt_get_write_access() down the road...

I'm a bit confused by this example. Like, where would we fetch
mnt->mnt_flags with MNT_WRITE_HOLD set and then write it back
unconditonally?

But bigger picture. We should cleanup mnt->mnt_flags:

* Really, clone_private_mount() should be extended using a flags
  argument instead of messing around with the flags afterwards like it
  does now. That's just broken and will always invite for subtle bugs.
  Doing that kills any direct access to mnt->mnt_flags from overlayfs.

* secretment_init() should not mess directly with
  mnt->mnt_flags |= MNT_NOEXEC either. That's also just wrong. That
  should be replaced with SB_I_NOEXEC on the superblock itself.

* Stuff like MNT_INTERNAL does not have to be in
  mnt->mnt_flags afaict. It could easily live in struct mount and we can
  have a mnt_is_internal() thing that can be used by security/ which is
  the only non-core VFS part that cares about that.

After these changes we're left with two non-core VFS accesses to
mnt->mnt_flags: nfs and ocfs2. Both care about access time settings.

We add mnt->mnt_flags accessors that only returns proper mount
options/user flags and never any of the private VFS flags.

Afterwards we document direct access or modification of mnt->mnt_flags
outside core VFS as unsupported and unsafe.

Then we at least have clear rules.

> 
> 	The races are real.  Some of them can be dealt with by grabbing
> mount_lock around the problematic modifications of ->mnt_flags, but that's
> not an option outside of fs/namespace.c - I really don't want to export
> mount_lock *or* provide a "clear these flags and set these ones" exported
> primitive.
> 
> 	In any case, the underlying problem is that we have this state
> of struct mount when it's almost, but not entirely thread-local.  That's
> likely to cause future bugs of the same sort.
> 
> 	I'd been playing with delaying the insertion into ->s_mounts
> and making mnt_get_write_access() fail and complain if mount hasn't been
> inserted yet.  It's... doable, but not pleasant.  However, there's
> another approach that might be better.
> 
> 	We have ->mnt_instance, which is used only under mount_lock.
> We have two places where we insert, one place where we remove and
> two places (both in sb_prepare_remount_readonly()) where we iterate
> through the list.
> 
> 	What if we steal LSB of ->mnt_instance.prev for what MNT_WRITE_HOLD

Fine by me but please use proper accessor like we do in the struct fd
case and give the bit(s) proper name(s). IWe're all very attuned to this
because we know the struct fd code. But everyime someone hears about
this for the first time they look confused.

> is currently used for?  list_for_each_entry() won't give a damn;
> list_del() and list_add_tail() are called in mount_lock scopes that do
> not contain any calls of mnt_hold_writers(), so they'll see that LSB
> clear and work as usual.  Loop in mnt_get_write_access() could just
> as easily do
>         while ((unsigned long)READ_ONCE(mnt->mnt_instance.prev) & 1) {
> as the current
>         while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
> and no barriers need to be changed.  We might want to move
> ->mnt_instance closer to ->mnt or to ->mnt_pcp, for the sake of
> the number of cachelines we are accessing, but then ->mnt_instance
> is pretty close to ->mnt_pcp as it is.

