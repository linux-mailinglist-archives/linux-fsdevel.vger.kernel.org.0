Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD422820A7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgJCCzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgJCCzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C967C0613E2
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7wfBmHwVyHQbmf3I7Eh12tTaqTqbHUTuaYa2EczHws8=; b=iYQ8nPGg7CJl6rJX/e4yWN71wa
        ofDzJthR+BgUaetQvimuVVYFqm9/EWFpj+GzR3KfR1xKhukI9184/3oICyTmW3OMkXTclIE8Kf6Ui
        K7sB5qnY1hm9eeui+A8xOzZS+yHJr5hKC6cbfTq8T1awNNo5Xv0Ni2P5/S2v/5kbt1Uc5liXm9X8W
        Fy5ftiopie/c+GxLC6yNlrOuCT8G0PmCx3K+83nUX+uLsQhzzHUriw5lODkZOo06Mya2MBdQluwN1
        7U8ZDqktg8GusPzvLH/CFTX9B0Tn9uYSvt2i4Dk0uCuJBaZ2NHo62eNSNbdNhGOgvwx8WPCTzTrif
        tIpKmLJg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhw-0005Ut-GA; Sat, 03 Oct 2020 02:55:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/13] um/mconsole: Pass a NULL pointer to kernel_read
Date:   Sat,  3 Oct 2020 03:55:25 +0100
Message-Id: <20201003025534.21045-5-willy@infradead.org>
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
 arch/um/drivers/mconsole_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index a2e680f7d39f..eb33464cc693 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -131,7 +131,6 @@ void mconsole_proc(struct mc_request *req)
 	struct file *file;
 	int first_chunk = 1;
 	char *ptr = req->request.data;
-	loff_t pos = 0;
 
 	ptr += strlen("proc");
 	ptr = skip_spaces(ptr);
@@ -154,7 +153,7 @@ void mconsole_proc(struct mc_request *req)
 	}
 
 	do {
-		len = kernel_read(file, buf, PAGE_SIZE - 1, &pos);
+		len = kernel_read(file, buf, PAGE_SIZE - 1, NULL);
 		if (len < 0) {
 			mconsole_reply(req, "Read of file failed", 1, 0);
 			goto out_free;
-- 
2.28.0

