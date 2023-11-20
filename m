Return-Path: <linux-fsdevel+bounces-3252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD71A7F1B2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3ED1C2165E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EAC225D4;
	Mon, 20 Nov 2023 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE85183;
	Mon, 20 Nov 2023 09:41:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SYvXP2hwMz9yN0H;
	Tue, 21 Nov 2023 01:25:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXBXXxmVtlIZIKAQ--.7181S7;
	Mon, 20 Nov 2023 18:41:22 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 25/25] security: Enforce ordering of 'ima' and 'evm' LSMs
Date: Mon, 20 Nov 2023 18:33:18 +0100
Message-Id: <20231120173318.1132868-26-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXBXXxmVtlIZIKAQ--.7181S7
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1xtry5KF18uFW7GrW8Xrb_yoW8Aw4xpa
	naqFW3Kr48JF1Igwn3Ja17GF1a9rWkCF13JrnxJw1DZa9Fqr1vyr43JrySvFyDXry8Aa4S
	qr429w1rKws0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F
	4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07jx
	WrAUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj5KqdgABs-
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

The ordering of LSM_ORDER_LAST LSMs depends on how they are placed in the
.lsm_info.init section of the kernel image.

Without making any assumption on the LSM ordering based on how they are
compiled, enforce that ordering at LSM infrastructure level.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/security.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/security/security.c b/security/security.c
index 351a124b771c..b98db79ca500 100644
--- a/security/security.c
+++ b/security/security.c
@@ -263,6 +263,18 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
+/* Find an LSM with a given name. */
+static struct lsm_info __init *find_lsm(const char *name)
+{
+	struct lsm_info *lsm;
+
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++)
+		if (!strcmp(lsm->name, name))
+			return lsm;
+
+	return NULL;
+}
+
 /*
  * Current index to use while initializing the lsm id list.
  */
@@ -333,10 +345,23 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* LSM_ORDER_LAST is always last. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		/* Do it later, to enforce the expected ordering. */
+		if (!strcmp(lsm->name, "ima") || !strcmp(lsm->name, "evm"))
+			continue;
+
 		if (lsm->order == LSM_ORDER_LAST)
 			append_ordered_lsm(lsm, "   last");
 	}
 
+	/* Ensure that the 'ima' and 'evm' LSMs are last and in this order. */
+	lsm = find_lsm("ima");
+	if (lsm)
+		append_ordered_lsm(lsm, "   last");
+
+	lsm = find_lsm("evm");
+	if (lsm)
+		append_ordered_lsm(lsm, "   last");
+
 	/* Disable all LSMs not in the ordered list. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if (exists_ordered_lsm(lsm))
-- 
2.34.1


