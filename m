Return-Path: <linux-fsdevel+bounces-55493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6DEB0AD81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 04:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E749F586708
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEA0195FE8;
	Sat, 19 Jul 2025 02:50:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6008C9476;
	Sat, 19 Jul 2025 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752893420; cv=none; b=KBaKbTm0edUjcpQSK9njoS2xMlbHnShyJ84Br3YJnL0Tpvz6fjkW1Y5oRL6JmhjiipMLpW+aR+TWgx9CIDoE5i6usQJMw77CfFDtd99rG+YJVKERfd4ARmsNTvVh3SiIgZSVs3pmO3MAxef39iZS5bLOX9+UhvgzH6c5X8ACglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752893420; c=relaxed/simple;
	bh=t9Py5tL8Dk6bAJwADZccNx+0tjERFwe/Vl3OBS1dYig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ev1AlkTa60RNG7XetsuGs2XEXc6xoG1QnL9NZUU7vGmGNTCpJ0vh5wU5KWBPG36q7E79tyO6odGNI4x1E/oSIhoEsRLZSMCSUOp3Vv9ZHcjWETt4+MW8lbHxdxYT0qcIoA65zdyGmueEmg1mgJeSHeXx1Aj7fje717GcBlWf+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bkWKP5NP4z13MRv;
	Sat, 19 Jul 2025 10:47:21 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C792180468;
	Sat, 19 Jul 2025 10:50:13 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Jul 2025 10:50:12 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <viro@zeniv.linux.org.uk>, <jack@suse.com>, <brauner@kernel.org>,
	<axboe@kernel.dk>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <yukuai3@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH] fs: Add additional checks for block devices during mount
Date: Sat, 19 Jul 2025 10:44:03 +0800
Message-ID: <20250719024403.3452285-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100017.china.huawei.com (7.202.181.16)

A filesystem abnormal mount issue was found during current testing:

disk_container=$(...kata-runtime...io.kubernets.docker.type=container...)
docker_id=$(...kata-runtime...io.katacontainers.disk_share=
            "{"src":"/dev/sdb","dest":"/dev/test"}"...)
${docker} stop "$disk_container"
${docker} exec "$docker_id" mount /dev/test /tmp -->success!!

When the "disk_container" is stopped, the created sda/sdb/sdc disks are
already deleted, but inside the "docker_id", /dev/test can still be mounted
successfully. The reason is that runc calls unshare, which triggers
clone_mnt(), increasing the "sb->s_active" reference count. As long as the
"docker_id" does not exit, the superblock still has a reference count.

So when mounting, the old superblock is reused in sget_fc(), and the mount
succeeds, even if the actual device no longer exists. The whole process can
be simplified as follows:

mkfs.ext4 -F /dev/sdb
mount /dev/sdb /mnt
mknod /dev/test b 8 16    # [sdb 8:16]
echo 1 > /sys/block/sdb/device/delete
mount /dev/test /mnt1    # -> mount success

Therefore, it is necessary to add an extra check. Solve this problem by
checking disk_live() in super_s_dev_test().

Fixes: aca740cecbe5 ("fs: open block device after superblock creation")
Link: https://lore.kernel.org/all/20250717091150.2156842-1-wozizhi@huawei.com/
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/super.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 80418ca8e215..8030fb519eb5 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1376,8 +1376,16 @@ static int super_s_dev_set(struct super_block *s, struct fs_context *fc)
 
 static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
 {
-	return !(s->s_iflags & SB_I_RETIRED) &&
-		s->s_dev == *(dev_t *)fc->sget_key;
+	if (s->s_iflags & SB_I_RETIRED)
+		return false;
+
+	if (s->s_dev != *(dev_t *)fc->sget_key)
+		return false;
+
+	if (s->s_bdev && !disk_live(s->s_bdev->bd_disk))
+		return false;
+
+	return true;
 }
 
 /**
-- 
2.39.2


