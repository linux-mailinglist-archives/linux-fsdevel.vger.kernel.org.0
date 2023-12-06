Return-Path: <linux-fsdevel+bounces-5021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BD1807541
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FCA1C20B02
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827448CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="FtCj3ZeR";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="eyslm8PS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2355DD64;
	Wed,  6 Dec 2023 07:14:16 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id DCC301D47;
	Wed,  6 Dec 2023 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701874953;
	bh=h7CldxQv2S5Mzb+cgzMS8C/4d3oWIhrtzyaVf9z57fs=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=FtCj3ZeRaBPZiv12dqOADExR+OT9YeqY3/k6OC2QQKJ9fE5ai7DN/5guAiwZgrx0Y
	 jzP8+1cDoiXU1I2OILGI8oMrFGQ8Mzot78sQq7PJSr+NK9SifuC9zxxEqJPwFMUUQW
	 5WoniFgJM0xApmStxoud0SP6WIR1lmABVdHpzCw8=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 243202117;
	Wed,  6 Dec 2023 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1701875337;
	bh=h7CldxQv2S5Mzb+cgzMS8C/4d3oWIhrtzyaVf9z57fs=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=eyslm8PSDjgl/rJxNS7F5ffPQA97GTxlXUWYf2oWGY5RTCsYMvvFyqCsElJpRYSwz
	 6npCQYykuV9udtf+8QOPyVk307zBuOQjVyLCP2+qixg9ZdLjMW9bmjegmNrIfmBVN8
	 0V/6teX8F6muUqbGlKbZHgFBNOh1lspt8A1CwIIE=
Received: from [172.16.192.129] (192.168.211.144) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Dec 2023 18:08:56 +0300
Message-ID: <53c3c86f-c816-4747-9262-592c3ddc6660@paragon-software.com>
Date: Wed, 6 Dec 2023 18:08:56 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 01/16] fs/ntfs3: Improve alternative boot processing
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
  fs/ntfs3/super.c | 35 +++++++++++++++++------------------
  1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9153dffde950..09d61c6c90aa 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -866,6 +866,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      u16 fn, ao;
      u8 cluster_bits;
      u32 boot_off = 0;
+    sector_t boot_block = 0;
      const char *hint = "Primary boot";

      /* Save original dev_size. Used with alternative boot. */
@@ -873,11 +874,11 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,

      sbi->volume.blocks = dev_size >> PAGE_SHIFT;

-    bh = ntfs_bread(sb, 0);
+read_boot:
+    bh = ntfs_bread(sb, boot_block);
      if (!bh)
-        return -EIO;
+        return boot_block ? -EINVAL : -EIO;

-check_boot:
      err = -EINVAL;

      /* Corrupted image; do not read OOB */
@@ -1108,26 +1109,24 @@ static int ntfs_init_from_boot(struct 
super_block *sb, u32 sector_size,
      }

  out:
-    if (err == -EINVAL && !bh->b_blocknr && dev_size0 > PAGE_SHIFT) {
+    brelse(bh);
+
+    if (err == -EINVAL && !boot_block && dev_size0 > PAGE_SHIFT) {
          u32 block_size = min_t(u32, sector_size, PAGE_SIZE);
          u64 lbo = dev_size0 - sizeof(*boot);

-        /*
-          * Try alternative boot (last sector)
-         */
-        brelse(bh);
-
-        sb_set_blocksize(sb, block_size);
-        bh = ntfs_bread(sb, lbo >> blksize_bits(block_size));
-        if (!bh)
-            return -EINVAL;
-
+        boot_block = lbo >> blksize_bits(block_size);
          boot_off = lbo & (block_size - 1);
-        hint = "Alternative boot";
-        dev_size = dev_size0; /* restore original size. */
-        goto check_boot;
+        if (boot_block && block_size >= boot_off + sizeof(*boot)) {
+            /*
+             * Try alternative boot (last sector)
+             */
+            sb_set_blocksize(sb, block_size);
+            hint = "Alternative boot";
+            dev_size = dev_size0; /* restore original size. */
+            goto read_boot;
+        }
      }
-    brelse(bh);

      return err;
  }
-- 
2.34.1


