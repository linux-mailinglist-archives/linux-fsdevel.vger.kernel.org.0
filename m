Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1C656341C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiGANJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 09:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiGANJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:09:51 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A81B62FD;
        Fri,  1 Jul 2022 06:09:48 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E095621B4;
        Fri,  1 Jul 2022 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656680929;
        bh=wiDeM+XRrwA5/U5QVEV7KWqJSki1m26BRivbZ581EWI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=eNqXwrX0yHLY8RBBgMwYVrJn4CpNuXmoNwqaL8/eopdArXljmFl/U35NnjZfmkUHB
         zEw74duTwrOrHgsVGTSJYKVsLNU5Mkpdy3F7Vaga6/mC8j8BNtGnMVsJyq22z7E1dl
         XTZpegwWd4h1nNz1H0mABfS/Iy+QPzipeyzCQNM0=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Jul 2022 16:09:45 +0300
Message-ID: <011fda2c-3717-b429-dc87-0f1471a735d5@paragon-software.com>
Date:   Fri, 1 Jul 2022 16:09:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [PATCH 1/5] fs/ntfs3: Fix very fragmented case in attr_punch_hole
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <34e58f6e-e508-4ad8-6941-37281ea7d3ef@paragon-software.com>
In-Reply-To: <34e58f6e-e508-4ad8-6941-37281ea7d3ef@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In some cases we need to ni_find_attr attr_b

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c | 13 ++++++++++++-
  1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 59d8f482ef0a..43b9482f9830 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2054,6 +2054,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  				if (err)
  					goto out;
  				/* Layout of records maybe changed. */
+				attr_b = NULL;
  			}
  		}
  		/* Free all allocated memory. */
@@ -2073,6 +2074,14 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  	}
  
  	total_size -= (u64)dealloc << sbi->cluster_bits;
+	if (!attr_b) {
+		attr_b = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL,
+				      &mi_b);
+		if (!attr_b) {
+			err = -EINVAL;
+			goto out;
+		}
+	}
  	attr_b->nres.total_size = cpu_to_le64(total_size);
  	mi_b->dirty = true;
  
@@ -2083,8 +2092,10 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  
  out:
  	up_write(&ni->file.run_lock);
-	if (err)
+	if (err) {
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
  		make_bad_inode(&ni->vfs_inode);
+	}
  
  	return err;
  }
-- 
2.37.0


