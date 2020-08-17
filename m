Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B58245E05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 09:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHQHc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 03:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQHcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:32:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9EAC061388;
        Mon, 17 Aug 2020 00:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bPO6IUsgQ1dooQn8lqNrZ8txirq2bFGwte1YnA3ccwk=; b=ULgPyG8AIdpi54WFRLGQa3atjG
        MYcmUn91T2ZJwQ8XUjt9xRibemgLD7hIV+9q374K0MCkC0goKr1Y5e6cPl974kSIuI9du3LtRhqWy
        pVNlGGcYWdlFvV35a8J+rXDvK/p4cY4tcFx0JloEF90rwLpx6aRcRrKuOjirQ9xAKtPSPbpuRxs7c
        3Ey2vwIhY4owqJn2UjpCnCdSPT4bw5VuudP/c4hvH+V44EHWcyL4DPUp+UiUSngAzDKo4/Iu/3U4j
        qumfNWtUCBhkIE77s5aYJXDpSNz0oppHKsoMsQuY93PpZh7c4n94SxD6zUNW0R+Mw0/+U5Ii6zhDS
        k6IPCgFQ==;
Received: from [2001:4bb8:188:3918:4550:cdf7:3d45:afb9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7Zcu-0000uv-IA; Mon, 17 Aug 2020 07:32:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/11] mem: remove duplicate ops for /dev/zero and /dev/null
Date:   Mon, 17 Aug 2020 09:32:02 +0200
Message-Id: <20200817073212.830069-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817073212.830069-1-hch@lst.de>
References: <20200817073212.830069-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no good reason to implement both the traditional ->read and
->write as well as the iter based ops.  So implement just the iter
based ones.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/char/mem.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 687d4af6945d36..14851f36787372 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -670,18 +670,6 @@ static ssize_t write_port(struct file *file, const char __user *buf,
 	return tmp-buf;
 }
 
-static ssize_t read_null(struct file *file, char __user *buf,
-			 size_t count, loff_t *ppos)
-{
-	return 0;
-}
-
-static ssize_t write_null(struct file *file, const char __user *buf,
-			  size_t count, loff_t *ppos)
-{
-	return count;
-}
-
 static ssize_t read_iter_null(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
@@ -872,7 +860,6 @@ static int open_port(struct inode *inode, struct file *filp)
 
 #define zero_lseek	null_lseek
 #define full_lseek      null_lseek
-#define write_zero	write_null
 #define write_iter_zero	write_iter_null
 #define open_mem	open_port
 #define open_kmem	open_mem
@@ -903,8 +890,6 @@ static const struct file_operations __maybe_unused kmem_fops = {
 
 static const struct file_operations null_fops = {
 	.llseek		= null_lseek,
-	.read		= read_null,
-	.write		= write_null,
 	.read_iter	= read_iter_null,
 	.write_iter	= write_iter_null,
 	.splice_write	= splice_write_null,
@@ -919,7 +904,6 @@ static const struct file_operations __maybe_unused port_fops = {
 
 static const struct file_operations zero_fops = {
 	.llseek		= zero_lseek,
-	.write		= write_zero,
 	.read_iter	= read_iter_zero,
 	.write_iter	= write_iter_zero,
 	.mmap		= mmap_zero,
-- 
2.28.0

