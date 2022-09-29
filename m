Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071BF5EFF76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 23:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiI2Vzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 17:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI2Vzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:55:53 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73257126B72;
        Thu, 29 Sep 2022 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yfSBUUb5PlM94Yw5THXJfR90UP8kJeqP7yQgjaw1P8Q=; b=qTLWjVJ2ulKzel6ORRabEzV7H8
        7aPIIiojQX/MbK7yG9C+F/g3B9gD61Icq3nR2Vx2t9DnD7moFFE+RAz/CvwVhZv5K8SEFg4gT8bhD
        h548indJgNGkEvTd13o/ZxkYeCdsXOejsFh9nT9fzNDr2kq/tUu3zRu/zIEHdRVlTIG7hkPNYWjFm
        E78VATyRsONbvQcKd9FyvV+69+c0SsjXbIxlzltbKsdpZy4EUhtg0GCrq49o39e/YyARu7OS/2+5A
        A5eq4tRX/mYM1PcZy3RZxnyv2di8mvTaVlGHCVmukW72JTdmOtGOxtrJgjq3LrbwplwugZWCBotZx
        /aWytyVA==;
Received: from [179.232.144.59] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oe1VP-00HDq3-7Q; Thu, 29 Sep 2022 23:55:44 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org
Cc:     regressions@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [REGRESSION][PATCH] Revert "pstore: migrate to crypto acomp interface"
Date:   Thu, 29 Sep 2022 18:55:15 -0300
Message-Id: <20220929215515.276486-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.3
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

This reverts commit e4f0a7ec586b7644107839f5394fb685cf1aadcc.

When using this new interface, both efi_pstore and ramoops
backends are unable to properly decompress dmesg if using
zstd, lz4 and lzo algorithms (and maybe more). It does succeed
with deflate though.

The message observed in the kernel log is:

[2.328828] pstore: crypto_acomp_decompress failed, ret = -22!

The pstore infrastructure is able to collect the dmesg with
both backends tested, but since decompression fails it's
unreadable. With this revert everything is back to normal.

Fixes: e4f0a7ec586b ("pstore: migrate to crypto acomp interface")
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

Hi Ard, Thorsten and pstore maintainers. I've found this yday
during pstore development - it was "hidden" since I was using
deflate. Tried some fixes (I plan to submit a cast fix for a
long-term issue later), but nothing I tried fixed this.

So, I thought in sending this revert - feel free to ignore it if
anybody comes with a proper fix for the async compress interface
proposed by Ard. The idea of the revert is because the 6.0-rc
cycle is nearly over, and would be nice to avoid introducing
this regression.

Also, I searched some mailing list discussions / submission of
the patch ("pstore: migrate to crypto acomp interface"), but
couldn't find it - can any of you point it to me in case it's
in some archive?

Thanks in advance, and sorry for reporting this so late in the
cycle, I wish I'd found it before.
Cheers,


Guilherme


 fs/pstore/platform.c | 63 +++++++++-----------------------------------
 1 file changed, 12 insertions(+), 51 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index b2fd3c20e7c2..0c034ea39954 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -28,14 +28,11 @@
 #include <linux/crypto.h>
 #include <linux/string.h>
 #include <linux/timer.h>
-#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
 
-#include <crypto/acompress.h>
-
 #include "internal.h"
 
 /*
@@ -93,8 +90,7 @@ module_param(compress, charp, 0444);
 MODULE_PARM_DESC(compress, "compression to use");
 
 /* Compression parameters */
