Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAD03D1881
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 23:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhGUUVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 16:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229923AbhGUUVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626901312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GclXY2ksYr1Udx8zsfvHxRSGegwER5nsOIWFyg2Lzz8=;
        b=IUG7uu+fFdGqw/4xvph0acvoxEu+fyCAOgg0uRVvHTR+u8VMJqToZNkHF+UGpGmWqEfaeA
        qZIRD1dlKBbvnCmbEYp7DO8AQX0uwTbrgq6Gkf0khSl/9PzaBLERytrNm6RvsofQh7X82z
        6QtP8MLz0wRKFCVfLSOwmKqdfXA5VYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-kVNbtwaQPnGttHTX-PduvA-1; Wed, 21 Jul 2021 17:01:51 -0400
X-MC-Unique: kVNbtwaQPnGttHTX-PduvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C62010086CA;
        Wed, 21 Jul 2021 21:01:49 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1811E385;
        Wed, 21 Jul 2021 21:01:46 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH] iov_iter: Fix iov_iter_get_pages{,_alloc} page fault return value
Date:   Wed, 21 Jul 2021 23:01:45 +0200
Message-Id: <20210721210145.166669-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both iov_iter_get_pages and iov_iter_get_pages_alloc return the number of bytes
of the iovec they could get the pages for.  When they cannot get any pages,
they're supposed to return 0, but when the start of the iovec isn't page
aligned, the calculation goes wrong and they return a negative value.
Fix that in both functions.

In addition, change iov_iter_get_pages_alloc to return ZERO_SIZE_PTR in that
case to prevent resource leaks.

It seems that the cifs and nfs filesystems don't handle the zero case very
well.  Steve, Trond, Anna, could you please have a look?

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 lib/iov_iter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e23123ae3a13..20dc3d800573 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1484,7 +1484,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		res = get_user_pages_fast(addr, n,
 				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0,
 				pages);
-		if (unlikely(res < 0))
+		if (unlikely(res <= 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
 	}
@@ -1608,8 +1608,9 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 			return -ENOMEM;
 		res = get_user_pages_fast(addr, n,
 				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0, p);
-		if (unlikely(res < 0)) {
+		if (unlikely(res <= 0)) {
 			kvfree(p);
+			*pages = ZERO_SIZE_PTR;
 			return res;
 		}
 		*pages = p;
-- 
2.26.3

