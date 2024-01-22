Return-Path: <linux-fsdevel+bounces-8462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF1F836F23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 19:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0B41C28D2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E2E664DF;
	Mon, 22 Jan 2024 17:36:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15646664AD;
	Mon, 22 Jan 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944967; cv=none; b=fWQL0uD8M7czFq4XQmrfbaV7qbtaw6HJvxFHGLkiCK9r+pDKIP1CBJHtjT/cCuyovxASy+eSbFLH4AumPfbXonNmeXh9HJ1eP4OBfbX/MuP9HN9+C4MCpjHEyMmmNjm1DJkn8uHMETD17PotPgIgSjNe7IVpyQSinZQSgdoKzcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944967; c=relaxed/simple;
	bh=lM7DH+/8lrtwvXiSqC/z22MGKWTe1DZd0HfSUOD4Jxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hKfG3tNrzBn3NWypciyVFiYqFsRjPx4TYxLdYuoyjcdgLVUDjj62i97nHp0Es6cAl/jL0Ci6nLoexEf5L7bX6HMIaZV881ZnxqoO9tF0etHmsuc2LZ8Rt1nOoAM7bmmA/YvKXsleyIQEB6xmPxIYm8aWIIIM1HvczMCqb6HvJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [39.174.92.167])
	by mail-app3 (Coremail) with SMTP id cC_KCgBnSTN7p65lk8t4AA--.4094S2;
	Tue, 23 Jan 2024 01:35:56 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hfs: fix a memleak in hfs_find_init
Date: Tue, 23 Jan 2024 01:27:17 +0800
Message-Id: <20240122172719.3843098-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgBnSTN7p65lk8t4AA--.4094S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW7Aw1kJw1UZr15AFyUGFg_yoWxZFg_Wa
	yxuwn29w1rGFyaya4aya9YgFWDWw4fur1fGr47KF1UCa9xKayxXrsF9r98AF9xWF47tryx
	JryUt34rCFn8tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUntxhUUUUU=
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

When the switch statment goes to default and return an error, ptr should
be freed since it is allocated in hfs_find_init.

Fixes: b3b2177a2d79 ("hfs: add lock nesting notation to hfs_find_init")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 fs/hfs/bfind.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..7aa3b9aba4d1 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -36,6 +36,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 		mutex_lock_nested(&tree->tree_lock, ATTR_BTREE_MUTEX);
 		break;
 	default:
+		kfree(fd->search_key);
 		return -EINVAL;
 	}
 	return 0;
-- 
2.34.1


