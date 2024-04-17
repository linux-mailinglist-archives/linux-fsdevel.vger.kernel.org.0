Return-Path: <linux-fsdevel+bounces-17140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FBC8A83D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD39C28029E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD09EDC;
	Wed, 17 Apr 2024 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="c9rld15O";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ajzIORTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7613C9BF;
	Wed, 17 Apr 2024 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359311; cv=none; b=FFd5dmusEBexO7jQG64/AY4wd8botLR/P7cVSb5b6Oruy0GXyzthrVKuVrLjQYu6Y3pqsU76PCno8wGBh0E4tfVjudehxYD9OP27Ky8j+sKa57PQJGyznvt7GCGpCJs1VtUZe1EJ7g5JkX7VWK+qP0jIXLXYMWQv/IdOj1oPMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359311; c=relaxed/simple;
	bh=8lhml+YZgdjn8NhCBVBuvir1Lph3FMmzF6dbSgoTgss=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BK5cnDEdMebMqkCxt1hi8b7zv4EuTlbm9lx3oc2mgNAp1kD/3YVSvofRQmZg19yKtonvkC37vtuB1HfbrEa5ipEvdooYw4tUGoDbWI24cMuiXbQUfPIQz5r3wDVYvjQxgpxr1Yr1JO0cUxEmQ0/hh4pblQAAt3/ui6tc7GTjoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=c9rld15O; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ajzIORTs; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 219912126;
	Wed, 17 Apr 2024 13:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713358857;
	bh=prgkscqEDLQIeu/yy6QwD13KMz4blk3DXnk7Gem4noY=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=c9rld15O0zHZUUGxuKxM0t1kmvjmqY4rRlwvalNxKTGbsow0UKEtLGmm2sfudolIs
	 HFu5G+h7qRIi/cDx2+24gAz+uGWq2ng3O4kYcO8FjrKA0SKnx19EeYYq2jBjScBIBn
	 oEXHiqfbklD32UDiGOau6WM26LzYQXDQSHNxbpL0=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 138AB35D;
	Wed, 17 Apr 2024 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713359306;
	bh=prgkscqEDLQIeu/yy6QwD13KMz4blk3DXnk7Gem4noY=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=ajzIORTsFNjLVBZjpm9z0L7PWxTDZFVnIkONSEV13XxtlnyMT2DdFCeZJUdOcGFe3
	 7LNXEEszrbs5pdseE/pHmJJXViqJ8bFzqRVKNLQIUBGMnCiFkKl4ZVrRsP6wEhVBXS
	 GoLX9PUSfPx4GpUKo0TmiPSFAO/Pp6AERY4t41VM=
Received: from [192.168.211.39] (192.168.211.39) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Apr 2024 16:08:25 +0300
Message-ID: <a3158bb9-4ef6-482f-ad1c-b251a93f661a@paragon-software.com>
Date: Wed, 17 Apr 2024 16:08:25 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 09/11] fs/ntfs3: Optimize to store sorted attribute definition
 table
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Language: en-US
In-Reply-To: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

0x18 bytes instead of 0xa0

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c  | 60 ++++++++++++++++++++++++++++-
  fs/ntfs3/inode.c   | 30 +++++++--------
  fs/ntfs3/ntfs.h    |  4 --
  fs/ntfs3/ntfs_fs.h | 40 ++++++++++---------
  fs/ntfs3/super.c   | 95 +++++++++++++++-------------------------------
  fs/ntfs3/xattr.c   |  6 +--
  6 files changed, 126 insertions(+), 109 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index ae2ef5c11868..f9c60f3cadaf 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2698,4 +2698,62 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 
*label, int len)
  out:
      __putname(uni);
      return err;
