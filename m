Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587172A5FC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 09:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgKDIi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 03:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgKDIi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:38:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A99C0613D3;
        Wed,  4 Nov 2020 00:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jq+SLlFg5Rp7aoY+6e/cCBd7mqDUva/P1tZgwKBac4Y=; b=UWp/1f22vmOs55Avsbw7tz25/p
        /3vx+cyEQXU+bA4zPNiaC6Dfbfp4Qmt/U5jDy0c/8kqN5peBaVixpqXaew7SDO9Z29OFjcOyJYYTJ
        Gq2kSnOR5NL8nprDJ5gkC+c98YFWM4PR6kBxkOSlTndsWnRcugicqxUp9UgLCduNQEQkCjxVDjq/S
        EViaPlWT69OP8xBxF9B6W90zC2wK36cofVl31CyQdT4CRwRyp9pBq02122bhCxvjJWO3PpNl5g3xm
        lppJngnpipuRsnyFIe79DDWl+y0O5I8pcYNsmVV9DGR3YCEBcpJeL5zK4k5uRYzSFX/PdO/hzW3Aq
        n6q1OKhQ==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaEJd-0004ua-1s; Wed, 04 Nov 2020 08:38:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] proc/stat: switch to ->read_iter
Date:   Wed,  4 Nov 2020 09:27:36 +0100
Message-Id: <20201104082738.1054792-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104082738.1054792-1-hch@lst.de>
References: <20201104082738.1054792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement ->read_iter so that splice can be used on this file.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 46b3293015fe61..4695b6de315129 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -226,7 +226,7 @@ static int stat_open(struct inode *inode, struct file *file)
 static const struct proc_ops stat_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= stat_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 };
-- 
2.28.0

