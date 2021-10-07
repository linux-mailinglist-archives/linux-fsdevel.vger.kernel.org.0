Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED67425DF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 22:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbhJGUt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 16:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241519AbhJGUt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633639682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZqbU7538GbZ8WBnSLVfxKi0wPIaObo8znbOgyBrQ4Yw=;
        b=WDyW7zLbrdYrr8wQqx5NZKQtNCaJZom+qB7Swsp3yoPk19napEE8YBITW8nfud+6xyFDRa
        etBNYEZZ/A+kBptddnXOSjxCc70BcWmoqH6E3PaxmPZmkEAspSwS4vOa2nbLFiL2dFfOJh
        DZOsCKRM7UKMHVb3BvC7nVddhqYC7so=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-vgGss0BUO0muDXUD0MbujQ-1; Thu, 07 Oct 2021 16:48:01 -0400
X-MC-Unique: vgGss0BUO0muDXUD0MbujQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 176AE10B3FB7;
        Thu,  7 Oct 2021 20:43:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46D3AC0222;
        Thu,  7 Oct 2021 20:43:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 03/10] cachefiles: Always indicate we should fill a
 post-EOF page with zeros
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
Date:   Thu, 07 Oct 2021 21:43:31 +0100
Message-ID: <163363941133.1980952.8507236797298999171.stgit@warthog.procyon.org.uk>
In-Reply-To: <163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk>
References: <163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In cachefiles_prepare_read(), always indicate to the netfs lib that a page
beyond the EOF should be filled with zeros, even if we don't have a cache
file attached because it's still being created.

This avoids confusion in netfs_rreq_prepare_read() where it sees source ==
NETFS_DOWNLOAD_FROM_SERVER, where it consequently sees the read after the
EOF getting reduced to 0 size and thus triggers the WARN_ON and marking the
read invalid.

Also don't try to check for data if there's a flag set indicating we don't
yet have anything stored in the cache.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/io.c |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 08b3183e0dce..dbc1c4421116 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -273,6 +273,7 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
 	struct file *file = subreq->rreq->cache_resources.cache_priv2;
+	enum netfs_read_source ret = NETFS_DOWNLOAD_FROM_SERVER;
 	loff_t off, to;
 
 	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
@@ -281,19 +282,24 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 	cache = container_of(object->fscache.cache,
 			     struct cachefiles_cache, cache);
 
-	if (!file)
-		goto cache_fail_nosec;
+	cachefiles_begin_secure(cache, &saved_cred);
 
-	if (subreq->start >= i_size)
-		return NETFS_FILL_WITH_ZEROES;
+	if (subreq->start >= i_size) {
+		ret = NETFS_FILL_WITH_ZEROES;
+		goto out;
+	}
 
-	cachefiles_begin_secure(cache, &saved_cred);
+	if (!file)
+		goto out;
+
+	if (test_bit(FSCACHE_COOKIE_NO_DATA_YET, &object->fscache.cookie->flags))
+		goto download_and_store;
 
 	off = vfs_llseek(file, subreq->start, SEEK_DATA);
 	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
 		if (off == (loff_t)-ENXIO)
 			goto download_and_store;
-		goto cache_fail;
+		goto out;
 	}
 
 	if (off >= subreq->start + subreq->len)
@@ -307,7 +313,7 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 
 	to = vfs_llseek(file, subreq->start, SEEK_HOLE);
 	if (to < 0 && to >= (loff_t)-MAX_ERRNO)
-		goto cache_fail;
+		goto out;
 
 	if (to < subreq->start + subreq->len) {
 		if (subreq->start + subreq->len >= i_size)
@@ -317,16 +323,15 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 		subreq->len = to - subreq->start;
 	}
 
-	cachefiles_end_secure(cache, saved_cred);
-	return NETFS_READ_FROM_CACHE;
+	ret = NETFS_READ_FROM_CACHE;
+	goto out;
 
 download_and_store:
 	if (cachefiles_has_space(cache, 0, (subreq->len + PAGE_SIZE - 1) / PAGE_SIZE) == 0)
 		__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
-cache_fail:
+out:
 	cachefiles_end_secure(cache, saved_cred);
-cache_fail_nosec:
-	return NETFS_DOWNLOAD_FROM_SERVER;
+	return ret;
 }
 
 /*


