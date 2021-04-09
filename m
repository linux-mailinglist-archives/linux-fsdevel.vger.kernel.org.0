Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5142C35A55E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhDISLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 14:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234627AbhDISLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617991867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgtAbf2LjG2l+2155p4OwWEE/xnbluMbW9xCxJONACw=;
        b=Vw3k4ERQBxrWQ7798MyJ87x8BGTM/lUR5dfzTI+oWqTkEHmGcl4vIDuC+1uTffwnNmVTrD
        6HuF0PIyEYPHX7Kl1KqvtCY0XDow2gnlxSDz+SnS9GKTQtrDRxzd7o9SUeOAMQ9wl/L/Yg
        fPqiJa1q8kcEq2TCDa2FgcRUXYjexyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-TK3YSBC1OvymhxW-Xrgfww-1; Fri, 09 Apr 2021 14:11:03 -0400
X-MC-Unique: TK3YSBC1OvymhxW-Xrgfww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DF2D18766D0;
        Fri,  9 Apr 2021 18:11:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEDCA10016FD;
        Fri,  9 Apr 2021 18:10:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 1/2] iov_iter: Remove iov_iter_for_each_range()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, willy@infradead.org, jlayton@kernel.org,
        hch@lst.de, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 09 Apr 2021 19:10:53 +0100
Message-ID: <161799185391.847742.2598422794034740322.stgit@warthog.procyon.org.uk>
In-Reply-To: <YG+s0iw5o91KQIlW@zeniv-ca.linux.org.uk>
References: <YG+s0iw5o91KQIlW@zeniv-ca.linux.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove iov_iter_for_each_range() as it's no longer used with the removal of
lustre.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/uio.h |    4 ----
 lib/iov_iter.c      |   27 ---------------------------
 2 files changed, 31 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5f5ffc45d4aa..221c256304d4 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -295,8 +295,4 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 int import_single_range(int type, void __user *buf, size_t len,
 		 struct iovec *iov, struct iov_iter *i);
 
-int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
-			    int (*f)(struct kvec *vec, void *context),
-			    void *context);
-
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f808c625c11e..93e9838c128d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -2094,30 +2094,3 @@ int import_single_range(int rw, void __user *buf, size_t len,
 	return 0;
 }
 EXPORT_SYMBOL(import_single_range);
-
-int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
-			    int (*f)(struct kvec *vec, void *context),
-			    void *context)
-{
-	struct kvec w;
-	int err = -EINVAL;
-	if (!bytes)
-		return 0;
-
-	iterate_all_kinds(i, bytes, v, -EINVAL, ({
-		w.iov_base = kmap(v.bv_page) + v.bv_offset;
-		w.iov_len = v.bv_len;
-		err = f(&w, context);
-		kunmap(v.bv_page);
-		err;}), ({
-		w = v;
-		err = f(&w, context);}), ({
-		w.iov_base = kmap(v.bv_page) + v.bv_offset;
-		w.iov_len = v.bv_len;
-		err = f(&w, context);
-		kunmap(v.bv_page);
-		err;})
-	)
-	return err;
-}
-EXPORT_SYMBOL(iov_iter_for_each_range);


