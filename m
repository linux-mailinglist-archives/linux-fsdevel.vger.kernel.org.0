Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAFF697D85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBONgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBONgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:36:16 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19DE358D;
        Wed, 15 Feb 2023 05:36:15 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7DF952147;
        Wed, 15 Feb 2023 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676467923;
        bh=OatpAkpsqEkQhNlA8+4RSwXL5RSbK1GB/mfif8PSuXw=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=iAEGNCOIRzqY/nbzXCP4Ctrra7Efo9iOlJbi0C6An8CFHbytSmWV++wz84rTlqMmh
         p6zCCJnU2Eaxt6xq+4+UPXt3YnnOlkUSBK9TS0HbznaWpvyZM15P4LOYZ+WahPq81y
         VUWSCf+xlhJ9Nlh5mwDg+yXXj4owFmYLtU8dRK7Q=
Received: from [192.168.211.36] (192.168.211.36) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Feb 2023 16:36:13 +0300
Message-ID: <75a56ed1-eafc-0a18-9c2d-db4e423c3f26@paragon-software.com>
Date:   Wed, 15 Feb 2023 17:36:12 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH 04/11] fs/ntfs3: Optimization in ntfs_set_state()
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <d7c91201-5e09-5c06-3283-7887f5a5b7f1@paragon-software.com>
In-Reply-To: <d7c91201-5e09-5c06-3283-7887f5a5b7f1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.36]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current volume flags are updated only if VOLUME_FLAG_DIRTY has been 
changed.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 342938704cfd..d888ba14237f 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -925,6 +925,7 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum 
NTFS_DIRTY_FLAGS dirty)
      struct VOLUME_INFO *info;
      struct mft_inode *mi;
      struct ntfs_inode *ni;
+    __le16 info_flags;

      /*
       * Do not change state if fs was real_dirty.
@@ -957,6 +958,8 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum 
NTFS_DIRTY_FLAGS dirty)
          goto out;
      }

+    info_flags = info->flags;
+
      switch (dirty) {
      case NTFS_DIRTY_ERROR:
          ntfs_notice(sbi->sb, "Mark volume as dirty due to NTFS errors");
@@ -970,8 +973,10 @@ int ntfs_set_state(struct ntfs_sb_info *sbi, enum 
NTFS_DIRTY_FLAGS dirty)
          break;
      }
      /* Cache current volume flags. */
-    sbi->volume.flags = info->flags;
-    mi->dirty = true;
+    if (info_flags != info->flags) {
+        sbi->volume.flags = info->flags;
+        mi->dirty = true;
+    }
      err = 0;

  out:
-- 
2.34.1

