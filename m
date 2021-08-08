Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A113E3B6F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhHHQZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232024AbhHHQZm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E395261181;
        Sun,  8 Aug 2021 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439923;
        bh=5u2bH7VJtM/e+LvuxtpQp+PsRT4F9kDqvViUS/4AlLc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VNZD/+/toD+1ZXHutTrnUuA/X4YKv2DDfY8fFHiCGmZWaj/BO1eAHk4zAGDvdTs9D
         nL40mtNrXob1hY4WSEBkih48b7aVpNXD1XdIwBPUjHu+R+ompbR+FElwH1aU4K9IS3
         FrnfKMNx8S+WFLrSMlR7BOwcrH1hL5kwJpLOH8ZCw6VbJGOkBmIoamPXUvgZMAda6H
         06h3CtuWa/Sq8XQ9YbhKlUxq3l/ixjgf+QswdEOR2nieVKCdtX3HCjcBphPjNrs9a6
         K6gMmRS4+yl1Ub+EDMytsUCZvrdQx+KbsP8rAa+TTWx0t5M5nPDdxt3MWBJV14yDfk
         Et1t9ytlsTEaQ==
Received: by pali.im (Postfix)
        id A155D1430; Sun,  8 Aug 2021 18:25:22 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 20/20] nls: Drop broken nls_utf8 module
Date:   Sun,  8 Aug 2021 18:24:53 +0200
Message-Id: <20210808162453.1653-21-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NLS table for utf8 is broken and cannot be fixed.

Now that all filesystems are using utf8s_to_utf16s()/utf16s_to_utf8s()
functions for converting between UTF-8 and UTF-16, and functions
utf8_to_utf32()/utf32_to_utf8() for converting between UTF-8 and Unicode
code points, there is no need to have this broken utf8 NLS module in kernel
tree anymore.

There is no user of this utf8 NLS module, so completely drop it,

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/nls/Kconfig    |  9 -------
 fs/nls/Makefile   |  1 -
 fs/nls/nls_utf8.c | 67 -----------------------------------------------
 3 files changed, 77 deletions(-)
 delete mode 100644 fs/nls/nls_utf8.c

diff --git a/fs/nls/Kconfig b/fs/nls/Kconfig
index c7857e36adbb..8f82cf30a493 100644
--- a/fs/nls/Kconfig
+++ b/fs/nls/Kconfig
@@ -608,13 +608,4 @@ config NLS_MAC_TURKISH
 
 	  If unsure, say Y.
 
-config NLS_UTF8
-	tristate "NLS UTF-8"
-	help
-	  If you want to display filenames with native language characters
-	  from the Microsoft FAT file system family or from JOLIET CD-ROMs
-	  correctly on the screen, you need to include the appropriate
-	  input/output character sets. Say Y here for the UTF-8 encoding of
-	  the Unicode/ISO9646 universal character set.
-
 endif # NLS
diff --git a/fs/nls/Makefile b/fs/nls/Makefile
index ac54db297128..e573db7fc173 100644
--- a/fs/nls/Makefile
+++ b/fs/nls/Makefile
@@ -42,7 +42,6 @@ obj-$(CONFIG_NLS_ISO8859_14)	+= nls_iso8859-14.o
 obj-$(CONFIG_NLS_ISO8859_15)	+= nls_iso8859-15.o
 obj-$(CONFIG_NLS_KOI8_R)	+= nls_koi8-r.o
 obj-$(CONFIG_NLS_KOI8_U)	+= nls_koi8-u.o nls_koi8-ru.o
-obj-$(CONFIG_NLS_UTF8)		+= nls_utf8.o
 obj-$(CONFIG_NLS_MAC_CELTIC)    += mac-celtic.o
 obj-$(CONFIG_NLS_MAC_CENTEURO)  += mac-centeuro.o
 obj-$(CONFIG_NLS_MAC_CROATIAN)  += mac-croatian.o
diff --git a/fs/nls/nls_utf8.c b/fs/nls/nls_utf8.c
deleted file mode 100644
index afcfbc4a14db..000000000000
--- a/fs/nls/nls_utf8.c
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- * Module for handling utf8 just like any other charset.
- * By Urban Widmark 2000
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/nls.h>
-#include <linux/errno.h>
-
-static unsigned char identity[256];
-
-static int uni2char(wchar_t uni, unsigned char *out, int boundlen)
-{
-	int n;
-
-	if (boundlen <= 0)
-		return -ENAMETOOLONG;
-
-	n = utf32_to_utf8(uni, out, boundlen);
-	if (n < 0) {
-		*out = '?';
-		return -EINVAL;
-	}
-	return n;
-}
-
-static int char2uni(const unsigned char *rawstring, int boundlen, wchar_t *uni)
-{
-	int n;
-	unicode_t u;
-
-	n = utf8_to_utf32(rawstring, boundlen, &u);
-	if (n < 0 || u > MAX_WCHAR_T) {
-		*uni = 0x003f;	/* ? */
-		return -EINVAL;
-	}
-	*uni = (wchar_t) u;
-	return n;
-}
-
-static struct nls_table table = {
-	.charset	= "utf8",
-	.uni2char	= uni2char,
-	.char2uni	= char2uni,
-	.charset2lower	= identity,	/* no conversion */
-	.charset2upper	= identity,
-};
-
-static int __init init_nls_utf8(void)
-{
-	int i;
-	for (i=0; i<256; i++)
-		identity[i] = i;
-
-        return register_nls(&table);
-}
-
-static void __exit exit_nls_utf8(void)
-{
-        unregister_nls(&table);
-}
-
-module_init(init_nls_utf8)
-module_exit(exit_nls_utf8)
-MODULE_LICENSE("Dual BSD/GPL");
-- 
2.20.1

