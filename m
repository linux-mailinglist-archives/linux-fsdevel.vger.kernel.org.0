Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13C4927C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbiARNzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:55:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244383AbiARNzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642514106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VF4onKqMIrYu5mloBKsdeoO9FD6g9xK5Udf/2HJaEOo=;
        b=Ft/EeX36ihTrK+KY+x9utp711JR7zeYWwzDXdMP3184EcK1N/+t9EJY+F50vTna0vvIBWk
        PB9q599FC3bcfmW3iQn01ifdpYtWMR1B5+Cdfm0QffUoCwdq9N7Qj7uVw+yGak9kv5UkYO
        nD8JY0QyFMMeu4zSlSX93zm72uxLhuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-vgBLGJ2uORa7FAsl4Z7w7Q-1; Tue, 18 Jan 2022 08:55:03 -0500
X-MC-Unique: vgBLGJ2uORa7FAsl4Z7w7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A5521090017;
        Tue, 18 Jan 2022 13:54:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAE842DE92;
        Tue, 18 Jan 2022 13:54:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/11] fscache: Add a comment explaining how page-release
 optimisation works
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
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
Date:   Tue, 18 Jan 2022 13:54:44 +0000
Message-ID: <164251408479.3435901.9540165422908194636.stgit@warthog.procyon.org.uk>
In-Reply-To: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a comment into fscache_note_page_release() to explain how the
page-release optimisation logic works[1].  It's not entirely obvious as it
has nothing to do with whether or not the netfs file contains data.

FSCACHE_COOKIE_NO_DATA_TO_READ is set if we have no data in the cache yet
(ie. the backing file lookup was negative, the file is 0 length or the
cookie got invalidated).  It means that we have no data in the cache, not
that the file is necessarily empty on the server.

FSCACHE_COOKIE_HAVE_DATA is set once we've stored data in the backing file.
From that point on, we have data we *could* read - however, it's covered by
pages in the netfs pagecache until at such time one of those covering pages
is released.

So if we've written data to the cache (HAVE_DATA) and there wasn't any data
in the cache when we started (NO_DATA_TO_READ), it may no longer be true
that we can skip reading from the cache.

Read skipping is done by cachefiles_prepare_read().

Note that tracking is not done on a per-page basis, but only on a per-file
basis.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/043a206f03929c2667a465314144e518070a9b2d.camel@kernel.org/ [1]
---

 include/linux/fscache.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index ede50406bcb0..296c5f1d9f35 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -665,6 +665,11 @@ static inline void fscache_clear_inode_writeback(struct fscache_cookie *cookie,
 static inline
 void fscache_note_page_release(struct fscache_cookie *cookie)
 {
+	/* If we've written data to the cache (HAVE_DATA) and there wasn't any
+	 * data in the cache when we started (NO_DATA_TO_READ), it may no
+	 * longer be true that we can skip reading from the cache - so clear
+	 * the flag that causes reads to be skipped.
+	 */
 	if (cookie &&
 	    test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
 	    test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))


