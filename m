Return-Path: <linux-fsdevel+bounces-9323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F186083FFAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59299B2122E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70AC53E32;
	Mon, 29 Jan 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="tJcaLeFF";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="kcu/vikB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743D53E02;
	Mon, 29 Jan 2024 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515687; cv=none; b=KXDAf09ivpm4ZgW08+QoGjs6cRkviqiYrM8uxQAax6EBaXz2J+KkqFhIHFQKUqw5IitYTgm3v1M+PskKtAVmawNlKFXkHA7DpypZbEzuq3E63QfHZCM2IkWCW3vS6VmIT5sw9jKW0ztaS9sexCuvdFxxOm0wRhkl7YphtAoTAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515687; c=relaxed/simple;
	bh=pNUWJLC16kaMVAE5WhZN3NaYZlEojCmbVSdRqnHrhnw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=HnERL2q6nms0vKjD0jVS+dnAAeKYPaU3SAqBW9XlWP5r8ViKq713ez3i0DeVJ4Yk3+3bGfIWulrxhuNVAFAOQ5j3YzWVRRFhNzbza+cOCYMr+WJnXZ/UsKfJnxAs8FfQKY+e+Ocq5qPngkc/6HXl/7mgGu2QpCUuYavjknzxs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=tJcaLeFF; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=kcu/vikB; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 83C70211A;
	Mon, 29 Jan 2024 08:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1706515271;
	bh=chi2nY9wvqimOanOPJ924vEM3xM63w6P1XRw2v6gYFk=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=tJcaLeFFp9u+SJjkx6v3cXKW00jKI2GE3PLAUnzWa7osSY3/61blJwoqDuCec29JW
	 fCfPd5/dSQWNFrnEX26qQ8jouwWLhd/QPuLtWj6deXl8g0cddxUzMAd/hWDfBGgp6N
	 nQSatgM03mfgrnxmKiy0VI6YbMyxLF8F9aYP2VU8=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CEF771D33;
	Mon, 29 Jan 2024 08:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1706515681;
	bh=chi2nY9wvqimOanOPJ924vEM3xM63w6P1XRw2v6gYFk=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=kcu/vikBsl5uPk/768daBudBH+s021A47Uz8SUBWuWSS9X4EJhQecPXwaK5tFJp40
	 0ST1HYQgl9yIgA0JI3HNAPHSO+VkQLU3M85+XgyBNJ7G44bf66baMNXYdZUfMFbtbX
	 duJlJ+Lnivnt0NlJdxIm8dBb2OVECOgZF1zWSTww=
Received: from [192.168.211.199] (192.168.211.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 29 Jan 2024 11:08:01 +0300
Message-ID: <5be49112-9f60-4091-97f8-b9a6d0aeee4c@paragon-software.com>
Date: Mon, 29 Jan 2024 11:08:01 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/5] fs/ntfs3: Use i_size_read and i_size_write
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
In-Reply-To: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  |  4 ++--
  fs/ntfs3/dir.c     |  2 +-
  fs/ntfs3/file.c    | 11 ++++++-----
  fs/ntfs3/frecord.c | 10 +++++-----
  fs/ntfs3/index.c   |  8 ++++----
  fs/ntfs3/inode.c   |  2 +-
  6 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 646e2dad1b75..7aadf5010999 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2084,7 +2084,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 
vbo, u64 bytes)

      /* Update inode size. */
      ni->i_valid = valid_size;
-    ni->vfs_inode.i_size = data_size;
+    i_size_write(&ni->vfs_inode, data_size);
      inode_set_bytes(&ni->vfs_inode, total_size);
      ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
      mark_inode_dirty(&ni->vfs_inode);
@@ -2499,7 +2499,7 @@ int attr_insert_range(struct ntfs_inode *ni, u64 
vbo, u64 bytes)
      mi_b->dirty = true;

  done:
-    ni->vfs_inode.i_size += bytes;
+    i_size_write(&ni->vfs_inode, ni->vfs_inode.i_size + bytes);
      ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
      mark_inode_dirty(&ni->vfs_inode);

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 9f6dd445eb04..effa6accf8a8 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -517,7 +517,7 @@ static int ntfs_dir_count(struct inode *dir, bool 
*is_empty, size_t *dirs,
      u32 e_size, off, end;
      size_t drs = 0, fles = 0, bit = 0;
      struct indx_node *node = NULL;
-    size_t max_indx = ni->vfs_inode.i_size >> ni->dir.index_bits;
+    size_t max_indx = i_size_read(&ni->vfs_inode) >> ni->dir.index_bits;

      if (is_empty)
          *is_empty = true;
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 07ed3d946e7c..b702543a8795 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -646,7 +646,7 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
              if (err)
                  goto out;
          } else if (new_size > i_size) {
-            inode->i_size = new_size;
+            i_size_write(inode, new_size);
          }
      }

@@ -696,7 +696,7 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct 
dentry *dentry,
              goto out;
          }
          inode_dio_wait(inode);
-        oldsize = inode->i_size;
+        oldsize = i_size_read(inode);
          newsize = attr->ia_size;

          if (newsize <= oldsize)
