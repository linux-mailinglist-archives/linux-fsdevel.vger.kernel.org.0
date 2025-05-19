Return-Path: <linux-fsdevel+bounces-49387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD2ABBA4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E43017F05D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69A2269CED;
	Mon, 19 May 2025 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="iGuz3wx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FAE35957;
	Mon, 19 May 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648301; cv=none; b=eJZWIG4ciUU3S+72Hpxc05d9vD254EBTSebeJVH9UwI3ga8MIGnAM0fWAmh7QhULjPwz6gpZzTesRfqmHCVnCjLcaj2x+JO+Tri9Lmja8epdzxuLYKgE41X9Bsxx1YkId7HxriLl6KR16rpXrNGCpUbqBfmT0YF1N0UP5KYiJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648301; c=relaxed/simple;
	bh=1TFDZrnppSFAD0JlqH6lVEgL5rsRavitm3KqWQs/JKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FofiIaHDCLQ+7FTmi43E5W8LYcJAJR+9zXtICfM9v1jGTp1Eac8VWh9le4RDRsAZUqMBS5w+Me5r0HzLP7c9FXsJeKc3vrq9keQEm98DbgRnU8HE8hxjkpM+eZM5SbY0O7sffu7sF5mH0T4un9kdtW2FGDSHdnswNBNX0JrSOCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=iGuz3wx/; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id F19711D0B;
	Mon, 19 May 2025 09:51:24 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=iGuz3wx/;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 6FF7F21B3;
	Mon, 19 May 2025 09:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1747648296;
	bh=jJvs72gtLIf+AhNDgR1jY87eVay24QMwgXIPiSfnjBo=;
	h=From:To:CC:Subject:Date;
	b=iGuz3wx/h+N+vwC7HG2rvgFEWMwGTFx8Xhv4xJEppJKty67yDUs3qH5NhWahppZNc
	 8dz4EWMdKDyjoLTl+ZF2MTVijXG6ks31IxlxdhbLkaZPCfRFcuLmKEIRKaJhs9D3f0
	 PkodATYA3wJ7kq+UihLz5OUrMamHbKQijAzLSClE=
Received: from localhost.localdomain (172.30.20.142) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 19 May 2025 12:51:35 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Fix handling of InitializeFileRecordSegment
Date: Mon, 19 May 2025 11:51:27 +0200
Message-ID: <20250519095127.7233-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Make the logic of handling the InitializeFileRecordSegment operation
similar to that in windows.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/fslog.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index e69f623b2e49..38934e6978ec 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3091,16 +3091,16 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		inode = ilookup(sbi->sb, rno);
 		if (inode) {
 			mi = &ntfs_i(inode)->mi;
-		} else if (op == InitializeFileRecordSegment) {
-			mi = kzalloc(sizeof(struct mft_inode), GFP_NOFS);
-			if (!mi)
-				return -ENOMEM;
-			err = mi_format_new(mi, sbi, rno, 0, false);
-			if (err)
-				goto out;
 		} else {
 			/* Read from disk. */
 			err = mi_get(sbi, rno, &mi);
+			if (err && op == InitializeFileRecordSegment) {
+				mi = kzalloc(sizeof(struct mft_inode),
+					     GFP_NOFS);
+				if (!mi)
+					return -ENOMEM;
+				err = mi_format_new(mi, sbi, rno, 0, false);
+			}
 			if (err)
 				return err;
 		}
@@ -3109,15 +3109,13 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		if (op == DeallocateFileRecordSegment)
 			goto skip_load_parent;
 
-		if (InitializeFileRecordSegment != op) {
-			if (rec->rhdr.sign == NTFS_BAAD_SIGNATURE)
-				goto dirty_vol;
-			if (!check_lsn(&rec->rhdr, rlsn))
-				goto out;
-			if (!check_file_record(rec, NULL, sbi))
-				goto dirty_vol;
-			attr = Add2Ptr(rec, roff);
-		}
+		if (rec->rhdr.sign == NTFS_BAAD_SIGNATURE)
+			goto dirty_vol;
+		if (!check_lsn(&rec->rhdr, rlsn))
+			goto out;
+		if (!check_file_record(rec, NULL, sbi))
+			goto dirty_vol;
+		attr = Add2Ptr(rec, roff);
 
 		if (is_rec_base(rec) || InitializeFileRecordSegment == op) {
 			rno_base = rno;
-- 
2.43.0


