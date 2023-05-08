Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC356FB04A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjEHMjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 08:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjEHMjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 08:39:36 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D647DC41;
        Mon,  8 May 2023 05:39:20 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 51A9A21C3;
        Mon,  8 May 2023 12:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549272;
        bh=RZn6MEBLEPB8PODbTWpyKrutKazvJ93u3sSJUo2QDe0=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=J8R8cYIvFDJzrpNRE3G922qcYFnnI/bBOt8ad0u0N5q6Er9X6MnYLf7IE68IgRSGr
         Cq0289oRYMayQVh4ydPTBa2Qt13pQMsi88iGtZZzOCwK2xRbpSrg8q3xKdZZdanJ5+
         bxFPnNDaGTF7QL2IBC2zfx2Q/H/bNWwDos1xmuuY=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 017652191;
        Mon,  8 May 2023 12:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683549559;
        bh=RZn6MEBLEPB8PODbTWpyKrutKazvJ93u3sSJUo2QDe0=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=LrMJkh4GqzhuNnEemwuNCNXOfSOiHzgcWJI5IDQnK+hU1RVOjLaFxFSFe/rwqSK1e
         GEMmkGr8V+GZb5edstNj+eeqb45lPijVKaqK/s2sWD+E0MOOXZtLB4hnD3upKqzdR8
         mKk7xAzkrW1WThUpFmZrffB4C/F6/rsqJGr/42/w=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:39:17 +0300
Message-ID: <39d06f0d-f30d-c7c7-39e6-e4a566e6d5f4@paragon-software.com>
Date:   Mon, 8 May 2023 16:39:17 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH 08/10] fs/ntfs3: Add ability to format new mft records with
 bigger/smaller header
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

Just define in ntfs.h
     #define MFTRECORD_FIXUP_OFFSET  MFTRECORD_FIXUP_OFFSET_1
or
     #define MFTRECORD_FIXUP_OFFSET  MFTRECORD_FIXUP_OFFSET_3

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/ntfs.h   | 9 +++++++++
  fs/ntfs3/record.c | 2 ++
  fs/ntfs3/super.c  | 6 +++---
  3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 3ec2eaf31996..98b76d1b09e7 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -288,6 +288,15 @@ struct MFT_REC {

  #define MFTRECORD_FIXUP_OFFSET_1 offsetof(struct MFT_REC, res)
  #define MFTRECORD_FIXUP_OFFSET_3 offsetof(struct MFT_REC, fixups)
+/*
+ * define MFTRECORD_FIXUP_OFFSET as MFTRECORD_FIXUP_OFFSET_3 (0x30)
+ * to format new mft records with bigger header (as current ntfs.sys does)
+ *
+ * define MFTRECORD_FIXUP_OFFSET as MFTRECORD_FIXUP_OFFSET_1 (0x2A)
+ * to format new mft records with smaller header (as old ntfs.sys did)
+ * Both variants are valid.
+ */
+#define MFTRECORD_FIXUP_OFFSET  MFTRECORD_FIXUP_OFFSET_1

  static_assert(MFTRECORD_FIXUP_OFFSET_1 == 0x2A);
  static_assert(MFTRECORD_FIXUP_OFFSET_3 == 0x30);
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index e73ca2df42eb..c12ebffc94da 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -388,6 +388,8 @@ int mi_format_new(struct mft_inode *mi, struct 
ntfs_sb_info *sbi, CLST rno,

      rec->seq = cpu_to_le16(seq);
      rec->flags = RECORD_FLAG_IN_USE | flags;
+    if (MFTRECORD_FIXUP_OFFSET == MFTRECORD_FIXUP_OFFSET_3)
+        rec->mft_record = cpu_to_le32(rno);

      mi->dirty = true;

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 12019bfe1325..7ab0a79c7d84 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -867,7 +867,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      }

      sbi->max_bytes_per_attr =
-        record_size - ALIGN(MFTRECORD_FIXUP_OFFSET_1, 8) -
+        record_size - ALIGN(MFTRECORD_FIXUP_OFFSET, 8) -
          ALIGN(((record_size >> SECTOR_SHIFT) * sizeof(short)), 8) -
          ALIGN(sizeof(enum ATTR_TYPE), 8);

@@ -909,10 +909,10 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,

      sbi->new_rec = rec;
      rec->rhdr.sign = NTFS_FILE_SIGNATURE;
-    rec->rhdr.fix_off = cpu_to_le16(MFTRECORD_FIXUP_OFFSET_1);
+    rec->rhdr.fix_off = cpu_to_le16(MFTRECORD_FIXUP_OFFSET);
      fn = (sbi->record_size >> SECTOR_SHIFT) + 1;
      rec->rhdr.fix_num = cpu_to_le16(fn);
-    ao = ALIGN(MFTRECORD_FIXUP_OFFSET_1 + sizeof(short) * fn, 8);
+    ao = ALIGN(MFTRECORD_FIXUP_OFFSET + sizeof(short) * fn, 8);
      rec->attr_off = cpu_to_le16(ao);
      rec->used = cpu_to_le32(ao + ALIGN(sizeof(enum ATTR_TYPE), 8));
      rec->total = cpu_to_le32(sbi->record_size);
-- 
2.34.1

