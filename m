Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E9A2C5E38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 00:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392001AbgKZXdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 18:33:54 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:55308 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391954AbgKZXdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:33:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id DBD311816C728;
        Fri, 27 Nov 2020 00:33:38 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1vN-nVJd0zxn; Fri, 27 Nov 2020 00:33:38 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vmeUVo1kcicr; Fri, 27 Nov 2020 00:33:38 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/7] fuse: Export IO helpers
Date:   Fri, 27 Nov 2020 00:32:55 +0100
Message-Id: <20201126233300.10714-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201126233300.10714-1-richard@nod.at>
References: <20201126233300.10714-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MUSE will use this functions in its IO path,
so export them.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/fuse/file.c   | 16 +++-------------
 fs/fuse/fuse_i.h | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c03034e8c152..ed91ca8b1203 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -20,8 +20,8 @@
 #include <linux/uio.h>
 #include <linux/fs.h>
=20
-static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
-				      struct fuse_page_desc **desc)
+struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
+			       struct fuse_page_desc **desc)
 {
 	struct page **pages;
=20
@@ -31,6 +31,7 @@ static struct page **fuse_pages_alloc(unsigned int npag=
es, gfp_t flags,
=20
 	return pages;
 }
+EXPORT_SYMBOL_GPL(fuse_pages_alloc);
=20
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid, struct file=
 *file,
 			  int opcode, struct fuse_open_out *outargp)
@@ -1338,17 +1339,6 @@ static inline void fuse_page_descs_length_init(str=
uct fuse_page_desc *descs,
 		descs[i].length =3D PAGE_SIZE - descs[i].offset;
 }
=20
-static inline unsigned long fuse_get_user_addr(const struct iov_iter *ii=
)
-{
-	return (unsigned long)ii->iov->iov_base + ii->iov_offset;
-}
-
-static inline size_t fuse_get_frag_size(const struct iov_iter *ii,
-					size_t max_size)
-{
-	return min(iov_iter_single_seg_count(ii), max_size);
-}
-
 static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_it=
er *ii,
 			       size_t *nbytesp, int write,
 			       unsigned int max_pages)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d51598017d13..d23954908610 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -31,6 +31,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/refcount.h>
 #include <linux/user_namespace.h>
+#include <linux/uio.h>
=20
 /** Default max number of pages that can be used in a single read reques=
t */
 #define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
@@ -858,6 +859,17 @@ static inline u64 fuse_get_attr_version(struct fuse_=
conn *fc)
 	return atomic64_read(&fc->attr_version);
 }
=20
+static inline unsigned long fuse_get_user_addr(const struct iov_iter *ii=
)
+{
+	return (unsigned long)ii->iov->iov_base + ii->iov_offset;
+}
+
+static inline size_t fuse_get_frag_size(const struct iov_iter *ii,
+					size_t max_size)
+{
+	return min(iov_iter_single_seg_count(ii), max_size);
+}
+
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
=20
@@ -1210,4 +1222,8 @@ void fuse_dax_inode_cleanup(struct inode *inode);
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_ali=
gnment);
 void fuse_dax_cancel_work(struct fuse_conn *fc);
=20
+/* file.c */
+struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
+			       struct fuse_page_desc **desc);
+
 #endif /* _FS_FUSE_I_H */
--=20
2.26.2

