Return-Path: <linux-fsdevel+bounces-60188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6241AB4288C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6647B66B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8BA362080;
	Wed,  3 Sep 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="e7T8sBwP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289942BF00A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923275; cv=none; b=fgxuahZugHjNdAc/dseCyD4ABBP0aCvLWwLWAFl+Kl1jnR5qzunNpu8IBRU8sG5ukyssptTYrypn4XqGPzttpNJWPg9D8DPdpbz5JLno+cJcT55BIWjBcpSGBVGLaLeL+cJVLwhH5Rox3TdwQ3JmQ5uz24+Z5g/DOdItxkGSTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923275; c=relaxed/simple;
	bh=seEhNtYIoFSjWhRcGYTTvNwrTWUQP+aG3RDX7BnjPS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfOP4yEqCRL5crR19aDG5semOS0cAWx0uIGmFBEVL9Mmd0VQfDprBUoQekDSBVO1xOOl/CzTqaWIFIZwg9uWD6itc5wwLnhBesM1MGNMd5t1UdWhVwqIXgolcnEBH118psRKY2mTkH07UF1dPEUmFaF8JY42wkzdGT/UNr3xlik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=e7T8sBwP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iw7DdGFJBPg05Vc38TL8e/KASlbyX1PeikJMRZcrrvA=; b=e7T8sBwP3No0nr5X7AqGvYHHjt
	jYwZksE36SKylE/011yfV0jr8a/JJ1xE4t1n9Ad75KGGiGfpFHm79mRTjdMIcakFwWRnZcp0Q9+FJ
	Rc8UbcNqBrkooDgddqElNnUKM/FJzJJN038ErE2w5EBItuvgNV2PceWR1A36eHvzkzaGZzIgGlORb
	iR8IrM1cN3lo1PHTqzzZW5s679SnJHMS4Qo3emqSofsOaFNwCEf8qxYqevg105JB6CDicW0PpG9tI
	FNdf/Bedc/5CjSKTue+jtDCw5DtGMtcKSkkZlB4odMtP9p5IZLB52j2U8yTX48+SLYF5s19rnDfCc
	+2wjgb+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uts05-000000040Ee-410r;
	Wed, 03 Sep 2025 18:14:30 +0000
Date: Wed, 3 Sep 2025 19:14:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCHES v3][RFC][CFT] mount-related stuff
Message-ID: <20250903181429.GL39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250828230706.GA3340273@ZenIV>
 <20250903045432.GH39973@ZenIV>
 <CAHk-=wgXnEyXQ4ENAbMNyFxTfJ=bo4wawdx8s0dBBHVxhfZDCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgXnEyXQ4ENAbMNyFxTfJ=bo4wawdx8s0dBBHVxhfZDCQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 03, 2025 at 07:47:18AM -0700, Linus Torvalds wrote:
> On Tue, 2 Sept 2025 at 21:54, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > If nobody objects, this goes into #for-next.
> 
> Looks all sane to me.
> 
> What was the issue with generic/475? I have missed that context..

At some point testing that branch has caught a failure in generic/475.
Unfortunately, it wouldn't trigger on every run, so there was
a possibility that it started earlier.  

When I went digging, I've found it with trixie kernel (6.12.38 in
that kvm, at the time) rebuilt with my local config; the one used
by debian didn't trigger that.  Bisection by config converged to
PREEMPT_VOLUNTARY (no visible failures) changed to PREEMPT (failures
happen with odds a bit below 10%).

There are several failure modes; the most common is something like
...
echo '1' 2>&1 > /sys/fs/xfs/dm-0/error/fail_at_unmount
echo '0' 2>&1 > /sys/fs/xfs/dm-0/error/metadata/EIO/max_retries
echo '0' 2>&1 > /sys/fs/xfs/dm-0/error/metadata/EIO/retry_timeout_seconds
fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output error)
fsstress: check_cwd failure
fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output error)
fsstress: check_cwd failure
fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output error)
fsstress: check_cwd failure
fsstress: check_cwd stat64() returned -1 with errno: 5 (Input/output error)
fsstress: check_cwd failure
fsstress killed (pid 10824)
fsstress killed (pid 10826)
fsstress killed (pid 10827)
fsstress killed (pid 10828)
fsstress killed (pid 10829)
umount: /home/scratch: target is busy.
unmount failed
umount: /home/scratch: target is busy.
umount: /dev/sdb2: not mounted.

in the end of output (that's mainline v6.12); other variants include e.g.
quietly hanging udevadm wait (killable).  It's bloody annoying to bisect -
100-iterations run takes about 2.5 hours and while usually a failure happens
in the first 40 minutes or so or not at all...

PREEMPT definitely is the main contributor to the failure odds...  I'm doing
a bisection between v6.12 and v6.10 at the moment, will post when I get
something more useful...

