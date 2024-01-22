Return-Path: <linux-fsdevel+bounces-8490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DAD837646
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 23:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82D82862DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 22:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986284A9B1;
	Mon, 22 Jan 2024 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIusVaAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501C495F1
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962774; cv=none; b=XdJv4Y2hw0/MUrGEYH3n2bSjyeVH3rkbBwUjeYXBV3NeSO4IxNl9i6FAUnLnJON91dtVJ2cz5jUrCJHX12n/2LuY258VZLiqUpbfR/WqgSHSMExAkcvFXsdFQK7fony1C2rNFBMeMu2wh4cSYcYxHAN/eqNnGe3M7W0LI0avdic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962774; c=relaxed/simple;
	bh=Qn7dd9HK9v0F1KFFIftRsyM5xQPDc6YGUH7hJwsGprs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLQ9xTYNPa9zv3g8vcGPPK3rdfEJ5doBWp0AqJlIF5LMzmwa4/cp/u9VrKbHwUtUij/sfCcXAn3EiRINeNeKiYAqkF+94nRFQ7wylAU8Whigzqec37v8LCejpaGCoX1JwtVGA32eb0v8BDumvCVR+h3LXhDAEzIP8bCEAl68cQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hIusVaAI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705962771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTDK7i2Q4hPQnzfb2SdByLYJyeMyokMSiVdAUDeKcK0=;
	b=hIusVaAItMpqSk2euRjzOS670x1BBqvyAXUS1n3Pugao+Mc2ThLCETgd2Di2AK2zsTl8th
	DTEfywQzCNhjPLgbVXhaeiHkFqK+RZ7ObBBatLmTLZwTgcDXtGgufwvYTPChPk4txIgv3G
	xKEacD9FTDkQa1Gs9+Ud8aIQAVMgdtI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-Qkey4K3HML2HB-kO-l1Q7Q-1; Mon,
 22 Jan 2024 17:32:48 -0500
X-MC-Unique: Qkey4K3HML2HB-kO-l1Q7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A62011C0418A;
	Mon, 22 Jan 2024 22:32:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 80C1F1C060B1;
	Mon, 22 Jan 2024 22:32:45 +0000 (UTC)
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
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 05/10] netfs: Fix a NULL vs IS_ERR() check in netfs_perform_write()
Date: Mon, 22 Jan 2024 22:32:18 +0000
Message-ID: <20240122223230.4000595-6-dhowells@redhat.com>
In-Reply-To: <20240122223230.4000595-1-dhowells@redhat.com>
References: <20240122223230.4000595-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

From: Dan Carpenter <dan.carpenter@linaro.org>

The netfs_grab_folio_for_write() function doesn't return NULL, it returns
error pointers.  Update the check accordingly.

Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for buffered write")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/29fb1310-8e2d-47ba-b68d-40354eb7b896@moroto.mountain/
---
 fs/netfs/buffered_write.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index e7f9ba6fb16b..a3059b3168fd 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -221,10 +221,11 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		if (unlikely(fault_in_iov_iter_readable(iter, part) == part))
 			break;
 
-		ret = -ENOMEM;
 		folio = netfs_grab_folio_for_write(mapping, pos, part);
-		if (!folio)
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
 			break;
+		}
 
 		flen = folio_size(folio);
 		offset = pos & (flen - 1);


