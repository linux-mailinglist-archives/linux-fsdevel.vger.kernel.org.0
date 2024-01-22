Return-Path: <linux-fsdevel+bounces-8430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F89836394
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 13:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287621F24138
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767D13FB2E;
	Mon, 22 Jan 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UndmevlT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDC73F8E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927163; cv=none; b=ThAQrOShzNPdNJ7Wv4RJzhozJN4gVS4hFoTP0XMuul3gzZj7pIn+ZG/+RdMgaFzQU22FYjljl5uZhAsWJT/EojrV78d0tQZGAs+4GRdgy/wRclqAU/TgfzA9O524IHK5g7HZDTfyiLtkJe0zarpu8UYrWbTgaP3hnuWh32ygq/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927163; c=relaxed/simple;
	bh=u1NZ5oJ45qo+iUmBVeXgQl020jMPO7hETF1JUMYSA/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVSFKMfylSbY4MCVb091Ba6GG83PpcadOoSa9XewX4WO0MksTIRLII9N3+RT8fIAjNwaMQdOXtZRG7Z6GeGnKRtHTGZrKgQw56AhRgebfV4rSE1OBJjDRYyQPA3eOUw1EOQ4bLe9MGku5RDBB+mwRYLeW7vZCPXU1tDVJEP8oMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UndmevlT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705927161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4H/QyaTEJT6yM0W34T+DHhl8mPiadWYAfCey1J2x+wk=;
	b=UndmevlTkSwRNvfNUV0KUkXKR94CCh3A/1I15K6N6Ri+OsTYrb6KBjVDM6VUxJBHdi33LX
	q9DVjgzip8ODgSqlC7lWZKs9MGqv3BV7LOlwL4gL+QjPqG4qLgOtfo3HqCHldE5YVHsCFp
	rP4+nfZEJRiEPYtahIvSCtT3xgUGUmU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-8WwqpJQRMMC-Y1cHcAnhdA-1; Mon, 22 Jan 2024 07:39:17 -0500
X-MC-Unique: 8WwqpJQRMMC-Y1cHcAnhdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CE6688D286;
	Mon, 22 Jan 2024 12:39:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E7049C0FDCC;
	Mon, 22 Jan 2024 12:39:13 +0000 (UTC)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 09/10] afs: Remove afs_dynroot_d_revalidate() as it is redundant
Date: Mon, 22 Jan 2024 12:38:42 +0000
Message-ID: <20240122123845.3822570-10-dhowells@redhat.com>
In-Reply-To: <20240122123845.3822570-1-dhowells@redhat.com>
References: <20240122123845.3822570-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Remove afs_dynroot_d_revalidate() as it is redundant as all it does is
return 1 and the caller assumes that if the op is not given.

Suggested-by: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dynroot.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index d3bc4a2d7085..c4d2711e20ad 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -258,16 +258,7 @@ const struct inode_operations afs_dynroot_inode_operations = {
 	.lookup		= afs_dynroot_lookup,
 };
 
-/*
- * Dirs in the dynamic root don't need revalidation.
- */
-static int afs_dynroot_d_revalidate(struct dentry *dentry, unsigned int flags)
-{
-	return 1;
-}
-
 const struct dentry_operations afs_dynroot_dentry_operations = {
-	.d_revalidate	= afs_dynroot_d_revalidate,
 	.d_delete	= always_delete_dentry,
 	.d_release	= afs_d_release,
 	.d_automount	= afs_d_automount,


