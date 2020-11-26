Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532AF2C5E32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 00:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391990AbgKZXdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 18:33:43 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:55378 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391953AbgKZXdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:33:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id EC98D181C88E5;
        Fri, 27 Nov 2020 00:33:39 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NUbqF_zWrq22; Fri, 27 Nov 2020 00:33:39 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QEwXlqxG2Uc3; Fri, 27 Nov 2020 00:33:39 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/7] fuse: Add MUSE specific defines FUSE interface
Date:   Fri, 27 Nov 2020 00:32:58 +0100
Message-Id: <20201126233300.10714-6-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201126233300.10714-1-richard@nod.at>
References: <20201126233300.10714-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Raise the FUSE API minor version to 33 and add all
MUSE specific operations and data structures.

MUSE_INIT: Initialize a new connection and install the MTD
MUSE_ERASE: Erase a block
MUSE_READ: Read a page
MUSE_WRITE: Write a page
MUSE_MARKBAD: Mark a block as bad
MUSE_ISBAD: Check whether a block is bad
MUSE_SYNC: Flush all cached data

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/uapi/linux/fuse.h | 73 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 7233502ea991..2f7cbe5ce434 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -175,6 +175,10 @@
  *
  *  7.32
  *  - add flags to fuse_attr, add FUSE_ATTR_SUBMOUNT, add FUSE_SUBMOUNTS
+ *
+ *  7.33
+ *  - add support for MUSE: MUSE_INIT, MUSE_ERASE, MUSE_READ, MUSE_WRITE=
,
+ *    MUSE_MARKBAD, MUSE_ISBAD and MUSE_SYNC
  */
=20
 #ifndef _LINUX_FUSE_H
@@ -210,7 +214,7 @@
 #define FUSE_KERNEL_VERSION 7
=20
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 32
+#define FUSE_KERNEL_MINOR_VERSION 33
=20
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -483,6 +487,15 @@ enum fuse_opcode {
 	/* CUSE specific operations */
 	CUSE_INIT		=3D 4096,
=20
+	/* MUSE specific operations */
+	MUSE_INIT		=3D 8192,
+	MUSE_ERASE		=3D 8193,
+	MUSE_READ		=3D 8194,
+	MUSE_WRITE		=3D 8195,
+	MUSE_MARKBAD		=3D 8196,
+	MUSE_ISBAD		=3D 8197,
+	MUSE_SYNC		=3D 8198,
+
 	/* Reserved opcodes: helpful to detect structure endian-ness */
 	CUSE_INIT_BSWAP_RESERVED	=3D 1048576,	/* CUSE_INIT << 8 */
 	FUSE_INIT_BSWAP_RESERVED	=3D 436207616,	/* FUSE_INIT << 24 */
@@ -936,4 +949,62 @@ struct fuse_removemapping_one {
 #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
 		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
=20
+#define MUSE_INIT_INFO_MAX 4096
+
+struct muse_init_in {
+	uint32_t	fuse_major;
+	uint32_t	fuse_minor;
+};
+
+struct muse_init_out {
+	uint32_t	fuse_major;
+	uint32_t	fuse_minor;
+	uint32_t	max_read;
+	uint32_t	max_write;
+};
+
+struct muse_erase_in {
+	uint64_t	addr;
+	uint64_t	len;
+};
+
+struct muse_read_in {
+	uint64_t	dataaddr;
+	uint64_t	datalen;
+	uint32_t	flags;
+	uint32_t	padding;
+};
+
+struct muse_read_out {
+	uint64_t	datalen;
+	uint32_t	soft_error;
+	uint32_t	padding;
+};
+
+struct muse_write_in {
+	uint64_t	dataaddr;
+	uint64_t	datalen;
+	uint32_t	flags;
+	uint32_t	padding;
+};
+
+struct muse_write_out {
+	uint64_t	datalen;
+	uint32_t	soft_error;
+	uint32_t	padding;
+};
+
+struct muse_markbad_in {
+	uint64_t	addr;
+};
+
+struct muse_isbad_in {
+	uint64_t	addr;
+};
+
+struct muse_isbad_out {
+	uint32_t	result;
+	uint32_t	padding;
+};
+
 #endif /* _LINUX_FUSE_H */
--=20
2.26.2

