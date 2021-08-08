Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3955B3E3B88
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhHHQ0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231859AbhHHQZg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 478D9610E7;
        Sun,  8 Aug 2021 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439917;
        bh=xmLXv5i7UZvG04SFDJpgGHD2RFkBzJD+zP5l8qNjoBE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AMesRXMciqTy9Z+x+pnrhCk8JGOS/orqjtIWJcARwaLKeo6rCnwvABVawy59SFgk3
         58vuidq58/vYYQVZ+riALGfKfsJIS5PrE1PjmxNL+rwInsZcUzEhOTDlAux/oGtpUo
         4SqVdxzndy8XgVRDYzPds6thgt7O0V5uaQG7dimlyktHJLz1fqjGbJFm8+MShhiLRN
         NJh+EfeSiMGjOdn28KEE4QID6GsT5oUYPjAsm9Y50PblNrgSYR5U+wm8vfKtOu1lL5
         BVC4WyAZlmciw14uVn4tWe23S14Z4WC/tgNVFGFO/RBJq7f+s7/seeKfpKqU/oGWpk
         yHIzD0DrI+5AA==
Received: by pali.im (Postfix)
        id 0316F1430; Sun,  8 Aug 2021 18:25:17 +0200 (CEST)
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
Subject: [RFC PATCH 09/20] befs: Fix error processing when load_nls() fails
Date:   Sun,  8 Aug 2021 18:24:42 +0200
Message-Id: <20210808162453.1653-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that specified charset in iocharset= mount option is used. On error
correctly propagate error code back to the caller.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/befs/linuxvfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index e071157bdaa3..963da3e9ab5d 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -914,10 +914,9 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 			   befs_sb->mount_opts.iocharset);
 		befs_sb->nls = load_nls(befs_sb->mount_opts.iocharset);
 		if (!befs_sb->nls) {
-			befs_warning(sb, "Cannot load nls %s"
-					" loading default nls",
+			befs_error(sb, "Cannot load nls %s",
 					befs_sb->mount_opts.iocharset);
-			befs_sb->nls = load_nls_default();
+			goto unacquire_priv_sbp;
 		}
 	/* load default nls if none is specified  in mount options */
 	} else {
-- 
2.20.1

