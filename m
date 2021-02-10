Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C40316B76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 17:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhBJQjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 11:39:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232784AbhBJQiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612975003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6q4l5j2A9zC8AOPQY3ki5vFxtQJE10uxKO//gAn5chg=;
        b=P9Ja+CceJgu87YP1k1zZb1aycA4H8XFB5fB4HzNj0Nmwd7vqODKBcz+EhqVbIcpiWwl79/
        Ul9zfWxLONn5DT0Vlh/9mpqdb0JjtDlEGIb4Z5BS8qp8KTNBlVHxSywPGjdmRw6GYQBSD2
        y+jM33mMrk8Xwbuv6fKfCNbfBWYukG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-0MlIkmEwOxCxZMmDqzOJ6A-1; Wed, 10 Feb 2021 11:36:42 -0500
X-MC-Unique: 0MlIkmEwOxCxZMmDqzOJ6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37F8D803F4C;
        Wed, 10 Feb 2021 16:36:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4970D60657;
        Wed, 10 Feb 2021 16:36:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com>
References: <CAHk-=wh+2gbF7XEjYc=HV9w_2uVzVf7vs60BPz0gFA=+pUm3ww@mail.gmail.com> <591237.1612886997@warthog.procyon.org.uk> <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com> <20210209202134.GA308988@casper.infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1331024.1612974993.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 10 Feb 2021 16:36:33 +0000
Message-ID: <1331025.1612974993@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Does the code not hold a refcount already?

The attached patch will do that.  Note that it's currently based on top of=
 the
patch that drops the PG_fscache alias, so it refers to PG_private_2.

I've run all three patches through xfstests over afs, both with and withou=
t a
cache, and Jeff has tested ceph with them.

David
---
commit 803a09110b41b9f6091a517fc8f5c4b15475048c
Author: David Howells <dhowells@redhat.com>
Date:   Wed Feb 10 11:35:15 2021 +0000

    netfs: Hold a ref on a page when PG_private_2 is set
    =

    Take a reference on a page when PG_private_2 is set and drop it once t=
he
    bit is unlocked.
    =

    Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 9018224693e9..043d96ca2aad 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/sched/mm.h>
@@ -230,10 +231,13 @@ static void netfs_rreq_completed(struct netfs_read_r=
equest *rreq)
 static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq=
)
 {
 	struct netfs_read_subrequest *subreq;
+	struct pagevec pvec;
 	struct page *page;
 	pgoff_t unlocked =3D 0;
 	bool have_unlocked =3D false;
 =

+	pagevec_init(&pvec);
+
 	rcu_read_lock();
 =

 	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
@@ -247,6 +251,8 @@ static void netfs_rreq_unmark_after_write(struct netfs=
_read_request *rreq)
 				continue;
 			unlocked =3D page->index;
 			unlock_page_private_2(page);
+			if (pagevec_add(&pvec, page) =3D=3D 0)
+				pagevec_release(&pvec);
 			have_unlocked =3D true;
 		}
 	}
@@ -403,8 +409,10 @@ static void netfs_rreq_unlock(struct netfs_read_reque=
st *rreq)
 				pg_failed =3D true;
 				break;
 			}
-			if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
+			if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags)) {
+				get_page(page);
 				SetPagePrivate2(page);
+			}
 			pg_failed |=3D subreq_failed;
 			if (pgend < iopos + subreq->len)
 				break;

