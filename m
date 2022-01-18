Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B437149279D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbiARNyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:54:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243414AbiARNyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642514039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2DJHYDTMbq93HbTwGgNWRdbri8NzRdmYwLg8A1nCzk=;
        b=Hptl33qjM6ujCIiHTx7NUBOoHO3PgPYFawBRlN2C7ICCLkAmGTJLpKVwXt741qeFvh2eKx
        vYht2HPWJ8OjnBywixRyvTi4Xe/nEHx6oPhS8lWla4fVlZVeQGZLsLrN6/zV8w6CIP6JOB
        BNW6nDLix42/4j/m9SayGmRCWLOcisM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-Bpv61KnLMsmgxYnww_CPJg-1; Tue, 18 Jan 2022 08:53:54 -0500
X-MC-Unique: Bpv61KnLMsmgxYnww_CPJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCD2F100CCD9;
        Tue, 18 Jan 2022 13:53:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 034CB10589CF;
        Tue, 18 Jan 2022 13:53:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/11] cachefiles: set default tag name if it's unspecified
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
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
Date:   Tue, 18 Jan 2022 13:53:19 +0000
Message-ID: <164251399914.3435901.4761991152407411408.stgit@warthog.procyon.org.uk>
In-Reply-To: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeffle Xu <jefflexu@linux.alibaba.com>

fscache_acquire_cache() requires a non-empty name, while 'tag <name>'
command is optional for cachefilesd.

Thus set default tag name if it's unspecified to avoid the regression of
cachefilesd. The logic is the same with that before rewritten.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/daemon.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 40a792421fc1..7ac04ee2c0a0 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -703,6 +703,17 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 		return -EBUSY;
 	}
 
+	/* Make sure we have copies of the tag string */
+	if (!cache->tag) {
+		/*
+		 * The tag string is released by the fops->release()
+		 * function, so we don't release it on error here
+		 */
+		cache->tag = kstrdup("CacheFiles", GFP_KERNEL);
+		if (!cache->tag)
+			return -ENOMEM;
+	}
+
 	return cachefiles_add_cache(cache);
 }
 


