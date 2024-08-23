Return-Path: <linux-fsdevel+bounces-26927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA9595D2D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877D0286A26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53604193070;
	Fri, 23 Aug 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pzxv2XtO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34548192B89
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429565; cv=none; b=MRx0gN6TYdGsU8UOPOTu3THqPPdKmez9XJjiV3n8UaUMEDBt9n9iiwFPN10L1cx60I+LpQ732shxLlzmf8PvqYyZR+RJ2lUarURl2c6kk7Lz57xLscm8D46+5LEJ/o+hK4bcOKg9odq8Ohjj0Xxl4i7m9u/5bbQ8/sXllOPjMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429565; c=relaxed/simple;
	bh=580hFqprR8ZFI5WWkFW4PKJxwZHdomHT+uVT2jWzm8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bv1htaTdl0M1ihVgKToNkfdu74KpMD+Yk3W2hzhRRAP/xGhdUn/uT8rCbK0I6I65/I/FOz63DYLNzVJv6KZaJyGCHUhDwjNJlKia44uKYXYCxAX9VZmiMvBll7QjgEHAfNRuk8o0qV1Vh0M1Yb+DfY/vF99grKbYUSTiKTl2feU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pzxv2XtO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724429563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF1dQkOHc38/CxHdvA+HTnp1kknbAHEKTFkwj9qcOQo=;
	b=Pzxv2XtOas/YNXwixAGB04IyB6qvPd6K+nXK+9J8n7XLInXJARr7WFk83jPrkUE7BFycX3
	PW5ffrmBc8UBi9yZjj17hn255xmw4eS3VWIWjFp6RQnKvAnLMcSk3jaQpTwz14t5No/vA0
	rKNl0IWU6Ai2+SK8+f3y230S7R/Oy1Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-8smGqBV2N5OacPwQdgxAmQ-1; Fri,
 23 Aug 2024 12:12:39 -0400
X-MC-Unique: 8smGqBV2N5OacPwQdgxAmQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 571C51955D4E;
	Fri, 23 Aug 2024 16:12:36 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11C6819560AA;
	Fri, 23 Aug 2024 16:12:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
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
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 3/5] netfs: Fix missing iterator reset on retry of short read
Date: Fri, 23 Aug 2024 17:12:04 +0100
Message-ID: <20240823161209.434705-4-dhowells@redhat.com>
In-Reply-To: <20240823161209.434705-1-dhowells@redhat.com>
References: <20240823161209.434705-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fix netfs_rreq_perform_resubmissions() to reset before retrying a short
read, otherwise the wrong part of the output buffer will be used.

Fixes: 92b6cc5d1e7c ("netfs: Add iov_iters to (sub)requests to describe various buffers")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 605b667fe3a6..d6ada4eba744 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -315,6 +315,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 			netfs_read_from_server(rreq, subreq);
 		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
 			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
+			netfs_reset_subreq_iter(rreq, subreq);
 			netfs_rreq_short_read(rreq, subreq);
 		}
 	}


