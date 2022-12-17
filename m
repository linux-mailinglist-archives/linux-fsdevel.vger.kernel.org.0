Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1334564FC00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 20:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiLQTGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 14:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiLQTFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 14:05:25 -0500
Received: from ms11p00im-qufo17291601.me.com (ms11p00im-qufo17291601.me.com [17.58.38.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7982E13F8C
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Dec 2022 10:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671303173;
        bh=tUqSlj7os7oVf75lqpDXOMEThqY4Jjg4qG11T5ftSlA=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=tUihMWp536/57gjEx28eAVWTl1HQlMtlrVf/V4JmijSZxHUmjQJGpidnIFpAB5NgA
         IJJLO1N7Xg4PboynvWluOyor7lbbtlrC6La8qy4BVOGVcNyT0Lst35BFcT2zTAIdmK
         YlLYB31fYIdLYi4pH9uD585H/6wglEwo6YQ81cLWfdgsgiPoOJeY7XFfDKo4qXL2+d
         IOrCsUQw0Xfqmm10ZKa4EQQBb8Qs/0tZswOMMqg/MqoUtP7CUghWJbhCPG7D3kYOHF
         NvztrPpq+2gd1+ePe6NdubZUJ6MgeKx76sIJJowmZuxPVksEcfErD0tjYhdXSZXACC
         u6cbpqizz++nA==
Received: from thundercleese.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17291601.me.com (Postfix) with ESMTPSA id C00B33A058C;
        Sat, 17 Dec 2022 18:52:52 +0000 (UTC)
From:   Eric Van Hensbergen <evanhensbergen@icloud.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: [PATCH 6/6] allow disable of xattr support on mount
Date:   Sat, 17 Dec 2022 18:52:10 +0000
Message-Id: <20221217185210.1431478-7-evanhensbergen@icloud.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221217185210.1431478-1-evanhensbergen@icloud.com>
References: <20221217185210.1431478-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ql5qw5btlTBhF_yMCTlLaRgNblbGJCjP
X-Proofpoint-ORIG-GUID: ql5qw5btlTBhF_yMCTlLaRgNblbGJCjP
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212170174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
---
 fs/9p/v9fs.c      | 9 ++++++++-
 fs/9p/v9fs.h      | 3 ++-
 fs/9p/vfs_super.c | 3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

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
index 5813967ecdf0..a08cf6618c86 100644
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

