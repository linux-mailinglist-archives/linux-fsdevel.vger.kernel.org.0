Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02125AFD1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgIBPpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728474AbgIBPpS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599061507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kp3dpQdctOfjShp2Jh9eA0jkHjcP1v7EI9LyqzTLfMc=;
        b=QHQhv3Z2RkWlMlnvtFfEux0Ok/zFGoKtSZZalaYtrxCj6i1OM1JR674KKPZU5wW7SA8DLp
        wXRf5+ca3qt39oGVU+UrMUqYOqVjpz3Bnc/np36lYRXbTys1KwAvy4bG5JA3J5BJN/VyEO
        K0BB+fvUnpvS9RvHDLJ5diL8+k2zczY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-n6zxdSpLNKSl960WC9bibQ-1; Wed, 02 Sep 2020 11:45:03 -0400
X-MC-Unique: n6zxdSpLNKSl960WC9bibQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E1FA1DE02;
        Wed,  2 Sep 2020 15:45:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3332B1002D73;
        Wed,  2 Sep 2020 15:45:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 6/6] mm: Pass a file_ra_state struct into
 force_page_cache_readahead() [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Sep 2020 16:45:00 +0100
Message-ID: <159906150036.663183.11566577279669811013.stgit@warthog.procyon.org.uk>
In-Reply-To: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
References: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass a file_ra_state struct into force_page_cache_readahead().  One caller
has one that should be passed in and the other doesn't, but the former
needs to pass its in.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/fadvise.c   |    3 ++-
 mm/internal.h  |    3 ++-
 mm/readahead.c |    5 ++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index 997f7c16690a..e1b09975caaa 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -106,7 +106,8 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 
 		{
 			DEFINE_READAHEAD(rac, file, mapping, start_index);
-			force_page_cache_readahead(&rac, nrpages);
+			force_page_cache_readahead(&rac, &rac.file->f_ra,
+						   nrpages);
 		}
 		break;
 	case POSIX_FADV_NOREUSE:
diff --git a/mm/internal.h b/mm/internal.h
index d62df5559500..ff7b549f6a9d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,7 +49,8 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-void force_page_cache_readahead(struct readahead_control *, unsigned long);
+void force_page_cache_readahead(struct readahead_control *, struct file_ra_state *,
+				unsigned long);
 void __do_page_cache_readahead(struct readahead_control *,
 		unsigned long nr_to_read, unsigned long lookahead_size);
 
diff --git a/mm/readahead.c b/mm/readahead.c
index d8e3e59e4c46..3f3ce65afc64 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -272,11 +272,10 @@ void __do_page_cache_readahead(struct readahead_control *rac,
  * memory at once.
  */
 void force_page_cache_readahead(struct readahead_control *rac,
-		unsigned long nr_to_read)
+		struct file_ra_state *ra, unsigned long nr_to_read)
 {
 	struct address_space *mapping = rac->mapping;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	struct file_ra_state *ra = &rac->file->f_ra;
 	unsigned long max_pages, index;
 
 	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages &&
@@ -655,7 +654,7 @@ void page_cache_sync_readahead(struct readahead_control *rac,
 
 	/* be dumb */
 	if (rac->file && (rac->file->f_mode & FMODE_RANDOM)) {
-		force_page_cache_readahead(rac, req_count);
+		force_page_cache_readahead(rac, ra, req_count);
 		return;
 	}
 


