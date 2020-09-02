Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873B125AFBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgIBPpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:45:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24228 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728400AbgIBPpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599061500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3IPCFyIVPVmMXkQUqgqDzASUCFftpliFw52FResyTI=;
        b=LenUYkUYDURFLWKqZ1gyGDsChcjJO4Kge351C27D3jNX5JtZ2eLi5bO2H/OnlN7ofEBZtp
        mk2h1zGv7yP8npWjSpgy39gH4xFG3G9NlMb5OJMT3/j5mTJdaLLCBghGTIyW/EYgLPmhPE
        enohdsmrbgJeFDhh+953UX/P4i50Mp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-bP1wLkRtPECuZMNwkvjG6g-1; Wed, 02 Sep 2020 11:44:56 -0400
X-MC-Unique: bP1wLkRtPECuZMNwkvjG6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F81418C5202;
        Wed,  2 Sep 2020 15:44:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 209F05C1C4;
        Wed,  2 Sep 2020 15:44:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 5/6] mm: Fold ra_submit() into do_sync_mmap_readahead()
 [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Sep 2020 16:44:53 +0100
Message-ID: <159906149326.663183.12774034343203621496.stgit@warthog.procyon.org.uk>
In-Reply-To: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
References: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fold ra_submit() into its last remaining user and pass the previously added
readahead_control struct down into __do_page_cache_readahead().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/filemap.c  |    6 +++---
 mm/internal.h |   10 ----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index fdfeedd1eb71..eaa046fdc0b6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2500,10 +2500,10 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	 * mmap read-around
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	ra->start = max_t(long, 0, offset - ra->ra_pages / 2);
-	ra->size = ra->ra_pages;
+	ra->start = rac._index = max_t(long, 0, offset - ra->ra_pages / 2);
+	ra->size  = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
-	ra_submit(ra, mapping, file);
+	__do_page_cache_readahead(&rac, ra->size, ra->async_size);
 	return fpin;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index c8ccf208f524..d62df5559500 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -53,16 +53,6 @@ void force_page_cache_readahead(struct readahead_control *, unsigned long);
 void __do_page_cache_readahead(struct readahead_control *,
 		unsigned long nr_to_read, unsigned long lookahead_size);
 
-/*
- * Submit IO for the read-ahead request in file_ra_state.
- */
-static inline void ra_submit(struct file_ra_state *ra,
-		struct address_space *mapping, struct file *file)
-{
-	DEFINE_READAHEAD(rac, file, mapping, ra->start);
-	__do_page_cache_readahead(&rac, ra->size, ra->async_size);
-}
-
 /**
  * page_evictable - test whether a page is evictable
  * @page: the page to test


