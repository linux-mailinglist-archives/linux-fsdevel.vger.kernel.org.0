Return-Path: <linux-fsdevel+bounces-54188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F7DAFBE32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 00:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DA11AA39E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4490425A359;
	Mon,  7 Jul 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TJ/NyMbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3491CAA6C;
	Mon,  7 Jul 2025 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926761; cv=none; b=tY9JVpXTwlXzfLxhBwIzm1EzxIxVL/VGpJy89WE/bfuCGCLVSzkc1ld7MkiQoCjxjLqa7aioPgIQP+VVHQNQYieyB2QVSrjnN+pBtWGheGgWRimYfEMKyWeR9eSKKo0g/mBI4weLhYCsPSOIa4eYecT+cE3w5vIsa11iKEnb5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926761; c=relaxed/simple;
	bh=d/pD4l50qB/+exeQR72Wr/rSix9IINeIPBJPur/b73E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gw5/WY6q1/EZP6vMiQ+duTphbJIgTDjfFhfVM0M5YISqw2q0oavx1DzF3M2zgiDkUr90Y2OG8y6Q69NIOD3b2//NuTHFTyItz7xtM4JVKSaKNl12XVVDDtJCthTOxR9vbFK1mtlOV7kdtXMKDzbRfIlM7fW0nTC4JcIRs2ygA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TJ/NyMbA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=Pq0EGLq1omLRWLWiAcIZwGlMCmRfydbLhtcyuAgUVgY=; b=TJ/NyMbARp8O7XoOPD64/ztRjH
	26SOVi6Bwy8kZdsSVDEVoSyd7OUeFRqs/ZO7SJ86hij8bzYwFZJkAwWWK+vp0N/MdroIfRg/apPZm
	gFM0hY3/S6GTrrEul2PiCI/VkHpt8G9r1kGS7aZiViVFvvaPheZA7FpHXfGiuHXrgmPnsJUnA2Q5X
	25Wg/0wA7sFGWb4jlK6MA6Sw4f31ePwHAJm1H7xNhJ8ymVoDOhEG2nlE8rGSgEL2xKrmMF8F6Ke1c
	VUY6mDTMRiPVyOuKf7oMBKz9Mp4RMc6eh0Oy20gITOrIzZH3zheefHMceirGNk7/MaypZhWgH8yv0
	w0qVmLrg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYuBB-00000004FH1-3xZP;
	Mon, 07 Jul 2025 22:19:18 +0000
Date: Mon, 7 Jul 2025 23:19:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20250707221917.GO1880847@ZenIV>
References: <20250707193115.GH1880847@ZenIV>
 <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV>
 <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
 <20250707204918.GK1880847@ZenIV>
 <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
 <20250707205952.GL1880847@ZenIV>
 <CAKPOu+8zjtLkjYzCCVyyC80YgekMws4vGOvnPLjvUiQ6zWaqaA@mail.gmail.com>
 <20250707213214.GM1880847@ZenIV>
 <CAKPOu+-JxtBnjxiLDXWFNQrD=4dR_KtJbvEdNEzJA33ZqKGuAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+-JxtBnjxiLDXWFNQrD=4dR_KtJbvEdNEzJA33ZqKGuAw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 11:47:04PM +0200, Max Kellermann wrote:
> On Mon, Jul 7, 2025 at 11:32 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > The second d_walk() does not have the if (!data.found) break; after it.
> > So if your point is that we should ignore these and bail out as soon as we
> > reach that state, we are not getting any closer to it.
> 
> Not quite. My point is that you shouldn't be busy-waiting. And
> whatever it is that leads to busy-waiting, it should be fixed
> 
> I don't know how the dcache works, and whatever solution I suggest,
> it's not well-founded. I still don't even know why you added that "<0"
> check.

Take a look at shrink_dcache_for_umount().  We really should not progress
past it in such situation.  And dentry can be in a shrink list *WITHOUT*
the need to pin the superblock it belongs to.

> > The second d_walk() is specifically about the stuff already in some other
> > thread's shrink list.  If it finds more than that, all the better, but the
> > primary goal is to make some progress in case if there's something in
> > another thread's shrink list they are yet to get around to evicting.
> >
> > Again, what would you have it do?  The requirement is to take out everything
> > that has no busy descendents.
> 
> A descendant that is dying (i.e. d_lockref.count<0 but still linked in
> its parent because Ceph is waiting for an I/O completion), is that
> "busy" or "not busy"? What was your idea of handling such a dentry
> when you wrote this patch?

Not busy, unless there are other things pinning it down.  That's 100%
intentional.

