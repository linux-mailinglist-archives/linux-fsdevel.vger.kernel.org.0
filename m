Return-Path: <linux-fsdevel+bounces-36056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF29DB54C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEADCB27EAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2B194A54;
	Thu, 28 Nov 2024 10:07:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860C193430;
	Thu, 28 Nov 2024 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788460; cv=none; b=KD//dlbUA0+FXlNhIDLEi0EyHwbeqDiQJeQGP4scj5kPp1TgurUc6hwW9B3qPOie6Px1A1xVMIoWniq57jJqM198bmfKeQim3m6Gd1xsE/I9Fr/ZJAJMniov10ZY0f0mHEiuJ1IyjgLzMizOV9G3JiM487e84GA67PU0eewsEZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788460; c=relaxed/simple;
	bh=2IwQCLW0Cl7dvj0cwRolE77xLo/mTohYgXOP0ykyCdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqoBlvV+AMRSylgCE2Bqk3yDKdd6ZMJq6cRimvAUPG2d74l+cBAobWr3SEd9sORnXLFkV1NnYjcJp5sng5txRin7NBUr224zna+lf7NkP1fNiXgQGMcqLs6QcdKxqUYd2oLukbW2kn/Dmod0o8ac8xbPHC2KQ5ksGQ00I4ga5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XzWWF340vz9v7JM;
	Thu, 28 Nov 2024 17:40:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id D3AA714039E;
	Thu, 28 Nov 2024 18:07:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAnj365QEhn6eNzAg--.15234S6;
	Thu, 28 Nov 2024 11:07:28 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 4/7] ima: Mark concurrent accesses to the iint pointer in the inode security blob
Date: Thu, 28 Nov 2024 11:06:17 +0100
Message-ID: <20241128100621.461743-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
In-Reply-To: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAnj365QEhn6eNzAg--.15234S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy5Ww1rCw13WFyxXF1DJrb_yoW8Gr4xpF
	yqqa4UG3s8ZFWxuFsYqF9rZr1SgayrKF48J398uwsFyF95Jr4FqrW8tr1a9Fy3Gr18tan2
	qr4jga15A3ZFyr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07jxwIDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGdH1TUCmgABsd

From: Roberto Sassu <roberto.sassu@huawei.com>

Use the READ_ONCE() and WRITE_ONCE() macros to mark concurrent read and
write accesses to the portion of the inode security blob containing the
iint pointer.

Writers are serialized by the iint lock.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_iint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index fca9db293c79..c763f431fbc1 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -32,7 +32,7 @@ struct ima_iint_cache *ima_iint_find(struct inode *inode)
 	if (!iint_lock)
 		return NULL;
 
-	return iint_lock->iint;
+	return READ_ONCE(iint_lock->iint);
 }
 
 #define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH + 1)
@@ -99,7 +99,7 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
 
 	lockdep_assert_held(&iint_lock->mutex);
 
-	iint = iint_lock->iint;
+	iint = READ_ONCE(iint_lock->iint);
 	if (iint)
 		return iint;
 
@@ -109,7 +109,7 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
 
 	ima_iint_init_always(iint, inode);
 
-	iint_lock->iint = iint;
+	WRITE_ONCE(iint_lock->iint, iint);
 
 	return iint;
 }
-- 
2.47.0.118.gfd3785337b


