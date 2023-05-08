Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AEE6F9D46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 03:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjEHBRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 21:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjEHBRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 21:17:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA51F468A;
        Sun,  7 May 2023 18:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PTHrGhg729vTgLExIgnS6GZIXZ79cZ7Du4oqbKrd5yA=; b=jOKays2+3gsfVEdCnQyXiTpGAB
        sy1Zi6r9fQIfiJ4jCm2+VzEZjYCNfHU5PD6+qjcHKiunwsIWh9DhztGtEeZaCb5WN9ltt3cvxYthN
        r1PrKvl6QvZDCwtPPgv8ViJ58AEj3sVk0FSYuqpu63DS1pn0iDKbZGLt7r9uL8jnfIieba69I6ZVm
        wKHLCjzwkyVHZRdf/1lH4u+Y8T2GJzli9hWGJ+gGxsjtxvg2twiMXWWBBbtWQWXHwy3sCaYYbhRwU
        pyqRY9qI1s8aRaOhEboXDXO7xSJ4d+mN3UbOxVgLF4+J3EhzEEFA8t+4hAoyL2cTDwJzoLCLYx9Qg
        AuuPq3GQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvpV7-00GvZ4-32;
        Mon, 08 May 2023 01:17:17 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/6] fs: move !SB_BORN check early on freeze and add for thaw
Date:   Sun,  7 May 2023 18:17:15 -0700
Message-Id: <20230508011717.4034511-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508011717.4034511-1-mcgrof@kernel.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The SB_BORN flag added on vfs_get_tree() when a filesystem is about to be
mounted. If a super_block lacks this flag there's nothing to do for that
filesystem in terms of freezing or thawing.

In subsequent patches support will be added to allow detecting failures for
iterating over all super_blocks and freezing or thawing. Although that
functionality will be be skipped when sb->s_bdi == &noop_backing_dev_info,
and so SB_BORN will not be set, since we already check for SB_BORN on
freeze just move that up earlier and to be consistent do the same on
thaw too. We do this as these are user facing APIs, and although it
would be incorrect to issue a freeze on a non-mounted sb, it is even
stranger to get -EBUSY.

Be consistent about this and bail early for !SB_BORN for freeze and thaw
without failing.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 16ccbb9dd230..28c633b81f8f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1678,12 +1678,13 @@ int freeze_super(struct super_block *sb, bool usercall)
 	if (!usercall && sb_is_frozen(sb))
 		return 0;
 
+	/* If the filesystem was not going to be mounted there is nothing to do */
+	if (!(sb->s_flags & SB_BORN))
+		return 0;
+
 	if (!sb_is_unfrozen(sb))
 		return -EBUSY;
 
-	if (!(sb->s_flags & SB_BORN))
-		return 0;	/* sic - it's "nothing to do" */
-
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
@@ -1761,6 +1762,10 @@ int thaw_super(struct super_block *sb, bool usercall)
 			return 0;
 	}
 
+	/* If the filesystem was not going to be mounted there is nothing to do */
+	if (!(sb->s_flags & SB_BORN))
+		return 0;
+
 	if (!sb_is_frozen(sb))
 		return -EINVAL;
 
-- 
2.39.2

