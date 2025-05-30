Return-Path: <linux-fsdevel+bounces-50148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB07AC8857
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 08:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C674A25B88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 06:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA53219A72;
	Fri, 30 May 2025 06:41:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B1C201006;
	Fri, 30 May 2025 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587296; cv=none; b=orVoUUOfKG/NoJhEvqVpUN4bOVo3hKUvHhY+vocn04VpeeGo4Xmp4BnsGJW8TbctFlAXQOb6gajoWrAYCDmbo6kt2o03CI1LdWEUrkknG8r9Faw4mmr54Huvf1NGYIedE0RY9L6IYX0s70mUswfRTwVaTvDYBtjRmz4UGz89hlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587296; c=relaxed/simple;
	bh=AHe9ZlzqSs1N0MqxT8r/mBag9PpTGvK3leRA+/aS4ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giP8EeyjYwF8U8IyWYHp9cG+y5Z+aIKWf//4q2zfLTtpDAg5+4tfDUJoXev9NKPs6YEIPV1lXJ/4A7L9YwPrX/P1alqR2GCFFh8CVI9z8AXsnxqM3vIznPjpOw5G2SB6LvNRVRoO6BwrpUR/CUIEjcOlw/Xf3ovZqGOg1oJuTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b7tth5wC7zYQv4K;
	Fri, 30 May 2025 14:41:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E2FCD1A1A1F;
	Fri, 30 May 2025 14:41:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl8PUzlo_wXRNw--.6893S9;
	Fri, 30 May 2025 14:41:31 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 5/5] ext4: disable large folios if dioread_nolock is not enabled
Date: Fri, 30 May 2025 14:28:58 +0800
Message-ID: <20250530062858.458039-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
References: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl8PUzlo_wXRNw--.6893S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJryDZr15CFWrKw1DJr1DKFg_yoW8WryDpF
	9xGFW8Grs8uas7CFWxtr1UXr15tayxGa1UJFWSg3WUWFW7AryfKFsYyF1rC3W7JrWxXw4S
	qF4UCrWDCw43AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The write-back process cannot restart a journal transaction when
submitting a sufficiently large and discontinuous folio if
dioread_nolock is disabled. To address this, disable large folios when
building an inode if dioread_nolock is disabled, and also ensure that
dioread_nolock cannot be disabled on an active inode that has large
folio enabled.

Fixes: 7ac67301e82f ("ext4: enable large folio for regular file")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4_jbd2.h | 7 +++++++
 fs/ext4/inode.c     | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index c0ee756cb34c..59292da272ef 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -422,6 +422,13 @@ static inline int ext4_free_data_revoke_credits(struct inode *inode, int blocks)
  */
 static inline int ext4_should_dioread_nolock(struct inode *inode)
 {
+	/*
+	 * Cannot disable dioread_nolock on an active inode that has
+	 * large folio enabled.
+	 */
+	if (mapping_large_folio_support(inode->i_mapping))
+		return 1;
+
 	if (!test_opt(inode->i_sb, DIOREAD_NOLOCK))
 		return 0;
 	if (!S_ISREG(inode->i_mode))
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e7de2fafc941..421c7bbc3ca9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5164,6 +5164,8 @@ bool ext4_should_enable_large_folio(struct inode *inode)
 		return false;
 	if (ext4_has_feature_encrypt(sb))
 		return false;
+	if (!ext4_should_dioread_nolock(inode))
+		return false;
 
 	return true;
 }
-- 
2.46.1


