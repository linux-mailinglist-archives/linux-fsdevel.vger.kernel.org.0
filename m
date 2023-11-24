Return-Path: <linux-fsdevel+bounces-3789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7927F86B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 00:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9CF1C20E7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301C93D99A;
	Fri, 24 Nov 2023 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKB5kkOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C6171A4;
	Fri, 24 Nov 2023 23:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DFCC433C8;
	Fri, 24 Nov 2023 23:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700868656;
	bh=t45L2cR6WsMeQVkO+rF2xoZAYVELMmfW6YLlhdfc/LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKB5kkOA7/uoP3ChC1UFTfFRUQRkiABc1n6UBo9BEG5UmDUAslrr+82HANpQ8IvxS
	 7p+Foq2BrpCLZ8onXEoC5N+RSQSZ7sf+KQh+0+qMTKXmCNCzt4DNue3KK7H3IkxDO5
	 FbhBoOR5DdiRtKXEhQavJMCrEztbiwUZzp/RvBHYjPTvD8igZ45oKJreR8qPmkc0tA
	 X/pq5M+3fdUZ5uAzpQ95GjI31yJzZT5/Bx3pO2fz0n68pbp+X8yZKfLASTl/3aP0Zp
	 SLBqQ6wKPYzuidoorcp+fv+Gpaxn2o/6oLJWsYXqScF+kOLeWFwG1ShubWMXj7AAqy
	 W9NnwimBvwUtQ==
Date: Fri, 24 Nov 2023 15:30:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>,
	Chandan Babu R <chandanbabu@kernel.org>
Cc: xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Catherine Hoang <catherine.hoang@oracle.com>
Subject: [MEGAPATCHSET v28] xfs: online repair, second part of part 1
Message-ID: <20231124233056.GH36190@frogsfrogsfrogs>
References: <20230926231410.GF11439@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926231410.GF11439@frogsfrogsfrogs>

Hi everyone,

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

