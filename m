Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5101077106F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjHEQMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 12:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEQMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:12:30 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACB510F8;
        Sat,  5 Aug 2023 09:12:29 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RJ6zt0Slbz9sW7;
        Sat,  5 Aug 2023 18:12:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1691251946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yCYqR+EeCPhLlyuM0EqRgutL3UUW623kAbsrUT4n0kQ=;
        b=OdHd8pGnTpNlH8BuqgTP2VG0QtbjeH+XFPBKgoRCyFzxn5xBoAejSoyYHQTYZ7gNnV8+pf
        x8IUMF26GANA0MZ3PS2IudaGlDu07PS/G7/h4n0CrM6s2DKtBYWDpINo882+LsvNHyv1X1
        vWCYSXacXeKQRf6Q1365f1pcSoLWMBIU9gAXFckG/98YZvO4CgBOdPmWTJH0K71YO/Y9Z3
        voWV9JqroE3EY+8PZRtzatBf//qtMQIQCH1qrfcV1nisYQm80mGKdphzRdnwyMMYLAYecH
        VoFZvyY1qkaPzYSLnaxONLuFtLxmqMZaxlHMVNvZKb+Ld8NNtDqwjdCK3X8opQ==
From:   Aleksa Sarai <cyphar@cyphar.com>
Date:   Sun, 06 Aug 2023 02:11:58 +1000
Subject: [PATCH] open: make RESOLVE_CACHED correctly test for O_TMPFILE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-resolve_cached-o_tmpfile-v1-1-7ba16308465e@cyphar.com>
X-B4-Tracking: v=1; b=H4sIAM10zmQC/x3M0QpAMBiG4VvRf2w1U4xbkcT24S9Mm6SWe7ccP
 gfvGynAMwK1WSSPmwO7I6HIMzLreCwQbJNJSVVKLSvhEdx2YzCjWWGFG679nHmDaGptJlXqyVa
 aUn56zPz8665/3w/C9KPragAAAA==
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=h2QuFb5UlHU5Y1F2VVpvnKPcSGujrQ9dOJy94AF37xw=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaScK3nk1nf+Q8LV1/2PmHr2fTU5ltOxr7prz4nNXd+vT
 dgkeExuS0cpC4MYF4OsmCLLNj/P0E3zF19J/rSSDWYOKxPIEAYuTgGYyGwzhl/MlcFRcw/msdgI
 1Fzpnen1sGP/pvjZtnoGcat55f5a31vF8Fdi/du2a+4N71dnSu45b9i252+939kvu0/Mszyf93/
 Xpa+MAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4RJ6zt0Slbz9sW7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

O_TMPFILE is actually __O_TMPFILE|O_DIRECTORY. This means that the old
fast-path check for RESOLVE_CACHED would reject all users passing
O_DIRECTORY with -EAGAIN, when in fact the intended test was to check
for __O_TMPFILE.

Cc: stable@vger.kernel.org # v5.12+
Fixes: 99668f618062 ("fs: expose LOOKUP_CACHED through openat2() RESOLVE_CACHED")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index b8883ec286f5..2634047c9e9f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1337,7 +1337,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_IN_ROOT;
 	if (how->resolve & RESOLVE_CACHED) {
 		/* Don't bother even trying for create/truncate/tmpfile open */
-		if (flags & (O_TRUNC | O_CREAT | O_TMPFILE))
+		if (flags & (O_TRUNC | O_CREAT | __O_TMPFILE))
 			return -EAGAIN;
 		lookup_flags |= LOOKUP_CACHED;
 	}

---
base-commit: bf5ad7af0516cb47121dae1b1c160e4385615274
change-id: 20230806-resolve_cached-o_tmpfile-978cb238bd68

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>

