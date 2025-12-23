Return-Path: <linux-fsdevel+bounces-71996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D21B8CDAC25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 23:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 542183031375
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB02874E1;
	Tue, 23 Dec 2025 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXmHef9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA0249E5;
	Tue, 23 Dec 2025 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766529028; cv=none; b=WIAPvRGwhvargdrys5e285zDtSLS/P0ygQpVR+BcEzCXIvKurnQvw3zyv9RxgHMql3CN4QqahgNVQtmSUQw6kWyC3RjNa4D+UNgz0lwLsztRaHiL9Bku10sQojqign1VbLc67owdn+8NnKzyCPOpIN7A/Q4mTF+SFMf8SgP2EGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766529028; c=relaxed/simple;
	bh=B6r7bfV6eyaWDwee8yFIX+GBsbrDynp6ca/i76jhF4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkp4cVYFCjj3S97h5A80lOeZsLB8XXvTCQPJuk3s7ZPmX4ObrAxBY9MPd0U7y9jJaHwY3DGVu2jQuF5VX7Fl7jnpmKFr1DmgAVgcEcQ56ndbUrkBjtY6/NOl04Mb/XdOelTVXF1uqxnFfTrHE1J0hlnC5Zj2pp3bYB28DEQLMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXmHef9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71533C113D0;
	Tue, 23 Dec 2025 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766529028;
	bh=B6r7bfV6eyaWDwee8yFIX+GBsbrDynp6ca/i76jhF4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXmHef9lfdG7KkGVZvPJ8ywKUuWKf3ilOX3PtTVzGPZhNJH8T5RdeTyGJXzrb999v
	 xiOLdhpVTPYQvvYqE69NJSJvOPIYO+iCHJ2MAQ0gaDBqv+7nhRqSSCr0rQSCIvTLE2
	 3pPVXAMsEGPSe1c59Rvw3Cst/VsfBg1I+GUgMDeT0Z4d5aE7UVRJRVskIdRsYTAhos
	 X+sTOq+W9IKyXt+QTXfLhgIaFyT6mwMZmt1H150U4xPeDXkrA+zSUlc7+kkhFdL8Bv
	 i4XjMuvYS4rrRg+liWiw+lu6GpVKgqM4ufETkyYCsGyWGtFBLFNIK8vLcv7uXLEsbG
	 sJhiMnzlRgpag==
From: Sasha Levin <sashal@kernel.org>
To: joannelkoong@gmail.com
Cc: willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH 0/1] iomap: fix race between iomap_set_range_uptodate and folio_end_read
Date: Tue, 23 Dec 2025 17:30:16 -0500
Message-ID: <20251223223018.3295372-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926002609.1302233-13-joannelkoong@gmail.com>
References: <20250926002609.1302233-13-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joanne,

While testing with your FUSE iomap patchset that recently landed upstream,
I ran into a warning in ifs_free() where the folio's uptodate flag didn't
match the ifs per-block uptodate bitmap. The warning was triggered during
FUSE-based filesystem unmount when running the LTP writev03 test.

After some investigation, I believe the root cause is a race condition
that has existed since commit 7a4847e54cc1 ("iomap: use folio_end_read()")
but was difficult to trigger until now. The issue is that folio_end_read()
uses XOR semantics to set the uptodate bit, so if iomap_set_range_uptodate()
calls folio_mark_uptodate() while a read is in progress, the subsequent
folio_end_read() will XOR and clear the uptodate bit.

The FUSE iomap enablement seems to have created the right conditions to
expose this race - likely due to different file extent patterns in
FUSE-based filesystems (like NTFS-3G) compared to native filesystems
like XFS/ext4.

The fix checks read_bytes_pending under the state_lock in
iomap_set_range_uptodate() and skips calling folio_mark_uptodate() if a
read is in progress, letting the read completion path handle it.

I'm not very familiar with the iomap internals, so I'd really appreciate
your review and feedback on whether this approach is correct.

Thanks,
Sasha

Sasha Levin (1):
  iomap: fix race between iomap_set_range_uptodate and folio_end_read

 fs/fuse/dev.c          |  3 +-
 fs/fuse/file.c         |  6 ++--
 fs/iomap/buffered-io.c | 65 +++++++++++++++++++++++++++++++++++++++---
 include/linux/iomap.h  |  2 ++
 4 files changed, 68 insertions(+), 8 deletions(-)

-- 
2.51.0


