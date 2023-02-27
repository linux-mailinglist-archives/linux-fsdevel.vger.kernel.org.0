Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6626A391D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 03:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjB0Czu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 21:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjB0Czq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:55:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE33011EA5;
        Sun, 26 Feb 2023 18:55:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68F1660D29;
        Mon, 27 Feb 2023 02:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1142C433EF;
        Mon, 27 Feb 2023 02:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677466536;
        bh=XzzzHWMtgZ6Vr9M2iDPwmlGp9yQezeqsE8i4VbxA0jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0x9Ma7B11r42JIm1XXV8r6kfdOc3DPv+fJH+QmRr0DghD469pKdjHRyjlCZCKJ3W
         kRBLnSBYHTMFJHC8S5LNMJWjCjRY/oUpEbdmM+sjqGlUIku+o8R7CVpazythVbkD4u
         0Ndxd3wLmm9NHzXsa7cikgSJiodWXoyOvWkK6GpX1zMjFheJnwRlh4QIhX1X4x6Azz
         r1evSWhBkNuxtl1NMLTL3Thm4kuAD+4pKKRfEUwMAGZWK21iVlO+L5xua+MvxMgec3
         u7qlsZ1WtCU4nYPDwpPdqIJbCsSvSq5TjaatYl9lEkDfXaMArt/RMX39Yc7OMzc3wh
         ukPBz2zRGVmtw==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     asmadeus@codewreck.org
Cc:     ericvh@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
        lucho@ionkov.net, rminnich@gmail.com,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH v5 8/11] fs/9p: Add new mount modes
Date:   Mon, 27 Feb 2023 02:55:32 +0000
Message-Id: <20230227025532.25421-1-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <Y/CQgOHjg0kmA1Vg@codewreck.org>
References: <Y/CQgOHjg0kmA1Vg@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some additional mount modes for cache management including
specifying directio as a mount option and an option for ignore
qid.version for determining whether or not a file is cacheable.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/v9fs.c | 16 ++++++++++++++--
 fs/9p/v9fs.h |  5 ++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index f8e952c013f9..43d3806150a9 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -38,7 +38,7 @@ enum {
 	/* String options */
 	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
 	/* Options that take no arguments */
-	Opt_nodevmap, Opt_noxattr,
+	Opt_nodevmap, Opt_noxattr, Opt_directio, Opt_ignoreqv,
 	/* Access options */
 	Opt_access, Opt_posixacl,
 	/* Lock timeout option */
@@ -56,6 +56,8 @@ static const match_table_t tokens = {
 	{Opt_remotename, "aname=%s"},
 	{Opt_nodevmap, "nodevmap"},
 	{Opt_noxattr, "noxattr"},
+	{Opt_directio, "directio"},
+	{Opt_ignoreqv, "ignoreqv"},
 	{Opt_cache, "cache=%s"},
 	{Opt_cachetag, "cachetag=%s"},
 	{Opt_access, "access=%s"},
@@ -125,7 +127,7 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 	if (v9ses->nodev)
 		seq_puts(m, ",nodevmap");
 	if (v9ses->cache)
-		seq_printf(m, ",%s", v9fs_cache_modes[v9ses->cache]);
+		seq_printf(m, ",cache=%s", v9fs_cache_modes[v9ses->cache]);
 #ifdef CONFIG_9P_FSCACHE
 	if (v9ses->cachetag && v9ses->cache == CACHE_FSCACHE)
 		seq_printf(m, ",cachetag=%s", v9ses->cachetag);
@@ -147,6 +149,10 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 		break;
 	}
 
+	if (v9ses->flags & V9FS_IGNORE_QV)
+		seq_puts(m, ",ignoreqv");
+	if (v9ses->flags & V9FS_DIRECT_IO)
+		seq_puts(m, ",directio");
 	if (v9ses->flags & V9FS_POSIX_ACL)
 		seq_puts(m, ",posixacl");
 
@@ -276,6 +282,12 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 		case Opt_noxattr:
 			v9ses->flags |= V9FS_NO_XATTR;
 			break;
+		case Opt_directio:
+			v9ses->flags |= V9FS_DIRECT_IO;
+			break;
+		case Opt_ignoreqv:
+			v9ses->flags |= V9FS_IGNORE_QV;
+			break;
 		case Opt_cachetag:
 #ifdef CONFIG_9P_FSCACHE
 			kfree(v9ses->cachetag);
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index a93327aed0d2..8e79b5b619af 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -37,7 +37,10 @@ enum p9_session_flags {
 	V9FS_ACCESS_USER	= 0x08,
 	V9FS_ACCESS_CLIENT	= 0x10,
 	V9FS_POSIX_ACL		= 0x20,
-	V9FS_NO_XATTR		= 0x40
+	V9FS_NO_XATTR		= 0x40,
+	V9FS_IGNORE_QV		= 0x80, /* ignore qid.version for cache hints */
+	V9FS_DIRECT_IO		= 0x100,
+	V9FS_SYNC			= 0x200
 };
 
 /* possible values of ->cache */
-- 
2.37.2

