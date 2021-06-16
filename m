Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781C83A9BDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhFPNYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 09:24:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3250 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbhFPNYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:24:50 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G4lwq6C9Kz6K6NG;
        Wed, 16 Jun 2021 21:12:59 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 15:22:40 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <zohar@linux.ibm.com>,
        <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <casey@schaufler-ca.com>, <stefanb@linux.ibm.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] fs: Return raw xattr for security.* if there is size disagreement with LSMs
Date:   Wed, 16 Jun 2021 15:22:27 +0200
Message-ID: <20210616132227.999256-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ee75bde9a17f418984186caa70abd33b@huawei.com>
References: <ee75bde9a17f418984186caa70abd33b@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vfs_getxattr() differs from vfs_setxattr() in the way it obtains the xattr
value. The former gives precedence to the LSMs, and if the LSMs don't
provide a value, obtains it from the filesystem handler. The latter does
the opposite, first invokes the filesystem handler, and if the filesystem
does not support xattrs, passes the xattr value to the LSMs.

The problem is that not necessarily the user gets the same xattr value that
he set. For example, if he sets security.selinux with a value not
terminated with '\0', he gets a value terminated with '\0' because SELinux
adds it during the translation from xattr to internal representation
(vfs_setxattr()) and from internal representation to xattr
(vfs_getxattr()).

Normally, this does not have an impact unless the integrity of xattrs is
verified with EVM. The kernel and the user see different values due to the
different functions used to obtain them:

kernel (EVM): uses vfs_getxattr_alloc() which obtains the xattr value from
              the filesystem handler (raw value);

user (ima-evm-utils): uses vfs_getxattr() which obtains the xattr value
                      from the LSMs (normalized value).

Given that the difference between the raw value and the normalized value
should be just the additional '\0' not the rest of the content, this patch
modifies vfs_getxattr() to compare the size of the xattr value obtained
from the LSMs to the size of the raw xattr value. If there is a mismatch
and the filesystem handler does not return an error, vfs_getxattr() returns
the raw value.

This patch should have a minimal impact on existing systems, because if the
SELinux label is written with the appropriate tools such as setfiles or
restorecon, there will not be a mismatch (because the raw value also has
'\0').

In the case where the SELinux label is written directly with setfattr and
without '\0', this patch helps to align EVM and ima-evm-utils in terms of
result provided (due to the fact that they both verify the integrity of
xattrs from raw values).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Tested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/xattr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5c8c5175b385..412ec875aa07 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -420,12 +420,27 @@ vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
 		int ret = xattr_getsecurity(mnt_userns, inode, suffix, value,
 					    size);
+		int ret_raw;
+
 		/*
 		 * Only overwrite the return value if a security module
 		 * is actually active.
 		 */
 		if (ret == -EOPNOTSUPP)
 			goto nolsm;
+
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Read raw xattr if the size from the filesystem handler
+		 * differs from that returned by xattr_getsecurity() and is
+		 * equal or greater than zero.
+		 */
+		ret_raw = __vfs_getxattr(dentry, inode, name, NULL, 0);
+		if (ret_raw >= 0 && ret_raw != ret)
+			goto nolsm;
+
 		return ret;
 	}
 nolsm:
-- 
2.25.1

