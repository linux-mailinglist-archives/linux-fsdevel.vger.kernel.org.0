Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B49659795
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 12:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiL3L0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 06:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiL3L0X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:26:23 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D7140C0;
        Fri, 30 Dec 2022 03:26:22 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D9A0A20EE;
        Fri, 30 Dec 2022 11:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672399367;
        bh=cx5DEN5yzbTg0lbldjz4Ma6Es6+57SY1O3L9oJVV9ds=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=rOEzMTST7ax17Nj+YLDvGarYh5kQ4KDBZeIOEVQIFf9UdpJRgksIAO8OzHWe07Y8g
         NK9ZUKG7fjgENsYOtlTdC1K3nh19owa7PFtoNKc4hD34JSAhzEsDbvu1hJa0OAv6dX
         +ZqmdLtXwNJcFp5/AxN6k/uEs5yqWbUzbyL4n7Gs=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Dec 2022 14:26:19 +0300
Message-ID: <e7c02fd6-3e32-7b25-935b-67f5539184e5@paragon-software.com>
Date:   Fri, 30 Dec 2022 15:26:18 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: [PATCH 4/5] fs/ntfs3: Restore overflow checking for attr size in
 mi_enum_attr
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

Fixed comment.
Removed explicit initialization for INDEX_ROOT.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/index.c  | 7 ++++---
  fs/ntfs3/record.c | 5 +++++
  fs/ntfs3/super.c  | 2 +-
  3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 8718df791a55..9fefeac5fe7e 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -994,7 +994,7 @@ struct INDEX_ROOT *indx_get_root(struct ntfs_index 
*indx, struct ntfs_inode *ni,
      struct ATTR_LIST_ENTRY *le = NULL;
      struct ATTRIB *a;
      const struct INDEX_NAMES *in = &s_index_names[indx->type];
-    struct INDEX_ROOT *root = NULL;
+    struct INDEX_ROOT *root;

      a = ni_find_attr(ni, NULL, &le, ATTR_ROOT, in->name, in->name_len, 
NULL,
               mi);
@@ -1007,8 +1007,9 @@ struct INDEX_ROOT *indx_get_root(struct ntfs_index 
*indx, struct ntfs_inode *ni,
      root = resident_data_ex(a, sizeof(struct INDEX_ROOT));

      /* length check */
-    if (root && offsetof(struct INDEX_ROOT, ihdr) + 
le32_to_cpu(root->ihdr.used) >
-            le32_to_cpu(a->res.data_size)) {
+    if (root &&
+        offsetof(struct INDEX_ROOT, ihdr) + le32_to_cpu(root->ihdr.used) >
+            le32_to_cpu(a->res.data_size)) {
          return NULL;
      }

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index abfe004774c0..0603169ee8a0 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -220,6 +220,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, 
struct ATTRIB *attr)
              return NULL;
          }

+        if (off + asize < off) {
+            /* Overflow check. */
+            return NULL;
+        }
+
          attr = Add2Ptr(attr, asize);
          off += asize;
      }
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 0967035146ce..19d0889b131f 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1187,7 +1187,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)

      /*
       * Typical $AttrDef contains up to 20 entries.
-     * Check for extremely large size.
+     * Check for extremely large/small size.
       */
      if (inode->i_size < sizeof(struct ATTR_DEF_ENTRY) ||
          inode->i_size > 100 * sizeof(struct ATTR_DEF_ENTRY)) {
-- 
2.34.1

