Return-Path: <linux-fsdevel+bounces-66549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19399C23674
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 07:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B27EA4E3177
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 06:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301032FB621;
	Fri, 31 Oct 2025 06:31:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966F239E61;
	Fri, 31 Oct 2025 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892285; cv=none; b=bUb4T82IH9qoc6hVvvy/nfbmb4qFTtzZXd7EQJEhVfKMdspki445dSolhD+3Q/Z5VBFf5w87RWFOduyZ7GiyyIsTSzDs9795OH4LNCj1fjIhlTAHf4QdNOMMR4r5SW/t3oN3ql404YNFfu3Ny+YAgv8MxkzeeTi1fcZbQJ56lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892285; c=relaxed/simple;
	bh=o44F4mLmP19tNT6q7Oqbg6UcUMAts5UKj4rziyYtqm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tR+BRT5sNRAro4XNkHLG6vGHMy42fYzPOKAPxAvS2LUI0bw3VJbdLb+PBLAabNg0p6S5fuK3NvNZHN8n//Bxol5HVclASd7HrLAVCmK6aBAbNs7WOS4PgTtLsg/9Gg1oijtiVjOiA0roRMLWhVyWyDuCKubeZEzO6IMJHHUIULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cyWMj17vkzYQtkN;
	Fri, 31 Oct 2025 14:31:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 248E01A1B8A;
	Fri, 31 Oct 2025 14:31:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgBHnESuVwRpEFrWCA--.33311S7;
	Fri, 31 Oct 2025 14:31:21 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 3/4] ext4: adjust the debug info in ext4_es_cache_extent()
Date: Fri, 31 Oct 2025 14:29:04 +0800
Message-ID: <20251031062905.4135909-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
References: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnESuVwRpEFrWCA--.33311S7
X-Coremail-Antispam: 1UD129KBjvJXoWruw4fCr43Ary5Cw4rCFy8Zrb_yoW8Jr1Dpa
	s3CF1UJr1rZ3yq9a4xGr48Jr13Way8GrW7JrZ3tw1ruay8ZryrKF1qyFyYvFyUXFWxXw4a
	vF40kw1UWa1jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUHWlkUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Print a trace point after successfully inserting an extent in the
ext4_es_cache_extent() function. Additionally, similar to other extent
cache operation functions, call ext4_print_pending_tree() to display the
extent debug information of the inode when in ES_DEBUG mode.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 55103c331b6b..ae25a3888de4 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1052,7 +1052,6 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 	newes.es_lblk = lblk;
 	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, pblk, status);
-	trace_ext4_es_cache_extent(inode, &newes);
 
 	if (!len)
 		return;
@@ -1073,6 +1072,8 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 			goto unlock;
 	}
 	__es_insert_extent(inode, &newes, NULL);
+	trace_ext4_es_cache_extent(inode, &newes);
+	ext4_es_print_tree(inode);
 unlock:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 }
-- 
2.46.1


