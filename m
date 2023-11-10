Return-Path: <linux-fsdevel+bounces-2707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6851B7E7A04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 09:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656EF1C20DAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 08:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E05D269;
	Fri, 10 Nov 2023 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Wx1OL1rG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050979FA
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 08:19:11 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B34D93D6
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 00:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DCTMRDVT5eqicOSsgcioYngcYG7bdDF5xsH/HIP+0k4=; b=Wx1OL1rGUrfo+tI57FsXscQs/m
	8fEeJM876393ZQLGCa5bLG6s/vHybdAGlPD1eGY1NKouX3wLGHhLBaeLLlsMhP6EkFwDGBIXlQfwp
	GClgCtL5srR8g7LBbyf9PzVJOHUdj7xb3iF2jGiy/rBACsijLg0rVmoWVnWrymzih+fN+SorPVPm2
	859lmzB5+tCBAXnkaFw8EZ1uHP0n9e0YMflxItNXG432uN1lNffBHLnLHV7GotQqh9rPGu2ZFvd3v
	xVvh2ot3rM793Buny+YAzAI2PWj0rRluKcPDs98zgLYxREsuswKab0Ru0SYxTl2udDRzo6xsQnVfa
	9rWLI5Eg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1MjK-00DoTg-1R;
	Fri, 10 Nov 2023 08:19:06 +0000
Date: Fri, 10 Nov 2023 08:19:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
Message-ID: <20231110081906.GM1957730@ZenIV>
References: <20231031061226.GC1957730@ZenIV>
 <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
 <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV>
 <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 09, 2023 at 09:57:39PM -0800, Linus Torvalds wrote:

> Anyway, what I'm actually getting at in a roundabout way is that maybe
> we should make D_UNHASHED be another flag in d_flags, and *not* use
> that d_hash.pprev field, and that would allow us to combine even more
> of these tests in dput(), because now pretty much *all* of those
> "retain_dentry()" checks would be about d_flags bits.
> 
> Hmm? As it is, it has that odd combination of d_flags and that
> d_unhashed() test, so it's testing two different fields.

Hmm, indeed.  The trouble is, we are getting tight on the ->d_flags bits.
Only two unassigned bits left (0x08000000 and 0x80000000).

DCACHE_COOKIE is defined (0x00002000), but unused.  Should've been
taken out when dcookie stuff went.

DCACHE_DENTRY_KILLED might be mergable with DCACHE_MAY_FREE now;
worth looking into.  In effect, DCACHE_MAY_FREE is set iff
we have both DCACHE_DENTRY_KILLED and DCACHE_SHRINK_LIST - and
the only place that checks it is guaranteed to have had
DCACHE_SHRINK_LIST.  Actually, that's nice - in terms of dentry
states we have
refcount > 0 <=> Busy
refcount == 0 <=> Retained
refcount < 0 && !KILLED <=> Dying
refcount < 0 && KILLED && !SHRINK_LIST <=> Freeing
refcount < 0 && KILLED && SHRINK_LIST <=> Husk.
<makes a note in the docs being written>

DCACHE_FALLTRHU is odd - it's never checked (or set, for that matter);
might be killable, might be intended for some overlayfs plans.

DCACHE_GENOCIDE might become killable, what with selinuxfs patch I've
got (apparently OK with selinux folks, will sort it out after -rc1).

OK, it's not as awful as I thought - one more bit won't hurt.
I'll go through the unlocked callers and see if any of those is
sensitive to separating setting that flag from hash list removal.
There might be dragons...

> Anyway, I really don't think it matters much, but since you brought up
> the whole suboptimal code generation..

FWIW, it's not all that suboptimal, at least with current gcc.  The thing
I'm really not sure about is whether that patch makes the whole thing
easier to follow - probably need to let it sit around for a week or so,
then look at it again; right now I don't trust my taste regarding that
particular change, having spent too much time today mucking with it ;-/

