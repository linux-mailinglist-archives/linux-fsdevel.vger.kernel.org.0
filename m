Return-Path: <linux-fsdevel+bounces-67683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3BFC46B92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 13:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFA4D4E9ADF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6137D30FC17;
	Mon, 10 Nov 2025 12:56:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC728B415;
	Mon, 10 Nov 2025 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779366; cv=none; b=QkcwQH4KsDwrsR+sUGksJ/mXhrsSNW9f18D3sWELsASKrMhiWIMJV3Tj/PCbKnDqCyZ8AJtpefwn7rlHFJtN3B5TqapgWiTDFEtRIKJOS3iZ8CzIzbLIGfw1c1yE4TUtAGyCVYVNEGwfBtIWSfIY57GEoWm2F0/i08IzyLd6QNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779366; c=relaxed/simple;
	bh=3hRonQVt91y89xI4BP9gf7F8k+FbA7MOBdxoLszVGto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cex+ErTQ8sxW2/fcGviLYkwY0s4/qTlYyv1WfLbQNBzPHMzr15cUA3ileElZwSlzk3vpU8GqlqQcCq/IY0vqp2MPesSt8gJRKLg8bk4s3pM03hEp5eDeCbZpM0iu4FnL3FXISOO73tiiwiK0oxHCskckynkjG9anVze5CZqFsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d4qQl11WwzKHMjM;
	Mon, 10 Nov 2025 20:55:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BCBA61A08BE;
	Mon, 10 Nov 2025 20:55:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgBHo3nb4BFpxgoQAQ--.64193S4;
	Mon, 10 Nov 2025 20:55:55 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] bdev: add hint prints in sb_set_blocksize() for LBS dependency on THP
Date: Mon, 10 Nov 2025 20:47:14 +0800
Message-Id: <20251110124714.1329978-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHo3nb4BFpxgoQAQ--.64193S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4DurWfArWxKFyrXFykGrg_yoW8CF4rpF
	yrCr4rAr4rKF1xuFy7ZFsxG3ZI9ws5AFyUJ34fuFy2v3yUt34fWr93Kry5Xr1I9rsxCrZ3
	XF4DKrWrur1xW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoPEfDUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAIBWkRXwoyxQAAsV

From: Baokun Li <libaokun1@huawei.com>

Support for block sizes greater than the page size depends on large
folios, which in turn require CONFIG_TRANSPARENT_HUGEPAGE to be enabled.

Because the code is wrapped in multiple layers of abstraction, this
dependency is rather obscure, so users may not realize it and may be
unsure how to enable LBS.

As suggested by Theodore, I have added hint messages in sb_set_blocksize
so that users can distinguish whether a mount failure with block size
larger than page size is due to lack of filesystem support or the absence
of CONFIG_TRANSPARENT_HUGEPAGE.

Suggested-by: Theodore Ts'o <tytso@mit.edu>
Link: https://patch.msgid.link/20251110043226.GD2988753@mit.edu
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 block/bdev.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 810707cca970..4888831acaf5 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -217,9 +217,26 @@ int set_blocksize(struct file *file, int size)
 
 EXPORT_SYMBOL(set_blocksize);
 
+static int sb_validate_large_blocksize(struct super_block *sb, int size)
+{
+	const char *err_str = NULL;
+
+	if (!(sb->s_type->fs_flags & FS_LBS))
+		err_str = "not supported by filesystem";
+	else if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		err_str = "is only supported with CONFIG_TRANSPARENT_HUGEPAGE";
+
+	if (!err_str)
+		return 0;
+
+	pr_warn_ratelimited("%s: block size(%d) > page size(%lu) %s\n",
+				sb->s_type->name, size, PAGE_SIZE, err_str);
+	return -EINVAL;
+}
+
 int sb_set_blocksize(struct super_block *sb, int size)
 {
-	if (!(sb->s_type->fs_flags & FS_LBS) && size > PAGE_SIZE)
+	if (size > PAGE_SIZE && sb_validate_large_blocksize(sb, size))
 		return 0;
 	if (set_blocksize(sb->s_bdev_file, size))
 		return 0;
-- 
2.46.1


