Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6610A6118EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiJ1RJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJ1RJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:09:23 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A18E241B21;
        Fri, 28 Oct 2022 10:06:47 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 0BFCD218D;
        Fri, 28 Oct 2022 17:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976647;
        bh=vZQidD9CJW5D93E6fSX67v6fhJf0xZSsvUiQiK86ffE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=NyNL3VpJEnie2japjXib21D1rz7EgtMMl+SJmVZwshFGqkdpFtAgcfd8tMb8LQZUQ
         4qcv6UNy8SWyEe82+pWEh7MXoRQNh2aA/M04rlZAFkreYsidr7JDt+2E+CM7jLYiJb
         8KyuqlN9w0Yaol8e+PniR11N2QOvm7V+VL2Otj6Y=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:06:45 +0300
Message-ID: <bfd402b4-1274-08af-0f83-e1e976a42cce@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:06:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 11/14] fs/ntfs3: Use ALIGN kernel macro
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
In-Reply-To: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
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

This way code will be more readable.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fsntfs.c  | 2 +-
  fs/ntfs3/ntfs.h    | 1 -
  fs/ntfs3/ntfs_fs.h | 2 ++
  3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index e5a1f4df0397..1e01a3e8e01e 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -479,7 +479,7 @@ static int ntfs_extend_mft(struct ntfs_sb_info *sbi)
  	struct ATTRIB *attr;
  	struct wnd_bitmap *wnd = &sbi->mft.bitmap;
  
-	new_mft_total = (wnd->nbits + MFT_INCREASE_CHUNK + 127) & (CLST)~127;
+	new_mft_total = ALIGN(wnd->nbits + NTFS_MFT_INCREASE_STEP, 128);
  	new_mft_bytes = (u64)new_mft_total << sbi->record_bits;
  
  	/* Step 1: Resize $MFT::DATA. */
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 9cc396b117bf..9f764bf4ed0a 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -84,7 +84,6 @@ typedef u32 CLST;
  
  #define COMPRESSION_UNIT     4
  #define COMPRESS_MAX_CLUSTER 0x1000
-#define MFT_INCREASE_CHUNK   1024
  
  enum RECORD_NUM {
  	MFT_REC_MFT		= 0,
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index c9b8a6f1ba0b..bc02cfb344f9 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -198,6 +198,8 @@ struct ntfs_index {
  
  /* Minimum MFT zone. */
  #define NTFS_MIN_MFT_ZONE 100
+/* Step to increase the MFT. */
+#define NTFS_MFT_INCREASE_STEP 1024
  
  /* Ntfs file system in-core superblock data. */
  struct ntfs_sb_info {
-- 
2.37.0


