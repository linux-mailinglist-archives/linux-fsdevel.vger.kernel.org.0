Return-Path: <linux-fsdevel+bounces-17141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D388A83DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BB31F2461B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC61EDC;
	Wed, 17 Apr 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="rnCYxvs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880013BAFB;
	Wed, 17 Apr 2024 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359346; cv=none; b=b572aq8dTQmAZIqqySVP633DgNveoWLiOnRLwjt/0rVDC7lAN0grrLcS6C21an3nfmT/8T+pinoEHXUh47AXH5OmPd4+fyMWsRBtcCrveBvp2fyRgB6IJyZ8SeejYK/My27OkSSOE71ytDMC7x4tuuTAuWbrt35ghTZ8BgLIqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359346; c=relaxed/simple;
	bh=DatEFLCOpw+NbDuENy+FYJ2ABAdky5Z6lhP8M4gukFg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=QZR9poAEGAEbvM+dg+R/yOAx4w9LQtxB4t0Jqy6bCNldHfaUKmYRMrNTKp0YNPnaUrBsMKtSdydDPwMxKwW8L95WgNOcYctTxiyEhDLYfOxtLf3oQ1AMJ22tnUjxb+5Xg4aNR86tM1Sc22ERnix7os4+m+5zbuny8XRA/q+cfek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=rnCYxvs0; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 120BF2126;
	Wed, 17 Apr 2024 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713358892;
	bh=MOOj/f32Isl8H3mG7B5vylZH6udxOz6XAGuNohryItc=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=rnCYxvs0Dbuue93udczCqEBBKnJpqbKEvt1OlSql5WaaVIR85ojHVyhtQaNpEfiyQ
	 ZejcHoT++YsK461jmTz7+ZoUT3LzlisE58FGBvGu8nJiRAwvpnxJH/swpfnV51YgxL
	 PnkhCmbDHiBqlEYIxZcdTUxl2cH7m5xh6aZzkI0M=
Received: from [192.168.211.39] (192.168.211.39) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Apr 2024 16:09:00 +0300
Message-ID: <890cc224-fdb8-4c5e-a22e-b96dc86e6908@paragon-software.com>
Date: Wed, 17 Apr 2024 16:09:00 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 10/11] fs/ntfs3: Remove cached label from sbi
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

Add more checks using $AttrDef.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++++
  fs/ntfs3/fsntfs.c  | 17 ++++-------
  fs/ntfs3/ntfs_fs.h | 27 +++++++++++++++++-
  fs/ntfs3/super.c   | 49 +++++++++++++++++++-------------
  4 files changed, 132 insertions(+), 32 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index aedae36b91d0..acee4644fd8d 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -228,6 +228,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, 
