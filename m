Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8587745607
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjGCH0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 03:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGCH0t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:26:49 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756C9E7A;
        Mon,  3 Jul 2023 00:26:39 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 134861D74;
        Mon,  3 Jul 2023 07:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688368886;
        bh=vlNC3aqT1PLyINaRjLgT5dt7keaunUkuSQDjNJ9mzS8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=qF1ERGbXVCfRF81fRmeXF7le5tiNB5aw8lYBUUKRh7sxSiHitGOZ5U92gH6LVSV5N
         7vVl257xtBbRv6qSnyHU5ND//ac6PFjXjLL1R3aWqyRXR8tpBn2J7V6FymwnVeVryC
         jlSEGvv5l4ExEpdPCuQwNhGcX53Q3gsA9XFZX2eI=
Received: from [192.168.211.138] (192.168.211.138) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 10:26:37 +0300
Message-ID: <890222ac-1bd2-6817-7873-390801c5a172@paragon-software.com>
Date:   Mon, 3 Jul 2023 11:26:36 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH 5/8] fs/ntfs3: Use kvmalloc instead of kmalloc(...
 __GFP_NOWARN)
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
  fs/ntfs3/attrlist.c | 15 +++++++++++++--
  fs/ntfs3/bitmap.c   |  3 ++-
  fs/ntfs3/super.c    |  2 +-
  3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 42631b31adf1..7c01735d1219 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -52,7 +52,8 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct 
ATTRIB *attr)

      if (!attr->non_res) {
          lsize = le32_to_cpu(attr->res.data_size);
-        le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
+        /* attr is resident: lsize < record_size (1K or 4K) */
+        le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
          if (!le) {
              err = -ENOMEM;
              goto out;
@@ -80,7 +81,17 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct 
ATTRIB *attr)
          if (err < 0)
              goto out;

-        le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
+        /* attr is nonresident.
+         * The worst case:
+         * 1T (2^40) extremely fragmented file.
+         * cluster = 4K (2^12) => 2^28 fragments
+         * 2^9 fragments per one record => 2^19 records
+         * 2^5 bytes of ATTR_LIST_ENTRY per one record => 2^24 bytes.
+         *
+         * the result is 16M bytes per attribute list.
+         * Use kvmalloc to allocate in range [several Kbytes - dozen 
Mbytes]
+         */
+        le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
          if (!le) {
              err = -ENOMEM;
              goto out;
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 107e808e06ea..d66055e30aff 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -659,7 +659,8 @@ int wnd_init(struct wnd_bitmap *wnd, struct 
super_block *sb, size_t nbits)
          wnd->bits_last = wbits;

      wnd->free_bits =
-        kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
+        kvmalloc_array(wnd->nwnd, sizeof(u16), GFP_KERNEL | __GFP_ZERO);
+
      if (!wnd->free_bits)
          return -ENOMEM;

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index da739e509269..0034952b9ccd 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1373,7 +1373,7 @@ static int ntfs_fill_super(struct super_block *sb, 
struct fs_context *fc)
      }

      bytes = inode->i_size;
-    sbi->def_table = t = kmalloc(bytes, GFP_NOFS | __GFP_NOWARN);
+    sbi->def_table = t = kvmalloc(bytes, GFP_KERNEL);
      if (!t) {
          err = -ENOMEM;
          goto put_inode_out;
-- 
2.34.1


