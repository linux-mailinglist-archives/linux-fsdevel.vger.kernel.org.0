Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B91A743A87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjF3LMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 07:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjF3LL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:11:59 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Jun 2023 04:11:51 PDT
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C174204
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 04:11:50 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-9uE2y5jYOzqoK4RnKsOZFA-1; Fri, 30 Jun 2023 07:10:42 -0400
X-MC-Unique: 9uE2y5jYOzqoK4RnKsOZFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9289310504B0;
        Fri, 30 Jun 2023 11:10:41 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.45.226.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E03F200A3AD;
        Fri, 30 Jun 2023 11:10:40 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] fs: Add kfuncs to handle idmapped mounts
Date:   Fri, 30 Jun 2023 13:08:25 +0200
Message-Id: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the introduction of idmapped mounts, file handling has become
somewhat more complicated. If the inode has been found through an
idmapped mount the idmap of the vfsmount must be used to get proper
i_uid / i_gid. This is important, for example, to correctly take into
account idmapped files when caching, LSM or for an audit.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/mnt_idmapping.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 4905665c47d0..ba98ce26b883 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -6,6 +6,7 @@
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
 #include <linux/user_namespace.h>
+#include <linux/bpf.h>
 
 #include "internal.h"
 
@@ -271,3 +272,71 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
 		kfree(idmap);
 	}
 }
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+/**
+ * bpf_is_idmapped_mnt - check whether a mount is idmapped
+ * @mnt: the mount to check
+ *
+ * Return: true if mount is mapped, false if not.
+ */
+__bpf_kfunc bool bpf_is_idmapped_mnt(struct vfsmount *mnt)
+{
+	return is_idmapped_mnt(mnt);
+}
+
+/**
+ * bpf_file_mnt_idmap - get file idmapping
+ * @file: the file from which to get mapping
+ *
+ * Return: The idmap for the @file.
+ */
+__bpf_kfunc struct mnt_idmap *bpf_file_mnt_idmap(struct file *file)
+{
+	return file_mnt_idmap(file);
+}
+
+/**
+ * bpf_inode_into_vfs_ids - map an inode's i_uid and i_gid down according to an idmapping
+ * @idmap: idmap of the mount the inode was found from
+ * @inode: inode to map
+ *
+ * The inode's i_uid and i_gid mapped down according to @idmap. If the inode's
+ * i_uid or i_gid has no mapping INVALID_VFSUID or INVALID_VFSGID is returned in
+ * the corresponding position.
+ *
+ * Return: A 64-bit integer containing the current GID and UID, and created as
+ * such: *gid* **<< 32 \|** *uid*.
+ */
+__bpf_kfunc uint64_t bpf_inode_into_vfs_ids(struct mnt_idmap *idmap,
+		const struct inode *inode)
+{
+	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
+	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
+
+	return (u64) __vfsgid_val(vfsgid) << 32 |
+		     __vfsuid_val(vfsuid);
+}
+
+__diag_pop();
+
+BTF_SET8_START(idmap_btf_ids)
+BTF_ID_FLAGS(func, bpf_is_idmapped_mnt)
+BTF_ID_FLAGS(func, bpf_file_mnt_idmap)
+BTF_ID_FLAGS(func, bpf_inode_into_vfs_ids)
+BTF_SET8_END(idmap_btf_ids)
+
+static const struct btf_kfunc_id_set idmap_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &idmap_btf_ids,
+};
+
+static int __init bpf_idmap_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &idmap_kfunc_set);
+}
+
+late_initcall(bpf_idmap_kfunc_init);
-- 
2.33.8

