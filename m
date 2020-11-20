Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D02BAD9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgKTPJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:09:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728818AbgKTPI7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOVb4/i1tOkNLeMBcqUh14yQwdQw5pAq8B7ip/oyDBk=;
        b=EFwTx+S6v/N/sicnKNOnteziGIz2hAehYHRbi+IwhMldAvdoEZKn3sBLJSOQf17z5H31xt
        NlLfxGLSh4V0Ho1HN6ip4XSonb1ov+XwEMpML1xBqRCfOuHv92wkMoMk0fIBAdu5SWGfix
        cBAXo96a92GhruLNlg1u0tJzREgscwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-1t8ANGtgM26B7ktBwz-usg-1; Fri, 20 Nov 2020 10:08:56 -0500
X-MC-Unique: 1t8ANGtgM26B7ktBwz-usg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2E4F911E3;
        Fri, 20 Nov 2020 15:08:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76AE260C05;
        Fri, 20 Nov 2020 15:08:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 29/76] fscache: Recast assertion in terms of cookie not
 being an index
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
Date:   Fri, 20 Nov 2020 15:08:46 +0000
Message-ID: <160588492664.3465195.1529947521472671914.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index 230025a1495c..8d8aba14912a 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -546,7 +546,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 	 * there, and if it's doing that, it may as well just retire the
 	 * cookie.
 	 */
-	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
+	ASSERTCMP(cookie->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
 
 	spin_lock(&cookie->lock);
 	cookie->object_size = new_size;


