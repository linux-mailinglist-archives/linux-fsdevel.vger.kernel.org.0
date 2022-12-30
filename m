Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709C165978F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 12:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiL3LYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 06:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3LYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:24:03 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0D91AD81;
        Fri, 30 Dec 2022 03:24:02 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 88B7020EE;
        Fri, 30 Dec 2022 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672399227;
        bh=Twpu2s1FblETHbbeLRTjYS0t9CCid29iOzsPHx6E0wE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=QR5/iro+5wvQnz4zgUWii+eGK6pfLK5jTlP6AP/lb7bu6kBjhnJzTX126KbMljeCh
         K4C63jAVeRuEkS25Qt480x0jhT43WWldB/Qy8GLP8U46K6BfFoY+Qf8Cvy8OUSLV1S
         lIK/c64ZDQWH9EXjkXsjMZrSoOuCSTKG1JxPm1ks=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Dec 2022 14:23:59 +0300
Message-ID: <96b69941-36c3-04a1-cbfb-5a82c11e39f6@paragon-software.com>
Date:   Fri, 30 Dec 2022 15:23:59 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: [PATCH 1/5] fs/ntfs3: Add null pointer checks
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <b06828df-f9b9-1c5d-d6db-05839bad7016@paragon-software.com>
In-Reply-To: <b06828df-f9b9-1c5d-d6db-05839bad7016@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added null pointer checks in function ntfs_security_init.
Also added le32_to_cpu in functions ntfs_security_init and indx_read.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c | 16 ++++++++++------
  fs/ntfs3/index.c  |  3 ++-
  2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 8de861ddec60..1f36e89dcff7 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1876,10 +1876,12 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
          goto out;
      }

-    root_sdh = resident_data_ex(attr, sizeof(struct INDEX_ROOT));
-    if (root_sdh->type != ATTR_ZERO ||
+    if(!(root_sdh = resident_data_ex(attr, sizeof(struct INDEX_ROOT))) ||
+        root_sdh->type != ATTR_ZERO ||
          root_sdh->rule != NTFS_COLLATION_TYPE_SECURITY_HASH ||
-        offsetof(struct INDEX_ROOT, ihdr) + root_sdh->ihdr.used > 
attr->res.data_size) {
+        offsetof(struct INDEX_ROOT, ihdr) +
+            le32_to_cpu(root_sdh->ihdr.used) >
+            le32_to_cpu(attr->res.data_size)) {
          err = -EINVAL;
          goto out;
      }
@@ -1895,10 +1897,12 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
          goto out;
      }

-    root_sii = resident_data_ex(attr, sizeof(struct INDEX_ROOT));
-    if (root_sii->type != ATTR_ZERO ||
+    if(!(root_sii = resident_data_ex(attr, sizeof(struct INDEX_ROOT))) ||
+        root_sii->type != ATTR_ZERO ||
          root_sii->rule != NTFS_COLLATION_TYPE_UINT ||
-        offsetof(struct INDEX_ROOT, ihdr) + root_sii->ihdr.used > 
attr->res.data_size) {
+        offsetof(struct INDEX_ROOT, ihdr) +
+            le32_to_cpu(root_sii->ihdr.used) >
+            le32_to_cpu(attr->res.data_size)) {
          err = -EINVAL;
          goto out;
      }
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index f716487ec8a0..8718df791a55 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1102,7 +1102,8 @@ int indx_read(struct ntfs_index *indx, struct 
ntfs_inode *ni, CLST vbn,
      }

      /* check for index header length */
-    if (offsetof(struct INDEX_BUFFER, ihdr) + ib->ihdr.used > bytes) {
+    if (offsetof(struct INDEX_BUFFER, ihdr) + le32_to_cpu(ib->ihdr.used) >
+        bytes) {
          err = -EINVAL;
          goto out;
      }
-- 
2.34.1
