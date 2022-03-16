Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0D74DB14D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356149AbiCPNY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345149AbiCPNYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:24:23 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66B9140FE;
        Wed, 16 Mar 2022 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647436989; x=1678972989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uhsr+hAyJHTjEB3uy9P7kpjmAwzMxcwAsXBKjsI5b2k=;
  b=N2lEjCZBfO6Wxoezs3ZrfsFEZHPiHahIYSIXfALDdM9oUCGTzKq3XNmC
   CE1aIdKji50HLLyQ3f0gC3MQd3LsaNdtcehrJJKLodgy9cuj9eHPkIc0V
   +jKvGkjMKQpCdd6WZIDcKxU+LE8/CRABO6LcAkO7QWB1daXB/xlTjwoqj
   egAonzxmgyiPyWujKUF36anV8QFkvvFmoSLZLptwJOETf96ZXILbe79rX
   qvxrwJtm66gMrUUfe+hh5BkDOTJxRwNOnCGS2C+oi/jRAbsH+Sn3y4KOz
   kcP0mKicCrZgcnJMv9bR2e0CkQk7mFyS7PBtUpcinePiiWdXhvp7A4L65
   A==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="299654886"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 21:23:09 +0800
IronPort-SDR: DHsl7/8JGLlotVDr6b8x4Cueb3+vkFM3ot5gbwbW10WgRGXhTNuiczo1E8t2VBgWA4c8WyWWHX
 B1cEYS6jTVJS81ICoZpYxSBZsAfwuI5QLRw0PwdcK4ifcADeMWmGWM2KBq7Le2Zn3dw80YP/01
 HM3JVoq6zr2mlbHVb/7nXGIcPO3uSRK40kYcQrVJK3Tds6IBxvpUbrVJZ0gtxaFj1bNQFDq8bJ
 gEPI0OsvTIi6B56/wIsjaOJLeFmHrxhdIqjkY9fMgMgU4nAwS7T0wki2AIor3VhtzXXTCM27LB
 4Ek4RP4GaokDsrpQ5jFqowdF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:54:15 -0700
IronPort-SDR: 7ICxNgif4XgkY2QAIJV85q0m8sytyrsLRX9hdRwnYeFComOZnwJNi92XrC3or07giHjP/99NVs
 fuDJZBs4hLGoFE3phhGNzWTHhE+Q4n/hwaH7HP0GF/9mH4Uve3XDwOlW2xWBY3gMJ7vw2mVKX2
 7+gq1nfmWx2F/RClbne3WFVnzI4LZZztDFDbqBZ0zp9LI35P8y3q663PWd/tMK8XxFuUT/U7eq
 1Dzn1LkIBpkZ7OrdcU2a6T+mmX2UmbLixMLM6lM4oDRVwbIFMVn13hRkxYSQEnbDN+r2rDaPAC
 Emk=
WDCIronportException: Internal
Received: from d2bbl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.209])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Mar 2022 06:23:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 3/4] fs: add check functions for sb_start_{write,pagefault,intwrite}
Date:   Wed, 16 Mar 2022 22:22:39 +0900
Message-Id: <0737603ecc6baf785843d6e91992e6ef202c308c.1647436353.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647436353.git.naohiro.aota@wdc.com>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
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

