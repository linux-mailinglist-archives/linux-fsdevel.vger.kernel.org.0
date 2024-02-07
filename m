Return-Path: <linux-fsdevel+bounces-10548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313184C2C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 03:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5651F23C81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 02:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4778FC05;
	Wed,  7 Feb 2024 02:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uE0FDbCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ADFF9C3;
	Wed,  7 Feb 2024 02:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274599; cv=none; b=REz3AvN34emprLv0lwKIPWe/XG5ag1ij7kdsM79Umrs2Q1o64zqhicB93TZD8UkZwbjm8R0IBWHRj2khO4FDGgxsVOv+MzQPSiJ+7qZp3eDLbwomysnwRPsfRecUczqg5rrix79JprloeDjALpCx8YUvgT8zmiLXkW41c/iUlN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274599; c=relaxed/simple;
	bh=m4TC24mVqklRhBOb7tK3BXuxTS7Fm1ONgjUeOjgSX50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsV5ASQTda7xKgpamZUyjgmkY5sdQ17aXMPpOpHc9GaVYBS7oo9acYXQyNz3b1+XepypRFOjhAnWUqMiHiSF09pcF9AGao79/C1dXzR01QI35noQuui6onEL/mhUjukz/rJFVx5tMmw2Qy8M+d9yW7iaHwQFBX+YU23GhmMt8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uE0FDbCj; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707274595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KKhJBqt5xtFm1mNazA1vBglPwhc1EdBuzv5UfyGKE6A=;
	b=uE0FDbCjgHuWFTrAI3gaaQwQ8PRgA/G1+r8CfJhMH1w3NESZ7wneEjSAut/0Lbmf6bZoLw
	ziPnTeNdA6oa2AuhS3XU3sicEtjiqHOM45oioUQ3G77d8tpbXPl430iebSZOLoDqYNPcHN
	SDWpjx624EyMjoiq0fCRVYGvn/EfbpA=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/7] filesystem visibililty ioctls
Date: Tue,  6 Feb 2024 21:56:14 -0500
Message-ID: <20240207025624.1019754-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ok, any further bikeshedding better be along the lines of "this will
cause a gaping security hole unless addressed" ;)

changes since v2:
 - now using nak (0x15) ioctl range; documentation updated
 - new helpers for setting the sysfs name
 - sysfs name uuid now has a length field

other notes:
 - fscrypt usage of s_uuid has justification, so we don't need to be
   concerned about exporting that (more) to userspace
 - i haven't updated btrfs for FS_IOC_SYSFS_NAME, less familiar with
   their code so they are cc'd
   ext4 may want this too?

Kent Overstreet (7):
  fs: super_set_uuid()
  overlayfs: Convert to super_set_uuid()
  fs: FS_IOC_GETUUID
  fat: Hook up sb->s_uuid
  fs: FS_IOC_GETSYSFSNAME
  xfs: add support for FS_IOC_GETSYSFSNAME
  bcachefs: add support for FS_IOC_GETSYSFSNAME

 .../userspace-api/ioctl/ioctl-number.rst      |  3 +-
 fs/bcachefs/fs.c                              |  3 +-
 fs/ext4/super.c                               |  2 +-
 fs/f2fs/super.c                               |  2 +-
 fs/fat/inode.c                                |  3 ++
 fs/gfs2/ops_fstype.c                          |  2 +-
 fs/ioctl.c                                    | 33 ++++++++++++
 fs/kernfs/mount.c                             |  4 +-
 fs/ocfs2/super.c                              |  4 +-
 fs/overlayfs/util.c                           | 14 +++--
 fs/ubifs/super.c                              |  2 +-
 fs/xfs/xfs_mount.c                            |  4 +-
 include/linux/fs.h                            | 51 +++++++++++++++++++
 include/uapi/linux/fs.h                       | 27 ++++++++++
 mm/shmem.c                                    |  4 +-
 15 files changed, 142 insertions(+), 16 deletions(-)

-- 
2.43.0


