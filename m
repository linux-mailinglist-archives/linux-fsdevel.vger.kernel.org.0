Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36CC3D102E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbhGUNHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238804AbhGUNGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626875251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cux4vK7FasEebT+e6GSkGlqilieGd9BwE6MltPwMMpQ=;
        b=UV9p6KN7KGytsysN3afLg3XAEde+e7dct5dtBowmoy5ecIPsAjM8sKflGP8eDq0XRuKgLk
        mEUGArDl0qdW5bGttBahVZp2fC/fJqMYQEtrUAhENopmxKAsoz3GgrC2+wOi3sbCDyc7+T
        KGsW6//rN9LVfqNRCbQXVVrfiUbC8TY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-Q8UWrdvhOY-FMC_HmRYBkg-1; Wed, 21 Jul 2021 09:47:26 -0400
X-MC-Unique: Q8UWrdvhOY-FMC_HmRYBkg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F80F107ACF5;
        Wed, 21 Jul 2021 13:47:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99F0C19C79;
        Wed, 21 Jul 2021 13:47:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 12/12] netfs: Export some read-request ref functions
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 14:47:15 +0100
Message-ID: <162687523532.276387.15449857111016442696.stgit@warthog.procyon.org.uk>
In-Reply-To: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export some functions for getting/putting read-request structures for use
in later patches.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/netfs/internal.h    |   10 ++++++++++
 fs/netfs/read_helper.c |   15 +++------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index a9ec6591f90a..6ae1eb55093a 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -78,9 +78,19 @@ static inline void netfs_see_write_request(struct netfs_write_request *wreq,
  */
 extern unsigned int netfs_debug;
 
+void __netfs_put_subrequest(struct netfs_read_subrequest *subreq, bool was_async);
+void netfs_put_read_request(struct netfs_read_request *rreq, bool was_async);
+void netfs_rreq_completed(struct netfs_read_request *rreq, bool was_async);
 int netfs_prefetch_for_write(struct file *file, struct page *page, loff_t pos, size_t len,
 			     bool always_fill);
 
+static inline void netfs_put_subrequest(struct netfs_read_subrequest *subreq,
+					bool was_async)
+{
+	if (refcount_dec_and_test(&subreq->usage))
+		__netfs_put_subrequest(subreq, was_async);
+}
+
 /*
  * write_helper.c
  */
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 0b771f2f5449..e5c636acc756 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -28,14 +28,6 @@ MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
 
 static void netfs_rreq_work(struct work_struct *);
 static void netfs_rreq_clear_buffer(struct netfs_read_request *);
-static void __netfs_put_subrequest(struct netfs_read_subrequest *, bool);
-
-static void netfs_put_subrequest(struct netfs_read_subrequest *subreq,
-				 bool was_async)
-{
-	if (refcount_dec_and_test(&subreq->usage))
-		__netfs_put_subrequest(subreq, was_async);
-}
 
 static struct netfs_read_request *netfs_alloc_read_request(struct address_space *mapping,
 							   struct file *file)
@@ -97,7 +89,7 @@ static void netfs_free_read_request(struct work_struct *work)
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
 
-static void netfs_put_read_request(struct netfs_read_request *rreq, bool was_async)
+void netfs_put_read_request(struct netfs_read_request *rreq, bool was_async)
 {
 	if (refcount_dec_and_test(&rreq->usage)) {
 		if (was_async) {
@@ -135,8 +127,7 @@ static void netfs_get_read_subrequest(struct netfs_read_subrequest *subreq)
 	refcount_inc(&subreq->usage);
 }
 
-static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
-				   bool was_async)
+void __netfs_put_subrequest(struct netfs_read_subrequest *subreq, bool was_async)
 {
 	struct netfs_read_request *rreq = subreq->rreq;
 
@@ -214,7 +205,7 @@ static void netfs_read_from_server(struct netfs_read_request *rreq,
 /*
  * Release those waiting.
  */
-static void netfs_rreq_completed(struct netfs_read_request *rreq, bool was_async)
+void netfs_rreq_completed(struct netfs_read_request *rreq, bool was_async)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 	netfs_rreq_clear_subreqs(rreq, was_async);


