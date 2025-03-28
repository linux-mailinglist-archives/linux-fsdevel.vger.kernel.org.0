Return-Path: <linux-fsdevel+bounces-45221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EF4A74E22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64FAD7A5D7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C041D79B1;
	Fri, 28 Mar 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvtGKwOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7EC1D5ADB;
	Fri, 28 Mar 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177166; cv=none; b=GT4YpQzgpnZdu4KKdTKurA6gBCIfe0qkh5VOFHp3DS6YZ+JeBRw2+XERSnVPzdFnXaePVnfXDJEUDJeCkjmr4ztGnMluSjFXgfLG5wTutF2LrMmcoeQZsGoQvbp6k1hJtVrTxEr/U9x+dvlJuBQZoS3oeS6kXIqQDfL3oHD7zIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177166; c=relaxed/simple;
	bh=KEJUdBRqRmD++BUGqzfKRSAkmfYbg8i/jOrvqvnnEnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ory8RLaOyWUYpAkZZTa3D4vyNRvQqapP98Mjo+YrpYCSltUAMHrldvGK0/w/DOL73X6KZBayxMHF6/+ez7fdTHcWUnZjzLcuwBGqJbgX4PgUsZlb7EQ7n/KCI87ouhh1lq4xGVbTXQdVLciPkmQSogsxDHlK+AqIWj7FqcCZ2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvtGKwOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C63C4CEE4;
	Fri, 28 Mar 2025 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743177165;
	bh=KEJUdBRqRmD++BUGqzfKRSAkmfYbg8i/jOrvqvnnEnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvtGKwOBKBHr/ITrQbHHYk53bz+T6SvN8O19RHqFYL62hwxFbO03kJP8JLx6jr0I4
	 7fgRlOHEgmQCC9YCSdqFYNJN1IuYHSQqv/QxJJdaN81yNAq/GGPkD75EQ/IxK7TP8v
	 tPbWoJYMxXZ1TYuOJBdqP/O0mrv1vzXHaA+E/LTSjtrLzUmihleSqJ7LMGklQEpud3
	 Ucq8aQbqKyDusSBbYKdYjM2fciEfTN+YNSyLJ4J/0kKFddJLMrTNlZdeeOnXtZXSV7
	 njYns1dLt0YGWJTGOGiBLc9N75HO2oEwP0hA5CnpyNWTfM12++VnG9c7SEyXQpgXVO
	 NwFnC+/vJGt1Q==
Date: Fri, 28 Mar 2025 16:52:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, jack@suse.cz, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [RFC PATCH 4/4] vfs: add filesystem freeze/thaw callbacks for
 power management
Message-ID: <20250328-ungnade-feldhasen-4a447a33068c@brauner>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
 <20250327140613.25178-5-James.Bottomley@HansenPartnership.com>
 <20250328-luxus-zinspolitik-835cc75fbad5@brauner>
 <cd5c3d8aab9c5fb37fa018cb3302ecf7d2bdb140.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd5c3d8aab9c5fb37fa018cb3302ecf7d2bdb140.camel@HansenPartnership.com>

> Since this is a hybrid thread between power management and VFS, could I
> just summarize what I think the various superblock locks are before
> discussing the actual problem (important because the previous threads
> always gave the impression of petering out for fear of vfs locking).
> 
> s_count: outermost of the superblock locks refcounting the superblock
> structure itself, making no guarantee that any of the underlying
> filesystem superblock structures are attached (i.e. kill_sb() may have
> been called).  Taken by incrementing under the global sb_lock and
> decremented using a put_super() variant.

and protects the presence of the superblock on the global super lists.

> 
> s_active: an atomic reference counting the underlying filesystem
> specific superblock structures.  if you hold s_active, kill_sb cannot
> be called.  Acquired by atomic_inc_not_zero() with a possible failure
> if it is zero and released by deactivate_super() and its variants.

or deactivate_locked_super() depending on whether s_umount is held or
not.

> 
> s_umount: rwsem and innermost of the superblock locks. Used to protect

No, it's not innermost. super_lock is a spinlock and obviously doesn't
nest with the semaphore. It's almost always the outmost lock for what
we're discussing here. Even is the outermost lock with most block device
locks.

It's also intimately tied into mount code and has implications for the
dcache and icache. That's all orthogonal to this thread.

> various operations from races.  Taken exclusively with down_write and
> shared with down_read. Private functions internal to super.c wrap this
> with grab_super and super_lock_shared/excl() wrappers.

See also the Documentation/filesystems/lock I added.

> 
> The explicit freeze/thaw_super() functions require the s_umount rwsem
> in down_write or exclusive mode and take it as the first step in their
> operation.  Looking at the locking in fs_bdev_freeze/thaw() implies
> that the super_operations freeze_super/thaw_super *don't* need this
> taken (presumably they handle it internally).

Block device locking cannot acquire the s_umount as that would cause
lock inversion with the block device open_mutex. The locking scheme
using sb_lock and the holder mutex allow safely acquiring the
superblock. It's orthogonal to what you're doing though.

