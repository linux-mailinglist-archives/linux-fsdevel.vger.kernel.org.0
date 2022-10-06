Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE905F714E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 00:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiJFWoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 18:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiJFWoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:44:19 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8A9F2536;
        Thu,  6 Oct 2022 15:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KLu43BdB40PAFi1kbT/ShHwcA3VOit69eMAzfYRiS0E=; b=AXp8Xp2pvGCESaKsozgFRLSAOh
        +QgLqPXphRCM4paPJUSABdiveLT5PZd2v30d3zkPpmATiiNLyBkVzg/A3z9Jmaj7Xz8hhIbNCXV0f
        bkqH558/OuBEMRtZYGm6xMEA4LvOsOwVV1taDNe15xxytOUkpe4oqcnrPytBZBSB0RxkRc+JFMvDN
        5JW0Hcun5BxkBn1dsvganpNqDyE34DtmujEvFWYP/u67F8cmXJTh7EzDXdgB8tiS0IwMG36x1Xa/P
        /kr8VwhbAm4hQupMUQOeDZDBZ8EUbpR7qX534f0hHk1ijTyi4MeX31wHotYDUAiNXTuCDfzuaSszM
        gG8r9NBQ==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ogZbD-00C4PM-6J; Fri, 07 Oct 2022 00:44:16 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5/8] pstore: Fix long-term implicit conversions in the compression routines
Date:   Thu,  6 Oct 2022 19:42:09 -0300
Message-Id: <20221006224212.569555-6-gpiccoli@igalia.com>
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

The pstore infrastructure is capable of compressing collected logs,
relying for that in many compression "libraries" present on kernel.
Happens that the (de)compression code in pstore performs many
implicit conversions from unsigned int/size_t to int, and vice-versa.
Specially in the compress buffer size calculation, we notice that
even the libs are not consistent, some of them return int, most of
them unsigned int and others rely on preprocessor calculation.

Here is an attempt to make it consistent: since we're talking
about buffer sizes, let's go with unsigned types, since negative
sizes don't make sense.

While at it, improve pstore_compress() return semantic too. This
function returns either some potential error or the size of the
compressed buffer. Such output size is a parameter, so changing it
to a pointer makes sense, even follows the compression libraries
API (that does modify its parameter with the output size).

In order to remove such ambiguity in the return of the function,
was required to validate that all compression libraries return
either 0 on success or some negative value on error - our analysis
showed that all compress libraries potentially used by pstore
do respect that [kudos to sw842_compress() as the most convoluted
return semantic among them all!].

Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/pstore/platform.c | 46 ++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index ee50812fdd2e..c10bfb8346fe 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -98,7 +98,7 @@ MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 static struct crypto_comp *tfm;
 
 struct pstore_zbackend {
-	int (*zbufsize)(size_t size);
+	unsigned int (*zbufsize)(size_t size);
 	const char *name;
 };
 
@@ -169,9 +169,9 @@ static bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
 }
 
 #if IS_ENABLED(CONFIG_PSTORE_DEFLATE_COMPRESS)
-static int zbufsize_deflate(size_t size)
+static unsigned int zbufsize_deflate(size_t size)
 {
-	size_t cmpr;
+	unsigned int cmpr;
 
 	switch (size) {
 	/* buffer range for efivars */
@@ -198,28 +198,28 @@ static int zbufsize_deflate(size_t size)
 #endif
 
 #if IS_ENABLED(CONFIG_PSTORE_LZO_COMPRESS)
-static int zbufsize_lzo(size_t size)
+static unsigned int zbufsize_lzo(size_t size)
 {
 	return lzo1x_worst_compress(size);
 }
 #endif
 
 #if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
-static int zbufsize_lz4(size_t size)
+static unsigned int zbufsize_lz4(size_t size)
 {
-	return LZ4_compressBound(size);
+	return (unsigned int)LZ4_compressBound(size);
 }
 #endif
 
 #if IS_ENABLED(CONFIG_PSTORE_842_COMPRESS)
-static int zbufsize_842(size_t size)
+static unsigned int zbufsize_842(size_t size)
 {
 	return size;
 }
 #endif
 
 #if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
-static int zbufsize_zstd(size_t size)
+static unsigned int zbufsize_zstd(size_t size)
 {
 	return zstd_compress_bound(size);
 }
@@ -267,27 +267,27 @@ static const struct pstore_zbackend zbackends[] = {
 	{ }
 };
 
-static int pstore_compress(const void *in, void *out,
-			   unsigned int inlen, unsigned int outlen)
+static bool pstore_compress(const void *in, void *out,
+			   unsigned int inlen, unsigned int *outlen)
 {
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS))
 		return -EINVAL;
 
-	ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
+	ret = crypto_comp_compress(tfm, in, inlen, out, outlen);
 	if (ret) {
 		pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
-		return ret;
+		return false;
 	}
 
-	return outlen;
+	return true;
 }
 
 static void allocate_buf_for_compression(void)
 {
 	struct crypto_comp *ctx;
-	int size;
+	unsigned int size;
 	char *buf;
 
 	/* Skip if not built-in or compression backend not selected yet. */
@@ -304,15 +304,15 @@ static void allocate_buf_for_compression(void)
 	}
 
 	size = zbackend->zbufsize(psinfo->bufsize);
-	if (size <= 0) {
-		pr_err("Invalid compression size for %s: %d\n",
+	if (!size) {
+		pr_err("Invalid compression size for %s: %u\n",
 		       zbackend->name, size);
 		return;
 	}
 
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf) {
-		pr_err("Failed %d byte compression buffer allocation for: %s\n",
+		pr_err("Failed %u byte compression buffer allocation for: %s\n",
 		       size, zbackend->name);
 		return;
 	}
@@ -414,7 +414,6 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		char *dst;
 		size_t dst_size;
 		int header_size;
-		int zipped_len = -1;
 		size_t dump_size;
 		struct pstore_record record;
 
@@ -444,13 +443,10 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 			break;
 
 		if (big_oops_buf) {
-			zipped_len = pstore_compress(dst, psinfo->buf,
-						header_size + dump_size,
-						psinfo->bufsize);
-
-			if (zipped_len > 0) {
+			record.size = psinfo->bufsize;
+			if (pstore_compress(dst, psinfo->buf,
+			    header_size + dump_size, (unsigned int *)&record.size)) {
 				record.compressed = true;
-				record.size = zipped_len;
 			} else {
 				record.size = copy_kmsg_to_buffer(header_size,
 								  dump_size);
@@ -677,7 +673,7 @@ EXPORT_SYMBOL_GPL(pstore_unregister);
 static void decompress_record(struct pstore_record *record)
 {
 	int ret;
-	int unzipped_len;
+	unsigned int unzipped_len;
 	char *unzipped, *workspace;
 
 	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !record->compressed)
-- 
2.38.0

