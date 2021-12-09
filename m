Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F3E46EF87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbhLIREj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241945AbhLIREc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qaXxd1EgdMkTE8kWlecXERp9Pyu6roSWgl/tfZOOqAg=;
        b=XV+Hy8pqRAtwn29yAQ5fOJFvIfvxVyot+1Rq7pgReJxX5hz6khYMLz1YtaSl66GXa6YL6S
        SF6kg4ICv/ICbrykoZNQxLN4XlHvYYKKG0FXnCl1tZXrvsj5gesIRncuDe/0HBemHBDYOV
        lt9u8ru71fHGXs/LzjuIVf+af4Dj/KQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-qXw8UCVuN7up7xlU_cf1YA-1; Thu, 09 Dec 2021 12:00:54 -0500
X-MC-Unique: qXw8UCVuN7up7xlU_cf1YA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32FB519253FD;
        Thu,  9 Dec 2021 17:00:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C66D845D72;
        Thu,  9 Dec 2021 17:00:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 31/67] cachefiles: Define structs
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Dec 2021 17:00:42 +0000
Message-ID: <163906924292.143852.15881439716653984905.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define the cachefiles_cache struct that's going to carry the cache-level
parameters and state of a cache.

Define the beginning of the cachefiles_object struct that's going to carry
the state for a data storage object.  For the moment this is just a
debugging ID for logging purposes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819623690.215744.2824739137193655547.stgit@warthog.procyon.org.uk/ # v1
---

 fs/cachefiles/internal.h |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 26e0e23d7702..cff4b2a5f928 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -16,6 +16,52 @@
 #include <linux/cred.h>
 #include <linux/security.h>
 
+struct cachefiles_cache;
+struct cachefiles_object;
+
+/*
+ * Data file records.
+ */
+struct cachefiles_object {
+	int				debug_id;	/* debugging ID */
+};
+
+/*
+ * Cache files cache definition
+ */
+struct cachefiles_cache {
+	struct vfsmount			*mnt;		/* mountpoint holding the cache */
+	struct file			*cachefilesd;	/* manager daemon handle */
+	const struct cred		*cache_cred;	/* security override for accessing cache */
+	struct mutex			daemon_mutex;	/* command serialisation mutex */
+	wait_queue_head_t		daemon_pollwq;	/* poll waitqueue for daemon */
+	atomic_t			gravecounter;	/* graveyard uniquifier */
+	atomic_t			f_released;	/* number of objects released lately */
+	atomic_long_t			b_released;	/* number of blocks released lately */
+	unsigned			frun_percent;	/* when to stop culling (% files) */
+	unsigned			fcull_percent;	/* when to start culling (% files) */
+	unsigned			fstop_percent;	/* when to stop allocating (% files) */
+	unsigned			brun_percent;	/* when to stop culling (% blocks) */
+	unsigned			bcull_percent;	/* when to start culling (% blocks) */
+	unsigned			bstop_percent;	/* when to stop allocating (% blocks) */
+	unsigned			bsize;		/* cache's block size */
+	unsigned			bshift;		/* min(ilog2(PAGE_SIZE / bsize), 0) */
+	uint64_t			frun;		/* when to stop culling */
+	uint64_t			fcull;		/* when to start culling */
+	uint64_t			fstop;		/* when to stop allocating */
+	sector_t			brun;		/* when to stop culling */
+	sector_t			bcull;		/* when to start culling */
+	sector_t			bstop;		/* when to stop allocating */
+	unsigned long			flags;
+#define CACHEFILES_READY		0	/* T if cache prepared */
+#define CACHEFILES_DEAD			1	/* T if cache dead */
+#define CACHEFILES_CULLING		2	/* T if cull engaged */
+#define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
+	char				*rootdirname;	/* name of cache root directory */
+	char				*secctx;	/* LSM security context */
+	char				*tag;		/* cache binding tag */
+};
+
 
 /*
  * Debug tracing.


