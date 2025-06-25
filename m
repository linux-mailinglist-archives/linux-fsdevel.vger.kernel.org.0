Return-Path: <linux-fsdevel+bounces-52941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D3AE8A79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5546804A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF32E3393;
	Wed, 25 Jun 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRne2fcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179E2E0B7F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869782; cv=none; b=drNpf0chYnJKGKp8+xEDVriM34gM/1VU76SoH8+cLCqDFBcN9RWiFLehCYf8/6nmHrHf0AP6AlSlCoKnMkGiPgtkhLLxcypSZe2dOwIkPNZaJtOoDJ5zJThqfxeRc3VIOCV+0ejys+2nDGVWQNftA/xhR6zbgU6y+BnwNYqb2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869782; c=relaxed/simple;
	bh=zttpQsblGMp7z07jk1lN8v6oW9ojloS7/vENaMxLw5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0i7jWXGtwhCFkBJK9kKJwWKDn2wyMqX6oANjiyZ9nFHEWUJuoaThY2xC8DBc1lYZrYRYa6U57/yl4M+QTBwo9afay62/BlO3fum5xqSjKvDJH04iCvKsbJJGX1JpadSOHIi4XxBQk7bxd7LpouGozFE8eF95mQa1ZY0Gg4RPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRne2fcG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750869779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAkDWqWictGqLE9t+71XFB8sKg+zbKHb8YN2JrhliGE=;
	b=CRne2fcGcnUrrZNmJqjJLOYEGKk2fixyiugo5+rDTYjT6CPL214hFP5wzxvRrS/rYAiM69
	TfLdlqwMrwZJ7KABiSARmBweDziQviYPqp3V27VPspYph77Z+AXF4hgmoP/tr1Ed71yQW8
	8mOOsqT60o6BQnevvMtItuAKro6j1U4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-NgOqbqqsPT2t9PVpHtDdag-1; Wed,
 25 Jun 2025 12:42:56 -0400
X-MC-Unique: NgOqbqqsPT2t9PVpHtDdag-1
X-Mimecast-MFC-AGG-ID: NgOqbqqsPT2t9PVpHtDdag_1750869774
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D6A41800287;
	Wed, 25 Jun 2025 16:42:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC15219560A3;
	Wed, 25 Jun 2025 16:42:44 +0000 (UTC)
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
Subject: [PATCH v2 05/16] netfs: Fix ref leak on inserted extra subreq in write retry
Date: Wed, 25 Jun 2025 17:42:00 +0100
Message-ID: <20250625164213.1408754-6-dhowells@redhat.com>
In-Reply-To: <20250625164213.1408754-1-dhowells@redhat.com>
References: <20250625164213.1408754-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


