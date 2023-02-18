Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A906069B71D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 01:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjBRApV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 19:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjBRApI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:45:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D56E67E;
        Fri, 17 Feb 2023 16:44:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 856D6B82EDB;
        Sat, 18 Feb 2023 00:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CB8C4339E;
        Sat, 18 Feb 2023 00:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676680442;
        bh=KENVm6Mybvc2iHuCzsErqi8WG1g+ScHvDff49cLzyDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k2zvKVLYQRYHVPCHNW4CkVsb+xtQmWFci14aAHMmH5MuhKOi5lq8QRlpLTzVC7jcv
         +eKBBcUB1xn7Q8YXHws7r0KqMU64v+Hi78jLoj4GRyIfUsAFqRsGXYacyVThPsKL7N
         Y7p2mn4y024cFomTPs83Gt2ARvuZAqJ/fwgVKQiCtYM95oCIhecekSRfR9jXd863Ht
         77GpUmI/2rEgtZAJD0ZIhaSB8mx1SbPlR2DAPqNt2fhJZF+tB56mq8rV+jXxKQux+1
         aXAjJvGX0vsSjDqF3W1R2BABHde2pKPUvB7UU3gXu/FR9oXlQb4LnLXTnTe3sTMhvt
         TkZX5pCShykFQ==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v4 08/11] fs/9p: Add new mount modes
Date:   Sat, 18 Feb 2023 00:33:20 +0000
Message-Id: <20230218003323.2322580-9-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230218003323.2322580-1-ericvh@kernel.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index d90141d25d0d..48c7614c9333 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -37,7 +37,10 @@ enum p9_session_flags {
 	V9FS_ACCESS_USER	= 0x08,
 	V9FS_ACCESS_CLIENT	= 0x10,
 	V9FS_POSIX_ACL		= 0x20,
-	V9FS_NO_XATTR		= 0x40
+	V9FS_NO_XATTR		= 0x40,
+	V9FS_IGNORE_QV		= 0x80,
+	V9FS_DIRECT_IO		= 0x100,
+	V9FS_SYNC			= 0x200
 };
 
 /* possible values of ->cache */
-- 
2.37.2

