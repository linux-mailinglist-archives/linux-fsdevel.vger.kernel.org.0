Return-Path: <linux-fsdevel+bounces-53401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8733AEED9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 07:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE63A3B2A6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 05:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43AD1FBCB0;
	Tue,  1 Jul 2025 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VdjAtIGj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VdjAtIGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5910D72601
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347988; cv=none; b=r+QJD/OLRhI4Cy63Zqdx/iYVz+QM4FJLl+lz0cTqBXCqe7y2ww+CJ9gMLUxweE+E8TtlzJUJaPXultq71HU3Jd+MDNfihIAFM6vQdAKW9fcHcgnl8VD6JbnjxrfxChHOg3Pyr8+1zvYX2cUY5QGCFtDdaCms0gCEqViIQHz5ERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347988; c=relaxed/simple;
	bh=XnVx387o9054TlRrZlU1jRljnaRkoNiAfiTX9vhzraA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZSamvWl/ALzNx1TWaItM10ncQIrMRwIOo5aniaNXLbobG6fXsMdeFEQyKCwmNgvEHaZPMjkh0VLD+EPJtEUpcVYTdfTI/k5iy/61TdiLKDXwEr+xsl0ixt12VZNn9Wc99wl821bdnSNEbpKMqusTrF2DGg6ILT5ntsY3suQJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VdjAtIGj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VdjAtIGj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B30921162;
	Tue,  1 Jul 2025 05:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751347978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=otcmawZHrXkZ1Ihn7n/iEDd4u2DGoxw2VZCs3loiyNM=;
	b=VdjAtIGj4eHy8mUPV/42RvdCwwwj1Wu7hk0OVxsyBqYrCzJsNvmh7KlyDksPCSXwDwcWnj
	GpvPSE1xzOQv+e33DxotnIoVlmCBE9RvJVC7xigOxOHIXNPIQKRiFbrASNQinsVtzCgzmY
	d9br+HmAgDaYBO2zi+lpr3/K70sp2lg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VdjAtIGj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751347978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=otcmawZHrXkZ1Ihn7n/iEDd4u2DGoxw2VZCs3loiyNM=;
	b=VdjAtIGj4eHy8mUPV/42RvdCwwwj1Wu7hk0OVxsyBqYrCzJsNvmh7KlyDksPCSXwDwcWnj
	GpvPSE1xzOQv+e33DxotnIoVlmCBE9RvJVC7xigOxOHIXNPIQKRiFbrASNQinsVtzCgzmY
	d9br+HmAgDaYBO2zi+lpr3/K70sp2lg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC7D213890;
	Tue,  1 Jul 2025 05:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bcXrIghzY2hEYQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 01 Jul 2025 05:32:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v2 0/6] btrfs: add remove_bdev() callback
Date: Tue,  1 Jul 2025 15:02:33 +0930
Message-ID: <cover.1751347436.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8B30921162
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

[CHANGELOG]
v2:
- Enhance and rename shutdown() callback
  Rename it to remove_bdev() and add a @bdev parameter.
  For the existing call backs in filesystems, keep their callback
  function names, now something like ".remove_bdev = ext4_shutdown,"
  will be a quick indicator of the behavior.

- Remove the @surprise parameter for the remove_bdev() parameter.
  The fs_bdev_mark_dead() is already trying to sync the fs if it's not
  a surprise removal.
  So there isn't much a filesystem can do with the @surprise parameter.

- Fix btrfs error handling when the devices are not opened
  There are several cases that the fs_devices is not opened, including:
  * sget_fc() failure
  * an existing super block is returned
  * a new super block is returned but btrfS_open_fs_devices() failed

  Handle the error properly so that fs_devices is not freed twice.

RFC->v1:
- Add a new remove_bdev() callback
  Thanks all the feedback from Christian, Christoph and Jan on this new
  name.

- Add a @surprise parameter to the remove_bdev() callback
  To keep it the same as the bdev_mark_dead().

- Hide the shutdown ioctl and remove_bdev callback behind experimental 
  With the shutdown ioctl, there are at least 2 test failures (g/388, g/508).

  G/388 is related to the error handling with COW fixup.
  G/508 looks like something related to log replay.

  And the remove_bdev() doesn't have any btrfs specific test case yet to
  check the auto-degraded behavior, nor the auto-degraded behavior is
  fully discussed.

  So hide both of them behind experimental features.

- Do not use btrfs_handle_fs_error() to avoid freeze/thaw behavior change
  btrfs_handle_fs_error() will flips the fs read-only, which will
  affect freeze/thaw behavior.
  And no other fs set the fs read-only when shutting down, so follow the
  other fs to have a more consistent behavior.


Qu Wenruo (6):
  fs: enhance and rename shutdown() callback to remove_bdev()
  btrfs: introduce a new fs state, EMERGENCY_SHUTDOWN
  btrfs: reject file operations if in shutdown state
  btrfs: reject delalloc ranges if in shutdown state
  btrfs: implement shutdown ioctl
  btrfs: implement remove_bdev super operation callback

 fs/btrfs/file.c            | 25 ++++++++++++++++++++-
 fs/btrfs/fs.h              | 28 ++++++++++++++++++++++++
 fs/btrfs/inode.c           | 14 +++++++++++-
 fs/btrfs/ioctl.c           | 43 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/messages.c        |  1 +
 fs/btrfs/reflink.c         |  3 +++
 fs/btrfs/super.c           | 45 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c         |  2 ++
 fs/btrfs/volumes.h         |  5 +++++
 fs/exfat/super.c           |  4 ++--
 fs/ext4/super.c            |  4 ++--
 fs/f2fs/super.c            |  4 ++--
 fs/ntfs3/super.c           |  4 ++--
 fs/super.c                 |  4 ++--
 fs/xfs/xfs_super.c         |  5 +++--
 include/linux/fs.h         |  7 +++++-
 include/uapi/linux/btrfs.h |  9 ++++++++
 17 files changed, 192 insertions(+), 15 deletions(-)

-- 
2.50.0


