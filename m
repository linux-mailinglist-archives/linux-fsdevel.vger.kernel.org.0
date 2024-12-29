Return-Path: <linux-fsdevel+bounces-38250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 150969FE0DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 00:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435EB7A10E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A417199935;
	Sun, 29 Dec 2024 23:41:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-12.prod.sxb1.secureserver.net (sxb1plsmtpa01-12.prod.sxb1.secureserver.net [92.204.81.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043623BE
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735515681; cv=none; b=eO9XZu0DuQ/yH3Z02uMhp3RbXMsHfYbWWTN2KhY85DtgniOiHZLgv4DGE5EHs1qj554vcdakLa/lfPRZJtk0wnKboEN2rBJJ6ax4TSFQb45fSqixYsCqX7nTGGkVL658Zf8WLvgCt0Jo2PU/bwlsvrdVYJVUW/yqIEwapmfsbzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735515681; c=relaxed/simple;
	bh=WGPABs3zTZprlXRKOMWfzX3Jn8cK7yWW3pvs3/Eg7bw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okk9P8uq4EkVJgNhuvf+E6Ci/hE8gUV8oPiA230BPeM7XCFPvpPN8N08A4sK5nPFv6RgnA3JeGidjS/KPS/ZAY8z2Mofkykzs6bvJXTRKLpzr8YlvaOQhxHS2gNOFyBQG2gmokOtfixmP4Oxs3Zx8APRBAFh1dxHh7NNqJwcMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from raspberrypi.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id S2rotGQTRxZ1ZS2rwtFiTZ; Sun, 29 Dec 2024 16:38:49 -0700
X-CMAE-Analysis: v=2.4 cv=S8MjwJsP c=1 sm=1 tr=0 ts=6771dd89
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=TjEQubXFWQas_0ZXauUA:9
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 0/4] squashfs: reduce memory usage and update docs
Date: Sun, 29 Dec 2024 23:37:48 +0000
Message-Id: <20241229233752.54481-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDL50b466NZkkVk5198sFnobUDcSFvKkgz5qAPnk8s0u5zw6H2GayUMW2CtPcKauxTIBNSecFWV+ODEfNhI2uTuj1a/KQsg2mSAk8mJO+eA0Uq8YWtEC
 qxOlBfePHPltucKYm9DnkxIqhUrhP7D5e9GD4lGMoBYxpeXvAl1pwzGlr/AmGK8AZ/sFcc2zglOYzC7a36mPDtfDiZXFUMBKVPICldWjJemblkedlwnrzETr
 3KDbzFk295TP5VqVUu7BAjRUlHorjAQXE9uZMK/1L6aTdzpHBrVm2AMFVs4ny9fk3dq6r+8uNN23m/qbuDSq8qC585LyhZG9fxTvQ09MyNQ=

Hi,

This patch-set reduces the amount of memory that Squashfs uses
when CONFIG_FILE_DIRECT is configured, and updates various
out of date information in the documentation and Kconfig.

Phillip Lougher (4):
      squashfs: make squashfs_cache_init() return ERR_PTR(-ENOMEM)
      squashfs: don't allocate read_page cache if SQUASHFS_FILE_DIRECT configured
      Documentation: update the Squashfs filesystem documentation
      squashfs: update Kconfig information

 Documentation/filesystems/squashfs.rst | 14 ++++++--------
 fs/squashfs/Kconfig                    |  6 +++---
 fs/squashfs/cache.c                    | 10 +++++++---
 fs/squashfs/squashfs.h                 |  6 ++++++
 fs/squashfs/super.c                    | 19 +++++++++++--------
 5 files changed, 33 insertions(+), 22 deletions(-)

 Thanks

 Phillip


