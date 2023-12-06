Return-Path: <linux-fsdevel+bounces-5012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06C3807528
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0861C2039F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B8B487AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="hXLqwnBo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F6F112;
	Wed,  6 Dec 2023 07:11:42 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C6A3D212D;
	Wed,  6 Dec 2023 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875116;
	bh=RexGtu8XWQhs4tm8penzzSeBhtaDj8gNGca25jwrs2M=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=hXLqwnBonYPKS90AP/XXpXvpg5+f5SWde19cling7MoZ4UnWwskiL/hAMPHubIxpw
	 Of4FcC2fjOf/dQzXu8I2+vhD8p4R9EntgiXK60JCya/xpV8K9VtmMDipKLzh3QLjox
	 JsiEpCgDcYrptLa+d6fhqSCIT7nICinhP97CaNZM=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:11:40 +0300
Message-ID: <17bac290-26bf-484d-bcf2-9a65e93add78@paragon-software.com>
Date: Wed, 6 Dec 2023 18:11:40 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 06/16] fs/ntfs3: Reduce stack usage
Content-Language: en-US
From: Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
In-Reply-To: <00fd1558-fda5-421b-be43-7de69e32cb4e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fslog.c | 218 +++++++++++++++++++++--------------------------
  1 file changed, 98 insertions(+), 120 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 98ccb6650858..7dbb000fc691 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -974,6 +974,16 @@ static inline void *alloc_rsttbl_from_idx(struct 
RESTART_TABLE **tbl, u32 vbo)
      return e;
  }

+struct restart_info {
+    u64 last_lsn;
+    struct RESTART_HDR *r_page;
+    u32 vbo;
+    bool chkdsk_was_run;
+    bool valid_page;
+    bool initialized;
+    bool restart;
+};
+
  #define RESTART_SINGLE_PAGE_IO cpu_to_le16(0x0001)

  #define NTFSLOG_WRAPPED 0x00000001
