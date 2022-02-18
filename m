Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DBD4BB091
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 05:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiBREOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 23:14:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiBREOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:14:40 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8674A583B8;
        Thu, 17 Feb 2022 20:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645157665; x=1676693665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hbJQ99/aX/+ekcOTer9bncUdMapvBu4fXoS7fXL0Y6E=;
  b=mM2hjywMtQtKx56bbCwJ365uBlLjtimmajjTW5Zr+BjagvmakJFbfmp8
   qGFj+ohXRRVSFi5CwW5oCU9qOaa3uHZW2gjNFSau8CMZdctHcuuiKb1QO
   ll2L4fs5Ls7/niL4C9/hWtNs506ObxKsxeTZSmQ7Bn2+qbUc+lbKmIdKQ
   bFRdpYX1dZjiOy43AC7IVhyt9D8WVBPNs/9lF3PZWlqiD3KnCyHw+4OVH
   YwSBP276KM6ZpWTLnfsMevB/xnNcHJiGX49clmadZ5N3MLrZTNNn6ZB26
   Pn4qeC/uaGmKlqmuif4iDksIgmKG1WdeIXAu0mKCZY37swQnRdR5c+SJT
   g==;
X-IronPort-AV: E=Sophos;i="5.88,377,1635177600"; 
   d="scan'208";a="194229485"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 12:14:25 +0800
IronPort-SDR: ne+oDq+HZT4GVD+/3qLLn902XXtPHPjPbtF2UXKw68HDJrpRK0r4YTYrBjFm+ZjIyB+8oTkJFV
 FZnKuAcw2ZRAfwiFTIY02kIEPHdnqF2bT1GuW8htBdAA+O21Io93qiA4mknAHpUiPssG1J0zgQ
 jJKnmFSSVvWy/QE4rDEMeTD/ogJW8bq361LzHKbHhqEDU3WdNn82WQodg9CrtTZUhf7QboaZgo
 IEq4F2pO6SGcTKTSPFJcMaVpXrGvY6hGTMl2o0b8ykTafnCkBYOL2s2HyMFsbemygxGTpfclxP
 nNo97ZleP8OgtugLLOkm0nVw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:46:02 -0800
IronPort-SDR: E3pafuPGoQYGF39A3TtzSrsHXFLjowlaDOOpYi96BCuy0nE5ZAba5zOvVti2IT48OaQKIAuL3w
 gAHo6ceJDtF1DGpvIO9SRSPlyAT7I9h7v+ZJJa7Eh/ByDTcnQTKe1loW2xxKjfBl0qLwGijzEz
 UlVVjbDZpmg9WYlBpvJ+y0aHjmfrpSirTkYErzRP8rdK8H0jQmH/b0+2evUifOuA/0U1jh6Uro
 wiBqX7pPwJjljNi1U2GyHG2/t/al2q0fsSsMWNfgQz3mYpUIDuvrz2G1gvXoVStGDQi/+oWk4h
 hlc=
WDCIronportException: Internal
Received: from fdxrrn2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.54.90])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Feb 2022 20:14:23 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 1/2] fs: add asserting functions for sb_start_{write,pagefault,intwrite}
Date:   Fri, 18 Feb 2022 13:14:18 +0900
Message-Id: <1ae764ab433d6f118c3ce20da2789a6c901a6359.1645157220.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645157220.git.naohiro.aota@wdc.com>
References: <cover.1645157220.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function sb_write_started() to return if sb_start_write() is
properly called. It is used in the next commit.

Also, add the similar functions for sb_start_pagefault() and
sb_start_intwrite().

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 include/linux/fs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..8c7d01388feb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1732,6 +1732,11 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
 #define __sb_writers_release(sb, lev)	\
 	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
 
+static inline bool __sb_write_started(struct super_block *sb, int level)
+{
+	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
+}
+
 /**
  * sb_end_write - drop write access to a superblock
  * @sb: the super we wrote to
@@ -1797,6 +1802,11 @@ static inline bool sb_start_write_trylock(struct super_block *sb)
 	return __sb_start_write_trylock(sb, SB_FREEZE_WRITE);
 }
 
+static inline bool sb_write_started(struct super_block *sb)
+{
+	return __sb_write_started(sb, SB_FREEZE_WRITE);
+}
+
 /**
  * sb_start_pagefault - get write access to a superblock from a page fault
  * @sb: the super we write to
@@ -1821,6 +1831,11 @@ static inline void sb_start_pagefault(struct super_block *sb)
 	__sb_start_write(sb, SB_FREEZE_PAGEFAULT);
 }
 
+static inline bool sb_pagefault_started(struct super_block *sb)
+{
+	return __sb_write_started(sb, SB_FREEZE_PAGEFAULT);
+}
+
 /**
  * sb_start_intwrite - get write access to a superblock for internal fs purposes
  * @sb: the super we write to
@@ -1844,6 +1859,11 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
 	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
 }
 
+static inline bool sb_intwrite_started(struct super_block *sb)
+{
+	return __sb_write_started(sb, SB_FREEZE_FS);
+}
+
 bool inode_owner_or_capable(struct user_namespace *mnt_userns,
 			    const struct inode *inode);
 
-- 
2.35.1

