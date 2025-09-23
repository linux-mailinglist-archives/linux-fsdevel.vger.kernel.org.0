Return-Path: <linux-fsdevel+bounces-62530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2832B97BCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 00:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C02F3222B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 22:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E61A30FC06;
	Tue, 23 Sep 2025 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkwvYkjE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372C312812;
	Tue, 23 Sep 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666888; cv=none; b=cwJAfQCMR1RUaHbm85gmvAalt35OdZkxfp6Ac4toWFUOWzUwdVhjKusiufmCilCN3J1K38woxQrXMpCzOpZLHgNR1AH6VnuiSwAGpRfTZilq2SXJmNN9/d6YMFsOXXAXoFgqxXJ6Gjqyrq5WeglmBE3+pi+8n40Z2RfmPKWvUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666888; c=relaxed/simple;
	bh=RDSGfBtPO3h7Dr4zZGayl3fUyKj2qbQ1oUeVZX3110E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss+2KZoVwBXC9/USHtACR/+DzUF/csIhZzV54ngbxeqLlk/AFN5bazcQ+7DICcwPRojGSChh9lQ8paI2iSu+iUzxkd5nE7/K2S21uEOtjVRVywTTNxcQgnK6X3KQGD4h+/219LS+dBNQ4QQFN7L0ukxY9TFnIj7DxoiouJ/Yknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkwvYkjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62068C4CEF5;
	Tue, 23 Sep 2025 22:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758666888;
	bh=RDSGfBtPO3h7Dr4zZGayl3fUyKj2qbQ1oUeVZX3110E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkwvYkjEcCiG9mQ0UtIPP52tBKKRfylmwHPt+INo0hVrTSesvq39RV1TBHvPzA71K
	 ChbUL2yIIqmUIbOyRypfUwJ5iZEiKUOwwcEtyPCJ2kpLX0djoCVXT9Qv8c+kn27sKz
	 XC6gAXUMrJZX7GEgbIgyYV171dbNIbVLnTYapC+bfggfEdY+LqMzFbrio3C1VxhDTd
	 POGSrAGDybnvfHaExgzfXuwQ4y5Qyta6adCzZpaCeVDS9FaA8REU//LkrKyC6lCG9X
	 c3R1Gx0pCxrm1YBWhR00/QXRniVYi8uF0V4t64//sQ57cyh1LLaARwmbhKEaaX6tA4
	 wttf7JVlLO+KA==
Date: Tue, 23 Sep 2025 15:34:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 2/8] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250923223447.GJ1587915@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
 <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com>
 <20250923145413.GH8117@frogsfrogsfrogs>
 <CAJfpegsytZbeQdO3aL+AScJa1Yr8b+_cWxZFqCuJBrV3yaoqNw@mail.gmail.com>
 <20250923205936.GI1587915@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923205936.GI1587915@frogsfrogsfrogs>

On Tue, Sep 23, 2025 at 01:59:36PM -0700, Darrick J. Wong wrote:
> On Tue, Sep 23, 2025 at 08:56:47PM +0200, Miklos Szeredi wrote:
> > On Tue, 23 Sept 2025 at 16:54, Darrick J. Wong <djwong@kernel.org> wrote:
> > 
> > > I'm not sure what you're referring to by "special" -- are you asking
> > > about why I added the touch_softlockup_watchdog() call here but not in
> > > fuse_wait_aborted()?  I think it could use that treatment too, but once
> > > you abort all the pending requests they tend to go away very quickly.
> > > It might be the case that nobody's gotten a warning simply because the
> > > aborted requests all go away in under 30 seconds.
> > 
> > Maybe I'm not understanding how the softlockup detector works.  I
> > thought that it triggers if task is spinning in a tight loop.  That
> > precludes any timeouts, since that means that the task went to sleep.
> > 
> > So what's happening here?
> 
> Hrm, I thought the softlockup detector also complains about tasks stuck
> in uninterruptible sleep, but you're right, it *does* schedule() so the
> softlockup detector won't complain about it.
> 
> I think.  Let me go try to prove that empirically. :)

Hrm.  If I change the bottom of the function to:

wait_event(fc->blocked_waitq, <some false expression>);

Then I get softlockup warnings because the process state gets set to
UNINTERRUPTIBLE, schedule() is called to pick another process, and the
umount process never reaches runnable state ever again.

If instead I change it to:

while (wait_event_timeout(fc->blocked_waitq, <false expr>, HZ) == 0) {
	/* empty */
}

then I do not get softlockup warnings, because the umount process
actually does get scheduled off and on the system, repeatedly.

Conclusion: The loop is necessary to avoid softlockup warnings while the
fuse requests are processed by the server, but it is not necessary to
touch the watchdog in the loop body.

Thanks for challenging me, now I've learned something useful. :)

--D

