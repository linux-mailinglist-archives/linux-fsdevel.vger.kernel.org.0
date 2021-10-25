Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06E443A447
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbhJYUUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbhJYUTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:19:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0498C09F4E9;
        Mon, 25 Oct 2021 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vv/KmcqWJK/oFV2TawxBudXMWzXGYV14w9h1+x9j/Xk=; b=IcQsV3cCOf37xxh7u26fU8ULIf
        MVUe5t5gE75wAakBsRjx4FOdjxD/nO/2hrhJmCs8x94gvd88oopL80mfX40HqQhZz3SU73QBS0o/0
        SsGuJiDEk5XwQFnxVJ9aHBQXyWeDjkRp28jakHeM9YEg+qYGCypJK5QsKjhDbtKu7t2UUQfiurNxy
        V+Jl0u97Hco/1OlLW2xpCVEeimfkhSGkri1Nh1o4WZoEAUFWvVGnsASQM2cIOxqX8+JGfnhLi/eyv
        8dUSdUBbAwWI2kNvMeQFk9ltDXaDz5jsDihyw0sY3NnOL5f7gieqM+KInizuc++LGXnIc4JiK811D
        +C4SFatA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf5zM-00HUbh-Vg; Mon, 25 Oct 2021 19:50:32 +0000
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
Subject: [PATCH v4 2/4] firmware_loader: move builtin build helper to shared library
Date:   Mon, 25 Oct 2021 12:50:29 -0700
Message-Id: <20211025195031.4169165-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025195031.4169165-1-mcgrof@kernel.org>
References: <20211025195031.4169165-1-mcgrof@kernel.org>
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

