Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52AD79186F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 15:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353088AbjIDNgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 09:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjIDNgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:36:47 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B11CFB;
        Mon,  4 Sep 2023 06:36:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RfTr70gnSz9xtn0;
        Mon,  4 Sep 2023 21:24:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDHerrf3PVkUqceAg--.16511S9;
        Mon, 04 Sep 2023 14:36:01 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 07/25] ima: Align ima_post_read_file() definition with LSM infrastructure
Date:   Mon,  4 Sep 2023 15:33:57 +0200
Message-Id: <20230904133415.1799503-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDHerrf3PVkUqceAg--.16511S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4ftr1DJFyxAryDWr1xKrg_yoW8uw1xp3
        Z8Ka4UGr9Ygry8CF97Ja9rA34rW3s2gF4UXFZ3W3sIqF17trn0vrZxCF1j9r1rKrWDCr15
        u3yUKrZ0k3WUtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj5OBcQAAsd
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Change ima_post_read_file() definition, so that it can be registered as
implementation of the post_read_file hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h               | 6 +++---
 security/integrity/ima/ima_main.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 93e3c6cdf1f8..6e4d060ff378 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -31,8 +31,8 @@ extern int ima_post_load_data(char *buf, loff_t size,
 			      enum kernel_load_data_id id, char *description);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
 			 bool contents);
-extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
-			      enum kernel_read_file_id id);
+int ima_post_read_file(struct file *file, char *buf, loff_t size,
+		       enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct mnt_idmap *idmap,
 				const struct path *dir, struct dentry *dentry,
 				umode_t mode, unsigned int dev);
@@ -112,7 +112,7 @@ static inline int ima_read_file(struct file *file, enum kernel_read_file_id id,
 	return 0;
 }
 
-static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
+static inline int ima_post_read_file(struct file *file, char *buf, loff_t size,
 				     enum kernel_read_file_id id)
 {
 	return 0;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e9e2a3ad25a1..f8581032e62c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -801,7 +801,7 @@ const int read_idmap[READING_MAX_ID] = {
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_post_read_file(struct file *file, void *buf, loff_t size,
+int ima_post_read_file(struct file *file, char *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
-- 
2.34.1

