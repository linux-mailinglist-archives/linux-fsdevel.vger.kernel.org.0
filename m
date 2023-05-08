Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA86FB041
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 14:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjEHMjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjEHMi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 08:38:57 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C93539196;
        Mon,  8 May 2023 05:38:49 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7713221C3;
        Mon,  8 May 2023 12:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549240;
        bh=d84Ds9/cfWxjNs2/jfAkCt+5qkUgSqpdu5xT/2Jr3EI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=baKqxaTL8KClyo2ZLOJzvkpx/AItLISWL6uH91JodSZwMNMyE5ulsY3OFgJAvIxlG
         gFZQLSyDcq4tthScvZirvZ3XkcBeP5vSSTFRnD8EIgwpMZVnSsp8bW+2GgfcXswEZe
         O9219w2ELaLMb297vuqHSbDNdGnQQxRo06UBqXsw=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:38:46 +0300
Message-ID: <4356fa5f-db35-4e2a-35bb-8f727a08dd63@paragon-software.com>
Date:   Mon, 8 May 2023 16:38:46 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH 07/10] fs/ntfs3: Code refactoring
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <b21a4bc9-166d-2631-d73b-cb4e802ff69e@paragon-software.com>
In-Reply-To: <b21a4bc9-166d-2631-d73b-cb4e802ff69e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Check functions arguments. Use u8 instead of size_t for ntfs names, more 
consts and other.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrlist.c |   3 +-
  fs/ntfs3/frecord.c  |   2 +-
  fs/ntfs3/fsntfs.c   |  37 +++++++--------
  fs/ntfs3/inode.c    |   5 +-
  fs/ntfs3/ntfs.h     | 108 ++++++++++++++++++++++++--------------------
  fs/ntfs3/ntfs_fs.h  |  12 ++---
  fs/ntfs3/record.c   |   2 +-
  7 files changed, 88 insertions(+), 81 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 81c22df27c72..42631b31adf1 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -375,8 +375,7 @@ bool al_remove_le(struct ntfs_inode *ni, struct 
ATTR_LIST_ENTRY *le)
   * al_delete_le - Delete first le from the list which matches its 
parameters.
   */
  bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
