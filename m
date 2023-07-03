Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A3474560B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 09:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjGCH1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 03:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGCH1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:27:49 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE02E73;
        Mon,  3 Jul 2023 00:27:24 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 701271D74;
        Mon,  3 Jul 2023 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688368931;
        bh=D5iKNYHdfTlYuVyZq7hZxLedK3pQqQ8YbD1w2/CiIkM=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=CI1shzojPy5vSQ43J+xYNHD1Gzp0EmNYBN5Mogs5S3EuABT2FjWh00R7QynsARaqy
         L7Nmq6ppKhjiM2BncRx78NR9lx2quEERAFxeRoJLHNXG0vHRzRFzpn1MxA6fpxxEmF
         Am2OoGIy/JyfpI/3JZUBFO6opPSLk7uzr8jti1/g=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D85EF1D1E;
        Mon,  3 Jul 2023 07:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688369242;
        bh=D5iKNYHdfTlYuVyZq7hZxLedK3pQqQ8YbD1w2/CiIkM=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=QLU2NYl/jPH9ptdm9LSZC8zXlU5D+m3dcAntTbIaWBkv4YUEl+TZvLtAyrmqWMP0X
         0hjnpbirOKPB6D/3tyOtJXQ1+pbGGrisCNWVvD1n6B8kiABkXs1gxVlFPbqPIB2IZE
         fPlsir8M7+6++8uLNS8rbBZrXuMMDSSB6h1J6jto=
Received: from [192.168.211.138] (192.168.211.138) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 10:27:22 +0300
Message-ID: <18640b25-5018-ebf2-38d9-e750404cb66f@paragon-software.com>
Date:   Mon, 3 Jul 2023 11:27:21 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH 6/8] fs/ntfs3: Add more attributes checks in mi_enum_attr()
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
In-Reply-To: <e41f6717-7c70-edf2-2d3a-8034840d14c5@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.138]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/record.c | 68 ++++++++++++++++++++++++++++++++++++-----------
  1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index cae939cb42cf..53629b1f65e9 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -199,8 +199,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, 
struct ATTRIB *attr)
  {
      const struct MFT_REC *rec = mi->mrec;
      u32 used = le32_to_cpu(rec->used);
-    u32 t32, off, asize;
+    u32 t32, off, asize, prev_type;
      u16 t16;
+    u64 data_size, alloc_size, tot_size;

      if (!attr) {
          u32 total = le32_to_cpu(rec->total);
@@ -219,6 +220,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, 
struct ATTRIB *attr)
          if (!is_rec_inuse(rec))
              return NULL;

+        prev_type = 0;
          attr = Add2Ptr(rec, off);
      } else {
          /* Check if input attr inside record. */
@@ -232,11 +234,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, 
struct ATTRIB *attr)
              return NULL;
          }

-        if (off + asize < off) {
-            /* Overflow check. */
+        /* Overflow check. */
+        if (off + asize < off)
              return NULL;
-        }

+        prev_type = le32_to_cpu(attr->type);
          attr = Add2Ptr(attr, asize);
          off += asize;
      }
@@ -256,7 +258,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, 
struct ATTRIB *attr)

      /* 0x100 is last known attribute for now. */
      t32 = le32_to_cpu(attr->type);
-    if ((t32 & 0xf) || (t32 > 0x100))
+    if (!t32 || (t32 & 0xf) || (t32 > 0x100))
+        return NULL;
+
+    /* attributes in record must be ordered by type */
+    if (t32 < prev_type)
          return NULL;

      /* Check overflow and boundary. */
@@ -265,16 +271,15 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, 
struct ATTRIB *attr)

      /* Check size of attribute. */
      if (!attr->non_res) {
+        /* Check resident fields. */
          if (asize < SIZEOF_RESIDENT)
              return NULL;

          t16 = le16_to_cpu(attr->res.data_off);
-
          if (t16 > asize)
              return NULL;

-        t32 = le32_to_cpu(attr->res.data_size);
-        if (t16 + t32 > asize)
+        if (t16 + le32_to_cpu(attr->res.data_size) > asize)
              return NULL;

          t32 = sizeof(short) * attr->name_len;
@@ -284,21 +289,52 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, 
struct ATTRIB *attr)
          return attr;
      }

-    /* Check some nonresident fields. */
-    if (attr->name_len &&
-        le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len >
-            le16_to_cpu(attr->nres.run_off)) {
+    /* Check nonresident fields. */
+    if (attr->non_res != 1)
+        return NULL;
+
+    t16 = le16_to_cpu(attr->nres.run_off);
+    if (t16 > asize)
+        return NULL;
+
+    t32 = sizeof(short) * attr->name_len;
+    if (t32 && le16_to_cpu(attr->name_off) + t32 > t16)
+        return NULL;
+
+    /* Check start/end vcn. */
+    if (le64_to_cpu(attr->nres.svcn) > le64_to_cpu(attr->nres.evcn) + 1)
+        return NULL;
+
+    data_size = le64_to_cpu(attr->nres.data_size);
+    if (le64_to_cpu(attr->nres.valid_size) > data_size)
          return NULL;
-    }

-    if (attr->nres.svcn || !is_attr_ext(attr)) {
+    alloc_size = le64_to_cpu(attr->nres.alloc_size);
+    if (data_size > alloc_size)
+        return NULL;
+
+    t32 = mi->sbi->cluster_mask;
+    if (alloc_size & t32)
+        return NULL;
+
+    if (!attr->nres.svcn && is_attr_ext(attr)) {
+        /* First segment of sparse/compressed attribute */
+        if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+            return NULL;
+
+        tot_size = le64_to_cpu(attr->nres.total_size);
+        if (tot_size & t32)
+            return NULL;
+
+        if (tot_size > alloc_size)
+            return NULL;
+    } else {
          if (asize + 8 < SIZEOF_NONRESIDENT)
              return NULL;

          if (attr->nres.c_unit)
              return NULL;
-    } else if (asize + 8 < SIZEOF_NONRESIDENT_EX)
-        return NULL;
+    }

      return attr;
  }
-- 
2.34.1

