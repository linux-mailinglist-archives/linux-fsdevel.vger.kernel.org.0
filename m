Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BC0461866
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378120AbhK2ObP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:31:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378030AbhK2O1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638195872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TG0Gbz9D3GUj9CweVWt4l/eSg/X6S3kcbhSt+YltHHQ=;
        b=DsEHKruVmb4CfH5gUauH37//GbqZltxLG6yfMKtJJI/MoAU6wH+9WCAgz/HurRwS0KwAHu
        mNGZXSelcYRxSxtcwswD95sksq6ywpISkGHNA+Gg3fPg1EfclJ0rTVCUc/aT6Zsb/BsqS9
        jC2jVLvoT6cPAC+yu7WjHK8lni9JKQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-6ieQjub7O_W0iDexGieO5Q-1; Mon, 29 Nov 2021 09:24:28 -0500
X-MC-Unique: 6ieQjub7O_W0iDexGieO5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 578E281CD03;
        Mon, 29 Nov 2021 14:24:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11B016060F;
        Mon, 29 Nov 2021 14:24:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/64] fscache: Implement a hash function
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:24:21 +0000
Message-ID: <163819586113.215744.1699465806130102367.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a function to generate hashes.  It needs to be stable over time
and endianness-independent as the hashes will appear on disk in future
patches.  It can assume that its input is a multiple of four bytes in size
and alignment.

This is borrowed from the VFS and simplified.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/internal.h |    2 ++
 fs/fscache/main.c     |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index ea52f8594a77..64767992bd15 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -22,6 +22,8 @@
  */
 extern unsigned fscache_debug;
 
+extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n);
+
 /*
  * proc.c
  */
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index 819de2ee1276..a4afba1b9d3b 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -24,6 +24,45 @@ MODULE_PARM_DESC(fscache_debug,
 struct workqueue_struct *fscache_wq;
 EXPORT_SYMBOL(fscache_wq);
 
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


