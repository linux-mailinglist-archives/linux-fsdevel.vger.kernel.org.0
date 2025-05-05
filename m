Return-Path: <linux-fsdevel+bounces-48018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF18AA8B89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 07:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE1D16C457
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 05:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BE1581EE;
	Mon,  5 May 2025 05:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="e/YnO4ua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939B139E
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746421740; cv=none; b=HKp7Qq1LohVm1l+KQ9g7jwpHkfhvnzgYB27LhP6eieWDrgKhCTXM5tKQLzFaccKbtkFOaf4qriB7cCRTFR1+beJQaXCURfMOHuReknLpQdL92gJSGiV7NXmYlTUq6OeIgKW0k6rEvbrDkyzHERWjzKDCcFXmjZgiIFjJmWYeOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746421740; c=relaxed/simple;
	bh=FEhP/LpnxopQuDaKfcZq/kOLsXYjj1618kRCujF86us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPhv6EggrNeqbWEUr2WUJ7IQo1u9uX0mRmCxescIrsrlsZxObvJbUP9lyYwxuSn5BzadpKxU57wikuVIYuBmP4IvIT8NiazJSeVw/bDs3/NbE1HtrRKIlgMFS1LarFg1q+rziANAnUQ1ez7nvpsBfx0uITJfnVNXRiHZBJeIasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=e/YnO4ua; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VkHhpXwEcahncYjhuZNR4kybmcZKvkTGpBJcbGX4xug=; b=e/YnO4ua+pzN/ziwusCh7sbzcJ
	y0mZI79wzkiWYkcfAcyuIUwg0pMc5u42IVU7V4nse8RW0YPt6TlL8BMM5+82svkWlJ+Ta0nCW5xh6
	yaaW6TnriADmoicboqW9o0PNCYXeOWgY0x4nUa5GKuF6QDty788byE+R1RQAG7pZmzICVbVLOLmgg
	xy+27Y1hXVNU7/aZSVQ51QCGS/Ro0w0zw+/LYJ7BUUuYJ7rHwfAUWkdM82oIv/vFXyjhZAz8I2qIa
	1PdjomN+No2JOst6hxMu8AKseJFlQYctFiGMxk2GPNUjbZARUahVdhTaA5niEk2dgGYSdBh2EnFc6
	aJ9J4dsQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBo4V-0000000219E-36Go;
	Mon, 05 May 2025 05:08:55 +0000
Date: Mon, 5 May 2025 06:08:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250505050855.GE2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250429040358.GO2023217@ZenIV>
 <20250429051054.GP2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429051054.GP2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 29, 2025 at 06:10:54AM +0100, Al Viro wrote:
> On Tue, Apr 29, 2025 at 05:03:58AM +0100, Al Viro wrote:
> > On Mon, Apr 28, 2025 at 07:53:18PM +0100, Al Viro wrote:
> > 
> > > FWIW, I've a series of cleanups falling out of audit of struct mount
> > > handling; it's still growing, but I'll post the stable parts for review
> > > tonight or tomorrow...
> > 
> > _Another_ fun one, this time around do_umount().
> 
> ... and more, from 620c266f3949 "fhandle: relax open_by_handle_at()
> permission checks" - just what is protecting has_locked_children()
> use there?  We are, after all, iterating through ->mnt_mounts -
> with no locks whatsoever.  Not to mention the fun question regarding
> the result (including the bits sensitive to is_mounted()) remaining
> valid by the time you get through exportfs_decode_fh_raw() (and no,
> you can't hold any namespace_sem over it - no IO allowed under
> that, so we'll need to recheck after that point)...

FWIW, looking at do_move_mounts(): some of the tests look odd.

        if (is_anon_ns(ns)) {
                /*
                 * Ending up with two files referring to the root of the
                 * same anonymous mount namespace would cause an error
                 * as this would mean trying to move the same mount
                 * twice into the mount tree which would be rejected
                 * later. But be explicit about it right here.
                 */
                if ((is_anon_ns(p->mnt_ns) && ns == p->mnt_ns))
                        goto out;

Why are we checking is_anon_ns(p->mnt_ns) here?  If ns is equal
to p->mnt_ns, we have just verified that is_anon_ns() is true for it;
if it is not, there's no point bothering with is_anon_ns() since
conjunction is false anyway.  And it's not as if that comparison
had been unsafe to calculate if is_anon_ns(p->mnt_ns) is false...

Looks really really confusing - is there a typo somewhere?  Why
not simply
        if (is_anon_ns(ns)) {
		/*
		 * Can't move the root of namespace into the same
		 * namespace.  Reject that early.
		 */
		if (ns == p->mnt)
			goto out;
What am I missing here?

Another odd thing: what's the point rejecting move of /foo/bar/baz/ beneath
/foo?  What's wrong with doing that?  _IF_ that's really intended, it needs
at least a comment spelling that out.  TBH, for quite a while I'd been
staring at that wondering WTF do you duplicate the common check for target
not being a descendent of source, but with different error value.  Until
spotting that the check is about _source_ being a descendent of target
rather than the other way round...

