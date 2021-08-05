Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9374E3E0E1D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 08:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhHEGQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 02:16:44 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:21210 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbhHEGQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:16:20 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210805061605epoutp042ffd70494ac45cf16e60275fc6994c2b~YVH4VoAvL0378903789epoutp04M
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Aug 2021 06:16:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210805061605epoutp042ffd70494ac45cf16e60275fc6994c2b~YVH4VoAvL0378903789epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628144165;
        bh=JnFbS1a0O8jMUbuOm0uXiX267ybMjtRGH49AX1wEeEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHWKBzm78eUQOT00BNX+5xEOxQb9aCgTDO0TQ82ZuB9TzCtvEcG3Zdd+C4reE9R4g
         w9SNWhP7Js44z3JTQl9wfdnmuD1Fw1r1DzSnjyWmJRpzLjmw3y3AMPjAjwmu7FIflp
         AQe0cqLA/6Icfj6m5NV3xot6QDnXhl7HQAC9sfL4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210805061605epcas1p3d0084c782d00e7ab4b7d355162018e44~YVH3xG0xC0764407644epcas1p3S;
        Thu,  5 Aug 2021 06:16:05 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GgJJg67VYz4x9QN; Thu,  5 Aug
        2021 06:16:03 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.B5.09468.3228B016; Thu,  5 Aug 2021 15:16:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210805061603epcas1p37b156b4f755bf66e0d9c39d076191a47~YVH2BBR840543205432epcas1p3u;
        Thu,  5 Aug 2021 06:16:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210805061603epsmtrp29ab1ce88864c7df4f971b6f47a5c8f9c~YVH1-5j5I0737507375epsmtrp2F;
        Thu,  5 Aug 2021 06:16:03 +0000 (GMT)
X-AuditID: b6c32a37-0b1ff700000024fc-de-610b822333aa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.EA.08289.3228B016; Thu,  5 Aug 2021 15:16:03 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210805061602epsmtip1809c445e1557faf88f8883f38b1f12c9~YVH1oig-X3007130071epsmtip1i;
        Thu,  5 Aug 2021 06:16:02 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        sandeen@sandeen.net, willy@infradead.org, hch@infradead.org,
        senozhatsky@chromium.org, christian@brauner.io,
        viro@zeniv.linux.org.uk, ronniesahlberg@gmail.com, hch@lst.de,
        dan.carpenter@oracle.com, metze@samba.org, smfrench@gmail.com,
        hyc.lee@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v7 11/13] ksmbd: add file operations
Date:   Thu,  5 Aug 2021 15:05:44 +0900
Message-Id: <20210805060546.3268-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805060546.3268-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmga5yE3eiwbVmXYvjr/+yWzS+U7Z4
        /W86i8XpCYuYLFauPspkce3+e3aLF/93MVv8/P+d0WLP3pMsFpd3zWGzuLjsJ4vFj+n1Fr19
        n1gtWq9oWezeuIjN4s2Lw2wWtybOZ7M4//c4q8XvH3PYHIQ9/s79yOwxu+Eii8fOWXfZPTav
        0PLYveAzk8fumw1sHq07/rJ7fHx6i8Vj7q4+Ro++LasYPbYsfsjk8XmTnMemJ2+ZAnijcmwy
        UhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgN5UUihLzCkF
        CgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbkZNy4
        vpmpoLGTtWLl1QnsDYy3O1i6GDk4JARMJLYvj+hi5OIQEtjBKPH273Y2COcTo8SWkz+Yuxg5
        gZzPjBIbe7lBbJCGdS0zWCCKdjFKzP1yiRGuY0fDZmaQsWwC2hJ/toiCNIgIxErc2PGaGaSG
        WWA2s8TzvadYQBLCQJM6Nu5nArFZBFQl9i1fD2bzCthIrHvxhA1im7zE6g0HwK7gBIq/Wr2Z
        FWSQhMANDon3M44yQfzgIrH9Ih9EvbDEq+Nb2CFsKYnP7/ZCzSmXOHHyFxOEXSOxYd4+dohW
        Y4meFyUgJrOApsT6XfoQFYoSO3/PZQSxmQX4JN597WGFqOaV6GgTgihRlei7dBhqoLREV/sH
        qIEeEqsmJ0NCrZ9Rovs5zwRGuVkI8xcwMq5iFEstKM5NTy02LDBGjq5NjOBErGW+g3Ha2w96
        hxiZOBgPMUpwMCuJ8CYv5koU4k1JrKxKLcqPLyrNSS0+xGgKDLiJzFKiyfnAXJBXEm9oamRs
        bGxhYmZuZmqsJM77LfZrgpBAemJJanZqakFqEUwfEwenVANT7Ydq86S4hZ76zUU6K439D3Im
        +zk/zTSYacvk/7tgLQPH0WctnR9MJKx7dwmueJDdmnNfJqvkYKCT3MX5F2a6soeWXg4Lumq2
        Ldlq2r6u0FBuXtbnnRp7eyxLT4tsXMHxWCS6oTRiouL88CmNy5cYv19S/PaL3InMmUe9C/5W
        Myi2rDf8KGqTOv+Br+GvpcusDsy/9NbEdO2i/5q+N9Y2mm+TszTbMIFHc1ZlkrIxgzLrz0e2
        Af/4vlfZTHpUc6yU/+ylZ9MUGqs4Dji7BVnKNc9knJBjmjrBMSTzwwOGmrg1Wz6zRM9NKGF1
        rMpY0pDjW7aLR9RQ91Wt8LLrx3+o3qxWMYvwe1N5XN/BTomlOCPRUIu5qDgRACdgm9BNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnK5yE3eiwYsGDovjr/+yWzS+U7Z4
        /W86i8XpCYuYLFauPspkce3+e3aLF/93MVv8/P+d0WLP3pMsFpd3zWGzuLjsJ4vFj+n1Fr19
        n1gtWq9oWezeuIjN4s2Lw2wWtybOZ7M4//c4q8XvH3PYHIQ9/s79yOwxu+Eii8fOWXfZPTav
        0PLYveAzk8fumw1sHq07/rJ7fHx6i8Vj7q4+Ro++LasYPbYsfsjk8XmTnMemJ2+ZAnijuGxS
        UnMyy1KL9O0SuDJuXN/MVNDYyVqx8uoE9gbG2x0sXYycHBICJhLrWmYA2VwcQgI7GCXutT6D
        SkhLHDtxhrmLkQPIFpY4fLgYouYDo8Sf99tZQOJsAtoSf7aIgpSLCMRL3Gy4DTaHWWA9s8TZ
        101gc4SBFnRs3M8EYrMIqErsW74ezOYVsJFY9+IJG8QueYnVGw4wg9icQPFXqzezgthCAtYS
        799eY57AyLeAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw5Ghp7WDcs+qD3iFG
        Jg7GQ4wSHMxKIrzJi7kShXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBa
        BJNl4uCUamCyutGh8+AIX5jkIfPtFzawdHzWbBRk+XwpZ4HH6Xvv+eYsFkgoKXzp8CC1T+vF
        5EUKN6dNitGoPLbg76rDTMse7nz8xJTT1KMmKmr/q6BTycKFdQtnGhyz9vhqlBEdWCOsEqAy
        WyNzWfLM+ReL/548sD3ccJHF+nDN9atO1zx8YikRtDdSzfPrHOVE9873bjcYl4ltvDCp6pzP
        67ZFFgG8pyrTmvxSf815qPrc++aLJ4byn/Y8ZrtnpN/I/fViz/egHS9Lmm0ZLufOXbrr74RN
        pyRCOkXkXa0+xaZIGiXnWE9dXZMiqP9o2Zut2mGFvrKxCsvyHuZZVMxt1sqd/ND/68VAr62L
        332KM971I3WbEktxRqKhFnNRcSIAJ5WMUgsDAAA=
