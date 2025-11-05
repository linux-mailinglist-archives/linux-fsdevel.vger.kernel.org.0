Return-Path: <linux-fsdevel+bounces-67021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8064CC33818
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43A304F3ABE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85C2367B3;
	Wed,  5 Nov 2025 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX7dZPpZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFD1FDE14;
	Wed,  5 Nov 2025 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303610; cv=none; b=b8BHoEClb3bhFOFO+g7YaBXOAauHNP4G8MobzepwkK//HrjUUbt7J3wVmMHNK7WvpTytZslOwR6qTMOwA4TWqEetqWOw0+ioVlaWDyjGCjnsexs1t1P1ctWcCkeOr2av1txQ7/TN33oc6G/S3Y6xYpKG7JCT6pSr4UslOqgulCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303610; c=relaxed/simple;
	bh=GhLR+QrwDJ2VvgLr6D9KiqM1dMq83TwZdbfvzC0QgP8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K9ACu8a9gCTKJNiASauyrgtr/bCKbvrOTGINkRIZkUpthNbIPpj5pT+uBsS7hPxvAbOBss1kCAnG16XSht9b2/Y58Nq9w5/Q8M8SgDAWJPEYP8yOYHJH1l+HQRWHk0BQk9w7nuGreJuzua85HHvBD7BIvO6javH9GovzzLrJt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX7dZPpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E9DC116B1;
	Wed,  5 Nov 2025 00:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303609;
	bh=GhLR+QrwDJ2VvgLr6D9KiqM1dMq83TwZdbfvzC0QgP8=;
	h=Date:From:To:Cc:Subject:From;
	b=LX7dZPpZIQh3CsTxJf+6wjouBudCCDIOeff0Nu0FBq9fbNZBmXoOIZeTBkxMwI2tF
	 ia1Ckc6cXOiAUB44+kDnWqHjmD/8WUynhmLe5RSR/Wo7Pv4HYDYoqxwy/7Tsd94h/j
	 9uZihTyJgie571XgWqSM0iLp3jhM7Tb/cgu0l04jz8LVnLA+p73h3bbERZ209bEK1n
	 60yqr8KQ5bw5p3anY2Yu5aQIpP9RBBlpl1OIlh4fZ+dLY9mE8OQaW3Rj18l7gU7QAF
	 jFE+OGCl8hN+0j7fk3UxNzBSgVfyoXxZJzHK3Vpp1i9qk+8lSEdgcmrBejO3DJTE1B
	 0JzukUmaxwEug==
Date: Tue, 4 Nov 2025 16:46:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Carlos Maiolino <cem@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: xfs <linux-xfs@vger.kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCHBOMB v2 6.19] xfs: autonomous self healing
Message-ID: <20251105004649.GA196370@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

You might recall that 18 months ago I showed off an early draft of a
patchset implementing autonomous self healing capabilities for XFS.
The premise is quite simple -- add a few hooks to the kernel to capture
significant filesystem metadata and file health events (pretty much all
failures), queue these events to a special anonfd, and let userspace
read the events at its leisure.  That's patchset 1.

Since the previous release, I've removed all the json event generation
stuff and made media errors use the rmap btree to report file data loss.
I also ported the userspace program to C.  I'm not going to blast
everyone with the full set; just know that the C version is here:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=health-monitoring

Patchset 2 is now a cleanup of the file IO error hooks in patchset 1 to
use a more generic interface and to call fsnotify with the error
reports.  This means that the fsnotify filesystem error functionality
conveys generic errors to unprivileged userspace programs, but I'm
leaving the privileged healthmon interface so that xfsprogs can figure
out which specific part of the filesystem needs fixing.

This work was mostly complete by the end of 2024, and I've been letting
it run on my XFS QA testing fleets ever since then.  I am submitting
this patchset for upstream for 6.19.  Once this is merged, the online
fsck project will be complete.

--D

The unreviewed patches in this series are:

[PATCHSET V3 1/2] xfs: autonomous self healing of filesystems
  [PATCH 02/22] docs: discuss autonomous self healing in the xfs online
  [PATCH 03/22] xfs: create debugfs uuid aliases
  [PATCH 04/22] xfs: create hooks for monitoring health updates
  [PATCH 05/22] xfs: create a filesystem shutdown hook
  [PATCH 06/22] xfs: create hooks for media errors
  [PATCH 07/22] iomap: report buffered read and write io errors to the
  [PATCH 08/22] iomap: report directio read and write errors to callers
  [PATCH 09/22] xfs: create file io error hooks
  [PATCH 10/22] xfs: create a special file to pass filesystem health to
  [PATCH 11/22] xfs: create event queuing, formatting,
  [PATCH 12/22] xfs: report metadata health events through healthmon
  [PATCH 13/22] xfs: report shutdown events through healthmon
  [PATCH 14/22] xfs: report media errors through healthmon
  [PATCH 15/22] xfs: report file io errors through healthmon
  [PATCH 16/22] xfs: allow reconfiguration of the health monitoring
  [PATCH 17/22] xfs: validate fds against running healthmon
  [PATCH 18/22] xfs: add media error reporting ioctl
  [PATCH 19/22] xfs: send uevents when major filesystem events happen
  [PATCH 20/22] xfs: merge health monitoring events when possible
  [PATCH 21/22] xfs: restrict healthmon users further
  [PATCH 22/22] xfs: charge healthmon event objects to the memcg of the
[PATCHSET V3 2/2] iomap: generic file IO error reporting
  [PATCH 1/6] iomap: report file IO errors to fsnotify
  [PATCH 2/6] xfs: switch healthmon to use the iomap I/O error
  [PATCH 3/6] xfs: port notify-failure to use the new vfs io error
  [PATCH 4/6] xfs: remove file I/O error hooks
  [PATCH 5/6] iomap: remove I/O error hooks
  [PATCH 6/6] xfs: report fs metadata errors via fsnotify


