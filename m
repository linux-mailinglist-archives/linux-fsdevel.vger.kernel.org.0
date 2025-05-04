Return-Path: <linux-fsdevel+bounces-48016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFAAAA89FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 01:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB127A89D2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 23:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19E81C6FF4;
	Sun,  4 May 2025 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dvjYfnXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4D5579E
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 May 2025 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746401088; cv=none; b=QLwBB05jQyUyT5DnRKUTnD2X/z8S4KgrPs8qxt4qTMgX4gWZqsMxs9QqlCGuI7w7Q/qZ28vSbo1nnLj0O8K4WnKJxLXgz5AlP8G5KWyw+XRbuGvozCpf0ppLcrtUEGcPj0SBrp3CmvKFROF1/DGCL5UfX3+825bhqIl4rgdmIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746401088; c=relaxed/simple;
	bh=rOHxoah9cwQ3J5H/KQowvi/9Mc4DBfjzqzbwOLQ3rIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ8ewJ0GZapv83Kfny41YbqDb2q0tSJxA9Hot5484IDV8oWbjrwy8orEe+3CbEFiSDwhrsnYaDd6MTbHCw9JQFbOD99Y8BtEIT17LxZ/eUnto1hxDCNHC/1ND8UflFTHsvVj1mlEova+Ulp7y94iL/e94UWAoAYHaUwhYt7Q5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dvjYfnXN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v6EoHCIevqCTqTDfvsK+4VK/BjZpUFy/AvhnLIsuVYs=; b=dvjYfnXNGT6LdoyvZZW6tg+MYs
	va6KhnHgg5K06XBsqiDyL0EGJPeIV4h0IWyRxhWVNp5jYCkyIxNehUMU8HRy+SbqA8Ccq6vsKPCPb
	pWjJqHnBufIg8YQj7YobMLsKl1DtrHGZHZXQhHMo6o4bx4KnbdDJ9ibOJhVMGm20dFCYw2h8OG85Y
	NM8k/ntIhJ/TEm+Rxof7xkxL1SW3lmlRW8sDcMJdLtNzNqkKcfUVxeuRtzYUw+0jOIW8nGv95T6HF
	YLNnkllaLR/MHRWtMzb7XNNjEp+OM/8NfP7Jwqwm8Zg1hN1l7VH2VFdkGMCdpIRsUgilbSXTIzZhD
	JsIefd8Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBihN-00000000IGr-16mG;
	Sun, 04 May 2025 23:24:41 +0000
Date: Mon, 5 May 2025 00:24:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] MNT_LOCKED vs. finish_automount()
Message-ID: <20250504232441.GC2023217@ZenIV>
References: <20250501201506.GS2023217@ZenIV>
 <87plgq8igd.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plgq8igd.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 02, 2025 at 10:46:26PM -0500, Eric W. Biederman wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > 	Back in 2011, when ->d_automount() had been introduced,
> > we went with "stepping on NFS referral, etc., has the submount
> > inherit the flags of parent one" (with the obvious exceptions
> > for internal-only flags).  Back then MNT_LOCKED didn't exist.
> >
> > 	Two years later, when MNT_LOCKED had been added, an explicit
> > "don't set MNT_LOCKED on expirable mounts when propagating across
> > the userns boundary; their underlying mountpoints can be exposed
> > whenever the original expires anyway".  Same went for root of
> > subtree attached by explicit mount --[r]bind - the mountpoint
> > had been exposed before the call, after all and for roots of
> > any propagation copies created by such (same reason).  Normal mount
> > (created by do_new_mount()) could never get MNT_LOCKED to start with.
> >
> > 	However, mounts created by finish_automount() bloody well
> > could - if the parent mount had MNT_LOCKED on it, submounts would
> > inherited it.  Even if they had been expirable.  Moreover, all their
> > propagation copies would have MNT_LOCKED stripped out.
> >
> > 	IMO this inconsistency is a bug; MNT_LOCKED should not
> > be inherited in finish_automount().
> >
> > 	Eric, is there something subtle I'm missing here?
> 
> I don't think you are missing anything.  This looks like a pretty clear
> cut case of simply not realizing finish_automount was special in a way
> that could result in MNT_LOCKED getting set.
> 
> I skimmed through the code just a minute ago and my reading of it
> matches your reading of it above.
> 
> The intended semantics of MNT_LOCKED are to not let an unprivileged user
> see under mounts they would never be able to see under without creating
> a mount namespace.
> 
> The mount point of an automount is pretty clearly something that is safe
> to see under.  Doubly so if this is a directory that will always be
> empty on a pseudo filesystem (aka autofs).

Does anybody have objections to the following?

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

The minimal fix is to have do_add_mount() treat MNT_LOCKED the same
way as other internal-only flags.  Longer term it would be cleaner to
deal with that in attach_recursive_mnt(), but that takes a bit more
massage, so let's go with the one-liner fix for now.

Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index 04a9bb9f31fa..352b4ccf1aaa 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3761,7 +3761,7 @@ static int do_add_mount(struct mount *newmnt, struct mountpoint *mp,
 {
 	struct mount *parent = real_mount(path->mnt);
 
-	mnt_flags &= ~MNT_INTERNAL_FLAGS;
+	mnt_flags &= ~(MNT_INTERNAL_FLAGS | MNT_LOCKED);
 
 	if (unlikely(!check_mnt(parent))) {
 		/* that's acceptable only for automounts done in private ns */

