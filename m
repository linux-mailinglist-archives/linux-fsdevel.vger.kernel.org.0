Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A55745630
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 09:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGCHdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 03:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjGCHdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:33:46 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7DE52;
        Mon,  3 Jul 2023 00:33:45 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7288A1D2D;
        Mon,  3 Jul 2023 07:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688369312;
        bh=vyFL1oZhfU5xO720PsZEshxb54c3khK1/6rIHMavdPI=;
        h=Date:To:CC:From:Subject;
        b=uOhK/kSSM6jkXirF69xA1s7lI7dreMO3txzGArfuqppEp4wtSSKADULERPejg29Bm
         QjmaEVbhj8CFldZIBrA0EpnM2JBZfc+Hyc5LNA8RcjbiPZeMYxCnt5wmNB0LSifyr0
         5eFrTLYpXCTr4H/KE0SFl7Bnp3UN2AefFxVAxW1s=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E6539439;
        Mon,  3 Jul 2023 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688369623;
        bh=vyFL1oZhfU5xO720PsZEshxb54c3khK1/6rIHMavdPI=;
        h=Date:To:CC:From:Subject;
        b=QM8izealV0gY8ReiLgWMkj4fwLg19nsJU9F1M4IIJf/KJQwzKK5YVeAtdKtOHZirI
         L7pxwKyW/FDF2b4ror+a0Np/uF+VIlZMxpoxeFamamlpaQw5W6CMD6jgc0zPs2rx52
         USb/HzLlpHam/MOz4K02x77DYYGN8/aVe8OG5r9g=
Received: from [192.168.211.138] (192.168.211.138) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 10:33:43 +0300
Message-ID: <5ce7410b-3715-dabb-0135-139f86546337@paragon-software.com>
Date:   Mon, 3 Jul 2023 11:33:42 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <dan.carpenter@linaro.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Correct mode for label entry inside /proc/fs/ntfs3/
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


Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/super.c | 7 ++++---
  1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index e36769eac7de..1a02072b6b0e 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1548,11 +1548,12 @@ static int ntfs_fill_super(struct super_block 
*sb, struct fs_context *fc)
      /* Create /proc/fs/ntfs3/.. */
      if (proc_info_root) {
          struct proc_dir_entry *e = proc_mkdir(sb->s_id, proc_info_root);
+        static_assert((S_IRUGO | S_IWUSR) == 0644);
          if (e) {
-            proc_create_data("volinfo", S_IFREG | S_IRUGO, e,
+            proc_create_data("volinfo", S_IRUGO, e,
                       &ntfs3_volinfo_fops, sb);
-            proc_create_data("label", S_IFREG | S_IRUGO | S_IWUGO,
-                     e, &ntfs3_label_fops, sb);
+            proc_create_data("label", S_IRUGO | S_IWUSR, e,
+                     &ntfs3_label_fops, sb);
              sbi->procdir = e;
          }
      }
-- 
2.34.1


