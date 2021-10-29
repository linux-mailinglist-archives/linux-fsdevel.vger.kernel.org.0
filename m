Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1A843FE2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhJ2OO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 10:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231654AbhJ2OON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635516704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPrgjvpRBiT5WHFPbooc756Od7ZHmX3BG/EeReDfgUw=;
        b=EXUohUGIUo7aciNTX2RmeOJvV21E86qcuCgza32P9U+csKxWK1tg3vqS1ysEM59Ppz6by1
        fTo9SG90DA0jxqhgPrmbE0GVDlR/Qxg8asr7GT/jYa68B8xtbMp0ni9dzr9CEtV/dO/pum
        N0KhNxK/2dVVuKD/XB+oyJ1nB133WVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-b9kFuCXfPa2urfETmzQk3w-1; Fri, 29 Oct 2021 10:11:39 -0400
X-MC-Unique: b9kFuCXfPa2urfETmzQk3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5FA580DDE0;
        Fri, 29 Oct 2021 14:11:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D5CA604CC;
        Fri, 29 Oct 2021 14:11:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 09/10] fscache: Remove stats that are no longer used
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-cachefs@redhat.com, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Oct 2021 15:11:27 +0100
Message-ID: <163551668761.1877519.6594360917661719152.stgit@warthog.procyon.org.uk>
In-Reply-To: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
References: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove stats counters that are no longer used and remove their display from
/proc/fs/fscache/stats.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163162776915.438332.16744135153328311006.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/163189114616.2509237.9890995143218948138.stgit@warthog.procyon.org.uk/ # rfc v2
---

 fs/fscache/internal.h |   28 ----------------------
 fs/fscache/stats.c    |   63 +------------------------------------------------
 2 files changed, 1 insertion(+), 90 deletions(-)

diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 5281fa1894cd..6eb3f51d7275 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -151,15 +151,6 @@ extern atomic_t fscache_n_attr_changed_nobufs;
 extern atomic_t fscache_n_attr_changed_nomem;
 extern atomic_t fscache_n_attr_changed_calls;
 
-extern atomic_t fscache_n_allocs;
-extern atomic_t fscache_n_allocs_ok;
-extern atomic_t fscache_n_allocs_wait;
-extern atomic_t fscache_n_allocs_nobufs;
-extern atomic_t fscache_n_allocs_intr;
-extern atomic_t fscache_n_allocs_object_dead;
-extern atomic_t fscache_n_alloc_ops;
-extern atomic_t fscache_n_alloc_op_waits;
-
 extern atomic_t fscache_n_retrievals;
 extern atomic_t fscache_n_retrievals_ok;
 extern atomic_t fscache_n_retrievals_wait;
@@ -178,22 +169,9 @@ extern atomic_t fscache_n_stores_nobufs;
 extern atomic_t fscache_n_stores_intr;
 extern atomic_t fscache_n_stores_oom;
 extern atomic_t fscache_n_store_ops;
-extern atomic_t fscache_n_store_calls;
-extern atomic_t fscache_n_store_pages;
-extern atomic_t fscache_n_store_radix_deletes;
-extern atomic_t fscache_n_store_pages_over_limit;
 extern atomic_t fscache_n_stores_object_dead;
 extern atomic_t fscache_n_store_op_waits;
 
-extern atomic_t fscache_n_store_vmscan_not_storing;
-extern atomic_t fscache_n_store_vmscan_gone;
-extern atomic_t fscache_n_store_vmscan_busy;
-extern atomic_t fscache_n_store_vmscan_cancelled;
-extern atomic_t fscache_n_store_vmscan_wait;
-
-extern atomic_t fscache_n_marks;
-extern atomic_t fscache_n_uncaches;
-
 extern atomic_t fscache_n_acquires;
 extern atomic_t fscache_n_acquires_null;
 extern atomic_t fscache_n_acquires_no_cache;
@@ -242,12 +220,6 @@ extern atomic_t fscache_n_cop_drop_object;
 extern atomic_t fscache_n_cop_put_object;
 extern atomic_t fscache_n_cop_sync_cache;
 extern atomic_t fscache_n_cop_attr_changed;
-extern atomic_t fscache_n_cop_read_or_alloc_page;
-extern atomic_t fscache_n_cop_read_or_alloc_pages;
-extern atomic_t fscache_n_cop_allocate_page;
-extern atomic_t fscache_n_cop_allocate_pages;
-extern atomic_t fscache_n_cop_write_page;
-extern atomic_t fscache_n_cop_uncache_page;
 
 extern atomic_t fscache_n_cache_no_space_reject;
 extern atomic_t fscache_n_cache_stale_objects;
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 4cefce5bf4cd..2449aa459140 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -30,15 +30,6 @@ atomic_t fscache_n_attr_changed_nobufs;
 atomic_t fscache_n_attr_changed_nomem;
 atomic_t fscache_n_attr_changed_calls;
 
-atomic_t fscache_n_allocs;
-atomic_t fscache_n_allocs_ok;
-atomic_t fscache_n_allocs_wait;
-atomic_t fscache_n_allocs_nobufs;
-atomic_t fscache_n_allocs_intr;
-atomic_t fscache_n_allocs_object_dead;
-atomic_t fscache_n_alloc_ops;
-atomic_t fscache_n_alloc_op_waits;
-
 atomic_t fscache_n_retrievals;
 atomic_t fscache_n_retrievals_ok;
 atomic_t fscache_n_retrievals_wait;
@@ -57,22 +48,9 @@ atomic_t fscache_n_stores_nobufs;
 atomic_t fscache_n_stores_intr;
 atomic_t fscache_n_stores_oom;
 atomic_t fscache_n_store_ops;
