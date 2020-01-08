Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19413439E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgAHNPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 08:15:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57500 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727706AbgAHNPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578489350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zrYLmKUociWJ3jPrLjftFdn8ngUJ4L3V4X3Hni10q1k=;
        b=dqniSras8Ek+n5NU5vUlHlKvV0B284dNARzST4CirwodPrfWa22mt4S+UzpzL3XBgbX2jR
        LxL3yrX1uG6F7o1HpgqwDE9kW1plnHkIO/ntnrrIbFP+6ciqe4QuePoMyXRYv4KccYxxIE
        rdk46HCVlNU7BGjyA7EwtRIspKXmY/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-1-RAODjPP9OiVhdT2bU7Iw-1; Wed, 08 Jan 2020 08:15:49 -0500
X-MC-Unique: 1-RAODjPP9OiVhdT2bU7Iw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45A82801E76;
        Wed,  8 Jan 2020 13:15:45 +0000 (UTC)
Received: from max.com (ovpn-204-63.brq.redhat.com [10.40.204.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 972FA7FB55;
        Wed,  8 Jan 2020 13:15:35 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
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
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jan Kara <jack@suse.cz>, YueHaibing <yuehaibing@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4] fs: Fix page_mkwrite off-by-one errors
Date:   Wed,  8 Jan 2020 14:15:28 +0100
Message-Id: <20200108131528.4279-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

here's an updated version with the latest feedback incorporated.  Hope
you find that useful.

As far as the f2fs merge conflict goes, I've been told by Linus not to
resolve those kinds of conflicts but to point them out when sending the
merge request.  So this shouldn't be a big deal.

Changes:

* Turn page_mkwrite_check_truncate into a non-inline function.
* Get rid of now-unused mapping variable in ext4_page_mkwrite.
* In btrfs_page_mkwrite, don't ignore the return value of
  block_page_mkwrite_return (no change in behavior).
* Clean up the f2fs_vm_page_mkwrite changes as suggested by
  Jaegeuk Kim.

Thanks,
Andreas

--

The check in block_page_mkwrite that is meant to determine whether an
offset is within the inode size is off by one.  This bug has been copied
into iomap_page_mkwrite and several filesystems (ubifs, ext4, f2fs,
ceph).

Fix that by introducing a new page_mkwrite_check_truncate helper that
checks for truncate and computes the bytes in the page up to EOF.  Use
the helper in the above mentioned filesystems.

In addition, use the new helper in btrfs as well.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Acked-by: David Sterba <dsterba@suse.com> (btrfs)
Acked-by: Richard Weinberger <richard@nod.at> (ubifs)
Acked-by: Theodore Ts'o <tytso@mit.edu> (ext4)
Acked-by: Chao Yu <yuchao0@huawei.com> (f2fs)
---
 fs/btrfs/inode.c        | 16 +++++-----------
 fs/buffer.c             | 16 +++-------------
 fs/ceph/addr.c          |  2 +-
 fs/ext4/inode.c         | 15 ++++-----------
 fs/f2fs/file.c          | 19 +++++++------------
 fs/iomap/buffered-io.c  | 18 +++++-------------
 fs/ubifs/file.c         |  3 +--
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 28 ++++++++++++++++++++++++++++
 9 files changed, 56 insertions(+), 63 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e3c76645cad7..23e6f614e000 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9011,16 +9011,15 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vm=
f)
 		goto out_noreserve;
 	}
=20
-	ret =3D VM_FAULT_NOPAGE; /* make the VM retry the fault */
 again:
 	lock_page(page);
-	size =3D i_size_read(inode);
=20
-	if ((page->mapping !=3D inode->i_mapping) ||
-	    (page_start >=3D size)) {
-		/* page got truncated out from underneath us */
+	ret2 =3D page_mkwrite_check_truncate(page, inode);
+	if (ret2 < 0) {
+		ret =3D block_page_mkwrite_return(ret2);
 		goto out_unlock;
 	}
+	zero_start =3D ret2;
 	wait_on_page_writeback(page);
=20
 	lock_extent_bits(io_tree, page_start, page_end, &cached_state);
@@ -9041,6 +9040,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		goto again;
 	}
