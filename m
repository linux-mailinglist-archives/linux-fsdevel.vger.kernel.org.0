Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BDD21145A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgGAUXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgGAUX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:23:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A66C08C5DB;
        Wed,  1 Jul 2020 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Tf3n/nAccIE+s6qWSUTEFb74RSxLQMp+OwHpsijS1gA=; b=ha5jsD/vgrF/2frL97A1CCZLgM
        KSuwA/LkvUBgaWBXfhpAYX4RPQs321B/tQaYBQuNpocq6ihzPfSXbQAIvb/i+pj54zqSrNfEwSQ0F
        wmc/unBVZomnw+zGN/HxNZJkzJ0jaMNksQY9/lJ/djk22zo2tgWkYUC9w7Y/5Y09faO5xvRC8tAob
        l2CaKmIgjoSnxLCAAKM4ZF/tDnVAH7TIO5fqNkkRmXZnwLpQOlhGY/v/+t5xF0UtPP+sXBWxkOZ70
        5FMKY4J8jGThcKLKlWOKAmGRTAhvCwGDSEbTxf5da9X1sId/SXGqjgx4Zl5436GkNncCiWwi2oJyD
        q9mDJ74Q==;
Received: from [2001:4bb8:18c:3b3b:379a:a079:66b5:89c3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjGL-0002TD-Tu; Wed, 01 Jul 2020 20:23:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/23] sysctl: Call sysctl_head_finish on error
Date:   Wed,  1 Jul 2020 22:09:47 +0200
Message-Id: <20200701200951.3603160-20-hch@lst.de>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This error path returned directly instead of calling sysctl_head_finish().

Fixes: ef9d965bc8b6 ("sysctl: reject gigantic reads/write to sysctl files")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/proc_sysctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 42c5128c7d1c76..6c1166ccdaea57 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -566,8 +566,9 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 		goto out;
 
 	/* don't even try if the size is too large */
-	if (count > KMALLOC_MAX_SIZE)
-		return -ENOMEM;
+	error = -ENOMEM;
+	if (count >= KMALLOC_MAX_SIZE)
+		goto out;
 
 	if (write) {
 		kbuf = memdup_user_nul(ubuf, count);
@@ -576,7 +577,6 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 			goto out;
 		}
 	} else {
-		error = -ENOMEM;
 		kbuf = kzalloc(count, GFP_KERNEL);
 		if (!kbuf)
 			goto out;
-- 
2.26.2

