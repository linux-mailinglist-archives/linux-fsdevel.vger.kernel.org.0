Return-Path: <linux-fsdevel+bounces-45397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968EA771E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 02:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC79D3A6BEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 00:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D37B136327;
	Tue,  1 Apr 2025 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzTo9gNa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21D3FC7;
	Tue,  1 Apr 2025 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467606; cv=none; b=Bnxw08hOiIN/6kNg6yipulOHqe7zJtAOHPj6bLsmAsGm/B0m7B5pA00aSMtYoIqkWhDMD/tv17Nx1ninPJXO4rzngwHu2fZhR6YvEdSiUai4930t0iSv+9mY6rsdy9YyuXkF01WizK7oOuN6v4O7ro/86KGw+bxYuRHwgPVkzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467606; c=relaxed/simple;
	bh=+zJ2gVANS/W08rzPAqYzO5t5HGmjYRihcBJZR3OXeQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFEFNBapqkUX61LT7aMwSjREPszU1nWMweE2QNYvna821g/1Dd9tGMc3HUdBTpe9cBPxUZ6Y79PGdtNpQZ5F7Pr5jN4K/a8ks/UItWH0S8w1Vv1qcFs5i6qBfMW2W5g8ysGWnugS+CJaDRhoPJTZHWK+l8znp/uON4xzh28E7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzTo9gNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77544C4CEE3;
	Tue,  1 Apr 2025 00:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743467606;
	bh=+zJ2gVANS/W08rzPAqYzO5t5HGmjYRihcBJZR3OXeQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzTo9gNarL0zjHyzGqzH76I+tkkdBYNgRgDOHLDbf5+LpY8NF85R5as86nceSDqIf
	 Gy8xouGZtOwoRqgDxaZ9xNoi0KB4KMIkqAxl6Tek1PKHGEybDfjK7CpUlFR+WkrPe4
	 ob8gnUgPmJEEYWt2WgSU+PB79zeKde+eURUkuZkaFfWVfSqXPhWyat5hht/dW2G82v
	 SOJgs96eYYq8aQQT4CW2Us8hDEDbkfWb1OR0M8VnzW7YkfaYoG0omVwTmJeAP0eTj1
	 Brwk83Wl8VccahrC8p3/oz0oES/QZ4ovhppnSJaFDJR3rB9p6KKS1Na3aULB5+crwv
	 EehzY08hiuotA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	rafael@kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH 0/6] power: wire-up filesystem freeze/thaw with suspend/resume
Date: Tue,  1 Apr 2025 02:32:45 +0200
Message-ID: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250401-work-freeze-693b5b5a78e0
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3022; i=brauner@kernel.org; h=from:subject:message-id; bh=+zJ2gVANS/W08rzPAqYzO5t5HGmjYRihcBJZR3OXeQU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/NrF24GwPCvFN8b438eTaXwZbS24kt+xMWqh5er1bj bO/SsqJjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMVmP477Yy3zPOwFRG/WBI 21xGeZ5engX7qiLKPDRVu1f0aEj7MDJ0GtaJSp2Z8bfRINJ3zvUZU8VYbmcwvBU1a1LhCjdJbOU EAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The whole shebang can also be found at:
https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.freeze

I know nothing about power or hibernation. I've tested it as best as I
could. Works for me (TM).

I need to catch some actual sleep now...

---

Now all the pieces are in place to actually allow the power subsystem to
freeze/thaw filesystems during suspend/resume. Filesystems are only
frozen and thawed if the power subsystem does actually own the freeze.

Othwerwise it risks thawing filesystems it didn't own. This could be
done differently be e.g., keeping the filesystems that were actually
frozen on a list and then unfreezing them from that list. This is
disgustingly unclean though and reeks of an ugly hack.

If the filesystem is already frozen by the time we've frozen all
userspace processes we don't care to freeze it again. That's userspace's
job once the process resumes. We only actually freeze filesystems if we
absolutely have to and we ignore other failures to freeze.

We could bubble up errors and fail suspend/resume if the error isn't
EBUSY (aka it's already frozen) but I don't think that this is worth it.
Filesystem freezing during suspend/resume is best-effort. If the user
has 500 ext4 filesystems mounted and 4 fail to freeze for whatever
reason then we simply skip them.

What we have now is already a big improvement and let's see how we fare
with it before making our lives even harder (and uglier) than we have
to.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      fs: add owner of freeze/thaw
      fs: allow pagefault based writers to be frozen
      power: freeze filesystems during suspend/resume

Luis Chamberlain (3):
      ext4: replace kthread freezing with auto fs freezing
      btrfs: replace kthread freezing with auto fs freezing
      xfs: replace kthread freezing with auto fs freezing

 fs/btrfs/disk-io.c          |  4 +--
 fs/btrfs/scrub.c            |  2 +-
 fs/ext4/mballoc.c           |  2 +-
 fs/ext4/super.c             |  3 --
 fs/f2fs/gc.c                |  6 ++--
 fs/gfs2/super.c             | 20 ++++++-----
 fs/gfs2/sys.c               |  4 +--
 fs/ioctl.c                  |  8 ++---
 fs/super.c                  | 82 ++++++++++++++++++++++++++++++++++++---------
 fs/xfs/scrub/fscounters.c   |  4 +--
 fs/xfs/xfs_discard.c        |  2 +-
 fs/xfs/xfs_log.c            |  3 +-
 fs/xfs/xfs_log_cil.c        |  2 +-
 fs/xfs/xfs_mru_cache.c      |  2 +-
 fs/xfs/xfs_notify_failure.c |  6 ++--
 fs/xfs/xfs_pwork.c          |  2 +-
 fs/xfs/xfs_super.c          | 14 ++++----
 fs/xfs/xfs_trans_ail.c      |  3 --
 fs/xfs/xfs_zone_gc.c        |  2 --
 include/linux/fs.h          | 16 ++++++---
 kernel/power/hibernate.c    | 13 ++++++-
 kernel/power/suspend.c      |  8 +++++
 22 files changed, 139 insertions(+), 69 deletions(-)
---
base-commit: a68c99192db8060f383a2680333866c0be688ece
change-id: 20250401-work-freeze-693b5b5a78e0


