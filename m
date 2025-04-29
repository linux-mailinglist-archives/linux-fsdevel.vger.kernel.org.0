Return-Path: <linux-fsdevel+bounces-47596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D81AA0B97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 14:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62EF27A5465
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57782C17A7;
	Tue, 29 Apr 2025 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WmmLLIO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987D2139B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929651; cv=none; b=SXVxNlmU3B21NLB2qJvtF0irlVHA4yA7MIrKxXPZsuw7DGd6Jgr4/FCm8SkYey7BOQcwa2wDS+fM8hvb7DlborS+uNEJJJxX+Ncqm2dC1byX/RLBM5q9Cqat7sFmDfnIP4TT6/KEQam5AtaAEpVTgvvP/K2Tgc0k7JopUUgV+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929651; c=relaxed/simple;
	bh=n18CIYv/ftWUZTL2nFGlTID3l9Hp7ubaXhLIK2EJIHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5bJzNbyLCA+MJJJNXw/REih6dFgr8M2vNdDnvqCVclXZIQfpstD208C5rcamYyYinshwesr8sXiG47slkGpzhgXhi0QhJBlCgqzlFx5Q292pkmsrBIL/oXNhKYhycvozG4JUGn1ZxrDSTzO58kqcXe2VrNqZlG+xV0GnVA+hos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WmmLLIO/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UAk+qvMxatIWvNNqDtCYUZ2WLMGYirYIfA4wyAuXIcU=; b=WmmLLIO/NdHx1iJum4DlRBnSZk
	+HcCrGwBBCWV1p9qXdK2yeQi6zzbnRg7TFd4WBJjNzPA3oZFtXq6KICMZpF/9rSOJSVef8IqA5KaA
	gnBiEQR47dU0/vCsQhVRWgqq0jBvZyAx84HiKhtAIs7B8NaKnrpdOf/HLZT8t9YfgRRUfB2Bx3dor
	CEwgOwL7dCjERvv9U80BMo5jfMvmVXA/SHfB8gJO5eHjSdaUG1qEx4VbhWRTzpUstKEVxtsQHcalO
	HFXDZMTJ/0jxCvZZNPhBcvtEFQXTY1zDYiaRMUxX0lfqpEF5IcoRTt9iUJlPjLRdmnlb693XXHn0p
	otUHJpLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9k3b-0000000FBRh-0Ek5;
	Tue, 29 Apr 2025 12:27:27 +0000
Date: Tue, 29 Apr 2025 13:27:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250429122727.GR2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250429040358.GO2023217@ZenIV>
 <20250429-fakten-anfliegen-6cf13f1292d0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429-fakten-anfliegen-6cf13f1292d0@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 29, 2025 at 09:56:14AM +0200, Christian Brauner wrote:
> On Tue, Apr 29, 2025 at 05:03:58AM +0100, Al Viro wrote:

> > by __legitimize_mnt().  It is considerably harder to hit, but I wouldn't
> > bet on it being impossible...
> 
> Most of these issues are almost impossible to hit in real workloads or
> it's so rare that it doesn't matter. This one in particular seems like a
> really uninteresting one. I mean, yes we should probably add that
> barrier there but also nobody would care if we didn't.

Rule of the thumb: whenever you see a barrier, the need to understand
everything that's going on with the function goes up a _lot_.
Especially when one of those suckers is in a seriously hot codepath
(and __legitimize_mnt() qualifies).  I certainly agree that this one is
not critical - said so right in commit message, but one thing we need in
the area is to review the locking; not only the majority of comments are
badly obsolete (anything that mentions vfsmount_lock, for starters), but
we also have fun questions about the mount_lock users - which ones need
to touch seqcount component (and full lock_mount_hash()) and which ony
need the spinlock side.  Same for RCU delays - witness the thread that
got me started on reviewing the locking/refcounting/lifetimes in there.

Another piece of fun: there are grades of struct mount accessibility;
to a very limited extent it becomes reachable as soon as we put it into
the per-superblock list, even before the damn thing is returned to caller
of clone_mnt().  There's only one thing that can get to them that way -
sb_prepare_remount_readonly().  But that includes modifications of
->mnt_flags - setting and clearing MNT_WRITE_HOLD.  Which makes
CLEAR_MNT_SHARED(mnt) in clone_mnt() (as well as set_mnt_shared(mnt)
in CL_MAKE_SHARED case) racy, and not harmlessly so.  This one is
trivial to fix (set ->mnt_flags before attaching to superblock and
inserting into the list), but there are several places in similar spirit
where reordering doesn't solve the problem (e.g. fs/overlayfs/super.c
playing with the flags on clone_private_mnt() results).  I *really*
don't want to export mount_lock and only slightly less so - a generic
helper for adding to/removing from flags, so sane API needed in
this case is an interesting question...

I'm putting together documentation on struct mount, will post it
once it's reasonably complete.

