Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2218946EF62
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbhLIREP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:04:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241688AbhLIREG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5dCbzoP8+tSDo3duENe/pb2R+iIFDYIwHHgvs+KT0bA=;
        b=E99tagpPLDgP/FzFD1RuyWZyEUVBGjxZRBq0u0KjarvoDfJqb18014hH+r8jkjLm6dvR73
        ZXut2oS+I8U908CwkMdNwbmufagen1IkcOOZqvzb0zGdNkFv3F7sgmWht4i1ElMW1GujIb
        s3Ka7OjEOhH3kHOAtkrRHmtqHXEU2Wk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37--1iPhLwGMYuoiudAXXkNKw-1; Thu, 09 Dec 2021 12:00:28 -0500
X-MC-Unique: -1iPhLwGMYuoiudAXXkNKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEB32824F84;
        Thu,  9 Dec 2021 17:00:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D0627A22A;
        Thu,  9 Dec 2021 17:00:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 28/67] fscache: Provide a function to note the release of a
 page
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
Date:   Thu, 09 Dec 2021 17:00:03 +0000
Message-ID: <163906920354.143852.7511819614661372008.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a function to be called from a network filesystem's releasepage
method to indicate that a page has been released that might have been a
reflection of data upon the server - and now that data must be reloaded
from the server or the cache.

This is used to end an optimisation for empty files, in particular files
that have just been created locally, whereby we know there cannot yet be
any data that we would need to read from the server or the cache.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819617128.215744.4725572296135656508.stgit@warthog.procyon.org.uk/ # v1
---

 include/linux/fscache.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 73942b4e9aee..fed7def0fbe0 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -603,4 +603,20 @@ static inline void fscache_clear_inode_writeback(struct fscache_cookie *cookie,
 	}
 }
 
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
+}
+
 #endif /* _LINUX_FSCACHE_H */


