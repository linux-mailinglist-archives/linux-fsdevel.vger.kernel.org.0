Return-Path: <linux-fsdevel+bounces-72111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8AECDEDBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 18:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02C8301277C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77B1534EC;
	Fri, 26 Dec 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ehm53CMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3C245020;
	Fri, 26 Dec 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766771011; cv=none; b=rmztD891aokpNYVrmTj0JNKYMl+fcLzNM4iB/jAnCrg1hsqSu3rnkruMxh7HyNQzIYei0lJ+yOpdd5KdlFHzjlilx0aJnkcPcLuFRvzR4KgCm2iJQ3wMEtqmlL66VSFoB+G7yIS92kOAzydXnIRf3bPxTOacByh/h5zHABHEDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766771011; c=relaxed/simple;
	bh=xFEeWeWR3+IeCOZe2kO6e6pmsusoXLogDMrmzCK0nUE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XW75eY22zGYzJxlNw7Ybqsnib+YIa7mX9ZWsPfFUOfE4WZgJqyWMKGJvsTZbjXpyJXyrSDilzPW0kCVspYiKBM+Lr9YuCa9qSPW3/txCI3x3SRrPcrrUneloPVK3SgSbcGOSjsHIZVF05nSXccO2FxgxDoVMfLZe7bewvjwgLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ehm53CMR; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 50B161D1D;
	Fri, 26 Dec 2025 17:40:19 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=ehm53CMR;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 98FA32267;
	Fri, 26 Dec 2025 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1766771007;
	bh=U92v8ZLmSxuCCgcK3nfja+cZW+fYx8Wdi27Vm0CmqN8=;
	h=From:To:CC:Subject:Date;
	b=ehm53CMRAESqiWhzlB2mC7LaG6OO6L/Y9Qbnyin1tJgcQy+MnXorQxsISdNgQOECw
	 MA+oT8qP3yWJtym4nZzp/Kf0rzlNGNFFvNjFmrQb7rRNJ5o59yDPDr/SrUhrRI0uI6
	 z4Z/QlM8UFb5x/dAqpmjVCeOmdQyuCpMVSgM0wKI=
Received: from localhost.localdomain (172.30.20.178) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 26 Dec 2025 20:43:26 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: zero-fill folios beyond i_valid in ntfs_read_folio()
Date: Fri, 26 Dec 2025 18:43:16 +0100
Message-ID: <20251226174317.15884-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Handle ntfs_read_folio() early when the folio offset is beyond i_valid
by zero-filling the folio and marking it uptodate. This avoids needless
I/O and locking, improves read performance.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 1319b99dfeb4..ace9873adaae 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -723,6 +723,19 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
+	loff_t vbo = folio_pos(folio);
+
+	if (unlikely(is_bad_ni(ni))) {
+		folio_unlock(folio);
+		return -EIO;
+	}
+
+	if (ni->i_valid <= vbo) {
+		folio_zero_range(folio, 0, folio_size(folio));
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+		return 0;
+	}
 
 	if (is_resident(ni)) {
 		ni_lock(ni);
-- 
2.43.0


