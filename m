Return-Path: <linux-fsdevel+bounces-39856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17550A1979A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 18:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0039416CD4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506B7215F6D;
	Wed, 22 Jan 2025 17:25:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D89215175;
	Wed, 22 Jan 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566758; cv=none; b=K5VpjO4bMeT31SslVgr+BBYOMmM6ox97ueXD3IVauH/8v/dU3Rp7Wok1wHJ8DQlN6s8D9AKpLK9HOoTQH9vc6Ty5nvPRP8wLoDjr0AP8XA317Y4jRvum6IB4Huc52ni9Ycs71gK7H3SFkF1vp7yfMOOKUMveSJEga9kujOEoZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566758; c=relaxed/simple;
	bh=plUfQCyTJZsurrbnalUzU+wyiF1hIlVErDDPnJaZDM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BGFoAzCrF8Lg7HyYBluC/2zPcY05mIkzRUrGUWlK5iGdXn1GYnAGTU4Qjndj/CbiJJ7T5ePJ3wAElTM7O3dZR4z1PuxDatxfqBEqM90zDPHuQjh9eBMaeGELtF+dj+9eE5O1/hnuiR6GmVavQTt9R/9OWHm/UbXvFPMiJKyThms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4YdVlg2Hwjz9v7J5;
	Thu, 23 Jan 2025 01:03:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8DA1B140684;
	Thu, 23 Jan 2025 01:25:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnbEvkKZFnsGscAQ--.5068S6;
	Wed, 22 Jan 2025 18:25:45 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 4/6] ima: Mark concurrent accesses to the iint pointer in the inode security blob
Date: Wed, 22 Jan 2025 18:24:30 +0100
Message-Id: <20250122172432.3074180-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
References: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDnbEvkKZFnsGscAQ--.5068S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy5Ww4UAF4DWr45Kry8Zrb_yoW8GF18pa
	4qqa4UG3s8ZFWxuFsYqF9xZF1SgayrGF48G398AwsFyFn5Jr1FqrW8tr1a9Fy5Gr18ta9a
	qr1j9a15A3W2yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBGeQmNQFOAAAsT

From: Roberto Sassu <roberto.sassu@huawei.com>

Use the READ_ONCE() and WRITE_ONCE() macros to mark concurrent read and
write accesses to the portion of the inode security blob containing the
iint pointer.

Writers are serialized by the iint lock.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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
2.34.1


