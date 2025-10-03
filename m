Return-Path: <linux-fsdevel+bounces-63338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6828BB5D5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 04:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229D2422536
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 02:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842FE2E7F30;
	Fri,  3 Oct 2025 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="nbMaw/UZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EFA2DC354
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759459613; cv=none; b=fAz0olLUVxpMSuF/T18Ob57IEbWyUokbjCLtDkuDyTPEtt6ePZPHy1k/Iw2xHqV2XLyk6udicGkj7bTObkkzvk0HkHvvtb6tVb8eDNlG2+Ku8liUMPPW/AYhWVOsvrwHeAHMENB0y+XCrD6mSxwb+Pbovuxj0mLW1NGRnJFnpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759459613; c=relaxed/simple;
	bh=Ian8cjIT1K+KMP7ripOyg3kGCrE9a1brDSJjYY5GYGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uoqk7WLLZKqFXr7DqXR8H1vd2Zn5WwgOatS1cUeo8QHjLav9tLjQbK98UoxwIf9numBiyO7seKBLCRiKIOIUMAlHQ1JYEeBfMX9zgKFqgW/XNOeL4mRY7gjTLWmzQrNUhQFE/ut5g4sxly1YPdbyQ44mOyj+NmcGcUjLIsVNbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=nbMaw/UZ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1759459598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=arFPoEw4NnR9PQwbNscdAi1I77PIuHTb0JaDC1udJwA=;
	b=nbMaw/UZDhg+hoQb4TVuwGqNeiG3aIPHeSuVFTFRzNpqx9KYffjbYyDuMld80bA0J87bHq
	bK2gAC3mgTZQ0rhOBaXYllYIUn2nEdH9uolYzXIcTPMNAijtbQTHFMLttQ7Wf3gtMSal8k
	fnSmimuOx0xifD8jQzIJcj8e4leOPRiNbe+AmQWQ1lBLaz8gU3qkWK92C3j5WLBLcGI/mP
	mMZCd1n062krtCO55hHIHuvdX/WXGoz9TF0Yqt5eg9SewLT2XHp2Nr7hbIjfGD89wNq3Aw
	cR2HPncDfe10R5/USkjPjE9eExpefr8+ouyEWOdd8p82fFUSn5NlGlwt8LnlGw==
From: George Anthony Vernon <contact@gvernon.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	skhan@linuxfoundation.org
Cc: George Anthony Vernon <contact@gvernon.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Subject: [PATCH] hfs: Validate CNIDs in hfs_read_inode
Date: Fri,  3 Oct 2025 03:45:39 +0100
Message-ID: <20251003024544.477462-1-contact@gvernon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

hfs_read_inode previously did not validate CNIDs read from disk, thereby
allowing inodes to be constructed with disallowed CNIDs and placed on
the dirty list, eventually hitting a bug on writeback.

Validate reserved CNIDs according to Apple technical note TN1150.

This issue was discussed at length on LKML previously, the discussion
is linked below.

Syzbot tested this patch on mainline and the bug did not replicate.
This patch was regression tested by issuing various system calls on a
mounted HFS filesystem and validating that file creation, deletion,
reads and writes all work.

Link: https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c4ae5b@
I-love.SAKURA.ne.jp/T/
Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Signed-off-by: George Anthony Vernon <contact@gvernon.com>
---
 fs/hfs/inode.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9cd449913dc8..6f893011492a 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -321,6 +321,30 @@ static int hfs_test_inode(struct inode *inode, void *data)
 	}
 }
 
+/*
+ * is_valid_cnid
+ *
+ * Validate the CNID of a catalog record read from disk
+ */
+static bool is_valid_cnid(unsigned long cnid, s8 type)
+{
+	if (likely(cnid >= HFS_FIRSTUSER_CNID))
+		return true;
+
+	switch (cnid) {
+	case HFS_POR_CNID:
+	case HFS_ROOT_CNID:
+		return type == HFS_CDR_DIR;
+	case HFS_EXT_CNID:
+	case HFS_CAT_CNID:
+	case HFS_BAD_CNID:
+	case HFS_EXCH_CNID:
+		return type == HFS_CDR_FIL;
+	default:
+		return false;
+	}
+}
+
 /*
  * hfs_read_inode
  */
@@ -359,6 +383,11 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		}
 
 		inode->i_ino = be32_to_cpu(rec->file.FlNum);
+		if (!is_valid_cnid(inode->i_ino, HFS_CDR_FIL)) {
+			pr_warn("rejected cnid %lu\n", inode->i_ino);
+			make_bad_inode(inode);
+			break;
+		}
 		inode->i_mode = S_IRUGO | S_IXUGO;
 		if (!(rec->file.Flags & HFS_FIL_LOCK))
 			inode->i_mode |= S_IWUGO;
@@ -372,6 +401,11 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		break;
 	case HFS_CDR_DIR:
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
+		if (!is_valid_cnid(inode->i_ino, HFS_CDR_DIR)) {
+			pr_warn("rejected cnid %lu\n", inode->i_ino);
+			make_bad_inode(inode);
+			break;
+		}
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
-- 
2.50.1


