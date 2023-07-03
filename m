Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350607455FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 09:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGCH0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 03:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGCH0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:26:16 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5638E55;
        Mon,  3 Jul 2023 00:26:08 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 27D1D1D74;
        Mon,  3 Jul 2023 07:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688368855;
        bh=+eBsKb2HTBRR8iMsfkWgMdZnxlIJ4gxnl7NXRmJUV8k=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=S0F7IwFq6c40h6gaEVdITZiroO+ZvZZ7+haTDwG7SUnO9xUWQul5u8vrjXJCUI2zF
         c49G0p4igW/1KdgwlwzRA0U6GP0EaxMmxiZ9YTB66g9k9NaCAfXn+0e3f4Ix0J/KH0
         XJZlEw2GHdOfNcWFHxLLz3BxujT5lf8W2i2kU15k=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 970F41D1E;
        Mon,  3 Jul 2023 07:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688369166;
        bh=+eBsKb2HTBRR8iMsfkWgMdZnxlIJ4gxnl7NXRmJUV8k=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ZBp5rhznk1XyJ0MlCxs6qu+hl7QD7YL6ibfUhcXAbi0M2+qxtzaQou6K/7emjY8m7
         o7dCJJpvZa699JIbR2dGdDTUsfbeieG5EPhehEcBTthpzsqZDK1hmx77LtbSxWdkgp
         GpkZ3aiTrUf+R/FzV1q4EliIHaVDa2BpEuapv4Hk=
Received: from [192.168.211.138] (192.168.211.138) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 10:26:06 +0300
Message-ID: <a1aa84a5-29d4-a4f0-0b2d-200fb49b12d5@paragon-software.com>
Date:   Mon, 3 Jul 2023 11:26:05 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH 4/8] fs/ntfs3: Don't allow to change label if volume is
 read-only
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
  fs/ntfs3/super.c | 7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index d24f2da36bb2..da739e509269 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -489,7 +489,12 @@ static ssize_t ntfs3_label_write(struct file *file, 
const char __user *buffer,
      int err;
      struct super_block *sb = pde_data(file_inode(file));
      ssize_t ret = count;
-    u8 *label = kmalloc(count, GFP_NOFS);
+    u8 *label;
+
+    if (sb_rdonly(sb))
+        return -EROFS;
+
+    label = kmalloc(count, GFP_NOFS);

      if (!label)
          return -ENOMEM;
-- 
2.34.1


