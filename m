Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE7544550
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiFIIHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 04:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiFIIHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D66EE0E8
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654762028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5p3HkdYZl79byUiBWy+T3SbLU5ysf1MJCDMDD4vnnFU=;
        b=bXRApliqKWACQDqcEEoP60KVkRVnOURkwzmcO/4qpPfspo9neeCilG8EcfRjUcoGF/+gnR
        rPhjKEwDTFp7eGJvcufEncxr3TIAsQ6gxXiiF3uaCV0XOVQVdqILuVnnjazP/svTeI7kmq
        h73DbAvPBUmqAnr71Kb5QuOmHDzoXGA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-xQzNKroLMPilsuVMymIF-w-1; Thu, 09 Jun 2022 04:07:04 -0400
X-MC-Unique: xQzNKroLMPilsuVMymIF-w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05752101E985;
        Thu,  9 Jun 2022 08:07:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A1864619F3;
        Thu,  9 Jun 2022 08:07:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] iov_iter: Fix iter_xarray_get_pages{,_alloc}()
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 09 Jun 2022 09:07:01 +0100
Message-ID: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The maths at the end of iter_xarray_get_pages() to calculate the actual
size doesn't work under some circumstances, such as when it's been asked to
extract a partial single page.  Various terms of the equation cancel out
and you end up with actual == offset.  The same issue exists in
iter_xarray_get_pages_alloc().

Fix these to just use min() to select the lesser amount from between the
amount of page content transcribed into the buffer, minus the offset, and
the size limit specified.

This doesn't appear to have caused a problem yet upstream because network
filesystems aren't getting the pages from an xarray iterator, but rather
passing it directly to the socket, which just iterates over it.  Cachefiles
*does* do DIO from one to/from ext4/xfs/btrfs/etc. but it always asks for
whole pages to be written or read.

Fixes: 7ff5062079ef ("iov_iter: Add ITER_XARRAY")
Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Mike Marshall <hubcap@omnibond.com>
cc: Gao Xiang <xiang@kernel.org>
cc: linux-afs@lists.infradead.org
cc: v9fs-developer@lists.sourceforge.net
cc: devel@lists.orangefs.org
cc: linux-erofs@lists.ozlabs.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---

 lib/iov_iter.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 834e1e268eb6..814f65fd0c42 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1434,7 +1434,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 {
 	unsigned nr, offset;
 	pgoff_t index, count;
-	size_t size = maxsize, actual;
+	size_t size = maxsize;
 	loff_t pos;
 
 	if (!size || !maxpages)
@@ -1461,13 +1461,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	if (nr == 0)
 		return 0;
 
-	actual = PAGE_SIZE * nr;
-	actual -= offset;
-	if (nr == count && size > 0) {
-		unsigned last_offset = (nr > 1) ? 0 : offset;
-		actual -= PAGE_SIZE - (last_offset + size);
-	}
-	return actual;
+	return min(nr * PAGE_SIZE - offset, maxsize);
 }
 
 /* must be done on non-empty ITER_IOVEC one */
@@ -1602,7 +1596,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	struct page **p;
 	unsigned nr, offset;
 	pgoff_t index, count;
-	size_t size = maxsize, actual;
+	size_t size = maxsize;
 	loff_t pos;
 
 	if (!size)
@@ -1631,13 +1625,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	if (nr == 0)
 		return 0;
 
-	actual = PAGE_SIZE * nr;
-	actual -= offset;
-	if (nr == count && size > 0) {
-		unsigned last_offset = (nr > 1) ? 0 : offset;
-		actual -= PAGE_SIZE - (last_offset + size);
-	}
-	return actual;
+	return min(nr * PAGE_SIZE - offset, maxsize);
 }
 
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,


