Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0833B21DC8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgGMQdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:33:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25093 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730585AbgGMQdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594657996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UAVOFIpflnrDTDC4tc7UBSxnZ+7A5gGjq40lYeIbzs8=;
        b=edyOj1crixUUfMEG7T8YiEAChXAoHzoFg0EmVy7Z+Bj+9KbGfoRuPONJCNsIe0uSgesMij
        Lc/voza4b2dTeDVN0r8VcNQYsr+aRTbjgT3Tk0lvU87sxU+iFZYZHbQalaNwtIqD3dhV6m
        3x8jjstM1REE9GGst/LXhtAKNNzTBGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-CTesaysMOqm-GmYkPqXWxw-1; Mon, 13 Jul 2020 12:33:14 -0400
X-MC-Unique: CTesaysMOqm-GmYkPqXWxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B754B100978C;
        Mon, 13 Jul 2020 16:33:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46D7319D7D;
        Mon, 13 Jul 2020 16:33:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/32] fscache: Recast assertion in terms of cookie not being
 an index
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:33:06 +0100
Message-ID: <159465798650.1376674.16738070178705686097.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recast assertion in terms of cookie not being an index rather than being a
datafile.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 5c53027d3f53..2d9d147411cd 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -485,7 +485,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 	 * there, and if it's doing that, it may as well just retire the
 	 * cookie.
 	 */
-	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
+	ASSERTCMP(cookie->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
 
 	spin_lock(&cookie->lock);
 	cookie->object_size = new_size;


