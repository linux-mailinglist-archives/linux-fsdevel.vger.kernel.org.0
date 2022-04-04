Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA04F121F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354412AbiDDJhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 05:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354372AbiDDJhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:37:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A412FFDA
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 02:35:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0118C1F381;
        Mon,  4 Apr 2022 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649064941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ihnaGXAKCorTBGS7HooSS2+OlpPNnRgEuxVrW2d4pWc=;
        b=1AU/cK4/UMFx7LWP/qeKNXNBrIDBMn33tHQuTzqXnRuXk25KwB5ign7Gv8mvFEP2ZpHEI8
        pOmBSaliygCDzZrtmmPDyzACzgWKD4rrAcPxYuqUQUbRTvS7CibXWQMHEr5nSrsx4PJxBY
        qzTNKDeOyGRPTgM6jjYIusFuDt8eL34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649064941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ihnaGXAKCorTBGS7HooSS2+OlpPNnRgEuxVrW2d4pWc=;
        b=ZINIEymvdnrwd83G6QnC4i9qqgL/2dXG/qnGGsZO8LYSnItupigRn9xy2nWGumil3WUUMC
        eoewfREbhtDvlHBw==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BEAA7A3B89;
        Mon,  4 Apr 2022 09:35:40 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>,
        Martin Wilck <mwilck@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v7 1/6] initramfs: refactor do_header() cpio magic checks
Date:   Mon,  4 Apr 2022 11:34:25 +0200
Message-Id: <20220404093429.27570-2-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220404093429.27570-1-ddiss@suse.de>
References: <20220404093429.27570-1-ddiss@suse.de>
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

do_header() is called for each cpio entry and fails if the first six
bytes don't match "newc" magic. The magic check includes a special case
error message if POSIX.1 ASCII (cpio -H odc) magic is detected. This
special case POSIX.1 check can be nested under the "newc" mismatch code
path to avoid calling memcmp() twice in a non-error case.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Martin Wilck <mwilck@suse.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 init/initramfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 2f3d96dc3db6..2f79b3ec0b40 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -257,12 +257,11 @@ static int __init do_collect(void)
 
 static int __init do_header(void)
 {
-	if (memcmp(collected, "070707", 6)==0) {
-		error("incorrect cpio method used: use -H newc option");
-		return 1;
-	}
 	if (memcmp(collected, "070701", 6)) {
-		error("no cpio magic");
+		if (memcmp(collected, "070707", 6) == 0)
+			error("incorrect cpio method used: use -H newc option");
+		else
+			error("no cpio magic");
 		return 1;
 	}
 	parse_header(collected);
-- 
2.34.1

