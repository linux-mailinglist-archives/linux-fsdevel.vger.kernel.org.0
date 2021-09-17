Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF9540FF44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbhIQSYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244170AbhIQSYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC9FC061757;
        Fri, 17 Sep 2021 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+bAxPNXEkjOLG0J16lJ79/BZjrPhBIO0OVG4jkta3IU=; b=0iVI7z+X129Mv0/pbPx3RKPj/k
        hxZMBYWuTcr10TBXzIXvlSWek7JhKLJexctVeUzwzM00et4epv9Nqv9BJ7bak9Z8H7tBFuHDCcoyw
        EWdX4D1o6FPa0MLP82YVOLadoF9RIM4LfNMRDL7twHJaB+os60U/5GYRiIl2V559w8p2Wl0SkVWJE
        aJLRFTuPo2U/barhlN8MsMRMLrWHYLiO7g4Nb4QDyaQIgCnWyFCMzfh1gP4vV6GaR0durL++P8I1K
        NzR2JlKf4klU/brjqKaI0qMCV/O22IaNfuYIMKWxZLc3OfKiPcqwcxRqrcdnoKYvivJVgC+dg2K7c
        W4BwdnGw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVI-00Ep5Y-AF; Fri, 17 Sep 2021 18:22:28 +0000
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
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
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 05/14] firmware_loader: formalize built-in firmware API
Date:   Fri, 17 Sep 2021 11:22:17 -0700
Message-Id: <20210917182226.3532898-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917182226.3532898-1-mcgrof@kernel.org>
References: <20210917182226.3532898-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Now that we have a kconfig entry to represent built-in firmware
support, formalize its use with a proper API. This can later be
used by other callers where all they need is built-in firmware.

We export the firmware_request_builtin() call for now only
under the TEST_FIRMWARE symbol namespace as there are no
direct modular users for it. If they pop up they are free
to export it generally. Built-in code always gets access to
the callers and we'll demonstrate a hidden user which has been
lurking in the kernel for a while and the reason why using a
proper API was better long term.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/builtin/Makefile |  6 +-
 drivers/base/firmware_loader/builtin/main.c   | 95 +++++++++++++++++++
 drivers/base/firmware_loader/firmware.h       | 17 ++++
 drivers/base/firmware_loader/main.c           | 78 +--------------
 include/linux/firmware.h                      | 11 +++
 5 files changed, 128 insertions(+), 79 deletions(-)
 create mode 100644 drivers/base/firmware_loader/builtin/main.c

diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base/firmware_loader/builtin/Makefile
index 101754ad48d9..eb4be452062a 100644
--- a/drivers/base/firmware_loader/builtin/Makefile
+++ b/drivers/base/firmware_loader/builtin/Makefile
@@ -1,11 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y  += main.o
 
 # Create $(fwdir) from $(CONFIG_EXTRA_FIRMWARE_DIR) -- if it doesn't have a
 # leading /, it's relative to $(srctree).
 fwdir := $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE_DIR))
 fwdir := $(addprefix $(srctree)/,$(filter-out /%,$(fwdir)))$(filter /%,$(fwdir))
 
-obj-y  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE)))
+firmware  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE)))
+obj-y += $(firmware)
 
 FWNAME    = $(patsubst $(obj)/%.gen.S,%,$@)
 FWSTR     = $(subst $(comma),_,$(subst /,_,$(subst .,_,$(subst -,_,$(FWNAME)))))
@@ -34,7 +36,7 @@ $(obj)/%.gen.S: FORCE
 	$(call filechk,fwbin)
 
 # The .o files depend on the binaries directly; the .S files don't.
-$(addprefix $(obj)/, $(obj-y)): $(obj)/%.gen.o: $(fwdir)/%
+$(addprefix $(obj)/, $(firmware)): $(obj)/%.gen.o: $(fwdir)/%
 
 targets := $(patsubst $(obj)/%,%, \
                                 $(shell find $(obj) -name \*.gen.S 2>/dev/null))
diff --git a/drivers/base/firmware_loader/builtin/main.c b/drivers/base/firmware_loader/builtin/main.c
new file mode 100644
index 000000000000..2af0e58f3f9f
--- /dev/null
+++ b/drivers/base/firmware_loader/builtin/main.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Builtin firmware support */
+
+#include <linux/firmware.h>
+#include "../firmware.h"
+
+extern struct builtin_fw __start_builtin_fw[];
+extern struct builtin_fw __end_builtin_fw[];
+
+static bool fw_copy_to_prealloc_buf(struct firmware *fw,
+				    void *buf, size_t size)
+{
+	if (!buf)
+		return true;
+	if (size < fw->size)
+		return false;
+	memcpy(buf, fw->data, fw->size);
+	return true;
+}
+
+/**
+ * firmware_request_builtin() - load builtin firmware
+ * @fw: pointer to firmware struct
+ * @name: name of firmware file
+ *
+ * Some use cases in the kernel have a requirement so that no memory allocator
+ * is involved as these calls take place early in boot process. An example is
+ * the x86 CPU microcode loader. In these cases all the caller wants is to see
+ * if the firmware was built-in and if so use it right away. This can be used
+ * for such cases.
+ *
+ * This looks for the firmware in the built-in kernel. Only if the kernel was
+ * built-in with the firmware you are looking for will this return successfully.
+ *
+ * Callers of this API do not need to use release_firmware() as the pointer to
+ * the firmware is expected to be provided locally on the stack of the caller.
+ **/
+bool firmware_request_builtin(struct firmware *fw, const char *name)
+{
+	struct builtin_fw *b_fw;
+
+	if (!fw)
+		return false;
+
+	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++) {
+		if (strcmp(name, b_fw->name) == 0) {
+			fw->size = b_fw->size;
+			fw->data = b_fw->data;
+			return true;
+		}
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_NS_GPL(firmware_request_builtin, TEST_FIRMWARE);
+
+/**
+ * firmware_request_builtin_buf() - load builtin firmware into optional buffer
+ * @fw: pointer to firmware struct
+ * @name: name of firmware file
+ * @buf: If set this lets you use a pre-allocated buffer so that the built-in
+ *	firmware into is copied into. This field can be NULL. It is used by
+ *	callers such as request_firmware_into_buf() and
+ *	request_partial_firmware_into_buf()
+ * @size: if buf was provided, the max size of the allocated buffer available.
+ *	If the built-in firmware does not fit into the pre-allocated @buf this
+ *	call will fail.
+ *
+ * This looks for the firmware in the built-in kernel. Only if the kernel was
+ * built-in with the firmware you are looking for will this call possibly
+ * succeed. If you passed a @buf the firmware will be copied into it *iff* the
+ * built-in firmware fits into the pre-allocated buffer size specified in
+ * @size.
+ *
+ * This caller is to be used internally by the firmware_loader only.
+ **/
+bool firmware_request_builtin_buf(struct firmware *fw, const char *name,
+				  void *buf, size_t size)
+{
+	if (!firmware_request_builtin(fw, name))
+		return false;
+
+	return fw_copy_to_prealloc_buf(fw, buf, size);
+}
+
+bool firmware_is_builtin(const struct firmware *fw)
+{
+	struct builtin_fw *b_fw;
+
+	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++)
+		if (fw->data == b_fw->data)
+			return true;
+
+	return false;
+}
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index a3014e9e2c85..7e38827ad006 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -151,6 +151,23 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
 
 int assign_fw(struct firmware *fw, struct device *device);
 