struct ATTRIB *attr,
                u64 new_size, struct runs_tree *run,
                struct ATTRIB **ins_attr, struct page *page)
  {
+    const struct ATTR_DEF_ENTRY_SMALL *q;
      struct ntfs_sb_info *sbi;
      struct ATTRIB *attr_s;
      struct MFT_REC *rec;
@@ -243,6 +244,22 @@ int attr_make_nonresident(struct ntfs_inode *ni, 
struct ATTRIB *attr,
      }

      sbi = mi->sbi;
+
+    /* Check if we can use nonresident form. */
+    q = ntfs_query_def(sbi, attr->type);
+    if (!q) {
+        ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+        return -EINVAL;
+    }
+
+    /* Check resident form. */
+    if (q->flags & NTFS_ATTR_MUST_BE_RESIDENT) {
+        ntfs_warn(sbi->sb,
+              "attribute %x is not allowed to be nonresident",
+              le32_to_cpu(attr->type));
+        return -EINVAL;
+    }
+
      rec = mi->mrec;
      attr_s = NULL;
      used = le32_to_cpu(rec->used);
@@ -2589,4 +2606,58 @@ int attr_force_nonresident(struct ntfs_inode *ni)
      up_write(&ni->file.run_lock);

      return err;
+}
+
+/*
+ * Returns true if attribute is ok
+ */
+bool attr_check(const struct ATTRIB *attr, struct ntfs_sb_info *sbi,
+        struct ntfs_inode *ni)
+{
+    u64 size;
+    const char *hint;
+    const struct ATTR_DEF_ENTRY_SMALL *q = ntfs_query_def(sbi, attr->type);
+
+    if (!q) {
+        hint = "unknown";
+        goto out;
+    }
+
+    /* Check resident form. */
+    if ((q->flags & NTFS_ATTR_MUST_BE_RESIDENT) && attr->non_res) {
+        hint = "must be resident";
+        goto out;
+    }
+
+    /* Check name. */
+    if ((q->flags & NTFS_ATTR_MUST_BE_NAMED) && !attr->name_len) {
+        hint = "must be named";
+        goto out;
+    }
+
+    /* Check size. */
+    size = attr_size(attr);
+    if (size < q->min_sz) {
+        hint = "minimum size";
+        goto out;
+    }
+
+    if (size > q->max_sz) {
+        hint = "maximum size";
+        goto out;
+    }
+
+    /* ok. */
+    return true;
+
+out:
+    if (ni)
+        ntfs_inode_err(&ni->vfs_inode, "attribute type=%x, %s",
+                   le32_to_cpu(attr->type), hint);
+    else
+        ntfs_err(sbi->sb, "attribute type=%x, %s",
+             le32_to_cpu(attr->type), hint);
+
+    ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+    return false;
  }
\ No newline at end of file
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index f9c60f3cadaf..5dacb8301202 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2650,8 +2650,8 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 
*label, int len)
  {
      int err;
      struct ATTRIB *attr;
+    u32 uni_bytes;
      struct ntfs_inode *ni = sbi->volume.ni;
-    const u8 max_ulen = 0x80; /* TODO: use attrdef to get maximum length */
      /* Allocate PATH_MAX bytes. */
      struct cpu_str *uni = __getname();

@@ -2663,7 +2663,8 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 
*label, int len)
      if (err < 0)
          goto out;

-    if (uni->len > max_ulen) {
+    uni_bytes = uni->len * sizeof(u16);
+    if (uni_bytes > sbi->attrdef.label_max_size) {
          ntfs_warn(sbi->sb, "new label is too long");
          err = -EFBIG;
          goto out;
@@ -2674,19 +2675,13 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 
*label, int len)
      /* Ignore any errors. */
      ni_remove_attr(ni, ATTR_LABEL, NULL, 0, false, NULL);

-    err = ni_insert_resident(ni, uni->len * sizeof(u16), ATTR_LABEL, NULL,
-                 0, &attr, NULL, NULL);
+    err = ni_insert_resident(ni, uni_bytes, ATTR_LABEL, NULL, 0, &attr,
+                 NULL, NULL);
      if (err < 0)
          goto unlock_out;

      /* write new label in on-disk struct. */
-    memcpy(resident_data(attr), uni->name, uni->len * sizeof(u16));
-
-    /* update cached value of current label. */
-    if (len >= ARRAY_SIZE(sbi->volume.label))
-        len = ARRAY_SIZE(sbi->volume.label) - 1;
-    memcpy(sbi->volume.label, label, len);
-    sbi->volume.label[len] = 0;
+    memcpy(resident_data(attr), uni->name, uni_bytes);
      mark_inode_dirty_sync(&ni->vfs_inode);

  unlock_out:
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 1d4fb6f87dea..12c392db5b08 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -293,7 +293,6 @@ struct ntfs_sb_info {
          __le16 flags; // Cached current VOLUME_INFO::flags, 
VOLUME_FLAG_DIRTY.
          u8 major_ver;
          u8 minor_ver;
-        char label[256];
          bool real_dirty; // Real fs state.
      } volume;

@@ -465,6 +464,8 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 
vbo, u64 bytes);
  int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
  int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 
*frame_size);
  int attr_force_nonresident(struct ntfs_inode *ni);
+bool attr_check(const struct ATTRIB *attr, struct ntfs_sb_info *sbi,
+        struct ntfs_inode *ni);

  /* Functions from attrlist.c */
  void al_destroy(struct ntfs_inode *ni);
