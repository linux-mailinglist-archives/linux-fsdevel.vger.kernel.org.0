Return-Path: <linux-fsdevel+bounces-3791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 149507F86D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 00:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C525F282324
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 23:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21153DB8D;
	Fri, 24 Nov 2023 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5JyKpeT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7878171A4;
	Fri, 24 Nov 2023 23:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC53C433CB;
	Fri, 24 Nov 2023 23:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700869180;
	bh=Ogn+845qTwOUzabVqp8uPRtIkUvstrvt/X810JTWhnY=;
	h=Date:From:To:Cc:Subject:From;
	b=a5JyKpeTGvT2JsZr9HrVNpH/eu+1Tj/rtSpPUwBiRZf7/UGyozMtd+fH9cbvhKIyU
	 TkUExCE1/5FD8b9rUeQUWkrEDBrSbIbY7IebHj/IfOEikIyLx7yrTdTG9oXneX9EMl
	 S3/c0AWKqDHjiZ+YCmmDzZsl2MMqG9y/aL3ilVEXgPrcChw+k/vQBAdRYT58GHwZE3
	 bW2uWaxeuIWnJ+ksFvdrwsbtlSRqhsxC/ONRPsdHXeDvD3FDFtoSLyVkR8ibVrZkJP
	 w7qUrOrG1aYFv2fqezXKSrbQF7WXvyveJl63QIQ4n8mFzpuo32RNA/3Y+5GVWluITa
	 FOL57VWuejzng==
Date: Fri, 24 Nov 2023 15:39:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>,
	Chandan Babu R <chandanbabu@kernel.org>
Cc: xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Catherine Hoang <catherine.hoang@oracle.com>
Subject: [MEGAPATCHSET v28] xfs: online repair, second part of part 1
Message-ID: <20231124233940.GK36190@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

[this time not as a reply to v27]

[[this time really not as a reply to v27]]

[[[***** email, this way is insane]]]

I've rebased the online fsck development branches atop 6.7, applied the
changes requested during the review of v27, and reworked the automatic
space reaping code to avoid open-coding EFI log item handling, and
cleaned up a few other things.

In other words, I'm formally submitting part 1 for inclusion in 6.8.

Just like the last several submissions, I would like people to focus the
following:

- Are the major subsystems sufficiently documented that you could figure
  out what the code does?

- Do you see any problems that are severe enough to cause long term
  support hassles? (e.g. bad API design, writing weird metadata to disk)

- Can you spot mis-interactions between the subsystems?

- What were my blind spots in devising this feature?

- Are there missing pieces that you'd like to help build?

- Can I just merge all of this?

The one thing that is /not/ in scope for this review are requests for
more refactoring of existing subsystems.  I'm still running QA round the
clock.  To spare vger, I'm only sending a few patchsets this time.  I
will of course stress test the new mailing infrastructure on 31 Dec with
a full posting, like I always do.

--D