-}
\ No newline at end of file
+}
+
+/*
+ * Check $AttrDef content and store sorted small $AttrDef entries
+ */
+int ntfs_check_attr_def(struct ntfs_sb_info *sbi,
+            const struct ATTR_DEF_ENTRY *raw, u32 bytes)
+{
+    const struct ATTR_DEF_ENTRY *de_s;
+    struct ATTR_DEF_ENTRY_SMALL *de_d;
+    u32 i, j;
+    u32 max_attr_type;
+    u32 n = (bytes / sizeof(*raw)) * sizeof(*raw);
+
+    for (i = 0, max_attr_type = 0, de_s = raw; i < n; i++, de_s++) {
+        u64 sz;
+        u32 attr_type = le32_to_cpu(de_s->type);
+
+        if (!attr_type)
+            break;
+
+        if ((attr_type & 0xf) || (!i && ATTR_STD != de_s->type) ||
+            (i && le32_to_cpu(de_s[-1].type) >= attr_type)) {
+            return -EINVAL;
+        }
+
+        max_attr_type = attr_type;
+
+        sz = le64_to_cpu(de_s->max_sz);
+        if (de_s->type == ATTR_REPARSE)
+            sbi->attrdef.rp_max_size = sz;
+        else if (de_s->type == ATTR_EA)
+            sbi->attrdef.ea_max_size = sz;
+        else if (de_s->type == ATTR_LABEL)
+            sbi->attrdef.label_max_size = sz;
+    }
+
+    /* Last known attribute type is 0x100. */
+    if (!max_attr_type || max_attr_type > 0x200)
+        return -EINVAL;
+
+    n = max_attr_type >> 4;
+    sbi->attrdef.table = kcalloc(n, sizeof(*de_d), GFP_KERNEL);
+    if (!sbi->attrdef.table)
+        return -ENOMEM;
+
+    for (j = 0, de_s = raw; j < i; j++, de_s++) {
+        u32 idx = (le32_to_cpu(de_s->type) >> 4) - 1;
+        de_d = sbi->attrdef.table + idx;
+
+        de_d->type = de_s->type;
+        de_d->flags = de_s->flags;
+        de_d->min_sz = le64_to_cpu(de_s->min_sz);
+        de_d->max_sz = le64_to_cpu(de_s->max_sz);
+    }
+    sbi->attrdef.entries = n;
+
+    return 0;
+}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 94177c1dd818..ae4465bf099f 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -18,7 +18,7 @@
  #include "ntfs_fs.h"

  /*
- * ntfs_read_mft - Read record and parses MFT.
+ * ntfs_read_mft - Read record and parse MFT.
   */
  static struct inode *ntfs_read_mft(struct inode *inode,
                     const struct cpu_str *name,
@@ -1090,29 +1090,27 @@ int ntfs_flush_inodes(struct super_block *sb, 
struct inode *i1,
      return ret;
  }

-int inode_write_data(struct inode *inode, const void *data, size_t bytes)
+/*
+ * Helper function to read file.
+ */
+int inode_read_data(struct inode *inode, void *data, size_t bytes)
  {
      pgoff_t idx;
+    struct address_space *mapping = inode->i_mapping;

-    /* Write non resident data. */
      for (idx = 0; bytes; idx++) {
          size_t op = bytes > PAGE_SIZE ? PAGE_SIZE : bytes;
-        struct page *page = ntfs_map_page(inode->i_mapping, idx);
+        struct page *page = read_mapping_page(mapping, idx, NULL);
+        void *kaddr;

          if (IS_ERR(page))
              return PTR_ERR(page);

-        lock_page(page);
-        WARN_ON(!PageUptodate(page));
-        ClearPageUptodate(page);
-
-        memcpy(page_address(page), data, op);
-
-        flush_dcache_page(page);
-        SetPageUptodate(page);
-        unlock_page(page);
+        kaddr = kmap_atomic(page);
+        memcpy(data, kaddr, op);
+        kunmap_atomic(kaddr);

-        ntfs_unmap_page(page);
+        put_page(page);

          bytes -= op;
          data = Add2Ptr(data, PAGE_SIZE);
@@ -1160,7 +1158,7 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info 
*sbi, const char *symname,
      /* err = the length of unicode name of symlink. */
      *nsize = ntfs_reparse_bytes(err);

-    if (*nsize > sbi->reparse.max_size) {
+    if (*nsize > sbi->attrdef.rp_max_size) {
          err = -EFBIG;
          goto out;
      }
@@ -1954,7 +1952,7 @@ static noinline int ntfs_readlink_hlp(const struct 
dentry *link_de,
          rp = NULL;
      }

-    if (size > sbi->reparse.max_size || size <= sizeof(u32))
+    if (size > sbi->attrdef.rp_max_size || size <= sizeof(u32))
          goto out;

      if (!rp) {
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 3d6143c7abc0..1dd03ba1dc93 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -817,7 +817,6 @@ struct VOLUME_INFO {

  #define SIZEOF_ATTRIBUTE_VOLUME_INFO 0xc

-#define NTFS_LABEL_MAX_LENGTH        (0x100 / sizeof(short))
  #define NTFS_ATTR_INDEXABLE        cpu_to_le32(0x00000002)
  #define NTFS_ATTR_DUPALLOWED        cpu_to_le32(0x00000004)
  #define NTFS_ATTR_MUST_BE_INDEXED    cpu_to_le32(0x00000010)
@@ -1002,9 +1001,6 @@ struct REPARSE_POINT {

  static_assert(sizeof(struct REPARSE_POINT) == 0x18);

-/* Maximum allowed size of the reparse data. */
-#define MAXIMUM_REPARSE_DATA_BUFFER_SIZE    (16 * 1024)
-
  /*
   * The value of the following constant needs to satisfy the following
   * conditions:
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 00dec0ec5648..1d4fb6f87dea 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -201,6 +201,15 @@ struct ntfs_index {
      u8 type; // index_mutex_classed
  };

+/* NOT ondisk!. Just a small copy of $AttrDef file entry. */
+struct ATTR_DEF_ENTRY_SMALL {
+    enum ATTR_TYPE type;
+    __le32 flags;
+    u64 min_sz;
+    u64 max_sz;
+};
+static_assert(sizeof(struct ATTR_DEF_ENTRY_SMALL) == 0x18);
+
  /* Minimum MFT zone. */
  #define NTFS_MIN_MFT_ZONE 100
  /* Step to increase the MFT. */
@@ -242,9 +251,13 @@ struct ntfs_sb_info {
      CLST reparse_no;
      CLST usn_jrnl_no;

-    struct ATTR_DEF_ENTRY *def_table; // Attribute definition table.
-    u32 def_entries;
-    u32 ea_max_size;
+    struct {
+        u64 rp_max_size; // 16K
+        u32 entries;
+        u32 ea_max_size;
+        u32 label_max_size;
+        struct ATTR_DEF_ENTRY_SMALL *table; // 'entries'.
+    } attrdef;

      struct MFT_REC *new_rec;

@@ -296,7 +309,6 @@ struct ntfs_sb_info {
      struct {
          struct ntfs_index index_r;
          struct ntfs_inode *ni;
-        u64 max_size; // 16K
      } reparse;

      struct {
@@ -658,6 +670,8 @@ int run_deallocate(struct ntfs_sb_info *sbi, const 
struct runs_tree *run,
             bool trim);
  bool valid_windows_name(struct ntfs_sb_info *sbi, const struct le_str 
*name);
  int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len);
+int ntfs_check_attr_def(struct ntfs_sb_info *sbi,
+            const struct ATTR_DEF_ENTRY *raw, u32 bytes);

  /* Globals from index.c */
  int indx_used_bit(struct ntfs_index *indx, struct ntfs_inode *ni, 
size_t *bit);
@@ -714,7 +728,7 @@ int ntfs3_write_inode(struct inode *inode, struct 
writeback_control *wbc);
  int ntfs_sync_inode(struct inode *inode);
  int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
                struct inode *i2);
-int inode_write_data(struct inode *inode, const void *data, size_t bytes);
+int inode_read_data(struct inode *inode, void *data, size_t bytes);
  int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
                struct dentry *dentry, const struct cpu_str *uni,
                umode_t mode, dev_t dev, const char *symname, u32 size,
@@ -908,22 +922,6 @@ static inline bool ntfs_is_meta_file(struct 
ntfs_sb_info *sbi, CLST rno)
             rno == sbi->usn_jrnl_no;
  }

-static inline void ntfs_unmap_page(struct page *page)
-{
-    kunmap(page);
-    put_page(page);
-}
-
-static inline struct page *ntfs_map_page(struct address_space *mapping,
-                     unsigned long index)
-{
-    struct page *page = read_mapping_page(mapping, index, NULL);
-
-    if (!IS_ERR(page))
-        kmap(page);
-    return page;
-}
-
  static inline size_t wnd_zone_bit(const struct wnd_bitmap *wnd)
  {
      return wnd->zone_bit;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index ac4722011140..8beefbca5769 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -624,7 +624,7 @@ static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
  {
      kfree(sbi->new_rec);
      kvfree(ntfs_put_shared(sbi->upcase));
-    kvfree(sbi->def_table);
+    kfree(sbi->attrdef.table);
      kfree(sbi->compress.lznt);
  #ifdef CONFIG_NTFS3_LZX_XPRESS
      xpress_free_decompressor(sbi->compress.xpress);
@@ -1157,8 +1157,6 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      CLST vcn, lcn, len;
      struct ATTRIB *attr;
      const struct VOLUME_INFO *info;
-    u32 idx, done, bytes;
-    struct ATTR_DEF_ENTRY *t;
      u16 *shared;
      struct MFT_REF ref;
      bool ro = sb_rdonly(sb);
@@ -1199,7 +1197,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)

      /*
       * Load $Volume. This should be done before $LogFile
-     * 'cause 'sbi->volume.ni' is used 'ntfs_set_state'.
+     * 'cause 'sbi->volume.ni' is used in 'ntfs_set_state'.
       */
      ref.low = cpu_to_le32(MFT_REC_VOL);
      ref.seq = cpu_to_le16(MFT_REC_VOL);
@@ -1422,54 +1420,28 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
          goto put_inode_out;
      }

-    bytes = inode->i_size;
-    sbi->def_table = t = kvmalloc(bytes, GFP_KERNEL);
-    if (!t) {
-        err = -ENOMEM;
-        goto put_inode_out;
-    }
-
-    for (done = idx = 0; done < bytes; done += PAGE_SIZE, idx++) {
-        unsigned long tail = bytes - done;
-        struct page *page = ntfs_map_page(inode->i_mapping, idx);
-
-        if (IS_ERR(page)) {
-            err = PTR_ERR(page);
-            ntfs_err(sb, "Failed to read $AttrDef (%d).", err);
+    {
+        u32 bytes = inode->i_size;
+        struct ATTR_DEF_ENTRY *def_table = kmalloc(bytes, GFP_KERNEL);
+        if (!def_table) {
+            err = -ENOMEM;
              goto put_inode_out;
          }
-        memcpy(Add2Ptr(t, done), page_address(page),
-               min(PAGE_SIZE, tail));
-        ntfs_unmap_page(page);

-        if (!idx && ATTR_STD != t->type) {
-            ntfs_err(sb, "$AttrDef is corrupted.");
-            err = -EINVAL;
-            goto put_inode_out;
+        /* Read the entire file. */
+        err = inode_read_data(inode, def_table, bytes);
+        if (err) {
+            ntfs_err(sb, "Failed to read $AttrDef (%d).", err);
+        } else {
+            /* Check content and store sorted array. */
+            err = ntfs_check_attr_def(sbi, def_table, bytes);
+            if (err)
+                ntfs_err(sb, "$AttrDef is corrupted.");
          }
-    }
-
-    t += 1;
-    sbi->def_entries = 1;
-    done = sizeof(struct ATTR_DEF_ENTRY);
-    sbi->reparse.max_size = MAXIMUM_REPARSE_DATA_BUFFER_SIZE;
-    sbi->ea_max_size = 0x10000; /* default formatter value */
-
-    while (done + sizeof(struct ATTR_DEF_ENTRY) <= bytes) {
-        u32 t32 = le32_to_cpu(t->type);
-        u64 sz = le64_to_cpu(t->max_sz);
-
-        if ((t32 & 0xF) || le32_to_cpu(t[-1].type) >= t32)
-            break;
-
-        if (t->type == ATTR_REPARSE)
-            sbi->reparse.max_size = sz;
-        else if (t->type == ATTR_EA)
-            sbi->ea_max_size = sz;

-        done += sizeof(struct ATTR_DEF_ENTRY);
-        t += 1;
-        sbi->def_entries += 1;
+        kfree(def_table);
+        if (err)
+            goto put_inode_out;
      }
      iput(inode);

@@ -1489,27 +1461,22 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
          goto put_inode_out;
      }

-    for (idx = 0; idx < (0x10000 * sizeof(short) >> PAGE_SHIFT); idx++) {
-        const __le16 *src;
-        u16 *dst = Add2Ptr(sbi->upcase, idx << PAGE_SHIFT);
-        struct page *page = ntfs_map_page(inode->i_mapping, idx);
-
-        if (IS_ERR(page)) {
-            err = PTR_ERR(page);
-            ntfs_err(sb, "Failed to read $UpCase (%d).", err);
-            goto put_inode_out;
-        }
-
-        src = page_address(page);
+    /* Read the entire file. */
+    err = inode_read_data(inode, sbi->upcase, 0x10000 * sizeof(short));
+    if (err) {
+        ntfs_err(sb, "Failed to read $UpCase (%d).", err);
+        goto put_inode_out;
+    }

  #ifdef __BIG_ENDIAN
-        for (i = 0; i < PAGE_SIZE / sizeof(u16); i++)
+    {
+        const __le16 *src = sbi->upcase;
+        u16 *dst = sbi->upcase;
+
+        for (i = 0; i < 0x10000; i++)
              *dst++ = le16_to_cpu(*src++);
-#else
-        memcpy(dst, src, PAGE_SIZE);
-#endif
-        ntfs_unmap_page(page);
      }
+#endif

      shared = ntfs_set_shared(sbi->upcase, 0x10000 * sizeof(short));
      if (shared && sbi->upcase != shared) {
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 872df2197202..a7f122e51c04 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -99,12 +99,12 @@ static int ntfs_read_ea(struct ntfs_inode *ni, 
struct EA_FULL **ea,

      /* Check Ea limit. */
      size = le32_to_cpu((*info)->size);
-    if (size > sbi->ea_max_size) {
+    if (size > sbi->attrdef.ea_max_size) {
          err = -EFBIG;
          goto out;
      }

-    if (attr_size(attr_ea) > sbi->ea_max_size) {
+    if (attr_size(attr_ea) > sbi->attrdef.ea_max_size) {
          err = -EFBIG;
          goto out;
      }
@@ -430,7 +430,7 @@ static noinline int ntfs_set_ea(struct inode *inode, 
const char *name,
       * 1. Check ea_info.size_pack for overflow.
       * 2. New attribute size must fit value from $AttrDef
       */
-    if (new_pack > 0xffff || size > sbi->ea_max_size) {
+    if (new_pack > 0xffff || size > sbi->attrdef.ea_max_size) {
          ntfs_inode_warn(
              inode,
              "The size of extended attributes must not exceed 64KiB");
-- 
2.34.1