-atomic_t fscache_n_store_calls;
-atomic_t fscache_n_store_pages;
-atomic_t fscache_n_store_radix_deletes;
-atomic_t fscache_n_store_pages_over_limit;
 atomic_t fscache_n_stores_object_dead;
 atomic_t fscache_n_store_op_waits;
 
-atomic_t fscache_n_store_vmscan_not_storing;
-atomic_t fscache_n_store_vmscan_gone;
-atomic_t fscache_n_store_vmscan_busy;
-atomic_t fscache_n_store_vmscan_cancelled;
-atomic_t fscache_n_store_vmscan_wait;
-
-atomic_t fscache_n_marks;
-atomic_t fscache_n_uncaches;
-
 atomic_t fscache_n_acquires;
 atomic_t fscache_n_acquires_null;
 atomic_t fscache_n_acquires_no_cache;
@@ -121,12 +99,6 @@ atomic_t fscache_n_cop_drop_object;
 atomic_t fscache_n_cop_put_object;
 atomic_t fscache_n_cop_sync_cache;
 atomic_t fscache_n_cop_attr_changed;
-atomic_t fscache_n_cop_read_or_alloc_page;
-atomic_t fscache_n_cop_read_or_alloc_pages;
-atomic_t fscache_n_cop_allocate_page;
-atomic_t fscache_n_cop_allocate_pages;
-atomic_t fscache_n_cop_write_page;
-atomic_t fscache_n_cop_uncache_page;
 
 atomic_t fscache_n_cache_no_space_reject;
 atomic_t fscache_n_cache_stale_objects;
@@ -156,10 +128,6 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_checkaux_update),
 		   atomic_read(&fscache_n_checkaux_obsolete));
 
-	seq_printf(m, "Pages  : mrk=%u unc=%u\n",
-		   atomic_read(&fscache_n_marks),
-		   atomic_read(&fscache_n_uncaches));
-
 	seq_printf(m, "Acquire: n=%u nul=%u noc=%u ok=%u nbf=%u"
 		   " oom=%u\n",
 		   atomic_read(&fscache_n_acquires),
@@ -198,17 +166,6 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_attr_changed_nomem),
 		   atomic_read(&fscache_n_attr_changed_calls));
 
-	seq_printf(m, "Allocs : n=%u ok=%u wt=%u nbf=%u int=%u\n",
-		   atomic_read(&fscache_n_allocs),
-		   atomic_read(&fscache_n_allocs_ok),
-		   atomic_read(&fscache_n_allocs_wait),
-		   atomic_read(&fscache_n_allocs_nobufs),
-		   atomic_read(&fscache_n_allocs_intr));
-	seq_printf(m, "Allocs : ops=%u owt=%u abt=%u\n",
-		   atomic_read(&fscache_n_alloc_ops),
-		   atomic_read(&fscache_n_alloc_op_waits),
-		   atomic_read(&fscache_n_allocs_object_dead));
-
 	seq_printf(m, "Retrvls: n=%u ok=%u wt=%u nod=%u nbf=%u"
 		   " int=%u oom=%u\n",
 		   atomic_read(&fscache_n_retrievals),
@@ -230,22 +187,11 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_stores_nobufs),
 		   atomic_read(&fscache_n_stores_intr),
 		   atomic_read(&fscache_n_stores_oom));
-	seq_printf(m, "Stores : ops=%u owt=%u run=%u pgs=%u rxd=%u olm=%u abt=%u\n",
+	seq_printf(m, "Stores : ops=%u owt=%u abt=%u\n",
 		   atomic_read(&fscache_n_store_ops),
 		   atomic_read(&fscache_n_store_op_waits),
-		   atomic_read(&fscache_n_store_calls),
-		   atomic_read(&fscache_n_store_pages),
-		   atomic_read(&fscache_n_store_radix_deletes),
-		   atomic_read(&fscache_n_store_pages_over_limit),
 		   atomic_read(&fscache_n_stores_object_dead));
 
-	seq_printf(m, "VmScan : nos=%u gon=%u bsy=%u can=%u wt=%u\n",
-		   atomic_read(&fscache_n_store_vmscan_not_storing),
-		   atomic_read(&fscache_n_store_vmscan_gone),
-		   atomic_read(&fscache_n_store_vmscan_busy),
-		   atomic_read(&fscache_n_store_vmscan_cancelled),
-		   atomic_read(&fscache_n_store_vmscan_wait));
-
 	seq_printf(m, "Ops    : pend=%u run=%u enq=%u can=%u rej=%u\n",
 		   atomic_read(&fscache_n_op_pend),
 		   atomic_read(&fscache_n_op_run),
@@ -270,13 +216,6 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_cop_put_object),
 		   atomic_read(&fscache_n_cop_attr_changed),
 		   atomic_read(&fscache_n_cop_sync_cache));
-	seq_printf(m, "CacheOp: rap=%d ras=%d alp=%d als=%d wrp=%d ucp=%d\n",
-		   atomic_read(&fscache_n_cop_read_or_alloc_page),
-		   atomic_read(&fscache_n_cop_read_or_alloc_pages),
-		   atomic_read(&fscache_n_cop_allocate_page),
-		   atomic_read(&fscache_n_cop_allocate_pages),
-		   atomic_read(&fscache_n_cop_write_page),
-		   atomic_read(&fscache_n_cop_uncache_page));
 	seq_printf(m, "CacheEv: nsp=%d stl=%d rtr=%d cul=%d\n",
 		   atomic_read(&fscache_n_cache_no_space_reject),
 		   atomic_read(&fscache_n_cache_stale_objects),


