Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BC838B6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfFGNSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:18:03 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56451 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfFGNSD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913510; x=1591449510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mcN9WtvQEWdujXnIA7oYPdYlHv79AOG60zJ58+aPVaw=;
  b=SyUKUFgIU2Is/+yrEKogBLJmIgZUpPSi0feq0SPTJ83/FGXHqN8v3J/N
   YQPm1YVwiScLQA9XgzfBGap9cmg5X9nBgUvvJy6V44tSe3euq1joDYU+C
   O/JOhFY9xRKIC7H5y34o+deBpWzXnN8NYkPiqvaWZRdEOwehvx4KZY7hC
   E/nUgKVWXWz47zvfUWf5MbhLul63PUe+Bya0xD68a0TCui/JCEf7AEp+T
   0zqJZUjRt4MIuVL6IJXJqgYUzuloI7oeQl7mfpbDiwbvccU3o882yrnWv
   JXNka0rUVYSTGT+bactc9sU/sDTxESMXYuPe8q4aCQE0kto1/yOtp70WK
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="209674976"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:18:29 +0800
IronPort-SDR: SBbqHnJA5jmRXmt2EGP55K+bxw8dMC9uCdUJLI4j3vysUOhgbXvgMS/IK7yOzPmBxZAyDY67f5
 sl7GVsmQIZ8OoXvhfvZ9HMs0TPNPpVogJM/kLy7GKw577ZxD288HlM1Gac8IVzsmUPOjtJyaa3
 yaGHMt7PHLaDP03vVZijbhznoHxMaH9AU5CpRU7uxDDLqEsVogoWSUdAYswUDCD4RSQiUxWtZd
 b0FBTpCqu6PXBtlnUxIqMMcmOwAkprin+L8FhmLYT0oXp1/EM/ybJRGgBx/q9oQz6rnr2/MkLi
 ptOz4neXnvgm7GY5ogaGco/1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:55:20 -0700
IronPort-SDR: uCGEZ0Cr8PiYRuFSJSdPJVQ2ygdQWLtl5ZOTaxWaNxZ5uUJ8wPn9mI/bAShPxilfe9967eTrdh
 Njp/lHbIUK8ZLUe+QpPApZlrUxiltbLJr9XQ9PWMpcdDoopi0m9RPDOS6ik5uU/Qd8SMiLfB/1
 my/12itXS3Mw7U9MS3ZeOhdKSzW4HFrZXNBKM1jg6e4EqRJoVjpTxe32tyD8lvGQyM9UCniG95
 /4D6Q9wDaX8Kw9C9LlLdeZOgj+mGoQOZ2IxvXgUHbn3leqrg79tB/1KNp4ozbsAtReuxsgE3hz
 2WI=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:18:01 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 01/12] btrfs-progs: build: Check zoned block device support
Date:   Fri,  7 Jun 2019 22:17:40 +0900
Message-Id: <20190607131751.5359-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the kernel supports zoned block devices, the file
/usr/include/linux/blkzoned.h will be present. Check this and define
BTRFS_ZONED if the file is present.

If it present, enables HMZONED feature, if not disable it.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 configure.ac | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure.ac b/configure.ac
index cf792eb5488b..c637f72a8fe6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -206,6 +206,18 @@ else
 AC_DEFINE([HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE], [0], [We did not define FIEMAP_EXTENT_SHARED])
 fi
 
+AC_CHECK_HEADER(linux/blkzoned.h, [blkzoned_found=yes], [blkzoned_found=no])
+AC_ARG_ENABLE([zoned],
+  AS_HELP_STRING([--disable-zoned], [disable zoned block device support]),
+  [], [enable_zoned=$blkzoned_found]
+)
+
+AS_IF([test "x$enable_zoned" = xyes], [
+	AC_CHECK_HEADER(linux/blkzoned.h, [],
+		[AC_MSG_ERROR([Couldn't find linux/blkzoned.h])])
+	AC_DEFINE([BTRFS_ZONED], [1], [enable zoned block device support])
+])
+
 dnl Define <NAME>_LIBS= and <NAME>_CFLAGS= by pkg-config
 dnl
 dnl The default PKG_CHECK_MODULES() action-if-not-found is end the
@@ -307,6 +319,7 @@ AC_MSG_RESULT([
 	btrfs-restore zstd: ${enable_zstd}
 	Python bindings:    ${enable_python}
 	Python interpreter: ${PYTHON}
+	zoned device:       ${enable_zoned}
 
 	Type 'make' to compile.
 ])
-- 
2.21.0

