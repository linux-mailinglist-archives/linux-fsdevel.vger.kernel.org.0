Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA415A331B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 02:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbiH0A2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 20:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbiH0A20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:28:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1298EA888
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 17:28:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 25E7A1F9B8;
        Sat, 27 Aug 2022 00:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661560103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VOnVivui6wWSOrPauLaMwb0xIePAqDQskwlb3gP3/M=;
        b=j/YZUNWHX4tEhQFsGAEUaSPs3/RfOUGt+1MLWxCHJGvJ0zhWeYBxMqM8YZzcNn5Mxh1ZBJ
        YUJ3jjIIpatWgh9jKLabGe23348c4X8tLkSzYoBEaPJ2GU7skgfVjcvd3PqLts9iLcz7vZ
        sfNP5Z/lFIsGBAuJsvvItH4+Siy8CqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661560103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VOnVivui6wWSOrPauLaMwb0xIePAqDQskwlb3gP3/M=;
        b=XAPNo2yNlqebT0T18HN9J+30L+bgx5TJLjUHAvKZJwgbGf200ybuj95fwUrAIixbqT23Fz
        eHkm7C4taSCfGgAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C871D133A6;
        Sat, 27 Aug 2022 00:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AIaaLyZlCWNQCgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Sat, 27 Aug 2022 00:28:22 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
        Li Wang <liwang@redhat.com>, Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        automated-testing@lists.yoctoproject.org,
        Tim Bird <tim.bird@sony.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/6] tst_test.sh: Pass used filesystem to tst_device
Date:   Sat, 27 Aug 2022 02:28:15 +0200
Message-Id: <20220827002815.19116-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827002815.19116-1-pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allow to get smaller minimal required size.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 7aea9ee5f..1eb0ce91c 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -694,7 +694,7 @@ tst_run()
 	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 
-		TST_DEVICE=$(tst_device acquire)
+		TST_DEVICE=$(tst_device -f $TST_FS_TYPE acquire)
 
 		if [ ! -b "$TST_DEVICE" -o $? -ne 0 ]; then
 			unset TST_DEVICE
-- 
2.37.2

