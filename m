Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAAC437C21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 19:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhJVRnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhJVRnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:43:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE293C061764;
        Fri, 22 Oct 2021 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vv/KmcqWJK/oFV2TawxBudXMWzXGYV14w9h1+x9j/Xk=; b=4bCE495yXilm7MSgyuKxSR2CG7
        SveJNa+OWSNtIfZ8r1/Vmaonz8kGiRXfzu6dsh7EDj4xeaACDi8SIGmDC0a6MMJ1LuzkKodCIjSMs
        metO5VPB/whe2keXvA1lXLuKtf1ab4umo/j/3cHiQDFEdol1G99/yrSiqTAzOf66liLzKRx4LakVN
        rlf6mSJ+uWXnjigUjR0TKg05oH/f+0KotRamROVUyLtsrDNd4w2m0ZX0H7mGTXgm+c6YHta+3Cubr
        50aEhw9wLgORr41wg5xTMx8KDH7N6diznGqbvSfOJLDUMT8JZPKBbsrn8RsRCSaDGYycTz0ccCL/1
        6A8PzdNw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdyX6-00BeR8-NC; Fri, 22 Oct 2021 17:40:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, brendanhiggins@google.com, yzaikin@google.com,
        sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 2/4] firmware_loader: move builtin build helper to shared library
Date:   Fri, 22 Oct 2021 10:40:39 -0700
Message-Id: <20211022174041.2776969-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022174041.2776969-1-mcgrof@kernel.org>
References: <20211022174041.2776969-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we wanted to use a different directory for building target
builtin firmware it is easier if we just have a shared library
Makefile, and each target directory can then just include it and
populate the respective needed variables. This reduces clutter,
makes things easier to read, and also most importantly allows
us to not have to try to magically adjust only one target
kconfig symbol for built-in firmware files. Trying to do this
can easily end up causing odd build issues if the user is not
careful.

As an example issue, if we are going to try to extend the
FW_LOADER_BUILTIN_FILES list and FW_LOADER_BUILTIN_DIR in case
of a new test firmware builtin support currently our only option
would be modify the defaults of each of these in case test firmware
builtin support was enabled. Defaults however won't augment a prior
setting, and so if FW_LOADER_BUILTIN_DIR="/lib/firmware" and you
and want this to be changed to something like
FW_LOADER_BUILTIN_DIR="drivers/base/firmware_loader/test-builtin"
the change will not take effect as a prior build already had it
set, and the build would fail. Trying to augment / append the
variables in the Makefile just makes this very difficult to
read.

Using a library let's us split up possible built-in targets so
that the user does not have to be involved. This will be used
in a subsequent patch which will add another user to this
built-in firmware library Makefile and demo how to use it outside
of the default FW_LOADER_BUILTIN_DIR and FW_LOADER_BUILTIN_FILES.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/builtin/Makefile | 34 ++-----------------
 .../base/firmware_loader/builtin/lib.Makefile | 32 +++++++++++++++++
 2 files changed, 34 insertions(+), 32 deletions(-)
 create mode 100644 drivers/base/firmware_loader/builtin/lib.Makefile

diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base/firmware_loader/builtin/Makefile
index 7cdd0b5c7384..9b0dc193f6c7 100644
--- a/drivers/base/firmware_loader/builtin/Makefile
+++ b/drivers/base/firmware_loader/builtin/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+include $(srctree)/drivers/base/firmware_loader/builtin/lib.Makefile
+
 obj-y  += main.o
 
 # Create $(fwdir) from $(CONFIG_FW_LOADER_BUILTIN_DIR) -- if it doesn't have a
@@ -8,35 +10,3 @@ fwdir := $(addprefix $(srctree)/,$(filter-out /%,$(fwdir)))$(filter /%,$(fwdir))
 
 firmware  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_FW_LOADER_BUILTIN_FILES)))
 obj-y += $(firmware)
