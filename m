Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30577AE9BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjIZJ5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 05:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjIZJ5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:57:04 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA0FB;
        Tue, 26 Sep 2023 02:56:57 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id CB48421BC;
        Tue, 26 Sep 2023 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1695721865;
        bh=OjduOup+un8qGaTqAgDN4qohzpVoBogSKK/pi3uPgl8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=HIMyLl9rMNTvWGANMBZ7k7mSFx743msYy8g+KbPRc35kVUui5Qgd+JfssKRCUF0ui
         twFYLxmtFfDFAjRcjxfXt7yN2F40dZVbX0JZVnAdS7CdKYjqrjG57x/xHjmQyQ4UVE
         zk0O+hx243YtYUWyghzeculoR16Cnf+FVRwSwCzI=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 2631B1D45;
        Tue, 26 Sep 2023 09:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1695722216;
        bh=OjduOup+un8qGaTqAgDN4qohzpVoBogSKK/pi3uPgl8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=QXyZoO1bXsfpERWazQ/dHI//s8xiRczuXczn4XUZ56rPoO9HfV38ePAekMdcfaUY/
         OyxcUmV7lg8D7Gw1Pc4+Gy3RKFwS6bD/9xb0nDoIQSlMoF+6JWb0mRW1zu4YHVxG2f
         x3S2MWJGobvAR2nlXUBUY6T0kBtzEYQMktPSZHeo=
Received: from [172.16.192.129] (192.168.211.137) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 26 Sep 2023 12:56:55 +0300
Message-ID: <4fdb4c65-d6db-4a0c-b2cc-296646c1e1fe@paragon-software.com>
Date:   Tue, 26 Sep 2023 12:56:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6/8] fs/ntfs3: Do not allow to change label if volume is
 read-only
Content-Language: en-US
From:   Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <7c217d7d-6ee4-4603-b5f1-ebe7b68cf430@paragon-software.com>
In-Reply-To: <7c217d7d-6ee4-4603-b5f1-ebe7b68cf430@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.137]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 5811da7e9d45..cf0a720523f0 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -497,7 +497,12 @@ static ssize_t ntfs3_label_write(struct file *file, 
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

