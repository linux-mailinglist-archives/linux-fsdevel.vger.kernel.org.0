Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806E02AEDA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 10:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgKKJ0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 04:26:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2092 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKKJ03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:26:29 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CWK7z0xjbz67KnT;
        Wed, 11 Nov 2020 17:25:03 +0800 (CST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.161)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 11 Nov 2020 10:26:26 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 11/11] ima: Don't remove security.ima if file must not be appraised
Date:   Wed, 11 Nov 2020 10:23:02 +0100
Message-ID: <20201111092302.1589-12-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.27.GIT
In-Reply-To: <20201111092302.1589-1-roberto.sassu@huawei.com>
References: <20201111092302.1589-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.161]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
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
index 00b038941a10..f03cb4b7270d 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -529,8 +529,6 @@ void ima_inode_post_setattr(struct dentry *dentry)
 		return;
 
 	action = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR);
-	if (!action)
-		__vfs_removexattr(dentry, XATTR_NAME_IMA);
 	iint = integrity_iint_find(inode);
 	if (iint) {
 		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
-- 
2.27.GIT