@@ -987,6 +997,7 @@ struct ntfs_log {
      struct ntfs_inode *ni;

      u32 l_size;
+    u32 orig_file_size;
      u32 sys_page_size;
      u32 sys_page_mask;
      u32 page_size;
@@ -1040,6 +1051,8 @@ struct ntfs_log {

      struct CLIENT_ID client_id;
      u32 client_undo_commit;
+
+    struct restart_info rst_info, rst_info2;
  };

  static inline u32 lsn_to_vbo(struct ntfs_log *log, const u64 lsn)
@@ -1105,16 +1118,6 @@ static inline bool verify_client_lsn(struct 
ntfs_log *log,
             lsn <= le64_to_cpu(log->ra->current_lsn) && lsn;
  }

-struct restart_info {
-    u64 last_lsn;
-    struct RESTART_HDR *r_page;
-    u32 vbo;
-    bool chkdsk_was_run;
-    bool valid_page;
-    bool initialized;
-    bool restart;
-};
-
  static int read_log_page(struct ntfs_log *log, u32 vbo,
               struct RECORD_PAGE_HDR **buffer, bool *usa_error)
  {
@@ -1176,7 +1179,7 @@ static int read_log_page(struct ntfs_log *log, u32 
vbo,
   * restart page header. It will stop the first time we find a
   * valid page header.
   */
-static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
+static int log_read_rst(struct ntfs_log *log, bool first,
              struct restart_info *info)
  {
      u32 skip, vbo;
@@ -1192,7 +1195,7 @@ static int log_read_rst(struct ntfs_log *log, u32 
l_size, bool first,
      }

      /* Loop continuously until we succeed. */
-    for (; vbo < l_size; vbo = 2 * vbo + skip, skip = 0) {
+    for (; vbo < log->l_size; vbo = 2 * vbo + skip, skip = 0) {
          bool usa_error;
          bool brst, bchk;
          struct RESTART_AREA *ra;
@@ -1285,22 +1288,17 @@ static int log_read_rst(struct ntfs_log *log, 
u32 l_size, bool first,
  /*
   * Ilog_init_pg_hdr - Init @log from restart page header.
   */
-static void log_init_pg_hdr(struct ntfs_log *log, u32 sys_page_size,
-                u32 page_size, u16 major_ver, u16 minor_ver)
+static void log_init_pg_hdr(struct ntfs_log *log, u16 major_ver, u16 
minor_ver)
  {
-    log->sys_page_size = sys_page_size;
-    log->sys_page_mask = sys_page_size - 1;
-    log->page_size = page_size;
-    log->page_mask = page_size - 1;
-    log->page_bits = blksize_bits(page_size);
+    log->sys_page_size = log->page_size;
+    log->sys_page_mask = log->page_mask;

      log->clst_per_page = log->page_size >> log->ni->mi.sbi->cluster_bits;
      if (!log->clst_per_page)
          log->clst_per_page = 1;

-    log->first_page = major_ver >= 2 ?
-                  0x22 * page_size :
-                  ((sys_page_size << 1) + (page_size << 1));
+    log->first_page = major_ver >= 2 ? 0x22 * log->page_size :
+                       4 * log->page_size;
      log->major_ver = major_ver;
      log->minor_ver = minor_ver;
  }
@@ -1308,12 +1306,11 @@ static void log_init_pg_hdr(struct ntfs_log 
*log, u32 sys_page_size,
  /*
   * log_create - Init @log in cases when we don't have a restart area 
to use.
   */
-static void log_create(struct ntfs_log *log, u32 l_size, const u64 
last_lsn,
+static void log_create(struct ntfs_log *log, const u64 last_lsn,
                 u32 open_log_count, bool wrapped, bool use_multi_page)
  {
-    log->l_size = l_size;
      /* All file offsets must be quadword aligned. */
-    log->file_data_bits = blksize_bits(l_size) - 3;
+    log->file_data_bits = blksize_bits(log->l_size) - 3;
      log->seq_num_mask = (8 << log->file_data_bits) - 1;
      log->seq_num_bits = sizeof(u64) * 8 - log->file_data_bits;
      log->seq_num = (last_lsn >> log->file_data_bits) + 2;
@@ -3720,10 +3717,8 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      struct ntfs_sb_info *sbi = ni->mi.sbi;
      struct ntfs_log *log;

-    struct restart_info rst_info, rst_info2;
-    u64 rec_lsn, ra_lsn, checkpt_lsn = 0, rlsn = 0;
+    u64 rec_lsn, checkpt_lsn = 0, rlsn = 0;
      struct ATTR_NAME_ENTRY *attr_names = NULL;
-    struct ATTR_NAME_ENTRY *ane;
      struct RESTART_TABLE *dptbl = NULL;
      struct RESTART_TABLE *trtbl = NULL;
      const struct RESTART_TABLE *rt;
@@ -3741,9 +3736,7 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      struct TRANSACTION_ENTRY *tr;
      struct DIR_PAGE_ENTRY *dp;
      u32 i, bytes_per_attr_entry;
-    u32 l_size = ni->vfs_inode.i_size;
-    u32 orig_file_size = l_size;
-    u32 page_size, vbo, tail, off, dlen;
+    u32 vbo, tail, off, dlen;
      u32 saved_len, rec_len, transact_id;
      bool use_second_page;
      struct RESTART_AREA *ra2, *ra = NULL;
@@ -3758,52 +3751,50 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      u16 t16;
      u32 t32;

-    /* Get the size of page. NOTE: To replay we can use default page. */
-#if PAGE_SIZE >= DefaultLogPageSize && PAGE_SIZE <= DefaultLogPageSize * 2
-    page_size = norm_file_page(PAGE_SIZE, &l_size, true);
-#else
-    page_size = norm_file_page(PAGE_SIZE, &l_size, false);
-#endif
-    if (!page_size)
-        return -EINVAL;
-
      log = kzalloc(sizeof(struct ntfs_log), GFP_NOFS);
      if (!log)
          return -ENOMEM;

      log->ni = ni;
-    log->l_size = l_size;
-    log->one_page_buf = kmalloc(page_size, GFP_NOFS);
+    log->l_size = log->orig_file_size = ni->vfs_inode.i_size;
+
+    /* Get the size of page. NOTE: To replay we can use default page. */
+#if PAGE_SIZE >= DefaultLogPageSize && PAGE_SIZE <= DefaultLogPageSize * 2
+    log->page_size = norm_file_page(PAGE_SIZE, &log->l_size, true);
+#else
+    log->page_size = norm_file_page(PAGE_SIZE, &log->l_size, false);
+#endif
+    if (!log->page_size) {
+        err = -EINVAL;
+        goto out;
+    }

+    log->one_page_buf = kmalloc(log->page_size, GFP_NOFS);
      if (!log->one_page_buf) {
          err = -ENOMEM;
          goto out;
      }

-    log->page_size = page_size;
-    log->page_mask = page_size - 1;
-    log->page_bits = blksize_bits(page_size);
+    log->page_mask = log->page_size - 1;
+    log->page_bits = blksize_bits(log->page_size);

      /* Look for a restart area on the disk. */
-    memset(&rst_info, 0, sizeof(struct restart_info));
-    err = log_read_rst(log, l_size, true, &rst_info);
+    err = log_read_rst(log, true, &log->rst_info);
      if (err)
          goto out;

      /* remember 'initialized' */
-    *initialized = rst_info.initialized;
+    *initialized = log->rst_info.initialized;

-    if (!rst_info.restart) {
-        if (rst_info.initialized) {
+    if (!log->rst_info.restart) {
+        if (log->rst_info.initialized) {
              /* No restart area but the file is not initialized. */
              err = -EINVAL;
              goto out;
          }

-        log_init_pg_hdr(log, page_size, page_size, 1, 1);
-        log_create(log, l_size, 0, get_random_u32(), false, false);
-
-        log->ra = ra;
+        log_init_pg_hdr(log, 1, 1);
+        log_create(log, 0, get_random_u32(), false, false);

          ra = log_create_ra(log);
          if (!ra) {
@@ -3820,25 +3811,26 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
       * If the restart offset above wasn't zero then we won't
       * look for a second restart.
       */
-    if (rst_info.vbo)
+    if (log->rst_info.vbo)
          goto check_restart_area;

-    memset(&rst_info2, 0, sizeof(struct restart_info));
-    err = log_read_rst(log, l_size, false, &rst_info2);
+    err = log_read_rst(log, false, &log->rst_info2);
      if (err)
          goto out;

      /* Determine which restart area to use. */
-    if (!rst_info2.restart || rst_info2.last_lsn <= rst_info.last_lsn)
+    if (!log->rst_info2.restart ||
+        log->rst_info2.last_lsn <= log->rst_info.last_lsn)
          goto use_first_page;

      use_second_page = true;

-    if (rst_info.chkdsk_was_run && page_size != rst_info.vbo) {
+    if (log->rst_info.chkdsk_was_run &&
+        log->page_size != log->rst_info.vbo) {
          struct RECORD_PAGE_HDR *sp = NULL;
          bool usa_error;

-        if (!read_log_page(log, page_size, &sp, &usa_error) &&
+        if (!read_log_page(log, log->page_size, &sp, &usa_error) &&
              sp->rhdr.sign == NTFS_CHKD_SIGNATURE) {
              use_second_page = false;
          }
@@ -3846,52 +3838,43 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      }

      if (use_second_page) {
-        kfree(rst_info.r_page);
-        memcpy(&rst_info, &rst_info2, sizeof(struct restart_info));
-        rst_info2.r_page = NULL;
+        kfree(log->rst_info.r_page);
+        memcpy(&log->rst_info, &log->rst_info2,
+               sizeof(struct restart_info));
+        log->rst_info2.r_page = NULL;
      }

  use_first_page:
-    kfree(rst_info2.r_page);
+    kfree(log->rst_info2.r_page);

  check_restart_area:
      /*
       * If the restart area is at offset 0, we want
       * to write the second restart area first.
       */
-    log->init_ra = !!rst_info.vbo;
+    log->init_ra = !!log->rst_info.vbo;

      /* If we have a valid page then grab a pointer to the restart area. */
-    ra2 = rst_info.valid_page ?
-              Add2Ptr(rst_info.r_page,
-                  le16_to_cpu(rst_info.r_page->ra_off)) :
+    ra2 = log->rst_info.valid_page ?
+              Add2Ptr(log->rst_info.r_page,
+                  le16_to_cpu(log->rst_info.r_page->ra_off)) :
                NULL;

-    if (rst_info.chkdsk_was_run ||
+    if (log->rst_info.chkdsk_was_run ||
          (ra2 && ra2->client_idx[1] == LFS_NO_CLIENT_LE)) {
          bool wrapped = false;
          bool use_multi_page = false;
          u32 open_log_count;

          /* Do some checks based on whether we have a valid log page. */
-        if (!rst_info.valid_page) {
-            open_log_count = get_random_u32();
-            goto init_log_instance;
-        }
-        open_log_count = le32_to_cpu(ra2->open_log_count);
-
-        /*
-         * If the restart page size isn't changing then we want to
-         * check how much work we need to do.
-         */
-        if (page_size != le32_to_cpu(rst_info.r_page->sys_page_size))
-            goto init_log_instance;
+        open_log_count = log->rst_info.valid_page ?
+                     le32_to_cpu(ra2->open_log_count) :
+                     get_random_u32();

-init_log_instance:
-        log_init_pg_hdr(log, page_size, page_size, 1, 1);
+        log_init_pg_hdr(log, 1, 1);

-        log_create(log, l_size, rst_info.last_lsn, open_log_count,
-               wrapped, use_multi_page);
+        log_create(log, log->rst_info.last_lsn, open_log_count, wrapped,
+               use_multi_page);

          ra = log_create_ra(log);
          if (!ra) {
@@ -3916,28 +3899,27 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
       * use the log file. We must use the system page size instead of the
       * default size if there is not a clean shutdown.
       */
-    t32 = le32_to_cpu(rst_info.r_page->sys_page_size);
-    if (page_size != t32) {
-        l_size = orig_file_size;
-        page_size =
-            norm_file_page(t32, &l_size, t32 == DefaultLogPageSize);
+    t32 = le32_to_cpu(log->rst_info.r_page->sys_page_size);
+    if (log->page_size != t32) {
+        log->l_size = log->orig_file_size;
+        log->page_size = norm_file_page(t32, &log->l_size,
+                        t32 == DefaultLogPageSize);
      }

-    if (page_size != t32 ||
-        page_size != le32_to_cpu(rst_info.r_page->page_size)) {
+    if (log->page_size != t32 ||
+        log->page_size != le32_to_cpu(log->rst_info.r_page->page_size)) {
          err = -EINVAL;
          goto out;
      }

      /* If the file size has shrunk then we won't mount it. */
-    if (l_size < le64_to_cpu(ra2->l_size)) {
+    if (log->l_size < le64_to_cpu(ra2->l_size)) {
          err = -EINVAL;
          goto out;
      }

-    log_init_pg_hdr(log, page_size, page_size,
-            le16_to_cpu(rst_info.r_page->major_ver),
-            le16_to_cpu(rst_info.r_page->minor_ver));
+    log_init_pg_hdr(log, le16_to_cpu(log->rst_info.r_page->major_ver),
+            le16_to_cpu(log->rst_info.r_page->minor_ver));

      log->l_size = le64_to_cpu(ra2->l_size);
      log->seq_num_bits = le32_to_cpu(ra2->seq_num_bits);
@@ -3945,7 +3927,7 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      log->seq_num_mask = (8 << log->file_data_bits) - 1;
      log->last_lsn = le64_to_cpu(ra2->current_lsn);
      log->seq_num = log->last_lsn >> log->file_data_bits;
-    log->ra_off = le16_to_cpu(rst_info.r_page->ra_off);
+    log->ra_off = le16_to_cpu(log->rst_info.r_page->ra_off);
      log->restart_size = log->sys_page_size - log->ra_off;
      log->record_header_len = le16_to_cpu(ra2->rec_hdr_len);
      log->ra_size = le16_to_cpu(ra2->ra_len);
@@ -4045,7 +4027,7 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      log->current_avail = current_log_avail(log);

      /* Remember which restart area to write first. */
-    log->init_ra = rst_info.vbo;
+    log->init_ra = log->rst_info.vbo;

  process_log:
      /* 1.0, 1.1, 2.0 log->major_ver/minor_ver - short values. */
@@ -4105,7 +4087,7 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      log->client_id.seq_num = cr->seq_num;
      log->client_id.client_idx = client;

-    err = read_rst_area(log, &rst, &ra_lsn);
+    err = read_rst_area(log, &rst, &checkpt_lsn);
      if (err)
          goto out;

@@ -4114,9 +4096,8 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)

      bytes_per_attr_entry = !rst->major_ver ? 0x2C : 0x28;

-    checkpt_lsn = le64_to_cpu(rst->check_point_start);
-    if (!checkpt_lsn)
-        checkpt_lsn = ra_lsn;
+    if (rst->check_point_start)
+        checkpt_lsn = le64_to_cpu(rst->check_point_start);

      /* Allocate and Read the Transaction Table. */
      if (!rst->transact_table_len)
@@ -4330,23 +4311,20 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      lcb = NULL;

  check_attribute_names2:
-    if (!rst->attr_names_len)
-        goto trace_attribute_table;
-
-    ane = attr_names;
-    if (!oatbl)
-        goto trace_attribute_table;
-    while (ane->off) {
-        /* TODO: Clear table on exit! */
-        oe = Add2Ptr(oatbl, le16_to_cpu(ane->off));
-        t16 = le16_to_cpu(ane->name_bytes);
-        oe->name_len = t16 / sizeof(short);
-        oe->ptr = ane->name;
-        oe->is_attr_name = 2;
-        ane = Add2Ptr(ane, sizeof(struct ATTR_NAME_ENTRY) + t16);
-    }
-
-trace_attribute_table:
+    if (rst->attr_names_len && oatbl) {
+        struct ATTR_NAME_ENTRY *ane = attr_names;
+        while (ane->off) {
+            /* TODO: Clear table on exit! */
+            oe = Add2Ptr(oatbl, le16_to_cpu(ane->off));
+            t16 = le16_to_cpu(ane->name_bytes);
+            oe->name_len = t16 / sizeof(short);
+            oe->ptr = ane->name;
+            oe->is_attr_name = 2;
+            ane = Add2Ptr(ane,
+                      sizeof(struct ATTR_NAME_ENTRY) + t16);
+        }
+    }
+
      /*
       * If the checkpt_lsn is zero, then this is a freshly
       * formatted disk and we have no work to do.
@@ -5189,7 +5167,7 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      kfree(oatbl);
      kfree(dptbl);
      kfree(attr_names);
-    kfree(rst_info.r_page);
+    kfree(log->rst_info.r_page);

      kfree(ra);
      kfree(log->one_page_buf);
-- 
2.34.1