-          const __le16 *name, size_t name_len,
-          const struct MFT_REF *ref)
+          const __le16 *name, u8 name_len, const struct MFT_REF *ref)
  {
      u16 size;
      struct ATTR_LIST_ENTRY *le;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 4227e3f590a5..be59bd399fd1 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -384,7 +384,7 @@ bool ni_add_subrecord(struct ntfs_inode *ni, CLST 
rno, struct mft_inode **mi)
   * ni_remove_attr - Remove all attributes for the given type/name/id.
   */
  int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
-           const __le16 *name, size_t name_len, bool base_only,
+           const __le16 *name, u8 name_len, bool base_only,
             const __le16 *id)
  {
      int err;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 1a0527e81ebb..1c05c088d1c6 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1661,7 +1661,8 @@ int ntfs_vbo_to_lbo(struct ntfs_sb_info *sbi, 
const struct runs_tree *run,
      return 0;
  }

-struct ntfs_inode *ntfs_new_inode(struct ntfs_sb_info *sbi, CLST rno, 
bool dir)
+struct ntfs_inode *ntfs_new_inode(struct ntfs_sb_info *sbi, CLST rno,
+                  enum RECORD_FLAG flag)
  {
      int err = 0;
      struct super_block *sb = sbi->sb;
@@ -1673,8 +1674,7 @@ struct ntfs_inode *ntfs_new_inode(struct 
ntfs_sb_info *sbi, CLST rno, bool dir)

      ni = ntfs_i(inode);

-    err = mi_format_new(&ni->mi, sbi, rno, dir ? RECORD_FLAG_DIR : 0,
-                false);
+    err = mi_format_new(&ni->mi, sbi, rno, flag, false);
      if (err)
          goto out;

@@ -1937,7 +1937,7 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
              break;

          sii_e = (struct NTFS_DE_SII *)ne;
-        if (le16_to_cpu(ne->view.data_size) < SIZEOF_SECURITY_HDR)
+        if (le16_to_cpu(ne->view.data_size) < sizeof(sii_e->sec_hdr))
              continue;

          next_id = le32_to_cpu(sii_e->sec_id) + 1;
@@ -1998,18 +1998,18 @@ int ntfs_get_security_by_id(struct ntfs_sb_info 
*sbi, __le32 security_id,
          goto out;

      t32 = le32_to_cpu(sii_e->sec_hdr.size);
-    if (t32 < SIZEOF_SECURITY_HDR) {
+    if (t32 < sizeof(struct SECURITY_HDR)) {
          err = -EINVAL;
          goto out;
      }

-    if (t32 > SIZEOF_SECURITY_HDR + 0x10000) {
+    if (t32 > sizeof(struct SECURITY_HDR) + 0x10000) {
          /* Looks like too big security. 0x10000 - is arbitrary big 
number. */
          err = -EFBIG;
          goto out;
      }

-    *size = t32 - SIZEOF_SECURITY_HDR;
+    *size = t32 - sizeof(struct SECURITY_HDR);

      p = kmalloc(*size, GFP_NOFS);
      if (!p) {
@@ -2023,14 +2023,14 @@ int ntfs_get_security_by_id(struct ntfs_sb_info 
*sbi, __le32 security_id,
      if (err)
          goto out;

-    if (memcmp(&d_security, &sii_e->sec_hdr, SIZEOF_SECURITY_HDR)) {
+    if (memcmp(&d_security, &sii_e->sec_hdr, sizeof(d_security))) {
          err = -EINVAL;
          goto out;
      }

      err = ntfs_read_run_nb(sbi, &ni->file.run,
                     le64_to_cpu(sii_e->sec_hdr.off) +
-                       SIZEOF_SECURITY_HDR,
+                       sizeof(struct SECURITY_HDR),
                     p, *size, NULL);
      if (err)
          goto out;
@@ -2069,7 +2069,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
      struct NTFS_DE_SDH sdh_e;
      struct NTFS_DE_SII sii_e;
      struct SECURITY_HDR *d_security;
-    u32 new_sec_size = size_sd + SIZEOF_SECURITY_HDR;
+    u32 new_sec_size = size_sd + sizeof(struct SECURITY_HDR);
      u32 aligned_sec_size = ALIGN(new_sec_size, 16);
      struct SECURITY_KEY hash_key;
      struct ntfs_fnd *fnd_sdh = NULL;
@@ -2207,14 +2207,14 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
      /* Fill SII entry. */
      sii_e.de.view.data_off =
          cpu_to_le16(offsetof(struct NTFS_DE_SII, sec_hdr));
-    sii_e.de.view.data_size = cpu_to_le16(SIZEOF_SECURITY_HDR);
+    sii_e.de.view.data_size = cpu_to_le16(sizeof(struct SECURITY_HDR));
      sii_e.de.view.res = 0;
-    sii_e.de.size = cpu_to_le16(SIZEOF_SII_DIRENTRY);
+    sii_e.de.size = cpu_to_le16(sizeof(struct NTFS_DE_SII));
      sii_e.de.key_size = cpu_to_le16(sizeof(d_security->key.sec_id));
      sii_e.de.flags = 0;
      sii_e.de.res = 0;
      sii_e.sec_id = d_security->key.sec_id;
-    memcpy(&sii_e.sec_hdr, d_security, SIZEOF_SECURITY_HDR);
+    memcpy(&sii_e.sec_hdr, d_security, sizeof(struct SECURITY_HDR));

      err = indx_insert_entry(indx_sii, ni, &sii_e.de, NULL, NULL, 0);
      if (err)
@@ -2223,7 +2223,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
      /* Fill SDH entry. */
      sdh_e.de.view.data_off =
          cpu_to_le16(offsetof(struct NTFS_DE_SDH, sec_hdr));
-    sdh_e.de.view.data_size = cpu_to_le16(SIZEOF_SECURITY_HDR);
+    sdh_e.de.view.data_size = cpu_to_le16(sizeof(struct SECURITY_HDR));
      sdh_e.de.view.res = 0;
      sdh_e.de.size = cpu_to_le16(SIZEOF_SDH_DIRENTRY);
      sdh_e.de.key_size = cpu_to_le16(sizeof(sdh_e.key));
@@ -2231,7 +2231,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
      sdh_e.de.res = 0;
      sdh_e.key.hash = d_security->key.hash;
      sdh_e.key.sec_id = d_security->key.sec_id;
-    memcpy(&sdh_e.sec_hdr, d_security, SIZEOF_SECURITY_HDR);
+    memcpy(&sdh_e.sec_hdr, d_security, sizeof(struct SECURITY_HDR));
      sdh_e.magic[0] = cpu_to_le16('I');
      sdh_e.magic[1] = cpu_to_le16('I');

@@ -2522,7 +2522,8 @@ void mark_as_free_ex(struct ntfs_sb_info *sbi, 
CLST lcn, CLST len, bool trim)
  /*
   * run_deallocate - Deallocate clusters.
   */
-int run_deallocate(struct ntfs_sb_info *sbi, struct runs_tree *run, 
bool trim)
+int run_deallocate(struct ntfs_sb_info *sbi, const struct runs_tree *run,
+           bool trim)
  {
      CLST lcn, len;
      size_t idx = 0;
@@ -2578,13 +2579,13 @@ static inline bool 
name_has_forbidden_chars(const struct le_str *fname)
      return false;
  }

-static inline bool is_reserved_name(struct ntfs_sb_info *sbi,
+static inline bool is_reserved_name(const struct ntfs_sb_info *sbi,
                      const struct le_str *fname)
  {
      int port_digit;
      const __le16 *name = fname->name;
      int len = fname->len;
-    u16 *upcase = sbi->upcase;
+    const u16 *upcase = sbi->upcase;

      /* check for 3 chars reserved names (device names) */
      /* name by itself or with any extension is forbidden */
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index f699cc053655..dc7e7ab701c6 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1309,7 +1309,7 @@ struct inode *ntfs_create_inode(struct mnt_idmap 
*idmap, struct inode *dir,
      if (err)
          goto out2;

-    ni = ntfs_new_inode(sbi, ino, fa & FILE_ATTRIBUTE_DIRECTORY);
+    ni = ntfs_new_inode(sbi, ino, S_ISDIR(mode) ? RECORD_FLAG_DIR : 0);
      if (IS_ERR(ni)) {
          err = PTR_ERR(ni);
          ni = NULL;
@@ -1437,8 +1437,7 @@ struct inode *ntfs_create_inode(struct mnt_idmap 
*idmap, struct inode *dir,

          root = Add2Ptr(attr, sizeof(I30_NAME) + SIZEOF_RESIDENT);
          memcpy(root, dir_root, offsetof(struct INDEX_ROOT, ihdr));
-        root->ihdr.de_off =
-            cpu_to_le32(sizeof(struct INDEX_HDR)); // 0x10
+        root->ihdr.de_off = cpu_to_le32(sizeof(struct INDEX_HDR));
          root->ihdr.used = cpu_to_le32(sizeof(struct INDEX_HDR) +
                            sizeof(struct NTFS_DE));
          root->ihdr.total = root->ihdr.used;
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 90151e56c122..3ec2eaf31996 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -95,11 +95,10 @@ enum RECORD_NUM {
      MFT_REC_BITMAP        = 6,
      MFT_REC_BOOT        = 7,
      MFT_REC_BADCLUST    = 8,
-    //MFT_REC_QUOTA        = 9,
-    MFT_REC_SECURE        = 9, // NTFS 3.0
+    MFT_REC_SECURE        = 9,
      MFT_REC_UPCASE        = 10,
-    MFT_REC_EXTEND        = 11, // NTFS 3.0
-    MFT_REC_RESERVED    = 11,
+    MFT_REC_EXTEND        = 11,
+    MFT_REC_RESERVED    = 12,
      MFT_REC_FREE        = 16,
      MFT_REC_USER        = 24,
  };
@@ -109,7 +108,6 @@ enum ATTR_TYPE {
      ATTR_STD        = cpu_to_le32(0x10),
      ATTR_LIST        = cpu_to_le32(0x20),
      ATTR_NAME        = cpu_to_le32(0x30),
-    // ATTR_VOLUME_VERSION on Nt4
      ATTR_ID            = cpu_to_le32(0x40),
      ATTR_SECURE        = cpu_to_le32(0x50),
      ATTR_LABEL        = cpu_to_le32(0x60),
@@ -118,7 +116,6 @@ enum ATTR_TYPE {
      ATTR_ROOT        = cpu_to_le32(0x90),
      ATTR_ALLOC        = cpu_to_le32(0xA0),
      ATTR_BITMAP        = cpu_to_le32(0xB0),
-    // ATTR_SYMLINK on Nt4
      ATTR_REPARSE        = cpu_to_le32(0xC0),
      ATTR_EA_INFO        = cpu_to_le32(0xD0),
      ATTR_EA            = cpu_to_le32(0xE0),
@@ -144,6 +141,7 @@ enum FILE_ATTRIBUTE {
      FILE_ATTRIBUTE_ENCRYPTED    = cpu_to_le32(0x00004000),
      FILE_ATTRIBUTE_VALID_FLAGS    = cpu_to_le32(0x00007fb7),
      FILE_ATTRIBUTE_DIRECTORY    = cpu_to_le32(0x10000000),
+    FILE_ATTRIBUTE_INDEX        = cpu_to_le32(0x20000000)
  };

  static_assert(sizeof(enum FILE_ATTRIBUTE) == 4);
@@ -266,7 +264,7 @@ enum RECORD_FLAG {
      RECORD_FLAG_IN_USE    = cpu_to_le16(0x0001),
      RECORD_FLAG_DIR        = cpu_to_le16(0x0002),
      RECORD_FLAG_SYSTEM    = cpu_to_le16(0x0004),
-    RECORD_FLAG_UNKNOWN    = cpu_to_le16(0x0008),
+    RECORD_FLAG_INDEX    = cpu_to_le16(0x0008),
  };

  /* MFT Record structure. */
@@ -331,18 +329,18 @@ struct ATTR_NONRESIDENT {
      __le64 svcn;        // 0x10: Starting VCN of this segment.
      __le64 evcn;        // 0x18: End VCN of this segment.
      __le16 run_off;        // 0x20: Offset to packed runs.
-    //  Unit of Compression size for this stream, expressed
-    //  as a log of the cluster size.
+    // Unit of Compression size for this stream, expressed
+    // as a log of the cluster size.
      //
-    //    0 means file is not compressed
-    //    1, 2, 3, and 4 are potentially legal values if the
-    //        stream is compressed, however the implementation
-    //        may only choose to use 4, or possibly 3.  Note
-    //        that 4 means cluster size time 16.    If convenient
-    //        the implementation may wish to accept a
-    //        reasonable range of legal values here (1-5?),
-    //        even if the implementation only generates
-    //        a smaller set of values itself.
+    // 0 means file is not compressed
+    // 1, 2, 3, and 4 are potentially legal values if the
+    // stream is compressed, however the implementation
+    // may only choose to use 4, or possibly 3.
+        // Note that 4 means cluster size time 16.
+        // If convenient the implementation may wish to accept a
+    // reasonable range of legal values here (1-5?),
+    // even if the implementation only generates
+    // a smaller set of values itself.
      u8 c_unit;        // 0x22:
      u8 res1[5];        // 0x23:
      __le64 alloc_size;    // 0x28: The allocated size of attribute in 
bytes.
@@ -836,16 +834,22 @@ static_assert(sizeof(struct ATTR_DEF_ENTRY) == 0xa0);
  /* Object ID (0x40) */
  struct OBJECT_ID {
      struct GUID ObjId;    // 0x00: Unique Id assigned to file.
-    struct GUID BirthVolumeId; // 0x10: Birth Volume Id is the Object 
Id of the Volume on.
-                // which the Object Id was allocated. It never changes.
-    struct GUID BirthObjectId; // 0x20: Birth Object Id is the first 
Object Id that was
-                // ever assigned to this MFT Record. I.e. If the Object Id
-                // is changed for some reason, this field will reflect the
-                // original value of the Object Id.
-    struct GUID DomainId;    // 0x30: Domain Id is currently unused but 
it is intended to be
-                // used in a network environment where the local machine is
-                // part of a Windows 2000 Domain. This may be used in a 
Windows
-                // 2000 Advanced Server managed domain.
+
+    // Birth Volume Id is the Object Id of the Volume on.
+    // which the Object Id was allocated. It never changes.
+    struct GUID BirthVolumeId; //0x10:
+
+    // Birth Object Id is the first Object Id that was
+    // ever assigned to this MFT Record. I.e. If the Object Id
+    // is changed for some reason, this field will reflect the
+    // original value of the Object Id.
+    struct GUID BirthObjectId; // 0x20:
+
+    // Domain Id is currently unused but it is intended to be
+    // used in a network environment where the local machine is
+    // part of a Windows 2000 Domain. This may be used in a Windows
+    // 2000 Advanced Server managed domain.
+    struct GUID DomainId;    // 0x30:
  };

  static_assert(sizeof(struct OBJECT_ID) == 0x40);
@@ -855,32 +859,35 @@ struct NTFS_DE_O {
      struct NTFS_DE de;
      struct GUID ObjId;    // 0x10: Unique Id assigned to file.
      struct MFT_REF ref;    // 0x20: MFT record number with this file.
-    struct GUID BirthVolumeId; // 0x28: Birth Volume Id is the Object 
Id of the Volume on
-                // which the Object Id was allocated. It never changes.
-    struct GUID BirthObjectId; // 0x38: Birth Object Id is the first 
Object Id that was
-                // ever assigned to this MFT Record. I.e. If the Object Id
-                // is changed for some reason, this field will reflect the
-                // original value of the Object Id.
-                // This field is valid if data_size == 0x48.
-    struct GUID BirthDomainId; // 0x48: Domain Id is currently unused 
but it is intended
-                // to be used in a network environment where the local
-                // machine is part of a Windows 2000 Domain. This may be
-                // used in a Windows 2000 Advanced Server managed domain.
+
+    // Birth Volume Id is the Object Id of the Volume on
+    // which the Object Id was allocated. It never changes.
+    struct GUID BirthVolumeId; // 0x28:
+
+    // Birth Object Id is the first Object Id that was
+    // ever assigned to this MFT Record. I.e. If the Object Id
+    // is changed for some reason, this field will reflect the
+    // original value of the Object Id.
+    // This field is valid if data_size == 0x48.
+    struct GUID BirthObjectId; // 0x38:
+
+    // Domain Id is currently unused but it is intended
+    // to be used in a network environment where the local
+    // machine is part of a Windows 2000 Domain. This may be
+    // used in a Windows 2000 Advanced Server managed domain.
+    struct GUID BirthDomainId; // 0x48:
  };

  static_assert(sizeof(struct NTFS_DE_O) == 0x58);

-#define NTFS_OBJECT_ENTRY_DATA_SIZE1                           \
-    0x38 // struct NTFS_DE_O.BirthDomainId is not used
-#define NTFS_OBJECT_ENTRY_DATA_SIZE2                           \
-    0x48 // struct NTFS_DE_O.BirthDomainId is used
-
  /* Q Directory entry structure ( rule = 0x11 ) */
  struct NTFS_DE_Q {
      struct NTFS_DE de;
      __le32 owner_id;    // 0x10: Unique Id assigned to file
+
+    /* here is 0x30 bytes of user quota. NOTE: 4 byte aligned! */
      __le32 Version;        // 0x14: 0x02
-    __le32 flags2;        // 0x18: Quota flags, see above
+    __le32 Flags;        // 0x18: Quota flags, see above
      __le64 BytesUsed;    // 0x1C:
      __le64 ChangeTime;    // 0x24:
      __le64 WarningLimit;    // 0x28:
@@ -888,9 +895,9 @@ struct NTFS_DE_Q {
      __le64 ExceededTime;    // 0x3C:

      // SID is placed here
-}; // sizeof() = 0x44
+}__packed; // sizeof() = 0x44

-#define SIZEOF_NTFS_DE_Q 0x44
+static_assert(sizeof(struct NTFS_DE_Q) == 0x44);

  #define SecurityDescriptorsBlockSize 0x40000 // 256K
  #define SecurityDescriptorMaxSize    0x20000 // 128K
@@ -912,7 +919,7 @@ struct SECURITY_HDR {
       */
  } __packed;

-#define SIZEOF_SECURITY_HDR 0x14
+static_assert(sizeof(struct SECURITY_HDR) == 0x14);

  /* SII Directory entry structure */
  struct NTFS_DE_SII {
@@ -921,7 +928,8 @@ struct NTFS_DE_SII {
      struct SECURITY_HDR sec_hdr;    // 0x14:
  } __packed;

-#define SIZEOF_SII_DIRENTRY 0x28
+static_assert(offsetof(struct NTFS_DE_SII, sec_hdr) == 0x14);
+static_assert(sizeof(struct NTFS_DE_SII) == 0x28);

  /* SDH Directory entry structure */
  struct NTFS_DE_SDH {
@@ -1155,7 +1163,7 @@ struct REPARSE_DATA_BUFFER {

  #define FILE_NEED_EA 0x80 // See ntifs.h
  /*
- *FILE_NEED_EA, indicates that the file to which the EA belongs cannot be
+ * FILE_NEED_EA, indicates that the file to which the EA belongs cannot be
   * interpreted without understanding the associated extended attributes.
   */
  struct EA_INFO {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 6667a75411fc..98b61e4b3215 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -467,8 +467,7 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE 
type, const __le16 *name,
            struct ATTR_LIST_ENTRY **new_le);
  bool al_remove_le(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le);
  bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
-          const __le16 *name, size_t name_len,
-          const struct MFT_REF *ref);
+          const __le16 *name, u8 name_len, const struct MFT_REF *ref);
  int al_update(struct ntfs_inode *ni, int sync);
  static inline size_t al_aligned(size_t size)
  {
@@ -527,7 +526,7 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, 
enum ATTR_TYPE type,
  int ni_load_all_mi(struct ntfs_inode *ni);
  bool ni_add_subrecord(struct ntfs_inode *ni, CLST rno, struct 
mft_inode **mi);
  int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
-           const __le16 *name, size_t name_len, bool base_only,
+           const __le16 *name, u8 name_len, bool base_only,
             const __le16 *id);
  int ni_create_attr_list(struct ntfs_inode *ni);
  int ni_expand_list(struct ntfs_inode *ni);
@@ -631,7 +630,7 @@ int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const 
struct runs_tree *run);
  int ntfs_vbo_to_lbo(struct ntfs_sb_info *sbi, const struct runs_tree *run,
              u64 vbo, u64 *lbo, u64 *bytes);
  struct ntfs_inode *ntfs_new_inode(struct ntfs_sb_info *sbi, CLST nRec,
-                  bool dir);
+                  enum RECORD_FLAG flag);
  extern const u8 s_default_security[0x50];
  bool is_sd_valid(const struct SECURITY_DESCRIPTOR_RELATIVE *sd, u32 len);
  int ntfs_security_init(struct ntfs_sb_info *sbi);
@@ -649,7 +648,8 @@ int ntfs_insert_reparse(struct ntfs_sb_info *sbi, 
__le32 rtag,
  int ntfs_remove_reparse(struct ntfs_sb_info *sbi, __le32 rtag,
              const struct MFT_REF *ref);
  void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, 
bool trim);
-int run_deallocate(struct ntfs_sb_info *sbi, struct runs_tree *run, 
bool trim);
+int run_deallocate(struct ntfs_sb_info *sbi, const struct runs_tree *run,
+           bool trim);
  bool valid_windows_name(struct ntfs_sb_info *sbi, const struct le_str 
*name);

  /* Globals from index.c */
@@ -738,7 +738,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, 
struct ATTRIB *attr);
  // TODO: id?
  struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
                  enum ATTR_TYPE type, const __le16 *name,
-                size_t name_len, const __le16 *id);
+                u8 name_len, const __le16 *id);
  static inline struct ATTRIB *rec_find_attr_le(struct mft_inode *rec,
                            struct ATTR_LIST_ENTRY *le)
  {
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 7974ca35a15c..e73ca2df42eb 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -302,7 +302,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, 
struct ATTRIB *attr)
   */
  struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
                  enum ATTR_TYPE type, const __le16 *name,
-                size_t name_len, const __le16 *id)
+                u8 name_len, const __le16 *id)
  {
      u32 type_in = le32_to_cpu(type);
      u32 atype;
-- 
2.34.1

