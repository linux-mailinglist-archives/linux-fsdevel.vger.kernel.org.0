Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C794D259D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 02:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiCIBDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 20:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiCIBDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA7251323F2
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 16:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646786440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QWldaxUgjSqrqhHqZ9kQzTo6lY37kzhgmv3hw+9M2s=;
        b=KdOx4/o+uKGCmFZPmQsHpWVslrl5h0+yW5IW/qL8EKgd1xVAVye1+xNgVQ7lwOzq3yxBq2
        UY0hsMXKqmlC9qpCqwhR9k7udaGXG/XfbrMuO1w6sm2CXMt6Ph/P4Ka6Nt3U05Y9jZvUyn
        JjYQ4864uGWOprVpNg+1JMDAnC5dDqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-XvRYsVbpM0uP4zx8B0iw_g-1; Tue, 08 Mar 2022 18:29:17 -0500
X-MC-Unique: XvRYsVbpM0uP4zx8B0iw_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5C241006AA6;
        Tue,  8 Mar 2022 23:29:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA4B34CEFB;
        Tue,  8 Mar 2022 23:29:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 14/19] netfs: Prepare to split read_helper.c
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
Date:   Tue, 08 Mar 2022 23:29:12 +0000
Message-ID: <164678215208.1200972.9761906209395002182.stgit@warthog.procyon.org.uk>
In-Reply-To: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename netfs_rreq_unlock() to netfs_rreq_unlock_folios() to make it sound
less like it's dropping a lock on an netfs_io_request struct.

Remove the 'static' marker on netfs_rreq_unlock_folios() and declaring it
in internal.h preparatory to splitting the file.

Changes
=======
ver #2)
 - Slide this patch to after the one adding netfs_begin_read().
 - As a consequence, don't need to unstatic so many functions.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com

Link: https://lore.kernel.org/r/164623002861.3564931.17340149482236413375.stgit@warthog.procyon.org.uk/ # v1
---

 fs/netfs/internal.h    |    5 +++++
 fs/netfs/read_helper.c |    4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 937c2465943f..11c0c9ef9299 100644
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
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 19d4fe0b4987..058a534ba917 100644
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
@@ -432,7 +432,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 		return;
 	}
 
-	netfs_rreq_unlock(rreq);
+	netfs_rreq_unlock_folios(rreq);
 
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);


