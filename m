Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4811A4C3A38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 01:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiBYASF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 19:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiBYASB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:18:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE7319DEB4;
        Thu, 24 Feb 2022 16:17:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 986DE61AD5;
        Fri, 25 Feb 2022 00:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF64C340E9;
        Fri, 25 Feb 2022 00:17:29 +0000 (UTC)
Date:   Thu, 24 Feb 2022 19:17:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@fb.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH][linux-next] fs: Fix lookup_flags in vfs_statx()
Message-ID: <20220224191727.55b300c4@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Steven Rostedt (Google) <rostedt@goodmis.org>

I needed to test Linux next and it locked up at starting init.

I bisected it down to:

30512d54fae35 ("fs: replace const char* parameter in vfs_statx and do_statx with struct filename")
1e0561928e3ab ("io-uring: Copy path name during prepare stage for statx")

The first commit did not even compile, so I consider the two of the them
the same commit.

Looking at what was changed, I see that the lookup_flags were removed from
the filename_lookup() in the vfs_statx() function, and that the
lookup_flags that were used later on in the function, were never properly
updated either.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
diff --git a/fs/stat.c b/fs/stat.c
index f0a9702cee67..2a2132670929 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -217,7 +217,7 @@ static int vfs_statx(int dfd, struct filename
*filename, int flags, struct kstat *stat, u32 request_mask)
 {
 	struct path path;
-	unsigned lookup_flags = 0;
+	unsigned lookup_flags = getname_statx_lookup_flags(flags);
 	int error;
 
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
AT_EMPTY_PATH | @@ -225,7 +225,7 @@ static int vfs_statx(int dfd, struct
filename *filename, int flags, return -EINVAL;
 
 retry:
-	error = filename_lookup(dfd, filename, flags, &path, NULL);
+	error = filename_lookup(dfd, filename, lookup_flags, &path, NULL);
 	if (error)
 		goto out;
 
