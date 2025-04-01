Return-Path: <linux-fsdevel+bounces-45446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A243A77B97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 15:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23931188F5CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 13:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622920370D;
	Tue,  1 Apr 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF1PWZIm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09115155A30;
	Tue,  1 Apr 2025 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512620; cv=none; b=vGvUvy0e3UEZCqL8CIVRxviSD3XxU9WvCC+DJpglsIhL1oi0ZGIK4Uc3mSzERMetBjKuWZQuj4BvJ8GYfw8PuJ5/EGQ3YtO5HNQiFYuNhfSBRc5yF7BB757E1Ot6neslmx86oQihMkiCNxa+goes2XqokX465MHZuyH3Zq53bu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512620; c=relaxed/simple;
	bh=IfPNnUAgREsDtieKgyqwxU3MQRWieUHArEzsESiBSSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZWg6mhGsC5RYnpVgVToJIrOOJvAd2W/7ZJb3UX2etQ6Eyr+wEz9Yww1s+ggztmwxH/9pr9ZIKZxptoyJVAeBFMx04cRHRche1GPcy/0XSPUR+9jofXJYbpZU5AA9cLCbXWbmuKC8KFsp1rWji0v3JlW+qPok9Pb568cnTRMGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF1PWZIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD417C4CEE5;
	Tue,  1 Apr 2025 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743512619;
	bh=IfPNnUAgREsDtieKgyqwxU3MQRWieUHArEzsESiBSSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iF1PWZImdgmJodvlmJsnW1yNFF3eOjqfkHF9QrZ9o5pURWuPCAkufILXmLC7Y779I
	 +zgThECJTwsE0MXVfz29LLVeFxgsBZRqvfzdHnl5wEUL31LjRXIa+3grRcUwOzPzI1
	 2dzsbZhUkHDpaqhQRwsic51EQtTegpRAOa03MXFBiX9vy4x1CUMRw6i/d6SGsxcllN
	 2QTLmx/vP4N0zd+TwIuDTsmbw02dtNWRK4/IQ8kMDULrXWR5PrJW9c/NlUXO4RUAAh
	 r0wBSVRxU75/w1KcNu7C9t4BQaP8urV6pencghCtBk5KBDogfYBJcSnT0IGcbJsW4r
	 gyxJVAdC3KaRA==
Date: Tue, 1 Apr 2025 15:03:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, rafael@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 0/6] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <20250401-kindisch-lagen-cd19c8f66103@brauner>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <s6rnz3ysjlu3rp6m56vua3vnlj53hbgxbbe3nj7v2ib5fg4l2i@py4pkvsgk2lr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <s6rnz3ysjlu3rp6m56vua3vnlj53hbgxbbe3nj7v2ib5fg4l2i@py4pkvsgk2lr>

On Tue, Apr 01, 2025 at 11:32:49AM +0200, Jan Kara wrote:
> On Tue 01-04-25 02:32:45, Christian Brauner wrote:
> > The whole shebang can also be found at:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.freeze
> > 
> > I know nothing about power or hibernation. I've tested it as best as I
> > could. Works for me (TM).
> > 
> > I need to catch some actual sleep now...
> > 
> > ---
> > 
> > Now all the pieces are in place to actually allow the power subsystem to
> > freeze/thaw filesystems during suspend/resume. Filesystems are only
> > frozen and thawed if the power subsystem does actually own the freeze.
> > 
> > Othwerwise it risks thawing filesystems it didn't own. This could be
> > done differently be e.g., keeping the filesystems that were actually
> > frozen on a list and then unfreezing them from that list. This is
> > disgustingly unclean though and reeks of an ugly hack.
> > 
> > If the filesystem is already frozen by the time we've frozen all
> > userspace processes we don't care to freeze it again. That's userspace's
> > job once the process resumes. We only actually freeze filesystems if we
> > absolutely have to and we ignore other failures to freeze.
> 
> Hum, I don't follow here. I supposed we'll use FREEZE_MAY_NEST |
> FREEZE_HOLDER_KERNEL for freezing from power subsystem. As far as I
> remember we have specifically designed nesting of freeze counters so that
> this way power subsystem can be sure freezing succeeds even if the
> filesystem is already frozen (by userspace or the kernel) and similarly
> power subsystem cannot thaw a filesystem frozen by somebody else. It will
> just drop its freeze refcount... What am I missing?

If we have 10 filesystems and suspend/hibernate manges to freeze 5 and
then fails on the 6th for whatever odd reason (current or future) then
power needs to undo the freeze of the first 5 filesystems. We can't just
walk the list again because while it's unlikely that a new filesystem
got added in the meantime we still cannot tell what filesystems the
power subsystem actually managed to get a freeze reference count on that
we need to drop during thaw.

There's various ways out of this ugliness. Either we record the
filesystems the power subsystem managed to freeze on a temporary list in
the callbacks and then walk that list backwards during thaw to undo the
freezing or we make sure that the power subsystem just actually
exclusively freezes things it can freeze and marking such filesystems as
being owned by power for the duration of the suspend or resume cycle. I
opted for the latter as that seemed the clean thing to do even if it
means more code changes. What are your thoughts on this?

