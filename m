Return-Path: <linux-fsdevel+bounces-24005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D19C9378F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 16:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85686B2102F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D071448F6;
	Fri, 19 Jul 2024 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdHGF21G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9D144317
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398173; cv=none; b=Ev7ozvsnPjQETHhYjF1/AQuici+pkuJTH3uFD5rs7Ns+iU+mRzvGs2dbTBsI7VgZ2oWk8nENkY2/GChynzxbq+vp31QtP5qye1EDYhHbRPs0NoK1XW5e1ivZu6iBh6+kbpLFnIPn3k2D5utOzcRfbxJtoccQsTs8GhpT0BFm57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398173; c=relaxed/simple;
	bh=gIlaJxWKHD27MPHhmQi5msnbVx2ypREkMJlqiu1ikrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yj3tdyu8K5D4hS0C5qKi1NtO1fpSEErqqhFCT9B4tmtlaTLowehCPdAGrBfvaKUGlKgf13QfXz+mvHP6BdIzjGXlxtC2UAk9ZHGJ0uinGhzXvTn3CcDVlHBiTtNPa/i2CPbHN5qlNSPPWdQ/RGgBqpONp3Fa5TpUJHq05AI6roM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdHGF21G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721398170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJ4DHXfd4Cg3o7za/FkNScfmghlF4ggW8W3YVfedUjc=;
	b=HdHGF21GALTTOXfMGOixJITctucA3fzZ6uUqXoZQ3X0A/mKOgBMUFelDfmJ2VUN+JsuyAK
	kosyGjx3VJvrx1cx7CwuNShYN6KTGNWncWMRj8oUVCB6/3OqyTtI28+ogL7NmjHLZPZxC5
	8XiA59OgWEr0WL15UIOMATCgMpzvK6E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-V7ZKtkQ7OdGCMUe-vhab4A-1; Fri,
 19 Jul 2024 10:09:27 -0400
X-MC-Unique: V7ZKtkQ7OdGCMUe-vhab4A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB41E1955D4B;
	Fri, 19 Jul 2024 14:09:25 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A197195605A;
	Fri, 19 Jul 2024 14:09:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: [PATCH 3/4] cifs: Fix setting of zero_point after DIO write
Date: Fri, 19 Jul 2024 15:09:03 +0100
Message-ID: <20240719140907.1598372-4-dhowells@redhat.com>
In-Reply-To: <20240719140907.1598372-1-dhowells@redhat.com>
References: <20240719140907.1598372-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

At the moment, at the end of a DIO write, cifs calls netfs_resize_file() to
adjust the size of the file if it needs it.  This will reduce the
zero_point (the point above which we assume a read will just return zeros)
if it's more than the new i_size, but won't increase it.

With DIO writes, however, we definitely want to increase it as we have
clobbered the local pagecache and then written some data that's not
available locally.

Fix cifs to make the zero_point above the end of a DIO or unbuffered write.

This fixes corruption seen occasionally with the generic/708 xfs-test.  In
that case, the read-back of some of the written data is being
short-circuited and replaced with zeroes.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Reported-by: Steve French <sfrench@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/file.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 6178c6d8097d..72cc265bc471 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2358,13 +2358,18 @@ void cifs_write_subrequest_terminated(struct cifs_io_subrequest *wdata, ssize_t
 				      bool was_async)
 {
 	struct netfs_io_request *wreq = wdata->rreq;
-	loff_t new_server_eof;
+	struct netfs_inode *ictx = netfs_inode(wreq->inode);
+	loff_t wrend;
 
 	if (result > 0) {
-		new_server_eof = wdata->subreq.start + wdata->subreq.transferred + result;
-
-		if (new_server_eof > netfs_inode(wreq->inode)->remote_i_size)
-			netfs_resize_file(netfs_inode(wreq->inode), new_server_eof, true);
+		wrend = wdata->subreq.start + wdata->subreq.transferred + result;
+
+		if (wrend > ictx->zero_point &&
+		    (wdata->rreq->origin == NETFS_UNBUFFERED_WRITE ||
+		     wdata->rreq->origin == NETFS_DIO_WRITE))
+			ictx->zero_point = wrend;
+		if (wrend > ictx->remote_i_size)
+			netfs_resize_file(ictx, wrend, true);
 	}
 
 	netfs_write_subrequest_terminated(&wdata->subreq, result, was_async);


