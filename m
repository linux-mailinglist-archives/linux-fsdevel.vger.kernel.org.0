Return-Path: <linux-fsdevel+bounces-8427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89113836388
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 13:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7D41F20984
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B543E47E;
	Mon, 22 Jan 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2sHzK1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350C3E462
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927156; cv=none; b=Qv3T2Myfv0bYrReqIW3N9RDCuW711cRDSs8Tc4fTs4/euSAr+k1V1gQ7cE0bM4YNkjAyCm8hl/HE0SC+q/90xudlszizQIGjjlFnl07dQ6GGKZtpv9uDYklsdpZJDhvUT3E0LOWYk6atvX3gdY1tjfzPOmq503FHpr0YRf3eL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927156; c=relaxed/simple;
	bh=8G3yBj9g+dso7iEfMFsKAhuhaGEPop9JL1MTx/cr1WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVsnXtSVYJ7vY+oN8vZJQOFNkw1Jf7mZaN4bL4Bj6Rw9jAGNrFn62h+uF+D0aeib6M7UogVp8+LkC3BjhrYSCAavlcjy94ovSRfS06Fcvr5A2R+VbiYEZZmR17tIjsTY588vl+dXbMaEq6kLGWicB3WN0QU3ErdcQNomdEY9Bmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2sHzK1T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705927153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iici4CcialH0lyfTdSLWnoYWTya5IEpmfmLuwHkca5Y=;
	b=d2sHzK1TzLCQgijOQJHWMUvHI3tN2WpJHxSrxbNE1rqKvogcXuUUDO5GW2izvBpzupBIdd
	8fe0SRFBamPRGS3yLA9USXFb/vX8YGJI09oUxdx2eN0uzOKY9DswLI62EhFg/NtKGhPgMi
	JyJVhGd3a6D5+duASp2V904/gfYdrGs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-nqfuXrHZNCS78rn85yiyNQ-1; Mon,
 22 Jan 2024 07:39:09 -0500
X-MC-Unique: nqfuXrHZNCS78rn85yiyNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A9D51C05ABA;
	Mon, 22 Jan 2024 12:39:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9CA3E2026D66;
	Mon, 22 Jan 2024 12:39:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH 06/10] cachefiles, erofs: Fix NULL deref in when cachefiles is not doing ondemand-mode
Date: Mon, 22 Jan 2024 12:38:39 +0000
Message-ID: <20240122123845.3822570-7-dhowells@redhat.com>
In-Reply-To: <20240122123845.3822570-1-dhowells@redhat.com>
References: <20240122123845.3822570-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

cachefiles_ondemand_init_object() as called from cachefiles_open_file() and
cachefiles_create_tmpfile() does not check if object->ondemand is set
before dereferencing it, leading to an oops something like:

	RIP: 0010:cachefiles_ondemand_init_object+0x9/0x41
	...
	Call Trace:
	 <TASK>
	 cachefiles_open_file+0xc9/0x187
	 cachefiles_lookup_cookie+0x122/0x2be
	 fscache_cookie_state_machine+0xbe/0x32b
	 fscache_cookie_worker+0x1f/0x2d
	 process_one_work+0x136/0x208
	 process_scheduled_works+0x3a/0x41
	 worker_thread+0x1a2/0x1f6
	 kthread+0xca/0xd2
	 ret_from_fork+0x21/0x33

Fix this by making the calls to cachefiles_ondemand_init_object()
conditional.

Fixes: 3c5ecfe16e76 ("cachefiles: extract ondemand info field from cachefiles_object")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Gao Xiang <xiang@kernel.org>
cc: Chao Yu <chao@kernel.org>
cc: Yue Hu <huyue2@coolpad.com>
cc: Jeffle Xu <jefflexu@linux.alibaba.com>
cc: linux-erofs@lists.ozlabs.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/namei.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7ade836beb58..180594d24c44 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -473,9 +473,11 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	if (!cachefiles_mark_inode_in_use(object, file_inode(file)))
 		WARN_ON(1);
 
-	ret = cachefiles_ondemand_init_object(object);
-	if (ret < 0)
-		goto err_unuse;
+	if (object->ondemand) {
+		ret = cachefiles_ondemand_init_object(object);
+		if (ret < 0)
+			goto err_unuse;
+	}
 
 	ni_size = object->cookie->object_size;
 	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
@@ -579,9 +581,11 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	}
 	_debug("file -> %pd positive", dentry);
 
-	ret = cachefiles_ondemand_init_object(object);
-	if (ret < 0)
-		goto error_fput;
+	if (object->ondemand) {
+		ret = cachefiles_ondemand_init_object(object);
+		if (ret < 0)
+			goto error_fput;
+	}
 
 	ret = cachefiles_check_auxdata(object, file);
 	if (ret < 0)


