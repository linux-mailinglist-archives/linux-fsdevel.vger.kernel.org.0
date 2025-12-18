Return-Path: <linux-fsdevel+bounces-71590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3903CCA099
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2E49303461D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 02:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6727274B55;
	Thu, 18 Dec 2025 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af6IaXkG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45420257435;
	Thu, 18 Dec 2025 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023371; cv=none; b=cbwT77bJji5kG6SeP9AIQRiwOOVZTwYE3V90aOwdZ7nN9Rprbk71GEaaQsw2ZnTnzaWysw3JMJ65AcNfSvbQsuqrhbUYBVGEJl+yjI8zIIejJ5rUuFAPQnJ5k2QgZMSvCI3qprUA46CKtuZIlJCfNBZqqo8utPSaHeuL3AAGpw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023371; c=relaxed/simple;
	bh=oH6Si/IQGwMkVWEFlgne6RF6Y/0VrLC5U4ma5Osfq3c=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=nKgIIumlWu6kOxFijjuiCC1dGjHsY4/Wd74lC+sm6/OxuP30XhdWvcHmX9GMg1QlfynfRpTqgSEqU0iflh+E1ZEWBchsR7KT+xvMzrloWqEomV5EHcRvYAFTOL/7xUxhw+YGdo8gmfmWbqPQlx9ZI2XP3LicILh5oFxtIpYHKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af6IaXkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE8FC4CEF5;
	Thu, 18 Dec 2025 02:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766023370;
	bh=oH6Si/IQGwMkVWEFlgne6RF6Y/0VrLC5U4ma5Osfq3c=;
	h=Date:Subject:From:To:Cc:From;
	b=Af6IaXkGoG11xHPkCt+uCy4AdVJXJxsXNOFBU4uTSq9x2gA9eMgSEOQ8i9WTcWP72
	 by0jwksuFFibLg5uOAxFOcc9Eda0kywGvAjYvZzfRsoF43FtqprQNyoO1Kntr2tFIk
	 GB+dhU/j4eqmCLjBq8ZMGLXRvxsnQ0FzPLJ3vI5N/gaupPJM2wcY1W7tjPLYnfwGaR
	 sj7sgPIM1P4PcqjNFVJ2eV4LxfDh5pM260VlxpLzA2e9EwPZ8VdeTElYL8kekEAMMj
	 IDuHBlwM1eZb608EWRbNLKSNaZ++KgAqEaKqA6C4ehEaffGAn8QZ85mvNrbOKieKAu
	 +wAxbORPk59+g==
Date: Wed, 17 Dec 2025 18:02:50 -0800
Subject: [PATCHSET V4 2/2] fs: send uevents on mount and unmount
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 linux-fsdevel@vger.kernel.org
Message-ID: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

To support a self healing filesystem, we need a way to autostart the
xfs_healer userspace daemon as soon as a filesystem mounts.  Since XFS
actually creates a file in the sysfs namespace, the kernel can emit
a uevent for that sysfs file when the filesystem mounts.  In turn, udev
will process the uevent according to the uevent rules, which means that
we have an easy way to start the background service.

This short series adds some common code to emit filesystem uevents and
teaches xfs to take advantage of it.  Unfortunately this isn't a fully
generic solution because not all filesystems actually create kobjects
for themselves.

This is also a prerequisite for the XFS self-healing V4 series which
will come at a later time.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=filesystem-uevents

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=filesystem-uevents
---
Commits in this patchset:
 * fs: send uevents for filesystem mount events
 * xfs: send uevents when major filesystem events happen
 * ext4: convert ext4_root to a kset
 * ext4: send uevents when major filesystem events happen
---
 include/linux/fsevent.h |   33 ++++++++++++
 fs/Makefile             |    2 -
 fs/ext4/ioctl.c         |    2 +
 fs/ext4/super.c         |    6 ++
 fs/ext4/sysfs.c         |   22 +++++---
 fs/fsevent.c            |  128 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fsops.c      |    2 +
 fs/xfs/xfs_super.c      |   10 ++++
 8 files changed, 195 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/fsevent.h
 create mode 100644 fs/fsevent.c


