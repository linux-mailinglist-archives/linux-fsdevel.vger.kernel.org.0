Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF451EC8F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 07:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgFCFwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 01:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFCFww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:52:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF30C05BD43;
        Tue,  2 Jun 2020 22:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QN7oI7JO3aC05O3t9oy8oBvuvZKExBcNr+amt4s0nQk=; b=uMvIOi8ieP0EvZtaJSUdZoPpIZ
        SxrxdLMf/Y7nbP6vTq9eyjskD9kCNrajX6mjMa22Xap973Ax/v77D45XQ4pzSSTV60XrYFtvG+XKI
        7SClKN0YP6cRH6RQh5FgU4zf8q7AXvKZnYOoxmNPamDyV+GrDW+eLtfGbjuAxGiPEO4KgJNbYe+SD
        q4biRsgdr8XscXExlfyl514kQDWKX4QekFEQPHZNQ6ld7B88OA4EStVxpDp0MgY/lbnmwIJTDJNc/
        ZIaw5eIIMHKsKxJYzlFNlTb74nPJU2H//Pk+NI5pFEEFKuBJ17FQoMgUO/s5ApRzZPquujJgA8qC4
        LBQLGMkw==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgMKY-0003rC-M1; Wed, 03 Jun 2020 05:52:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        build test robot <lkp@intel.com>
Subject: [PATCH 4/4] trace: fix an incorrect __user annotation on stack_trace_sysctl
Date:   Wed,  3 Jun 2020 07:52:37 +0200
Message-Id: <20200603055237.677416-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603055237.677416-1-hch@lst.de>
References: <20200603055237.677416-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No user pointers for sysctls anymore.

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Reported-by: build test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/ftrace.h     | 5 ++---
 kernel/trace/trace_stack.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ddfc377de0d2c..fce81238f304d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -319,9 +319,8 @@ static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs,
 
 extern int stack_tracer_enabled;
 
-int stack_trace_sysctl(struct ctl_table *table, int write,
-		       void __user *buffer, size_t *lenp,
-		       loff_t *ppos);
+int stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
+		       size_t *lenp, loff_t *ppos);
 
 /* DO NOT MODIFY THIS VARIABLE DIRECTLY! */
 DECLARE_PER_CPU(int, disable_stack_tracer);
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index c557f42a93971..98bba4764c527 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -515,9 +515,8 @@ static const struct file_operations stack_trace_filter_fops = {
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 int
-stack_trace_sysctl(struct ctl_table *table, int write,
-		   void __user *buffer, size_t *lenp,
-		   loff_t *ppos)
+stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
+		   size_t *lenp, loff_t *ppos)
 {
 	int was_enabled;
 	int ret;
-- 
2.26.2

