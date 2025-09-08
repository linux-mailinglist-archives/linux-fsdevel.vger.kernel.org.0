Return-Path: <linux-fsdevel+bounces-60466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D888B481B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 02:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82003B3AA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 00:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79D336124;
	Mon,  8 Sep 2025 00:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iwXnW/lf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320729405
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757289982; cv=none; b=U/TyAoZ8dLWik5Hl4CR48VohPzrBQbXgTCDKvJODaapMiuSsM2+9djafsGBYKgffJE9GuKkhXYH2CRkMZvs7CS6xFetbgmlMo7Ck5VdMx/Q5dzjLUYtWSn2A4EqWa80eMmbszCvvTQijJoPMTi1EbD0b4AY/jfBzEh/llwZl9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757289982; c=relaxed/simple;
	bh=GFI6Fb99a/7vP3q0k5cNRBEuexw9FkrYut49JyIZRG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbM6EeRszAydcZ5YrIZfE8K7RA6O3fDqbpxI+2c3iq3DLIdLscytB86yqgtcCSQDClY0Uc1wtKHnBOiE30uqj5ogq+JcDjck3S4Wxe7Wz2VLpzRjpGfv2Nx6adEGJ3Y9rw+/VY8bH5c76AxJGdjDYwZL3Bd5SlXpK9mbDWZ4nzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iwXnW/lf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wdoFa+nwn/3dbz01PVOAnMcw4Rb17lJsGu+YubN3A1Q=; b=iwXnW/lfj+jdyHEryQ8oeNic7L
	5c0PmhWsewqeDBl0APsXXtYrd3obWPbRanSC5bhTUZwDoPD4u/+PFyhVifOaiuWRqgxK2xcz2x4kh
	RLxxnU7AT+XgvDD0ql78RV1zrNxF7wg9J2uooNG7xPyN3CJz2LJCw5xeJRhkzQIFCZpIKiMtwBK6F
	EB8kYe7kH16oCPcIfz8cOS3u0ViYM8Kd3cnIXv5T8RImvSEMs7laPaXGMsokY1pH74eIHEMNmyYef
	x1v9aYDHO8oIj1ZJoIpRzs+22Z3ioHBH1hO6ZWWOGCTolWEHedFUmsCgI+pE4dj+G9RR+TcDRoGdE
	VFmTRX+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvPOj-0000000AchI-2gd3;
	Mon, 08 Sep 2025 00:06:17 +0000
Date: Mon, 8 Sep 2025 01:06:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
Message-ID: <20250908000617.GF31600@ZenIV>
References: <20250907203255.GE31600@ZenIV>
 <CAHk-=wif3NXNMmTERKnmDjDBSbY3qdFgd5ScWTwZaZg0NFACUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wif3NXNMmTERKnmDjDBSbY3qdFgd5ScWTwZaZg0NFACUw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 07, 2025 at 02:51:18PM -0700, Linus Torvalds wrote:
> On Sun, 7 Sept 2025 at 13:32, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         I would like to discuss a flagday change to calling conventions
> > of ->create()/->unlink()/->rename()/etc. - all directory methods.
> > It would have no impact on the code generation, it would involve
> > quite a bit of localized churn and it would allow to deal with catching
> > ->d_name races on compiler level.
> 
> Can you make this more concrete by actually sending an example patch.
> 
> Well, two patches: first the patch for the "claim_stability" helper
> type and functions, and then a separate patch for converting _one_ of
> the users (eg 'symlink').
> 
> Because I have a hard time visualizing just how noisy the result would
> be (and whether it would be legible end result).

Will do...  BTW, for a non-obvious example of the things that show up
in process: ceph_wait_on_conflict_unlink() is actually guaranteed that
its argument is stable.  The way it copies ->d_name locally (with
a good reason - there's a loop using that for comparisons, so it's
a valid optimization) would otherwise be seriously racy.

> And I do wonder if it might not be simpler to have a model where
> filesystems always get a stable dentry name - either because we hold
> the parent lock on a VFS level (fairly common, I think), or because we
> pass a separate copy to the filesystem
> 
> You did that with the d_revalidate() callback, and I think that was a
> clear success. Can we extend on *that* pattern, perhaps?

Umm...  For one thing, there's something wrong with passing two arguments
that always differ by constant offset (and type, of course)...  More
serious reason is that in quite a few cases we want both dentry and stable
name accessible for a helper called from those (ceph_wait_on_conflict_unlink(),
for example).  And for those we either have to pass both dentry and const
struct qstr * or we still have to trace their call chains every time we
do that audit.  Passing struct stable_dentry instead avoids that...

