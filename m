Return-Path: <linux-fsdevel+bounces-34913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7793A9CE0E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBFD289FA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B471CEAD1;
	Fri, 15 Nov 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDAyIy3h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410781BBBDD;
	Fri, 15 Nov 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679483; cv=none; b=RavtqMCgXS93rq/5xh1/csatZmNaF+RIxm2D6Kj+mb7I9NxeFfbDzHVK//GXLNcfTg6wWDYTOZpdVYNznb1YXl3eZ6rS9HowtHeh2vj7oTBT6xbbuDb3IFnowWuKMD8fuJ0ClFKdKz1w781J02epn4+6VDqmTYmsbrHGGhoYIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679483; c=relaxed/simple;
	bh=i9mr35JANGPgP5i4kTP+v5RfbSIjjvNEh3L2erR8J+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCDH+rmbX09IAQKgjMn7gqeRWpVWCwzCSSCljzavOINnNX9UdP2aK92dpl+zIdBX9Sg2NWk5poB94tF+oA5VMhAA+GUsHujM8WFE4t3wVNbA77ggFd8CJ6HrqrwbO75/w3qrsmDWDrqJH5HBMk8fWNrWmkBNM5MKX8nxatXJgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDAyIy3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642AEC4CECF;
	Fri, 15 Nov 2024 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679481;
	bh=i9mr35JANGPgP5i4kTP+v5RfbSIjjvNEh3L2erR8J+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=gDAyIy3hkxznYxO5ra8O7aG0+Q4npPORB2z3+tSlCk8FIwTl0eo9RA7PlzL5RDul3
	 emydgf2oDsQix1aZfbm0gYWf++g9G+dLk6eR5eP78jvO7Vi6AjH5LwXCBnKZnamrPM
	 hDcb9bH7wh3PbOvs68PFyLlvlmLxOy2qPJn0MhGj9pIKwLhofrfp8s9ZizpbEuxFpK
	 BTKTUN8YTEqOrIXrJacqFV00utu5xq7GjCCfK/IpR1InAsTCj7gMdOCgSizZVTIbHm
	 brUg04C2VPluTwSwr9fSr3Vx7UxWNlTZ8SUEbFz6Lwhd9kx8IYZ6y63zNc+IPErDrE
	 FXi6IEf1dI4JA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs pidfs
Date: Fri, 15 Nov 2024 15:04:33 +0100
Message-ID: <20241115-vfs-pidfs-841631f030e8@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336; i=brauner@kernel.org; h=from:subject:message-id; bh=i9mr35JANGPgP5i4kTP+v5RfbSIjjvNEh3L2erR8J+Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbh3y+FX+lyFUluNaLxerh4o7Nq8paV3QyVy2eKNPr3 uG9+NHUjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkoTmL4K+C555BNypvoqh/L GiM514d72fGGJt7Omawe/Kf7qJODCSPD7MtsjDeLXnnPDW2tmvT7t4Iaz1uF6AVzdjEXLT/3QGQ 6EwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This adds a new ioctl to retrieve information about a pidfd.

A common pattern when using pidfds is having to get information about
the process, which currently requires /proc being mounted, resolving the
fd to a pid, and then do manual string parsing of /proc/N/status and
friends. This needs to be reimplemented over and over in all userspace
projects (e.g.: it has been reimplemented in systemd, dbus, dbus-daemon,
polkit so far), and requires additional care in checking that the fd is
still valid after having parsed the data, to avoid races.

Having a programmatic API that can be used directly removes all these
requirements, including having /proc mounted.

As discussed at LPC24, add an ioctl with an extensible struct so that
more parameters can be added later if needed. Start with returning
pid/tgid/ppid and some creds unconditionally, and cgroupid optionally.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc3 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.pidfs

for you to fetch changes up to cdda1f26e74bac732eca537a69f19f6a37b641be:

  pidfd: add ioctl to retrieve pid info (2024-10-24 13:54:51 +0200)

Please consider pulling these changes from the signed vfs-6.13.pidfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.pidfs

----------------------------------------------------------------
Luca Boccassi (1):
      pidfd: add ioctl to retrieve pid info

 fs/pidfs.c                                      | 86 ++++++++++++++++++++++++-
 include/uapi/linux/pidfd.h                      | 50 ++++++++++++++
 tools/testing/selftests/pidfd/pidfd_open_test.c | 82 ++++++++++++++++++++++-
 3 files changed, 214 insertions(+), 4 deletions(-)

