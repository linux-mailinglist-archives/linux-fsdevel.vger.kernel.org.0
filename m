Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF23C2BAE32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgKTPOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:14:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729208AbgKTPN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uomWbsImiumFICDtRpb1G8QZPYUTXnwJ7BaEhbKeStk=;
        b=M3hZ9tFr6aBRStxxUYnf1m6ZZd1M5DlrMN2Z2/eTa1DfFcvVnmziLx03XcMD5Vbgi4Nt1W
        Sdv9YjJ4b0m83hT9OwgK9OS5vxV3hE4uV7amoh865aSrxg7gZxWS1HtIJvpiNgYVWSrKqQ
        CMntdGQjZNQijysnkWeVgUWTh9Mw4M4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-vWdiV8ipNHmYaGCZrhouZg-1; Fri, 20 Nov 2020 10:13:52 -0500
X-MC-Unique: vWdiV8ipNHmYaGCZrhouZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 538EC1005D65;
        Fri, 20 Nov 2020 15:13:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 271235C1D5;
        Fri, 20 Nov 2020 15:13:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 52/76] fscache: disable cookie when doing an invalidation
 for DIO write
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:13:43 +0000
Message-ID: <160588522336.3465195.4306404507840267540.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

O_DIRECT I/O is probably a good indicator that we don't need to be
caching this file at the moment. Disable the cookie by treating it
as we would a NULL cookie after the invalidation completes. Reenable
when the last unuse is done.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c     |    9 ++++++++-
 include/linux/fscache.h |    9 ++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 1b30b28f7cf6..d20028535a86 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -427,8 +427,11 @@ void __fscache_unuse_cookie(struct fscache_cookie *cookie,
 {
 	if (aux_data || object_size)
 		__fscache_update_cookie(cookie, aux_data, object_size);
-	if (atomic_dec_and_test(&cookie->n_active))
+	if (atomic_dec_and_test(&cookie->n_active)) {
+		clear_bit(FSCACHE_COOKIE_DISABLED, &cookie->flags);
+		smp_mb__after_atomic();
 		wake_up_var(&cookie->n_active);
+	}
 }
 EXPORT_SYMBOL(__fscache_unuse_cookie);
 
@@ -554,6 +557,10 @@ void __fscache_invalidate(struct fscache_cookie *cookie,
 	 */
 	ASSERTCMP(cookie->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
 
+	if ((flags & FSCACHE_INVAL_DIO_WRITE) &&
+	    test_and_set_bit(FSCACHE_COOKIE_DISABLED, &cookie->flags))
+		return;
+
 	spin_lock(&cookie->lock);
 	fscache_update_aux(cookie, aux_data, &new_size);
 	cookie->zero_point = new_size;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 1d141d17f63b..3c173fb660a6 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -26,11 +26,13 @@
 #define fscache_available() (1)
 #define fscache_cookie_valid(cookie) (cookie)
 #define fscache_object_valid(object) (object)
+#define fscache_cookie_enabled(cookie) (cookie && !test_bit(FSCACHE_COOKIE_DISABLED, &cookie->flags))
 #else
 #define __fscache_available (0)
 #define fscache_available() (0)
 #define fscache_cookie_valid(cookie) (0)
 #define fscache_object_valid(object) (NULL)
+#define fscache_cookie_enabled(cookie) (0)
 #endif
 
 
@@ -127,6 +129,7 @@ struct fscache_cookie {
 
 	unsigned long			flags;
 #define FSCACHE_COOKIE_RELINQUISHED	6		/* T if cookie has been relinquished */
+#define FSCACHE_COOKIE_DISABLED		7		/* T if cookie has been disabled */
 
 	enum fscache_cookie_stage	stage;
 	enum fscache_cookie_type	type:8;
@@ -410,7 +413,7 @@ static inline
 void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
 			   const loff_t *object_size)
 {
-	if (fscache_cookie_valid(cookie))
+	if (fscache_cookie_enabled(cookie))
 		__fscache_update_cookie(cookie, aux_data, object_size);
 }
 
@@ -468,7 +471,7 @@ static inline
 void fscache_invalidate(struct fscache_cookie *cookie,
 			const void *aux_data, loff_t size, unsigned int flags)
 {
-	if (fscache_cookie_valid(cookie))
+	if (fscache_cookie_enabled(cookie))
 		__fscache_invalidate(cookie, aux_data, size, flags);
 }
 
@@ -492,7 +495,7 @@ int fscache_begin_operation(struct fscache_cookie *cookie,
 			    struct fscache_op_resources *opr,
 			    enum fscache_want_stage want_stage)
 {
-	if (fscache_cookie_valid(cookie))
+	if (fscache_cookie_enabled(cookie))
 		return __fscache_begin_operation(cookie, opr, want_stage);
 	return -ENOBUFS;
 }


