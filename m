Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB72820AA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgJCCzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgJCCzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB3EC0613E4
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+oV+LcT3sx5oCMOTys3bgBcoEI6gKKfCJtAnBPr5x1c=; b=Xfub/3cjndf93LkJw3WwDukG0n
        lHVcFi2MI7adSWi0/TWrF/guKBMJGglqL4LpkqbiPVFR+Hoedl7HGKpQsMJoEHeq5qiyY2xZc8LJz
        2EuJniqdezddS85mUdJzUJAtwlvWLgIpiTnlTUGCE0QkRpfMzBIyB/apzLe55iW6jM7FgIhfLxRFc
        UKabbaNNzXlkNdRaAFVK2uHQto5yCOKBnfif20C5HYoJNujzyl4zx3uKmcWTHVekwf4xMCuqyC04M
        C3LwBuR1ofxmdU9xc+ESikuincJNsDOb/mthBmGT0NU0aZBmNf1WTILJ5P6qT6Oa6OEtB0ACXqoO1
        iWnCLrnA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhy-0005Vx-P1; Sat, 03 Oct 2020 02:55:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/13] proc: Pass a NULL pointer to kernel_write
Date:   Sat,  3 Oct 2020 03:55:33 +0100
Message-Id: <20201003025534.21045-13-willy@infradead.org>
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
 fs/proc/proc_sysctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 317899222d7f..be9c46833aa5 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1754,7 +1754,6 @@ static int process_sysctl_arg(char *param, char *val,
 	struct file *file;
 	int len;
 	int err;
-	loff_t pos = 0;
 	ssize_t wret;
 
 	if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
@@ -1812,7 +1811,7 @@ static int process_sysctl_arg(char *param, char *val,
 		goto out;
 	}
 	len = strlen(val);
-	wret = kernel_write(file, val, len, &pos);
+	wret = kernel_write(file, val, len, NULL);
 	if (wret < 0) {
 		err = wret;
 		if (err == -EINVAL)
-- 
2.28.0

