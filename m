Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08282697DA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBONlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBONlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:41:12 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B4B392B4;
        Wed, 15 Feb 2023 05:41:09 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 93C162120;
        Wed, 15 Feb 2023 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676467804;
        bh=ERksTfD1/XuhpX5Xy+AmdTxEr0QconrM00RyDm/UdXY=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=g1u1V3iNHInPiICLDPOXbO+m0D/AjSraShkh5o+Gdxcb5hXxGKb1W5vFsOyEzfZ63
         idhN4dsDVU1iRW8pwpS4vKgsltLnpXdE2yZ/HPC6oqlNewjdozg0ytl0XXgGIaRtit
         UvoDHMb5JT/NYn5rIBwytEXTZGVgUPDby8exVw+g=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id DBFA11E70;
        Wed, 15 Feb 2023 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676468054;
        bh=ERksTfD1/XuhpX5Xy+AmdTxEr0QconrM00RyDm/UdXY=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=AsdxIAg+F0mmU8xLtS285CIFiOgbi3Nq0/LFvbkT5/t6Sy4eQqmwp5I2wwqNCnBZm
         SYlMbIl9H+ZO9k382nRanwhucO7DIZKhyoSGndWseJweTTlazsCD+695oMhADOFMR0
         35UyY0KUgxcWRkGL+zb9MBIpskCfEICBkHKzwQVc=
Received: from [192.168.211.36] (192.168.211.36) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Feb 2023 16:34:14 +0300
Message-ID: <878105e3-d075-4d4e-5c47-3f22f95e23c8@paragon-software.com>
Date:   Wed, 15 Feb 2023 17:34:13 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH 01/11] fs/ntfs3: Use bh_read to simplify code
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

The duplicating code is replaced by a generic function bh_read()

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/file.c  | 10 ++--------
  fs/ntfs3/inode.c |  1 +
  2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index d294cd975688..d37df7376543 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -223,16 +223,10 @@ static int ntfs_zero_range(struct inode *inode, 
u64 vbo, u64 vbo_to)
                  set_buffer_uptodate(bh);

              if (!buffer_uptodate(bh)) {
-                lock_buffer(bh);
-                bh->b_end_io = end_buffer_read_sync;
-                get_bh(bh);
-                submit_bh(REQ_OP_READ, bh);
-
-                wait_on_buffer(bh);
-                if (!buffer_uptodate(bh)) {
+                err = bh_read(bh, 0);
+                if (err < 0) {
                      unlock_page(page);
                      put_page(page);
-                    err = -EIO;
                      goto out;
                  }
              }
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index e80e94325467..5e06299591ed 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -648,6 +648,7 @@ static noinline int ntfs_get_block_vbo(struct inode 
*inode, u64 vbo,
              bh->b_size = block_size;
              off = vbo & (PAGE_SIZE - 1);
              set_bh_page(bh, page, off);
+
              err = bh_read(bh, 0);
              if (err < 0)
                  goto out;
-- 
2.34.1

