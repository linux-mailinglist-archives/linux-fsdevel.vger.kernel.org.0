Return-Path: <linux-fsdevel+bounces-9361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E207840458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BF2281F66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1A75F849;
	Mon, 29 Jan 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igw5lcxN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ADA4F1E7
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529325; cv=none; b=C8QMmq62KpEpvEspghX6946k1dS5BXnv23vOcSRWSYWafECQngKupapkG5KQdWF5BARdjIQ6tfLXJ69adquXgvt1A6kFvg55tJlsDk3Qm4vRJRz7ArS9Bd20GD28f+h7CishNB/8ROtXfZGCB+JVUeAwxQuZ37AdeUNhfqyEMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529325; c=relaxed/simple;
	bh=PMrkwWNf0Ov30HBPXASH7CkKvXggMgrqzxgN3NrV/VY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BO/TisX3sPy0CTvnYQkmT7XHZ9EypvllhZyFmc09tcwA2NydYZJbn8FliBN+vL5tMWQKrkeYisqm1aWRauQnihsKJZoL5MbZ7u0E5sNF5VURE0tVzStKPGaqCkVp+HxSn6BL0pYfigKBxPLroan7haImsSr85H7kCq0WwWXPNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igw5lcxN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706529322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ywApO59Mwrb0F3WdOnI+RuaKXV32Yr1moSFyFDBVZS8=;
	b=igw5lcxNsqD6Reidyq514XVVxx81MmjwXO9T0D4DlkNsE/q8GDAfL+ZGA1grw5sC05jtbV
	uvP4BI8q2KoAvuet/F+xvEyqflj7HTJGn9uugSY+fGLkIFWwROjiMDvrcYM8ZVeg/aJ3j7
	Bdinq8qYFVUbrxooxmV4xFUnyVTTpg0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-_hvLZoDIM-y0hjc_RyKfow-1; Mon,
 29 Jan 2024 06:55:18 -0500
X-MC-Unique: _hvLZoDIM-y0hjc_RyKfow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 348C929AA3AC;
	Mon, 29 Jan 2024 11:55:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 967671121306;
	Mon, 29 Jan 2024 11:55:16 +0000 (UTC)
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
Subject: [RFC PATCH 0/3] 9p: Further netfslib-related changes
Date: Mon, 29 Jan 2024 11:54:34 +0000
Message-ID: <20240129115512.1281624-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi Eric, Dominique,

Here are some netfslib-related changes we might want to consider applying
to 9p:

 (1) Enable large folio support for 9p.  This is handled entirely by
     netfslib and is already supported in afs.  I wonder if we should limit
     the maximum folio size to 1MiB to match the maximum I/O size in the 9p
     protocol.

 (2) Make better use of netfslib's writethrough caching support by not
     disabling caching for O_DSYNC.  netfs_perform_write() will set up
     and dispatch write requests as it copies data into the pagecache.

 (3) Always update netfs_inode::remote_size to reflect what we think the
     server's idea of the file size is.  This is separate from
     inode::i_size which is our idea of what it should be if all of our
     outstanding dirty data is committed.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-9p

Thanks,
David

David Howells (2):
  9p: Make better use of netfslib's writethrough caching
  9p: Always update remote_i_size in stat2inode

Dominique Martinet (1):
  9p: Enable large folio support

 fs/9p/fid.h            | 3 +--
 fs/9p/vfs_inode.c      | 1 +
 fs/9p/vfs_inode_dotl.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)


