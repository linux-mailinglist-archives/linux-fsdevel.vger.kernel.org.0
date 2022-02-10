Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D3C4B05FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 07:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiBJGA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 01:00:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiBJGA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:00:26 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DDC10C9;
        Wed,  9 Feb 2022 22:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644472827; x=1676008827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XFkmH/dThKpVF9UvfZz/KfESK70aFHzA7gd+50eJuUQ=;
  b=YhFnA5rKSCsrIVnkUvjsMKy5Tis/sQo3Q7HyUNoW4OjD8hPHhED714Oj
   2ngg7QMKkvxPHfSx98klRwZrcM3N0xmqaf+45QZv38KdsrsC0E+brbGGh
   Hd5p2wFf0ACtcSvdgndgmTTGxgUUbEnPKFL9JvChvozQ3u5dgWIqK76+9
   AwUDBunYHxP8rR0+YF6srJCGsnokvlSGNByv97r8d1Sr566HQiWW8KCm0
   bc42Z639TBOcKcDPiWkCJ9g94i2KwiS/CxwAnnk4+LToYFzJ/iDKsnpnj
   qCnl0syEC4vJFwLUK9puOchX6sz+nExoCpxckd+eQ9FOUhv10mlksGPf/
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,357,1635177600"; 
   d="scan'208";a="191512596"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 13:59:22 +0800
IronPort-SDR: H5ka9EFjzeiZo+yEeTPZGqBXOxPDaL/IeQGz5wnjPOfApVAcbBhn5sOng57Ykd3UajF2FQ9xx/
 Xq8vJatPmr7MxzDrC80IZNApIlqYasoXw6Yv65ohiHEdFk8uLc5kfDlxEVd7bgbdeAP4Ipq8bK
 U8rhMuAklvcshChptmCyRcHC87imlNYrWYpRNLz2Mrbmq1CVZGLduIYr80UZjbv/7QmfGCj/d6
 shAEtP2Z3VPJ5H2UnU8PUO3P0ODqZP+q+AF89OXQTgEX5UyPPjRQE38PyxHl6Wy/aEhnnv9k0N
 44v5rKnZ05vtblB6E74lR72o
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 21:32:20 -0800
IronPort-SDR: XmYoNIDG0DqwfjM8L1IWEzJiU5b6xufsumXvJTqzeQx3K6Y9A89csVBAWxoAWb81HnrY2vB/lF
 qJR4ThW6MWem2BOgOyw5D3jN43KJ9JOjzXWpXsGXBBhin9X7KLypprRMs9XBQ6SzLmwZhjbykj
 IcJfOQopx0xO2DTtv0EG4folwMbwXU8cnIwUYvVoYQroCHREfjh6JN2haWPsc0/buDHKBZSq+8
 9aJqNxjRHIXfxItUTcqlJqAQ8UhvsrNF6ZkhnF7HygT1DhTkADGJtgscNAmMUoG5Dv4bzX7tGB
 oLY=
WDCIronportException: Internal
Received: from chmc3h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.51.94])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2022 21:59:23 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/2] fs: add asserting functions for sb_start_{write,pagefault,intwrite}
Date:   Thu, 10 Feb 2022 14:59:04 +0900
Message-Id: <40cbbef14229eaa34df0cdc576f02a1bd4ba6809.1644469146.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644469146.git.naohiro.aota@wdc.com>
References: <cover.1644469146.git.naohiro.aota@wdc.com>
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

Add an assert function sb_assert_write_started() to check if
sb_start_write() is properly called. It is used in the next commit.

Also, add the assert functions for sb_start_pagefault() and
sb_start_intwrite().

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 include/linux/fs.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbf812ce89a8..5d5dc9a276d9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1820,6 +1820,11 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
 #define __sb_writers_release(sb, lev)	\
 	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
 
+static inline void __sb_assert_write_started(struct super_block *sb, int level)
+{
+	lockdep_assert_held_read(sb->s_writers.rw_sem + level - 1);
+}
+
 /**
  * sb_end_write - drop write access to a superblock
  * @sb: the super we wrote to
@@ -1885,6 +1890,11 @@ static inline bool sb_start_write_trylock(struct super_block *sb)
 	return __sb_start_write_trylock(sb, SB_FREEZE_WRITE);
 }
 
+static inline void sb_assert_write_started(struct super_block *sb)
+{
+	__sb_assert_write_started(sb, SB_FREEZE_WRITE);
+}
+
 /**
  * sb_start_pagefault - get write access to a superblock from a page fault
  * @sb: the super we write to
@@ -1909,6 +1919,11 @@ static inline void sb_start_pagefault(struct super_block *sb)
 	__sb_start_write(sb, SB_FREEZE_PAGEFAULT);
 }
 
+static inline void sb_assert_pagefault_started(struct super_block *sb)
+{
+	__sb_assert_write_started(sb, SB_FREEZE_PAGEFAULT);
+}
+
 /**
  * sb_start_intwrite - get write access to a superblock for internal fs purposes
  * @sb: the super we write to
@@ -1932,6 +1947,11 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
 	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
 }
 
+static inline void sb_assert_intwrite_started(struct super_block *sb)
+{
+	__sb_assert_write_started(sb, SB_FREEZE_FS);
+}
+
 bool inode_owner_or_capable(struct user_namespace *mnt_userns,
 			    const struct inode *inode);
 
-- 
2.35.1

