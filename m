Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EED697D8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjBONgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBONgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:36:50 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC2C358D;
        Wed, 15 Feb 2023 05:36:48 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id AE4042147;
        Wed, 15 Feb 2023 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676467956;
        bh=b+LLWuFDWYTNULIicKcI1S4EHJN/4plvEY5VcSHrLWg=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=Q/Yhfksb+qlZJt/4SxooKi0BdMWTt4rWIloAIs3pdR8jX3wuZjC6uyvFVJEygSGxA
         qUfQAD8VSljf5GabnWJAwMIbqa+GC5tWrNBKOuc4ArDXojXIv2GIg4qgHfGkjqsvbM
         RUE7iQtJBUzaiDMmsz+ntj3SX8NU96W+/1yPV/qA=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 0E8EC1E70;
        Wed, 15 Feb 2023 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676468207;
        bh=b+LLWuFDWYTNULIicKcI1S4EHJN/4plvEY5VcSHrLWg=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ptH5fSA1Cz8XKI6v5HdTiOH2aOVUYljEDjk4I6gFH627yI0aZPymi8pOrP5gUwlMs
         tW7L8ujIRq2JCs26nIJCdQ8r1U1/LsHBdzKlLxGh2FZ9x4mJ3qpflYanYe/wwE7Gdf
         0EnfrqssmhRvJu5CANZTFB19MIUDtuWifUzDlQwk=
Received: from [192.168.211.36] (192.168.211.36) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Feb 2023 16:36:46 +0300
Message-ID: <eb87d3e8-a3fa-2359-24dc-012ee10543d8@paragon-software.com>
Date:   Wed, 15 Feb 2023 17:36:46 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH 05/11] fs/ntfs3: Undo endian changes
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

sbi->mft.reserved_bitmap is in-memory (not on-disk!) bitmap.
Assumed cpu endian is faster than fixed endian.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c | 11 +++++------
  1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index d888ba14237f..9ed9dd0d8edf 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -646,13 +646,13 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, 
CLST *rno, bool mft,
                           NULL, 0, NULL, NULL))
                      goto next;

-                __clear_bit_le(ir - MFT_REC_RESERVED,
+                __clear_bit(ir - MFT_REC_RESERVED,
                          &sbi->mft.reserved_bitmap);
              }
          }

          /* Scan 5 bits for zero. Bit 0 == MFT_REC_RESERVED */
-        zbit = find_next_zero_bit_le(&sbi->mft.reserved_bitmap,
+        zbit = find_next_zero_bit(&sbi->mft.reserved_bitmap,
                        MFT_REC_FREE, MFT_REC_RESERVED);
          if (zbit >= MFT_REC_FREE) {
              sbi->mft.next_reserved = MFT_REC_FREE;
@@ -720,7 +720,7 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, 
CLST *rno, bool mft,
      if (*rno >= MFT_REC_FREE)
          wnd_set_used(wnd, *rno, 1);
      else if (*rno >= MFT_REC_RESERVED && sbi->mft.reserved_bitmap_inited)
-        __set_bit_le(*rno - MFT_REC_RESERVED, &sbi->mft.reserved_bitmap);
+        __set_bit(*rno - MFT_REC_RESERVED, &sbi->mft.reserved_bitmap);

  out:
      if (!mft)
@@ -748,7 +748,7 @@ void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, 
CLST rno, bool is_mft)
          else
              wnd_set_free(wnd, rno, 1);
      } else if (rno >= MFT_REC_RESERVED && 
sbi->mft.reserved_bitmap_inited) {
-        __clear_bit_le(rno - MFT_REC_RESERVED, &sbi->mft.reserved_bitmap);
+        __clear_bit(rno - MFT_REC_RESERVED, &sbi->mft.reserved_bitmap);
      }

      if (rno < wnd_zone_bit(wnd))
@@ -846,9 +846,8 @@ void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, 
int wait)
  {
      int err;
      struct super_block *sb = sbi->sb;
-    u32 blocksize;
+    u32 blocksize, bytes;
      sector_t block1, block2;
-    u32 bytes;

      if (!sb)
          return;
-- 
2.34.1

