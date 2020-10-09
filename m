Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D7288B28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbgJIObt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388851AbgJIObL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:31:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4727EC0613D6;
        Fri,  9 Oct 2020 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GW1YniPzUpda1PIsi2+AeQMOnKxd544xKFcJ+bcv5fM=; b=UkGU12VIIK99MHzzfEryJUWbjO
        A0nKktmS8L+pBXk27jD0P9xgYbyljS6tsG8fMjJJpMDG2kRA2N8MVd7r4ckabTScnK0YgmTTfTxJs
        FWD0S5kScgojp6mVIa5rSQ7tkL6wO/nzblA4AN5aaXMhmOo+V/mRvQ3bc3iTPjQQLC5rkw3ueoU9n
        T2v4r1/bCFm0FHkTqpfc7gLV+TXyWxNrhpFXAnWXyVvuzv8EY5bzSr1+wA8/3w0M2H2fL7oL7chak
        g7Z8Ez1HNYatDB1fkRf1mxdg6JbokrEYb5spx6bU41Om7N/n7D5GJbHbOJ1lTZ9qxmEpBDlnJ130m
        t/QP01eQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQtQL-0005va-Lv; Fri, 09 Oct 2020 14:31:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-xfs@vger.kernel.org
Subject: [PATCH v2 10/16] hostfs: Tell the VFS that readpage was synchronous
Date:   Fri,  9 Oct 2020 15:30:58 +0100
Message-Id: <20201009143104.22673-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The hostfs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c070c0d8e3e9..c49221c09c4b 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -455,6 +455,8 @@ static int hostfs_readpage(struct file *file, struct page *page)
  out:
 	flush_dcache_page(page);
 	kunmap(page);
+	if (!ret)
+		return AOP_UPDATED_PAGE;
 	unlock_page(page);
 	return ret;
 }
-- 
2.28.0

