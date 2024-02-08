Return-Path: <linux-fsdevel+bounces-10753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7B84DCD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929CC1C22AF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCBC76031;
	Thu,  8 Feb 2024 09:23:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A26EB6E;
	Thu,  8 Feb 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384193; cv=none; b=QD+/COhVfOuXYPc1le1V9NssKF1ReevqzdBlvMeIBirooiDRzDKVFsiB2LVNFZR9T+V0NB0L+tenbG/gtvIsgJatmoG9veB0/ezo9JJhdBLGIe8tjaf1irheEHtRRG3Ox4YoIodS6Tk5e8nrShEQ0WeVxyoG1GxkUu7yC0aoldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384193; c=relaxed/simple;
	bh=buq5LdcGq+scmwclurdsaNhgHllZWHnoWJ875s8+pn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxHCj02f2lcmIO2YxpiDjIJj9/+nmk9l00aO1AeHSsUOtRa2dUd6vjMMcHJqg9mhndPydXPNaes7+RWW0Atj0mxhFUGC0T1nCWU3FFyblfC/fzuDwqZFFesa6CgcTU4FX6k23kj59xHHmm9gSROu/b0NnpkkgpLk/e6a65qWA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TVs3D0zk1z4f3kF8;
	Thu,  8 Feb 2024 17:23:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9E4A91A0B93;
	Thu,  8 Feb 2024 17:23:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQx4ncRl3tGXDQ--.8574S9;
	Thu, 08 Feb 2024 17:23:08 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] fs/writeback: remove unnecessary return in writeback_inodes_sb
Date: Fri,  9 Feb 2024 01:20:24 +0800
Message-Id: <20240208172024.23625-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240208172024.23625-1-shikemeng@huaweicloud.com>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnSQx4ncRl3tGXDQ--.8574S9
X-Coremail-Antispam: 1UD129KBjvdXoW7Jry8Cw1kKr1UXFWrXrW3Awb_yoW3Jrc_XF
	15XFs2yFnFqF45Aay8Zas3JF4v9Fn5CF1kJFySkF98J3WY9rykZr4vvw4DJryv9a47XFWD
	Gw1fXrWUtrWkKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0D
	M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0TqcUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

writeback_inodes_sb doesn't have return value, just remove unnecessary
return in it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 816505d74b2f..eb62196777dd 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2748,7 +2748,7 @@ EXPORT_SYMBOL(writeback_inodes_sb_nr);
  */
 void writeback_inodes_sb(struct super_block *sb, enum wb_reason reason)
 {
-	return writeback_inodes_sb_nr(sb, get_nr_dirty_pages(), reason);
+	writeback_inodes_sb_nr(sb, get_nr_dirty_pages(), reason);
 }
 EXPORT_SYMBOL(writeback_inodes_sb);
 
-- 
2.30.0


