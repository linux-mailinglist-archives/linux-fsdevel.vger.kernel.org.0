Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8506C1E56D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 07:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgE1Fli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 01:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgE1FlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 01:41:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC7C08C5C2;
        Wed, 27 May 2020 22:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=v2d8pva8LsFTXWqDIrLlQ4NNcDJbw9ZGB5N3mHruM2Q=; b=Sly8RB2C62rL3Ag/ASebOALXhx
        jsuXC/klqC7pOqgzkf/1FnDCemkL8CJ+lOg3UTElUUlsu9+DZ105kBNCHmi+9z0Ta/66886wFbboz
        l7cRNTN6XYxRap49QE9qL0m7mfcweYdrhtbur4ZVe8uphe8UNliBog+pZxXlUHfN6u3eaS52CjD79
        Jw3HmMizeh4AfoIP9whoapShinlg6Nkm3V0ALzdCPd1D0DJShVbS/oiyoWWswaMQ+V7VEO7EesKii
        0gmtiASmBpMtbs6ccT1OWSAcIdicHs9kNujJoQ7qL8XZ8FSzweMvmqkaQed43j7l05cBGEGl5Ld5h
        79rnpqIg==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeBI3-0002Qp-M1; Thu, 28 May 2020 05:41:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 11/14] integrity/ima: switch to using __kernel_read
Date:   Thu, 28 May 2020 07:40:40 +0200
Message-Id: <20200528054043.621510-12-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528054043.621510-1-hch@lst.de>
References: <20200528054043.621510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__kernel_read has a bunch of additional sanity checks, and this moves
the set_fs out of non-core code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 security/integrity/iint.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index e12c4900510f6..1d20003243c3f 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -188,19 +188,7 @@ DEFINE_LSM(integrity) = {
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count)
 {
-	mm_segment_t old_fs;
-	char __user *buf = (char __user *)addr;
-	ssize_t ret;
-
-	if (!(file->f_mode & FMODE_READ))
-		return -EBADF;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = __vfs_read(file, buf, count, &offset);
-	set_fs(old_fs);
-
-	return ret;
+	return __kernel_read(file, addr, count, &offset);
 }
 
 /*
-- 
2.26.2