+#ifdef CONFIG_FW_LOADER_BUILTIN
+bool firmware_is_builtin(const struct firmware *fw);
+bool firmware_request_builtin_buf(struct firmware *fw, const char *name,
+				  void *buf, size_t size);
+#else
+static inline bool firmware_is_builtin(const struct firmware *fw)
+{
+	return false;
+}
+static inline bool firmware_request_builtin_buf(struct firmware *fw,
+						const char *name,
+						void *buf, size_t size)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
 void fw_free_paged_buf(struct fw_priv *fw_priv);
 int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed);
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 45075c7f9290..94d1789a233e 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -93,82 +93,6 @@ DEFINE_MUTEX(fw_lock);
 
 static struct firmware_cache fw_cache;
 
-/* Builtin firmware support */
-
-#ifdef CONFIG_FW_LOADER_BUILTIN
-
-extern struct builtin_fw __start_builtin_fw[];
-extern struct builtin_fw __end_builtin_fw[];
-
-static bool fw_copy_to_prealloc_buf(struct firmware *fw,
-				    void *buf, size_t size)
-{
-	if (!buf)
-		return true;
-	if (size < fw->size)
-		return false;
-	memcpy(buf, fw->data, fw->size);
-	return true;
-}
-
-static bool firmware_request_builtin(struct firmware *fw, const char *name)
-{
-	struct builtin_fw *b_fw;
-
-	if (!fw)
-		return false;
-
-	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++) {
-		if (strcmp(name, b_fw->name) == 0) {
-			fw->size = b_fw->size;
-			fw->data = b_fw->data;
-			return true;
-		}
-	}
-
-	return false;
-}
-
-static bool firmware_request_builtin_buf(struct firmware *fw, const char *name,
-					 void *buf, size_t size)
-{
-	if (!firmware_request_builtin(fw, name))
-		return false;
-	return fw_copy_to_prealloc_buf(fw, buf, size);
-}
-
-static bool fw_is_builtin_firmware(const struct firmware *fw)
-{
-	struct builtin_fw *b_fw;
-
-	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++)
-		if (fw->data == b_fw->data)
-			return true;
-
-	return false;
-}
-
-#else
-
-static inline bool firmware_request_builtin(struct firmware *fw,
-					    const char *name)
-{
-	return false;
-}
-
-static inline bool firmware_request_builtin_buf(struct firmware *fw,
-						const char *name, void *buf,
-						size_t size)
-{
-	return false;
-}
-
-static inline bool fw_is_builtin_firmware(const struct firmware *fw)
-{
-	return false;
-}
-#endif
-
 static void fw_state_init(struct fw_priv *fw_priv)
 {
 	struct fw_state *fw_st = &fw_priv->fw_st;
@@ -1068,7 +992,7 @@ EXPORT_SYMBOL(request_partial_firmware_into_buf);
 void release_firmware(const struct firmware *fw)
 {
 	if (fw) {
-		if (!fw_is_builtin_firmware(fw))
+		if (!firmware_is_builtin(fw))
 			firmware_free_data(fw);
 		kfree(fw);
 	}
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 25109192cebe..29d17a05ead6 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -20,12 +20,15 @@ struct firmware {
 struct module;
 struct device;
 
+#ifdef CONFIG_FW_LOADER_BUILTIN
 struct builtin_fw {
 	char *name;
 	void *data;
 	unsigned long size;
 };
 
+bool firmware_request_builtin(struct firmware *fw, const char *name);
+
 /* We have to play tricks here much like stringify() to get the
    __COUNTER__ macro to be expanded as we want it */
 #define __fw_concat1(x, y) x##y
@@ -38,6 +41,14 @@ struct builtin_fw {
 	static const struct builtin_fw __fw_concat(__builtin_fw,__COUNTER__) \
 	__used __section(".builtin_fw") = { name, blob, size }
 
+#else
+static inline bool firmware_request_builtin(struct firmware *fw,
+					    const char *name)
+{
+	return false;
+}
+#endif
+
 #if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
-- 
2.30.2

