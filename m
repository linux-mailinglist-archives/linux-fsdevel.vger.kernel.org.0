Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8875F69B728
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 01:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBRAtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 19:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBRAtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:49:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051305CF3A;
        Fri, 17 Feb 2023 16:48:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65B10B82EA6;
        Sat, 18 Feb 2023 00:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C24C4339B;
        Sat, 18 Feb 2023 00:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676680439;
        bh=rvDymktanf6MSiAzIPMCTiULQZumTY7dlyrm9CYAra8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5s5bduuvTJwpmyQLndx1q3QKOTxY+MAvEohBtO6bBJ6vHrq0ksXVYJ4u2Gl+9nSl
         7K/36OoDsVN6AUW7UiEMpCLQvbsTDVB7peDF132Xy4u9m9XIYPWa2aYp3Wj9zjVFq6
         dq2VzOo8zBT6Jd0kbQdknCeq3vsB4VPHVDGQ/9AoqdOE2m6TiKPvYLl5cjsJWaYmFF
         CfCy0IhVlokPKNpaYe5gmjDFNdJSAG0uMMBTD1/lORsD75nBYeYx5MoeU0sdMMi9IX
         F063gTxW5kJw2iG0n9bqEs/7mmCZmQ5AyzI/CjWrvUtFGYWbfDHeCRqs6hfLuBgADl
         OkLTeNp9oxs8g==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v4 05/11] fs/9p: allow disable of xattr support on mount
Date:   Sat, 18 Feb 2023 00:33:17 +0000
Message-Id: <20230218003323.2322580-6-ericvh@kernel.org>
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

xattr creates a lot of additional messages for 9p in
the current implementation.  This allows users to
conditionalize xattr support on 9p mount if they
are on a connection with bad latency.  Using this
flag is also useful when debugging other aspects
of 9p as it reduces the noise in the trace files.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 Documentation/filesystems/9p.rst | 2 ++
 fs/9p/v9fs.c                     | 9 ++++++++-
 fs/9p/v9fs.h                     | 3 ++-
 fs/9p/vfs_super.c                | 3 ++-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 7b5964bc8865..0e800b8f73cc 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -137,6 +137,8 @@ Options
   		This can be used to share devices/named pipes/sockets between
 		hosts.  This functionality will be expanded in later versions.
 
+  noxattr	do not offer xattr functions on this mount.
+
   access	there are four access modes.
 			user
 				if a user tries to access a file on v9fs
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index a46bf9121f11..f8e952c013f9 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -38,7 +38,7 @@ enum {
 	/* String options */
 	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
 	/* Options that take no arguments */
-	Opt_nodevmap,
+	Opt_nodevmap, Opt_noxattr,
 	/* Access options */
 	Opt_access, Opt_posixacl,
 	/* Lock timeout option */
@@ -55,6 +55,7 @@ static const match_table_t tokens = {
 	{Opt_uname, "uname=%s"},
 	{Opt_remotename, "aname=%s"},
 	{Opt_nodevmap, "nodevmap"},
+	{Opt_noxattr, "noxattr"},
 	{Opt_cache, "cache=%s"},
 	{Opt_cachetag, "cachetag=%s"},
 	{Opt_access, "access=%s"},
@@ -149,6 +150,9 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 	if (v9ses->flags & V9FS_POSIX_ACL)
 		seq_puts(m, ",posixacl");
 
+	if (v9ses->flags & V9FS_NO_XATTR)
+		seq_puts(m, ",noxattr");
+
 	return p9_show_client_options(m, v9ses->clnt);
 }
 
@@ -269,6 +273,9 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 		case Opt_nodevmap:
 			v9ses->nodev = 1;
 			break;
+		case Opt_noxattr:
+			v9ses->flags |= V9FS_NO_XATTR;
+			break;
 		case Opt_cachetag:
 #ifdef CONFIG_9P_FSCACHE
 			kfree(v9ses->cachetag);
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 517b2201ad24..d90141d25d0d 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -36,7 +36,8 @@ enum p9_session_flags {
 	V9FS_ACCESS_SINGLE	= 0x04,
 	V9FS_ACCESS_USER	= 0x08,
 	V9FS_ACCESS_CLIENT	= 0x10,
-	V9FS_POSIX_ACL		= 0x20
+	V9FS_POSIX_ACL		= 0x20,
+	V9FS_NO_XATTR		= 0x40
 };
 
 /* possible values of ->cache */
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 65d96fa94ba2..5fc6a945bfff 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -64,7 +64,8 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 	sb->s_magic = V9FS_MAGIC;
 	if (v9fs_proto_dotl(v9ses)) {
 		sb->s_op = &v9fs_super_ops_dotl;
-		sb->s_xattr = v9fs_xattr_handlers;
+		if (!(v9ses->flags & V9FS_NO_XATTR))
+			sb->s_xattr = v9fs_xattr_handlers;
 	} else {
 		sb->s_op = &v9fs_super_ops;
 		sb->s_time_max = U32_MAX;
-- 
2.37.2

