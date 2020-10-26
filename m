Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125EA299563
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 19:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789826AbgJZSbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 14:31:51 -0400
Received: from casper.infradead.org ([90.155.50.34]:47312 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789831AbgJZSbu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HWRDY/xGxom/HFnGYYY2Iux/rYuJshH0/dvieqGPquA=; b=O5P8PEjzWtkJMIjikpin9q4lkl
        7eQsNQjKzfA1g526ZkjcXgfI4VY3b3t5Kw2wabGRFSkhZ5AEEsJo2yERHDSXHX0O9dBWO6YmfTTw9
        nKPHprqoVKwPh21qEdupXeXZGJPj3Qgi87pa68/wl687xkAYMqO7/d2Kqc1zpUQXTFIl1a0HxXvAJ
        sUXgUmeHn+8IigGi3PPh783K7pUSYYGPTH3sNxg0AaZdxuWNBuVzVd/CuIw1n8t5UDKXhFRn9wvNq
        Dbq+UDn1Fu6Zm/W55JVS8N22W6dSAI9QT/h1mQhEBdFmIIkft51EVMAPw2Ptn8zL4WReueepHzJrJ
        R03aeTiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX7HT-0002k5-IT; Mon, 26 Oct 2020 18:31:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     Zi Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 8/9] mm: Fix THP size assumption in mem_cgroup_split_huge_fixup
Date:   Mon, 26 Oct 2020 18:31:35 +0000
Message-Id: <20201026183136.10404-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026183136.10404-1-willy@infradead.org>
References: <20201026183136.10404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Ask the page what size it is instead of assuming PMD size.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3a24e3b619f5..e7824c4dab25 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3280,7 +3280,7 @@ void mem_cgroup_split_huge_fixup(struct page *head)
 	if (mem_cgroup_disabled())
 		return;
 
-	for (i = 1; i < HPAGE_PMD_NR; i++) {
+	for (i = 1; i < thp_nr_pages(head); i++) {
 		css_get(&memcg->css);
 		head[i].mem_cgroup = memcg;
 	}
-- 
2.28.0

