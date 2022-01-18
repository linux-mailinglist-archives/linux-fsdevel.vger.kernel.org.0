Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69F14927BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbiARNyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:54:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244132AbiARNyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642514092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0H8i+DlKXoFlzGfONMzGSVnFQYHwXgV1sPpYBX+8jJE=;
        b=JGsKuu2vDoNVChUdgHTN5nbZBM++1TdIDPcCq7xwhun/HNg3lUc77sbYNeeqel7aIE3eQx
        HSU/LDylnigcxaFdQmCMM+iNQZIgYZWLGHmysgKVT4JO4qnXp1iszUz77qexVhfmdWjzN/
        yk8sFWhs5zbS12Mkb7h2IiWfwMJxEpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-KRPhdvaOOrG7W_oVkauJ3A-1; Tue, 18 Jan 2022 08:54:49 -0500
X-MC-Unique: KRPhdvaOOrG7W_oVkauJ3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FE8A101AFD6;
        Tue, 18 Jan 2022 13:54:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CD9D7E2EA;
        Tue, 18 Jan 2022 13:54:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/11] cachefiles: Check that the backing filesystem supports
 tmpfiles
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
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
Date:   Tue, 18 Jan 2022 13:54:25 +0000
Message-ID: <164251406558.3435901.1249023136670058162.stgit@warthog.procyon.org.uk>
In-Reply-To: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a check that the backing filesystem supports the creation of
tmpfiles[1].

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/568749bd7cc02908ecf6f3d6a611b6f9cf5c4afd.camel@kernel.org/ [1]
---

 fs/cachefiles/cache.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 2b2879c5d1d2..7077f72e6f47 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -51,6 +51,7 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
 
 	/* Check features of the backing filesystem:
 	 * - Directories must support looking up and directory creation
+	 * - We create tmpfiles to handle invalidation
 	 * - We use xattrs to store metadata
 	 * - We need to be able to query the amount of space available
 	 * - We want to be able to sync the filesystem when stopping the cache
@@ -60,6 +61,7 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
 	if (d_is_negative(root) ||
 	    !d_backing_inode(root)->i_op->lookup ||
 	    !d_backing_inode(root)->i_op->mkdir ||
+	    !d_backing_inode(root)->i_op->tmpfile ||
 	    !(d_backing_inode(root)->i_opflags & IOP_XATTR) ||
 	    !root->d_sb->s_op->statfs ||
 	    !root->d_sb->s_op->sync_fs ||


