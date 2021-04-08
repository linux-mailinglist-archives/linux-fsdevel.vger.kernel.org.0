Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B334E3585B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 16:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhDHOFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 10:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231830AbhDHOFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617890697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSWYbhIaJdMrpl7aiwuuHeD5yWsVtmcOiCOXzWCEKpk=;
        b=ZmXyKpUjhY330RUaMDpL+XJecCSnfbvA8OLocuTBe8IojoR2j7KRmEyRloW8rc/NuP6cVO
        3bk28ImSoQkY5pG7F0irovGmyJFWatr3WzhMhOR/N0Ozq+J19PVIW8qGM0kgLbJRor3KJN
        QnK2Eh1ogZKBukNLocyWgwEE+g9wLAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-Y6CR6-g9PnGwphTM_rO9Jg-1; Thu, 08 Apr 2021 10:04:54 -0400
X-MC-Unique: Y6CR6-g9PnGwphTM_rO9Jg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12AEB801FCE;
        Thu,  8 Apr 2021 14:04:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F36525D747;
        Thu,  8 Apr 2021 14:04:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 04/30] fs: Document file_ra_state
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 08 Apr 2021 15:04:46 +0100
Message-ID: <161789068619.6155.1397999970593531574.stgit@warthog.procyon.org.uk>
In-Reply-To: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
References: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

Turn the comments into kernel-doc and improve the wording slightly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20210407201857.3582797-3-willy@infradead.org/
---

 include/linux/fs.h |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..33831a8bda52 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -891,18 +891,22 @@ struct fown_struct {
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
 
-/*
- * Track a single file's readahead state
+/**
+ * struct file_ra_state - Track a file's readahead state.
+ * @start: Where the most recent readahead started.
+ * @size: Number of pages read in the most recent readahead.
+ * @async_size: Start next readahead when this many pages are left.
+ * @ra_pages: Maximum size of a readahead request.
+ * @mmap_miss: How many mmap accesses missed in the page cache.
+ * @prev_pos: The last byte in the most recent read request.
  */
 struct file_ra_state {
-	pgoff_t start;			/* where readahead started */
-	unsigned int size;		/* # of readahead pages */
-	unsigned int async_size;	/* do asynchronous readahead when
-					   there are only # of pages ahead */
-
-	unsigned int ra_pages;		/* Maximum readahead window */
-	unsigned int mmap_miss;		/* Cache miss stat for mmap accesses */
-	loff_t prev_pos;		/* Cache last read() position */
+	pgoff_t start;
+	unsigned int size;
+	unsigned int async_size;
+	unsigned int ra_pages;
+	unsigned int mmap_miss;
+	loff_t prev_pos;
 };
 
 /*


