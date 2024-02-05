Return-Path: <linux-fsdevel+bounces-10350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C0884A7AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5611C2788E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 21:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFA512B14A;
	Mon,  5 Feb 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mxIalyj5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1263F12A168
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163569; cv=none; b=leFSuF1Vm97fojT3QZaBBCaFDTibPlvXwmWRmF8nZMinrqGg6ntsgJZxlJiOsLH3c8hoGnW6ZSgyafh1xFo2peAYymf1Z/gL46cATLyHGuVC8V4Q78dUCqmLffdxQaENCBQ9/PFbK4XF/m4zFom5GCH9G91l0ogQyLZ3rfh2Tv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163569; c=relaxed/simple;
	bh=ZzpfRJLNiDFRXBfUCaCz/ALUxgqYKP7yarQNXpLqifw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U98XM20xkgZjyntJ/lfQxUzca3/pRQA6ummRuN8FjmHtZfFj21lPD7eZBbEy4YBt+gSPkJzJLMP1OGu3SOd6+Vmmkge4/tJXPgvHOE95CPpk+cWB4yA7ueGfzaOsbIm0cCSg/J2QeGVtL2AS9Cg8k2JteFF0N4fU698OeTEPJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mxIalyj5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707163563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y0S45WMR1qJRBOTa9Fq+vJw0l8t2/n0Fhw6eQ4IEkC0=;
	b=mxIalyj5f8L31oBRKlsLNd/rlDjR6y+USSkDnz53a0/c/mhd3QPBRyo5n/+BZ4dQNWYY3/
	Jd+FxdxI3gXwetCA9FdGyqd63Sgqiyd6vcSFLH6R+qVp0TUFxI/wwWPD18xSmU57AqLWRY
	uK/PZfhJ10AFjXwWre9cYCKA9duawQM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 0/6] filesystem visibility ioctls
Date: Mon,  5 Feb 2024 15:05:11 -0500
Message-ID: <20240205200529.546646-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,

this patchset adds a few new ioctls to standardize a few interfaces we
want
 - get/set UUID
 - get sysfs path

The get/set UUID ioctls are lifted versions of the ext4 ioctls with one
difference, killing the flexible array member - we'll never have UUIDs
more than 16 bytes, and getting rid of the flexible array member makes
them easier to use.

FS_IOC_GETSYSFSNAME is new, but it addresses something that we've been
doing in fs specific code for awhile - "given a path on a mounted
filesystem, tell me where it lives in sysfs".

Cheers,
Kent

Kent Overstreet (6):
  fs: super_block->s_uuid_len
  fs: FS_IOC_GETUUID
  fat: Hook up sb->s_uuid
  fs: FS_IOC_GETSYSFSNAME
  xfs: add support for FS_IOC_GETSYSFSNAME
  bcachefs: add support for FS_IOC_GETSYSFSNAME

 fs/bcachefs/fs.c        |  1 +
 fs/fat/inode.c          |  4 ++++
 fs/ioctl.c              | 33 +++++++++++++++++++++++++++++++++
 fs/super.c              |  1 +
 fs/xfs/xfs_mount.c      |  2 ++
 include/linux/fs.h      |  2 ++
 include/uapi/linux/fs.h | 21 +++++++++++++++++++++
 7 files changed, 64 insertions(+)

-- 
2.43.0


