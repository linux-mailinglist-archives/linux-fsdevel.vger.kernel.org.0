Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206F83C6411
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhGLTtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbhGLTtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:49:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78761C0613DD;
        Mon, 12 Jul 2021 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ls0PDTK4GmPt7o8GB9HWSuuERwLuQPqR3wzi6YV9cbE=; b=msR3r+CxymI9f1TqwdX859M2f8
        efT+6ox25yrnjVp3xSbuo1jNeYNQt9Mm91BMyQyib0fBd5lcHveUyoKoMqSea2uKsdOVNBejxvFxH
        RRjJW9oV+v1DKdrPlaJh/OoClBowrGno3ocy9gVJKmlTAYyEq8PPAaEOXOHBcZkEp/A+4lqsJKPha
        3R57wRTj0xzTnVbTRL0F+SPllevLR0VUmztl6eBJraPpxfo5kCHaKsjPHPKBdiZFqXUZb8qUUBb48
        MRWVNUgJ8Ifnc8DX+mX+cSOQX0jhrALm7IT9BQeR5MeE2DTWnVbrYZxx1mtI1HZyv0sOs1JTQzXOP
        RCUnMJUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31sX-000Nvm-4F; Mon, 12 Jul 2021 19:46:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 01/18] mm: Add folio_nid()
Date:   Mon, 12 Jul 2021 20:45:34 +0100
Message-Id: <20210712194551.91920-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712194551.91920-1-willy@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of page_to_nid().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a856c078e040..80f27eb151ba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1427,6 +1427,11 @@ static inline int page_to_nid(const struct page *page)
 }
 #endif
 
+static inline int folio_nid(const struct folio *folio)
+{
+	return page_to_nid(&folio->page);
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 static inline int cpu_pid_to_cpupid(int cpu, int pid)
 {
-- 
2.30.2