@@ -1152,4 +1153,28 @@ static inline void le64_sub_cpu(__le64 *var, u64 val)
      *var = cpu_to_le64(le64_to_cpu(*var) - val);
  }

+/*
+ * Attributes types: 0x10, 0x20, 0x30....
+ * indexes in attribute table:  0, 1, 2...
+ */
+static inline const struct ATTR_DEF_ENTRY_SMALL *
+ntfs_query_def(const struct ntfs_sb_info *sbi, enum ATTR_TYPE type)
+{
+    const struct ATTR_DEF_ENTRY_SMALL *q;
+    u32 idx = (le32_to_cpu(type) >> 4) - 1;
+
+    if (idx >= sbi->attrdef.entries) {
+        /* such attribute is not allowed in this ntfs. */
+        return NULL;
+    }
+
+    q = sbi->attrdef.table + idx;
+    if (!q->type) {
+        /* such attribute is not allowed in this ntfs. */
+        return NULL;
+    }
+
+    return q;
+}
+
  #endif /* _LINUX_NTFS3_NTFS_FS_H */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 8beefbca5769..dae961d2d6f8 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -481,11 +481,39 @@ static int ntfs3_volinfo_open(struct inode *inode, 
struct file *file)
  /* read /proc/fs/ntfs3/<dev>/label */
  static int ntfs3_label_show(struct seq_file *m, void *o)
  {
+    int len;
      struct super_block *sb = m->private;
      struct ntfs_sb_info *sbi = sb->s_fs_info;
+    struct ATTRIB *attr;
+    u8 *label = kmalloc(PAGE_SIZE, GFP_NOFS);
+
+    if (!label)
+        return -ENOMEM;
+
+    attr = ni_find_attr(sbi->volume.ni, NULL, NULL, ATTR_LABEL, NULL, 0,
+                NULL, NULL);
+
+    if (!attr) {
+        /* It is ok if no ATTR_LABEL */
+        label[0] = 0;
+        len = 0;
+    } else if (!attr_check(attr, sbi, sbi->volume.ni)) {
+        len = sprintf(label, "%pg: failed to get label", sb->s_bdev);
+    } else {
+        len = ntfs_utf16_to_nls(sbi, resident_data(attr),
+                    le32_to_cpu(attr->res.data_size) >> 1,
+                    label, PAGE_SIZE);
+        if (len < 0) {
+            label[0] = 0;
+            len = 0;
+        } else if (len >= PAGE_SIZE) {
+            len = PAGE_SIZE - 1;
+        }
+    }

-    seq_printf(m, "%s\n", sbi->volume.label);
+    seq_printf(m, "%.*s\n", len, label);

+    kfree(label);
      return 0;
  }

@@ -1210,25 +1238,6 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)

      ni = ntfs_i(inode);

-    /* Load and save label (not necessary). */
-    attr = ni_find_attr(ni, NULL, NULL, ATTR_LABEL, NULL, 0, NULL, NULL);
-
-    if (!attr) {
-        /* It is ok if no ATTR_LABEL */
-    } else if (!attr->non_res && !is_attr_ext(attr)) {
-        /* $AttrDef allows labels to be up to 128 symbols. */
-        err = utf16s_to_utf8s(resident_data(attr),
-                      le32_to_cpu(attr->res.data_size) >> 1,
-                      UTF16_LITTLE_ENDIAN, sbi->volume.label,
-                      sizeof(sbi->volume.label));
-        if (err < 0)
-            sbi->volume.label[0] = 0;
-    } else {
-        /* Should we break mounting here? */
-        //err = -EINVAL;
-        //goto put_inode_out;
-    }
-
      attr = ni_find_attr(ni, attr, NULL, ATTR_VOL_INFO, NULL, 0, NULL, 
NULL);
      if (!attr || is_attr_ext(attr) ||
          !(info = resident_data_ex(attr, SIZEOF_ATTRIBUTE_VOLUME_INFO))) {
-- 
2.34.1


