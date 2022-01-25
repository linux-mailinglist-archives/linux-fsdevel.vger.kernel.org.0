Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF33449ACB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 07:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376349AbiAYGuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 01:50:03 -0500
Received: from condef-06.nifty.com ([202.248.20.71]:33271 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359242AbiAYGrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:47:32 -0500
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-06.nifty.com with ESMTP id 20P6iEZM015119;
        Tue, 25 Jan 2022 15:44:14 +0900
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 20P6edB5010638;
        Tue, 25 Jan 2022 15:40:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 20P6edB5010638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1643092840;
        bh=TbWmOZ8d8pmojx/2X1ZY7sbtSi55pkmlSEYND/PsdLs=;
        h=From:To:Cc:Subject:Date:From;
        b=fd45ghN/4u0yHPlNfIEPEQbWadJLXy6My9eYwb5hkMQOAr5/EX8O55veGpYffoeJR
         a243oUcIPfsh1ePfwQ4oGv16fgh+uLzcKEzL519I+m7/q6rZXujjTiwnrhJTbdoNM/
         swomFk9oywKkNuqyVHXuRfNpBGoEOxbSenpdJfQQ4k/xlv9IC7q8cfcJGDyGKI4NQV
         q31BBUrEgEQiQKu5wPi0Q1Cy7pobGfKHrFF0QCyEAuE3pu0qpdHIo5d7t1GXtZoc1Y
         1v5RmsJH3m8WtlQGxWiVjFq5x6KqOgRnFu/ZkYLeR8B5x4g4PrcR0Mb6UyBK0YBtkH
         GVXq8wLSvUN/Q==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Michal Simek <monstr@monstr.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: unify cmd_copy and cmd_shipped
Date:   Tue, 25 Jan 2022 15:40:27 +0900
Message-Id: <20220125064027.873131-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cmd_copy and cmd_shipped have similar functionality. The difference is
that cmd_copy uses 'cp' while cmd_shipped 'cat'.

Unify them into cmd_copy because this macro name is more intuitive.

Going forward, cmd_copy will use 'cat' to avoid the permission issue.
I also thought of 'cp --no-preserve=mode' but this option is not
mentioned in the POSIX spec [1], so I am keeping the 'cat' command.

[1]: https://pubs.opengroup.org/onlinepubs/009695299/utilities/cp.html
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/microblaze/boot/Makefile     |  2 +-
 arch/microblaze/boot/dts/Makefile |  2 +-
 fs/unicode/Makefile               |  2 +-
 scripts/Makefile.lib              | 12 ++++--------
 usr/Makefile                      |  4 ++--
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index cff570a71946..2b42c370d574 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -29,7 +29,7 @@ $(obj)/simpleImage.$(DTB).ub: $(obj)/simpleImage.$(DTB) FORCE
 	$(call if_changed,uimage)
 
 $(obj)/simpleImage.$(DTB).unstrip: vmlinux FORCE
-	$(call if_changed,shipped)
+	$(call if_changed,copy)
 
 $(obj)/simpleImage.$(DTB).strip: vmlinux FORCE
 	$(call if_changed,strip)
diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
index ef00dd30d19a..b84e2cbb20ee 100644
--- a/arch/microblaze/boot/dts/Makefile
+++ b/arch/microblaze/boot/dts/Makefile
@@ -12,7 +12,7 @@ $(obj)/linked_dtb.o: $(obj)/system.dtb
 # Generate system.dtb from $(DTB).dtb
 ifneq ($(DTB),system)
 $(obj)/system.dtb: $(obj)/$(DTB).dtb
-	$(call if_changed,shipped)
+	$(call if_changed,copy)
 endif
 endif
 
diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index 2f9d9188852b..74ae80fc3a36 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -31,7 +31,7 @@ $(obj)/utf8data.c: $(obj)/mkutf8data $(filter %.txt, $(cmd_utf8data)) FORCE
 else
 
 $(obj)/utf8data.c: $(src)/utf8data.c_shipped FORCE
-	$(call if_changed,shipped)
+	$(call if_changed,copy)
 
 endif
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 79be57fdd32a..40735a3adb54 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -246,20 +246,16 @@ $(foreach m, $(notdir $1), \
 	$(addprefix $(obj)/, $(foreach s, $3, $($(m:%$(strip $2)=%$(s)))))))
 endef
 
-quiet_cmd_copy = COPY    $@
-      cmd_copy = cp $< $@
-
-# Shipped files
+# Copy a file
 # ===========================================================================
 # 'cp' preserves permissions. If you use it to copy a file in read-only srctree,
 # the copy would be read-only as well, leading to an error when executing the
 # rule next time. Use 'cat' instead in order to generate a writable file.
-
-quiet_cmd_shipped = SHIPPED $@
-cmd_shipped = cat $< > $@
+quiet_cmd_copy = COPY    $@
+      cmd_copy = cat $< > $@
 
 $(obj)/%: $(src)/%_shipped
-	$(call cmd,shipped)
+	$(call cmd,copy)
 
 # Commands useful for building a boot image
 # ===========================================================================
diff --git a/usr/Makefile b/usr/Makefile
index cc0d2824e100..59d9e8b07a01 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -3,7 +3,7 @@
 # kbuild file for usr/ - including initramfs image
 #
 
-compress-y					:= shipped
+compress-y					:= copy
 compress-$(CONFIG_INITRAMFS_COMPRESSION_GZIP)	:= gzip
 compress-$(CONFIG_INITRAMFS_COMPRESSION_BZIP2)	:= bzip2
 compress-$(CONFIG_INITRAMFS_COMPRESSION_LZMA)	:= lzma
@@ -37,7 +37,7 @@ endif
 # .cpio.*, use it directly as an initramfs, and avoid double compression.
 ifeq ($(words $(subst .cpio.,$(space),$(ramfs-input))),2)
 cpio-data := $(ramfs-input)
-compress-y := shipped
+compress-y := copy
 endif
 
 endif
-- 
2.32.0

