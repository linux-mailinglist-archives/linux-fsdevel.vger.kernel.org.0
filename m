Return-Path: <linux-fsdevel+bounces-58421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65472B2E9A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2617B9E40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1EA1E102D;
	Thu, 21 Aug 2025 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9fp4FJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D44610B;
	Thu, 21 Aug 2025 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737235; cv=none; b=bH63ptyAEGjLyw3QjPeoaUkDTppczIg12XM8wJj6lpg6vGbx2fop2dHioaw+AiOw4Jz0YnMLFIc4IKv4KFz3yr99R9VHNGfJ26edeEdgjRk0pLsCK5InfTSohVIdcUHLpUc+qofnvDFvKvJYlpMj6M1OhaUDtrd4E7od6iqUDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737235; c=relaxed/simple;
	bh=hFWNOeAk2QKuMkZJITC6Qfp3VVeUpIBPH0JhmXeSG/M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thff7hWQ1cSvAmvRV6us6qEMp3kg/6Do9nne7KgVEpuYYZCX1UqOj2q66pdXjiPjJL0nLQJgDrXsFGF9ywdlQSs4UEKMf3vDiljGMyyYfYb+kZIOHCnF1LrMm6u+KeB8LSJnSc+EhvOLICXDyG7CmmjRKwasakwmeSG8iP13n98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9fp4FJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26214C4CEEB;
	Thu, 21 Aug 2025 00:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737235;
	bh=hFWNOeAk2QKuMkZJITC6Qfp3VVeUpIBPH0JhmXeSG/M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=N9fp4FJKAAfHQOdFV+FbVscKLGn2tWw0719cy8lIMqLE9OZ6mObcDiNyctT0l9nrZ
	 yKN5rD/HmCr7xiSUprAfXuQIj9FSpP8fnx33rsqZWW4juV/arfUj7Ev5yihxGARlxf
	 6Te+kQEs5l1FCvA5GHtL/URJWw+ntjYHbtQ3H+5eDQaUpRVC5MLU614tGy/Lq29HqQ
	 SOBu8X1nQNKDACvQ6YgL55PAJw6NzF1QNUykIFx6rHb3GIUfWi/TBerUmnh9Cwbis4
	 3k5i5JOQf0etZuel4sETNUefpqG4ZOCjz7H4zC5ituRMoeTcKOjFVZhNKV+xqsEnkd
	 LtkO+I3l+mj5g==
Date: Wed, 20 Aug 2025 17:47:14 -0700
Subject: [PATCHSET RFC v4 1/4] fuse: general bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: stable@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev,
 John@groves.net, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
In-Reply-To: <20250821003720.GA4194186@frogsfrogsfrogs>
References: <20250821003720.GA4194186@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here's a collection of fixes that I *think* are bugs in fuse, along with
some scattered improvements.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-fixes
---
Commits in this patchset:
 * fuse: fix livelock in synchronous file put from fuseblk workers
 * fuse: flush pending fuse events before aborting the connection
 * fuse: capture the unique id of fuse commands being sent
 * fuse: implement file attributes mask for statx
 * fuse: update file mode when updating acls
 * fuse: propagate default and file acls on creation
 * fuse: enable FUSE_SYNCFS for all servers
---
 fs/fuse/fuse_i.h    |   14 +++++++
 fs/fuse/acl.c       |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c       |   44 +++++++++++++++++++++++
 fs/fuse/dev_uring.c |    8 ++++
 fs/fuse/dir.c       |   96 +++++++++++++++++++++++++++++++++++++++------------
 fs/fuse/file.c      |   10 +++++
 fs/fuse/inode.c     |    5 +++
 7 files changed, 245 insertions(+), 27 deletions(-)


