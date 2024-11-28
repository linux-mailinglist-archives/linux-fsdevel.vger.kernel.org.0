Return-Path: <linux-fsdevel+bounces-36058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AFC9DB554
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97695283129
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34806196C7C;
	Thu, 28 Nov 2024 10:07:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683D18B495;
	Thu, 28 Nov 2024 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788474; cv=none; b=OLvAavUzi4rCLcX08tIlB9zsKrToDP0JNEoxnvLUYbCsQQT4/TIcoIbZAwiLBCeNc913LIR+asnflgkjbvrBmzo3C90H0LWPr/PYZvn+iQxwsYcAwK9pLVzvFnJZO+yQL5nT3u6AgUgZZSpZBcc2IGV9QEAH6tY1SeUWV1ub/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788474; c=relaxed/simple;
	bh=xRRIuZ9kFkonOepYI1GvHgFa5dc2Ba237bKKwbLQHgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY7lWRlOrUpSWH7dHVZ+ZqGCadcO3DVxla2NNoqFO/wg12UirK51S0uJ+N8/y9KJFLHdg/YAQfZ9s012s3DHyYyWK7c9WK2ISbcKNTIsJI81IyZV3JWvhBcYjg4iAQ5WsKDXTIoJKpJ/C4P1t2Icq2bdpx3Ke4Z3+dTTm1iaL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XzWfv1J8pz9v7NM;
	Thu, 28 Nov 2024 17:46:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B9B0C140393;
	Thu, 28 Nov 2024 18:07:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAnj365QEhn6eNzAg--.15234S8;
	Thu, 28 Nov 2024 11:07:44 +0100 (CET)
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
	Roberto Sassu <roberto.sassu@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 6/7] ima: Discard files opened with O_PATH
Date: Thu, 28 Nov 2024 11:06:19 +0100
Message-ID: <20241128100621.461743-7-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAnj365QEhn6eNzAg--.15234S8
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyUArWDJw15CrykJr48Xrb_yoW8Wr4xpa
	9xWa4rKr95JFy0kFs5Gay2kayrKFWxKr4Uuan5WanIv3ZxXr9Ygr4fJr1UuFyfJFyYyr40
	vr1akrWaya1qy3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07jhXo7UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBGdH1TUCnAAAsa

From: Roberto Sassu <roberto.sassu@huawei.com>

According to man open.2, files opened with O_PATH are not really opened. The
obtained file descriptor is used to indicate a location in the filesystem
tree and to perform operations that act purely at the file descriptor
level.

Thus, ignore open() syscalls with O_PATH, since IMA cares about file data.

Cc: stable@vger.kernel.org # v2.6.39.x
Fixes: 1abf0c718f15a ("New kind of open files - "location only".")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 50b37420ea2c..712c3a522e6c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -202,7 +202,8 @@ static void ima_file_free(struct file *file)
 	struct inode *inode = file_inode(file);
 	struct ima_iint_cache *iint;
 
-	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ima_policy_flag || !S_ISREG(inode->i_mode) ||
+	    (file->f_flags & O_PATH))
 		return;
 
 	iint = ima_iint_find(inode);
@@ -232,7 +233,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
 
-	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ima_policy_flag || !S_ISREG(inode->i_mode) ||
+	    (file->f_flags & O_PATH))
 		return 0;
 
 	/* Return an IMA_MEASURE, IMA_APPRAISE, IMA_AUDIT action
-- 
2.47.0.118.gfd3785337b


