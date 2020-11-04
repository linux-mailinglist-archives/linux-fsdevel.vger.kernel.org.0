Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF62A5FC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 09:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgKDInU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 03:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgKDInU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:43:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F15CC0613D3;
        Wed,  4 Nov 2020 00:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BqGMdCF39ToNsf0gCJyADCoWFE//W7MHOhvrYub/R7U=; b=UYHEnYomKrC1JJdW/FZ+RoLjRx
        hziFFRLsLwcP6vhmPRwKsjvYxRn/uprhVjfP+JQjQsdny0TN0CcX/qNuWeKhu/HHY+gvFnlg1HHD8
        mLjilTzU8VkYw9YANpF0W+18l35tFGiu7/EmhMdk7cqc7NsqTWtQKyvij0hn488/q0jaBSwMPCcJb
        hmZiVrwI/VV73iU8zFGfupmX7yET5IxFK/FQOEqgunZAkT8SdVFIb0CBYdfhZ2jJN6Ptjnjys1EkK
        bW/aMjQq/AtOcZZU8CcKzW+0hyZwd75a6BoPO4lrqVN6faLMZ/MClwI5lz75Dgcftlk1zZCZYJ4K8
        KgFyhoPg==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaENv-0005E7-9y; Wed, 04 Nov 2020 08:43:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] proc "seq files": switch to ->read_iter
Date:   Wed,  4 Nov 2020 09:27:38 +0100
Message-Id: <20201104082738.1054792-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104082738.1054792-1-hch@lst.de>
References: <20201104082738.1054792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement ->read_iter for all proc "seq files" so that splice works on
them.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index f81327673f4901..b84663252adda0 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -590,7 +590,7 @@ static int proc_seq_release(struct inode *inode, struct file *file)
 static const struct proc_ops proc_seq_ops = {
 	/* not permanent -- can call into arbitrary seq_operations */
 	.proc_open	= proc_seq_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= proc_seq_release,
 };
-- 
2.28.0

