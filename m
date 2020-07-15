Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E627B220586
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgGOGyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgGOGyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:54:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9764BC061755;
        Tue, 14 Jul 2020 23:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=y+69naeMbJzLmps1ix1zIh5S0S7ZMs54M4SKXhvxIQw=; b=m5M0g8I044GkmEWX1jwLHudNgg
        Y+R7SYA1jyAZiY2QPIlKeZnT/BMBXmOsKpm66Wg/2BFzyBNPno9O6z6DEvT49dtjIx21GcnTrCXQR
        M/MrLXSh8EjTApsGbTG3LZaaIAcqn06MVY+gfWePppXQm72I/Knz3pBbii8lerEJfot94ZLRdUJFq
        tbE5Ekq60OkT/InvLe5vM1FZpUKnspDXaMk+F2zVesBJysWviC8GKPDR5Kkyb/RnQXY9d8I8CnuUG
        dROrl1xSVgpjtTdlb6JMDsXnb53vLlNuoBwD0soTpbOOqMfhHxoJXRlDHOVA0ILXdGczFilL6cky5
        Mfv0KDYw==;
Received: from [2001:4bb8:105:4a81:1c8f:d581:a5f2:bdb7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvbJR-0001kO-9X; Wed, 15 Jul 2020 06:54:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] initramfs: use vfs_utimes in do_copy
Date:   Wed, 15 Jul 2020 08:54:34 +0200
Message-Id: <20200715065434.2550-5-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715065434.2550-1-hch@lst.de>
References: <20200715065434.2550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't bother saving away the pathname and just use the new struct path
based utimes helper instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index c335920e5ecc2d..3823d15e5d2619 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -201,7 +201,6 @@ static inline void __init eat(unsigned n)
 	byte_count -= n;
 }
 
-static __initdata char *vcollected;
 static __initdata char *collected;
 static long remains __initdata;
 static __initdata char *collect;
@@ -342,7 +341,6 @@ static int __init do_name(void)
 			vfs_fchmod(wfile, mode);
 			if (body_len)
 				vfs_truncate(&wfile->f_path, body_len);
-			vcollected = kstrdup(collected, GFP_KERNEL);
 			state = CopyFile;
 		}
 	} else if (S_ISDIR(mode)) {
@@ -365,11 +363,16 @@ static int __init do_name(void)
 static int __init do_copy(void)
 {
 	if (byte_count >= body_len) {
+		struct timespec64 t[2] = { };
+
 		if (xwrite(wfile, victim, body_len) != body_len)
 			error("write error");
+
+		t[0].tv_sec = mtime;
+		t[1].tv_sec = mtime;
+		vfs_utimes(&wfile->f_path, t);
+
 		fput(wfile);
-		do_utime(vcollected, mtime);
-		kfree(vcollected);
 		eat(body_len);
 		state = SkipIt;
 		return 0;
-- 
2.27.0