-static struct crypto_acomp *tfm;
-static struct acomp_req *creq;
+static struct crypto_comp *tfm;
 
 struct pstore_zbackend {
 	int (*zbufsize)(size_t size);
@@ -272,21 +268,12 @@ static const struct pstore_zbackend zbackends[] = {
 static int pstore_compress(const void *in, void *out,
 			   unsigned int inlen, unsigned int outlen)
 {
-	struct scatterlist src, dst;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS))
 		return -EINVAL;
 
-	sg_init_table(&src, 1);
-	sg_set_buf(&src, in, inlen);
-
-	sg_init_table(&dst, 1);
-	sg_set_buf(&dst, out, outlen);
-
-	acomp_request_set_params(creq, &src, &dst, inlen, outlen);
-
-	ret = crypto_acomp_compress(creq);
+	ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
 	if (ret) {
 		pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
 		return ret;
@@ -297,7 +284,7 @@ static int pstore_compress(const void *in, void *out,
 
 static void allocate_buf_for_compression(void)
 {
-	struct crypto_acomp *acomp;
+	struct crypto_comp *ctx;
 	int size;
 	char *buf;
 
@@ -309,7 +296,7 @@ static void allocate_buf_for_compression(void)
 	if (!psinfo || tfm)
 		return;
 
-	if (!crypto_has_acomp(zbackend->name, 0, CRYPTO_ALG_ASYNC)) {
+	if (!crypto_has_comp(zbackend->name, 0, 0)) {
 		pr_err("Unknown compression: %s\n", zbackend->name);
 		return;
 	}
@@ -328,24 +315,16 @@ static void allocate_buf_for_compression(void)
 		return;
 	}
 
-	acomp = crypto_alloc_acomp(zbackend->name, 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR_OR_NULL(acomp)) {
+	ctx = crypto_alloc_comp(zbackend->name, 0, 0);
+	if (IS_ERR_OR_NULL(ctx)) {
 		kfree(buf);
 		pr_err("crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
-		       PTR_ERR(acomp));
-		return;
-	}
-
-	creq = acomp_request_alloc(acomp);
-	if (!creq) {
-		crypto_free_acomp(acomp);
-		kfree(buf);
-		pr_err("acomp_request_alloc('%s') failed\n", zbackend->name);
+		       PTR_ERR(ctx));
 		return;
 	}
 
 	/* A non-NULL big_oops_buf indicates compression is available. */
-	tfm = acomp;
+	tfm = ctx;
 	big_oops_buf_sz = size;
 	big_oops_buf = buf;
 
@@ -355,8 +334,7 @@ static void allocate_buf_for_compression(void)
 static void free_buf_for_compression(void)
 {
 	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
-		acomp_request_free(creq);
-		crypto_free_acomp(tfm);
+		crypto_free_comp(tfm);
 		tfm = NULL;
 	}
 	kfree(big_oops_buf);
@@ -693,8 +671,6 @@ static void decompress_record(struct pstore_record *record)
 	int ret;
 	int unzipped_len;
 	char *unzipped, *workspace;
-	struct acomp_req *dreq;
-	struct scatterlist src, dst;
 
 	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !record->compressed)
 		return;
@@ -718,30 +694,16 @@ static void decompress_record(struct pstore_record *record)
 	if (!workspace)
 		return;
 
-	dreq = acomp_request_alloc(tfm);
-	if (!dreq) {
-		kfree(workspace);
-		return;
-	}
-
-	sg_init_table(&src, 1);
-	sg_set_buf(&src, record->buf, record->size);
-
-	sg_init_table(&dst, 1);
-	sg_set_buf(&dst, workspace, unzipped_len);
-
-	acomp_request_set_params(dreq, &src, &dst, record->size, unzipped_len);
-
 	/* After decompression "unzipped_len" is almost certainly smaller. */
-	ret = crypto_acomp_decompress(dreq);
+	ret = crypto_comp_decompress(tfm, record->buf, record->size,
+					  workspace, &unzipped_len);
 	if (ret) {
-		pr_err("crypto_acomp_decompress failed, ret = %d!\n", ret);
+		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
 		kfree(workspace);
 		return;
 	}
 
 	/* Append ECC notice to decompressed buffer. */
-	unzipped_len = dreq->dlen;
 	memcpy(workspace + unzipped_len, record->buf + record->size,
 	       record->ecc_notice_size);
 
@@ -749,7 +711,6 @@ static void decompress_record(struct pstore_record *record)
 	unzipped = kmemdup(workspace, unzipped_len + record->ecc_notice_size,
 			   GFP_KERNEL);
 	kfree(workspace);
-	acomp_request_free(dreq);
 	if (!unzipped)
 		return;
 
-- 
2.37.3

