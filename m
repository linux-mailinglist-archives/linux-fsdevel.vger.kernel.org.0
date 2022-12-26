Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E24656311
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiLZOWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiLZOWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4982182;
        Mon, 26 Dec 2022 06:22:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ABD160EA0;
        Mon, 26 Dec 2022 14:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E67C4339B;
        Mon, 26 Dec 2022 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064524;
        bh=BEzrRcBKQ+GZ/U+aeCEg9n4Pdy0ikdO5wXFWpAtXmSg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=N7GrMIigC6HxWNrAVct3befoFSSCxU8We3pVOw0O7RzGrspOaLS7OpPHudv168XAA
         25iLUs0PGQXhlSEnFpoMuteXkAvUDuXi2F3q5Ilj3JLvHTC0foaYVDx8XDUHW+FfEn
         lqCyqB5hNS+kNb4YFZ9eV4RnkF0iFaa4JEVF30ZkqOMn2UQsHeJ+XlEW0A0kdXjKtc
         Xnn089Q0lcPPNDHVVs8gb8ZCLt1Gr/wpy2bnawgEal9zvN7aQIAwzliJYz0B7WrevK
         JgvI5+UbqzqVfOzTHbOeRJ2Ud40GRBYxGQlvQ1bcYt2Piyv+6jvwF/w1hr47ANYy2v
         ugCvYxfnZppOg==
Received: by pali.im (Postfix)
        id 46DDAA32; Mon, 26 Dec 2022 15:22:02 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v2 02/18] hfsplus: Add iocharset= mount option as alias for nls=
Date:   Mon, 26 Dec 2022 15:21:34 +0100
Message-Id: <20221226142150.13324-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226142150.13324-1-pali@kernel.org>
References: <20221226142150.13324-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Other fs drivers are using iocharset= mount option for specifying charset.
So add it also for hfsplus and mark old nls= mount option as deprecated.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/filesystems/hfsplus.rst | 3 +++
 fs/hfsplus/options.c                  | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/hfsplus.rst b/Documentation/filesystems/hfsplus.rst
index f02f4f5fc020..171805304cc2 100644
--- a/Documentation/filesystems/hfsplus.rst
+++ b/Documentation/filesystems/hfsplus.rst
@@ -50,6 +50,9 @@ When mounting an HFSPlus filesystem, the following options are accepted:
 	or locked.  Use at your own risk.
 
   nls=cccc
+	Deprecated alias for ``iocharset=`` mount option.
+
+  iocharset=cccc
 	Encoding to use when presenting file names.
 
 
diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
index c94a58762ad6..d3dc0d4ba77f 100644
--- a/fs/hfsplus/options.c
+++ b/fs/hfsplus/options.c
@@ -23,6 +23,7 @@ enum {
 	opt_creator, opt_type,
 	opt_umask, opt_uid, opt_gid,
 	opt_part, opt_session, opt_nls,
+	opt_iocharset,
 	opt_nodecompose, opt_decompose,
 	opt_barrier, opt_nobarrier,
 	opt_force, opt_err
@@ -37,6 +38,7 @@ static const match_table_t tokens = {
 	{ opt_part, "part=%u" },
 	{ opt_session, "session=%u" },
 	{ opt_nls, "nls=%s" },
+	{ opt_iocharset, "iocharset=%s" },
 	{ opt_decompose, "decompose" },
 	{ opt_nodecompose, "nodecompose" },
 	{ opt_barrier, "barrier" },
@@ -170,6 +172,9 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
 			}
 			break;
 		case opt_nls:
+			pr_warn("option nls= is deprecated, use iocharset=\n");
+			fallthrough;
+		case opt_iocharset:
 			if (sbi->nls) {
 				pr_err("unable to change nls mapping\n");
 				return 0;
@@ -234,7 +239,7 @@ int hfsplus_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbi->session >= 0)
 		seq_printf(seq, ",session=%u", sbi->session);
 	if (sbi->nls)
-		seq_printf(seq, ",nls=%s", sbi->nls->charset);
+		seq_printf(seq, ",iocharset=%s", sbi->nls->charset);
 	if (test_bit(HFSPLUS_SB_NODECOMPOSE, &sbi->flags))
 		seq_puts(seq, ",nodecompose");
 	if (test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
-- 
2.20.1

