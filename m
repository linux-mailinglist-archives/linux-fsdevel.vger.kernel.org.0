Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3608410685B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 09:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKVIxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 03:53:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46765 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726248AbfKVIxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574412811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETmztk1xpEDwQNeWi0jtGkHt/PmUQwJTqkKAhUf/IJc=;
        b=L0ximmI2aDzybylZ0DQhnQEL6s58qlkCjTls/xl8N/M5z6GgHq9TuXBp+okVPUc9Mb9Qnr
        j60b+u0PsKzhW/AxNYYFoLi52j7r3XsXjmqgIRo6iTXcYvpnUbJmfwrSmBQO3yIbVZBMjK
        Ivlhw/PB9pr8mmSk9tYlIzUbLnRq+mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-W_bG3UiOOIuoBnOddZ_V0w-1; Fri, 22 Nov 2019 03:53:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4E9B18557C9;
        Fri, 22 Nov 2019 08:53:26 +0000 (UTC)
Received: from orion.redhat.com (unknown [10.40.205.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04F89691A4;
        Fri, 22 Nov 2019 08:53:24 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, darrick.wong@oracle.com, sandeen@sandeen.net
Subject: [PATCH 1/5] fs: Enable bmap() function to properly return errors
Date:   Fri, 22 Nov 2019 09:53:16 +0100
Message-Id: <20191122085320.124560-2-cmaiolino@redhat.com>
In-Reply-To: <20191122085320.124560-1-cmaiolino@redhat.com>
References: <20191122085320.124560-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: W_bG3UiOOIuoBnOddZ_V0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By now, bmap() will either return the physical block number related to
the requested file offset or 0 in case of error or the requested offset
maps into a hole.
This patch makes the needed changes to enable bmap() to proper return
errors, using the return value as an error return, and now, a pointer
must be passed to bmap() to be filled with the mapped physical block.

It will change the behavior of bmap() on return:

- negative value in case of error
- zero on success or map fell into a hole

In case of a hole, the *block will be zero too

Since this is a prep patch, by now, the only error return is -EINVAL if
->bmap doesn't exist.

Changelog:

=09V6:
=09=09- Fix bmap() doc function
=09=09=09Reported-by: kbuild test robot <lkp@intel.com>
=09V5:
=09=09- Rebasing against 5.3 required changes to the f2fs
=09=09  check_swap_activate() function

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 drivers/md/md-bitmap.c | 16 ++++++++++------
 fs/f2fs/data.c         | 16 +++++++++++-----
 fs/inode.c             | 30 +++++++++++++++++-------------
 fs/jbd2/journal.c      | 22 +++++++++++++++-------
 include/linux/fs.h     |  2 +-
 mm/page_io.c           | 11 +++++++----
 6 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b092c7b5282f..bfb7fddd4f1b 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -364,7 +364,7 @@ static int read_page(struct file *file, unsigned long i=
ndex,
 =09int ret =3D 0;
 =09struct inode *inode =3D file_inode(file);
 =09struct buffer_head *bh;
-=09sector_t block;
+=09sector_t block, blk_cur;
=20
 =09pr_debug("read bitmap file (%dB @ %llu)\n", (int)PAGE_SIZE,
 =09=09 (unsigned long long)index << PAGE_SHIFT);
@@ -375,17 +375,21 @@ static int read_page(struct file *file, unsigned long=
 index,
 =09=09goto out;
 =09}
 =09attach_page_buffers(page, bh);
-=09block =3D index << (PAGE_SHIFT - inode->i_blkbits);
+=09blk_cur =3D index << (PAGE_SHIFT - inode->i_blkbits);
 =09while (bh) {
+=09=09block =3D blk_cur;
+
 =09=09if (count =3D=3D 0)
 =09=09=09bh->b_blocknr =3D 0;
 =09=09else {
-=09=09=09bh->b_blocknr =3D bmap(inode, block);
-=09=09=09if (bh->b_blocknr =3D=3D 0) {
-=09=09=09=09/* Cannot use this file! */
+=09=09=09ret =3D bmap(inode, &block);
+=09=09=09if (ret || !block) {
 =09=09=09=09ret =3D -EINVAL;
+=09=09=09=09bh->b_blocknr =3D 0;
 =09=09=09=09goto out;
 =09=09=09}
+
+=09=09=09bh->b_blocknr =3D block;
 =09=09=09bh->b_bdev =3D inode->i_sb->s_bdev;
 =09=09=09if (count < (1<<inode->i_blkbits))
 =09=09=09=09count =3D 0;
@@ -399,7 +403,7 @@ static int read_page(struct file *file, unsigned long i=
ndex,
 =09=09=09set_buffer_mapped(bh);
 =09=09=09submit_bh(REQ_OP_READ, 0, bh);
 =09=09}
-=09=09block++;
+=09=09blk_cur++;
 =09=09bh =3D bh->b_this_page;
 =09}
 =09page->index =3D index;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5755e897a5f0..f949d3590027 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3068,12 +3068,16 @@ static int check_swap_activate(struct file *swap_fi=
le, unsigned int max)
 =09while ((probe_block + blocks_per_page) <=3D last_block && page_no < max=
) {
 =09=09unsigned block_in_page;
 =09=09sector_t first_block;
+=09=09sector_t block =3D 0;
+=09=09int=09 err =3D 0;
=20
 =09=09cond_resched();
=20
-=09=09first_block =3D bmap(inode, probe_block);
-=09=09if (first_block =3D=3D 0)
+=09=09block =3D probe_block;
+=09=09err =3D bmap(inode, &block);
+=09=09if (err || !block)
 =09=09=09goto bad_bmap;
+=09=09first_block =3D block;
=20
 =09=09/*
 =09=09 * It must be PAGE_SIZE aligned on-disk
@@ -3085,11 +3089,13 @@ static int check_swap_activate(struct file *swap_fi=
le, unsigned int max)
=20
 =09=09for (block_in_page =3D 1; block_in_page < blocks_per_page;
 =09=09=09=09=09block_in_page++) {
-=09=09=09sector_t block;
=20
-=09=09=09block =3D bmap(inode, probe_block + block_in_page);
-=09=09=09if (block =3D=3D 0)
+=09=09=09block =3D probe_block + block_in_page;
+=09=09=09err =3D bmap(inode, &block);
+
+=09=09=09if (err || !block)
 =09=09=09=09goto bad_bmap;
+
 =09=09=09if (block !=3D first_block + block_in_page) {
 =09=09=09=09/* Discontiguity */
 =09=09=09=09probe_block++;
diff --git a/fs/inode.c b/fs/inode.c
index fef457a42882..0a20aaa572f2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1593,21 +1593,25 @@ EXPORT_SYMBOL(iput);
=20
 /**
  *=09bmap=09- find a block number in a file
- *=09@inode: inode of file
- *=09@block: block to find
- *
- *=09Returns the block number on the device holding the inode that
- *=09is the disk block number for the block of the file requested.
- *=09That is, asked for block 4 of inode 1 the function will return the
- *=09disk block relative to the disk start that holds that block of the
- *=09file.
+ *=09@inode:  inode owning the block number being requested
+ *=09@block: pointer containing the block to find
+ *
+ *=09Replaces the value in *block with the block number on the device hold=
ing
+ *=09corresponding to the requested block number in the file.
+ *=09That is, asked for block 4 of inode 1 the function will replace the
+ *=094 in *block, with disk block relative to the disk start that holds th=
at
+ *=09block of the file.
+ *
+ *=09Returns -EINVAL in case of error, 0 otherwise. If mapping falls into =
a
+ *=09hole, returns 0 and *block is also set to 0.
  */
-sector_t bmap(struct inode *inode, sector_t block)
+int bmap(struct inode *inode, sector_t *block)
 {
-=09sector_t res =3D 0;
-=09if (inode->i_mapping->a_ops->bmap)
-=09=09res =3D inode->i_mapping->a_ops->bmap(inode->i_mapping, block);
-=09return res;
+=09if (!inode->i_mapping->a_ops->bmap)
+=09=09return -EINVAL;
+
+=09*block =3D inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
+=09return 0;
 }
 EXPORT_SYMBOL(bmap);
=20
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1c58859aa592..5664101c73a8 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -795,18 +795,23 @@ int jbd2_journal_bmap(journal_t *journal, unsigned lo=
ng blocknr,
 {
 =09int err =3D 0;
 =09unsigned long long ret;
+=09sector_t block =3D 0;
=20
 =09if (journal->j_inode) {
-=09=09ret =3D bmap(journal->j_inode, blocknr);
-=09=09if (ret)
-=09=09=09*retp =3D ret;
-=09=09else {
+=09=09block =3D blocknr;
+=09=09ret =3D bmap(journal->j_inode, &block);
+
+=09=09if (ret || !block) {
 =09=09=09printk(KERN_ALERT "%s: journal block not found "
 =09=09=09=09=09"at offset %lu on %s\n",
 =09=09=09       __func__, blocknr, journal->j_devname);
 =09=09=09err =3D -EIO;
 =09=09=09__journal_abort_soft(journal, err);
+
+=09=09} else {
+=09=09=09*retp =3D block;
 =09=09}
+
 =09} else {
 =09=09*retp =3D blocknr; /* +journal->j_blk_offset */
 =09}
@@ -1232,11 +1237,14 @@ journal_t *jbd2_journal_init_dev(struct block_devic=
e *bdev,
 journal_t *jbd2_journal_init_inode(struct inode *inode)
 {
 =09journal_t *journal;
+=09sector_t blocknr;
 =09char *p;
-=09unsigned long long blocknr;
+=09int err =3D 0;
+
+=09blocknr =3D 0;
+=09err =3D bmap(inode, &blocknr);
=20
-=09blocknr =3D bmap(inode, 0);
-=09if (!blocknr) {
+=09if (err || !blocknr) {
 =09=09pr_err("%s: Cannot locate journal superblock\n",
 =09=09=09__func__);
 =09=09return NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..8b31075415ce 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2863,7 +2863,7 @@ static inline ssize_t generic_write_sync(struct kiocb=
 *iocb, ssize_t count)
 extern void emergency_sync(void);
 extern void emergency_remount(void);
 #ifdef CONFIG_BLOCK
-extern sector_t bmap(struct inode *, sector_t);
+extern int bmap(struct inode *, sector_t *);
 #endif
 extern int notify_change(struct dentry *, struct iattr *, struct inode **)=
;
 extern int inode_permission(struct inode *, int);
diff --git a/mm/page_io.c b/mm/page_io.c
index 60a66a58b9bf..be663b504c80 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -176,8 +176,9 @@ int generic_swapfile_activate(struct swap_info_struct *=
sis,
=20
 =09=09cond_resched();
=20
-=09=09first_block =3D bmap(inode, probe_block);
-=09=09if (first_block =3D=3D 0)
+=09=09first_block =3D probe_block;
+=09=09ret =3D bmap(inode, &first_block);
+=09=09if (ret || !first_block)
 =09=09=09goto bad_bmap;
=20
 =09=09/*
@@ -192,9 +193,11 @@ int generic_swapfile_activate(struct swap_info_struct =
*sis,
 =09=09=09=09=09block_in_page++) {
 =09=09=09sector_t block;
=20
-=09=09=09block =3D bmap(inode, probe_block + block_in_page);
-=09=09=09if (block =3D=3D 0)
+=09=09=09block =3D probe_block + block_in_page;
+=09=09=09ret =3D bmap(inode, &block);
+=09=09=09if (ret || !block)
 =09=09=09=09goto bad_bmap;
+
 =09=09=09if (block !=3D first_block + block_in_page) {
 =09=09=09=09/* Discontiguity */
 =09=09=09=09probe_block++;
--=20
2.23.0

