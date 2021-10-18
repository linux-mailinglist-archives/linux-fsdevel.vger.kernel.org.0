Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E634321E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhJRPIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233937AbhJRPIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=veiaXltL6VCtrjdWipdEmPq2N2GsVmVphqdEUrpeTnQ=;
        b=WyVZ/QZt1gvi/RMv1BLtz97ZsJnUtbLXXtbgO5cLbrvqCA9AzA7DgU2QDHZ6nlbFKN7vYo
        dTVCM2kNm6XgcgT1Ea8kJ5lLygeTTEs4jOPYcrOzf70GwlzfFFl6AvqHCWF5MIbiC4rBKW
        pXUdKrl4yogr7U2/g3PMb1z6Q59v6Dw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-Ey0meNAIMT-wBxUNPFUEoA-1; Mon, 18 Oct 2021 11:06:21 -0400
X-MC-Unique: Ey0meNAIMT-wBxUNPFUEoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 754B0DF8A4;
        Mon, 18 Oct 2021 15:06:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E37C60E1C;
        Mon, 18 Oct 2021 15:05:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 57/67] cachefiles, afs: Drive FSCACHE_COOKIE_NO_DATA_TO_READ
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 16:05:52 +0100
Message-ID: <163456955230.2614702.5960779119312105796.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drive the FSCACHE_COOKIE_NO_DATA_TO_READ bit to skip reads on cache files
that can't have any data available to read.  This needs clearing once we've
written some data and then released the netfs page that contained it.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c           |    1 +
 fs/cachefiles/io.c      |    1 +
 fs/fscache/cookie.c     |    2 ++
 include/linux/fscache.h |   16 ++++++++++++++++
 4 files changed, 20 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 5db1e7d29ad5..7fe57f210259 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -506,6 +506,7 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 			return false;
 		wait_on_page_fscache(page);
 	}
+	fscache_note_page_release(afs_vnode_cache(vnode));
 #endif
 
 	if (PagePrivate(page)) {
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 9b3b55a94e66..5e3579800689 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -195,6 +195,7 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
 	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
 	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
 
+	set_bit(FSCACHE_COOKIE_HAVE_DATA, &ki->object->cookie->flags);
 	if (ki->term_func)
 		ki->term_func(ki->term_func_priv, ret, ki->was_async);
 	cachefiles_put_kiocb(ki);
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 1420027cfe97..369f9258bb50 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -263,6 +263,8 @@ static struct fscache_cookie *fscache_alloc_cookie(
 	cookie->key_len		= index_key_len;
 	cookie->aux_len		= aux_data_len;
 	cookie->object_size	= object_size;
+	if (object_size == 0)
+		__set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 
 	if (fscache_set_key(cookie, index_key, index_key_len) < 0)
 		goto nomem;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index ba192567d099..d18b7d3564ab 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -131,6 +131,7 @@ struct fscache_cookie {
 #define FSCACHE_COOKIE_DO_WITHDRAW	10		/* T if this cookie needs withdrawing */
 #define FSCACHE_COOKIE_DO_COMMIT	11		/* T if this cookie needs committing */
 #define FSCACHE_COOKIE_DO_PREP_TO_WRITE	12		/* T if cookie needs write preparation */
+#define FSCACHE_COOKIE_HAVE_DATA	13		/* T if this cookie has data stored */
 
 	enum fscache_cookie_stage	stage;
 	u8				advice;		/* FSCACHE_ADV_* */
@@ -643,7 +644,22 @@ static inline void fscache_clear_inode_writeback(struct fscache_cookie *cookie,
 		loff_t i_size = i_size_read(inode);
 		fscache_unuse_cookie(cookie, aux, &i_size);
 	}
+}
 
+/**
+ * fscache_note_page_release - Note that a netfs page got released
+ * @cookie: The cookie corresponding to the file
+ *
+ * Note that a page that has been copied to the cache has been released.  This
+ * means that future reads will need to look in the cache to see if it's there.
+ */
+static inline
+void fscache_note_page_release(struct fscache_cookie *cookie)
+{
+	if (cookie &&
+	    test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
+	    test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
+		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 }
 
 #ifdef FSCACHE_USE_FALLBACK_IO_API