@@ -708,7 +708,7 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct 
dentry *dentry,
              goto out;

          ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
-        inode->i_size = newsize;
+        i_size_write(inode, newsize);
      }

      setattr_copy(idmap, inode, attr);
@@ -847,7 +847,7 @@ static ssize_t ntfs_compress_write(struct kiocb 
*iocb, struct iov_iter *from)
      size_t count = iov_iter_count(from);
      loff_t pos = iocb->ki_pos;
      struct inode *inode = file_inode(file);
-    loff_t i_size = inode->i_size;
+    loff_t i_size = i_size_read(inode);
      struct address_space *mapping = inode->i_mapping;
      struct ntfs_inode *ni = ntfs_i(inode);
      u64 valid = ni->i_valid;
@@ -1177,7 +1177,8 @@ static int ntfs_file_release(struct inode *inode, 
struct file *file)
          down_write(&ni->file.run_lock);

          err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run,
-                    inode->i_size, &ni->i_valid, false, NULL);
+                    i_size_read(inode), &ni->i_valid, false,
+                    NULL);

          up_write(&ni->file.run_lock);
          ni_unlock(ni);
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 2636ab7640ac..3b42938a9d3b 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2099,7 +2099,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct 
page *page)
      gfp_t gfp_mask;
      struct page *pg;

-    if (vbo >= ni->vfs_inode.i_size) {
+    if (vbo >= i_size_read(&ni->vfs_inode)) {
          SetPageUptodate(page);
          err = 0;
          goto out;
@@ -2173,7 +2173,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
  {
      struct ntfs_sb_info *sbi = ni->mi.sbi;
      struct inode *inode = &ni->vfs_inode;
-    loff_t i_size = inode->i_size;
+    loff_t i_size = i_size_read(inode);
      struct address_space *mapping = inode->i_mapping;
      gfp_t gfp_mask = mapping_gfp_mask(mapping);
      struct page **pages = NULL;
@@ -2457,6 +2457,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 
frame_vbo, struct page **pages,
      struct ATTR_LIST_ENTRY *le = NULL;
      struct runs_tree *run = &ni->file.run;
      u64 valid_size = ni->i_valid;
+    loff_t i_size = i_size_read(&ni->vfs_inode);
      u64 vbo_disk;
      size_t unc_size;
      u32 frame_size, i, npages_disk, ondisk_size;
@@ -2548,7 +2549,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 
frame_vbo, struct page **pages,
              }
          }

-        frames = (ni->vfs_inode.i_size - 1) >> frame_bits;
+        frames = (i_size - 1) >> frame_bits;

          err = attr_wof_frame_info(ni, attr, run, frame64, frames,
                        frame_bits, &ondisk_size, &vbo_data);
@@ -2556,8 +2557,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 
frame_vbo, struct page **pages,
              goto out2;

          if (frame64 == frames) {
-            unc_size = 1 + ((ni->vfs_inode.i_size - 1) &
-                    (frame_size - 1));
+            unc_size = 1 + ((i_size - 1) & (frame_size - 1));
              ondisk_size = attr_size(attr) - vbo_data;
          } else {
              unc_size = frame_size;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index cf92b2433f7a..daabaad63aaf 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1462,7 +1462,7 @@ static int indx_create_allocate(struct ntfs_index 
*indx, struct ntfs_inode *ni,
          goto out2;

      if (in->name == I30_NAME) {
-        ni->vfs_inode.i_size = data_size;
+        i_size_write(&ni->vfs_inode, data_size);
          inode_set_bytes(&ni->vfs_inode, alloc_size);
      }

@@ -1544,7 +1544,7 @@ static int indx_add_allocate(struct ntfs_index 
*indx, struct ntfs_inode *ni,
      }

      if (in->name == I30_NAME)
-        ni->vfs_inode.i_size = data_size;
+        i_size_write(&ni->vfs_inode, data_size);

      *vbn = bit << indx->idx2vbn_bits;

@@ -2090,7 +2090,7 @@ static int indx_shrink(struct ntfs_index *indx, 
struct ntfs_inode *ni,
          return err;

      if (in->name == I30_NAME)
-        ni->vfs_inode.i_size = new_data;
+        i_size_write(&ni->vfs_inode, new_data);

      bpb = bitmap_size(bit);
      if (bpb * 8 == nbits)
@@ -2576,7 +2576,7 @@ int indx_delete_entry(struct ntfs_index *indx, 
struct ntfs_inode *ni,
          err = attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
                      &indx->alloc_run, 0, NULL, false, NULL);
          if (in->name == I30_NAME)
-            ni->vfs_inode.i_size = 0;
+            i_size_write(&ni->vfs_inode, 0);

          err = ni_remove_attr(ni, ATTR_ALLOC, in->name, in->name_len,
                       false, NULL);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 85452a6b1d40..eb7a8c9fba01 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -985,7 +985,7 @@ int ntfs_write_end(struct file *file, struct 
address_space *mapping, loff_t pos,
          }

          if (pos + err > inode->i_size) {
-            inode->i_size = pos + err;
+            i_size_write(inode, pos + err);
              dirty = true;
          }

-- 
2.34.1


