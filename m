Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FBD2078D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404700AbgFXQP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404786AbgFXQOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:14:04 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B69C061795;
        Wed, 24 Jun 2020 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ruv3QkeH3yf1ddYt00bBWdUvSXa4YUB7wJ/k+J42Rps=; b=X2WXdDNrl5NtIMaD8okmbVqsBE
        Fv6aiG5zmAjpVm/DMFeGS7tay3Cf5f9FVcSnt9us7oSjadjcmXAEyFmM+p0v3IzXQKNqPp+NwJzmz
        CjQ8vjnLW3kyWxlPGIijQKtLX4dS/AWJ/ZfG+Qt0oc0osEyuSKPcySr8GK8SaxWB39+n5Dzb1X6RA
        y35R1bHjb3oU4ymyp2ENPfJAtZqrc80i5SQ02RzMhIJfTzA2/MkuBAnK3/WX+F/G7Skaz9nSCHvcl
        /+F7Ham9HemsZjqtXl43dJ8d5tbsciSq62GLSNVI2AGE+seDJbGSvkhmT0+CMUM7Y10UElf8czU20
        xXuiiUpg==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo81v-0005xy-F5; Wed, 24 Jun 2020 16:13:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 05/14] fs: check FMODE_WRITE in __kernel_write
Date:   Wed, 24 Jun 2020 18:13:26 +0200
Message-Id: <20200624161335.1810359-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624161335.1810359-1-hch@lst.de>
References: <20200624161335.1810359-1-hch@lst.de>
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

