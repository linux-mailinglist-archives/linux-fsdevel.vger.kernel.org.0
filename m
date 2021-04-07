Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679A6356A98
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 12:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351702AbhDGKzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 06:55:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2796 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhDGKzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:55:46 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFh2W6lr8z686lh;
        Wed,  7 Apr 2021 18:48:35 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 12:55:35 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v5 12/12] ima: Don't remove security.ima if file must not be appraised
Date:   Wed, 7 Apr 2021 12:52:52 +0200
Message-ID: <20210407105252.30721-13-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210407105252.30721-1-roberto.sassu@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Files might come from a remote source and might have xattrs, including
security.ima. It should not be IMA task to decide whether security.ima
should be kept or not. This patch removes the removexattr() system
call in ima_inode_post_setattr().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 538ccbf972c8..45e244fc2ef2 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -532,8 +532,6 @@ void ima_inode_post_setattr(struct user_namespace *mnt_userns,
 		return;
 
 	action = ima_must_appraise(mnt_userns, inode, MAY_ACCESS, POST_SETATTR);
-	if (!action)
-		__vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_IMA);
 	iint = integrity_iint_find(inode);
 	if (iint) {
 		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
-- 
2.26.2

