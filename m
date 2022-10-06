Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B15F714B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 00:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiJFWnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 18:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiJFWnm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:43:42 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7AAF2539;
        Thu,  6 Oct 2022 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OOh5S7b6Hnc2HBjRQcJVdon08G2hglJQpnHO9T3Cemg=; b=ThouN2ayN/yFeffHynfhHg2/qD
        w4T8KYJlY8/StyOg87HM20xS9875r/MjXAPdnPBM+KQwsQOpHLwysnjEAtYWsTBrC2UAemnOSupPS
        OTPONbqDcq15jtfcB5JK/74xz7CtFKa7BdT9NQNyQgO3NXoGbTrKkqb/VAB7v/E4ObTGGjTX++Idr
        uQ0Pcdk/iruuagZWGebLNCeV/UOnL9QqAXMmIAI2IVua2QZ3zOt2v0sNzxuEbUHmDAOux+XjggbFE
        59ln3xjTEDFlA+yOyVi5/5t+aFQLvN7V6W7vadqykvM4tCbHGN4PxQw8FuFSROQ1P8dTE9mRL9+KV
        UTg+C7+g==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ogZac-00C4MB-VT; Fri, 07 Oct 2022 00:43:39 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 4/8] pstore: Alert on backend write error
Date:   Thu,  6 Oct 2022 19:42:08 -0300
Message-Id: <20221006224212.569555-5-gpiccoli@igalia.com>
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

The pstore dump function doesn't alert at all on errors - despite
pstore is usually a last resource and if it fails users won't be
able to read the kernel log, this is not the case for server users
with serial access, for example.

So, let's at least attempt to inform such advanced users on the first
backend writing error detected during the kmsg dump - this is also
very useful for pstore debugging purposes.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/pstore/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 06c2c66af332..ee50812fdd2e 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -463,6 +463,9 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		if (ret == 0 && reason == KMSG_DUMP_OOPS) {
 			pstore_new_entry = 1;
 			pstore_timer_kick();
+		} else {
+			pr_err_once("backend (%s) writing error (%d)\n",
+				    psinfo->name, ret);
 		}
 
 		total += record.size;
-- 
2.38.0

