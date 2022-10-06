Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A98D5F7157
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 00:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiJFWpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 18:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiJFWpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:45:05 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97291F9D7;
        Thu,  6 Oct 2022 15:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4iG63sk4vA6rn/yAYwNv2iOxQi+fqpBsYdlN8BwQs3A=; b=GkBjgu1/TVuhbldpcnc9P5tti3
        fnR6oQ6kIP4TQki6ka9doaNPif02IOOkEjMnGnAlVcsZ2m4RzPJ+yvOGo8qoVyze/TPi5tWWb8MI3
        oCBDPPriCA2cFUpDVFSJmXQaAVQLMke85iDWY1+uNe3gvVv6urKd3mmi3X9RoA8wqesPzRlKDjB3j
        1aWnPZIVemONMM1xqbmT7xLJhKuPPmVFAAC50BMWJeHt+oSivHwDSEz3RbTe2FBRy+3dUX6vqD+fE
        lpJKYy1wm7aSLThNt8T210VQD3WKY70L39mqJ3LrkLV/6sKgxk2RmIcq+R3TK85H/DxiwCAyaSY4y
        A4sCdKRQ==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ogZbv-00C4T8-QL; Fri, 07 Oct 2022 00:45:00 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 8/8] efi: pstore: Add module parameter for setting the record size
Date:   Thu,  6 Oct 2022 19:42:12 -0300
Message-Id: <20221006224212.569555-9-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221006224212.569555-1-gpiccoli@igalia.com>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
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
as 1024 bytes. That's not a big deal, but at the same time having
no way to change that in the kernel is a bit bummer for specialized
users - there is not such a limit in the UEFI specification.

So, add here a module parameter to enable advanced users to change
the UEFI record size for efi-pstore data collection.
Through empirical analysis we observed that extreme low values
(like 8 bytes) could eventually cause writing issues, so we limit
the low end to 1024 bytes (which is also the default).

Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/firmware/efi/efi-pstore.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 97a9e84840a0..78c27f6a83aa 100644
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
@@ -224,11 +226,14 @@ static __init int efivars_pstore_init(void)
 	if (efivars_pstore_disable)
 		return 0;
 
+	if (record_size < 1024)
+		record_size = 1024;
+
 	efi_pstore_info.buf = kmalloc(4096, GFP_KERNEL);
 	if (!efi_pstore_info.buf)
 		return -ENOMEM;
 
-	efi_pstore_info.bufsize = 1024;
+	efi_pstore_info.bufsize = record_size;
 
 	if (pstore_register(&efi_pstore_info)) {
 		kfree(efi_pstore_info.buf);
-- 
2.38.0

