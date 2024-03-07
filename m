Return-Path: <linux-fsdevel+bounces-13878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842D5874EE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 13:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AED61F23C29
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4186312BEA6;
	Thu,  7 Mar 2024 12:23:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC512AADB;
	Thu,  7 Mar 2024 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814199; cv=none; b=l/vmhALvqDXz2wQRIHU7WgAr7OavW/ilF+TmWPEVV2ZZ2Zw03hhNk22BeNfKj2OlVVtA1bm8T7BDmWyzR+Pq7PpNFebXIRfijzrFXoSU6+vc69gFCgNL/bu9XKrw8J0elymWM7aUEHtiIf4gMp+JsyKlHa76cyilkQuOP/iTQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814199; c=relaxed/simple;
	bh=47347CDrcctM5q9XZgq8/xM8yKL2YcYdeT0/hb+myVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bsJXsEKo8DKwWzf769ANwnzjJzyouVu12lsB/Ys8Gqlm8qzEEnaP8t8Q7YNtnftHc0gWjH+gX6FxS9OQcoyyGugLztxogp05KCcTeqhBAG/wsNAm6NvyUhTZi68lNXDPHTnpr6/M0sQZRpshnrBp3kVnFEgDDYRABN3hxy5W1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tr7HG3lf7z9xxml;
	Thu,  7 Mar 2024 20:03:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id AB30214037C;
	Thu,  7 Mar 2024 20:23:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3LxihselliRTjAw--.14417S2;
	Thu, 07 Mar 2024 13:23:07 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>
Subject: [PATCH] evm: Change vfs_getxattr() with __vfs_getxattr() in evm_calc_hmac_or_hash()
Date: Thu,  7 Mar 2024 13:22:39 +0100
Message-Id: <20240307122240.3560688-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwA3LxihselliRTjAw--.14417S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4rCw4DAr15Jw45JF17trb_yoW8GFykpF
	W5Ka9rKrn5JryrKas5GF4kAayF93yUXr47KrsxAa4Iv3Z8ZryxZr92qry7uryFvr18trn5
	J3yqqr1Yyw13A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU8imRUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj5cVqAABsT

From: Roberto Sassu <roberto.sassu@huawei.com>

Use __vfs_getxattr() instead of vfs_getxattr(), in preparation for
deprecating using the vfs_ interfaces for retrieving fscaps.

__vfs_getxattr() is only used for debugging purposes, to check if kernel
space and user space see the same xattr value.

Cc: stable@vger.kernel.org # 5.14.x
Cc: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
Fixes: 907a399de7b0 ("evm: Check xattr size discrepancy between kernel and user")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index b1ffd4cc0b44..168d98c63513 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -278,8 +278,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (size < 0)
 			continue;
 
-		user_space_size = vfs_getxattr(&nop_mnt_idmap, dentry,
-					       xattr->name, NULL, 0);
+		user_space_size = __vfs_getxattr(dentry, inode, xattr->name,
+						 NULL, 0);
 		if (user_space_size != size)
 			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
 				 dentry->d_name.name, xattr->name, size,
-- 
2.34.1


