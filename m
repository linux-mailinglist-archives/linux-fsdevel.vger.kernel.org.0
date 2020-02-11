Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6171599BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 20:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgBKT0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 14:26:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48205 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbgBKT0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581449200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=u+0GYiep1QB0KPutSBZqydXJKykgwUd1aiyZ3fQymnw=;
        b=TCigELLDwGakr2++TAX6674A2nGKWL0HeURfyxo+JkypZxoqoJnTM0j6kaT8Ub7EJU5hZr
        NnM75KmjzkQcfWj0eNjW9AVXfWQKYKUB/fuX9KQZDJGmsY0z4vcYpNp3ZwpWgKeEgC8S2j
        +7ik7zIkdQQjNkMnPuprTPCY8K8Q9Xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-CWooVX0WOK27TOLNEmxwcQ-1; Tue, 11 Feb 2020 14:26:36 -0500
X-MC-Unique: CWooVX0WOK27TOLNEmxwcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E7B6800D41;
        Tue, 11 Feb 2020 19:26:35 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0103D5D9E2;
        Tue, 11 Feb 2020 19:26:34 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id C950D866BE;
        Tue, 11 Feb 2020 19:26:34 +0000 (UTC)
Date:   Tue, 11 Feb 2020 14:26:34 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, Andreas Gruenbacher <agruenba@redhat.com>
Message-ID: <1350360444.7695146.1581449194730.JavaMail.zimbra@redhat.com>
In-Reply-To: <1527244171.7695063.1581449058353.JavaMail.zimbra@redhat.com>
Subject: [PATCH] fs: clean up __block_commit_write
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.36.116.223, 10.4.195.18]
Thread-Topic: clean up __block_commit_write
Thread-Index: eBERf7LiVHkczv0v1pxcMer2hXYuOQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Function __block_commit_write did nothing with the inode passed in
and it always returned 0. This patch changes it to a void and gets
rid of the overhead needed to pass in the inode.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/buffer.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b8d28370cfd7..19bfc86e6a8f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2059,8 +2059,7 @@ int __block_write_begin(struct page *page, loff_t pos, unsigned len,
 }
 EXPORT_SYMBOL(__block_write_begin);
 
-static int __block_commit_write(struct inode *inode, struct page *page,
-		unsigned from, unsigned to)
+static void __block_commit_write(struct page *page, unsigned from, unsigned to)
 {
 	unsigned block_start, block_end;
 	int partial = 0;
@@ -2094,7 +2093,6 @@ static int __block_commit_write(struct inode *inode, struct page *page,
 	 */
 	if (!partial)
 		SetPageUptodate(page);
-	return 0;
 }
 
 /*
@@ -2130,7 +2128,6 @@ int block_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
-	struct inode *inode = mapping->host;
 	unsigned start;
 
 	start = pos & (PAGE_SIZE - 1);
@@ -2156,7 +2153,7 @@ int block_write_end(struct file *file, struct address_space *mapping,
 	flush_dcache_page(page);
 
 	/* This could be a short (even 0-length) commit */
-	__block_commit_write(inode, page, start, start+copied);
+	__block_commit_write(page, start, start+copied);
 
 	return copied;
 }
@@ -2469,8 +2466,7 @@ EXPORT_SYMBOL(cont_write_begin);
 
 int block_commit_write(struct page *page, unsigned from, unsigned to)
 {
-	struct inode *inode = page->mapping->host;
-	__block_commit_write(inode,page,from,to);
+	__block_commit_write(page, from, to);
 	return 0;
 }
 EXPORT_SYMBOL(block_commit_write);

