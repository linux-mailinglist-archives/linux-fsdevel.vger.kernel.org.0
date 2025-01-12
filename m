Return-Path: <linux-fsdevel+bounces-38958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3210BA0A78A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50FBF7A0F38
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4484815F41F;
	Sun, 12 Jan 2025 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TCILOVwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3440379E1
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669151; cv=none; b=pqdtBbPJMjg8RzJ9BVa+Y6aslmz5V/tM3z1UHCDQ30yxbW6s5wNBYeYJGdGtlFKK7cIk+dcWBR83aOXxhj8KXO6INYw8iiRZFSU7iZqY8DCrYms/m6O5OyB//h2+wNeYowVK0vr4jHabHBT2Myzqj51VX62TSldLa1lN3aBkfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669151; c=relaxed/simple;
	bh=O4ZpQB07hBOqrS3qQM39iMd0qINQ7mI76YvqUS0fjRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPMOCKrJXViA1BfEaPG10DVMQgd4DVSjy5lwJa+C3X401YJtWOalkwmZt1Cukw4F3uAedITc0/uUsn8Mqs1UH0Jg4v/PYNTOe+eeT6sn4jE/tQ6BAXL5XA4kOir3xcUAelx62ukPnPrO3DfU6/VpwPejGMnzsH7IOUx7P/BMlFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TCILOVwm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NOsCQh4Kfy244o5ubzEniOm/WRlr+t2zligUwHb3i+U=; b=TCILOVwm7yukkBzyN51AZWFTXT
	vUDKAfaezGOnIg3RotmhBKoZtivYYE6iS3BmFUUOiKoOARrE74Gh9Ju0sNTf7kp5rOanpjfymad31
	Xvz7RVakXpmqHEFgdDoNMXFpj7RWM94WngUEteQg6M8OJZQP/8EiW1dmx09WwfCGrMcvhRbft/Yz9
	plYkC8sLdmC7r2brUHdJX+BfqOFpQGT572Y87hyV0DT1bW/GVPeJG/VjeIEcqBrHakwjSZl4uWT0F
	JUGmPZZ0oHA7OoO5YX3e7mHKXzbi/qnSMJFZ0cKpPmYC+6P+bCuU/vC43XSsS2T4+oT7Lap4YZtQ+
	939Uq/tw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWsyg-00000000ah5-04lV;
	Sun, 12 Jan 2025 08:05:46 +0000
Date: Sun, 12 Jan 2025 08:05:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCHES v2][RFC][CFT] debugfs cleanups
Message-ID: <20250112080545.GX1977892@ZenIV>
References: <20241229080948.GY1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241229080948.GY1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Dec 29, 2024 at 08:09:48AM +0000, Al Viro wrote:

> 	All of that could be avoided if we augmented debugfs inodes with
> a couple of pointers - no more stashing crap in ->d_fsdata, etc.
> And it's really not hard to do.  The series below attempts to untangle
> that mess; it can be found in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.debugfs

Rebased on top of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-linus
and force-pushed into the same branch.

Changes since v1:

* "debugfs: fix missing mutex_destroy() in short_fops case" dropped - already
merged.
* struct debugfs_short_fops made available without CONFIG_DEBUG_FS (fixes
build breakage on !DEBUG_FS builds)
* orangefs-debugfs converted to debugfs_create_file_aux_num() (accidentally
missed in the original series)

Shortlog:
Al Viro (21):
      debugfs: separate cache for debugfs inodes
      debugfs: move ->automount into debugfs_inode_info
      debugfs: get rid of dynamically allocation proxy_ops
      debugfs: don't mess with bits in ->d_fsdata
      debugfs: allow to store an additional opaque pointer at file creation
      debugfs: take debugfs_short_fops definition out of ifdef
      carl9170: stop embedding file_operations into their objects
      b43: stop embedding struct file_operations into their objects
      b43legacy: make use of debugfs_get_aux()
      netdevsim: don't embed file_operations into your structs
      mediatek: stop messing with ->d_iname
      [not even compile-tested] greybus/camera - stop messing with ->d_iname
      mtu3: don't mess wiht ->d_iname
      xhci: don't mess with ->d_iname
      qat: don't mess with ->d_name
      sof-client-ipc-flood-test: don't mess with ->d_name
      slub: don't mess with ->d_name
      arm_scmi: don't mess with ->d_parent->d_name
      octeontx2: don't mess with ->d_parent or ->d_parent->d_name
      orangefs-debugfs: don't mess with ->d_name
      saner replacement for debugfs_rename()

Diffstat:
 Documentation/filesystems/debugfs.rst              |  12 +-
 .../crypto/intel/qat/qat_common/adf_tl_debugfs.c   |  36 +---
 drivers/firmware/arm_scmi/raw_mode.c               |  12 +-
 drivers/net/bonding/bond_debugfs.c                 |   9 +-
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c       |  19 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |  76 +++-----
 drivers/net/ethernet/marvell/skge.c                |   5 +-
 drivers/net/ethernet/marvell/sky2.c                |   5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   6 +-
 drivers/net/netdevsim/hwstats.c                    |  29 ++-
 drivers/net/wireless/ath/carl9170/debug.c          |  28 ++-
 drivers/net/wireless/broadcom/b43/debugfs.c        |  27 ++-
 drivers/net/wireless/broadcom/b43legacy/debugfs.c  |  26 ++-
 drivers/opp/debugfs.c                              |  10 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                |  40 +---
 drivers/staging/greybus/camera.c                   |  17 +-
 drivers/usb/host/xhci-debugfs.c                    |  25 +--
 drivers/usb/mtu3/mtu3_debugfs.c                    |  40 +---
 fs/debugfs/file.c                                  | 165 ++++++++--------
 fs/debugfs/inode.c                                 | 208 ++++++++++-----------
 fs/debugfs/internal.h                              |  50 +++--
 fs/orangefs/orangefs-debugfs.c                     |  16 +-
 include/linux/debugfs.h                            |  44 ++++-
 mm/shrinker_debug.c                                |  16 +-
 mm/slub.c                                          |  13 +-
 net/hsr/hsr_debugfs.c                              |   9 +-
 net/mac80211/debugfs_netdev.c                      |  11 +-
 net/wireless/core.c                                |   5 +-
 sound/soc/sof/sof-client-ipc-flood-test.c          |  39 ++--
 29 files changed, 402 insertions(+), 596 deletions(-)

Individual patches in followups.

