Return-Path: <linux-fsdevel+bounces-73152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A71F3D0E8DA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 11:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE4A6300BDBC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BEB3328E2;
	Sun, 11 Jan 2026 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="iLxSAjyM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979593321B0
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768126504; cv=none; b=kJtPCTsbjCWGevmTm5/WG7YkV9G5A9dhn45ZBMdSLLyU8p8qaYhbgsNH71fadoHXd4CqmZzEcmfxr/6NkM1I0WZ42y7hW6+mW6I3qKTZHaQ6fvv8Un3W/VcN326sAEvE1bt6dX8pPVwbZIl2W6H3YycXA4AB2UIs9x/rY151tk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768126504; c=relaxed/simple;
	bh=rGhbNSriYD/xZ6FPaQ6m/3kCoqlFbrwyWBVxGN2hQgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxFrFPoEa/MoiAoeiQE8cXoJlSXePEIVNzy2Ff+ts4v8zPj98G70Zd4i06Imr3ufoNjEB1nQ9QSTfpmd9DwoCxlSJiU32u3cWUZJH9pHau9eLXL+vtTW9OFRbA02Y13dCsxuvLLljijmQ7tFpSgSaGFO9s7f4ZZc1BYwOhIPniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=iLxSAjyM; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IM
	7pmdN0D6eT9k9LQNRMMJ4aBDmgeZu02mUdCD87x9g=; b=iLxSAjyM8Q1N/I2dth
	xGTuq1imvTF/WMlRTgF+s71hZMh7wzshiv0meNraTJ8zQ8p3agCwYriRJtM1ClUA
	VFcdW/jDHQDNvmGUfogGeoHnP0/DV5BUXgUFADyvnEhIBkQ7pJcOqHYv5pZdahRn
	weqb2RyyP1u6Nak+2fue90CmQ=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3lx+Ad2Np0FddBg--.65279S3;
	Sun, 11 Jan 2026 18:12:20 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [f2fs-dev] [PATCH v2 1/2] f2fs: add 'folio_in_bio' to handle readahead folios with no BIO submission
Date: Sun, 11 Jan 2026 18:09:40 +0800
Message-Id: <20260111100941.119765-2-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111100941.119765-1-nzzhao@126.com>
References: <20260111100941.119765-1-nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lx+Ad2Np0FddBg--.65279S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4xurWrCw4DKryrXryUAwb_yoW8Cr43pF
	yDKF95KFs8Gay8ur48tws0vw1Sk348Wa1UGFWfCw1fAasxXa4rKFy0q34Y9F1UtFn5JF1I
	qF4FvryUWa1UtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRaLvtUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsAQyAmljd4SbEAAA32

f2fs_read_data_large_folio() can build a single read BIO across multiple
folios during readahead. If a folio ends up having none of its subpages
added to the BIO (e.g. all subpages are zeroed / treated as holes), it
will never be seen by f2fs_finish_read_bio(), so folio_end_read() is
never called. This leaves the folio locked and not marked uptodate.

Track whether the current folio has been added to a BIO via a local
'folio_in_bio' bool flag, and when iterating readahead folios, explicitly
mark the folio uptodate (on success) and unlock it when nothing was added.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/data.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f32eb51ccee4..ddabcb1b9882 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2436,6 +2436,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	unsigned nrpages;
 	struct f2fs_folio_state *ffs;
 	int ret = 0;
+	bool folio_in_bio;

 	if (!IS_IMMUTABLE(inode))
 		return -EOPNOTSUPP;
@@ -2451,6 +2452,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	if (!folio)
 		goto out;

+	folio_in_bio = false;
 	index = folio->index;
 	offset = 0;
 	ffs = NULL;
@@ -2536,6 +2538,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 					offset << PAGE_SHIFT))
 			goto submit_and_realloc;

+		folio_in_bio = true;
 		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
 				F2FS_BLKSIZE);
@@ -2545,6 +2548,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	}
 	trace_f2fs_read_folio(folio, DATA);
 	if (rac) {
+		if (!folio_in_bio) {
+			if (!ret)
+				folio_mark_uptodate(folio);
+			folio_unlock(folio);
+		}
 		folio = readahead_folio(rac);
 		goto next_folio;
 	}
--
2.34.1