=20
+	size =3D i_size_read(inode);
 	if (page->index =3D=3D ((size - 1) >> PAGE_SHIFT)) {
 		reserved_space =3D round_up(size - page_start,
 					  fs_info->sectorsize);
@@ -9073,12 +9073,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf=
)
 	}
 	ret2 =3D 0;
=20
-	/* page is wholly or partially inside EOF */
-	if (page_start + PAGE_SIZE > size)
-		zero_start =3D offset_in_page(size);
-	else
-		zero_start =3D PAGE_SIZE;
-
 	if (zero_start !=3D PAGE_SIZE) {
 		kaddr =3D kmap(page);
 		memset(kaddr + zero_start, 0, PAGE_SIZE - zero_start);
diff --git a/fs/buffer.c b/fs/buffer.c
index d8c7242426bb..53aabde57ca7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2499,23 +2499,13 @@ int block_page_mkwrite(struct vm_area_struct *vma=
, struct vm_fault *vmf,
 	struct page *page =3D vmf->page;
 	struct inode *inode =3D file_inode(vma->vm_file);
 	unsigned long end;
-	loff_t size;
 	int ret;
=20
 	lock_page(page);
-	size =3D i_size_read(inode);
-	if ((page->mapping !=3D inode->i_mapping) ||
-	    (page_offset(page) > size)) {
-		/* We overload EFAULT to mean page got truncated */
-		ret =3D -EFAULT;
+	ret =3D page_mkwrite_check_truncate(page, inode);
+	if (ret < 0)
 		goto out_unlock;
-	}
-
-	/* page is wholly or partially inside EOF */
-	if (((page->index + 1) << PAGE_SHIFT) > size)
-		end =3D size & ~PAGE_MASK;
-	else
-		end =3D PAGE_SIZE;
+	end =3D ret;
=20
 	ret =3D __block_write_begin(page, 0, end, get_block);
 	if (!ret)
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7ab616601141..ef958aa4adb4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1575,7 +1575,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault=
 *vmf)
 	do {
 		lock_page(page);
=20
-		if ((off > size) || (page->mapping !=3D inode->i_mapping)) {
+		if (page_mkwrite_check_truncate(page, inode) < 0) {
 			unlock_page(page);
 			ret =3D VM_FAULT_NOPAGE;
 			break;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 629a25d999f0..3244803df30a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5871,13 +5871,11 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf=
)
 {
 	struct vm_area_struct *vma =3D vmf->vma;
 	struct page *page =3D vmf->page;
-	loff_t size;
 	unsigned long len;
 	int err;
 	vm_fault_t ret;
 	struct file *file =3D vma->vm_file;
 	struct inode *inode =3D file_inode(file);
-	struct address_space *mapping =3D inode->i_mapping;
 	handle_t *handle;
 	get_block_t *get_block;
 	int retries =3D 0;
@@ -5907,18 +5905,13 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf=
)
 	}
=20
 	lock_page(page);
-	size =3D i_size_read(inode);
-	/* Page got truncated from under us? */
-	if (page->mapping !=3D mapping || page_offset(page) > size) {
+	err =3D page_mkwrite_check_truncate(page, inode);
+	if (err < 0) {
 		unlock_page(page);
-		ret =3D VM_FAULT_NOPAGE;
-		goto out;
+		goto out_ret;
 	}
+	len =3D err;
=20
-	if (page->index =3D=3D size >> PAGE_SHIFT)
-		len =3D size & ~PAGE_MASK;
-	else
-		len =3D PAGE_SIZE;
 	/*
 	 * Return if we have all the buffers mapped. This avoids the need to do
 	 * journal_start/journal_stop which can block and take a long time
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 85af112e868d..c2d919210a26 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -51,7 +51,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault =
*vmf)
 	struct inode *inode =3D file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
 	struct dnode_of_data dn =3D { .node_changed =3D false };
-	int err;
+	int offset, err;
=20
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err =3D -EIO;
@@ -70,11 +70,12 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_faul=
t *vmf)
 	file_update_time(vmf->vma->vm_file);
 	down_read(&F2FS_I(inode)->i_mmap_sem);
 	lock_page(page);
-	if (unlikely(page->mapping !=3D inode->i_mapping ||
-			page_offset(page) > i_size_read(inode) ||
-			!PageUptodate(page))) {
+	offset =3D -EFAULT;
+	if (likely(PageUptodate(page)))
+		offset =3D page_mkwrite_check_truncate(page, inode);
+	if (unlikely(offset < 0)) {
 		unlock_page(page);
-		err =3D -EFAULT;
+		err =3D offset;
 		goto out_sem;
 	}
=20
@@ -101,14 +102,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fau=
lt *vmf)
 	if (PageMappedToDisk(page))
 		goto out_sem;
=20
-	/* page is wholly or partially inside EOF */
-	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
-						i_size_read(inode)) {
-		loff_t offset;
-
-		offset =3D i_size_read(inode) & ~PAGE_MASK;
+	if (offset !=3D PAGE_SIZE)
 		zero_user_segment(page, offset, PAGE_SIZE);
-	}
 	set_page_dirty(page);
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 828444e14d09..7c84c4c027c4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1077,24 +1077,16 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vm=
f, const struct iomap_ops *ops)
 	struct page *page =3D vmf->page;
 	struct inode *inode =3D file_inode(vmf->vma->vm_file);
 	unsigned long length;
-	loff_t offset, size;
+	loff_t offset;
 	ssize_t ret;
=20
 	lock_page(page);
-	size =3D i_size_read(inode);
-	offset =3D page_offset(page);
-	if (page->mapping !=3D inode->i_mapping || offset > size) {
-		/* We overload EFAULT to mean page got truncated */
-		ret =3D -EFAULT;
+	ret =3D page_mkwrite_check_truncate(page, inode);
+	if (ret < 0)
 		goto out_unlock;
-	}
-
-	/* page is wholly or partially inside EOF */
-	if (offset > size - PAGE_SIZE)
-		length =3D offset_in_page(size);
-	else
-		length =3D PAGE_SIZE;
+	length =3D ret;
=20
+	offset =3D page_offset(page);
 	while (length > 0) {
 		ret =3D iomap_apply(inode, offset, length,
 				IOMAP_WRITE | IOMAP_FAULT, ops, page,
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index cd52585c8f4f..91f7a1f2db0d 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1563,8 +1563,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_f=
ault *vmf)
 	}
=20
 	lock_page(page);
-	if (unlikely(page->mapping !=3D inode->i_mapping ||
-		     page_offset(page) > i_size_read(inode))) {
+	if (unlikely(page_mkwrite_check_truncate(page, inode) < 0)) {
 		/* Page got truncated out from underneath us */
 		goto sigbus;
 	}
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 37a4d9e32cd3..6c9c5b88924d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -636,4 +636,6 @@ static inline unsigned long dir_pages(struct inode *i=
node)
 			       PAGE_SHIFT;
 }
=20
+int page_mkwrite_check_truncate(struct page *page, struct inode *inode);
+
 #endif /* _LINUX_PAGEMAP_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index bf6aa30be58d..d3e2766216e3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2700,6 +2700,34 @@ const struct vm_operations_struct generic_file_vm_=
ops =3D {
 	.page_mkwrite	=3D filemap_page_mkwrite,
 };
=20
+/**
+ * page_mkwrite_check_truncate - check if page was truncated
+ * @page: the page to check
+ * @inode: the inode to check the page against
+ *
+ * Returns the number of bytes in the page up to EOF,
+ * or -EFAULT if the page was truncated.
+ */
+int page_mkwrite_check_truncate(struct page *page, struct inode *inode)
+{
+	loff_t size =3D i_size_read(inode);
+	pgoff_t index =3D size >> PAGE_SHIFT;
+	int offset =3D offset_in_page(size);
+
+	if (page->mapping !=3D inode->i_mapping)
+		return -EFAULT;
+
+	/* page is wholly inside EOF */
+	if (page->index < index)
+		return PAGE_SIZE;
+	/* page is wholly past EOF */
+	if (page->index > index || !offset)
+		return -EFAULT;
+	/* page is partially inside EOF */
+	return offset;
+}
+EXPORT_SYMBOL(page_mkwrite_check_truncate);
+
 /* This is used for a general mmap of a disk file */
=20
 int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
--=20
2.20.1

