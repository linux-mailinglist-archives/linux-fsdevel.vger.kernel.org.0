Return-Path: <linux-fsdevel+bounces-32128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12C09A0FAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 18:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540F21F2888C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2021019D;
	Wed, 16 Oct 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RX2G9AaP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208516BE39
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096124; cv=none; b=M3GZ2Xrv0EO5gLbek5v4GIO7VVSO2FCB3Pb2mi8ecsTKjZe25B7JpZOE9Cy1aYiTURYvF+qFGirXdnER1LkE+ImYJ0jlJFw0Q0Y+qA3SK3IHwvHZ+qVIrpQihev4NH2PkWyV3V7+h1e0glHX4p/hZLty8+zTS7Fv1FzO3G4/TPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096124; c=relaxed/simple;
	bh=l8A3AThTq+ezAyEa6ZdEacg08ACdKh98w19rNnepIiU=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=YpvB7ke5F9g5PO+zhzJQfFJYGywmXWyEOcY07bKbo5jgHZGrtrfFIUFsvfeB+kH9t00P5EKtCKmK2hg7Q+DTjKCENgov3ucUjak6VQSm43zJNInVxxvQ1FfCE0cQmovdDKQFCjIuChDIj+SH2sjNo/XWbQTx5IWf1mA+G2sZL2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RX2G9AaP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729096122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=73sRhC/MVUgLr8wQOAXRbG/9ryOP4YoRdbzww8lNz4M=;
	b=RX2G9AaP3lA/+lLaP0MSAesWjNzVzi9TNY7UQEebiyBlf72Kzz/Oprcz6CM47irMzQdjMv
	YlF4lxUqqyhlNyatqBxHbO6mowr1zSdPEiQN2Px0KnNlIbe08JMhVnW6OCOcBrG256tffT
	gacpLXQjWwCw0rO2oA6G3GXOh3xcjmk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-acA3QZC1NvWB9lBdONbJig-1; Wed,
 16 Oct 2024 12:28:39 -0400
X-MC-Unique: acA3QZC1NvWB9lBdONbJig-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0BC619560A1;
	Wed, 16 Oct 2024 16:28:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.218])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02B621956086;
	Wed, 16 Oct 2024 16:28:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
    Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Trond Myklebust <trondmy@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Downgrade i_rwsem for a buffered write
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1317957.1729096113.1@warthog.procyon.org.uk>
Date: Wed, 16 Oct 2024 17:28:33 +0100
Message-ID: <1317958.1729096113@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

In the I/O locking code borrowed from NFS into netfslib, i_rwsem is held
locked across a buffered write - but this causes a performance regression
in cifs as it excludes buffered reads for the duration (cifs didn't use any
locking for buffered reads).

Mitigate this somewhat by downgrading the i_rwsem to a read lock across the
buffered write.  This at least allows parallel reads to occur whilst
excluding other writes, DIO, truncate and setattr.

Note that this shouldn't be a problem for a buffered write as a read
through an mmap can circumvent i_rwsem anyway.

Also note that we might want to make this change in NFS also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Trond Myklebust <trondmy@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/locking.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/locking.c b/fs/netfs/locking.c
index 21eab56ee2f9..2249ecd09d0a 100644
--- a/fs/netfs/locking.c
+++ b/fs/netfs/locking.c
@@ -109,6 +109,7 @@ int netfs_start_io_write(struct inode *inode)
 		up_write(&inode->i_rwsem);
 		return -ERESTARTSYS;
 	}
+	downgrade_write(&inode->i_rwsem);
 	return 0;
 }
 EXPORT_SYMBOL(netfs_start_io_write);
@@ -123,7 +124,7 @@ EXPORT_SYMBOL(netfs_start_io_write);
 void netfs_end_io_write(struct inode *inode)
 	__releases(inode->i_rwsem)
 {
-	up_write(&inode->i_rwsem);
+	up_read(&inode->i_rwsem);
 }
 EXPORT_SYMBOL(netfs_end_io_write);
 


