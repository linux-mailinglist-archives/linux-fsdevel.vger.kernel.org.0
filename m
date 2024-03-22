Return-Path: <linux-fsdevel+bounces-15079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4FE886DA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539BE286F41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4907B60261;
	Fri, 22 Mar 2024 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMVIeqVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F5B45BFF;
	Fri, 22 Mar 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114659; cv=none; b=lTRZmaJ0n8mdmiM2md4QEXcerfckyz1SBGJ6BSk1E97j2cUZ2+kIgQuDHkLBxmEN7q3dbjDiiJEQ8NjcM0dPo4Ca2y0JbzVIaQqMYzSlCJPaRiys6GuDkoOj1Gh4WdWVwIeGgsVfNsFZ3oS1cmDV2+gAlu/O2IXWlPiGLSol5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114659; c=relaxed/simple;
	bh=6kRXYQHQ09VB0rp2Y0Fn5bU3vT3oHZGNIxJ8xR0YUf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mv0pXls6NP5hRef+vg11Wo/NhJhYePfCsOA9H/quBXuhKAg7dc/MFl9wkKQLGOPz7HEB02Z773Y4TnXw6XRrwvRDbUHWfQ5l6ToMWiQjPh1CBfe64CyEyVL9+ht/Xt6M+OmjnW4vHUozpcB2JPVZgb8Vx9SXyzjKCELK7aLIW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMVIeqVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94E5C433F1;
	Fri, 22 Mar 2024 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711114659;
	bh=6kRXYQHQ09VB0rp2Y0Fn5bU3vT3oHZGNIxJ8xR0YUf0=;
	h=From:To:Cc:Subject:Date:From;
	b=mMVIeqVtLAwpPwV/kcxxAVn46on5nR0HXikq88lh3pA5JqB8PKArhQGXsn9R7V0YJ
	 cj+uME2mgnvVHHbZKxkkjNQfJP+y/DhmdsS0BqP80IPYB0nt92U/ry1mJFWBHeJTCp
	 TPyn2KV4cCMnIrM65oWt7EWTUhl+fFlUuJ3QHsNtctLR4zu7GaWw+uC1UvYtjuLhhc
	 mvmoz0V0mAARmJ92UMhqBo6cK61ZIhukyrEU2AOs+yMKc8SCLMDk6tWsx99fIFuY9P
	 VoKOzmt+uMH39LjXiPEr2nbU+Nl5WC6Ed60PCtcFSjSZXFKtHxSJirODhWqu3J84SG
	 7YMJ5wognQG3Q==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: Bug fixes for 6.9
Date: Fri, 22 Mar 2024 19:02:00 +0530
Message-ID: <874jcymlpd.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch which contains two XFS bug fixes for 6.9-rc1. A brief
summary of the bug fixes is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 75bcffbb9e7563259b7aed0fa77459d6a3a35627:

  xfs: shrink failure needs to hold AGI buffer (2024-03-07 14:59:05 +0530)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.9-merge-9

for you to fetch changes up to 0c6ca06aad84bac097f5c005d911db92dba3ae94:

  xfs: quota radix tree allocations need to be NOFS on insert (2024-03-15 10:30:23 +0530)

----------------------------------------------------------------
Bug fixes for 6.9:

* Fix invalid pointer dereference by initializing xmbuf before tracepoint
  function is invoked.
* Use memalloc_nofs_save() when inserting into quota radix tree.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: fix dev_t usage in xmbuf tracepoints

Dave Chinner (1):
      xfs: quota radix tree allocations need to be NOFS on insert

 fs/xfs/xfs_buf_mem.c |  4 ++--
 fs/xfs/xfs_dquot.c   | 18 +++++++++++++-----
 fs/xfs/xfs_trace.h   |  9 +++++++--
 3 files changed, 22 insertions(+), 9 deletions(-)

