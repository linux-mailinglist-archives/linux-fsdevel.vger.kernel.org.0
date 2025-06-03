Return-Path: <linux-fsdevel+bounces-50515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E142ACCE56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FB03A4AED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8022192E1;
	Tue,  3 Jun 2025 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="H0cNZqxV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF019ABC3
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983629; cv=none; b=klYRv0eIEP7IPginUoof5lr4yJxWTuHU2gc8BIdUmfek4+cf3t937lsYT+riOfbfn6xX8cWOJavr71Gbdz84Nt2zLgghHtLRZZFfca12KSiPBRLMT+zsdXGDOrDdIZpZ9hrEdrGskPLRGrH5ryYsIct7//kG3IUCyrtQ4eEXUK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983629; c=relaxed/simple;
	bh=ST7DBC8rOzBNPcx14cwjszn4apDL+ffkae7POoyxmRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kfcL0w2GtCWJwiQS1RSaft8vmJxfuUzeZVT1fdJ0AL41jAkxoTqPApnF5UKIFGRlPBDY5eLgad/nqWq3cj7lUNb8vH+De7AbvO5DctqPOXpxfBDfmfJNAeh8/MqtVEjhPRTtgZLC/G3mq2lqfMBH343dxRMRK1d8C/T444wQr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=H0cNZqxV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=I3YSTQytHzqFUXhUmgskgPRjZokKGNKwpnEQ4lSzsaE=; b=H0cNZqxV8FyFw9Riv6hA85G5Ed
	wkrj+VZG868FZW9o0yK84wUDZ+lKRdz20+nJHRPpJ/QKuIfDuqLSy0yWBjsdOQkoZMqiip8Ls7S+o
	a0utdK+VQOGRZwGHa2j6PURKSkOvCLUDhzpqTGSA0n2bxZpiNTScJYZDV2sJ0LlTH5LJbovMgPBNH
	PkLEn89tgBrCPqwz4kyrc/sD687w8i+adG6aHkrpJqcB33BKVDRU8NriDkpv94LW+hozaSfkf810w
	OtxRq4ahVK5KxnRrs+aB1m9PWvNf049yJWe1eDAqXKLt1+DD1/4gIzYs+QEh3sMXrmIeNQ3vuGcKt
	BPTL/dZA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMYXI-0000000H63q-2eK1;
	Tue, 03 Jun 2025 20:47:04 +0000
Date: Tue, 3 Jun 2025 21:47:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] separate the internal mount flags from the rest
Message-ID: <20250603204704.GB299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Currently we use ->mnt_flags for all kinds of things, including
the ones only fs/{namespace,pnode}.c care about.

	That wouldn't be a problem if not for the locking.  ->mnt_flags is
protected by mount_lock.  All writers MUST grab that.  Having lockless
readers is unsurprising - after all, for something like noexec we want
the current state of mount, whatever it happens to be.  If userland
remounts something noexec and that races with execve(2), there's nothing
to be done - it is a race, but not the kernel one.

	However, for a bunch of flags we rely upon the fact that all
changes in one of those are always done under namespace_sem (exclusive).
It's not a lockless read - we do depend upon namespace_sem (shared) being
sufficient to stabilize those particular bits.	MNT_SHARED is one such.
Note that this flag is a part of propagation graph representation and
namespace_sem is what protects the entire thing, so setting or clearing
it under mount_lock alone would be a very bad idea.

Since MNT_SHARED sits in ->mnt_flags, we have to take mount_lock to set or
clear it, leading to places like this:
        if (IS_MNT_SHARED(from)) {
		to->mnt_group_id = from->mnt_group_id;
		list_add(&to->mnt_share, &from->mnt_share);
		lock_mount_hash();
		set_mnt_shared(to);
		unlock_mount_hash();
	}
Non-empty ->mnt_share on a mount without MNT_SHARED would be a hard bug;
these changes belong together.  Incidentally, lock_mount_hash() is an
overkill here - read_seqlock_excl(&mount_lock) would be better...

The rules would be easier to follow if we took MNT_SHARED, MNT_UNBINDABLE,
MNT_MARKED and possibly MNT_LOCKED and MNT_LOCK_* to separate field, protected
by namespace_sem alone (MNT_LOCKED - depending upon how the path_parent() mess
settles).

Yes, it's 4 bytes added into struct mount.  However, this
        int mnt_id;                     /* mount identifier, reused */
	u64 mnt_id_unique;              /* mount ID unique until reboot */
	int mnt_group_id;               /* peer group identifier */
	int mnt_expiry_mark;            /* true if marked for expiry */
is preceded and followed by a pointer, so we already have a gap there,
_and_ there are other pending changes that kill ->mnt_umounting.  So the
size of struct mount won't grow even on 32bit and would actually go down
on 64bit.

Objections?  The thing I really want is clear locking rules for that
stuff.  Reduced contention on mount_lock and fewer increments of its
seqcount component wouldn't hurt either, but that's secondary...


PS: despite being strictly namespace.c-internal, two flags must stay in
->mnt_flags - MNT_DOOMED and MNT_SYNC_UMOUNT - __legitimize_mnt() needs
them there.  Could be folded together with a bit of massage, though, but
that's a separate story...

