Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7D621DC8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgGMQdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:33:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60611 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730577AbgGMQdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594657986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jQyN5nMptUdr+FXFnO+0cz+AZazAi5FEXN8n0OwGMPM=;
        b=FqFYIQCYE3wPVIwLVJek3Y/3zdwK1O3+2dl9N5JctErzDEznmbhagsabEo6CBAhq2XKHuU
        q+G09+eR/0mRGPc1eR/Oc5qQZTDTb8OHGcQJHc+U1SotMZDl16ya58VbcY4Tb2E7WVdFQH
        IfLfeH2EcLdQ0cFwCTT8f8vQ0LaeSF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-6akDkgNxPv2r1vJGIyslDQ-1; Mon, 13 Jul 2020 12:33:03 -0400
X-MC-Unique: 6akDkgNxPv2r1vJGIyslDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A6FB100A8C0;
        Mon, 13 Jul 2020 16:33:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B34915D9CC;
        Mon, 13 Jul 2020 16:32:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/32] fscache, cachefiles: Fix disabled histogram warnings
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:32:54 +0100
Message-ID: <159465797497.1376674.14328755555295693847.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix variable unused warnings due to disabled histogram stuff.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/internal.h |    7 +++++--
 fs/fscache/internal.h    |    6 ++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b89f76a03546..16d15291a629 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -143,11 +143,11 @@ extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
 /*
  * proc.c
  */
-#ifdef CONFIG_CACHEFILES_HISTOGRAM
 extern atomic_t cachefiles_lookup_histogram[HZ];
 extern atomic_t cachefiles_mkdir_histogram[HZ];
 extern atomic_t cachefiles_create_histogram[HZ];
 
+#ifdef CONFIG_CACHEFILES_HISTOGRAM
 extern int __init cachefiles_proc_init(void);
 extern void cachefiles_proc_cleanup(void);
 static inline
@@ -162,7 +162,10 @@ void cachefiles_hist(atomic_t histogram[], unsigned long start_jif)
 #else
 #define cachefiles_proc_init()		(0)
 #define cachefiles_proc_cleanup()	do {} while (0)
-#define cachefiles_hist(hist, start_jif) do {} while (0)
+static inline
+void cachefiles_hist(atomic_t histogram[], unsigned long start_jif)
+{
+}
 #endif
 
 /*
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 443671310e31..a70c1a612309 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -95,13 +95,13 @@ extern struct fscache_cookie fscache_fsdef_index;
 /*
  * histogram.c
  */
-#ifdef CONFIG_FSCACHE_HISTOGRAM
 extern atomic_t fscache_obj_instantiate_histogram[HZ];
 extern atomic_t fscache_objs_histogram[HZ];
 extern atomic_t fscache_ops_histogram[HZ];
 extern atomic_t fscache_retrieval_delay_histogram[HZ];
 extern atomic_t fscache_retrieval_histogram[HZ];
 
+#ifdef CONFIG_FSCACHE_HISTOGRAM
 static inline void fscache_hist(atomic_t histogram[], unsigned long start_jif)
 {
 	unsigned long jif = jiffies - start_jif;
@@ -113,7 +113,9 @@ static inline void fscache_hist(atomic_t histogram[], unsigned long start_jif)
 extern const struct seq_operations fscache_histogram_ops;
 
 #else
-#define fscache_hist(hist, start_jif) do {} while (0)
+static inline void fscache_hist(atomic_t histogram[], unsigned long start_jif)
+{
+}
 #endif
 
 /*


