Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790CD3E7C0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbhHJPWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242957AbhHJPWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:22:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A38C0613D3;
        Tue, 10 Aug 2021 08:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=i2aSZmavKDHCT/DkTtD/CFUJjsvlzBlnTR8HFnC7uGg=; b=QdWOp7kddD8VY/dPEPXkD65/P7
        jP8EkIH5P+WKYuySxO2hYK6pfFNcPtxKEqWMJ5MYO1AD3jT2hqonPM9k1DhrY5DnodAfEg3x6NM3K
        VHa8+yDP22iGrsh9VJeB4cCz9DKyVqZ0Jc9cnhkux5medMVl0m+hygDixdAnBLQmUijC/ZuhPBZlA
        82f7FpWkFwq/QGdEVEsMqnYF2JQMz0WlcEhKy2BLN6WM1GmwbsWyK+SXsYi8OQooUp/JBg6pWliov
        HRV+N9zUtwb5iU76wXc0wutBKysCXnicIE5yNPQnrkSRS+Pw4/sYk9ejl9f3Iye8nFhWCT+nTiJ5B
        CrGxDf6A==;
Received: from 089144200071.atnat0009.highway.a1.net ([89.144.200.71] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDTXe-00CHDz-Pl; Tue, 10 Aug 2021 15:20:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] proc: stop using seq_get_buf in proc_task_name
Date:   Tue, 10 Aug 2021 17:19:45 +0200
Message-Id: <20210810151945.1795567-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use seq_escape_str and seq_printf instead of poking holes into the
seq_file abstraction.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/array.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index ee0ce8cecc4a..49be8c8ef555 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -98,27 +98,17 @@
 
 void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 {
-	char *buf;
-	size_t size;
 	char tcomm[64];
-	int ret;
 
 	if (p->flags & PF_WQ_WORKER)
 		wq_worker_comm(tcomm, sizeof(tcomm), p);
 	else
 		__get_task_comm(tcomm, sizeof(tcomm), p);
 
-	size = seq_get_buf(m, &buf);
-	if (escape) {
-		ret = string_escape_str(tcomm, buf, size,
-					ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
-		if (ret >= size)
-			ret = -1;
-	} else {
-		ret = strscpy(buf, tcomm, size);
-	}
-
-	seq_commit(m, ret);
+	if (escape)
+		seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
+	else
+		seq_printf(m, "%.64s", tcomm);
 }
 
 /*
-- 
2.30.2

