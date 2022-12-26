Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6967365634D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiLZOXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiLZOWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E136302;
        Mon, 26 Dec 2022 06:22:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EF6360EB3;
        Mon, 26 Dec 2022 14:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CF0C433F1;
        Mon, 26 Dec 2022 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064540;
        bh=5u2bH7VJtM/e+LvuxtpQp+PsRT4F9kDqvViUS/4AlLc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tYsbgvlgOJaF8H1SdFzVwT/R2HizKskvG/7ePvtZ1Zah8Nowv0dae2/QH1uUXQEqN
         tX4oe095AgKLScJipg2QqH6fNYTdZPSsTR0sYqL/rSidlPk6T0S7zfLoTVNYWh65nG
         zuZYflHj8oifrjrkkGFs9qvR7uvaXg0ZiRsEK+oaBK/3425Ow6YEgPrqkj3OvCty7+
         J0F/0Nw1OTfl5g4GFaxoQXERgnMDONqMT3jkeLy4zuNVil9TnTAV0R6SM7irCbfJ81
         kvQ/bXiol65QJi1ZruhYHP+0nhxUyS8O1Zdk72l1CUaWTszATm4fxQLZIxpCKc/1Vw
         rJiMOl47B5OIw==
Received: by pali.im (Postfix)
        id 2D6729D7; Mon, 26 Dec 2022 15:22:20 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v2 18/18] nls: Drop broken nls_utf8 module
Date:   Mon, 26 Dec 2022 15:21:50 +0100
Message-Id: <20221226142150.13324-19-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226142150.13324-1-pali@kernel.org>
References: <20221226142150.13324-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

