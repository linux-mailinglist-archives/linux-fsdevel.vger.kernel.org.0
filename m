Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B62115BFDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 14:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgBMN5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 08:57:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57856 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730109AbgBMN5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581602229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=2/TsokBgSpqMd4MzulK7hW0+NswHzLQLQHSif5OxWtk=;
        b=i3DJ+ZBt15aZyxWl8F/gbzToRnpCmD6hRaeEw1Qvmyh22o1g6CPtmD8JvXa2tqVIbNO0sl
        4YtT1Rn62mTJKjy+F4rgpGchKMVoRKaOoIMaHrKAnq5aagwf3YP/nXOoLzx19lLrZGYx3q
        qy0w+kW3DU0g2hZZgexo/v3EbC+4elw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-60ocgYqTNmu8Dd-MxHOyAg-1; Thu, 13 Feb 2020 08:57:06 -0500
X-MC-Unique: 60ocgYqTNmu8Dd-MxHOyAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AD4E8E2DC0;
        Thu, 13 Feb 2020 13:57:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ED2A5C1C3;
        Thu, 13 Feb 2020 13:57:05 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id F20988B2A3;
        Thu, 13 Feb 2020 13:57:04 +0000 (UTC)
Date:   Thu, 13 Feb 2020 08:57:04 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Message-ID: <1454296586.8777883.1581602224759.JavaMail.zimbra@redhat.com>
In-Reply-To: <1350360444.7695146.1581449194730.JavaMail.zimbra@redhat.com>
Subject: [PATCH v2] fs: clean up __block_commit_write
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.36.116.223, 10.4.195.4]
Thread-Topic: clean up __block_commit_write
Thread-Index: 8iJZlxlKNG2njZeT0x82wFMyBH/uTg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al,

Can you add this to your tree then? (Christoph's suggestion has been implemented).

Bob

Function __block_commit_write did nothing with the inode passed in
and it always returned 0. This patch changes it to a void and gets
rid of the overhead needed to pass in the inode.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b8d28370cfd7..07e0a327be4a 100644
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
+	__block_commit_write(page, start, start + copied);
 
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

