Return-Path: <linux-fsdevel+bounces-10513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1260084BE7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 21:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E11E1C228F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B9F17BD6;
	Tue,  6 Feb 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bSIpDTWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6C17BB4
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250751; cv=none; b=LtZ/eRnsDm872Wbu/mZ0D73nMbqOYBlg8eIbH1U5g60IFXijpZu1SSAQkDOG++1EeVEVA3tbbMGUDdpDbNBCdXT9k9hv9s0r9j9rJWYrtCiswtlM6kVBMT7TgZZ/Ejg2yrqgWHkCy7LQfE+6bx3dn4SrnuK4J9ikV34Xxhx2IA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250751; c=relaxed/simple;
	bh=CvqiEYInYd5a5l6jtW2YD1didNCDQzJwxx0JM3XNOpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwB1PBrU3PBdlEBZFb2qV++/oxe9J0cqGvFgcPuoL52wf1NExScKNyz/L9UMvv6CaSQ1/Vol44el5g3v9hs4QM8gOFnwmA05GYio6JoPDYv5xgoFVgBoAC4g1IFU6egfmIslhNedFeZBOu9BKYNddbjI/p3PE8H9YbSsCiHcxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bSIpDTWc; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707250747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Tm3QJ8ktnoQXwinKZstJfbJd1PnNWgD9rX0cMudv04=;
	b=bSIpDTWcgiVydgYV6QG8ktqF9gSZ203W29s/MfAwSIZ8zMQ6TjGTpkO1EYtb1Q13YoRrMI
	w1JM6fJGXavHELNfuC+9/f5A/cuSw00qaTkCbtW9iE8v8CoEr6D9MHipb0hI4EQC/YGFuq
	Cu1uAayTOJ9Eq5NhFjrfGq87EkaCc9o=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 0/7] filesystem visibililty ioctls
Date: Tue,  6 Feb 2024 15:18:48 -0500
Message-ID: <20240206201858.952303-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

previous:
https://lore.kernel.org/linux-fsdevel/20240206-aufwuchs-atomkraftgegner-dc53ce1e435f@brauner/T/

Changes since v1:
 - super_set_uuid() helper, per Dave

 - nix FS_IOC_SETUUID - Al raised this and I'm in 100% agreement,
   changing a UUID on an existing filesystem is a rare operation that
   should only be done when the filesystem is offline; we'd need to
   audit/fix a bunch of stuff if we wanted to support this

 - fix iocl numberisng, no longer using btrfs's space

 - flags argument in struct fsuuid2 is gone; since we're no longer
   setting this is no longer needed. As discussed previously, this
   interface is only for exporting the public, user-changable UUID (and
   there's now a comment saying that this exports the same UUID that
   libblkid reports, per Darrick).

Darrick also noticed that fscrypt (!) is using sb->s_uuid, which looks
busted - they want to be using the "this can never change" UUID, but
that is not an item for this patchset.

 - FS_IOC_GETSYSFSNAME -> FS_IOC_GETSYSFSPATH, per Darrick (the commit
   messages didn't get updated, whoops); and there's now a comment to
   reflect that this patch is also for finding filesystem info under
   debugfs, if present.

Christain, if nothing else comes up, are you ready to take this?

Cheers,
Kent

Kent Overstreet (7):
  fs: super_set_uuid()
  overlayfs: Convert to super_set_uuid()
  fs: FS_IOC_GETUUID
  fat: Hook up sb->s_uuid
  fs: FS_IOC_GETSYSFSNAME
  xfs: add support for FS_IOC_GETSYSFSNAME
  bcachefs: add support for FS_IOC_GETSYSFSNAME

 fs/bcachefs/fs.c        |  3 ++-
 fs/ext4/super.c         |  2 +-
 fs/f2fs/super.c         |  2 +-
 fs/fat/inode.c          |  3 +++
 fs/gfs2/ops_fstype.c    |  2 +-
 fs/ioctl.c              | 33 +++++++++++++++++++++++++++++++++
 fs/kernfs/mount.c       |  4 +++-
 fs/ocfs2/super.c        |  4 ++--
 fs/overlayfs/util.c     | 14 +++++++++-----
 fs/ubifs/super.c        |  2 +-
 fs/xfs/xfs_mount.c      |  4 +++-
 include/linux/fs.h      | 10 ++++++++++
 include/uapi/linux/fs.h | 27 +++++++++++++++++++++++++++
 mm/shmem.c              |  4 +++-
 14 files changed, 99 insertions(+), 15 deletions(-)

-- 
2.43.0


