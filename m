Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFBF64BB18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiLMRbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbiLMRap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:30:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34F223395
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670952591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7AcOPhjBNP3YYrMH1MpqCjdI1yvhV6rSsFzQUZOjVA4=;
        b=HCAdOtqgvacJlmz5RDVuH8rOFKWP1xAll4afd7NCuXeGvMlDGvd3avZLoLaK6Xs7NPYHp3
        VIm0y/3Qh6Ob2LgHzSU1b8/54D+LC7K19VQJx/FW4l5AWvZFnNT360gGErq/fFnDwMIEtd
        Bv0ULfkxfD4lF6IbTuARoJMdTTcz3CA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-489-eI0QdseXPMS2UBZDTiEfEA-1; Tue, 13 Dec 2022 12:29:49 -0500
X-MC-Unique: eI0QdseXPMS2UBZDTiEfEA-1
Received: by mail-ed1-f69.google.com with SMTP id y20-20020a056402271400b0046c9a6ec30fso7686591edd.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AcOPhjBNP3YYrMH1MpqCjdI1yvhV6rSsFzQUZOjVA4=;
        b=Ublz6+sGO7kmMAwerQLQbbuftYF5f3ogycbgo7MyxlxIR+JjIJwxBJhk7ZmyEm7M/D
         dJvuP+IrVXY8oJKafRZ+wD52aDRUZAR9jGUAAFHtDalepT4kM1C4gAzsUVbEeCUDvZ4D
         HYfQs1Zeyd/gAy0aGctrT+lOihyC9BNochGqqpZlu/0bM43MlCZAzbcIlBKoDZmnAbEJ
         m344zBfFwijIFDYY6waFKpUMqVig4JvEc0Zu+xPy8NWBA82B+8Qvatd5QI9mldRx3sHF
         Gr4PBj3or7bMdXooSvuuza5rBnBB+pxg6aa98WFXJP8iKmId7prqA0/iNrzrGCJCmg+6
         Y++w==
X-Gm-Message-State: ANoB5pnLYL9LsTp6RJbKOQ8A1vI+iwqC4CBQk+uj2KhUzogLSk+P+fok
        Z2WpGm9qOLREtqFGD2U0OORsDpNVxu+G898NxzIM4Ki3FFYR4zY4l0ao5Q5F4qiSfNh+evzVgQV
        5hQsmw+RkIeXTDb/DHTqXzYep
X-Received: by 2002:a05:6402:294d:b0:45c:cd16:aeae with SMTP id ed13-20020a056402294d00b0045ccd16aeaemr17634083edb.13.1670952588698;
        Tue, 13 Dec 2022 09:29:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7g+f81AoDPxBBSymiyRRy+EhAfrPjPqsbZz/ctE8vnernSk7jZGWtN7Vj8WarlzeMC5phV4A==
X-Received: by 2002:a05:6402:294d:b0:45c:cd16:aeae with SMTP id ed13-20020a056402294d00b0045ccd16aeaemr17634066edb.13.1670952588390;
        Tue, 13 Dec 2022 09:29:48 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b0047025bf942bsm1204187edb.16.2022.12.13.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:29:47 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [RFC PATCH 10/11] xfs: add fs-verity support
Date:   Tue, 13 Dec 2022 18:29:34 +0100
Message-Id: <20221213172935.680971-11-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221213172935.680971-1-aalbersh@redhat.com>
References: <20221213172935.680971-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add integration with fs-verity. The XFS store fs-verity metadata in
the extended attributes. The metadata consist of verity descriptor
and Merkle tree pages.

The descriptor is stored under "verity_descriptor" extended
attribute. The Merkle tree pages are stored under binary indexes.

When fs-verity is enabled on an inode, the XFS_IVERITY flag is set
meaning that the Merkle tree is being build. Then, pagecache is
flushed and large folios are disabled as these aren't yet supported
by fs-verity. This is done in xfs_begin_enable_verity() to make sure
that fs-verity operations on the inode don't populate cache with
large folios during a tree build. The initialization ends with
storing of verity descriptor and setting inode on-disk flag
(XFS_DIFLAG2_VERITY).

Also add check that block size == PAGE_SIZE as fs-verity doesn't
support different sizes yet.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/Makefile          |   1 +
 fs/xfs/libxfs/xfs_attr.c |   8 ++
 fs/xfs/xfs_inode.h       |   1 +
 fs/xfs/xfs_super.c       |  10 ++
 fs/xfs/xfs_verity.c      | 203 +++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_verity.h      |  19 ++++
 6 files changed, 242 insertions(+)
 create mode 100644 fs/xfs/xfs_verity.c
 create mode 100644 fs/xfs/xfs_verity.h

diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 42d0496fdad7d..5afa8ae5b3b7f 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -131,6 +131,7 @@ xfs-$(CONFIG_XFS_POSIX_ACL)	+= xfs_acl.o
 xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
 xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
 xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
+xfs-$(CONFIG_FS_VERITY)		+= xfs_verity.o
 
 # notify failure
 ifeq ($(CONFIG_MEMORY_FAILURE),y)
diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 57080ea4c869b..42013fc99b76a 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -26,6 +26,7 @@
 #include "xfs_trace.h"
 #include "xfs_attr_item.h"
 #include "xfs_xattr.h"
+#include "xfs_verity.h"
 
 struct kmem_cache		*xfs_attr_intent_cache;
 
@@ -1632,6 +1633,13 @@ xfs_attr_namecheck(
 		return xfs_verify_pptr(mp, (struct xfs_parent_name_rec *)name);
 	}
 
+	if (flags & XFS_ATTR_VERITY) {
+		if (length != sizeof(__be64) &&
+				length != XFS_VERITY_DESCRIPTOR_NAME_LEN)
+			return false;
+		return true;
+	}
+
 	return xfs_str_attr_namecheck(name, length);
 }
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 5735de32beebd..070631adac572 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -325,6 +325,7 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
  * plain old IRECLAIMABLE inode.
  */
 #define XFS_INACTIVATING	(1 << 13)
+#define XFS_IVERITY		(1 << 14) /* merkle tree is in progress */
 
 /* All inode state flags related to inode reclaim. */
 #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 50c2c819ba940..a3c89d2c06a8a 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -41,6 +41,7 @@
 #include "xfs_attr_item.h"
 #include "xfs_xattr.h"
 #include "xfs_iunlink_item.h"
+#include "xfs_verity.h"
 
 #include <linux/magic.h>
 #include <linux/fs_context.h>
