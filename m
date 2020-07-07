Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4EF21756A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgGGRsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgGGRsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF51C08C5DC;
        Tue,  7 Jul 2020 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Bo298b9PL3Uu2rIZ3OmLGqOnn53VokHDlRvRjRJg3qI=; b=gUdNvtLu1LXksfHJwAE/PEGff/
        IRsFpXTeIDn0OZgGTZfQLo/BfWKWKGB59MRTKJJ90h/3ou01eixHX+he8bGDRA++03Bo+K5I1uzGu
        lkNR2gHQ74B0o35kSpZRF8LV7wnjMBtvF0ts/annAWLDl5TOD4GWmknlujQnFOA9zpvXDJyf9GWWu
        NV8z22SZ8Myr75iZpxurF2xzxlxlshIYZl1QnU5dpgOH0rsI9j0Wc4I16NUqtYTUTwAV/lJ5v+6Ia
        AAYQ04+5d8u3MlwAALUVKuhrygUFDe2Q74m3gFKfhkNmI/yFcqpHKDc1d+0Vw/5ZrC9DkIbyE5ztX
        /IYoyAdg==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhQ-0003HP-Bm; Tue, 07 Jul 2020 17:48:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/23] fs: unexport __kernel_write
Date:   Tue,  7 Jul 2020 19:47:42 +0200
Message-Id: <20200707174801.4162712-5-hch@lst.de>
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

This is a very special interface that skips sb_writes protection, and not
used by modules anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index bbfa9b12b15eb7..2c601d853ff3d8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -522,7 +522,6 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	inc_syscw(current);
 	return ret;
 }
-EXPORT_SYMBOL(__kernel_write);
 
 ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 			    loff_t *pos)
-- 
2.26.2

