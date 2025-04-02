Return-Path: <linux-fsdevel+bounces-45518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46277A790C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 16:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6973AAE56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2623A989;
	Wed,  2 Apr 2025 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAZKmy2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1115317BB6;
	Wed,  2 Apr 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602897; cv=none; b=m3OXE8J/EUI3Fwu6K6SS12VsWvENc6RibPqZ1mOlCYWAlAeYcUYhTGyiQ0AOujDxt0vECoGyge0w7mohktOlsjfylVj5VBRHBH8DQ6zhf0oNy9AVqUOCE0XJIOaraLhk2RNUOdssBPFbPBxRC9x1BoxRHzexcaRoq7OkLEuGnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602897; c=relaxed/simple;
	bh=5LSN8xbr1mSlhFYbFKGSzQEbQQIkR41oBPOPFGrZKHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acC3zFWQXFXTPfhwxXXHAwYMjgiOyxNpZvHwlqMx8uwWJBhr5S0yQIo4hDVliIj+OWJb0s65rneK2zC8q180Y65zxi0n1zr91RL6/LnsERSAC0PLsJ/qwMjTzjTD6ocYYThFYdpZLYFHbjQng22OgyqhPUee2ssMi5Se+ujQSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAZKmy2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCB2C4CEE9;
	Wed,  2 Apr 2025 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743602896;
	bh=5LSN8xbr1mSlhFYbFKGSzQEbQQIkR41oBPOPFGrZKHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAZKmy2TLrzWHjuSZVHbJOy1ksb1IPe2yGDtRbs5XL4mXSXoKRzuVRImVNr13co6l
	 GqORv9ixdGSf2DPoItQR3urSEdeBMv4QLmmHMMiBzOq6Po+annHiQfyNaCacRTO/r5
	 kY2Hf0iUGHduBnPcA2ef0gOKQysuyFyBvzpeMPF8kmaZpXzKtzVoaEXGzjZqxGchYH
	 MYwd0T+iWBesX4U6BztU/16zqsznjWihUocOgdPVSWCmK/osor6ETt8MvSUfdcpv8P
	 EWQV3KYyaaM9rSoBP8aAfTydD9KTyCvyCnwG1d868YfnGwphFeRLxmWkRXviShk9T3
	 qKD+Gu4m3AiwQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH v2 0/4] power: wire-up filesystem freeze/thaw with suspend/resume
Date: Wed,  2 Apr 2025 16:07:30 +0200
Message-ID: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <5tiim72iyudzgmjbyvavfumprrifydt2mfb3h3wycsnqybek23@2ftdyt47yhyl>
References: <5tiim72iyudzgmjbyvavfumprrifydt2mfb3h3wycsnqybek23@2ftdyt47yhyl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250401-work-freeze-693b5b5a78e0
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2454; i=brauner@kernel.org; h=from:subject:message-id; bh=5LSN8xbr1mSlhFYbFKGSzQEbQQIkR41oBPOPFGrZKHc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/dVk5L3v5e3GXp2eVHcISWtruB5ps/MgXoOrLImH94 ZuPQdD6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlk+TIyPHlk+u6O8TO/N5Mc nL6Ui0zx/9dlWbzjkcOtK+qKOwqvHmdkmGZV9dzjvfnipHmRi/TWM8jwL5NO488w1sp8u6VFvdu UDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

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
Changes in v2:
- Drop all patches that remove TASK_FREEZABLE.
- Expand commit messages a bit.
- Link to v1: https://lore.kernel.org/r/20250401-work-freeze-v1-0-d000611d4ab0@kernel.org

---
Christian Brauner (4):
      fs: add owner of freeze/thaw
      fs: allow all writers to be frozen
      power: freeze filesystems during suspend/resume
      kernfs: add warning about implementing freeze/thaw

 fs/f2fs/gc.c                |  6 ++--
 fs/gfs2/super.c             | 20 ++++++-----
 fs/gfs2/sys.c               |  4 +--
 fs/ioctl.c                  |  8 ++---
 fs/kernfs/mount.c           | 15 +++++++++
 fs/super.c                  | 82 ++++++++++++++++++++++++++++++++++++---------
 fs/xfs/scrub/fscounters.c   |  4 +--
 fs/xfs/xfs_notify_failure.c |  6 ++--
 include/linux/fs.h          | 16 +++++----
 kernel/power/hibernate.c    | 16 ++++++++-
 kernel/power/main.c         | 31 +++++++++++++++++
 kernel/power/power.h        |  4 +++
 kernel/power/suspend.c      |  7 ++++
 13 files changed, 174 insertions(+), 45 deletions(-)
---
base-commit: 62dfd8d59e2d16873398ede5b1835e302df789b3
change-id: 20250401-work-freeze-693b5b5a78e0


