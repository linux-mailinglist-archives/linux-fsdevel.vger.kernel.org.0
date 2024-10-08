Return-Path: <linux-fsdevel+bounces-31306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C8E9944F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7DB2B24FA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40FE1BFE1F;
	Tue,  8 Oct 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jCi+Ur33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A5716EB42;
	Tue,  8 Oct 2024 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381381; cv=none; b=r8Zq8rypb7x+TaFkPRatRUjjZGaXQi1o4dFNk//bIbGwmVtN70Ks5c2RWhQJzJK4YMW2G7lYJ1NRXz7/kos80aM+Qr66aBp+5iCIZn8lyKMe25jh40EE76agqNDM7N7aa1b3IGEkx2ztGvTcF5/nfiJaRc4BNKNZ8X96fodktMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381381; c=relaxed/simple;
	bh=FJR4Ir4ZuWPXAfrYHUlhoiegfsDfN7qxz21F7RWF9dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhmVKi4jmdzn5m717/Uadww1waR/jPV1KICNCB2Vmme5tVgu7NizHeb9U8nXVActWwc1F/htPXp8Nr0MePydBWULtBgIvW67w8WiHb2+AOJ4u6EVQwkKkoA3B628LhpjiyEimxweZ01RRZfAoDqLlOtxV6skMoebMRCoy9lKBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jCi+Ur33; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728381376; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1k0liHka3S7LfAa+7MLacRLt1xutM2cYpmE1M22Izy0=;
	b=jCi+Ur33o4RnqQqkunHsDH1ipG/wU230NRZmpOLphVT/bnYKQJdII/Vyz8ICbKN2/KBBqaD5aGkSj8cd3Vpv72sG04Mhquwo/q8dv4BhpDKbUOoQJozvzI+PWG9RZr3T18PAToBEzkskWBN0WxWDae0S+gfylNqzjeU5FqVrpDQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGdZ8t5_1728381374)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 17:56:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Chao Yu <chao@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: use get_tree_bdev_by_dev() to avoid misleading messages
Date: Tue,  8 Oct 2024 17:56:06 +0800
Message-ID: <20241008095606.990466-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can pass in an arbitrary source path for the proper type of
a mount then without "Can't lookup blockdev" error message.

Reported-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Closes: https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..04a5873c1594 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -700,16 +700,19 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi = fc->s_fs_info;
+	dev_t dev;
 	int ret;
 
 	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
-	ret = get_tree_bdev(fc, erofs_fc_fill_super);
+	if (!fc->source)
+		return invalf(fc, "No source specified");
+	ret = lookup_bdev(fc->source, &dev);
+	if (!ret)
+		return get_tree_bdev_by_dev(fc, erofs_fc_fill_super, dev);
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
 	if (ret == -ENOTBLK) {
-		if (!fc->source)
-			return invalf(fc, "No source specified");
 		sbi->fdev = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
 		if (IS_ERR(sbi->fdev))
 			return PTR_ERR(sbi->fdev);
-- 
2.43.5


