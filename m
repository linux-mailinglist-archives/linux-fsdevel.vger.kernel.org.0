Return-Path: <linux-fsdevel+bounces-8425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FFD83637D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 13:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CED21F27353
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC6C3D982;
	Mon, 22 Jan 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa05kvtt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075F3D55F
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927150; cv=none; b=Yo5lcFZ2FqfACRJrCYDVWD9rAsTplfCE5iRoyWHh1q0E6VkkEr6Lk9toLrIFiFnx48Q0jyYHD9TOHnC9LYOTsmzGhggGVFF+WMaKerFTUpyazMNIpXkBaY5NgYtRlmn1x93JZihILr4segzcKsMDUF6lKe/W2GvI3ajw4FaLoSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927150; c=relaxed/simple;
	bh=OfIzfUBOegY/aA+DNYcmnKkvNEOiMv9jvlr290zr5sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5rHKAhRWOyk40I1b9beQ7JzDV04vB4RumQa4W+7gcRC7NYkKEVRHs6Bw/VTmeeurxEwbvvfySiE0KyPiT956zD5bqMsKOgI0nWC1O5faWd33gir4DRFOLlc/q+T4GX3NJbZIoXlzmVF3/sJi3c/18cgutbD2xBdQEcl3GkOo8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aa05kvtt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705927147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CJ3I/7LDGs8hexTud6zRTfvlS0atGDHH81M3ADEHcQ=;
	b=aa05kvtt3HsTXHgovh9UtJ8kY/gRoDeW3PRBhkPLmL/HDWEN3FasUoBg78tnCGeJxNb5LY
	MU8fyureIawjyzoVd7nLqdTkSOixUvViX4RUS8rMRnGEld03yMoKrKzZfdtdi64KQNYCZM
	hpeT65/vk8E0huiGp3slLgBlt6GvxKo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-IYJ33U9IOce8J_5Yad4F5w-1; Mon, 22 Jan 2024 07:39:03 -0500
X-MC-Unique: IYJ33U9IOce8J_5Yad4F5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6003885A58B;
	Mon, 22 Jan 2024 12:39:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7DE802026D66;
	Mon, 22 Jan 2024 12:39:00 +0000 (UTC)
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
Subject: [PATCH 04/10] netfs, fscache: Prevent Oops in fscache_put_cache()
Date: Mon, 22 Jan 2024 12:38:37 +0000
Message-ID: <20240122123845.3822570-5-dhowells@redhat.com>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

This function dereferences "cache" and then checks if it's
IS_ERR_OR_NULL().  Check first, then dereference.

Fixes: 9549332df4ed ("fscache: Implement cache registration")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/e84bc740-3502-4f16-982a-a40d5676615c@moroto.mountain/ # v2
---
 fs/netfs/fscache_cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index d645f8b302a2..9397ed39b0b4 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -179,13 +179,14 @@ EXPORT_SYMBOL(fscache_acquire_cache);
 void fscache_put_cache(struct fscache_cache *cache,
 		       enum fscache_cache_trace where)
 {
-	unsigned int debug_id = cache->debug_id;
+	unsigned int debug_id;
 	bool zero;
 	int ref;
 
 	if (IS_ERR_OR_NULL(cache))
 		return;
 
+	debug_id = cache->debug_id;
 	zero = __refcount_dec_and_test(&cache->ref, &ref);
 	trace_fscache_cache(debug_id, ref - 1, where);
 


