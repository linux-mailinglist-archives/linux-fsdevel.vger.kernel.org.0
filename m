Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1609E2A5FC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 09:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKDIlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 03:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgKDIlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:41:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF01C0613D3;
        Wed,  4 Nov 2020 00:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=a5oULKFczWJE8wpPo185mmyf8X80bBrK4/ugxfglgnU=; b=uujTH7VPF6HBLc/vJ0bdcBFvw2
        CddWcgIvkvEeYPEFRb47JQGxGAQ4W0JoRLGvjCCay/DM66uVZtmQTlERlZyRNflzsXwGfsX/aJaW6
        MrVIQZWIUCFEugls4IyytjsdsTYndqwLRVR05vSa0Ur0M6KFEzztyCYqPvos3n7Kd3+vaQzDog6vw
        1XWWRY8CfBU+oSWjFuIVjXJ4fAKtnsAuPmrJSyJrwbtfcTK/kw6YDX6guPbqTTpLhC7bK6DSF3ISW
        e869ay/712vTS/rS8FF8SY3QXgXft7YvgbRljun9Y6Bh20f+hAPVQu7HxvLA6tjzsftzFdqoRKIL+
        7h+94+Gw==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaELm-00057P-7p; Wed, 04 Nov 2020 08:41:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@google.com>
Subject: [PATCH 5/6] proc "single files": switch to ->read_iter
Date:   Wed,  4 Nov 2020 09:27:37 +0100
Message-Id: <20201104082738.1054792-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104082738.1054792-1-hch@lst.de>
References: <20201104082738.1054792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@google.com>

Implement ->read_iter for all proc "single files" so that more bionic
tests cases can pass when they call splice() on other fun files like
/proc/version

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 2f9fa179194d72..f81327673f4901 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -621,7 +621,7 @@ static int proc_single_open(struct inode *inode, struct file *file)
 static const struct proc_ops proc_single_ops = {
 	/* not permanent -- can call into arbitrary ->single_show */
 	.proc_open	= proc_single_open,
-	.proc_read	= seq_read,
+	.proc_read_iter = seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 };
-- 
2.28.0

