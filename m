Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A029DFCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 02:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgJ1WMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730697AbgJ1WLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUuHqBu02RDH7y/ePmq8mZIPwAVRS5g/Og4KHeFUFfk=;
        b=ZawpRARj6FXCYE9M7F8rWkaZtI0FTCDigWm3bFFrRaPlwUb8DrT9SGtJ7/yd2fxsSz4p2b
        ey51TyrO1TtGrN7NhqZr5FBxiGy1ybxSyhByn4lZT3dL62GRxA+srW2yHSP8Ma7gWR7Vfu
        UvB0rv+RcDU3B7Yu0qe1TFpFkHPn9r8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-VdivdnJDPRycjhOiUNr6cw-1; Wed, 28 Oct 2020 10:10:35 -0400
X-MC-Unique: VdivdnJDPRycjhOiUNr6cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA37F101962B;
        Wed, 28 Oct 2020 14:10:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6204100238E;
        Wed, 28 Oct 2020 14:10:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/11] afs: Fix page leak on afs_write_begin() failure
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Nick Piggin <npiggin@gmail.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 14:10:31 +0000
Message-ID: <160389423194.300137.6010089051775505793.stgit@warthog.procyon.org.uk>
In-Reply-To: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
References: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the leak of the target page in afs_write_begin() when it fails.

Fixes: 15b4650e55e0 ("afs: convert to new aops")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Nick Piggin <npiggin@gmail.com>
---

 fs/afs/write.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 29685947324e..16a896096ccf 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -76,7 +76,7 @@ static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
  */
 int afs_write_begin(struct file *file, struct address_space *mapping,
 		    loff_t pos, unsigned len, unsigned flags,
-		    struct page **pagep, void **fsdata)
+		    struct page **_page, void **fsdata)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	struct page *page;
@@ -110,9 +110,6 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 		SetPageUptodate(page);
 	}
 
-	/* page won't leak in error case: it eventually gets cleaned off LRU */
-	*pagep = page;
-
 try_again:
 	/* See if this page is already partially written in a way that we can
 	 * merge the new write with.
@@ -154,6 +151,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	if (!TestSetPagePrivate(page))
 		get_page(page);
 	set_page_private(page, priv);
+	*_page = page;
 	_leave(" = 0");
 	return 0;
 
@@ -163,17 +161,18 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 flush_conflicting_write:
 	_debug("flush conflict");
 	ret = write_one_page(page);
-	if (ret < 0) {
-		_leave(" = %d", ret);
-		return ret;
-	}
+	if (ret < 0)
+		goto error;
 
 	ret = lock_page_killable(page);
-	if (ret < 0) {
-		_leave(" = %d", ret);
-		return ret;
-	}
+	if (ret < 0)
+		goto error;
 	goto try_again;
+
+error:
+	put_page(page);
+	_leave(" = %d", ret);
+	return ret;
 }
 
 /*


