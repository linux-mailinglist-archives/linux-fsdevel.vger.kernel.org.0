Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF252820A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgJCCzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgJCCzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE2C0613E6
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=r+DrRNf/YvIlg8iiF7HHU8Cai8iu71aY/7FqVYN0BRM=; b=ned4PYyHjgF+26+mwwxw1aHiuq
        QDuuCsBJl3rUyaIrWB/NWyRy9JxWSnCxc95D917cqlwNWEcsvhC9sWtaP8c9PAxAHRDUbHzvQMSAN
        aVfrBSI5sWYi35Yfb6C0T0C7zDplNQ2RidvUoKz/f/4Cs2XU1aJHvlsb4+pv614lK8CI+pQvE129G
        61lHaGVcGQwc2Bm/Sb/ImapC1VZhN/uJB5aAlhgmlM+4Bre9gwCksmnPPxNmJ5/xEpNQTXd5hV5YV
        UW3BhRiO7Ru6JEminQrcQniJaRe4iHyNmjTiJvQDSi3cGGc0JFxVHQkW5LIZ8O2/KuEcvLHjLMCyi
        Kdj35ZNg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhx-0005VZ-SO; Sat, 03 Oct 2020 02:55:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/13] bpfilter: Pass a NULL pointer to kernel_read and kernel_write
Date:   Sat,  3 Oct 2020 03:55:30 +0100
Message-Id: <20201003025534.21045-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201003025534.21045-1-willy@infradead.org>
References: <20201003025534.21045-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We want to start at 0 and do not care about the updated value.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 net/bpfilter/bpfilter_kern.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 51a941b56ec3..bca294c9253f 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -34,21 +34,18 @@ static void __stop_umh(void)
 static int bpfilter_send_req(struct mbox_request *req)
 {
 	struct mbox_reply reply;
-	loff_t pos = 0;
 	ssize_t n;
 
 	if (!bpfilter_ops.info.tgid)
 		return -EFAULT;
-	pos = 0;
 	n = kernel_write(bpfilter_ops.info.pipe_to_umh, req, sizeof(*req),
-			   &pos);
+			   NULL);
 	if (n != sizeof(*req)) {
 		pr_err("write fail %zd\n", n);
 		goto stop;
 	}
-	pos = 0;
 	n = kernel_read(bpfilter_ops.info.pipe_from_umh, &reply, sizeof(reply),
-			&pos);
+			NULL);
 	if (n != sizeof(reply)) {
 		pr_err("read fail %zd\n", n);
 		goto stop;
-- 
2.28.0

