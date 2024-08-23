Return-Path: <linux-fsdevel+bounces-26996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B98195D799
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 22:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61CB5B24589
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E006219FA8C;
	Fri, 23 Aug 2024 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeDeQaUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5519FA86
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443773; cv=none; b=KfXgR/OKqECbFe1jrKzfUBj669V3CASRpLPzCRrBynx4xHHEPSbvuJT4uJIje8QWuLqy98Dd+BWRMd1Pk+1CGN/LxaBXYv8TcmuBvrYtTBHZqPWdVMPA6XqEHGZMqDLaVP8VT1fB8ElriP/KV+9r7O4KsN2BrwNQDsJVuYTA0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443773; c=relaxed/simple;
	bh=urr6E/8rF5Ax2jrUKfHT3GcC6Ya417D3++tj8xbY6gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9mCQfiqWvw4uQFq98kmYStRPQqFUo0IvdGkMti0lQrkW17zJagX0WTEskQy3lrC16ckPPy3B7voEm+4BRmEz/J2up3miJp+ZKn4NwUc82/hmUycfcmC+T7kk3wfylD5Q2cL/TfeVqaYt3kWQJTDygI3Mj1DypnMSiPdL2LwNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeDeQaUh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAmCIU0bJDpl8o1iuVK4ffMXJRGL1l5OGSxq2KqoTWQ=;
	b=IeDeQaUhi2sStu4lfSqaPJmBw2UHbVVViNTfeY6LGuUvNQVfXRERDvB3jrhSP7t9OT9Ziu
	51PYWkIiRnrTgyEvxm0v0uWU+0wYrU4oOA25qVwD+i8rynNhT4iksNklyubNqzUMn8omwW
	UXf4/W8flbvy1c6d07u3lwffdTX98DI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-Dvwmp2x-PPyrCItiYsUPfQ-1; Fri,
 23 Aug 2024 16:09:29 -0400
X-MC-Unique: Dvwmp2x-PPyrCItiYsUPfQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AD3B19560B7;
	Fri, 23 Aug 2024 20:09:27 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDBE11956053;
	Fri, 23 Aug 2024 20:09:17 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Paulo Alcantara <pc@manguebit.com>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] netfs, cifs: Improve some debugging bits
Date: Fri, 23 Aug 2024 21:08:17 +0100
Message-ID: <20240823200819.532106-10-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Improve some debugging bits:

 (1) The netfslib _debug() macro doesn't need a newline in its format
     string.

 (2) Display the request debug ID and subrequest index in messages emitted
     in smb2_adjust_credits() to make it easier to reference in traces.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/io.c           | 2 +-
 fs/smb/client/smb2ops.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 943128507af5..d6ada4eba744 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -270,7 +270,7 @@ static void netfs_reset_subreq_iter(struct netfs_io_request *rreq,
 	if (count == remaining)
 		return;
 
-	_debug("R=%08x[%u] ITER RESUB-MISMATCH %zx != %zx-%zx-%llx %x\n",
+	_debug("R=%08x[%u] ITER RESUB-MISMATCH %zx != %zx-%zx-%llx %x",
 	       rreq->debug_id, subreq->debug_index,
 	       iov_iter_count(&subreq->io_iter), subreq->transferred,
 	       subreq->len, rreq->i_size,
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 8fb68c47c218..2741f7d63fe7 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -316,7 +316,8 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 				      cifs_trace_rw_credits_no_adjust_up);
 		trace_smb3_too_many_credits(server->CurrentMid,
 				server->conn_id, server->hostname, 0, credits->value - new_val, 0);
-		cifs_server_dbg(VFS, "request has less credits (%d) than required (%d)",
+		cifs_server_dbg(VFS, "R=%x[%x] request has less credits (%d) than required (%d)",
+				subreq->rreq->debug_id, subreq->subreq.debug_index,
 				credits->value, new_val);
 
 		return -EOPNOTSUPP;
@@ -338,8 +339,9 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		trace_smb3_reconnect_detected(server->CurrentMid,
 			server->conn_id, server->hostname, scredits,
 			credits->value - new_val, in_flight);
-		cifs_server_dbg(VFS, "trying to return %d credits to old session\n",
-			 credits->value - new_val);
+		cifs_server_dbg(VFS, "R=%x[%x] trying to return %d credits to old session\n",
+				subreq->rreq->debug_id, subreq->subreq.debug_index,
+				credits->value - new_val);
 		return -EAGAIN;
 	}
 


