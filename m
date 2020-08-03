Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4A723A7F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgHCN60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgHCN6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:58:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E31C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2020 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BH9HSd/AqV6LidMBIrGy9n33CQxj+9jQt9Z9fvEU60c=; b=VMJA1PSCXJR4gEg2fWvi4J9NRG
        oH4dAde8kb75B85dFbEHxc7twu6tz5pzRyG0P4a2AbJI/OgPVe6zCEUlIeXBq3aaBzlcnwkKB739K
        wvC6l2imDy1qNPtOv/J6yJuMCg98pA4bFbqfoW5yyO+E3VdpjNRc2cr0teBmWc9S2owCWq0BYcpas
        z8PFB/FlR6i/CZM866KRM2WLZYhFasMRN1A4t47XhvQ5Paiyf8E2G/BPt+k4d7BQuCPy11hBxHJ9N
        JdQo5tPtlSB43AUCtNih7yUjJe079/+eiDVmWYt8mXkxaDFxHLUlS1hQxxdnuHdLQ0NbVh5JAICMK
        fA+rBhrQ==;
Received: from 93-43-212-104.ip93.fastwebnet.it ([93.43.212.104] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2ayq-0002Iu-Mq; Mon, 03 Aug 2020 13:58:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org
Subject: [PATCH] init: fix init_dup
Date:   Mon,  3 Aug 2020 15:58:19 +0200
Message-Id: <20200803135819.751465-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't allocate an unused fd for each call.  Also drop the extra
reference from filp_open after the init_dup calls while we're at it.

Fixes: 36e96b411649 ("init: add an init_dup helper")
Reported-by Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Al, feel free to fold this into the original patch, as that is the
last one in the branch.

 fs/init.c   | 2 +-
 init/main.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/init.c b/fs/init.c
index 730e05acda2392..e9c320a48cf157 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -260,6 +260,6 @@ int __init init_dup(struct file *file)
 	fd = get_unused_fd_flags(0);
 	if (fd < 0)
 		return fd;
-	fd_install(get_unused_fd_flags(0), get_file(file));
+	fd_install(fd, get_file(file));
 	return 0;
 }
diff --git a/init/main.c b/init/main.c
index 089e21504b1fc1..9dae9c4f806bb9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1470,6 +1470,7 @@ void __init console_on_rootfs(void)
 	init_dup(file);
 	init_dup(file);
 	init_dup(file);
+	fput(file);
 }
 
 static noinline void __init kernel_init_freeable(void)
-- 
2.27.0

