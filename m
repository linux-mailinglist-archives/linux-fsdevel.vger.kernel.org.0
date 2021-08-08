Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E113E3B81
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhHHQZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhHHQZe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A3DC61019;
        Sun,  8 Aug 2021 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439915;
        bh=SvKOqyPaGSzoaIcYwQ0yRxDdigaErxC/HKUfKX6Zrtc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hOZn2eQCBH07F4do1hg8Lbo8/EGitk9c3nGslXaoXHoJxnwmVTzTopeoh/i5A+dRz
         +hQyiLFU/vjmhXfbIJewjGg1jkhXeGsEnpxngLTaIgA59xilyJ2ZFZye8CkUDUtfOV
         3WRkf9aeq56MTG9sEJInu+TH1/yNQcfq32ljdAb0Y69r8mgh12oytPhYvL7poh9Cd6
         o6xss5RH6D72UXPJugRdVHUOczcg8p3OVR2VzGag1zeGHAsfFd46hap86mxOCoAiBG
         nWf2ZYxdARW30jDLeuJ/JON5j5ccLn85rtPTgzuUrjPA7YinjA1o3XKOlPrpewC1Y/
         AGayuPIIx4VMA==
Received: by pali.im (Postfix)
        id 730F21545; Sun,  8 Aug 2021 18:25:13 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 02/20] hfsplus: Add iocharset= mount option as alias for nls=
Date:   Sun,  8 Aug 2021 18:24:35 +0200
Message-Id: <20210808162453.1653-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Other fs drivers are using iocharset= mount option for specifying charset.
So add it also for hfsplus and mark old nls= mount option as deprecated.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/hfsplus/options.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
index 047e05c57560..a975548f6b91 100644
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
@@ -166,6 +168,9 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
 			}
 			break;
 		case opt_nls:
+			pr_warn("option nls= is deprecated, use iocharset=\n");
+			/* fallthrough */
+		case opt_iocharset:
 			if (sbi->nls) {
 				pr_err("unable to change nls mapping\n");
 				return 0;
@@ -230,7 +235,7 @@ int hfsplus_show_options(struct seq_file *seq, struct dentry *root)
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

