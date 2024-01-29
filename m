Return-Path: <linux-fsdevel+bounces-9362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EE584045C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96761C203DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA13604C8;
	Mon, 29 Jan 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDpNoWOL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E35D8F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529329; cv=none; b=RYafgwE7EoDXXxPgIwhlEbxmqJ4pBpYDW7wyK4j/RmIXf3gqGqMIKTuHaM0vf8WQ8XtjJ/n4Y0xYPCDzwfdUdu5vNgGyFFfqpRWKJq3Wc9AmeBxt9faEjuEKq9mTPpH959nPToweAX5zuGPt9JFbDXTyMHicJ3q+8X8bel9RwMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529329; c=relaxed/simple;
	bh=AnzxcJj9wjtJkMYs3W/gQlln1rYbehXjbzJ6iBM9txw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUyU+RHvCfqgcF1fBSUAKW5dluLX32aRDYIpt9amZsKJ9Q9SCBJ1TgI+UcWWomPt4Y54okssyieM2NZc39d+BH0xs07wES3KK+S/duavR/JfAQzl1tF02Mlj7odcYiUIo9N5oKBE2jso0c3YnOPoASeRTtLNvvEYc9nS06J8b0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDpNoWOL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706529326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFEwBUvtYUzBE87TzSBBZpD+94Lt4ih08V10OQ70ATs=;
	b=IDpNoWOLZUhjudJ1XlAmFSqU/hnb906p8eqbJL9l31HRLC8mok8zDljTFDMY7aMMGIV2qw
	e6OFwiGvuwecregPXIA4WL8Dm93IDRnt44bmnD0JBvhGjC79ObB3FVB2dsMAgn29NBX0Xl
	25h2ZKaori+AWZ6IPlewB6IC9nGqoKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-3fM3ZQmaN2O0NeesbjZpxw-1; Mon, 29 Jan 2024 06:55:21 -0500
X-MC-Unique: 3fM3ZQmaN2O0NeesbjZpxw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FC87185A780;
	Mon, 29 Jan 2024 11:55:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C99E4492BC6;
	Mon, 29 Jan 2024 11:55:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Cc: David Howells <dhowells@redhat.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] 9p: Enable large folio support
Date: Mon, 29 Jan 2024 11:54:35 +0000
Message-ID: <20240129115512.1281624-2-dhowells@redhat.com>
In-Reply-To: <20240129115512.1281624-1-dhowells@redhat.com>
References: <20240129115512.1281624-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: Dominique Martinet <asmadeus@codewreck.org>

Enable large folio support in 9P now that the VM/VFS data I/O interface is
handled through netfslib.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
---
 fs/9p/vfs_inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 32572982f72e..ca9f504b9daf 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -262,6 +262,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 	inode->i_rdev = rdev;
 	simple_inode_init_ts(inode);
 	inode->i_mapping->a_ops = &v9fs_addr_operations;
+	mapping_set_large_folios(inode->i_mapping);
 	inode->i_private = NULL;
 
 	switch (mode & S_IFMT) {


