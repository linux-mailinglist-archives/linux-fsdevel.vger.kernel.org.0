Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF87B745611
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjGCH2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 03:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjGCH2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:28:32 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A74E55;
        Mon,  3 Jul 2023 00:28:28 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 94B1C1D21;
        Mon,  3 Jul 2023 07:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688368995;
        bh=zSbz2rcKBXxPlxirBwRjMtqYwWRIZxW3itsjx+mpDUw=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=DYoyooiNxquY396tRP4PveJSv97Iv0Ubc6k8OL0qQxFCA6XV8qkchtYOOoqDY9Ra+
         t7yKwtRq3jIZDDqVANBULtAwLYwL/8uGar/18pHjMuBWJwDrWjiil/HB6HfJPIKS5G
         FLI/MYkMXFukxZXJvtk/m+4OJcOXuR370YsZz3Ag=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 0DE091D1E;
        Mon,  3 Jul 2023 07:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688369307;
        bh=zSbz2rcKBXxPlxirBwRjMtqYwWRIZxW3itsjx+mpDUw=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=Lv+C1XgnNu8FamEESwPA7jrLynFkxB2x/2GVVnBNxkQPd5KO6vOyXEnbwYKGvxWMy
         QEdp3btymMdQO3l0HSsf1HdeQ+5KGzxNAQpPfAtjTFD79NrSQK+I+Y//QUVuoFJ8Hw
         v5bT3YcVraRNSndWCb5HxWWSgnKku9tLZ6TUgG3o=
Received: from [192.168.211.138] (192.168.211.138) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 10:28:26 +0300
Message-ID: <f54ef3d3-2cca-535d-344c-408d969545d8@paragon-software.com>
Date:   Mon, 3 Jul 2023 11:28:25 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH 8/8] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
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


Reported-by: syzbot+478c1bf0e6bf4a8f3a04@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/ntfs_fs.h |  2 ++
  fs/ntfs3/super.c   | 26 ++++++++++++++++++++------
  2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 629403ede6e5..788567d71d93 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -42,9 +42,11 @@ enum utf16_endian;
  #define MINUS_ONE_T            ((size_t)(-1))
  /* Biggest MFT / smallest cluster */
  #define MAXIMUM_BYTES_PER_MFT        4096
+#define MAXIMUM_SHIFT_BYTES_PER_MFT    12
  #define NTFS_BLOCKS_PER_MFT_RECORD    (MAXIMUM_BYTES_PER_MFT / 512)

  #define MAXIMUM_BYTES_PER_INDEX        4096
+#define MAXIMUM_SHIFT_BYTES_PER_INDEX    12
  #define NTFS_BLOCKS_PER_INODE        (MAXIMUM_BYTES_PER_INDEX / 512)

  /* NTFS specific error code when fixup failed. */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 0034952b9ccd..34ebfaa8fbab 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -905,9 +905,17 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
          goto out;
      }

-    sbi->record_size = record_size =
-        boot->record_size < 0 ? 1 << (-boot->record_size) :
-                    (u32)boot->record_size << cluster_bits;
+    if (boot->record_size >= 0) {
+        record_size = (u32)boot->record_size << cluster_bits;
+    } else if (-boot->record_size <= MAXIMUM_SHIFT_BYTES_PER_MFT) {
+        record_size = 1u << (-boot->record_size);
+    } else {
+        ntfs_err(sb, "%s: invalid record size %d.", hint,
+             boot->record_size);
+        goto out;
+    }
+
+    sbi->record_size = record_size;
      sbi->record_bits = blksize_bits(record_size);
      sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes

@@ -924,9 +932,15 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
          goto out;
      }

-    sbi->index_size = boot->index_size < 0 ?
-                  1u << (-boot->index_size) :
-                  (u32)boot->index_size << cluster_bits;
+    if (boot->index_size >= 0) {
+        sbi->index_size = (u32)boot->index_size << cluster_bits;
+    } else if (-boot->index_size <= MAXIMUM_SHIFT_BYTES_PER_INDEX) {
+        sbi->index_size = 1u << (-boot->index_size);
+    } else {
+        ntfs_err(sb, "%s: invalid index size %d.", hint,
+             boot->index_size);
+        goto out;
+    }

      /* Check index record size. */
      if (sbi->index_size < SECTOR_SIZE || 
!is_power_of_2(sbi->index_size)) {
-- 
2.34.1

