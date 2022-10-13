Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715585FE3E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJMVLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 17:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJMVLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:11:41 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9CC18F922;
        Thu, 13 Oct 2022 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zxaa0wrHR2Xk0QAem3sMoc/ttgR5Mks9tB52oq2LMoI=; b=dIqmKbS9ZsZSomzzqJQLshwLGd
        Hpi7MiR63y0OnqraByMoaYaKLWJVpZBjjSq2MURwcN8ln/FIqz/f/x2iUdbRep/j0TkhNWW1pW5tJ
        nOcemyt+qiusxHo52qEvdh8O1QwyGFJEChAE80mQTx2DHnNSZkJ45Bo/dMyODtRaNMZEA4TiUOasN
        qlVoN2P/lFJz9N23Tf45XgfgewIf0QhDp/1lk9rIGZ01FLiwGTfyUpVwtmu50urQUediF1V+zK2OP
        9hEQPQhT6HBDzUF3K5W74HOdvkj6s29Ou/IYvqwVSMZ2QFKDSTpWwxDJ1Bet68fYfuFu9ACMD1jCm
        1L7ts2Fg==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oj5UL-0010za-VR; Thu, 13 Oct 2022 23:11:34 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        ardb@kernel.org, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH V2 3/3] efi: pstore: Add module parameter for setting the record size
Date:   Thu, 13 Oct 2022 18:06:48 -0300
Message-Id: <20221013210648.137452-4-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013210648.137452-1-gpiccoli@igalia.com>
References: <20221013210648.137452-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By default, the efi-pstore backend hardcode the UEFI variable size
as 1024 bytes. The historical reasons for that were discussed by
Ard in threads [0][1]:

"there is some cargo cult from prehistoric EFI times going
on here, it seems. Or maybe just misinterpretation of the maximum
size for the variable *name* vs the variable itself.".

"OVMF has
OvmfPkg/OvmfPkgX64.dsc:
gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x2000
OvmfPkg/OvmfPkgX64.dsc:
gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x8400

where the first one is without secure boot and the second with secure
boot. Interestingly, the default is

gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x400

so this is probably where this 1k number comes from."

With that, and since there is not such a limit in the UEFI spec, we
have the confidence to hereby add a module parameter to enable advanced
users to change the UEFI record size for efi-pstore data collection,
this way allowing a much easier reading of the collected log, which is
not scattered anymore among many small files.

Through empirical analysis we observed that extreme low values (like 8
bytes) could eventually cause writing issues, so given that and the OVMF
default discussed, we limited the minimum value to 1024 bytes, which also
is still the default.

[0] https://lore.kernel.org/lkml/CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com/
[1] https://lore.kernel.org/lkml/CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com/

Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V2:
- Fixed a memory corruption bug in the code (that wasn't causing
trouble before due to the fixed sized of record_size), thanks
Ard for spotting this!

- Added Ard's archeology in the commit message plus a comment
with the reasoning behind the minimum value.


 drivers/firmware/efi/efi-pstore.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 97a9e84840a0..827e32427ddb 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -10,7 +10,9 @@ MODULE_IMPORT_NS(EFIVAR);
 
 #define DUMP_NAME_LEN 66
 
-#define EFIVARS_DATA_SIZE_MAX 1024
+static unsigned int record_size = 1024;
+module_param(record_size, uint, 0444);
+MODULE_PARM_DESC(record_size, "size of each pstore UEFI var (in bytes, min/default=1024)");
 
 static bool efivars_pstore_disable =
 	IS_ENABLED(CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE);
@@ -30,7 +32,7 @@ static int efi_pstore_open(struct pstore_info *psi)
 	if (err)
 		return err;
 
-	psi->data = kzalloc(EFIVARS_DATA_SIZE_MAX, GFP_KERNEL);
+	psi->data = kzalloc(record_size, GFP_KERNEL);
 	if (!psi->data)
 		return -ENOMEM;
 
@@ -52,7 +54,7 @@ static inline u64 generic_id(u64 timestamp, unsigned int part, int count)
 static int efi_pstore_read_func(struct pstore_record *record,
 				efi_char16_t *varname)
 {
-	unsigned long wlen, size = EFIVARS_DATA_SIZE_MAX;
+	unsigned long wlen, size = record_size;
 	char name[DUMP_NAME_LEN], data_type;
 	efi_status_t status;
 	int cnt;
@@ -133,7 +135,7 @@ static ssize_t efi_pstore_read(struct pstore_record *record)
 	efi_status_t status;
 
 	for (;;) {
-		varname_size = EFIVARS_DATA_SIZE_MAX;
+		varname_size = record_size;
 
 		/*
 		 * If this is the first read() call in the pstore enumeration,
@@ -224,11 +226,20 @@ static __init int efivars_pstore_init(void)
 	if (efivars_pstore_disable)
 		return 0;
 
-	efi_pstore_info.buf = kmalloc(4096, GFP_KERNEL);
+	/*
+	 * Notice that 1024 is the minimum here to prevent issues with
+	 * decompression algorithms that were spotted during tests;
+	 * even in the case of not using compression, smaller values would
+	 * just pollute more the pstore FS with many small collected files.
+	 */
+	if (record_size < 1024)
+		record_size = 1024;
+
+	efi_pstore_info.buf = kmalloc(record_size, GFP_KERNEL);
 	if (!efi_pstore_info.buf)
 		return -ENOMEM;
 
-	efi_pstore_info.bufsize = 1024;
+	efi_pstore_info.bufsize = record_size;
 
 	if (pstore_register(&efi_pstore_info)) {
 		kfree(efi_pstore_info.buf);
-- 
2.38.0

