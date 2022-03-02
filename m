Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0897B4CA762
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 15:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbiCBOIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 09:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242672AbiCBOIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:08:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2613EB82C2
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 06:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646230043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=miEpNHiiYOQkk53mPmiDF12f5M7bEYXiNF+tJ/BMrwc=;
        b=ezkgDNIOEBSpabUzwUlG4l2eJ7ljQz19mirKOkKrKmNugHBWUGZcnWGjgSjOEIKjEBub8Z
        k5gjf8RkBZqwxUEMAudEjd4EK+YJfgnww9+XblL1KACI+FRnQAGQYHK0/uBcLTkz+K+Mds
        yxNcwKYkPekCWqQKtLkuajsNwNdgsO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-Ad4CkeJVOz23sZLda2kSMA-1; Wed, 02 Mar 2022 09:07:20 -0500
X-MC-Unique: Ad4CkeJVOz23sZLda2kSMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5089719253C0;
        Wed,  2 Mar 2022 14:07:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FC3E76C32;
        Wed,  2 Mar 2022 14:07:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/19] netfs: Prepare to split read_helper.c
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Mar 2022 14:07:08 +0000
Message-ID: <164623002861.3564931.17340149482236413375.stgit@warthog.procyon.org.uk>
In-Reply-To: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
References: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prepare to split read_helper.c by removing some 'static' markers and
declaring those functions in internal.h.

Rename netfs_rreq_unlock() to netfs_rreq_unlock_folios() to make it sound
less like it's dropping a lock on an netfs_io_request struct.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/netfs/internal.h    |    8 ++++++++
 fs/netfs/read_helper.c |   10 +++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index ee2f64cde221..3970528955be 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -15,6 +15,11 @@
 
 #define pr_fmt(fmt) "netfs: " fmt
 
+/*
+ * buffered_read.c
+ */
+void netfs_rreq_unlock_folios(struct netfs_io_request *rreq);
+
 /*
  * objects.c
  */
@@ -40,6 +45,9 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
 extern unsigned int netfs_debug;
 
 void netfs_rreq_work(struct work_struct *work);
+void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async);
+bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
+			     unsigned int *_debug_index);
 
 /*
  * stats.c
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index c953a573b6b6..e666f9cccc95 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -250,7 +250,7 @@ static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq)
  * Unlock the folios in a read operation.  We need to set PG_fscache on any
  * folios we're going to write back before we unlock them.
  */
-static void netfs_rreq_unlock(struct netfs_io_request *rreq)
+void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 {
 	struct netfs_io_subrequest *subreq;
 	struct folio *folio;
@@ -418,7 +418,7 @@ static void netfs_rreq_is_still_valid(struct netfs_io_request *rreq)
  * Note that we could be in an ordinary kernel thread, on a workqueue or in
  * softirq context at this point.  We inherit a ref from the caller.
  */
-static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
+void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
 
@@ -432,7 +432,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 		return;
 	}
 
-	netfs_rreq_unlock(rreq);
+	netfs_rreq_unlock_folios(rreq);
 
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
@@ -632,8 +632,8 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
 /*
  * Slice off a piece of a read request and submit an I/O request for it.
  */
-static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
-				    unsigned int *_debug_index)
+bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
+			     unsigned int *_debug_index)
 {
 	struct netfs_io_subrequest *subreq;
 	enum netfs_io_source source;


