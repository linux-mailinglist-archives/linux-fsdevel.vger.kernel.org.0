Return-Path: <linux-fsdevel+bounces-45071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3157DA7159A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 12:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8290B188BAF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4A31DDA3E;
	Wed, 26 Mar 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J3tjCCUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504C1CAA96;
	Wed, 26 Mar 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988149; cv=none; b=FfN2uuRGoVNTFyhF867PxrNpsnEURhpr7JV9mF/X4LFzPHXUZQ/Rt9StFFwzTHkFTV/R3dN2cogv5r0axfZTVlVhTbto5awlYsmJ1yuBBJ9oDOcq7a0DbY+jhfgVRDNed/WQIDuia6lHrcL2Q/iaDFoquyW4yFa1JkA815W46Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988149; c=relaxed/simple;
	bh=CndoDvn0jkjEWqRyynmQWpLG7kKUVa3kGb5BIs3AG68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUogYeHDcEKXi73sFUTL2uVYQ+SAle3UkTn1eSdwhPgYI/8XZvKh1SOsG/TcrezbOTZ1Abb0C/RccgoAkwlj0fKZoMaPBwFt1IW2r9DW/0KnUMZxb5CYvO0Ew9IZ/c4MoqAyOEnxLUawfebCln6xwwYIY/3AomDd1XR3R0hwwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J3tjCCUz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nk8QyZuJsVYS3VmlEAQjifVbkAMkGVtYdMxw10Sn9jA=; b=J3tjCCUz69LtEGyBhQNKEkakVQ
	F83tU98Dh+ymLIej4Cati3/wDcByRg6XQ4qMmZEFVyRGBwmkJD5dfUP/NXb/4MgEcvBFQIdYgXuX6
	StFKpeV3L5f9PjqnEX648RPkmYebq+jCJYUPDPGqHWCErl51P13zyiN/frqhYbH4+Wd7vxYNahe4a
	BVL98iCryjjE2JyouY48p0bVbbaegtF149pFcJ4VR1C7m7D7nnOqXog6vkVne7/ejWUfgBZB5vbjM
	mfR+lrlZR7JZ4I9+rr9QjAe+iiazgfyPxTqjkj16kjBR3MZd9OPmfLTz/6x5mc2fJP0WP7SC2zEYW
	W6p8IR7A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txOq0-00000008LLi-2YJF;
	Wed, 26 Mar 2025 11:22:24 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: jack@suse.cz,
	hch@infradead.org,
	James.Bottomley@HansenPartnership.com,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gost.dev@samsung.com,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 0/6] fs: automatic kernel fs freeze / thaw
Date: Wed, 26 Mar 2025 04:22:14 -0700
Message-ID: <20250326112220.1988619-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Based on discussions at LSFMM, on where are we at with automatic fs
suspend / resume. I did a quick check and most of the complexities from
the last series I tried from 2023-03 [0] are now resolved, namely the
following patches are no longer needed as Christian did the work for
this already:

  fs: unify locking semantics for fs freeze / thaw
  fs: distinguish between user initiated freeze and kernel  initiated freeze
  fs: move !SB_BORN check early on freeze and add for thaw

So the only thing left to do is add an fs flag for a sanity check that
the fs doesn't use rely on ktrhead freezing, and enable it for
filesystems which have done that work. This adds the work for
a few filesystems. If regressions are found we can simply remove
FS_AUTOFREEZE from the fs.

I did a quick boot test with this on my laptop and suspend doesn't work,
its not clear if this was an artifact of me trying this on linux-next or
what, I can try without my patches on next to see if next actually
suspends without them. And so, we gotta figure out if there's something
stupid still to fix, or something broken with these changes I overlooked
on the rebase.

[0] https://web.git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20230507-fs-freeze

Luis Chamberlain (6):
  fs: add frozen sb state helpers
  fs: add iterate_supers_excl() and iterate_supers_reverse_excl()
  fs: add automatic kernel fs freeze / thaw and remove kthread freezing
  ext4: replace kthread freezing with auto fs freezing
  btrfs: replace kthread freezing with auto fs freezing
  xfs: replace kthread freezing with auto fs freezing

 fs/btrfs/disk-io.c     |   4 +-
 fs/btrfs/scrub.c       |   2 +-
 fs/btrfs/super.c       |   2 +-
 fs/ext4/ext4_jbd2.c    |   2 +-
 fs/ext4/mballoc.c      |   2 +-
 fs/ext4/super.c        |   9 +--
 fs/gfs2/sys.c          |   2 +-
 fs/quota/quota.c       |   3 +-
 fs/super.c             | 149 +++++++++++++++++++++++++++++++++++++++--
 fs/xfs/xfs_discard.c   |   2 +-
 fs/xfs/xfs_log.c       |   3 +-
 fs/xfs/xfs_log_cil.c   |   2 +-
 fs/xfs/xfs_mru_cache.c |   2 +-
 fs/xfs/xfs_pwork.c     |   2 +-
 fs/xfs/xfs_super.c     |  16 ++---
 fs/xfs/xfs_trans.c     |   3 +-
 fs/xfs/xfs_trans_ail.c |   3 -
 fs/xfs/xfs_zone_gc.c   |   2 -
 include/linux/fs.h     |  38 +++++++++++
 kernel/power/process.c |  15 ++++-
 20 files changed, 223 insertions(+), 40 deletions(-)

-- 
2.47.2


