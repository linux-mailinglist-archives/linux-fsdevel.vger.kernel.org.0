Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887762B9496
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 15:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgKSO1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 09:27:05 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:58532 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgKSO1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:27:04 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Nov 2020 09:27:03 EST
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 898CF181C8900;
        Thu, 19 Nov 2020 15:18:26 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7yQ7veX_WR98; Thu, 19 Nov 2020 15:18:26 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Dx73T873WR7e; Thu, 19 Nov 2020 15:18:26 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/5] fuse: Rename FUSE_DIO_CUSE
Date:   Thu, 19 Nov 2020 15:16:55 +0100
Message-Id: <20201119141659.26176-2-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201119141659.26176-1-richard@nod.at>
References: <20201119141659.26176-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MUSE needs to use this flag too, rename it to
FUSE_DIO_NOFS to denote that the DIO operation has no FUSE backed
inode.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/fuse/cuse.c   | 4 ++--
 fs/fuse/file.c   | 4 ++--
 fs/fuse/fuse_i.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 45082269e698..55744430b0f0 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -96,7 +96,7 @@ static ssize_t cuse_read_iter(struct kiocb *kiocb, stru=
ct iov_iter *to)
 	struct fuse_io_priv io =3D FUSE_IO_PRIV_SYNC(kiocb);
 	loff_t pos =3D 0;
=20
-	return fuse_direct_io(&io, to, &pos, FUSE_DIO_CUSE);
+	return fuse_direct_io(&io, to, &pos, FUSE_DIO_NOFS);
 }
=20
 static ssize_t cuse_write_iter(struct kiocb *kiocb, struct iov_iter *fro=
m)
@@ -108,7 +108,7 @@ static ssize_t cuse_write_iter(struct kiocb *kiocb, s=
truct iov_iter *from)
 	 * responsible for locking and sanity checks.
 	 */
 	return fuse_direct_io(&io, from, &pos,
-			      FUSE_DIO_WRITE | FUSE_DIO_CUSE);
+			      FUSE_DIO_WRITE | FUSE_DIO_NOFS);
 }
=20
 static int cuse_open(struct inode *inode, struct file *file)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c03034e8c152..697e79032c73 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1409,7 +1409,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, str=
uct iov_iter *iter,
 		       loff_t *ppos, int flags)
 {
 	int write =3D flags & FUSE_DIO_WRITE;
-	int cuse =3D flags & FUSE_DIO_CUSE;
+	int nofs =3D flags & FUSE_DIO_NOFS;
 	struct file *file =3D io->iocb->ki_filp;
 	struct inode *inode =3D file->f_mapping->host;
 	struct fuse_file *ff =3D file->private_data;
@@ -1430,7 +1430,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, str=
uct iov_iter *iter,
 		return -ENOMEM;
=20
 	ia->io =3D io;
-	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
+	if (!nofs && fuse_range_is_writeback(inode, idx_from, idx_to)) {
 		if (!write)
 			inode_lock(inode);
 		fuse_sync_writes(inode);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d51598017d13..637caddff2a8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1140,8 +1140,8 @@ int fuse_do_open(struct fuse_mount *fm, u64 nodeid,=
 struct file *file,
 /** If set, it is WRITE; otherwise - READ */
 #define FUSE_DIO_WRITE (1 << 0)
=20
-/** CUSE pass fuse_direct_io() a file which f_mapping->host is not from =
FUSE */
-#define FUSE_DIO_CUSE  (1 << 1)
+/** CUSE and MUSE pass fuse_direct_io() a file which f_mapping->host is =
not from FUSE */
+#define FUSE_DIO_NOFS  (1 << 1)
=20
 ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		       loff_t *ppos, int flags);
--=20
2.26.2

