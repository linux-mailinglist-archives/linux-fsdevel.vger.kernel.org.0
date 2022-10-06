Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482815F7146
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 00:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiJFWnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 18:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiJFWnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:43:00 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE77F2537;
        Thu,  6 Oct 2022 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ux48LLt57AGPgmUYDQ9s60SdNch88HLBtYUsjAHGl1I=; b=jAPeqo2Ws0y4fXsh0Yglfckq1e
        /jX4ZsrqEtq6jzai0vPaAJeGCpmGhhaEdOCz1aWzTz3iO/mFhUjYJJJKfKH2EvvnYMp/un8t+PNSW
        TmzhihtEaqJJBS/fCpQvBrH6eTiN9p0b7dOr5Tqdz/7H16zsWw4DCcKPywdEYsVmWPXbTA1vlngmC
        XbzQwUP1ynRLdkPEvNa1snNyR4WEpcvP8ednMvFobRfo6rSJ88zIii+Mo2z7DkXHz54RH1xZk7pTW
        x1ZuLvogrxTbWKAhx6Ajp6SkgcYRidv7GIvaT+gSwjUCY3oKtS0Ip9rTY5dvOiSdZ069ysyjDYgkk
        OOnTY30g==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ogZZw-00C4J5-QA; Fri, 07 Oct 2022 00:42:57 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 1/8] pstore: Improve error reporting in case of backend overlap
Date:   Thu,  6 Oct 2022 19:42:05 -0300
Message-Id: <20221006224212.569555-2-gpiccoli@igalia.com>
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

The pstore infrastructure supports one single backend at a time;
trying to load a another backend causes an error and displays a
message, introduced on commit 0d7cd09a3dbb ("pstore: Improve
register_pstore() error reporting").

Happens that this message is not really clear about the situation,
also the current error returned (-EPERM) isn't accurate, whereas
-EBUSY makes more sense. We have another place in the code that
relies in the -EBUSY return for a similar check.

So, make it consistent here by returning -EBUSY and using a
similar message in both scenarios.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/pstore/platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 0c034ea39954..c32957e4b256 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -562,8 +562,9 @@ static int pstore_write_user_compat(struct pstore_record *record,
 int pstore_register(struct pstore_info *psi)
 {
 	if (backend && strcmp(backend, psi->name)) {
-		pr_warn("ignoring unexpected backend '%s'\n", psi->name);
-		return -EPERM;
+		pr_warn("backend '%s' already in use: ignoring '%s'\n",
+			backend, psi->name);
+		return -EBUSY;
 	}
 
 	/* Sanity check flags. */
-- 
2.38.0

