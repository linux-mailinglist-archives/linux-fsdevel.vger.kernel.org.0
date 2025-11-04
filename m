Return-Path: <linux-fsdevel+bounces-66874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC0CC2EE0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 02:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C08A3B6F3E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 01:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA59239E60;
	Tue,  4 Nov 2025 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="EfvNsUOF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1F34D3B1
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 01:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220977; cv=none; b=cNS3ns+k5zBPFw97IJKaUnDfciedHgdD8vWO02fssqdSuMqQSeeEGpD00BGIjQN+3JdrHh1A0eu88+snA/jt5LXO4Iyfaw3sujEGPwdUyWCHTChdlQU3/a/c1x5tINeJRYWofPpPSuOWnxDFzlgwuuTXnBhh4EeewZo2Ctft0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220977; c=relaxed/simple;
	bh=EtHjVYidO7JVfTJF23zoRwPGX6WasUH30g8H9z7x3Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4AS78bgNM8YiKlVpNGy8bxrHAFVqFxtTye1aVFObBjFI3GhciNVM3syTnWZ/4oEFRdLVYZvUVTisILgGkdJcQUTvPlFY+M3RZt2HDjyNpTvAEXFS2aMKJeRifd8s1Q7/A6oF7FM6I72h2k9sIVQ7zdoKiL+uJU8+Q4EbxgPYn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=EfvNsUOF; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1762220972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjFX/81Y0re8gVRg79dRQiABafb6DaeO5lM9NV5uG1w=;
	b=EfvNsUOF09VBBcu4b116uiekiy6M/ykVYGxKOf0Hm45akkGUqAMDqZbeofTt9+VE7UrmwN
	QBBK/6+3HwlaIGCcDgUgb0riBK3Yl3HJmIh9lUEOwb1kAfTSOg1INohhC6+zTxHUGPwmtP
	LCREtZV5eQ7Nm4RE+eJBVGS4Z1PDJbzrFvQtg5yND08qEY/BK7d3RSOBbc3YlIZU/SAOPX
	rFYwtgz8b95oDj0xnEmoEiklPggIvyVZx6jfjeWLRKJFvnFcvKJzflma4ZJ18pzDr9APur
	eKYcI/WLRlmscb9uwFplfYOEaL5BuEuk6Yu+2hJ39IXCVRDbR9Roj6efF39Fsg==
From: George Anthony Vernon <contact@gvernon.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	skhan@linuxfoundation.org
Cc: George Anthony Vernon <contact@gvernon.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	penguin-kernel@i-love.sakura.ne.jp,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 2/2] hfs: Update sanity check of the root record
Date: Tue,  4 Nov 2025 01:47:37 +0000
Message-ID: <20251104014738.131872-4-contact@gvernon.com>
In-Reply-To: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
operation when the inode number of the record retrieved as a result of
hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for commit
b905bafdea21 ("hfs: Sanity check the root record") checked the record
size and the record type but did not check the inode number.

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: George Anthony Vernon <contact@gvernon.com>
---
 fs/hfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 47f50fa555a4..a7dd20f2d743 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -358,7 +358,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
-		if (rec.type != HFS_CDR_DIR)
+		if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
 			res = -EIO;
 	}
 	if (res)
-- 
2.50.1


