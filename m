Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E607C21758C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgGGRt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgGGRsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3667C061755;
        Tue,  7 Jul 2020 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ruv3QkeH3yf1ddYt00bBWdUvSXa4YUB7wJ/k+J42Rps=; b=X75j3alJTwTh4rHPd55B93+/Ks
        ZDooFPCkgJDSFe7kTvl8S0qHXjcPmrmVbG4kE5dWn1aBg5XcL6O2bt8sjQ+Y0LyjxwLL8OYuXVJEE
        QJg4Jx9j4QBGZsgyNooR7TZverM3Wp6pGQqw0F+eU0Yzn0ze1RrSnrO2yEuzgQy+yUO1hUjt2IlNy
        LEif7xEfDnBwEFUvbESNgImccJHWXdjllpjiyDHeEoJfJScVp1c4r82NLoB4A6Aa5gi+kqigR6nAm
        TIQgpDqDmndI3RL3N8pn5i3la1sn/13TK6GpesmHTrlecc2SAf58SHpV/4uupE4zcwuBY6ipMIRTQ
        P6nfKkKQ==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhR-0003Ha-E1; Tue, 07 Jul 2020 17:48:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/23] fs: check FMODE_WRITE in __kernel_write
Date:   Tue,  7 Jul 2020 19:47:43 +0200
Message-Id: <20200707174801.4162712-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a WARN_ON_ONCE if the file isn't actually open for write.  This
matches the check done in vfs_write, but actually warn warns as a
kernel user calling write on a file not opened for writing is a pretty
obvious programming error.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 2c601d853ff3d8..8f9fc05990ae8b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -505,6 +505,8 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	const char __user *p;
 	ssize_t ret;
 
+	if (WARN_ON_ONCE(!(file->f_mode & FMODE_WRITE)))
+		return -EBADF;
 	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 
-- 
2.26.2

