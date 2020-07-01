Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2C121143F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGAUU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGAUU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:20:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BBBC08C5C1;
        Wed,  1 Jul 2020 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Bo298b9PL3Uu2rIZ3OmLGqOnn53VokHDlRvRjRJg3qI=; b=uMWgaUli7AAOBW65spdPhtl/6v
        xzbYcUgWDw7Lpt5tmjmGaMAhK7GMJIJsRyv1wTqsYic1BaKQTUS521VceaKgd2kwvkKsup+1Tz8w2
        0YfRarA12bW2qkAgbvlgheW62QvZdrAPWk7OCUrU10qGNEyIm5QTqr4gkhGH/rMFBVOlsQjn1tsyA
        Fio/3yi/tN29tfjH5qdbc2sCJXtWgffks2JkARF/XOMjnLd9OuIUphMT9Qo02e9xFjraPf0U4kSNz
        1fFuwJSOFWZD/poOq5HLrQ/UxOu77N5y+DChBx7iv6rLcFGzp4v3j5yGGM+YfjCP+CR4lb6Sn0azw
        8Y/zsVYQ==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjDw-0002Ay-VY; Wed, 01 Jul 2020 20:20:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/23] fs: unexport __kernel_write
Date:   Wed,  1 Jul 2020 22:09:32 +0200
Message-Id: <20200701200951.3603160-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701200951.3603160-1-hch@lst.de>
References: <20200701200951.3603160-1-hch@lst.de>
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

