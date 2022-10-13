Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75A5FE3DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 23:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJMVL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 17:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJMVLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:11:20 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD42A18F91B;
        Thu, 13 Oct 2022 14:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GcklzwrLgeVXmrc9kawBXnG2QLvECr568P4pKI8MuFw=; b=BrDPtCLAEqR1VvN0IuOE/DgCzT
        tBBEh7LHeyN1ZhVNYID1zIqeGO/7a9E9hIARvHp/F1DAx3lnJsc3fj5v/6cK7++KHCreXrewhNGBn
        duu2ZbRtli6s+BYpqFWJ5oA2OaZo8ihKZ9qBCBcnCnWMHspHWzTSxbcaP3GQAkIbH55NUdaWMNLy5
        PCC5gF0PSP36WeF07kyV5fD0x16REiu6K57wIQpAt5Mx/atoRzKEyBJrnREKe+/6rBX/rNtjFyl93
        zNA2EL9YSHln9xMZ8qxN0j+sVQ05MvjCuEj5sckgmGH5RDqKgFeJaB3EotBNj9s0z7/1OHZDq//fr
        HnDf9VRg==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oj5U4-0010zH-BX; Thu, 13 Oct 2022 23:11:17 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        ardb@kernel.org, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH V2 2/3] efi: pstore: Follow convention for the efi-pstore backend name
Date:   Thu, 13 Oct 2022 18:06:47 -0300
Message-Id: <20221013210648.137452-3-gpiccoli@igalia.com>
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

For some reason, the efi-pstore backend name (exposed through the
pstore infrastructure) is hardcoded as "efi", whereas all the other
backends follow a kind of convention in using the module name.

Let's do it here as well, to make user's life easier (they might
use this info for unloading the module backend, for example).

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V2:
- Added Ard's ACK - thanks!


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

