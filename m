Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81EC2820A9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgJCCzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJCCzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E9EC0613E7
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=a6rXTb4p9M3grB7I8IIFpEsnjAcJ5xvKxvNBP1IIEow=; b=XnPmpsW5iVwSBTyCEqZU4KyhFH
        Gq397VGo5pn/Y0iFu+R77E1YnstSU/nyAlo2QMk63lQNVTLNFMbZ4i8dxC08MfAhTq4PHcl29/o3u
        WTnM05iRMcvpS8pGqJ7KA7kr2kJ7n2NQUAkTCs8SbZvzCI2+4vW+rZkKjuq8BpUdBNFVnhJxIIYYp
        FNOZenfGdNsrk9SDbUt9SO7SzYhn5FDutOb+nI8mtPJViXGpxtZZFj9f/9+SPxupG29foLV1yTKIW
        5WWClrj9J8wKMBuSOFIDGgGmHe7aHFwcpy77l+0owVm7CrBMW3LlNkyyJ7xZhIpeFz7Kd2j0dknZg
        BGYJ8o1w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhy-0005Vp-Eu; Sat, 03 Oct 2020 02:55:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/13] target: Pass a NULL pointer to kernel_write
Date:   Sat,  3 Oct 2020 03:55:32 +0100
Message-Id: <20201003025534.21045-12-willy@infradead.org>
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
 drivers/target/target_core_alua.c | 3 +--
 drivers/target/target_core_pr.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index 6b72afee2f8b..98b702e50961 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -883,14 +883,13 @@ static int core_alua_write_tpg_metadata(
 	u32 md_buf_len)
 {
 	struct file *file = filp_open(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
-	loff_t pos = 0;
 	int ret;
 
 	if (IS_ERR(file)) {
 		pr_err("filp_open(%s) for ALUA metadata failed\n", path);
 		return -ENODEV;
 	}
-	ret = kernel_write(file, md_buf, md_buf_len, &pos);
+	ret = kernel_write(file, md_buf, md_buf_len, NULL);
 	if (ret < 0)
 		pr_err("Error writing ALUA metadata file: %s\n", path);
 	fput(file);
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 8fc88654bff6..6fb9940e2e02 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -1976,7 +1976,6 @@ static int __core_scsi3_write_aptpl_to_file(
 	char *path;
 	u32 pr_aptpl_buf_len;
 	int ret;
-	loff_t pos = 0;
 
 	path = kasprintf(GFP_KERNEL, "%s/pr/aptpl_%s", db_root,
 			&wwn->unit_serial[0]);
@@ -1993,7 +1992,7 @@ static int __core_scsi3_write_aptpl_to_file(
 
 	pr_aptpl_buf_len = (strlen(buf) + 1); /* Add extra for NULL */
 
-	ret = kernel_write(file, buf, pr_aptpl_buf_len, &pos);
+	ret = kernel_write(file, buf, pr_aptpl_buf_len, NULL);
 
 	if (ret < 0)
 		pr_debug("Error writing APTPL metadata file: %s\n", path);
-- 
2.28.0

