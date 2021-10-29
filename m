Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8031843FDFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhJ2OMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 10:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231755AbhJ2OMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635516607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5M1iNAPaptlPLme6linigjNcNwwDvDm+17gtczkZJ1s=;
        b=ThZuCY6gDVuaVReosu7mSVXb5mcnxvjpOOS3s8muENOBNE7FoAn7N/mCEnn7w3PUKcUGTw
        6tR0AWcrbiTG5otO4ujv1ENp60w4ItJMj4+ajoBZp5D6xrO3m4TutYaVgI5EOIIjZPhSxq
        x/UFg1xah0z1EhtkzEFDBq4XoMVEMJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-QUot6QYgNTyaSCEBZ2BN7A-1; Fri, 29 Oct 2021 10:09:49 -0400
X-MC-Unique: QUot6QYgNTyaSCEBZ2BN7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E402A40D0;
        Fri, 29 Oct 2021 14:09:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E406960C13;
        Fri, 29 Oct 2021 14:09:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 02/10] fscache: Fix fscache_cookie_enabled() to handle NULL
 cookie
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Oct 2021 15:09:28 +0100
Message-ID: <163551656895.1877519.8303891885033763947.stgit@warthog.procyon.org.uk>
In-Reply-To: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
References: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix fscache_cookie_enabled() to handle being given a NULL cookie pointer
(ie. a cookie was not allocated and caching should be ignored).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/fscache.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 32f65c16328a..5e3ddb11715a 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -167,7 +167,8 @@ struct fscache_cookie {
 
 static inline bool fscache_cookie_enabled(struct fscache_cookie *cookie)
 {
-	return test_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
+	return (fscache_cookie_valid(cookie) &&
+		test_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags));
 }
 
 /*


