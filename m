Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B498659791
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 12:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiL3LZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 06:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiL3LZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:25:17 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561321AA3D;
        Fri, 30 Dec 2022 03:25:16 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id DE17120EE;
        Fri, 30 Dec 2022 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672399301;
        bh=IhyjcyPjOgMswqZxmuu5gRIeIvP7uahHFtRFs1brtbo=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=fNkB3w4M7B1DlwImb18fnuXOaqbVJHMipnCdhLUYFgn+lYhn1u2+QANaBcjhGhFJS
         Yz2kq0eeB9y2QgA4OHtZ9mbheeLjaCNWcBtuFVtZtQ5JwbBnfmt+4fJguDUknaEtYB
         e+d+u2olbAKUA6sp8HmbTPsBNG+EvlzUEIM7wEbA=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 7FDB6212E;
        Fri, 30 Dec 2022 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672399514;
        bh=IhyjcyPjOgMswqZxmuu5gRIeIvP7uahHFtRFs1brtbo=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=S4C/nd8YgpdR/ITjFElMBsYZSVSpv84wYac3uiuoBREKkvJLdGNjN3s7zb9oD/VTg
         Ra8y9m19ehTPN3b98ttaKxslLDl9FGXotQtl4B8Lk3T06xVge11ByfWTXeJuboUXDA
         QLWRbM6IcK5kyA2WkOTYtEq/2K0BmVRqHs5jL9AU=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Dec 2022 14:25:14 +0300
Message-ID: <4e72d357-35de-f0d8-7f4b-f3f0e5f641b8@paragon-software.com>
Date:   Fri, 30 Dec 2022 15:25:13 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: [PATCH 2/5] fs/ntfs3: Improved checking of attribute's name length
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

Added comment, added null pointer checking.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/inode.c | 8 +++++++-
  1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 8225d0b7c48c..51f9542de7b0 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -137,7 +137,13 @@ static struct inode *ntfs_read_mft(struct inode *inode,
      rsize = attr->non_res ? 0 : le32_to_cpu(attr->res.data_size);
      asize = le32_to_cpu(attr->size);

-    if (le16_to_cpu(attr->name_off) + attr->name_len > asize)
+    /*
+     * Really this check was done in 'ni_enum_attr_ex' -> ... 
'mi_enum_attr'.
+     * There not critical to check this case again
+     */
+    if (attr->name_len &&
+        sizeof(short) * attr->name_len + le16_to_cpu(attr->name_off) >
+            asize)
          goto out;

      if (attr->non_res) {
-- 
2.34.1
