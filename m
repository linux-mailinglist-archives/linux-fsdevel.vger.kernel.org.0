Return-Path: <linux-fsdevel+bounces-9868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C984585C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4AB1F24C31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8D31A27A;
	Thu,  1 Feb 2024 13:00:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AE52135B;
	Thu,  1 Feb 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792447; cv=none; b=AUobfvaTUI9vj2NmEoOXjWbhWBpxz4D+6JD3zgHHfpRf73T7YZIWQGG/TAOnAK34TMkhvhgCcp1vXtonTMvTlTsDuJADkUf11nKuqP5OLWgAVx3OT3AHnQMZwDdtTQIsW4dmNnKBdYDGjZVnWmGgKQSxPxYiToUfuLZzCtXjSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792447; c=relaxed/simple;
	bh=KGwHBmWrAATKZPHoOixC25AHQc2bWnaKnUFnY/2WAO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RNXvXgnOFDYuEBk0efhpnRmBHSaohDhUK+rEX2EhlXFwpDTqdDcFZbOjE5sY9lVZJsFaalAiWh5IRdCdy9zr+PV8BqugYaOBXBqwXZkv2C+fzKSoMC7iWEmJtAUPr3ouVX+J6opnzr3cJPS6QboMuz7+7ZR6S5oGFkF1BnmaUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [60.177.98.222])
	by mail-app3 (Coremail) with SMTP id cC_KCgCXezX0lbtlXt3jAA--.1379S2;
	Thu, 01 Feb 2024 21:00:37 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] hfs: fix a memleak in hfs_find_init
Date: Thu,  1 Feb 2024 21:00:24 +0800
Message-Id: <20240201130027.3058006-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgCXezX0lbtlXt3jAA--.1379S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy5Cw43Kw45Jw48Gr1UGFg_yoWDGwb_Za
	1xu3s2gw1kur9xA34avF9YqFWDGa929r4xWr47tF18K39a9a4xGFs2qr95AryfWF12kryx
	JryUJ3yF93ZxXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

In every caller of hfs_find_init, `ptr` won't be freed when hfs_find_init
fails, but will be freed when somewhere after hfs_find_init fails.
This suggests that hfs_find_init should proberly free `ptr` in its own
error-handling to prevent `ptr` from leaking.

In particular, When the switch statment goes to default and return an error,
`ptr` should be freed.

Fixes: b3b2177a2d79 ("hfs: add lock nesting notation to hfs_find_init")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
Changelog:

v2: Improve commit message to be more clear.
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


