Return-Path: <linux-fsdevel+bounces-50589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC148ACD8A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95CD175010
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 07:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815671F237D;
	Wed,  4 Jun 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSastmV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E358E433B3
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022596; cv=none; b=JUWT0P5cy508OnxXyZlnfvd21l5sh5KLxaUo4UktwzEh3q5SpCCJA4X9FWeaeGoDqQjk1/M87vSqS1NVR+RNe3+sbHVhkL8VqC71KaA9321eYtVhfy5AkgzFR41Dp34L4nHTRG+hCHRwYrILC/egWjvkK6BREfZGluA1JR1KDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022596; c=relaxed/simple;
	bh=EbkUH3R6rCHG/BS5wQimzTFeo0Ujd9YHoW9KrKFHATM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi4uBPLwvXSPLyJcsnx4NkFCbblobuo5LFecSm+Q+PRvzkBS9T2i8XrZKfRWEtsetW8OXZrjZtnqyWhorlSLMh7NJFho/9wLt3Qp/rl7MipQdvlEIyQWK1/szlcsnODD0ITJ+64YVAKKoKLITTqubyZ1AuOZwvwXidhPSpE5T/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSastmV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E488C4CEE7;
	Wed,  4 Jun 2025 07:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749022595;
	bh=EbkUH3R6rCHG/BS5wQimzTFeo0Ujd9YHoW9KrKFHATM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSastmV3x+hm4/svh7lrFH1X3Hpx8S9DRmNk+p2+3fdEn+2j3dKmRL76Bc4MiDzkt
	 saHZ4xxWXcEZr4rHAM/JWr0EdE6T/8kZFxsCF5EanWAq4rbevw40W+5TQ3XQlM3AiK
	 rCrv5MNQ4DGvmceXkM6YfqKFhe0KaFct4z8nkw+nQye+z6EjDMDUncrYruVhOe5kkC
	 zp26LdIjMv8OyLtp+bdks6BdwZoOekvSNS6nhOu3mlHyr0EwepMf0793Wz38Uo0ndd
	 Zww3xI1JC3oVqFuvQEKo6wtspowpjerp7z0YuTcPFxr1cqTcfA2n+kxXEcntn7aWnQ
	 Fuc1p8mEneftw==
Date: Wed, 4 Jun 2025 09:36:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] separate the internal mount flags from the rest
Message-ID: <20250604-trott-sekunde-3faf975af789@brauner>
References: <20250603204704.GB299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603204704.GB299672@ZenIV>

On Tue, Jun 03, 2025 at 09:47:04PM +0100, Al Viro wrote:
> 	Currently we use ->mnt_flags for all kinds of things, including
> the ones only fs/{namespace,pnode}.c care about.
> 
> 	That wouldn't be a problem if not for the locking.  ->mnt_flags is
> protected by mount_lock.  All writers MUST grab that.  Having lockless
> readers is unsurprising - after all, for something like noexec we want
> the current state of mount, whatever it happens to be.  If userland
> remounts something noexec and that races with execve(2), there's nothing
> to be done - it is a race, but not the kernel one.
> 
> 	However, for a bunch of flags we rely upon the fact that all
> changes in one of those are always done under namespace_sem (exclusive).
> It's not a lockless read - we do depend upon namespace_sem (shared) being
> sufficient to stabilize those particular bits.	MNT_SHARED is one such.
> Note that this flag is a part of propagation graph representation and
> namespace_sem is what protects the entire thing, so setting or clearing
> it under mount_lock alone would be a very bad idea.
> 
> Since MNT_SHARED sits in ->mnt_flags, we have to take mount_lock to set or
> clear it, leading to places like this:
>         if (IS_MNT_SHARED(from)) {
> 		to->mnt_group_id = from->mnt_group_id;
> 		list_add(&to->mnt_share, &from->mnt_share);
> 		lock_mount_hash();
> 		set_mnt_shared(to);
> 		unlock_mount_hash();
> 	}
> Non-empty ->mnt_share on a mount without MNT_SHARED would be a hard bug;
> these changes belong together.  Incidentally, lock_mount_hash() is an
> overkill here - read_seqlock_excl(&mount_lock) would be better...
> 
> The rules would be easier to follow if we took MNT_SHARED, MNT_UNBINDABLE,
> MNT_MARKED and possibly MNT_LOCKED and MNT_LOCK_* to separate field, protected
> by namespace_sem alone (MNT_LOCKED - depending upon how the path_parent() mess
> settles).

Agreed.

> 
> Yes, it's 4 bytes added into struct mount.  However, this
>         int mnt_id;                     /* mount identifier, reused */
> 	u64 mnt_id_unique;              /* mount ID unique until reboot */
> 	int mnt_group_id;               /* peer group identifier */
> 	int mnt_expiry_mark;            /* true if marked for expiry */
> is preceded and followed by a pointer, so we already have a gap there,
> _and_ there are other pending changes that kill ->mnt_umounting.  So the
> size of struct mount won't grow even on 32bit and would actually go down
> on 64bit.

I'm not at all worried about the size in this case.

> 
> Objections?  The thing I really want is clear locking rules for that
> stuff.  Reduced contention on mount_lock and fewer increments of its
> seqcount component wouldn't hurt either, but that's secondary...

Seems good to me!

> PS: despite being strictly namespace.c-internal, two flags must stay in
> ->mnt_flags - MNT_DOOMED and MNT_SYNC_UMOUNT - __legitimize_mnt() needs

Sure.

