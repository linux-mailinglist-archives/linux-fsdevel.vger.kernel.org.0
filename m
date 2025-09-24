Return-Path: <linux-fsdevel+bounces-62669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C477B9C350
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 22:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB1317656E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9BD328960;
	Wed, 24 Sep 2025 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXo55Lt7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE3263899;
	Wed, 24 Sep 2025 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747267; cv=none; b=CtZXtDX2VRNj8rXnW6AaUYfopSE1jvdfyDxPPLZ1JETXI2k6rjlidpFmLWDiHx18A77u9bOXWhlpJFXQIXuD7pQ4StN+0G1Oy98WTO+qLfHZJ62a5eNgKBAVXBh2VWGMCN5HFo4Un15jyNpBGj1mI8OsQsk8lZas6dElzHRG854=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747267; c=relaxed/simple;
	bh=xWH1TxsNZ8dxcOdQEdnQYvj3FtwyhW6MXLZfRkmrTJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5RW7vC9l560F4NLUCUQUKc10kl2Q45ZCYPD+e5LOSF1sQPGY9M0IKdRZ6SRnQwSuYoNa4WuT7UeNHAdFX1x+4Fq4EkUEmriJfCh8EZoDXv1AXCGGmba/P85DGPDlNPk8U+X6VK1eWjTbA1xDy9aKJSnyIV1Yqf/OEs+bfteSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXo55Lt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97D0C4CEE7;
	Wed, 24 Sep 2025 20:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758747267;
	bh=xWH1TxsNZ8dxcOdQEdnQYvj3FtwyhW6MXLZfRkmrTJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXo55Lt7M34RKB6ulpym/caKqGhZ4FdA3Bvjp1Xy2zHmJSN1YmXhG1G8FBOZVfbDK
	 sjszWKK3iVAGsfNO5RpL2Pwk6C239yh940u/JHxDZjw8f62pLgCYyX3qQHkf0uiHRZ
	 rZ5Sw2y8K7vAlJBO/PByR6JgcviZz39Z2FlTzssBXZzYjdpfXwxsJDO+PFO/PYiwB4
	 fB4W25One9ijU96b0hc+ARDWrPoPr1a6VnUtkxBAAH4O8T2OdLG7FMI+IYtkDN62ZI
	 wKCAPRHVXpzs+ObqStdz874bq3/jcHK9Fwd3NcJ8kKZaBqHSqqVGaQ2c2QbcKprrEN
	 ZO6OEIHiaX7yQ==
Date: Wed, 24 Sep 2025 13:54:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 2/8] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250924205426.GO1587915@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
 <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com>
 <20250923145413.GH8117@frogsfrogsfrogs>
 <CAJfpegsytZbeQdO3aL+AScJa1Yr8b+_cWxZFqCuJBrV3yaoqNw@mail.gmail.com>
 <20250923205936.GI1587915@frogsfrogsfrogs>
 <20250923223447.GJ1587915@frogsfrogsfrogs>
 <CAJfpegthiP32O=O5O8eAEjYbY2sAJ1SFA0nS8NGjM85YvWBNuA@mail.gmail.com>
 <20250924175056.GO8117@frogsfrogsfrogs>
 <CAJfpegsCBnwXY8BcnJkSj0oVjd-gHUAoJFssNjrd3RL_3Dr3Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsCBnwXY8BcnJkSj0oVjd-gHUAoJFssNjrd3RL_3Dr3Xw@mail.gmail.com>

On Wed, Sep 24, 2025 at 08:19:59PM +0200, Miklos Szeredi wrote:
> On Wed, 24 Sept 2025 at 19:50, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > The wait_event_timeout() loop causes the process to schedule at least
> > once per second, which avoids the "blocked for more than..." warning.
> > Since the process actually does go to sleep, it's not necessary to touch
> > the softlockup watchdog because we're not preventing another process
> > from being scheduled on a CPU.
> 
> To be clear, this triggers because no RELEASE reply is received for
> more than 20 seconds?  That sounds weird.  What is the server doing
> all that time?
> 
> If a reply *is* received, then the task doing the umount should have
> woken up (to check fc->num_waiting), which would have prevented the
> hung task warning.
> 
> What am I missing?

(Note: I set /proc/sys/kernel/hung_task_timeout_secs to 10 seconds to
generate the 20 second warning)

I think what you're missing is the fuse server taking more than 20
seconds to process one RELEASE command successfully.  Say you create a
sparse file with 1 million extents, open it, and unlink the the file.
The file's still open, so the unlink can't truncate it or free it.

Next, you close the file and unmount the filesystem.  Inode eviction
causes a RELEASE command to be issued, so the fuse server starts
truncating the file to free it.  There's a million extents to free, but
the server is slow and can't process more than (say) 1000 extent freeing
operations per second.  That implies that the truncation will take 1000
seconds to complete, which means the reply to the RELEASE doesn't arrive
for 1000 seconds.  Meanwhile, the umount process doesn't see a change in
fc->waiting for 1000 seconds, so it isn't woken up for that amount of
time and we get the stuck task warning.

I think we don't want stuck task warnings because the "stuck" task
(umount) is not the task that is actually doing the work.  For an
in-kernel filesystem like XFS, the inode eviction process would be
generating enough context switches from all the metadata IOs to avoid
the hung task warning.

--D

> Thanks,
> Miklos
> 

