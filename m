Return-Path: <linux-fsdevel+bounces-10601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50684CA8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 13:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0711C24C12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 12:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B74259B53;
	Wed,  7 Feb 2024 12:12:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DD959B7A;
	Wed,  7 Feb 2024 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307956; cv=none; b=ULJxjAHwWbWhuf7LgaRT7EWMy0M3hS8cNo2clqWPtmBHlFRucVvc3jgw/wEiQDCNlU0zjRXsL5+5yBDTmQ4aoy1/KD1H6cPBtNra3wdVjyedCVFNyIzmIZHgcJgwUwmee4GZaFUKSkEvxrKJPgWIYn/TuWv5vCNVThAQ8nXZca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307956; c=relaxed/simple;
	bh=uaCk34XimdWFsY6rPzntiDvSX1Y/Yj1+4ziH7jT3T7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UrQxGj1doRH/9h6WL15r958noRW7IkMHEmE+HVFQq4csytw+VS+vn2lngcy56/ulqwKAj+akXhZBhlNVuAphp4IfFcIMP7Hi4fwxlm7O0qQLQ9XzrMDit3iBdZA94N97eAWjhOQoIaydolT6HsCQGZC1oW2+i0rY8cP2t3PIj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [39.174.92.167])
	by mail-app2 (Coremail) with SMTP id by_KCgDHCamYc8NlQPZ1AQ--.27667S2;
	Wed, 07 Feb 2024 20:12:09 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] hfs: fix a memleak in hfs_find_init
Date: Wed,  7 Feb 2024 20:12:00 +0800
Message-Id: <20240207121202.3142524-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:by_KCgDHCamYc8NlQPZ1AQ--.27667S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtFykCF45uFW3KF4xGF4kJFb_yoW8Jr4UpF
	WxCrZ0ka1DGr1YvwnrZ3WfW34SkrsakFWUArWrAw17uwsIv3ZakrWkt3yYvFn0yrWxZa15
	Jr15Xr15ZwnFv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

If hfs_find_init succeeds but some other function called after it fails,
the overall cleanup function of hfs_find_init (i.e. hfs_find_exit) will
be called and `fd->search_key` is freed. However, if hfs_find_init fails
and returns an error, neither external nor internal deallocation of
`fd->search_key` is triggered.

This observation suggests that there could be a memleak problem in
hfs_find_init. In this patch, we add the missing deallocation in the
error-handling path (i.e. the default branch of the switch statement) to
prevent such memory leak.

Fixes: b3b2177a2d79 ("hfs: add lock nesting notation to hfs_find_init")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
Changelog:

v2: Improve commit message to be more clear.
v3: Update commit message.
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


