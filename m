Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9295F714A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 00:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiJFWnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 18:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiJFWn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:43:28 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB326142C94;
        Thu,  6 Oct 2022 15:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BzPX7ATJ1oaxpGuf0PVinseY88CmdU+HARHaDj9AtIo=; b=XFTEarTMRQ8OPVLnEUe7ojm1rN
        KY2CyosasIJ4PjDyLd8UgRQhgpbO2C63gXavydiLAkrGkeBugdaoaMXSe/i2IrTVvqxoKQBCdtnbf
        T2FEzsQGQvW+fcQpwntv//6VjC7EZJ+kBwqArSTc5X4MsYdp1q78eFRAwYgKnw/uejGFoRZtnYp3B
        KlfEyqbxpctfP4Ml6yG7UPnZksHP9Cju9xhAKOagBStgz7kr4hpWR8aSx8d/HVNoAncZh55ssjkCg
        Hvvm2bu0ilt94rfR+O00FeVWKboVjPvrwOS477f/wjkz3KV6Aquu9rZ6G8rWjHOChDipD6Rqhh/QD
        APhNfXkA==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ogZaP-00C4Ks-CC; Fri, 07 Oct 2022 00:43:26 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 3/8] pstore: Inform unregistered backend names as well
Date:   Thu,  6 Oct 2022 19:42:07 -0300
Message-Id: <20221006224212.569555-4-gpiccoli@igalia.com>
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

Currently we only show the registered ones in the kernel
log; users that change backend for some reason require
first to unregister the current one, so let's confirm this
operation with a message in the log.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/pstore/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index be05090076ce..06c2c66af332 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -665,6 +665,8 @@ void pstore_unregister(struct pstore_info *psi)
 	psinfo = NULL;
 	kfree(backend);
 	backend = NULL;
+
+	pr_info("Unregistered %s as persistent store backend\n", psi->name);
 	mutex_unlock(&psinfo_lock);
 }
 EXPORT_SYMBOL_GPL(pstore_unregister);
-- 
2.38.0

