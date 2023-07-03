Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93E974561A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 09:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGCHcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 03:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGCHcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:32:41 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7603CC;
        Mon,  3 Jul 2023 00:32:40 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6740A1D34;
        Mon,  3 Jul 2023 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688368769;
        bh=Rx//LO9/7IMTU2TX9c0DIpKI/VjGm4z0Maj34lCnuA8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=mu+4Zi+tLFsNMkcxYwGJASldvxkMTPZFVITANt9PQgmJTIhNILUfanN8HReP5EGc5
         xOzSWVLVzvh1CrbVPqqkTlw4n773/xN7s9TfM/EgnivaCCaitQa9SfuU+V/0/3DBz2
         dDW1mRxHVXGxntNaJNTgR3OOLHnLFHs2erVFyFrA=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D2AF71D1E;
        Mon,  3 Jul 2023 07:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1688369080;
        bh=Rx//LO9/7IMTU2TX9c0DIpKI/VjGm4z0Maj34lCnuA8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=mbEfFe+uruU4DDxz9aMUbl86vfw5tJv1u7XTjIXN0qGP4zWp5U6A3fp4GDW60Dn7J
         UGp9F/YD7nbSA6VuaVUG+ZYaiHAKVGP8dP0FW4Br07t8eQbXVIYmXOg5fktOTnf6Yf
         iHxMePOqIco19Sq1QD1Fk18NmNFsNhLx4EcS2G0k=
Received: from [192.168.211.138] (192.168.211.138) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 3 Jul 2023 10:24:40 +0300
Message-ID: <379d007b-63d1-ab12-57aa-0ceee3d539a0@paragon-software.com>
Date:   Mon, 3 Jul 2023 11:24:39 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH 1/8] fs/ntfs3: Add ckeck in ni_update_parent()
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

Check simple case when parent inode equals current inode.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/frecord.c | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 16bd9faa2d28..8f34d6472ddb 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3208,6 +3208,12 @@ static bool ni_update_parent(struct ntfs_inode 
*ni, struct NTFS_DUP_INFO *dup,
          if (!fname || !memcmp(&fname->dup, dup, sizeof(fname->dup)))
              continue;

+        /* Check simple case when parent inode equals current inode. */
+        if (ino_get(&fname->home) == ni->vfs_inode.i_ino) {
+            ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+            continue;
+        }
+
          /* ntfs_iget5 may sleep. */
          dir = ntfs_iget5(sb, &fname->home, NULL);
          if (IS_ERR(dir)) {
-- 
2.34.1


