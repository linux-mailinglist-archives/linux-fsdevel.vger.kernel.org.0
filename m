Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D7C4321C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhJRPHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233874AbhJRPGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HO9YymjW83uus3ZxQrl12j24vv8cDVvU6mSOVZgOUCA=;
        b=Llu2keF9u98fNnIP+HJhMEGL0NpFh7cyb64A2us5hDSzyR4NmflQCOUEMYmoYyMn2bPhtk
        StZd1REK0aPRZ2FXhPTg9CysifOZoqNwNqAuxys3VmxGaFeHro+0mMAG5aRgmLAEgKUfUD
        9R0zwbAlUFgxofRZ+UFM96QKC7Mb8x0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-LvlXEboLNE6rtTEDUmVbKQ-1; Mon, 18 Oct 2021 11:03:52 -0400
X-MC-Unique: LvlXEboLNE6rtTEDUmVbKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB9E510168C0;
        Mon, 18 Oct 2021 15:03:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2D3057CA4;
        Mon, 18 Oct 2021 15:03:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 51/67] fscache: Make fscache_write_to_cache() conditional on
 cookie
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
Date:   Mon, 18 Oct 2021 16:03:46 +0100
Message-ID: <163456942676.2614702.13709221260564510952.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make fscache_write_to_cache() conditional on cookie not being NULL, rather
than merely conditional on CONFIG_FSCACHE=[ym].  The problem with the
latter is if a filesystem, say afs, has CONFIG_AFS_FSCACHE=n but calls into
this function - linkage will fail if CONFIG_FSCACHE is less than
CONFIG_AFS.  Analogous problems can affect other filesystems, e.g. 9p.

Making fscache_write_to_cache() conditional on the cookie achieves two
things:

 (1) If cookie optimises down to constant NULL, term_func is called
     directly and may be inlined and the slow path is never called.

 (2) __fscache_write_to_cache() isn't called if cookie is dynamically NULL
     - and so, in such a case, term_func is called immediately.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/fscache.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 847c076d05a6..ba192567d099 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -593,7 +593,7 @@ static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
 					  netfs_io_terminated_t term_func,
 					  void *term_func_priv)
 {
-	if (fscache_available()) {
+	if (fscache_cookie_valid(cookie)) {
 		__fscache_write_to_cache(cookie, mapping, start, len, i_size,
 					 term_func, term_func_priv);
 	} else {


