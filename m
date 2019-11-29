Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B8710D6DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 15:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfK2OVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 09:21:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50387 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726968AbfK2OVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575037261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VP6e4fS82ZVWbpnJBKYprOYp5qn0BT0NQcR/ZfMdaJk=;
        b=cuMz57nipn5hctiIwFXgt+6Ih4qLKpXBpXNvIRwuErHjfyuVqwREkVzPQ0sl9cctHhNt7v
        21jdeHoSBPrIoYjekV4WikcPxmIJ0/3IAtL1rxpgIJ+EFh4tdU72zwfmfBOBaGqiRpWD92
        20MDfvdcms4ZlL9biXBZALKunlpup1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-LJWOf1WKPIOJgC45aX2Gvw-1; Fri, 29 Nov 2019 09:21:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D44C8017CC;
        Fri, 29 Nov 2019 14:20:56 +0000 (UTC)
Received: from max.com (ovpn-204-19.brq.redhat.com [10.40.204.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2885110013A1;
        Fri, 29 Nov 2019 14:20:47 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fs: Fix page_mkwrite off-by-one errors
Date:   Fri, 29 Nov 2019 15:20:45 +0100
Message-Id: <20191129142045.7215-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: LJWOf1WKPIOJgC45aX2Gvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The check in block_page_mkwrite meant to determine whether an offset is
within the inode size is off by one.  This bug has spread to
iomap_page_mkwrite and to several filesystems (ubifs, ext4, f2fs, ceph).
To fix that, introduce a new page_mkwrite_check_truncate helper that
checks for truncate and computes the bytes in the page up to EOF, and
use that helper in the above mentioned filesystems and in btrfs.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

---

This patch has a trivial conflict with commit "iomap: Fix overflow in
iomap_page_mkwrite" in Darrick's iomap pull request for 5.5:

  https://lore.kernel.org/lkml/20191125190907.GN6219@magnolia/
---
 fs/btrfs/inode.c        | 15 ++++-----------
 fs/buffer.c             | 16 +++-------------
 fs/ceph/addr.c          |  2 +-
 fs/ext4/inode.c         | 14 ++++----------
 fs/f2fs/file.c          | 19 +++++++------------
 fs/iomap/buffered-io.c  | 17 ++++-------------
 fs/ubifs/file.c         |  3 +--
 include/linux/pagemap.h | 24 ++++++++++++++++++++++++
 8 files changed, 48 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 015910079e73..019948101bc2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8990,13 +8990,11 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 =09ret =3D VM_FAULT_NOPAGE; /* make the VM retry the fault */
 again:
 =09lock_page(page);
-=09size =3D i_size_read(inode);
=20
-=09if ((page->mapping !=3D inode->i_mapping) ||
-=09    (page_start >=3D size)) {
-=09=09/* page got truncated out from underneath us */
+=09ret2 =3D page_mkwrite_check_truncate(page, inode);
+=09if (ret2 < 0)
 =09=09goto out_unlock;
-=09}
+=09zero_start =3D ret2;
 =09wait_on_page_writeback(page);
=20
 =09lock_extent_bits(io_tree, page_start, page_end, &cached_state);
@@ -9017,6 +9015,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 =09=09goto again;
 =09}
=20
+=09size =3D i_size_read(inode);
 =09if (page->index =3D=3D ((size - 1) >> PAGE_SHIFT)) {
 =09=09reserved_space =3D round_up(size - page_start,
 =09=09=09=09=09  fs_info->sectorsize);
@@ -9049,12 +9048,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 =09}
 =09ret2 =3D 0;
=20
-=09/* page is wholly or partially inside EOF */
-=09if (page_start + PAGE_SIZE > size)
-=09=09zero_start =3D offset_in_page(size);
-=09else
-=09=09zero_start =3D PAGE_SIZE;
-
 =09if (zero_start !=3D PAGE_SIZE) {
 =09=09kaddr =3D kmap(page);
 =09=09memset(kaddr + zero_start, 0, PAGE_SIZE - zero_start);
diff --git a/fs/buffer.c b/fs/buffer.c
index 86a38b979323..b162ec65910e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2459,23 +2459,13 @@ int block_page_mkwrite(struct vm_area_struct *vma, =
struct vm_fault *vmf,
 =09struct page *page =3D vmf->page;
 =09struct inode *inode =3D file_inode(vma->vm_file);
 =09unsigned long end;
-=09loff_t size;
 =09int ret;
=20
 =09lock_page(page);
-=09size =3D i_size_read(inode);
-=09if ((page->mapping !=3D inode->i_mapping) ||
-=09    (page_offset(page) > size)) {
-=09=09/* We overload EFAULT to mean page got truncated */
-=09=09ret =3D -EFAULT;
+=09ret =3D page_mkwrite_check_truncate(page, inode);
+=09if (ret < 0)
 =09=09goto out_unlock;
-=09}
-
-=09/* page is wholly or partially inside EOF */
-=09if (((page->index + 1) << PAGE_SHIFT) > size)
-=09=09end =3D size & ~PAGE_MASK;
-=09else
-=09=09end =3D PAGE_SIZE;
+=09end =3D ret;
=20
 =09ret =3D __block_write_begin(page, 0, end, get_block);
 =09if (!ret)
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7ab616601141..ef958aa4adb4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1575,7 +1575,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *=
vmf)
 =09do {
 =09=09lock_page(page);
=20
-=09=09if ((off > size) || (page->mapping !=3D inode->i_mapping)) {
+=09=09if (page_mkwrite_check_truncate(page, inode) < 0) {
 =09=09=09unlock_page(page);
 =09=09=09ret =3D VM_FAULT_NOPAGE;
 =09=09=09break;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 516faa280ced..23bf095e0b29 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6186,7 +6186,6 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 {
 =09struct vm_area_struct *vma =3D vmf->vma;
 =09struct page *page =3D vmf->page;
-=09loff_t size;
 =09unsigned long len;
 =09int err;
 =09vm_fault_t ret;
@@ -6222,18 +6221,13 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 =09}
=20
 =09lock_page(page);
-=09size =3D i_size_read(inode);
-=09/* Page got truncated from under us? */
-=09if (page->mapping !=3D mapping || page_offset(page) > size) {
+=09err =3D page_mkwrite_check_truncate(page, inode);
+=09if (err < 0) {
 =09=09unlock_page(page);
-=09=09ret =3D VM_FAULT_NOPAGE;
-=09=09goto out;
+=09=09goto out_ret;
 =09}
+=09len =3D err;
=20
-=09if (page->index =3D=3D size >> PAGE_SHIFT)
-=09=09len =3D size & ~PAGE_MASK;
-=09else
-=09=09len =3D PAGE_SIZE;
 =09/*
 =09 * Return if we have all the buffers mapped. This avoids the need to do
 =09 * journal_start/journal_stop which can block and take a long time
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 29bc0a542759..973f731e7af4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -51,7 +51,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *v=
mf)
 =09struct inode *inode =3D file_inode(vmf->vma->vm_file);
 =09struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
 =09struct dnode_of_data dn =3D { .node_changed =3D false };
-=09int err;
+=09int offset, err;
=20
 =09if (unlikely(f2fs_cp_error(sbi))) {
 =09=09err =3D -EIO;
@@ -70,13 +70,14 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault =
*vmf)
 =09file_update_time(vmf->vma->vm_file);
 =09down_read(&F2FS_I(inode)->i_mmap_sem);
 =09lock_page(page);
-=09if (unlikely(page->mapping !=3D inode->i_mapping ||
-=09=09=09page_offset(page) > i_size_read(inode) ||
-=09=09=09!PageUptodate(page))) {
+=09err =3D -EFAULT;
+=09if (likely(PageUptodate(page)))
+=09=09err =3D page_mkwrite_check_truncate(page, inode);
+=09if (unlikely(err < 0)) {
 =09=09unlock_page(page);
-=09=09err =3D -EFAULT;
 =09=09goto out_sem;
 =09}
+=09offset =3D err;
=20
 =09/* block allocation */
 =09__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
@@ -101,14 +102,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault=
 *vmf)
 =09if (PageMappedToDisk(page))
 =09=09goto out_sem;
=20
-=09/* page is wholly or partially inside EOF */
-=09if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
-=09=09=09=09=09=09i_size_read(inode)) {
-=09=09loff_t offset;
-
-=09=09offset =3D i_size_read(inode) & ~PAGE_MASK;
+=09if (offset !=3D PAGE_SIZE)
 =09=09zero_user_segment(page, offset, PAGE_SIZE);
-=09}
 =09set_page_dirty(page);
 =09if (!PageUptodate(page))
 =09=09SetPageUptodate(page);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e25901ae3ff4..663b5071b154 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1035,23 +1035,14 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,=
 const struct iomap_ops *ops)
 =09struct page *page =3D vmf->page;
 =09struct inode *inode =3D file_inode(vmf->vma->vm_file);
 =09unsigned long length;
-=09loff_t offset, size;
+=09loff_t offset;
 =09ssize_t ret;
=20
 =09lock_page(page);
-=09size =3D i_size_read(inode);
-=09if ((page->mapping !=3D inode->i_mapping) ||
-=09    (page_offset(page) > size)) {
-=09=09/* We overload EFAULT to mean page got truncated */
-=09=09ret =3D -EFAULT;
+=09ret =3D page_mkwrite_check_truncate(page, inode);
+=09if (ret < 0)
 =09=09goto out_unlock;
-=09}
-
-=09/* page is wholly or partially inside EOF */
-=09if (((page->index + 1) << PAGE_SHIFT) > size)
-=09=09length =3D offset_in_page(size);
-=09else
-=09=09length =3D PAGE_SIZE;
+=09length =3D ret;
=20
 =09offset =3D page_offset(page);
 =09while (length > 0) {
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index cd52585c8f4f..91f7a1f2db0d 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1563,8 +1563,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fau=
lt *vmf)
 =09}
=20
 =09lock_page(page);
-=09if (unlikely(page->mapping !=3D inode->i_mapping ||
-=09=09     page_offset(page) > i_size_read(inode))) {
+=09if (unlikely(page_mkwrite_check_truncate(page, inode) < 0)) {
 =09=09/* Page got truncated out from underneath us */
 =09=09goto sigbus;
 =09}
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 37a4d9e32cd3..5a3f860470ad 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -636,4 +636,28 @@ static inline unsigned long dir_pages(struct inode *in=
ode)
 =09=09=09       PAGE_SHIFT;
 }
=20
+/**
+ * page_mkwrite_check_truncate - check if page was truncated
+ * @page: the page to check
+ * @inode: the inode to check the page against
+ *
+ * Returns the number of bytes in the page up to EOF,
+ * or -EFAULT if the page was truncated.
+ */
+static inline int page_mkwrite_check_truncate(struct page *page,
+=09=09=09=09=09      struct inode *inode)
+{
+=09loff_t size =3D i_size_read(inode);
+=09pgoff_t end_index =3D (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+=09if (page->mapping !=3D inode->i_mapping ||
+=09    page->index >=3D end_index)
+=09=09return -EFAULT;
+=09if (page->index !=3D size >> PAGE_SHIFT) {
+=09=09/* page is wholly inside EOF */
+=09=09return PAGE_SIZE;
+=09}
+=09return offset_in_page(size);
+}
+
 #endif /* _LINUX_PAGEMAP_H */
--=20
2.20.1

