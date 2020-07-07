Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7204B217594
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgGGRsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGRsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3C0C061755;
        Tue,  7 Jul 2020 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jzV+T85fyIY/sAf/kMztKfiAVfq1VzZmIi5LCeoOypo=; b=lMLi+aGsrNxCY3Oj8Qva9lGg5l
        txPcbqJfSTYYP9op3LwyT+uR9tdwA92AaslaNjSEXtheBTxptT0qQI+CmjCI2b8JoTFh86SVTFBmI
        IL/TNqehK0nLGW86csDnn3Zfix6xoKKsU7e1tWtJpucMjZMy6gYLvXf5/AQ0vzZvya/8Lflj7RSGT
        gOUxHayKLqkhrBZo0IAdTKYmUYf7I2nOdhL2lsbZKlvloIXvmugAO0gC70qeURHk9DNnuB2sGQEPQ
        LUUVMelXKCAQeYGbsHhfJpIHUKFwcrOSGonjuj7Guqd39Mn0g44B9Yf0u9jGrnRlyOjZ/Rs3C9byD
        /5xaGPWg==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhO-0003H9-7X; Tue, 07 Jul 2020 17:48:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Kent <raven@themaw.net>
Subject: [PATCH 02/23] autofs: switch to kernel_write
Date:   Tue,  7 Jul 2020 19:47:40 +0200
Message-Id: <20200707174801.4162712-3-hch@lst.de>
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

While pipes don't really need sb_writers projection, __kernel_write is an
interface better kept private, and the additional rw_verify_area does not
hurt here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/waitq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index b04c528b19d342..74c886f7c51cbe 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -53,7 +53,7 @@ static int autofs_write(struct autofs_sb_info *sbi,
 
 	mutex_lock(&sbi->pipe_mutex);
 	while (bytes) {
-		wr = __kernel_write(file, data, bytes, &file->f_pos);
+		wr = kernel_write(file, data, bytes, &file->f_pos);
 		if (wr <= 0)
 			break;
 		data += wr;
-- 
2.26.2

