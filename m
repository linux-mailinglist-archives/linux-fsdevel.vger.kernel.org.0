Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3591F4AFE37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiBIUWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiBIUWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02972E015649
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dCnOJMOAi/wP8BATocAORL5pcnn1AJU1QOWJSgwpzH4=; b=STBWkChZSUibJIQL3+uDCPWT55
        tNHajQ7p4dPR7feBuM4ig2iu6cBUO7oHOB6wAAKqNbEGDwPE8LJoZ/7C2Aec1bF+6UdEXWJxcjWvf
        j/8Z/wUH/0S/JzItphnAqOd/DqXFfDqLwZtpHfuS3H8qA1Z2LXNaqNBq9XEIOEKkpcwlYkq8qGGzP
        zi7eHlo1SIpS2chOSCnw63FLMELp5RLKRFGK8wctuUWqG1e7R8sHtt4I1piF+sjOv6NjBpvJGtfaH
        Kuh4rmVitOB42+V1m7CuEO6OONB69zjWoJhlTpJW5pZeTjE+Ak9fl6+nezAi4WiVZ0VIu/t+37hMv
        Qbk9WJ2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTr-008cpL-Au; Wed, 09 Feb 2022 20:22:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 07/56] buffer: Add folio_buffers()
Date:   Wed,  9 Feb 2022 20:21:26 +0000
Message-Id: <20220209202215.2055748-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While there is no intent to use large folios in filesystems using buffer
heads, converting the filesystems to use single-page folios is still worth
doing to remove legacy infrastructure and hidden calls to compound_head().
These helper functions are needed for that conversion to take place.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/buffer_head.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 36f33685c8c0..3451f1fcda12 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -144,6 +144,7 @@ BUFFER_FNS(Defer_Completion, defer_completion)
 		((struct buffer_head *)page_private(page));	\
 	})
 #define page_has_buffers(page)	PagePrivate(page)
+#define folio_buffers(folio)		folio_get_private(folio)
 
 void buffer_check_dirty_writeback(struct page *page,
 				     bool *dirty, bool *writeback);
-- 
2.34.1

