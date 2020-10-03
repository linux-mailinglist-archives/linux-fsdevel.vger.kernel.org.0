Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7862820A0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgJCCzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgJCCzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D36C0613D0
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vQudb/YZOgOEpYx8+w+kb1tjBdEIBosBFOAll6Co9dA=; b=hj8//l8jzWqe+rmg7+spP4fdYg
        8zzOVMMTziJLLFpYZ67rPRN1TxmSy/PPfqAf2w7UkLukP1jzwR2buK9ztM/p1OVJHrCzeSFobWwsQ
        SROyxEn0o1hKcF+Yv7kdhp/IDAFOoRNQ71qNwGhkptEdAoQb8gucuPVR43WvY26JjXBR5CdXIecv7
        k8juYnVHmWZ2m922/L5QCLwahosEyxytPTYTBBevblepG8q2hvjHkVNVduqZJZAOdklgUZ+IagUf7
        9nZqJiU04T61aBRTlTEAiUeMhwWwBibvODXCTTa6LT+vLMZeFmvBwjJK+kRfdbOIFt1jl/Zm2FTtf
        O908tUaw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhw-0005V0-PS; Sat, 03 Oct 2020 02:55:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/13] x86/aout: Pass a NULL pointer to kernel_read
Date:   Sat,  3 Oct 2020 03:55:26 +0100
Message-Id: <20201003025534.21045-6-willy@infradead.org>
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
 arch/x86/ia32/ia32_aout.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index a09fc37ead9d..f2029db06e2b 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -247,10 +247,9 @@ static int load_aout_library(struct file *file)
 	unsigned long bss, start_addr, len, error;
 	int retval;
 	struct exec ex;
-	loff_t pos = 0;
 
 	retval = -ENOEXEC;
-	error = kernel_read(file, &ex, sizeof(ex), &pos);
+	error = kernel_read(file, &ex, sizeof(ex), NULL);
 	if (error != sizeof(ex))
 		goto out;
 
-- 
2.28.0