-
-FWNAME    = $(patsubst $(obj)/%.gen.S,%,$@)
-FWSTR     = $(subst $(comma),_,$(subst /,_,$(subst .,_,$(subst -,_,$(FWNAME)))))
-ASM_WORD  = $(if $(CONFIG_64BIT),.quad,.long)
-ASM_ALIGN = $(if $(CONFIG_64BIT),3,2)
-PROGBITS  = $(if $(CONFIG_ARM),%,@)progbits
-
-filechk_fwbin = \
-	echo "/* Generated by $(src)/Makefile */"		;\
-	echo "    .section .rodata"				;\
-	echo "    .p2align 4"					;\
-	echo "_fw_$(FWSTR)_bin:"				;\
-	echo "    .incbin \"$(fwdir)/$(FWNAME)\""		;\
-	echo "_fw_end:"						;\
-	echo "    .section .rodata.str,\"aMS\",$(PROGBITS),1"	;\
-	echo "    .p2align $(ASM_ALIGN)"			;\
-	echo "_fw_$(FWSTR)_name:"				;\
-	echo "    .string \"$(FWNAME)\""			;\
-	echo "    .section .builtin_fw,\"a\",$(PROGBITS)"	;\
-	echo "    .p2align $(ASM_ALIGN)"			;\
-	echo "    $(ASM_WORD) _fw_$(FWSTR)_name"		;\
-	echo "    $(ASM_WORD) _fw_$(FWSTR)_bin"			;\
-	echo "    $(ASM_WORD) _fw_end - _fw_$(FWSTR)_bin"
-
-$(obj)/%.gen.S: FORCE
-	$(call filechk,fwbin)
-
-# The .o files depend on the binaries directly; the .S files don't.
-$(addprefix $(obj)/, $(firmware)): $(obj)/%.gen.o: $(fwdir)/%
-
-targets := $(patsubst $(obj)/%,%, \
-                                $(shell find $(obj) -name \*.gen.S 2>/dev/null))
diff --git a/drivers/base/firmware_loader/builtin/lib.Makefile b/drivers/base/firmware_loader/builtin/lib.Makefile
new file mode 100644
index 000000000000..e979a67acfa7
--- /dev/null
+++ b/drivers/base/firmware_loader/builtin/lib.Makefile
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0
+FWNAME    = $(patsubst $(obj)/%.gen.S,%,$@)
+FWSTR     = $(subst $(comma),_,$(subst /,_,$(subst .,_,$(subst -,_,$(FWNAME)))))
+ASM_WORD  = $(if $(CONFIG_64BIT),.quad,.long)
+ASM_ALIGN = $(if $(CONFIG_64BIT),3,2)
+PROGBITS  = $(if $(CONFIG_ARM),%,@)progbits
+
+filechk_fwbin = \
+	echo "/* Generated by $(src)/Makefile */"		;\
+	echo "    .section .rodata"				;\
+	echo "    .p2align 4"					;\
+	echo "_fw_$(FWSTR)_bin:"				;\
+	echo "    .incbin \"$(fwdir)/$(FWNAME)\""		;\
+	echo "_fw_end:"						;\
+	echo "    .section .rodata.str,\"aMS\",$(PROGBITS),1"	;\
+	echo "    .p2align $(ASM_ALIGN)"			;\
+	echo "_fw_$(FWSTR)_name:"				;\
+	echo "    .string \"$(FWNAME)\""			;\
+	echo "    .section .builtin_fw,\"a\",$(PROGBITS)"	;\
+	echo "    .p2align $(ASM_ALIGN)"			;\
+	echo "    $(ASM_WORD) _fw_$(FWSTR)_name"		;\
+	echo "    $(ASM_WORD) _fw_$(FWSTR)_bin"			;\
+	echo "    $(ASM_WORD) _fw_end - _fw_$(FWSTR)_bin"
+
+$(obj)/%.gen.S: FORCE
+	$(call filechk,fwbin)
+
+# The .o files depend on the binaries directly; the .S files don't.
+$(addprefix $(obj)/, $(firmware)): $(obj)/%.gen.o: $(fwdir)/%
+
+targets := $(patsubst $(obj)/%,%, \
+                                $(shell find $(obj) -name \*.gen.S 2>/dev/null))
-- 
2.30.2

