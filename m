Return-Path: <linux-fsdevel+bounces-52554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99D9AE411F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514BA3A5E1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F339253B7A;
	Mon, 23 Jun 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJ1Sz3D3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3C25392C
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682958; cv=none; b=QKshY/xY1fToQjtcbphPKC3l1ESIbcdGyStXgbWioafZ1Qkh8jzfKf0BD8SPqtQFwxIvWqrGubk7qy5r39mcZGYnoyOjH4WtqN2XzgxzTvusbOo9DYKqD+bGaBfqJ9nqq67Fz+YSfUsCGsBrQ00x1C6s0Tyg+uAPDPYLkn9CFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682958; c=relaxed/simple;
	bh=zttpQsblGMp7z07jk1lN8v6oW9ojloS7/vENaMxLw5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCSx+tOuj1t+MuqKb4V7/hiNTLGlVn1nDBiVQTg58/gheqeXr3n1RFQ98PQUw+X6NxnmMxll+Ynq6IunrnyKg7IfRQXjbAywnkZBtCCdNt53s9V1ORYQBkMDefPsLCx6s+Q8wo75tp9BM3EK+p9G1jLQ9G1U1d6Y55rrRu2qJho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJ1Sz3D3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750682954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAkDWqWictGqLE9t+71XFB8sKg+zbKHb8YN2JrhliGE=;
	b=VJ1Sz3D33inpROAfmhnrtlV10IH9o54mdQjU/Q6BmL9gGPAqfvUYcGh6bd1KP5EE0WPUK+
	+OSiuVkvbbyBysWjJ8ByRDrwlrAmtAokdVhIY0BLXV91AdO6hQUPBRnzb4r5fqXjEhs+pe
	AwtK0GUdlvhI3pqPDok44F5BJy08eIY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-2SGQBkdxOt-n-7M3CZ5wKQ-1; Mon,
 23 Jun 2025 08:49:13 -0400
X-MC-Unique: 2SGQBkdxOt-n-7M3CZ5wKQ-1
X-Mimecast-MFC-AGG-ID: 2SGQBkdxOt-n-7M3CZ5wKQ_1750682950
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B760C19560AE;
	Mon, 23 Jun 2025 12:49:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 133FF195608D;
	Mon, 23 Jun 2025 12:49:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 05/11] netfs: Fix ref leak on inserted extra subreq in write retry
Date: Mon, 23 Jun 2025 13:48:25 +0100
Message-ID: <20250623124835.1106414-6-dhowells@redhat.com>
In-Reply-To: <20250623124835.1106414-1-dhowells@redhat.com>
References: <20250623124835.1106414-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The write-retry algorithm will insert extra subrequests into the list if it
can't get sufficient capacity to split the range that needs to be retried
into the sequence of subrequests it currently has (for instance, if the
cifs credit pool has fewer credits available than it did when the range was
originally divided).

However, the allocator furnishes each new subreq with 2 refs and then
another is added for resubmission, causing one to be leaked.

Fix this by replacing the ref-getting line with a neutral trace line.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_retry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 9d1d8a8bab72..7158657061e9 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -153,7 +153,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
 					     refcount_read(&subreq->ref),
 					     netfs_sreq_trace_new);
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_split);
 
 			list_add(&subreq->rreq_link, &to->rreq_link);
 			to = list_next_entry(to, rreq_link);


