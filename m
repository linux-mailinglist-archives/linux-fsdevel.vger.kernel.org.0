Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0873AF7EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhFUVtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 17:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232180AbhFUVtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624312028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPGq6buGb7ejt5zPN/7ICG1K/mOBpwuloXcDHzUu2+U=;
        b=Tjb2xqciMs2xbndR7eZdwNXvAw4F2fVCAB7KQS54Ogu1mfbQfpIzaa4ATGbd6yfRuSfBs1
        EAlJF+rFwVgQPLHmukO1S2yG1CyJarb7FLxmoCPuCa+zdo6TkYo3CcE2dHKa2bicOovH/q
        7UIS7nIPJ3Qa/tVL+/hNGfolpoD7FjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-1JTlQtHNMW6iY_oE3SQIiQ-1; Mon, 21 Jun 2021 17:47:07 -0400
X-MC-Unique: 1JTlQtHNMW6iY_oE3SQIiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE954800C78;
        Mon, 21 Jun 2021 21:47:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4752019D7C;
        Mon, 21 Jun 2021 21:46:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/12] fscache: Fix cookie key hashing
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Jun 2021 22:46:58 +0100
Message-ID: <162431201844.2908479.8293647220901514696.stgit@warthog.procyon.org.uk>
In-Reply-To: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
References: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current hash algorithm used for hashing cookie keys is really bad,
producing almost no dispersion (after a test kernel build, ~30000 files
were split over just 18 out of the 32768 hash buckets).

Borrow the full_name_hash() hash function into fscache to do the hashing
for cookie keys and, in the future, volume keys.

I don't want to use full_name_hash() as-is because I want the hash value to
be consistent across arches and over time as the hash value produced may
get used on disk.

I can also optimise parts of it away as the key will always be a padded
array of aligned 32-bit words.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c   |   14 +-------------
 fs/fscache/internal.h |    2 ++
 fs/fscache/main.c     |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index ec9bce33085f..2558814193e9 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -87,10 +87,8 @@ void fscache_free_cookie(struct fscache_cookie *cookie)
 static int fscache_set_key(struct fscache_cookie *cookie,
 			   const void *index_key, size_t index_key_len)
 {
-	unsigned long long h;
 	u32 *buf;
 	int bufs;
-	int i;
 
 	bufs = DIV_ROUND_UP(index_key_len, sizeof(*buf));
 
@@ -104,17 +102,7 @@ static int fscache_set_key(struct fscache_cookie *cookie,
 	}
 
 	memcpy(buf, index_key, index_key_len);
-
-	/* Calculate a hash and combine this with the length in the first word
-	 * or first half word
-	 */
-	h = (unsigned long)cookie->parent;
-	h += index_key_len + cookie->type;
-
-	for (i = 0; i < bufs; i++)
-		h += buf[i];
-
-	cookie->key_hash = h ^ (h >> 32);
+	cookie->key_hash = fscache_hash(0, buf, bufs);
 	return 0;
 }
 
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 200082cafdda..a49136c63e4b 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -74,6 +74,8 @@ extern struct workqueue_struct *fscache_object_wq;
 extern struct workqueue_struct *fscache_op_wq;
 DECLARE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
 
+extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n);
+
 static inline bool fscache_object_congested(void)
 {
 	return workqueue_congested(WORK_CPU_UNBOUND, fscache_object_wq);
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index c1e6cc9091aa..4207f98e405f 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -93,6 +93,45 @@ static struct ctl_table fscache_sysctls_root[] = {
 };
 #endif
 
+/*
+ * Mixing scores (in bits) for (7,20):
+ * Input delta: 1-bit      2-bit
+ * 1 round:     330.3     9201.6
+ * 2 rounds:   1246.4    25475.4
+ * 3 rounds:   1907.1    31295.1
+ * 4 rounds:   2042.3    31718.6
+ * Perfect:    2048      31744
+ *            (32*64)   (32*31/2 * 64)
+ */
+#define HASH_MIX(x, y, a)	\
+	(	x ^= (a),	\
+	y ^= x,	x = rol32(x, 7),\
+	x += y,	y = rol32(y,20),\
+	y *= 9			)
+
+static inline unsigned int fold_hash(unsigned long x, unsigned long y)
+{
+	/* Use arch-optimized multiply if one exists */
+	return __hash_32(y ^ __hash_32(x));
+}
+
+/*
+ * Generate a hash.  This is derived from full_name_hash(), but we want to be
+ * sure it is arch independent and that it doesn't change as bits of the
+ * computed hash value might appear on disk.  The caller also guarantees that
+ * the hashed data will be a series of aligned 32-bit words.
+ */
+unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n)
+{
+	unsigned int a, x = 0, y = salt;
+
+	for (; n; n--) {
+		a = *data++;
+		HASH_MIX(x, y, a);
+	}
+	return fold_hash(x, y);
+}
+
 /*
  * initialise the fs caching module
  */


