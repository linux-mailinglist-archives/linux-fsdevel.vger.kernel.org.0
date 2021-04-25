Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B45F36A9D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 01:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhDYXPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 19:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231441AbhDYXPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 19:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619392505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+JuniTf6/0QJHyHH9jZCObdX5/aD9evlCt++gaJJ1U=;
        b=XHuwJPRJUE/ui47Aju4ctDA+pDgtS+Qxu4ySzhkr6Oan9nyJfmrpl7KgqhO5gZzzilxuNU
        WPmsMLdlCgOzNnyBg6jEarky6OW6hJ+0xjhik9pKvPWo6RprZkon8Z5DPC8p5NEdrKQ9ju
        Y9NayKqF9KK4OB8VNyZko9LHVKrl+gQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-BQSQMrQCPYm7CjiNMMlK1Q-1; Sun, 25 Apr 2021 19:15:01 -0400
X-MC-Unique: BQSQMrQCPYm7CjiNMMlK1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 009458030B5;
        Sun, 25 Apr 2021 23:14:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C7785D74F;
        Sun, 25 Apr 2021 23:14:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
References: <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk> <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] iov_iter: Four fixes for ITER_XARRAY
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3545033.1619392490.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 26 Apr 2021 00:14:50 +0100
Message-ID: <3545034.1619392490@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

I think this patch should include all the fixes necessary.  I could merge
it in, but I think it might be better to tag it on the end as an additiona=
l
patch.

David
---
iov_iter: Four fixes for ITER_XARRAY

Fix four things[1] in the patch that adds ITER_XARRAY[2]:

 (1) Remove the address_space struct predeclaration.  This is a holdover
     from when it was ITER_MAPPING.

 (2) Fix _copy_mc_to_iter() so that the xarray segment updates count and
     iov_offset in the iterator before returning.

 (3) Fix iov_iter_alignment() to not loop in the xarray case.  Because the
     middle pages are all whole pages, only the end pages need be
     considered - and this can be reduced to just looking at the start
     position in the xarray and the iteration size.

 (4) Fix iov_iter_advance() to limit the size of the advance to no more
     than the remaining iteration size.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/YIVrJT8GwLI0Wlgx@zeniv-ca.linux.org.uk [1]
Link: https://lore.kernel.org/r/161918448151.3145707.11541538916600921083.=
stgit@warthog.procyon.org.uk [2]
---
 include/linux/uio.h |    1 -
 lib/iov_iter.c      |    5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5f5ffc45d4aa..d3ec87706d75 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -10,7 +10,6 @@
 #include <uapi/linux/uio.h>
 =

 struct page;
-struct address_space;
 struct pipe_inode_info;
 =

 struct kvec {
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 44fa726a8323..61228a6c69f8 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -791,6 +791,8 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes=
, struct iov_iter *i)
 			curr_addr =3D (unsigned long) from;
 			bytes =3D curr_addr - s_addr - rem;
 			rcu_read_unlock();
+			i->iov_offset +=3D bytes;
+			i->count -=3D bytes;
 			return bytes;
 		}
 		})
@@ -1147,6 +1149,7 @@ void iov_iter_advance(struct iov_iter *i, size_t siz=
e)
 		return;
 	}
 	if (unlikely(iov_iter_is_xarray(i))) {
+		size =3D min(size, i->count);
 		i->iov_offset +=3D size;
 		i->count -=3D size;
 		return;
@@ -1346,6 +1349,8 @@ unsigned long iov_iter_alignment(const struct iov_it=
er *i)
 			return size | i->iov_offset;
 		return size;
 	}
+	if (unlikely(iov_iter_is_xarray(i)))
+		return (i->xarray_start + i->iov_offset) | i->count;
 	iterate_all_kinds(i, size, v,
 		(res |=3D (unsigned long)v.iov_base | v.iov_len, 0),
 		res |=3D v.bv_offset | v.bv_len,

