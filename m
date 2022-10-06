Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1825F7154
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 00:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiJFWox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 18:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiJFWou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:44:50 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB231AE4C;
        Thu,  6 Oct 2022 15:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fyTNkQo2umov1vOiOrWjKRPdNwFQ2sA+uyQXpivio3w=; b=qgqa9fPeQyI/PxxJrVajIRmbKM
        lN90Nsf7BVEGPmgyeE2vPm2u5lpq1kU1HXKS4LQP7lnuc6cJHNS691w9FQnpsuzFEJ1WevfEckY80
        XEEIzxx8zeHyw0qFB/7qD8f3WacwPEVbc5cqpiLkluyHiFT1MMyWKcfmgDmG5iwI/0rbw27HB2edj
        3OmLRSlNaTd/4wblcYOZga7dixjV8BPUJ9saFnoRCnTHdWm0EBT3unTk/+GMJnUApol0sUJKHIy9F
        LVucn2/hKXN/D3bh2lPsAAT8aNZ9YBQlMZxijxMH0I2QUfPUIcMIO9aDyt0ucvmMke8+PYm34N3fd
        QmxFaing==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ogZbh-00C4R4-PY; Fri, 07 Oct 2022 00:44:46 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 7/8] efi: pstore: Follow convention for the efi-pstore backend name
Date:   Thu,  6 Oct 2022 19:42:11 -0300
Message-Id: <20221006224212.569555-8-gpiccoli@igalia.com>
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

For some reason, the efi-pstore backend name (exposed through the
pstore infrastructure) is hardcoded as "efi", whereas all the other
backends follow a kind of convention in using the module name.

Let's do it here as well, to make user's life easier (they might
use this info for unloading the module backend, for example).

Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/firmware/efi/efi-pstore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 3bddc152fcd4..97a9e84840a0 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -207,7 +207,7 @@ static int efi_pstore_erase(struct pstore_record *record)
 
 static struct pstore_info efi_pstore_info = {
 	.owner		= THIS_MODULE,
-	.name		= "efi",
+	.name		= KBUILD_MODNAME,
 	.flags		= PSTORE_FLAGS_DMESG,
 	.open		= efi_pstore_open,
 	.close		= efi_pstore_close,
-- 
2.38.0

