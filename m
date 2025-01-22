Return-Path: <linux-fsdevel+bounces-39858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293AA197A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 18:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A7C188E4AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864652165EF;
	Wed, 22 Jan 2025 17:26:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0B2163B3;
	Wed, 22 Jan 2025 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566776; cv=none; b=V218HmTnYOXtlwwAFWr4rtqS1qt6cqPRg+8jbAyU2KG6RYE6PRoDfZFJiuxZ4VjkJF6Z6YGKHuWU8CSKbtAimWLtC6gb2mMJntYRYprYzcvjL5H+OH/odvNC3O3sVl4yOQ79bAkLE+RnnR8i6V/k6HEAg4mnIy/3i+t+NIOrQtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566776; c=relaxed/simple;
	bh=+G54zyLYx4ceeWfGoCy64lc7WrHPNoQcsdY8qK53ikE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bJPum4dLrV7b8gLl6MB7zbUH6Hp07WA+Xv+c1xwlFi2hXT115nw7VKqUvLss+DHcnqimnXUXU78fSGjnn1tdi87quvAgPTcOfERBNsLHMZYsSWFSpbVTObXLCq30xzQPLyQDP5DZBGx0UPqgOGvAo5vDWjkjAiALx1bIMptcCX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdVc466Yzz9v7JQ;
	Thu, 23 Jan 2025 00:57:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id ED4E3140521;
	Thu, 23 Jan 2025 01:26:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnbEvkKZFnsGscAQ--.5068S8;
	Wed, 22 Jan 2025 18:26:05 +0100 (CET)
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
	Roberto Sassu <roberto.sassu@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 6/6] ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr
Date: Wed, 22 Jan 2025 18:24:32 +0100
Message-Id: <20250122172432.3074180-7-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDnbEvkKZFnsGscAQ--.5068S8
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1UCFWUuFWxWry7urW3Jrb_yoW5Jw48pa
	9a9FyUGr10qFW0krn3J3W3Ca4rK39F9FWUXa15Aw1vyFnxZr1jqFyDtr17CF98Wr1SkFy2
	qF9IvryYya1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07jIPfQUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBGeQmNQFOgAAsR

From: Roberto Sassu <roberto.sassu@huawei.com>

Commit 11c60f23ed13 ("integrity: Remove unused macro
IMA_ACTION_RULE_FLAGS") removed the IMA_ACTION_RULE_FLAGS mask, due to it
not being used after commit 0d73a55208e9 ("ima: re-introduce own integrity
cache lock").

However, it seems that the latter commit mistakenly used the wrong mask
when moving the code from ima_inode_post_setattr() to
process_measurement(). There is no mention in the commit message about this
change and it looks quite important, since changing from IMA_ACTIONS_FLAGS
(later renamed to IMA_NONACTION_FLAGS) to IMA_ACTION_RULE_FLAGS was done by
commit 42a4c603198f0 ("ima: fix ima_inode_post_setattr").

Restore the original change of resetting only the policy-specific flags and
not the new file status, but with new mask 0xfb000000 since the
policy-specific flags changed meanwhile. Also rename IMA_ACTION_RULE_FLAGS
to IMA_NONACTION_RULE_FLAGS, to be consistent with IMA_NONACTION_FLAGS.

Cc: stable@vger.kernel.org # v4.16.x
Fixes: 11c60f23ed13 ("integrity: Remove unused macro IMA_ACTION_RULE_FLAGS")
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h      | 1 +
 security/integrity/ima/ima_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e1a3d1239bee..615900d4150d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -141,6 +141,7 @@ struct ima_kexec_hdr {
 
 /* IMA iint policy rule cache flags */
 #define IMA_NONACTION_FLAGS	0xff000000
+#define IMA_NONACTION_RULE_FLAGS	0xfb000000
 #define IMA_DIGSIG_REQUIRED	0x01000000
 #define IMA_PERMIT_DIRECTIO	0x02000000
 #define IMA_NEW_FILE		0x04000000
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 46adfd524dd8..7173dca20c23 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -275,7 +275,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		/* reset appraisal flags if ima_inode_post_setattr was called */
 		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
 				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
-				 IMA_NONACTION_FLAGS);
+				 IMA_NONACTION_RULE_FLAGS);
 
 	/*
 	 * Re-evaulate the file if either the xattr has changed or the
-- 
2.34.1


