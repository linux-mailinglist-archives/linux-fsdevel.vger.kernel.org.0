Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8664F290938
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410583AbgJPQE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410571AbgJPQE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7017FC0613E0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7bp7tBDREj0/quRwoGKFhcM4IA6X+ak+6znUWRbIy7w=; b=qgdML7Eu0svzD9aZEAF3t+N+Hl
        WhJ378LctHaJ2RpvavXxT9nHM/zbtJnZoksNdYM4h7jg713eWgZGak3vbcg1/QvZkZIpD9TEvZZxh
        Eb6vMVI5dQhtNO/jFneRGv7v/P72Fr5D5IhyPDLlP6LaSnbLphK93OgTwSOjy8mbZV/ihaYN6oGVb
        UHxuh7O8lrgpZOtQbTDJcREsSgpDewF0WmrSWUJpc3g7OStb+rmjn+B31ZMREHgD/mbLbckdXCvLc
        ef6ebyetdHJQUT8P5idONrecE1bek7FJm3SdogVKgcMF44Ne8fBvksCqGphIwZGuMuuacWl6PGRvJ
        rejNztAw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDt-0004ur-4r; Fri, 16 Oct 2020 16:04:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 18/18] vboxsf: Tell the VFS that readpage was synchronous
Date:   Fri, 16 Oct 2020 17:04:43 +0100
Message-Id: <20201016160443.18685-19-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The vboxsf inline data readpage implementation was already synchronous,
so use AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/vboxsf/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index c4ab5996d97a..c2a144e5cb5a 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -228,6 +228,8 @@ static int vboxsf_readpage(struct file *file, struct page *page)
 	}
 
 	kunmap(page);
+	if (!err)
+		return AOP_UPDATED_PAGE;
 	unlock_page(page);
 	return err;
 }
-- 
2.28.0

