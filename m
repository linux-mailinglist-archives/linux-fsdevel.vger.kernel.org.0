Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D175F7148
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 00:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiJFWnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 18:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiJFWnO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:43:14 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80819142C9A;
        Thu,  6 Oct 2022 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ROxU9ZPvDJlhMxlhvGBHee4urUu69sraTMRl63LvHNo=; b=oebQFFy873qnFMejWs0yByUCJu
        qZOVtCliWUehonJMF4AVEmd6/c4MT+TrOtlHrP6Hbp1qjgWtsmf2iJLrTIz1PNpx0pmyFl/xtWoks
        JvNfIiFfEWFHeQwfcY31fVm2MI0gyL0FSecRBMfOW9TR4K45Ih2wVTsx0hZhdBZdBfDCpi6wRPxVf
        y89SLESrHPvtOFEvtKHyrr742UaWHpTOwsxM68Zc+BKYJ75s6asrQTvMuv3WoXZJe2EmLWW5i0iP6
        /XIlY3Ex1qGehh4xHwCLUZodMi97dYlZpaL2iiXzpfnlScxgtGcEabm5B2jxoM1JuPrrQiAKbZtHs
        Musmo8gg==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ogZaA-00C4JQ-GL; Fri, 07 Oct 2022 00:43:11 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 2/8] pstore: Expose kmsg_bytes as a module parameter
Date:   Thu,  6 Oct 2022 19:42:06 -0300
Message-Id: <20221006224212.569555-3-gpiccoli@igalia.com>
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

Currently this tuning is only exposed as a filesystem option,
but most Linux distros automatically mount pstore, hence changing
this setting requires remounting it. Also, if that mount option
wasn't explicitly set it doesn't show up in mount information,
so users cannot check what is the current value of kmsg_bytes.

Let's then expose it as a module parameter, allowing both user
visibility at all times (even if not manually set) and also the
possibility of setting that as a boot/module parameter.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/pstore/platform.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index c32957e4b256..be05090076ce 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -89,6 +89,11 @@ static char *compress =
 module_param(compress, charp, 0444);
 MODULE_PARM_DESC(compress, "compression to use");
 
+/* How much of the kernel log to snapshot */
+unsigned long kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
+module_param(kmsg_bytes, ulong, 0444);
+MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
+
 /* Compression parameters */
 static struct crypto_comp *tfm;
 
@@ -100,9 +105,6 @@ struct pstore_zbackend {
 static char *big_oops_buf;
 static size_t big_oops_buf_sz;
 
-/* How much of the console log to snapshot */
-unsigned long kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
-
 void pstore_set_kmsg_bytes(int bytes)
 {
 	kmsg_bytes = bytes;
-- 
2.38.0