X-CMS-MailID: 20210805061603epcas1p37b156b4f755bf66e0d9c39d076191a47
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210805061603epcas1p37b156b4f755bf66e0d9c39d076191a47
References: <20210805060546.3268-1-namjae.jeon@samsung.com>
        <CGME20210805061603epcas1p37b156b4f755bf66e0d9c39d076191a47@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds file operations.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/vfs.c       | 1886 ++++++++++++++++++++++++++++++++++++++++++
 fs/ksmbd/vfs.h       |  197 +++++
 fs/ksmbd/vfs_cache.c |  725 ++++++++++++++++
 fs/ksmbd/vfs_cache.h |  178 ++++
 fs/ksmbd/xattr.h     |  122 +++
 5 files changed, 3108 insertions(+)
 create mode 100644 fs/ksmbd/vfs.c
 create mode 100644 fs/ksmbd/vfs.h
 create mode 100644 fs/ksmbd/vfs_cache.c
 create mode 100644 fs/ksmbd/vfs_cache.h
 create mode 100644 fs/ksmbd/xattr.h

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
new file mode 100644
index 000000000000..612c52d7a01b
--- /dev/null
+++ b/fs/ksmbd/vfs.c
@@ -0,0 +1,1886 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/backing-dev.h>
+#include <linux/writeback.h>
+#include <linux/xattr.h>
+#include <linux/falloc.h>
+#include <linux/genhd.h>
+#include <linux/fsnotify.h>
+#include <linux/dcache.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/sched/xacct.h>
+#include <linux/crc32c.h>
+
+#include "glob.h"
+#include "oplock.h"
+#include "connection.h"
+#include "vfs.h"
+#include "vfs_cache.h"
+#include "smbacl.h"
+#include "ndr.h"
+#include "auth.h"
+#include "misc.h"
+
+#include "smb_common.h"
+#include "mgmt/share_config.h"
+#include "mgmt/tree_connect.h"
+#include "mgmt/user_session.h"
+#include "mgmt/user_config.h"
+
+static char *extract_last_component(char *path)
+{
+	char *p = strrchr(path, '/');
+
+	if (p && p[1] != '\0') {
+		*p = '\0';
+		p++;
+	} else {
+		p = NULL;
+		pr_err("Invalid path %s\n", path);
+	}
+	return p;
+}
+
+static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
+				    struct inode *parent_inode,
+				    struct inode *inode)
+{
+	if (!test_share_config_flag(work->tcon->share_conf,
+				    KSMBD_SHARE_FLAG_INHERIT_OWNER))
+		return;
+
+	i_uid_write(inode, i_uid_read(parent_inode));
+}
+
+/**
+ * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
+ *
+ * the parent dentry got by dget_parent or @parent could be
+ * unstable, we try to lock a parent inode and lookup the
+ * child dentry again.
+ *
+ * the reference count of @parent isn't incremented.
+ */
+int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
+{
+	struct dentry *dentry;
+	int ret = 0;
+
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	dentry = lookup_one_len(child->d_name.name, parent,
+				child->d_name.len);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out_err;
+	}
+
+	if (dentry != child) {
+		ret = -ESTALE;
+		dput(dentry);
+		goto out_err;
+	}
+
+	dput(dentry);
+	return 0;
+out_err:
+	inode_unlock(d_inode(parent));
+	return ret;
+}
+
+int ksmbd_vfs_may_delete(struct user_namespace *user_ns,
+			 struct dentry *dentry)
+{
+	struct dentry *parent;
+	int ret;
+
+	parent = dget_parent(dentry);
+	ret = ksmbd_vfs_lock_parent(parent, dentry);
+	if (ret) {
+		dput(parent);
+		return ret;
+	}
+
+	ret = inode_permission(user_ns, d_inode(parent),
+			       MAY_EXEC | MAY_WRITE);
+
+	inode_unlock(d_inode(parent));
+	dput(parent);
+	return ret;
+}
+
+int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
+				   struct dentry *dentry, __le32 *daccess)
+{
+	struct dentry *parent;
+	int ret = 0;
+
+	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
+
+	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_WRITE))
+		*daccess |= cpu_to_le32(WRITE_DAC | WRITE_OWNER | SYNCHRONIZE |
+				FILE_WRITE_DATA | FILE_APPEND_DATA |
+				FILE_WRITE_EA | FILE_WRITE_ATTRIBUTES |
+				FILE_DELETE_CHILD);
+
+	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_READ))
+		*daccess |= FILE_READ_DATA_LE | FILE_READ_EA_LE;
+
+	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_EXEC))
+		*daccess |= FILE_EXECUTE_LE;
+
+	parent = dget_parent(dentry);
+	ret = ksmbd_vfs_lock_parent(parent, dentry);
+	if (ret) {
+		dput(parent);
+		return ret;
+	}
+
+	if (!inode_permission(user_ns, d_inode(parent), MAY_EXEC | MAY_WRITE))
+		*daccess |= FILE_DELETE_LE;
+
+	inode_unlock(d_inode(parent));
+	dput(parent);
+	return ret;
+}
+
+/**
+ * ksmbd_vfs_create() - vfs helper for smb create file
+ * @work:	work
+ * @name:	file name
+ * @mode:	file create mode
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
+{
+	struct path path;
+	struct dentry *dentry;
+	int err;
+
+	dentry = kern_path_create(AT_FDCWD, name, &path, 0);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		if (err != -ENOENT)
+			pr_err("path create failed for %s, err %d\n",
+			       name, err);
+		return err;
+	}
+
+	mode |= S_IFREG;
+	err = vfs_create(mnt_user_ns(path.mnt), d_inode(path.dentry),
+			 dentry, mode, true);
+	if (!err) {
+		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
+					d_inode(dentry));
+	} else {
+		pr_err("File(%s): creation failed (err:%d)\n", name, err);
+	}
+	done_path_create(&path, dentry);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_mkdir() - vfs helper for smb create directory
+ * @work:	work
+ * @name:	directory name
+ * @mode:	directory create mode
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
+{
+	struct path path;
+	struct dentry *dentry;
+	int err;
+
+	dentry = kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		if (err != -EEXIST)
+			ksmbd_debug(VFS, "path create failed for %s, err %d\n",
+				    name, err);
+		return err;
+	}
+
+	mode |= S_IFDIR;
+	err = vfs_mkdir(mnt_user_ns(path.mnt), d_inode(path.dentry),
+			dentry, mode);
+	if (err) {
+		goto out;
+	} else if (d_unhashed(dentry)) {
+		struct dentry *d;
+
+		d = lookup_one_len(dentry->d_name.name, dentry->d_parent,
+				   dentry->d_name.len);
+		if (IS_ERR(d)) {
+			err = PTR_ERR(d);
+			goto out;
+		}
+		if (unlikely(d_is_negative(d))) {
+			dput(d);
+			err = -ENOENT;
+			goto out;
+		}
+
+		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
+		dput(d);
+	}
+out:
+	done_path_create(&path, dentry);
+	if (err)
+		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
+	return err;
+}
+
+static ssize_t ksmbd_vfs_getcasexattr(struct user_namespace *user_ns,
+				      struct dentry *dentry, char *attr_name,
+				      int attr_name_len, char **attr_value)
+{
+	char *name, *xattr_list = NULL;
+	ssize_t value_len = -ENOENT, xattr_list_len;
+
+	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	if (xattr_list_len <= 0)
+		goto out;
+
+	for (name = xattr_list; name - xattr_list < xattr_list_len;
+			name += strlen(name) + 1) {
+		ksmbd_debug(VFS, "%s, len %zd\n", name, strlen(name));
+		if (strncasecmp(attr_name, name, attr_name_len))
+			continue;
+
+		value_len = ksmbd_vfs_getxattr(user_ns,
+					       dentry,
+					       name,
+					       attr_value);
+		if (value_len < 0)
+			pr_err("failed to get xattr in file\n");
+		break;
+	}
+
+out:
+	kvfree(xattr_list);
+	return value_len;
+}
+
+static int ksmbd_vfs_stream_read(struct ksmbd_file *fp, char *buf, loff_t *pos,
+				 size_t count)
+{
+	ssize_t v_len;
+	char *stream_buf = NULL;
+
+	ksmbd_debug(VFS, "read stream data pos : %llu, count : %zd\n",
+		    *pos, count);
+
+	v_len = ksmbd_vfs_getcasexattr(file_mnt_user_ns(fp->filp),
+				       fp->filp->f_path.dentry,
+				       fp->stream.name,
+				       fp->stream.size,
+				       &stream_buf);
+	if ((int)v_len <= 0)
+		return (int)v_len;
+
+	if (v_len <= *pos) {
+		count = -EINVAL;
+		goto free_buf;
+	}
+
+	if (v_len - *pos < count)
+		count = v_len - *pos;
+
+	memcpy(buf, &stream_buf[*pos], count);
+
+free_buf:
+	kvfree(stream_buf);
+	return count;
+}
+
+/**
+ * check_lock_range() - vfs helper for smb byte range file locking
+ * @filp:	the file to apply the lock to
+ * @start:	lock start byte offset
+ * @end:	lock end byte offset
+ * @type:	byte range type read/write
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int check_lock_range(struct file *filp, loff_t start, loff_t end,
+			    unsigned char type)
+{
+	struct file_lock *flock;
+	struct file_lock_context *ctx = file_inode(filp)->i_flctx;
+	int error = 0;
+
+	if (!ctx || list_empty_careful(&ctx->flc_posix))
+		return 0;
+
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(flock, &ctx->flc_posix, fl_list) {
+		/* check conflict locks */
+		if (flock->fl_end >= start && end >= flock->fl_start) {
+			if (flock->fl_type == F_RDLCK) {
+				if (type == WRITE) {
+					pr_err("not allow write by shared lock\n");
+					error = 1;
+					goto out;
+				}
+			} else if (flock->fl_type == F_WRLCK) {
+				/* check owner in lock */
+				if (flock->fl_file != filp) {
+					error = 1;
+					pr_err("not allow rw access by exclusive lock from other opens\n");
+					goto out;
+				}
+			}
+		}
+	}
+out:
+	spin_unlock(&ctx->flc_lock);
+	return error;
+}
+
+/**
+ * ksmbd_vfs_read() - vfs helper for smb file read
+ * @work:	smb work
+ * @fid:	file id of open file
+ * @count:	read byte count
+ * @pos:	file pos
+ *
+ * Return:	number of read bytes on success, otherwise error
+ */
+int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
+		   loff_t *pos)
+{
+	struct file *filp = fp->filp;
+	ssize_t nbytes = 0;
+	char *rbuf = work->aux_payload_buf;
+	struct inode *inode = file_inode(filp);
+
+	if (S_ISDIR(inode->i_mode))
+		return -EISDIR;
+
+	if (unlikely(count == 0))
+		return 0;
+
+	if (work->conn->connection_type) {
+		if (!(fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
+			pr_err("no right to read(%pd)\n",
+			       fp->filp->f_path.dentry);
+			return -EACCES;
+		}
+	}
+
+	if (ksmbd_stream_fd(fp))
+		return ksmbd_vfs_stream_read(fp, rbuf, pos, count);
+
+	if (!work->tcon->posix_extensions) {
+		int ret;
+
+		ret = check_lock_range(filp, *pos, *pos + count - 1, READ);
+		if (ret) {
+			pr_err("unable to read due to lock\n");
+			return -EAGAIN;
+		}
+	}
+
+	nbytes = kernel_read(filp, rbuf, count, pos);
+	if (nbytes < 0) {
+		pr_err("smb read failed for (%s), err = %zd\n",
+		       fp->filename, nbytes);
+		return nbytes;
+	}
+
+	filp->f_pos = *pos;
+	return nbytes;
+}
+
+static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
+				  size_t count)
+{
+	char *stream_buf = NULL, *wbuf;
+	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
+	size_t size, v_len;
+	int err = 0;
+
+	ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
+		    *pos, count);
+
+	size = *pos + count;
+	if (size > XATTR_SIZE_MAX) {
+		size = XATTR_SIZE_MAX;
+		count = (*pos + count) - XATTR_SIZE_MAX;
+	}
+
+	v_len = ksmbd_vfs_getcasexattr(user_ns,
+				       fp->filp->f_path.dentry,
+				       fp->stream.name,
+				       fp->stream.size,
+				       &stream_buf);
+	if ((int)v_len < 0) {
+		pr_err("not found stream in xattr : %zd\n", v_len);
+		err = (int)v_len;
+		goto out;
+	}
+
+	if (v_len < size) {
+		wbuf = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+		if (!wbuf) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		if (v_len > 0)
+			memcpy(wbuf, stream_buf, v_len);
+		kvfree(stream_buf);
+		stream_buf = wbuf;
+	}
+
+	memcpy(&stream_buf[*pos], buf, count);
+
+	err = ksmbd_vfs_setxattr(user_ns,
+				 fp->filp->f_path.dentry,
+				 fp->stream.name,
+				 (void *)stream_buf,
+				 size,
+				 0);
+	if (err < 0)
+		goto out;
+
+	fp->filp->f_pos = *pos;
+	err = 0;
+out:
+	kvfree(stream_buf);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_write() - vfs helper for smb file write
+ * @work:	work
+ * @fid:	file id of open file
+ * @buf:	buf containing data for writing
+ * @count:	read byte count
+ * @pos:	file pos
+ * @sync:	fsync after write
+ * @written:	number of bytes written
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
+		    char *buf, size_t count, loff_t *pos, bool sync,
+		    ssize_t *written)
+{
+	struct ksmbd_session *sess = work->sess;
+	struct file *filp;
+	loff_t	offset = *pos;
+	int err = 0;
+
+	if (sess->conn->connection_type) {
+		if (!(fp->daccess & FILE_WRITE_DATA_LE)) {
+			pr_err("no right to write(%pd)\n",
+			       fp->filp->f_path.dentry);
+			err = -EACCES;
+			goto out;
+		}
+	}
+
+	filp = fp->filp;
+
+	if (ksmbd_stream_fd(fp)) {
+		err = ksmbd_vfs_stream_write(fp, buf, pos, count);
+		if (!err)
+			*written = count;
+		goto out;
+	}
+
+	if (!work->tcon->posix_extensions) {
+		err = check_lock_range(filp, *pos, *pos + count - 1, WRITE);
+		if (err) {
+			pr_err("unable to write due to lock\n");
+			err = -EAGAIN;
+			goto out;
+		}
+	}
+
+	/* Do we need to break any of a levelII oplock? */
+	smb_break_all_levII_oplock(work, fp, 1);
+
+	err = kernel_write(filp, buf, count, pos);
+	if (err < 0) {
+		ksmbd_debug(VFS, "smb write failed, err = %d\n", err);
+		goto out;
+	}
+
+	filp->f_pos = *pos;
+	*written = err;
+	err = 0;
+	if (sync) {
+		err = vfs_fsync_range(filp, offset, offset + *written, 0);
+		if (err < 0)
+			pr_err("fsync failed for filename = %pd, err = %d\n",
+			       fp->filp->f_path.dentry, err);
+	}
+
+out:
+	return err;
+}
+
+/**
+ * ksmbd_vfs_getattr() - vfs helper for smb getattr
+ * @work:	work
+ * @fid:	file id of open file
+ * @attrs:	inode attributes
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_getattr(struct path *path, struct kstat *stat)
+{
+	int err;
+
+	err = vfs_getattr(path, stat, STATX_BTIME, AT_STATX_SYNC_AS_STAT);
+	if (err)
+		pr_err("getattr failed, err %d\n", err);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_fsync() - vfs helper for smb fsync
+ * @work:	work
+ * @fid:	file id of open file
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id)
+{
+	struct ksmbd_file *fp;
+	int err;
+
+	fp = ksmbd_lookup_fd_slow(work, fid, p_id);
+	if (!fp) {
+		pr_err("failed to get filp for fid %llu\n", fid);
+		return -ENOENT;
+	}
+	err = vfs_fsync(fp->filp, 0);
+	if (err < 0)
+		pr_err("smb fsync failed, err = %d\n", err);
+	ksmbd_fd_put(work, fp);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_remove_file() - vfs helper for smb rmdir or unlink
+ * @name:	absolute directory or file name
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
+{
+	struct path path;
+	struct dentry *parent;
+	int err;
+	int flags = 0;
+
+	if (ksmbd_override_fsids(work))
+		return -ENOMEM;
+
+	if (test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS))
+		flags = LOOKUP_FOLLOW;
+
+	err = kern_path(name, flags, &path);
+	if (err) {
+		ksmbd_debug(VFS, "can't get %s, err %d\n", name, err);
+		ksmbd_revert_fsids(work);
+		return err;
+	}
+
+	parent = dget_parent(path.dentry);
+	err = ksmbd_vfs_lock_parent(parent, path.dentry);
+	if (err) {
+		dput(parent);
+		path_put(&path);
+		ksmbd_revert_fsids(work);
+		return err;
+	}
+
+	if (!d_inode(path.dentry)->i_nlink) {
+		err = -ENOENT;
+		goto out_err;
+	}
+
+	if (S_ISDIR(d_inode(path.dentry)->i_mode)) {
+		err = vfs_rmdir(mnt_user_ns(path.mnt), d_inode(parent),
+				path.dentry);
+		if (err && err != -ENOTEMPTY)
+			ksmbd_debug(VFS, "%s: rmdir failed, err %d\n", name,
+				    err);
+	} else {
+		err = vfs_unlink(mnt_user_ns(path.mnt), d_inode(parent),
+				 path.dentry, NULL);
+		if (err)
+			ksmbd_debug(VFS, "%s: unlink failed, err %d\n", name,
+				    err);
+	}
+
+out_err:
+	inode_unlock(d_inode(parent));
+	dput(parent);
+	path_put(&path);
+	ksmbd_revert_fsids(work);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_link() - vfs helper for creating smb hardlink
+ * @oldname:	source file name
+ * @newname:	hardlink name
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
+		   const char *newname)
+{
+	struct path oldpath, newpath;
+	struct dentry *dentry;
+	int err;
+	int flags = 0;
+
+	if (ksmbd_override_fsids(work))
+		return -ENOMEM;
+
+	if (test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS))
+		flags = LOOKUP_FOLLOW;
+
+	err = kern_path(oldname, flags, &oldpath);
+	if (err) {
+		pr_err("cannot get linux path for %s, err = %d\n",
+		       oldname, err);
+		goto out1;
+	}
+
+	dentry = kern_path_create(AT_FDCWD, newname, &newpath,
+				  flags | LOOKUP_REVAL);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		pr_err("path create err for %s, err %d\n", newname, err);
+		goto out2;
+	}
+
+	err = -EXDEV;
+	if (oldpath.mnt != newpath.mnt) {
+		pr_err("vfs_link failed err %d\n", err);
+		goto out3;
+	}
+
+	err = vfs_link(oldpath.dentry, mnt_user_ns(newpath.mnt),
+		       d_inode(newpath.dentry),
+		       dentry, NULL);
+	if (err)
+		ksmbd_debug(VFS, "vfs_link failed err %d\n", err);
+
+out3:
+	done_path_create(&newpath, dentry);
+out2:
+	path_put(&oldpath);
+out1:
+	ksmbd_revert_fsids(work);
+	return err;
+}
+
+static int ksmbd_validate_entry_in_use(struct dentry *src_dent)
+{
+	struct dentry *dst_dent;
+
+	spin_lock(&src_dent->d_lock);
+	list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
+		struct ksmbd_file *child_fp;
+
+		if (d_really_is_negative(dst_dent))
+			continue;
+
+		child_fp = ksmbd_lookup_fd_inode(d_inode(dst_dent));
+		if (child_fp) {
+			spin_unlock(&src_dent->d_lock);
+			ksmbd_debug(VFS, "Forbid rename, sub file/dir is in use\n");
+			return -EACCES;
+		}
+	}
+	spin_unlock(&src_dent->d_lock);
+
+	return 0;
+}
+
+static int __ksmbd_vfs_rename(struct ksmbd_work *work,
+			      struct user_namespace *src_user_ns,
+			      struct dentry *src_dent_parent,
+			      struct dentry *src_dent,
+			      struct user_namespace *dst_user_ns,
+			      struct dentry *dst_dent_parent,
+			      struct dentry *trap_dent,
+			      char *dst_name)
+{
+	struct dentry *dst_dent;
+	int err;
+
+	if (!work->tcon->posix_extensions) {
+		err = ksmbd_validate_entry_in_use(src_dent);
+		if (err)
+			return err;
+	}
+
+	if (d_really_is_negative(src_dent_parent))
+		return -ENOENT;
+	if (d_really_is_negative(dst_dent_parent))
+		return -ENOENT;
+	if (d_really_is_negative(src_dent))
+		return -ENOENT;
+	if (src_dent == trap_dent)
+		return -EINVAL;
+
+	if (ksmbd_override_fsids(work))
+		return -ENOMEM;
+
+	dst_dent = lookup_one_len(dst_name, dst_dent_parent, strlen(dst_name));
+	err = PTR_ERR(dst_dent);
+	if (IS_ERR(dst_dent)) {
+		pr_err("lookup failed %s [%d]\n", dst_name, err);
+		goto out;
+	}
+
+	err = -ENOTEMPTY;
+	if (dst_dent != trap_dent && !d_really_is_positive(dst_dent)) {
+		struct renamedata rd = {
+			.old_mnt_userns	= src_user_ns,
+			.old_dir	= d_inode(src_dent_parent),
+			.old_dentry	= src_dent,
+			.new_mnt_userns	= dst_user_ns,
+			.new_dir	= d_inode(dst_dent_parent),
+			.new_dentry	= dst_dent,
+		};
+		err = vfs_rename(&rd);
+	}
+	if (err)
+		pr_err("vfs_rename failed err %d\n", err);
+	if (dst_dent)
+		dput(dst_dent);
+out:
+	ksmbd_revert_fsids(work);
+	return err;
+}
+
+int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
+			char *newname)
+{
+	struct path dst_path;
+	struct dentry *src_dent_parent, *dst_dent_parent;
+	struct dentry *src_dent, *trap_dent, *src_child;
+	char *dst_name;
+	int err;
+	int flags;
+
+	dst_name = extract_last_component(newname);
+	if (!dst_name)
+		return -EINVAL;
+
+	src_dent_parent = dget_parent(fp->filp->f_path.dentry);
+	src_dent = fp->filp->f_path.dentry;
+
+	flags = LOOKUP_DIRECTORY;
+	if (test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS))
+		flags |= LOOKUP_FOLLOW;
+
+	err = kern_path(newname, flags, &dst_path);
+	if (err) {
+		ksmbd_debug(VFS, "Cannot get path for %s [%d]\n", newname, err);
+		goto out;
+	}
+	dst_dent_parent = dst_path.dentry;
+
+	trap_dent = lock_rename(src_dent_parent, dst_dent_parent);
+	dget(src_dent);
+	dget(dst_dent_parent);
+	src_child = lookup_one_len(src_dent->d_name.name, src_dent_parent,
+				   src_dent->d_name.len);
+	if (IS_ERR(src_child)) {
+		err = PTR_ERR(src_child);
+		goto out_lock;
+	}
+
+	if (src_child != src_dent) {
+		err = -ESTALE;
+		dput(src_child);
+		goto out_lock;
+	}
+	dput(src_child);
+
+	err = __ksmbd_vfs_rename(work,
+				 file_mnt_user_ns(fp->filp),
+				 src_dent_parent,
+				 src_dent,
+				 mnt_user_ns(dst_path.mnt),
+				 dst_dent_parent,
+				 trap_dent,
+				 dst_name);
+out_lock:
+	dput(src_dent);
+	dput(dst_dent_parent);
+	unlock_rename(src_dent_parent, dst_dent_parent);
+	path_put(&dst_path);
+out:
+	dput(src_dent_parent);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_truncate() - vfs helper for smb file truncate
+ * @work:	work
+ * @name:	old filename
+ * @fid:	file id of old file
+ * @size:	truncate to given size
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_truncate(struct ksmbd_work *work, const char *name,
+		       struct ksmbd_file *fp, loff_t size)
+{
+	struct path path;
+	int err = 0;
+
+	if (name) {
+		err = kern_path(name, 0, &path);
+		if (err) {
+			pr_err("cannot get linux path for %s, err %d\n",
+			       name, err);
+			return err;
+		}
+		err = vfs_truncate(&path, size);
+		if (err)
+			pr_err("truncate failed for %s err %d\n",
+			       name, err);
+		path_put(&path);
+	} else {
+		struct file *filp;
+
+		filp = fp->filp;
+
+		/* Do we need to break any of a levelII oplock? */
+		smb_break_all_levII_oplock(work, fp, 1);
+
+		if (!work->tcon->posix_extensions) {
+			struct inode *inode = file_inode(filp);
+
+			if (size < inode->i_size) {
+				err = check_lock_range(filp, size,
+						       inode->i_size - 1, WRITE);
+			} else {
+				err = check_lock_range(filp, inode->i_size,
+						       size - 1, WRITE);
+			}
+
+			if (err) {
+				pr_err("failed due to lock\n");
+				return -EAGAIN;
+			}
+		}
+
+		err = vfs_truncate(&filp->f_path, size);
+		if (err)
+			pr_err("truncate failed for filename : %s err %d\n",
+			       fp->filename, err);
+	}
+
+	return err;
+}
+
+/**
+ * ksmbd_vfs_listxattr() - vfs helper for smb list extended attributes
+ * @dentry:	dentry of file for listing xattrs
+ * @list:	destination buffer
+ * @size:	destination buffer length
+ *
+ * Return:	xattr list length on success, otherwise error
+ */
+ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
+{
+	ssize_t size;
+	char *vlist = NULL;
+
+	size = vfs_listxattr(dentry, NULL, 0);
+	if (size <= 0)
+		return size;
+
+	vlist = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	if (!vlist)
+		return -ENOMEM;
+
+	*list = vlist;
+	size = vfs_listxattr(dentry, vlist, size);
+	if (size < 0) {
+		ksmbd_debug(VFS, "listxattr failed\n");
+		kvfree(vlist);
+		*list = NULL;
+	}
+
+	return size;
+}
+
+static ssize_t ksmbd_vfs_xattr_len(struct user_namespace *user_ns,
+				   struct dentry *dentry, char *xattr_name)
+{
+	return vfs_getxattr(user_ns, dentry, xattr_name, NULL, 0);
+}
+
+/**
+ * ksmbd_vfs_getxattr() - vfs helper for smb get extended attributes value
+ * @user_ns:	user namespace
+ * @dentry:	dentry of file for getting xattrs
+ * @xattr_name:	name of xattr name to query
+ * @xattr_buf:	destination buffer xattr value
+ *
+ * Return:	read xattr value length on success, otherwise error
+ */
+ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
+			   struct dentry *dentry,
+			   char *xattr_name, char **xattr_buf)
+{
+	ssize_t xattr_len;
+	char *buf;
+
+	*xattr_buf = NULL;
+	xattr_len = ksmbd_vfs_xattr_len(user_ns, dentry, xattr_name);
+	if (xattr_len < 0)
+		return xattr_len;
+
+	buf = kmalloc(xattr_len + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	xattr_len = vfs_getxattr(user_ns, dentry, xattr_name,
+				 (void *)buf, xattr_len);
+	if (xattr_len > 0)
+		*xattr_buf = buf;
+	else
+		kfree(buf);
+	return xattr_len;
+}
+
+/**
+ * ksmbd_vfs_setxattr() - vfs helper for smb set extended attributes value
+ * @user_ns:	user namespace
+ * @dentry:	dentry to set XATTR at
+ * @name:	xattr name for setxattr
+ * @value:	xattr value to set
+ * @size:	size of xattr value
+ * @flags:	destination buffer length
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
+		       struct dentry *dentry, const char *attr_name,
+		       const void *attr_value, size_t attr_size, int flags)
+{
+	int err;
+
+	err = vfs_setxattr(user_ns,
+			   dentry,
+			   attr_name,
+			   attr_value,
+			   attr_size,
+			   flags);
+	if (err)
+		ksmbd_debug(VFS, "setxattr failed, err %d\n", err);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_set_fadvise() - convert smb IO caching options to linux options
+ * @filp:	file pointer for IO
+ * @options:	smb IO options
+ */
+void ksmbd_vfs_set_fadvise(struct file *filp, __le32 option)
+{
+	struct address_space *mapping;
+
+	mapping = filp->f_mapping;
+
+	if (!option || !mapping)
+		return;
+
+	if (option & FILE_WRITE_THROUGH_LE) {
+		filp->f_flags |= O_SYNC;
+	} else if (option & FILE_SEQUENTIAL_ONLY_LE) {
+		filp->f_ra.ra_pages = inode_to_bdi(mapping->host)->ra_pages * 2;
+		spin_lock(&filp->f_lock);
+		filp->f_mode &= ~FMODE_RANDOM;
+		spin_unlock(&filp->f_lock);
+	} else if (option & FILE_RANDOM_ACCESS_LE) {
+		spin_lock(&filp->f_lock);
+		filp->f_mode |= FMODE_RANDOM;
+		spin_unlock(&filp->f_lock);
+	}
+}
+
+int ksmbd_vfs_zero_data(struct ksmbd_work *work, struct ksmbd_file *fp,
+			loff_t off, loff_t len)
+{
+	smb_break_all_levII_oplock(work, fp, 1);
+	if (fp->f_ci->m_fattr & ATTR_SPARSE_FILE_LE)
+		return vfs_fallocate(fp->filp,
+				     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				     off, len);
+
+	return vfs_fallocate(fp->filp, FALLOC_FL_ZERO_RANGE, off, len);
+}
+
+int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
+			 struct file_allocated_range_buffer *ranges,
+			 int in_count, int *out_count)
+{
+	struct file *f = fp->filp;
+	struct inode *inode = file_inode(fp->filp);
+	loff_t maxbytes = (u64)inode->i_sb->s_maxbytes, end;
+	loff_t extent_start, extent_end;
+	int ret = 0;
+
+	if (start > maxbytes)
+		return -EFBIG;
+
+	if (!in_count)
+		return 0;
+
+	/*
+	 * Shrink request scope to what the fs can actually handle.
+	 */
+	if (length > maxbytes || (maxbytes - length) < start)
+		length = maxbytes - start;
+
+	if (start + length > inode->i_size)
+		length = inode->i_size - start;
+
+	*out_count = 0;
+	end = start + length;
+	while (start < end && *out_count < in_count) {
+		extent_start = f->f_op->llseek(f, start, SEEK_DATA);
+		if (extent_start < 0) {
+			if (extent_start != -ENXIO)
+				ret = (int)extent_start;
+			break;
+		}
+
+		if (extent_start >= end)
+			break;
+
+		extent_end = f->f_op->llseek(f, extent_start, SEEK_HOLE);
+		if (extent_end < 0) {
+			if (extent_end != -ENXIO)
+				ret = (int)extent_end;
+			break;
+		} else if (extent_start >= extent_end) {
+			break;
+		}
+
+		ranges[*out_count].file_offset = cpu_to_le64(extent_start);
+		ranges[(*out_count)++].length =
+			cpu_to_le64(min(extent_end, end) - extent_start);
+
+		start = extent_end;
+	}
+
+	return ret;
+}
+
+int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
+			   struct dentry *dentry, char *attr_name)
+{
+	return vfs_removexattr(user_ns, dentry, attr_name);
+}
+
+int ksmbd_vfs_unlink(struct user_namespace *user_ns,
+		     struct dentry *dir, struct dentry *dentry)
+{
+	int err = 0;
+
+	err = ksmbd_vfs_lock_parent(dir, dentry);
+	if (err)
+		return err;
+	dget(dentry);
+
+	if (S_ISDIR(d_inode(dentry)->i_mode))
+		err = vfs_rmdir(user_ns, d_inode(dir), dentry);
+	else
+		err = vfs_unlink(user_ns, d_inode(dir), dentry, NULL);
+
+	dput(dentry);
+	inode_unlock(d_inode(dir));
+	if (err)
+		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
+
+	return err;
+}
+
+static int __dir_empty(struct dir_context *ctx, const char *name, int namlen,
+		       loff_t offset, u64 ino, unsigned int d_type)
+{
+	struct ksmbd_readdir_data *buf;
+
+	buf = container_of(ctx, struct ksmbd_readdir_data, ctx);
+	buf->dirent_count++;
+
+	if (buf->dirent_count > 2)
+		return -ENOTEMPTY;
+	return 0;
+}
+
+/**
+ * ksmbd_vfs_empty_dir() - check for empty directory
+ * @fp:	ksmbd file pointer
+ *
+ * Return:	true if directory empty, otherwise false
+ */
+int ksmbd_vfs_empty_dir(struct ksmbd_file *fp)
+{
+	int err;
+	struct ksmbd_readdir_data readdir_data;
+
+	memset(&readdir_data, 0, sizeof(struct ksmbd_readdir_data));
+
+	set_ctx_actor(&readdir_data.ctx, __dir_empty);
+	readdir_data.dirent_count = 0;
+
+	err = iterate_dir(fp->filp, &readdir_data.ctx);
+	if (readdir_data.dirent_count > 2)
+		err = -ENOTEMPTY;
+	else
+		err = 0;
+	return err;
+}
+
+static int __caseless_lookup(struct dir_context *ctx, const char *name,
+			     int namlen, loff_t offset, u64 ino,
+			     unsigned int d_type)
+{
+	struct ksmbd_readdir_data *buf;
+
+	buf = container_of(ctx, struct ksmbd_readdir_data, ctx);
+
+	if (buf->used != namlen)
+		return 0;
+	if (!strncasecmp((char *)buf->private, name, namlen)) {
+		memcpy((char *)buf->private, name, namlen);
+		buf->dirent_count = 1;
+		return -EEXIST;
+	}
+	return 0;
+}
+
+/**
+ * ksmbd_vfs_lookup_in_dir() - lookup a file in a directory
+ * @dir:	path info
+ * @name:	filename to lookup
+ * @namelen:	filename length
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int ksmbd_vfs_lookup_in_dir(struct path *dir, char *name, size_t namelen)
+{
+	int ret;
+	struct file *dfilp;
+	int flags = O_RDONLY | O_LARGEFILE;
+	struct ksmbd_readdir_data readdir_data = {
+		.ctx.actor	= __caseless_lookup,
+		.private	= name,
+		.used		= namelen,
+		.dirent_count	= 0,
+	};
+
+	dfilp = dentry_open(dir, flags, current_cred());
+	if (IS_ERR(dfilp))
+		return PTR_ERR(dfilp);
+
+	ret = iterate_dir(dfilp, &readdir_data.ctx);
+	if (readdir_data.dirent_count > 0)
+		ret = 0;
+	fput(dfilp);
+	return ret;
+}
+
+/**
+ * ksmbd_vfs_kern_path() - lookup a file and get path info
+ * @name:	name of file for lookup
+ * @flags:	lookup flags
+ * @path:	if lookup succeed, return path info
+ * @caseless:	caseless filename lookup
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_kern_path(char *name, unsigned int flags, struct path *path,
+			bool caseless)
+{
+	int err;
+
+	if (name[0] != '/')
+		return -EINVAL;
+
+	err = kern_path(name, flags, path);
+	if (!err)
+		return 0;
+
+	if (caseless) {
+		char *filepath;
+		struct path parent;
+		size_t path_len, remain_len;
+
+		filepath = kstrdup(name, GFP_KERNEL);
+		if (!filepath)
+			return -ENOMEM;
+
+		path_len = strlen(filepath);
+		remain_len = path_len - 1;
+
+		err = kern_path("/", flags, &parent);
+		if (err)
+			goto out;
+
+		while (d_can_lookup(parent.dentry)) {
+			char *filename = filepath + path_len - remain_len;
+			char *next = strchrnul(filename, '/');
+			size_t filename_len = next - filename;
+			bool is_last = !next[0];
+
+			if (filename_len == 0)
+				break;
+
+			err = ksmbd_vfs_lookup_in_dir(&parent, filename,
+						      filename_len);
+			if (err) {
+				path_put(&parent);
+				goto out;
+			}
+
+			path_put(&parent);
+			next[0] = '\0';
+
+			err = kern_path(filepath, flags, &parent);
+			if (err)
+				goto out;
+
+			if (is_last) {
+				path->mnt = parent.mnt;
+				path->dentry = parent.dentry;
+				goto out;
+			}
+
+			next[0] = '/';
+			remain_len -= filename_len + 1;
+		}
+
+		path_put(&parent);
+		err = -EINVAL;
+out:
+		kfree(filepath);
+	}
+	return err;
+}
+
+int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
+				struct dentry *dentry)
+{
+	char *name, *xattr_list = NULL;
+	ssize_t xattr_list_len;
+	int err = 0;
+
+	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	if (xattr_list_len < 0) {
+		goto out;
+	} else if (!xattr_list_len) {
+		ksmbd_debug(SMB, "empty xattr in the file\n");
+		goto out;
+	}
+
+	for (name = xattr_list; name - xattr_list < xattr_list_len;
+	     name += strlen(name) + 1) {
+		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
+
+		if (!strncmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
+			     sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1) ||
+		    !strncmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
+			     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1)) {
+			err = ksmbd_vfs_remove_xattr(user_ns, dentry, name);
+			if (err)
+				ksmbd_debug(SMB,
+					    "remove acl xattr failed : %s\n", name);
+		}
+	}
+out:
+	kvfree(xattr_list);
+	return err;
+}
+
+int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
+			       struct dentry *dentry)
+{
+	char *name, *xattr_list = NULL;
+	ssize_t xattr_list_len;
+	int err = 0;
+
+	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	if (xattr_list_len < 0) {
+		goto out;
+	} else if (!xattr_list_len) {
+		ksmbd_debug(SMB, "empty xattr in the file\n");
+		goto out;
+	}
+
+	for (name = xattr_list; name - xattr_list < xattr_list_len;
+			name += strlen(name) + 1) {
+		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
+
+		if (!strncmp(name, XATTR_NAME_SD, XATTR_NAME_SD_LEN)) {
+			err = ksmbd_vfs_remove_xattr(user_ns, dentry, name);
+			if (err)
+				ksmbd_debug(SMB, "remove xattr failed : %s\n", name);
+		}
+	}
+out:
+	kvfree(xattr_list);
+	return err;
+}
+
+static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespace *user_ns,
+							    struct inode *inode,
+							    int acl_type)
+{
+	struct xattr_smb_acl *smb_acl = NULL;
+	struct posix_acl *posix_acls;
+	struct posix_acl_entry *pa_entry;
+	struct xattr_acl_entry *xa_entry;
+	int i;
+
+	posix_acls = get_acl(inode, acl_type);
+	if (!posix_acls)
+		return NULL;
+
+	smb_acl = kzalloc(sizeof(struct xattr_smb_acl) +
+			  sizeof(struct xattr_acl_entry) * posix_acls->a_count,
+			  GFP_KERNEL);
+	if (!smb_acl)
+		goto out;
+
+	smb_acl->count = posix_acls->a_count;
+	pa_entry = posix_acls->a_entries;
+	xa_entry = smb_acl->entries;
+	for (i = 0; i < posix_acls->a_count; i++, pa_entry++, xa_entry++) {
+		switch (pa_entry->e_tag) {
+		case ACL_USER:
+			xa_entry->type = SMB_ACL_USER;
+			xa_entry->uid = from_kuid(user_ns, pa_entry->e_uid);
+			break;
+		case ACL_USER_OBJ:
+			xa_entry->type = SMB_ACL_USER_OBJ;
+			break;
+		case ACL_GROUP:
+			xa_entry->type = SMB_ACL_GROUP;
+			xa_entry->gid = from_kgid(user_ns, pa_entry->e_gid);
+			break;
+		case ACL_GROUP_OBJ:
+			xa_entry->type = SMB_ACL_GROUP_OBJ;
+			break;
+		case ACL_OTHER:
+			xa_entry->type = SMB_ACL_OTHER;
+			break;
+		case ACL_MASK:
+			xa_entry->type = SMB_ACL_MASK;
+			break;
+		default:
+			pr_err("unknown type : 0x%x\n", pa_entry->e_tag);
+			goto out;
+		}
+
+		if (pa_entry->e_perm & ACL_READ)
+			xa_entry->perm |= SMB_ACL_READ;
+		if (pa_entry->e_perm & ACL_WRITE)
+			xa_entry->perm |= SMB_ACL_WRITE;
+		if (pa_entry->e_perm & ACL_EXECUTE)
+			xa_entry->perm |= SMB_ACL_EXECUTE;
+	}
+out:
+	posix_acl_release(posix_acls);
+	return smb_acl;
+}
+
+int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
+			   struct user_namespace *user_ns,
+			   struct dentry *dentry,
+			   struct smb_ntsd *pntsd, int len)
+{
+	int rc;
+	struct ndr sd_ndr = {0}, acl_ndr = {0};
+	struct xattr_ntacl acl = {0};
+	struct xattr_smb_acl *smb_acl, *def_smb_acl = NULL;
+	struct inode *inode = d_inode(dentry);
+
+	acl.version = 4;
+	acl.hash_type = XATTR_SD_HASH_TYPE_SHA256;
+	acl.current_time = ksmbd_UnixTimeToNT(current_time(inode));
+
+	memcpy(acl.desc, "posix_acl", 9);
+	acl.desc_len = 10;
+
+	pntsd->osidoffset =
+		cpu_to_le32(le32_to_cpu(pntsd->osidoffset) + NDR_NTSD_OFFSETOF);
+	pntsd->gsidoffset =
+		cpu_to_le32(le32_to_cpu(pntsd->gsidoffset) + NDR_NTSD_OFFSETOF);
+	pntsd->dacloffset =
+		cpu_to_le32(le32_to_cpu(pntsd->dacloffset) + NDR_NTSD_OFFSETOF);
+
+	acl.sd_buf = (char *)pntsd;
+	acl.sd_size = len;
+
+	rc = ksmbd_gen_sd_hash(conn, acl.sd_buf, acl.sd_size, acl.hash);
+	if (rc) {
+		pr_err("failed to generate hash for ndr acl\n");
+		return rc;
+	}
+
+	smb_acl = ksmbd_vfs_make_xattr_posix_acl(user_ns, inode,
+						 ACL_TYPE_ACCESS);
+	if (S_ISDIR(inode->i_mode))
+		def_smb_acl = ksmbd_vfs_make_xattr_posix_acl(user_ns, inode,
+							     ACL_TYPE_DEFAULT);
+
+	rc = ndr_encode_posix_acl(&acl_ndr, user_ns, inode,
+				  smb_acl, def_smb_acl);
+	if (rc) {
+		pr_err("failed to encode ndr to posix acl\n");
+		goto out;
+	}
+
+	rc = ksmbd_gen_sd_hash(conn, acl_ndr.data, acl_ndr.offset,
+			       acl.posix_acl_hash);
+	if (rc) {
+		pr_err("failed to generate hash for ndr acl\n");
+		goto out;
+	}
+
+	rc = ndr_encode_v4_ntacl(&sd_ndr, &acl);
+	if (rc) {
+		pr_err("failed to encode ndr to posix acl\n");
+		goto out;
+	}
+
+	rc = ksmbd_vfs_setxattr(user_ns, dentry,
+				XATTR_NAME_SD, sd_ndr.data,
+				sd_ndr.offset, 0);
+	if (rc < 0)
+		pr_err("Failed to store XATTR ntacl :%d\n", rc);
+
+	kfree(sd_ndr.data);
+out:
+	kfree(acl_ndr.data);
+	kfree(smb_acl);
+	kfree(def_smb_acl);
+	return rc;
+}
+
+int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
+			   struct user_namespace *user_ns,
+			   struct dentry *dentry,
+			   struct smb_ntsd **pntsd)
+{
+	int rc;
+	struct ndr n;
+	struct inode *inode = d_inode(dentry);
+	struct ndr acl_ndr = {0};
+	struct xattr_ntacl acl;
+	struct xattr_smb_acl *smb_acl = NULL, *def_smb_acl = NULL;
+	__u8 cmp_hash[XATTR_SD_HASH_SIZE] = {0};
+
+	rc = ksmbd_vfs_getxattr(user_ns, dentry, XATTR_NAME_SD, &n.data);
+	if (rc <= 0)
+		return rc;
+
+	n.length = rc;
+	rc = ndr_decode_v4_ntacl(&n, &acl);
+	if (rc)
+		goto free_n_data;
+
+	smb_acl = ksmbd_vfs_make_xattr_posix_acl(user_ns, inode,
+						 ACL_TYPE_ACCESS);
+	if (S_ISDIR(inode->i_mode))
+		def_smb_acl = ksmbd_vfs_make_xattr_posix_acl(user_ns, inode,
+							     ACL_TYPE_DEFAULT);
+
+	rc = ndr_encode_posix_acl(&acl_ndr, user_ns, inode, smb_acl,
+				  def_smb_acl);
+	if (rc) {
+		pr_err("failed to encode ndr to posix acl\n");
+		goto out_free;
+	}
+
+	rc = ksmbd_gen_sd_hash(conn, acl_ndr.data, acl_ndr.offset, cmp_hash);
+	if (rc) {
+		pr_err("failed to generate hash for ndr acl\n");
+		goto out_free;
+	}
+
+	if (memcmp(cmp_hash, acl.posix_acl_hash, XATTR_SD_HASH_SIZE)) {
+		pr_err("hash value diff\n");
+		rc = -EINVAL;
+		goto out_free;
+	}
+
+	*pntsd = acl.sd_buf;
+	(*pntsd)->osidoffset = cpu_to_le32(le32_to_cpu((*pntsd)->osidoffset) -
+					   NDR_NTSD_OFFSETOF);
+	(*pntsd)->gsidoffset = cpu_to_le32(le32_to_cpu((*pntsd)->gsidoffset) -
+					   NDR_NTSD_OFFSETOF);
+	(*pntsd)->dacloffset = cpu_to_le32(le32_to_cpu((*pntsd)->dacloffset) -
+					   NDR_NTSD_OFFSETOF);
+
+	rc = acl.sd_size;
+out_free:
+	kfree(acl_ndr.data);
+	kfree(smb_acl);
+	kfree(def_smb_acl);
+	if (rc < 0) {
+		kfree(acl.sd_buf);
+		*pntsd = NULL;
+	}
+
+free_n_data:
+	kfree(n.data);
+	return rc;
+}
+
+int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
+				   struct dentry *dentry,
+				   struct xattr_dos_attrib *da)
+{
+	struct ndr n;
+	int err;
+
+	err = ndr_encode_dos_attr(&n, da);
+	if (err)
+		return err;
+
+	err = ksmbd_vfs_setxattr(user_ns, dentry, XATTR_NAME_DOS_ATTRIBUTE,
+				 (void *)n.data, n.offset, 0);
+	if (err)
+		ksmbd_debug(SMB, "failed to store dos attribute in xattr\n");
+	kfree(n.data);
+
+	return err;
+}
+
+int ksmbd_vfs_get_dos_attrib_xattr(struct user_namespace *user_ns,
+				   struct dentry *dentry,
+				   struct xattr_dos_attrib *da)
+{
+	struct ndr n;
+	int err;
+
+	err = ksmbd_vfs_getxattr(user_ns, dentry, XATTR_NAME_DOS_ATTRIBUTE,
+				 (char **)&n.data);
+	if (err > 0) {
+		n.length = err;
+		if (ndr_decode_dos_attr(&n, da))
+			err = -EINVAL;
+		kfree(n.data);
+	} else {
+		ksmbd_debug(SMB, "failed to load dos attribute in xattr\n");
+	}
+
+	return err;
+}
+
+/**
+ * ksmbd_vfs_init_kstat() - convert unix stat information to smb stat format
+ * @p:          destination buffer
+ * @ksmbd_kstat:      ksmbd kstat wrapper
+ */
+void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat)
+{
+	struct file_directory_info *info = (struct file_directory_info *)(*p);
+	struct kstat *kstat = ksmbd_kstat->kstat;
+	u64 time;
+
+	info->FileIndex = 0;
+	info->CreationTime = cpu_to_le64(ksmbd_kstat->create_time);
+	time = ksmbd_UnixTimeToNT(kstat->atime);
+	info->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(kstat->mtime);
+	info->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(kstat->ctime);
+	info->ChangeTime = cpu_to_le64(time);
+
+	if (ksmbd_kstat->file_attributes & ATTR_DIRECTORY_LE) {
+		info->EndOfFile = 0;
+		info->AllocationSize = 0;
+	} else {
+		info->EndOfFile = cpu_to_le64(kstat->size);
+		info->AllocationSize = cpu_to_le64(kstat->blocks << 9);
+	}
+	info->ExtFileAttributes = ksmbd_kstat->file_attributes;
+
+	return info;
+}
+
+int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
+				struct user_namespace *user_ns,
+				struct dentry *dentry,
+				struct ksmbd_kstat *ksmbd_kstat)
+{
+	u64 time;
+	int rc;
+
+	generic_fillattr(user_ns, d_inode(dentry), ksmbd_kstat->kstat);
+
+	time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->ctime);
+	ksmbd_kstat->create_time = time;
+
+	/*
+	 * set default value for the case that store dos attributes is not yes
+	 * or that acl is disable in server's filesystem and the config is yes.
+	 */
+	if (S_ISDIR(ksmbd_kstat->kstat->mode))
+		ksmbd_kstat->file_attributes = ATTR_DIRECTORY_LE;
+	else
+		ksmbd_kstat->file_attributes = ATTR_ARCHIVE_LE;
+
+	if (test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
+		struct xattr_dos_attrib da;
+
+		rc = ksmbd_vfs_get_dos_attrib_xattr(user_ns, dentry, &da);
+		if (rc > 0) {
+			ksmbd_kstat->file_attributes = cpu_to_le32(da.attr);
+			ksmbd_kstat->create_time = da.create_time;
+		} else {
+			ksmbd_debug(VFS, "fail to load dos attribute.\n");
+		}
+	}
+
+	return 0;
+}
+
+ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
+				struct dentry *dentry, char *attr_name,
+				int attr_name_len)
+{
+	char *name, *xattr_list = NULL;
+	ssize_t value_len = -ENOENT, xattr_list_len;
+
+	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	if (xattr_list_len <= 0)
+		goto out;
+
+	for (name = xattr_list; name - xattr_list < xattr_list_len;
+			name += strlen(name) + 1) {
+		ksmbd_debug(VFS, "%s, len %zd\n", name, strlen(name));
+		if (strncasecmp(attr_name, name, attr_name_len))
+			continue;
+
+		value_len = ksmbd_vfs_xattr_len(user_ns, dentry, name);
+		break;
+	}
+
+out:
+	kvfree(xattr_list);
+	return value_len;
+}
+
+int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
+				size_t *xattr_stream_name_size, int s_type)
+{
+	char *type, *buf;
+
+	if (s_type == DIR_STREAM)
+		type = ":$INDEX_ALLOCATION";
+	else
+		type = ":$DATA";
+
+	buf = kasprintf(GFP_KERNEL, "%s%s%s",
+			XATTR_NAME_STREAM, stream_name,	type);
+	if (!buf)
+		return -ENOMEM;
+
+	*xattr_stream_name = buf;
+	*xattr_stream_name_size = strlen(buf) + 1;
+
+	return 0;
+}
+
+int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
+			       struct ksmbd_file *src_fp,
+			       struct ksmbd_file *dst_fp,
+			       struct srv_copychunk *chunks,
+			       unsigned int chunk_count,
+			       unsigned int *chunk_count_written,
+			       unsigned int *chunk_size_written,
+			       loff_t *total_size_written)
+{
+	unsigned int i;
+	loff_t src_off, dst_off, src_file_size;
+	size_t len;
+	int ret;
+
+	*chunk_count_written = 0;
+	*chunk_size_written = 0;
+	*total_size_written = 0;
+
+	if (!(src_fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
+		pr_err("no right to read(%pd)\n", src_fp->filp->f_path.dentry);
+		return -EACCES;
+	}
+	if (!(dst_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE))) {
+		pr_err("no right to write(%pd)\n", dst_fp->filp->f_path.dentry);
+		return -EACCES;
+	}
+
+	if (ksmbd_stream_fd(src_fp) || ksmbd_stream_fd(dst_fp))
+		return -EBADF;
+
+	smb_break_all_levII_oplock(work, dst_fp, 1);
+
+	if (!work->tcon->posix_extensions) {
+		for (i = 0; i < chunk_count; i++) {
+			src_off = le64_to_cpu(chunks[i].SourceOffset);
+			dst_off = le64_to_cpu(chunks[i].TargetOffset);
+			len = le32_to_cpu(chunks[i].Length);
+
+			if (check_lock_range(src_fp->filp, src_off,
+					     src_off + len - 1, READ))
+				return -EAGAIN;
+			if (check_lock_range(dst_fp->filp, dst_off,
+					     dst_off + len - 1, WRITE))
+				return -EAGAIN;
+		}
+	}
+
+	src_file_size = i_size_read(file_inode(src_fp->filp));
+
+	for (i = 0; i < chunk_count; i++) {
+		src_off = le64_to_cpu(chunks[i].SourceOffset);
+		dst_off = le64_to_cpu(chunks[i].TargetOffset);
+		len = le32_to_cpu(chunks[i].Length);
+
+		if (src_off + len > src_file_size)
+			return -E2BIG;
+
+		ret = vfs_copy_file_range(src_fp->filp, src_off,
+					  dst_fp->filp, dst_off, len, 0);
+		if (ret < 0)
+			return ret;
+
+		*chunk_count_written += 1;
+		*total_size_written += ret;
+	}
+	return 0;
+}
+
+void ksmbd_vfs_posix_lock_wait(struct file_lock *flock)
+{
+	wait_event(flock->fl_wait, !flock->fl_blocker);
+}
+
+int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout)
+{
+	return wait_event_interruptible_timeout(flock->fl_wait,
+						!flock->fl_blocker,
+						timeout);
+}
+
+void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock)
+{
+	locks_delete_block(flock);
+}
+
+int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
+				 struct inode *inode)
+{
+	struct posix_acl_state acl_state;
+	struct posix_acl *acls;
+	int rc;
+
+	ksmbd_debug(SMB, "Set posix acls\n");
+	rc = init_acl_state(&acl_state, 1);
+	if (rc)
+		return rc;
+
+	/* Set default owner group */
+	acl_state.owner.allow = (inode->i_mode & 0700) >> 6;
+	acl_state.group.allow = (inode->i_mode & 0070) >> 3;
+	acl_state.other.allow = inode->i_mode & 0007;
+	acl_state.users->aces[acl_state.users->n].uid = inode->i_uid;
+	acl_state.users->aces[acl_state.users->n++].perms.allow =
+		acl_state.owner.allow;
+	acl_state.groups->aces[acl_state.groups->n].gid = inode->i_gid;
+	acl_state.groups->aces[acl_state.groups->n++].perms.allow =
+		acl_state.group.allow;
+	acl_state.mask.allow = 0x07;
+
+	acls = posix_acl_alloc(6, GFP_KERNEL);
+	if (!acls) {
+		free_acl_state(&acl_state);
+		return -ENOMEM;
+	}
+	posix_state_to_acl(&acl_state, acls->a_entries);
+	rc = set_posix_acl(user_ns, inode, ACL_TYPE_ACCESS, acls);
+	if (rc < 0)
+		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
+			    rc);
+	else if (S_ISDIR(inode->i_mode)) {
+		posix_state_to_acl(&acl_state, acls->a_entries);
+		rc = set_posix_acl(user_ns, inode, ACL_TYPE_DEFAULT,
+				   acls);
+		if (rc < 0)
+			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
+				    rc);
+	}
+	free_acl_state(&acl_state);
+	posix_acl_release(acls);
+	return rc;
+}
+
+int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
+				struct inode *inode, struct inode *parent_inode)
+{
+	struct posix_acl *acls;
+	struct posix_acl_entry *pace;
+	int rc, i;
+
+	acls = get_acl(parent_inode, ACL_TYPE_DEFAULT);
+	if (!acls)
+		return -ENOENT;
+	pace = acls->a_entries;
+
+	for (i = 0; i < acls->a_count; i++, pace++) {
+		if (pace->e_tag == ACL_MASK) {
+			pace->e_perm = 0x07;
+			break;
+		}
+	}
+
+	rc = set_posix_acl(user_ns, inode, ACL_TYPE_ACCESS, acls);
+	if (rc < 0)
+		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
+			    rc);
+	if (S_ISDIR(inode->i_mode)) {
+		rc = set_posix_acl(user_ns, inode, ACL_TYPE_DEFAULT,
+				   acls);
+		if (rc < 0)
+			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
+				    rc);
+	}
+	posix_acl_release(acls);
+	return rc;
+}
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
new file mode 100644
index 000000000000..cb0cba0d5d07
--- /dev/null
+++ b/fs/ksmbd/vfs.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_VFS_H__
+#define __KSMBD_VFS_H__
+
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <uapi/linux/xattr.h>
+#include <linux/posix_acl.h>
+
+#include "smbacl.h"
+#include "xattr.h"
+
+/*
+ * Enumeration for stream type.
+ */
+enum {
+	DATA_STREAM	= 1,	/* type $DATA */
+	DIR_STREAM		/* type $INDEX_ALLOCATION */
+};
+
+/* CreateOptions */
+/* Flag is set, it must not be a file , valid for directory only */
+#define FILE_DIRECTORY_FILE_LE			cpu_to_le32(0x00000001)
+#define FILE_WRITE_THROUGH_LE			cpu_to_le32(0x00000002)
+#define FILE_SEQUENTIAL_ONLY_LE			cpu_to_le32(0x00000004)
+
+/* Should not buffer on server*/
+#define FILE_NO_INTERMEDIATE_BUFFERING_LE	cpu_to_le32(0x00000008)
+/* MBZ */
+#define FILE_SYNCHRONOUS_IO_ALERT_LE		cpu_to_le32(0x00000010)
+/* MBZ */
+#define FILE_SYNCHRONOUS_IO_NONALERT_LE		cpu_to_le32(0x00000020)
+
+/* Flaf must not be set for directory */
+#define FILE_NON_DIRECTORY_FILE_LE		cpu_to_le32(0x00000040)
+
+/* Should be zero */
+#define CREATE_TREE_CONNECTION			cpu_to_le32(0x00000080)
+#define FILE_COMPLETE_IF_OPLOCKED_LE		cpu_to_le32(0x00000100)
+#define FILE_NO_EA_KNOWLEDGE_LE			cpu_to_le32(0x00000200)
+#define FILE_OPEN_REMOTE_INSTANCE		cpu_to_le32(0x00000400)
+
+/**
+ * Doc says this is obsolete "open for recovery" flag should be zero
+ * in any case.
+ */
+#define CREATE_OPEN_FOR_RECOVERY		cpu_to_le32(0x00000400)
+#define FILE_RANDOM_ACCESS_LE			cpu_to_le32(0x00000800)
+#define FILE_DELETE_ON_CLOSE_LE			cpu_to_le32(0x00001000)
+#define FILE_OPEN_BY_FILE_ID_LE			cpu_to_le32(0x00002000)
+#define FILE_OPEN_FOR_BACKUP_INTENT_LE		cpu_to_le32(0x00004000)
+#define FILE_NO_COMPRESSION_LE			cpu_to_le32(0x00008000)
+
+/* Should be zero*/
+#define FILE_OPEN_REQUIRING_OPLOCK		cpu_to_le32(0x00010000)
+#define FILE_DISALLOW_EXCLUSIVE			cpu_to_le32(0x00020000)
+#define FILE_RESERVE_OPFILTER_LE		cpu_to_le32(0x00100000)
+#define FILE_OPEN_REPARSE_POINT_LE		cpu_to_le32(0x00200000)
+#define FILE_OPEN_NO_RECALL_LE			cpu_to_le32(0x00400000)
+
+/* Should be zero */
+#define FILE_OPEN_FOR_FREE_SPACE_QUERY_LE	cpu_to_le32(0x00800000)
+#define CREATE_OPTIONS_MASK			cpu_to_le32(0x00FFFFFF)
+#define CREATE_OPTION_READONLY			0x10000000
+/* system. NB not sent over wire */
+#define CREATE_OPTION_SPECIAL			0x20000000
+
+struct ksmbd_work;
+struct ksmbd_file;
+struct ksmbd_conn;
+
+struct ksmbd_dir_info {
+	const char	*name;
+	char		*wptr;
+	char		*rptr;
+	int		name_len;
+	int		out_buf_len;
+	int		num_entry;
+	int		data_count;
+	int		last_entry_offset;
+	bool		hide_dot_file;
+	int		flags;
+};
+
+struct ksmbd_readdir_data {
+	struct dir_context	ctx;
+	union {
+		void		*private;
+		char		*dirent;
+	};
+
+	unsigned int		used;
+	unsigned int		dirent_count;
+	unsigned int		file_attr;
+};
+
+/* ksmbd kstat wrapper to get valid create time when reading dir entry */
+struct ksmbd_kstat {
+	struct kstat		*kstat;
+	unsigned long long	create_time;
+	__le32			file_attributes;
+};
+
+int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child);
+int ksmbd_vfs_may_delete(struct user_namespace *user_ns, struct dentry *dentry);
+int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
+				   struct dentry *dentry, __le32 *daccess);
+int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
+int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode);
+int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp,
+		   size_t count, loff_t *pos);
+int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
+		    char *buf, size_t count, loff_t *pos, bool sync,
+		    ssize_t *written);
+int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id);
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name);
+int ksmbd_vfs_link(struct ksmbd_work *work,
+		   const char *oldname, const char *newname);
+int ksmbd_vfs_getattr(struct path *path, struct kstat *stat);
+int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
+			char *newname);
+int ksmbd_vfs_truncate(struct ksmbd_work *work, const char *name,
+		       struct ksmbd_file *fp, loff_t size);
+struct srv_copychunk;
+int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
+			       struct ksmbd_file *src_fp,
+			       struct ksmbd_file *dst_fp,
+			       struct srv_copychunk *chunks,
+			       unsigned int chunk_count,
+			       unsigned int *chunk_count_written,
+			       unsigned int *chunk_size_written,
+			       loff_t  *total_size_written);
+ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list);
+ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
+			   struct dentry *dentry,
+			   char *xattr_name,
+			   char **xattr_buf);
+ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
+				struct dentry *dentry, char *attr_name,
+				int attr_name_len);
+int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
+		       struct dentry *dentry, const char *attr_name,
+		       const void *attr_value, size_t attr_size, int flags);
+int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
+				size_t *xattr_stream_name_size, int s_type);
+int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
+			   struct dentry *dentry, char *attr_name);
+int ksmbd_vfs_kern_path(char *name, unsigned int flags, struct path *path,
+			bool caseless);
+int ksmbd_vfs_empty_dir(struct ksmbd_file *fp);
+void ksmbd_vfs_set_fadvise(struct file *filp, __le32 option);
+int ksmbd_vfs_zero_data(struct ksmbd_work *work, struct ksmbd_file *fp,
+			loff_t off, loff_t len);
+struct file_allocated_range_buffer;
+int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
+			 struct file_allocated_range_buffer *ranges,
+			 int in_count, int *out_count);
+int ksmbd_vfs_unlink(struct user_namespace *user_ns,
+		     struct dentry *dir, struct dentry *dentry);
+void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat);
+int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
+				struct user_namespace *user_ns,
+				struct dentry *dentry,
+				struct ksmbd_kstat *ksmbd_kstat);
+void ksmbd_vfs_posix_lock_wait(struct file_lock *flock);
+int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout);
+void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock);
+int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
+				struct dentry *dentry);
+int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
+			       struct dentry *dentry);
+int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
+			   struct user_namespace *user_ns,
+			   struct dentry *dentry,
+			   struct smb_ntsd *pntsd, int len);
+int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
+			   struct user_namespace *user_ns,
+			   struct dentry *dentry,
+			   struct smb_ntsd **pntsd);
+int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
+				   struct dentry *dentry,
+				   struct xattr_dos_attrib *da);
+int ksmbd_vfs_get_dos_attrib_xattr(struct user_namespace *user_ns,
+				   struct dentry *dentry,
+				   struct xattr_dos_attrib *da);
+int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
+				 struct inode *inode);
+int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
+				struct inode *inode,
+				struct inode *parent_inode);
+#endif /* __KSMBD_VFS_H__ */
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
new file mode 100644
index 000000000000..92d8c61ffd2a
--- /dev/null
+++ b/fs/ksmbd/vfs_cache.c
@@ -0,0 +1,725 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ * Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "glob.h"
+#include "vfs_cache.h"
+#include "oplock.h"
+#include "vfs.h"
+#include "connection.h"
+#include "mgmt/tree_connect.h"
+#include "mgmt/user_session.h"
+#include "smb_common.h"
+
+#define S_DEL_PENDING			1
+#define S_DEL_ON_CLS			2
+#define S_DEL_ON_CLS_STREAM		8
+
+static unsigned int inode_hash_mask __read_mostly;
+static unsigned int inode_hash_shift __read_mostly;
+static struct hlist_head *inode_hashtable __read_mostly;
+static DEFINE_RWLOCK(inode_hash_lock);
+
+static struct ksmbd_file_table global_ft;
+static atomic_long_t fd_limit;
+static struct kmem_cache *filp_cache;
+
+void ksmbd_set_fd_limit(unsigned long limit)
+{
+	limit = min(limit, get_max_files());
+	atomic_long_set(&fd_limit, limit);
+}
+
+static bool fd_limit_depleted(void)
+{
+	long v = atomic_long_dec_return(&fd_limit);
+
+	if (v >= 0)
+		return false;
+	atomic_long_inc(&fd_limit);
+	return true;
+}
+
+static void fd_limit_close(void)
+{
+	atomic_long_inc(&fd_limit);
+}
+
+/*
+ * INODE hash
+ */
+
+static unsigned long inode_hash(struct super_block *sb, unsigned long hashval)
+{
+	unsigned long tmp;
+
+	tmp = (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + hashval) /
+		L1_CACHE_BYTES;
+	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> inode_hash_shift);
+	return tmp & inode_hash_mask;
+}
+
+static struct ksmbd_inode *__ksmbd_inode_lookup(struct inode *inode)
+{
+	struct hlist_head *head = inode_hashtable +
+		inode_hash(inode->i_sb, inode->i_ino);
+	struct ksmbd_inode *ci = NULL, *ret_ci = NULL;
+
+	hlist_for_each_entry(ci, head, m_hash) {
+		if (ci->m_inode == inode) {
+			if (atomic_inc_not_zero(&ci->m_count))
+				ret_ci = ci;
+			break;
+		}
+	}
+	return ret_ci;
+}
+
+static struct ksmbd_inode *ksmbd_inode_lookup(struct ksmbd_file *fp)
+{
+	return __ksmbd_inode_lookup(file_inode(fp->filp));
+}
+
+static struct ksmbd_inode *ksmbd_inode_lookup_by_vfsinode(struct inode *inode)
+{
+	struct ksmbd_inode *ci;
+
+	read_lock(&inode_hash_lock);
+	ci = __ksmbd_inode_lookup(inode);
+	read_unlock(&inode_hash_lock);
+	return ci;
+}
+
+int ksmbd_query_inode_status(struct inode *inode)
+{
+	struct ksmbd_inode *ci;
+	int ret = KSMBD_INODE_STATUS_UNKNOWN;
+
+	read_lock(&inode_hash_lock);
+	ci = __ksmbd_inode_lookup(inode);
+	if (ci) {
+		ret = KSMBD_INODE_STATUS_OK;
+		if (ci->m_flags & S_DEL_PENDING)
+			ret = KSMBD_INODE_STATUS_PENDING_DELETE;
+		atomic_dec(&ci->m_count);
+	}
+	read_unlock(&inode_hash_lock);
+	return ret;
+}
+
+bool ksmbd_inode_pending_delete(struct ksmbd_file *fp)
+{
+	return (fp->f_ci->m_flags & S_DEL_PENDING);
+}
+
+void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp)
+{
+	fp->f_ci->m_flags |= S_DEL_PENDING;
+}
+
+void ksmbd_clear_inode_pending_delete(struct ksmbd_file *fp)
+{
+	fp->f_ci->m_flags &= ~S_DEL_PENDING;
+}
+
+void ksmbd_fd_set_delete_on_close(struct ksmbd_file *fp,
+				  int file_info)
+{
+	if (ksmbd_stream_fd(fp)) {
+		fp->f_ci->m_flags |= S_DEL_ON_CLS_STREAM;
+		return;
+	}
+
+	fp->f_ci->m_flags |= S_DEL_ON_CLS;
+}
+
+static void ksmbd_inode_hash(struct ksmbd_inode *ci)
+{
+	struct hlist_head *b = inode_hashtable +
+		inode_hash(ci->m_inode->i_sb, ci->m_inode->i_ino);
+
+	hlist_add_head(&ci->m_hash, b);
+}
+
+static void ksmbd_inode_unhash(struct ksmbd_inode *ci)
+{
+	write_lock(&inode_hash_lock);
+	hlist_del_init(&ci->m_hash);
+	write_unlock(&inode_hash_lock);
+}
+
+static int ksmbd_inode_init(struct ksmbd_inode *ci, struct ksmbd_file *fp)
+{
+	ci->m_inode = file_inode(fp->filp);
+	atomic_set(&ci->m_count, 1);
+	atomic_set(&ci->op_count, 0);
+	atomic_set(&ci->sop_count, 0);
+	ci->m_flags = 0;
+	ci->m_fattr = 0;
+	INIT_LIST_HEAD(&ci->m_fp_list);
+	INIT_LIST_HEAD(&ci->m_op_list);
+	rwlock_init(&ci->m_lock);
+	return 0;
+}
+
+static struct ksmbd_inode *ksmbd_inode_get(struct ksmbd_file *fp)
+{
+	struct ksmbd_inode *ci, *tmpci;
+	int rc;
+
+	read_lock(&inode_hash_lock);
+	ci = ksmbd_inode_lookup(fp);
+	read_unlock(&inode_hash_lock);
+	if (ci)
+		return ci;
+
+	ci = kmalloc(sizeof(struct ksmbd_inode), GFP_KERNEL);
+	if (!ci)
+		return NULL;
+
+	rc = ksmbd_inode_init(ci, fp);
+	if (rc) {
+		pr_err("inode initialized failed\n");
+		kfree(ci);
+		return NULL;
+	}
+
+	write_lock(&inode_hash_lock);
+	tmpci = ksmbd_inode_lookup(fp);
+	if (!tmpci) {
+		ksmbd_inode_hash(ci);
+	} else {
+		kfree(ci);
+		ci = tmpci;
+	}
+	write_unlock(&inode_hash_lock);
+	return ci;
+}
+
+static void ksmbd_inode_free(struct ksmbd_inode *ci)
+{
+	ksmbd_inode_unhash(ci);
+	kfree(ci);
+}
+
+static void ksmbd_inode_put(struct ksmbd_inode *ci)
+{
+	if (atomic_dec_and_test(&ci->m_count))
+		ksmbd_inode_free(ci);
+}
+
+int __init ksmbd_inode_hash_init(void)
+{
+	unsigned int loop;
+	unsigned long numentries = 16384;
+	unsigned long bucketsize = sizeof(struct hlist_head);
+	unsigned long size;
+
+	inode_hash_shift = ilog2(numentries);
+	inode_hash_mask = (1 << inode_hash_shift) - 1;
+
+	size = bucketsize << inode_hash_shift;
+
+	/* init master fp hash table */
+	inode_hashtable = vmalloc(size);
+	if (!inode_hashtable)
+		return -ENOMEM;
+
+	for (loop = 0; loop < (1U << inode_hash_shift); loop++)
+		INIT_HLIST_HEAD(&inode_hashtable[loop]);
+	return 0;
+}
+
+void ksmbd_release_inode_hash(void)
+{
+	vfree(inode_hashtable);
+}
+
+static void __ksmbd_inode_close(struct ksmbd_file *fp)
+{
+	struct dentry *dir, *dentry;
+	struct ksmbd_inode *ci = fp->f_ci;
+	int err;
+	struct file *filp;
+
+	filp = fp->filp;
+	if (ksmbd_stream_fd(fp) && (ci->m_flags & S_DEL_ON_CLS_STREAM)) {
+		ci->m_flags &= ~S_DEL_ON_CLS_STREAM;
+		err = ksmbd_vfs_remove_xattr(file_mnt_user_ns(filp),
+					     filp->f_path.dentry,
+					     fp->stream.name);
+		if (err)
+			pr_err("remove xattr failed : %s\n",
+			       fp->stream.name);
+	}
+
+	if (atomic_dec_and_test(&ci->m_count)) {
+		write_lock(&ci->m_lock);
+		if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING)) {
+			dentry = filp->f_path.dentry;
+			dir = dentry->d_parent;
+			ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
+			write_unlock(&ci->m_lock);
+			ksmbd_vfs_unlink(file_mnt_user_ns(filp), dir, dentry);
+			write_lock(&ci->m_lock);
+		}
+		write_unlock(&ci->m_lock);
+
+		ksmbd_inode_free(ci);
+	}
+}
+
+static void __ksmbd_remove_durable_fd(struct ksmbd_file *fp)
+{
+	if (!has_file_id(fp->persistent_id))
+		return;
+
+	write_lock(&global_ft.lock);
+	idr_remove(global_ft.idr, fp->persistent_id);
+	write_unlock(&global_ft.lock);
+}
+
+static void __ksmbd_remove_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
+{
+	if (!has_file_id(fp->volatile_id))
+		return;
+
+	write_lock(&fp->f_ci->m_lock);
+	list_del_init(&fp->node);
+	write_unlock(&fp->f_ci->m_lock);
+
+	write_lock(&ft->lock);
+	idr_remove(ft->idr, fp->volatile_id);
+	write_unlock(&ft->lock);
+}
+
+static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
+{
+	struct file *filp;
+	struct ksmbd_lock *smb_lock, *tmp_lock;
+
+	fd_limit_close();
+	__ksmbd_remove_durable_fd(fp);
+	__ksmbd_remove_fd(ft, fp);
+
+	close_id_del_oplock(fp);
+	filp = fp->filp;
+
+	__ksmbd_inode_close(fp);
+	if (!IS_ERR_OR_NULL(filp))
+		fput(filp);
+
+	/* because the reference count of fp is 0, it is guaranteed that
+	 * there are not accesses to fp->lock_list.
+	 */
+	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
+		spin_lock(&fp->conn->llist_lock);
+		list_del(&smb_lock->clist);
+		spin_unlock(&fp->conn->llist_lock);
+
+		list_del(&smb_lock->flist);
+		locks_free_lock(smb_lock->fl);
+		kfree(smb_lock);
+	}
+
+	kfree(fp->filename);
+	if (ksmbd_stream_fd(fp))
+		kfree(fp->stream.name);
+	kmem_cache_free(filp_cache, fp);
+}
+
+static struct ksmbd_file *ksmbd_fp_get(struct ksmbd_file *fp)
+{
+	if (!atomic_inc_not_zero(&fp->refcount))
+		return NULL;
+	return fp;
+}
+
+static struct ksmbd_file *__ksmbd_lookup_fd(struct ksmbd_file_table *ft,
+					    u64 id)
+{
+	struct ksmbd_file *fp;
+
+	if (!has_file_id(id))
+		return NULL;
+
+	read_lock(&ft->lock);
+	fp = idr_find(ft->idr, id);
+	if (fp)
+		fp = ksmbd_fp_get(fp);
+	read_unlock(&ft->lock);
+	return fp;
+}
+
+static void __put_fd_final(struct ksmbd_work *work, struct ksmbd_file *fp)
+{
+	__ksmbd_close_fd(&work->sess->file_table, fp);
+	atomic_dec(&work->conn->stats.open_files_count);
+}
+
+static void set_close_state_blocked_works(struct ksmbd_file *fp)
+{
+	struct ksmbd_work *cancel_work, *ctmp;
+
+	spin_lock(&fp->f_lock);
+	list_for_each_entry_safe(cancel_work, ctmp, &fp->blocked_works,
+				 fp_entry) {
+		list_del(&cancel_work->fp_entry);
+		cancel_work->state = KSMBD_WORK_CLOSED;
+		cancel_work->cancel_fn(cancel_work->cancel_argv);
+	}
+	spin_unlock(&fp->f_lock);
+}
+
+int ksmbd_close_fd(struct ksmbd_work *work, u64 id)
+{
+	struct ksmbd_file	*fp;
+	struct ksmbd_file_table	*ft;
+
+	if (!has_file_id(id))
+		return 0;
+
+	ft = &work->sess->file_table;
+	read_lock(&ft->lock);
+	fp = idr_find(ft->idr, id);
+	if (fp) {
+		set_close_state_blocked_works(fp);
+
+		if (!atomic_dec_and_test(&fp->refcount))
+			fp = NULL;
+	}
+	read_unlock(&ft->lock);
+
+	if (!fp)
+		return -EINVAL;
+
+	__put_fd_final(work, fp);
+	return 0;
+}
+
+void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp)
+{
+	if (!fp)
+		return;
+
+	if (!atomic_dec_and_test(&fp->refcount))
+		return;
+	__put_fd_final(work, fp);
+}
+
+static bool __sanity_check(struct ksmbd_tree_connect *tcon, struct ksmbd_file *fp)
+{
+	if (!fp)
+		return false;
+	if (fp->tcon != tcon)
+		return false;
+	return true;
+}
+
+struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work, u64 id)
+{
+	return __ksmbd_lookup_fd(&work->sess->file_table, id);
+}
+
+struct ksmbd_file *ksmbd_lookup_fd_fast(struct ksmbd_work *work, u64 id)
+{
+	struct ksmbd_file *fp = __ksmbd_lookup_fd(&work->sess->file_table, id);
+
+	if (__sanity_check(work->tcon, fp))
+		return fp;
+
+	ksmbd_fd_put(work, fp);
+	return NULL;
+}
+
+struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
+					u64 pid)
+{
+	struct ksmbd_file *fp;
+
+	if (!has_file_id(id)) {
+		id = work->compound_fid;
+		pid = work->compound_pfid;
+	}
+
+	fp = __ksmbd_lookup_fd(&work->sess->file_table, id);
+	if (!__sanity_check(work->tcon, fp)) {
+		ksmbd_fd_put(work, fp);
+		return NULL;
+	}
+	if (fp->persistent_id != pid) {
+		ksmbd_fd_put(work, fp);
+		return NULL;
+	}
+	return fp;
+}
+
+struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id)
+{
+	return __ksmbd_lookup_fd(&global_ft, id);
+}
+
+struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid)
+{
+	struct ksmbd_file	*fp = NULL;
+	unsigned int		id;
+
+	read_lock(&global_ft.lock);
+	idr_for_each_entry(global_ft.idr, fp, id) {
+		if (!memcmp(fp->create_guid,
+			    cguid,
+			    SMB2_CREATE_GUID_SIZE)) {
+			fp = ksmbd_fp_get(fp);
+			break;
+		}
+	}
+	read_unlock(&global_ft.lock);
+
+	return fp;
+}
+
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode)
+{
+	struct ksmbd_file	*lfp;
+	struct ksmbd_inode	*ci;
+
+	ci = ksmbd_inode_lookup_by_vfsinode(inode);
+	if (!ci)
+		return NULL;
+
+	read_lock(&ci->m_lock);
+	list_for_each_entry(lfp, &ci->m_fp_list, node) {
+		if (inode == file_inode(lfp->filp)) {
+			atomic_dec(&ci->m_count);
+			read_unlock(&ci->m_lock);
+			return lfp;
+		}
+	}
+	atomic_dec(&ci->m_count);
+	read_unlock(&ci->m_lock);
+	return NULL;
+}
+
+#define OPEN_ID_TYPE_VOLATILE_ID	(0)
+#define OPEN_ID_TYPE_PERSISTENT_ID	(1)
+
+static void __open_id_set(struct ksmbd_file *fp, u64 id, int type)
+{
+	if (type == OPEN_ID_TYPE_VOLATILE_ID)
+		fp->volatile_id = id;
+	if (type == OPEN_ID_TYPE_PERSISTENT_ID)
+		fp->persistent_id = id;
+}
+
+static int __open_id(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
+		     int type)
+{
+	u64			id = 0;
+	int			ret;
+
+	if (type == OPEN_ID_TYPE_VOLATILE_ID && fd_limit_depleted()) {
+		__open_id_set(fp, KSMBD_NO_FID, type);
+		return -EMFILE;
+	}
+
+	idr_preload(GFP_KERNEL);
+	write_lock(&ft->lock);
+	ret = idr_alloc_cyclic(ft->idr, fp, 0, INT_MAX - 1, GFP_NOWAIT);
+	if (ret >= 0) {
+		id = ret;
+		ret = 0;
+	} else {
+		id = KSMBD_NO_FID;
+		fd_limit_close();
+	}
+
+	__open_id_set(fp, id, type);
+	write_unlock(&ft->lock);
+	idr_preload_end();
+	return ret;
+}
+
+unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp)
+{
+	__open_id(&global_ft, fp, OPEN_ID_TYPE_PERSISTENT_ID);
+	return fp->persistent_id;
+}
+
+struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
+{
+	struct ksmbd_file *fp;
+	int ret;
+
+	fp = kmem_cache_zalloc(filp_cache, GFP_KERNEL);
+	if (!fp) {
+		pr_err("Failed to allocate memory\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_LIST_HEAD(&fp->blocked_works);
+	INIT_LIST_HEAD(&fp->node);
+	INIT_LIST_HEAD(&fp->lock_list);
+	spin_lock_init(&fp->f_lock);
+	atomic_set(&fp->refcount, 1);
+
+	fp->filp		= filp;
+	fp->conn		= work->sess->conn;
+	fp->tcon		= work->tcon;
+	fp->volatile_id		= KSMBD_NO_FID;
+	fp->persistent_id	= KSMBD_NO_FID;
+	fp->f_ci		= ksmbd_inode_get(fp);
+
+	if (!fp->f_ci) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	ret = __open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
+	if (ret) {
+		ksmbd_inode_put(fp->f_ci);
+		goto err_out;
+	}
+
+	atomic_inc(&work->conn->stats.open_files_count);
+	return fp;
+
+err_out:
+	kmem_cache_free(filp_cache, fp);
+	return ERR_PTR(ret);
+}
+
+static int
+__close_file_table_ids(struct ksmbd_file_table *ft,
+		       struct ksmbd_tree_connect *tcon,
+		       bool (*skip)(struct ksmbd_tree_connect *tcon,
+				    struct ksmbd_file *fp))
+{
+	unsigned int			id;
+	struct ksmbd_file		*fp;
+	int				num = 0;
+
+	idr_for_each_entry(ft->idr, fp, id) {
+		if (skip(tcon, fp))
+			continue;
+
+		set_close_state_blocked_works(fp);
+
+		if (!atomic_dec_and_test(&fp->refcount))
+			continue;
+		__ksmbd_close_fd(ft, fp);
+		num++;
+	}
+	return num;
+}
+
+static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon,
+			       struct ksmbd_file *fp)
+{
+	return fp->tcon != tcon;
+}
+
+static bool session_fd_check(struct ksmbd_tree_connect *tcon,
+			     struct ksmbd_file *fp)
+{
+	return false;
+}
+
+void ksmbd_close_tree_conn_fds(struct ksmbd_work *work)
+{
+	int num = __close_file_table_ids(&work->sess->file_table,
+					 work->tcon,
+					 tree_conn_fd_check);
+
+	atomic_sub(num, &work->conn->stats.open_files_count);
+}
+
+void ksmbd_close_session_fds(struct ksmbd_work *work)
+{
+	int num = __close_file_table_ids(&work->sess->file_table,
+					 work->tcon,
+					 session_fd_check);
+
+	atomic_sub(num, &work->conn->stats.open_files_count);
+}
+
+int ksmbd_init_global_file_table(void)
+{
+	return ksmbd_init_file_table(&global_ft);
+}
+
+void ksmbd_free_global_file_table(void)
+{
+	struct ksmbd_file	*fp = NULL;
+	unsigned int		id;
+
+	idr_for_each_entry(global_ft.idr, fp, id) {
+		__ksmbd_remove_durable_fd(fp);
+		kmem_cache_free(filp_cache, fp);
+	}
+
+	ksmbd_destroy_file_table(&global_ft);
+}
+
+int ksmbd_file_table_flush(struct ksmbd_work *work)
+{
+	struct ksmbd_file	*fp = NULL;
+	unsigned int		id;
+	int			ret;
+
+	read_lock(&work->sess->file_table.lock);
+	idr_for_each_entry(work->sess->file_table.idr, fp, id) {
+		ret = ksmbd_vfs_fsync(work, fp->volatile_id, KSMBD_NO_FID);
+		if (ret)
+			break;
+	}
+	read_unlock(&work->sess->file_table.lock);
+	return ret;
+}
+
+int ksmbd_init_file_table(struct ksmbd_file_table *ft)
+{
+	ft->idr = kzalloc(sizeof(struct idr), GFP_KERNEL);
+	if (!ft->idr)
+		return -ENOMEM;
+
+	idr_init(ft->idr);
+	rwlock_init(&ft->lock);
+	return 0;
+}
+
+void ksmbd_destroy_file_table(struct ksmbd_file_table *ft)
+{
+	if (!ft->idr)
+		return;
+
+	__close_file_table_ids(ft, NULL, session_fd_check);
+	idr_destroy(ft->idr);
+	kfree(ft->idr);
+	ft->idr = NULL;
+}
+
+int ksmbd_init_file_cache(void)
+{
+	filp_cache = kmem_cache_create("ksmbd_file_cache",
+				       sizeof(struct ksmbd_file), 0,
+				       SLAB_HWCACHE_ALIGN, NULL);
+	if (!filp_cache)
+		goto out;
+
+	return 0;
+
+out:
+	pr_err("failed to allocate file cache\n");
+	return -ENOMEM;
+}
+
+void ksmbd_exit_file_cache(void)
+{
+	kmem_cache_destroy(filp_cache);
+}
diff --git a/fs/ksmbd/vfs_cache.h b/fs/ksmbd/vfs_cache.h
new file mode 100644
index 000000000000..70dfe6a99f13
--- /dev/null
+++ b/fs/ksmbd/vfs_cache.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __VFS_CACHE_H__
+#define __VFS_CACHE_H__
+
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/rwsem.h>
+#include <linux/spinlock.h>
+#include <linux/idr.h>
+#include <linux/workqueue.h>
+
+#include "vfs.h"
+
+/* Windows style file permissions for extended response */
+#define	FILE_GENERIC_ALL	0x1F01FF
+#define	FILE_GENERIC_READ	0x120089
+#define	FILE_GENERIC_WRITE	0x120116
+#define	FILE_GENERIC_EXECUTE	0X1200a0
+
+#define KSMBD_START_FID		0
+#define KSMBD_NO_FID		(INT_MAX)
+#define SMB2_NO_FID		(0xFFFFFFFFFFFFFFFFULL)
+
+struct ksmbd_conn;
+struct ksmbd_session;
+
+struct ksmbd_lock {
+	struct file_lock *fl;
+	struct list_head clist;
+	struct list_head flist;
+	struct list_head llist;
+	unsigned int flags;
+	int cmd;
+	int zero_len;
+	unsigned long long start;
+	unsigned long long end;
+};
+
+struct stream {
+	char *name;
+	ssize_t size;
+};
+
+struct ksmbd_inode {
+	rwlock_t			m_lock;
+	atomic_t			m_count;
+	atomic_t			op_count;
+	/* opinfo count for streams */
+	atomic_t			sop_count;
+	struct inode			*m_inode;
+	unsigned int			m_flags;
+	struct hlist_node		m_hash;
+	struct list_head		m_fp_list;
+	struct list_head		m_op_list;
+	struct oplock_info		*m_opinfo;
+	__le32				m_fattr;
+};
+
+struct ksmbd_file {
+	struct file			*filp;
+	char				*filename;
+	u64				persistent_id;
+	u64				volatile_id;
+
+	spinlock_t			f_lock;
+
+	struct ksmbd_inode		*f_ci;
+	struct ksmbd_inode		*f_parent_ci;
+	struct oplock_info __rcu	*f_opinfo;
+	struct ksmbd_conn		*conn;
+	struct ksmbd_tree_connect	*tcon;
+
+	atomic_t			refcount;
+	__le32				daccess;
+	__le32				saccess;
+	__le32				coption;
+	__le32				cdoption;
+	__u64				create_time;
+	__u64				itime;
+
+	bool				is_nt_open;
+	bool				attrib_only;
+
+	char				client_guid[16];
+	char				create_guid[16];
+	char				app_instance_id[16];
+
+	struct stream			stream;
+	struct list_head		node;
+	struct list_head		blocked_works;
+	struct list_head		lock_list;
+
+	int				durable_timeout;
+
+	/* for SMB1 */
+	int				pid;
+
+	/* conflict lock fail count for SMB1 */
+	unsigned int			cflock_cnt;
+	/* last lock failure start offset for SMB1 */
+	unsigned long long		llock_fstart;
+
+	int				dirent_offset;
+
+	/* if ls is happening on directory, below is valid*/
+	struct ksmbd_readdir_data	readdir_data;
+	int				dot_dotdot[2];
+};
+
+static inline void set_ctx_actor(struct dir_context *ctx,
+				 filldir_t actor)
+{
+	ctx->actor = actor;
+}
+
+#define KSMBD_NR_OPEN_DEFAULT BITS_PER_LONG
+
+struct ksmbd_file_table {
+	rwlock_t		lock;
+	struct idr		*idr;
+};
+
+static inline bool has_file_id(u64 id)
+{
+	return id < KSMBD_NO_FID;
+}
+
+static inline bool ksmbd_stream_fd(struct ksmbd_file *fp)
+{
+	return fp->stream.name != NULL;
+}
+
+int ksmbd_init_file_table(struct ksmbd_file_table *ft);
+void ksmbd_destroy_file_table(struct ksmbd_file_table *ft);
+int ksmbd_close_fd(struct ksmbd_work *work, u64 id);
+struct ksmbd_file *ksmbd_lookup_fd_fast(struct ksmbd_work *work, u64 id);
+struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work, u64 id);
+struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
+					u64 pid);
+void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp);
+struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id);
+struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode);
+unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp);
+struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp);
+void ksmbd_close_tree_conn_fds(struct ksmbd_work *work);
+void ksmbd_close_session_fds(struct ksmbd_work *work);
+int ksmbd_close_inode_fds(struct ksmbd_work *work, struct inode *inode);
+int ksmbd_init_global_file_table(void);
+void ksmbd_free_global_file_table(void);
+int ksmbd_file_table_flush(struct ksmbd_work *work);
+void ksmbd_set_fd_limit(unsigned long limit);
+
+/*
+ * INODE hash
+ */
+int __init ksmbd_inode_hash_init(void);
+void ksmbd_release_inode_hash(void);
+
+enum KSMBD_INODE_STATUS {
+	KSMBD_INODE_STATUS_OK,
+	KSMBD_INODE_STATUS_UNKNOWN,
+	KSMBD_INODE_STATUS_PENDING_DELETE,
+};
+
+int ksmbd_query_inode_status(struct inode *inode);
+bool ksmbd_inode_pending_delete(struct ksmbd_file *fp);
+void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp);
+void ksmbd_clear_inode_pending_delete(struct ksmbd_file *fp);
+void ksmbd_fd_set_delete_on_close(struct ksmbd_file *fp,
+				  int file_info);
+int ksmbd_init_file_cache(void);
+void ksmbd_exit_file_cache(void);
+#endif /* __VFS_CACHE_H__ */
diff --git a/fs/ksmbd/xattr.h b/fs/ksmbd/xattr.h
new file mode 100644
index 000000000000..8857c01093d9
--- /dev/null
+++ b/fs/ksmbd/xattr.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2021 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __XATTR_H__
+#define __XATTR_H__
+
+/*
+ * These are on-disk structures to store additional metadata into xattr to
+ * reproduce windows filesystem semantics. And they are encoded with NDR to
+ * compatible with samba's xattr meta format. The compatibility with samba
+ * is important because it can lose the information(file attribute,
+ * creation time, acls) about the existing files when switching between
+ * ksmbd and samba.
+ */
+
+/*
+ * Dos attribute flags used for what variable is valid.
+ */
+enum {
+	XATTR_DOSINFO_ATTRIB		= 0x00000001,
+	XATTR_DOSINFO_EA_SIZE		= 0x00000002,
+	XATTR_DOSINFO_SIZE		= 0x00000004,
+	XATTR_DOSINFO_ALLOC_SIZE	= 0x00000008,
+	XATTR_DOSINFO_CREATE_TIME	= 0x00000010,
+	XATTR_DOSINFO_CHANGE_TIME	= 0x00000020,
+	XATTR_DOSINFO_ITIME		= 0x00000040
+};
+
+/*
+ * Dos attribute structure which is compatible with samba's one.
+ * Storing it into the xattr named "DOSATTRIB" separately from inode
+ * allows ksmbd to faithfully reproduce windows filesystem semantics
+ * on top of a POSIX filesystem.
+ */
+struct xattr_dos_attrib {
+	__u16	version;	/* version 3 or version 4 */
+	__u32	flags;		/* valid flags */
+	__u32	attr;		/* Dos attribute */
+	__u32	ea_size;	/* EA size */
+	__u64	size;
+	__u64	alloc_size;
+	__u64	create_time;	/* File creation time */
+	__u64	change_time;	/* File change time */
+	__u64	itime;		/* Invented/Initial time */
+};
+
+/*
+ * Enumeration is used for computing posix acl hash.
+ */
+enum {
+	SMB_ACL_TAG_INVALID = 0,
+	SMB_ACL_USER,
+	SMB_ACL_USER_OBJ,
+	SMB_ACL_GROUP,
+	SMB_ACL_GROUP_OBJ,
+	SMB_ACL_OTHER,
+	SMB_ACL_MASK
+};
+
+#define SMB_ACL_READ			4
+#define SMB_ACL_WRITE			2
+#define SMB_ACL_EXECUTE			1
+
+struct xattr_acl_entry {
+	int type;
+	uid_t uid;
+	gid_t gid;
+	mode_t perm;
+};
+
+/*
+ * xattr_smb_acl structure is used for computing posix acl hash.
+ */
+struct xattr_smb_acl {
+	int count;
+	int next;
+	struct xattr_acl_entry entries[0];
+};
+
+/* 64bytes hash in xattr_ntacl is computed with sha256 */
+#define XATTR_SD_HASH_TYPE_SHA256	0x1
+#define XATTR_SD_HASH_SIZE		64
+
+/*
+ * xattr_ntacl is used for storing ntacl and hashes.
+ * Hash is used for checking valid posix acl and ntacl in xattr.
+ */
+struct xattr_ntacl {
+	__u16	version; /* version 4*/
+	void	*sd_buf;
+	__u32	sd_size;
+	__u16	hash_type; /* hash type */
+	__u8	desc[10]; /* posix_acl description */
+	__u16	desc_len;
+	__u64	current_time;
+	__u8	hash[XATTR_SD_HASH_SIZE]; /* 64bytes hash for ntacl */
+	__u8	posix_acl_hash[XATTR_SD_HASH_SIZE]; /* 64bytes hash for posix acl */
+};
+
+/* DOS ATTRIBUITE XATTR PREFIX */
+#define DOS_ATTRIBUTE_PREFIX		"DOSATTRIB"
+#define DOS_ATTRIBUTE_PREFIX_LEN	(sizeof(DOS_ATTRIBUTE_PREFIX) - 1)
+#define XATTR_NAME_DOS_ATTRIBUTE	(XATTR_USER_PREFIX DOS_ATTRIBUTE_PREFIX)
+#define XATTR_NAME_DOS_ATTRIBUTE_LEN	\
+		(sizeof(XATTR_USER_PREFIX DOS_ATTRIBUTE_PREFIX) - 1)
+
+/* STREAM XATTR PREFIX */
+#define STREAM_PREFIX			"DosStream."
+#define STREAM_PREFIX_LEN		(sizeof(STREAM_PREFIX) - 1)
+#define XATTR_NAME_STREAM		(XATTR_USER_PREFIX STREAM_PREFIX)
+#define XATTR_NAME_STREAM_LEN		(sizeof(XATTR_NAME_STREAM) - 1)
+
+/* SECURITY DESCRIPTOR(NTACL) XATTR PREFIX */
+#define SD_PREFIX			"NTACL"
+#define SD_PREFIX_LEN	(sizeof(SD_PREFIX) - 1)
+#define XATTR_NAME_SD	(XATTR_SECURITY_PREFIX SD_PREFIX)
+#define XATTR_NAME_SD_LEN	\
+		(sizeof(XATTR_SECURITY_PREFIX SD_PREFIX) - 1)
+
+#endif /* __XATTR_H__ */
-- 
2.17.1