@@ -1469,6 +1470,9 @@ xfs_fs_fill_super(
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
 #endif
 	sb->s_op = &xfs_super_operations;
+#ifdef CONFIG_FS_VERITY
+	sb->s_vop = &xfs_verity_ops;
+#endif
 
 	/*
 	 * Delay mount work if the debug hook is set. This is debug
@@ -1669,6 +1673,12 @@ xfs_fs_fill_super(
 		xfs_alert(mp,
 	"EXPERIMENTAL parent pointer feature enabled. Use at your own risk!");
 
+	if (xfs_has_verity(mp) && mp->m_super->s_blocksize != PAGE_SIZE) {
+		xfs_alert(mp,
+			"Cannot use fs-verity with block size != PAGE_SIZE");
+		goto out_filestream_unmount;
+	}
+
 	error = xfs_mountfs(mp);
 	if (error)
 		goto out_filestream_unmount;
diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
new file mode 100644
index 0000000000000..112a72d0b0ca7
--- /dev/null
+++ b/fs/xfs/xfs_verity.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Red Hat, Inc.
+ */
+#include "xfs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_da_format.h"
+#include "xfs_da_btree.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_inode.h"
+#include "xfs_attr.h"
+#include "xfs_verity.h"
+#include "xfs_bmap_util.h"
+#include "xfs_log_format.h"
+#include "xfs_trans.h"
+
+static int
+xfs_get_verity_descriptor(
+	struct inode		*inode,
+	void			*buf,
+	size_t			buf_size)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	int			error = 0;
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
+		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
+		.valuelen	= buf_size,
+	};
+
+	error = xfs_attr_get(&args);
+	if (error)
+		return error;
+
+	if (buf_size == 0)
+		return args.valuelen;
+
+	if (args.valuelen > buf_size) {
+		kmem_free(args.value);
+		return -ERANGE;
+	}
+
+	memcpy(buf, args.value, buf_size);
+
+	kmem_free(args.value);
+	return args.valuelen;
+}
+
+static int
+xfs_begin_enable_verity(
+	struct file	    *filp)
+{
+	struct inode	    *inode = file_inode(filp);
+	struct xfs_inode    *ip = XFS_I(inode);
+	int		    error = 0;
+
+	if (IS_DAX(inode))
+		return -EINVAL;
+
+	if (xfs_iflags_test(ip, XFS_IVERITY))
+		return -EBUSY;
+	xfs_iflags_set(ip, XFS_IVERITY);
+
+	/*
+	 * As fs-verity doesn't support multi-page folios yet, flush everything
+	 * from page cache and disable it
+	 */
+	filemap_invalidate_lock(inode->i_mapping);
+
+	inode_dio_wait(inode);
+	error = xfs_flush_unmap_range(ip, 0, XFS_ISIZE(ip));
+	if (error)
+		goto out;
+	mapping_clear_large_folios(inode->i_mapping);
+
+out:
+	filemap_invalidate_unlock(inode->i_mapping);
+	if (error)
+		xfs_iflags_clear(ip, XFS_IVERITY);
+	return error;
+}
+
+static int
+xfs_end_enable_verity(
+	struct file		*filp,
+	const void		*desc,
+	size_t			desc_size,
+	u64			merkle_tree_size)
+{
+	struct inode		*inode = file_inode(filp);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.whichfork	= XFS_ATTR_FORK,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.attr_flags	= XATTR_CREATE,
+		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
+		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
+		.value		= (void *)desc,
+		.valuelen	= desc_size,
+	};
+	int			error = 0;
+
+	/* fs-verity failed, just cleanup */
+	if (desc == NULL) {
+		mapping_set_large_folios(inode->i_mapping);
+		goto out;
+	}
+
+	error = xfs_attr_set(&args);
+	if (error)
+		goto out;
+
+	/* Set fsverity inode flag */
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_ichange, 0, 0, 0, &tp);
+	if (error)
+		goto out;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
+
+	ip->i_diflags2 |= XFS_DIFLAG2_VERITY;
+	inode->i_flags |= S_VERITY;
+
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+	error = xfs_trans_commit(tp);
+
+out:
+	if (error)
+		mapping_set_large_folios(inode->i_mapping);
+
+	xfs_iflags_clear(ip, XFS_IVERITY);
+	return error;
+}
+
+static struct page *
+xfs_read_merkle_tree_page(
+	struct inode		*inode,
+	pgoff_t			index,
+	unsigned long		num_ra_pages)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct page		*page;
+	__be64			name = cpu_to_be64(index);
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.name		= (const uint8_t *)&name,
+		.namelen	= sizeof(__be64),
+		.valuelen	= PAGE_SIZE,
+	};
+	int			error = 0;
+
+	error = xfs_attr_get(&args);
+	if (error)
+		return ERR_PTR(-EFAULT);
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(page_address(page), args.value, args.valuelen);
+
+	kmem_free(args.value);
+	return page;
+}
+
+static int
+xfs_write_merkle_tree_block(
+	struct inode		*inode,
+	const void		*buf,
+	u64			index,
+	int			log_blocksize)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	__be64			name = cpu_to_be64(index);
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.whichfork	= XFS_ATTR_FORK,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.attr_flags	= XATTR_CREATE,
+		.name		= (const uint8_t *)&name,
+		.namelen	= sizeof(__be64),
+		.value		= (void *)buf,
+		.valuelen	= 1 << log_blocksize,
+	};
+
+	return xfs_attr_set(&args);
+}
+
+const struct fsverity_operations xfs_verity_ops = {
+	.begin_enable_verity = &xfs_begin_enable_verity,
+	.end_enable_verity = &xfs_end_enable_verity,
+	.get_verity_descriptor = &xfs_get_verity_descriptor,
+	.read_merkle_tree_page = &xfs_read_merkle_tree_page,
+	.write_merkle_tree_block = &xfs_write_merkle_tree_block,
+};
diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
new file mode 100644
index 0000000000000..ae5d87ca32a86
--- /dev/null
+++ b/fs/xfs/xfs_verity.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Red Hat, Inc.
+ */
+#ifndef __XFS_VERITY_H__
+#define __XFS_VERITY_H__
+
+#include <linux/fsverity.h>
+
+#define XFS_VERITY_DESCRIPTOR_NAME "verity_descriptor"
+#define XFS_VERITY_DESCRIPTOR_NAME_LEN 17
+
+#ifdef CONFIG_FS_VERITY
+extern const struct fsverity_operations xfs_verity_ops;
+#else
+#define xfs_verity_ops NULL
+#endif	/* CONFIG_FS_VERITY */
+
+#endif	/* __XFS_VERITY_H__ */
-- 
2.31.1

