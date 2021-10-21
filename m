Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1032436705
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 17:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhJUQBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhJUQBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:01:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2535BC061226;
        Thu, 21 Oct 2021 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Sg7U2bCbLjaubYtMWf6IzjmNz2LnCsp1x7XoP4U68JU=; b=ogHhjRNkjyPDqQLNp4Mfd5iqBo
        okXQObmasarUlogRW1S5X3DDjzrjRqRXbOyyajeNyYNGJGy5HONN9giCCAvHcawONd2LEFQ47TURq
        QW8Ze5Y076B7MPxVR/ot+Y05Yb6JTQMCoROX3cnv/MZF45sKeZyracRd0IaCiOr0qs5wpKSPtaZL0
        1xReOt3awB6K7jCLRzDGIbBhHJYp+8hf+hRdq6PddTGWQHS/ZUf6zurc+Y59QTLBNiWggbJWnTEx+
        /vxz18f2U7kS9mwFf9n+Jxhrt1Vcny2EyFK5BkqmhmK+/sVlVkfTnrBhaw8GJ9DYBsVvEYNFeDcUo
        teSLJjdw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdaSq-008GM2-EN; Thu, 21 Oct 2021 15:58:44 +0000
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
Subject: [PATCH v2 03/10] x86/microcode: Use the firmware_loader built-in API
Date:   Thu, 21 Oct 2021 08:58:36 -0700
Message-Id: <20211021155843.1969401-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021155843.1969401-1-mcgrof@kernel.org>
References: <20211021155843.1969401-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The microcode loader has been looping through __start_builtin_fw down to
__end_builtin_fw to look for possibly built-in firmware for microcode
updates.

Now that the firmware loader code has exported an API for looping
through the kernel's built-in firmware section, use it and drop the x86
implementation in favor.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/x86/include/asm/microcode.h      |  3 ---
 arch/x86/kernel/cpu/microcode/amd.c   | 14 ++++++++++----
 arch/x86/kernel/cpu/microcode/core.c  | 17 -----------------
 arch/x86/kernel/cpu/microcode/intel.c |  9 ++++++++-
 4 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index ab45a220fac4..d6bfdfb0f0af 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -130,14 +130,11 @@ static inline unsigned int x86_cpuid_family(void)
 extern void __init load_ucode_bsp(void);
 extern void load_ucode_ap(void);
 void reload_early_microcode(void);
-extern bool get_builtin_firmware(struct cpio_data *cd, const char *name);
 extern bool initrd_gone;
 #else
 static inline void __init load_ucode_bsp(void)			{ }
 static inline void load_ucode_ap(void)				{ }
 static inline void reload_early_microcode(void)			{ }
-static inline bool
-get_builtin_firmware(struct cpio_data *cd, const char *name)	{ return false; }
 #endif
 
 #endif /* _ASM_X86_MICROCODE_H */
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 3d4a48336084..8b2fcdfa6d31 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -456,17 +456,23 @@ apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_p
 
 static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
 {
-#ifdef CONFIG_X86_64
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
+	struct firmware fw;
+
+	if (IS_ENABLED(CONFIG_X86_32))
+		return false;
 
 	if (family >= 0x15)
 		snprintf(fw_name, sizeof(fw_name),
 			 "amd-ucode/microcode_amd_fam%.2xh.bin", family);
 
-	return get_builtin_firmware(cp, fw_name);
-#else
+	if (firmware_request_builtin(&fw, fw_name)) {
+		cp->size = fw.size;
+		cp->data = (void *)fw.data;
+		return true;
+	}
+
 	return false;
-#endif
 }
 
 static void __load_ucode_amd(unsigned int cpuid_1_eax, struct cpio_data *ret)
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index efb69be41ab1..f955d25076ba 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -140,23 +140,6 @@ static bool __init check_loader_disabled_bsp(void)
 	return *res;
 }
 
-extern struct builtin_fw __start_builtin_fw[];
-extern struct builtin_fw __end_builtin_fw[];
-
-bool get_builtin_firmware(struct cpio_data *cd, const char *name)
-{
-	struct builtin_fw *b_fw;
-
-	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++) {
-		if (!strcmp(name, b_fw->name)) {
-			cd->size = b_fw->size;
-			cd->data = b_fw->data;
-			return true;
-		}
-	}
-	return false;
-}
-
 void __init load_ucode_bsp(void)
 {
 	unsigned int cpuid_1_eax;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 7e8e07bddd5f..d28a9f8f3fec 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -456,6 +456,7 @@ static void save_mc_for_early(struct ucode_cpu_info *uci, u8 *mc, unsigned int s
 static bool load_builtin_intel_microcode(struct cpio_data *cp)
 {
 	unsigned int eax = 1, ebx, ecx = 0, edx;
+	struct firmware fw;
 	char name[30];
 
 	if (IS_ENABLED(CONFIG_X86_32))
@@ -466,7 +467,13 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
 	sprintf(name, "intel-ucode/%02x-%02x-%02x",
 		      x86_family(eax), x86_model(eax), x86_stepping(eax));
 
-	return get_builtin_firmware(cp, name);
+	if (firmware_request_builtin(&fw, name)) {
+		cp->size = fw.size;
+		cp->data = (void *)fw.data;
+		return true;
+	}
+
+	return false;
 }
 
 /*
-- 
2.30.2

