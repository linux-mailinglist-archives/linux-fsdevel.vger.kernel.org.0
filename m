Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D04D5C89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 08:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbiCKHjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 02:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiCKHjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:39:46 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D6541BD;
        Thu, 10 Mar 2022 23:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646984322; x=1678520322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aYgHb/WNHaZCE/viGgmF46/TgOrl1HXLBvnmPq9KaZE=;
  b=BU0yPepKlURQhdxEW/mxA/qyx01VIzO1PXpvDPADUVKLufBWWXYiD8cN
   P+38h4sqJRvIVjL9pWCiZNQtIV4Qls1pljAuMDUOhvGYcTNOYZLVDrAf4
   vmezzRZUe6HNjYqADMODEdxswOu38kHWQUjrBlLEAZNwNHamUzFs8pfWn
   7tyi32+P4YM1lOMHzy8UX8KyJnW4BJbCICyOiQ76dpuNIXZo65P1L3cLO
   bbO5gXOHIA+/AvvW0OyPV+OhIjwm0xi1EVwMcgeCEXUDR5O0NWbVwPteu
   xwMG/7cp0fdeUMmB7iTmPr8JmWEgap5iGT5GQTkInFdAMxWWeXaukbEAa
   g==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643644800"; 
   d="scan'208";a="199899092"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 15:38:42 +0800
IronPort-SDR: BSm/FnfXWcKDfSEVy0WBY55ecVAL4kpz6MF4KoqHzr9FE5KFewuPoFBtB51ssFc57JELwg6CnO
 Q2t+UdsT75ZdWTRPojet6rYVKpHBoO7Abc/Br84ABFzGkaxdqY14NdKywI3YuZH5QfbkSXqnv7
 if5zP26xLcDrRXbXyGXYES6at3LXwemHWJEq5KBO/2oqRxcWwDXs2xcM0bSn5AncZgVjKwM+4H
 KXW/f1m6wbYktoYJDHFbA23oCmRHdZXnj5U/8N126WZFBLQ9SY+KFfO0s+SmU5S4fpZ4uPHelD
 9a8aa6mmLfn108gMTFFhlPcs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:10:57 -0800
IronPort-SDR: fP4GHn30tO29Dw65gM+OCjtZ2ZtJPv9W5/3+aobzo9C8Pn0LM7YWyNZPaw3bkOVp4qWyL4d2bG
 avweEz9L2wOcSzmoS9IAkEamM8sRSMpopKN2JPlnilh2WtQTXRrq2ogi7NaWCpacqvNwYEaIkG
 738rHsm3K1AKEB4TiSbyXEr5ryNaqMRi1xmmXxhgGKU3hPuqoBJYjZ9BnotaTX6P3zJsr1Fdup
 +7iUE0tzW4MrYBH9cCQssFDJKS5OV5MYRGLdNIsiMW5w9XrVQ+C8sKrUWuvAllIIHUckWfWEGe
 Wmk=
WDCIronportException: Internal
Received: from dyv5jr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.231])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Mar 2022 23:38:44 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/4] fs: add check functions for sb_start_{write,pagefault,intwrite}
Date:   Fri, 11 Mar 2022 16:38:04 +0900
Message-Id: <407d74293ca164d44eb419d34c2365795e27c02f.1646983176.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646983176.git.naohiro.aota@wdc.com>
References: <cover.1646983176.git.naohiro.aota@wdc.com>
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
index 27746a3da8fd..0c8714d64169 100644
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

