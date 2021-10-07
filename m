Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1673B425DED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 22:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbhJGUtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 16:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242209AbhJGUt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633639654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5M1iNAPaptlPLme6linigjNcNwwDvDm+17gtczkZJ1s=;
        b=Tr1fyQ/P57T3LrSmPE82fD97lLORM95YrFdxYuGnvIEyJTHNDXnteHllZoFjY2FyFoJE18
        xJR0DreDuB+/0BrFEmGr+LYSlwiP+DpMhGgbJeOv8ZtOLcfssCkDY7a38OHMgfzOuJZAWU
        /dlxWRrN8maXfw3xuwbFzLJfmkkyXMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-mY1vl1iQNEOpl5NgqOSS-g-1; Thu, 07 Oct 2021 16:47:31 -0400
X-MC-Unique: mY1vl1iQNEOpl5NgqOSS-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CCB8A76CB6;
        Thu,  7 Oct 2021 20:43:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57A805C1A3;
        Thu,  7 Oct 2021 20:43:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 02/10] fscache: Fix fscache_cookie_enabled() to handle NULL
 cookie
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Oct 2021 21:43:22 +0100
Message-ID: <163363940251.1980952.8682998052010411386.stgit@warthog.procyon.org.uk>
In-Reply-To: <163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk>
References: <163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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


