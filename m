Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945411C41DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbgEDROi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:14:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23933 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730316AbgEDROh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4U4fcN/pK7N2vY4Mne5ej9n14XUHHEQ4OsRfDbqy0E=;
        b=A4tV4ccBvdYxSlD5ge4xJAARPvqsjRtcfmyYjw67IgQjRp7xLWdu+59uKdPkRKnRyd311o
        PUqu024ZoXiGdu6ptgC073GvDxQf5qskCw7TMLCOjS2NGzsDsEmzdl/QQjYeOqEh9sNYhb
        pHn/cJj+9jcOyMl8Ib1La2OVgLdBucE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-u8C8a5BLMmaTOqWvrjo2nA-1; Mon, 04 May 2020 13:14:31 -0400
X-MC-Unique: u8C8a5BLMmaTOqWvrjo2nA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0E9C835B40;
        Mon,  4 May 2020 17:14:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1704760F8D;
        Mon,  4 May 2020 17:14:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 46/61] cachefiles: Shape write requests
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:14:26 +0100
Message-ID: <158861246621.340223.9118210695394840507.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In cachefiles_shape_extent(), shape a write request to always write to the
cache.  The assumption is made that the caller has read the entire cache
granule beforehand if necessary.

Possibly this should be amended so that writes will only take place to
granules that are marked present and granules that lie beyond the EOF.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/content-map.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index 13632c097248..2c45092465b6 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -71,7 +71,8 @@ static unsigned int cachefiles_shape_single(struct fscache_object *obj,
 
 	extent->dio_block_size = CACHEFILES_DIO_BLOCK_SIZE;
 
-	if (object->content_info == CACHEFILES_CONTENT_SINGLE) {
+	if (!for_write &&
+	    object->content_info == CACHEFILES_CONTENT_SINGLE) {
 		ret = FSCACHE_READ_FROM_CACHE;
 	} else {
 		eof = (i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -128,13 +129,20 @@ unsigned int cachefiles_shape_extent(struct fscache_object *obj,
 
 	granule = start / CACHEFILES_GRAN_PAGES;
 
-	/* If the content map didn't get expanded for some reason - simply
-	 * ignore this granule.
-	 */
-	if (granule / 8 >= object->content_map_size)
-		return 0;
+	if (granule / 8 >= object->content_map_size) {
+		cachefiles_expand_content_map(object, i_size);
+		if (granule / 8 >= object->content_map_size)
+			return 0;
+	}
 
-	if (cachefiles_granule_is_present(object, granule)) {
+	if (for_write) {
+		/* Assume that the preparation to write involved preloading any
+		 * bits of the cache that weren't to be written and filling any
+		 * gaps that didn't end up being written.
+		 */
+		bend = end;
+		ret = FSCACHE_WRITE_TO_CACHE;
+	} else if (cachefiles_granule_is_present(object, granule)) {
 		/* The start of the requested extent is present in the cache -
 		 * restrict the returned extent to the maximum length of what's
 		 * available.


