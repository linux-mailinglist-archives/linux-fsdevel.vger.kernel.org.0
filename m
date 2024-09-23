Return-Path: <linux-fsdevel+bounces-29855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C259A97EDB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32AC1C213B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F2B19F40A;
	Mon, 23 Sep 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0gcPpT5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB21119F122
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104128; cv=none; b=l+tLVFh0eXXSszUrYBiIUoJ1v0EG0exdwSHMT9Hqh26k/v7N6LBwcwGWcLhOBpy9XQT/tIrDwicL2XfHzVfYGa1f7Pe1LzvfEd9b/S5zHUQGdjdYcdxHJxY07sDWbJsGrkerDR1YNM5ZK0glCZOL84jVS6ZRUXVDlojLW3nCij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104128; c=relaxed/simple;
	bh=piXuVnAJq0Ja06sMKcORgtwIhID/qYO+WgQAvFaFwqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxV5HygjVnLr2navG7Asxsl+kooJ+8pH4mFXIIQO4qr2ABuWXoHbaitrxPuc/S38lYxaVfzMZ9g3NHzY8ghm0ZNNQymgvn1CErjFAS56OaQj5AkmLscSl/nXHVWJYO5MAJuH9dIkh+o0y9P/Z+Sa5nMZV60bzrbIiW+sudkvI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0gcPpT5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHIPIQ0jqmx06tKWg5zwKCYYjtifDx3/S1TSTB/jDJ4=;
	b=L0gcPpT5ABauBb/ZpiAyj0ZBd0LbLpGD76vJeyWGztDODsI1jcpXJZcfRwW94N3dlpOu4x
	pxbwskfLuMIFSQnOM892S5OJyvZdFQaF4hjBgDSl6RT/6o/Tbob6PiyITsgdvaLj2vZHt6
	i/1Seh4UcIYXaj8CBFjSX5Bm00ftnqQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-n60o72YoO8em_juxYjNDxw-1; Mon,
 23 Sep 2024 11:08:42 -0400
X-MC-Unique: n60o72YoO8em_juxYjNDxw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 633B218B6A33;
	Mon, 23 Sep 2024 15:08:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2387B190AABA;
	Mon, 23 Sep 2024 15:08:24 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
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
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 4/8] afs: Remove unused struct and function prototype
Date: Mon, 23 Sep 2024 16:07:48 +0100
Message-ID: <20240923150756.902363-5-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Thorsten Blum <thorsten.blum@toblux.com>

The struct afs_address_list and the function prototype
afs_put_address_list() are not used anymore and can be removed. Remove
them.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240911095046.3749-2-thorsten.blum@toblux.com/
---
 fs/afs/afs_vl.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/afs/afs_vl.h b/fs/afs/afs_vl.h
index 9c65ffb8a523..a06296c8827d 100644
--- a/fs/afs/afs_vl.h
+++ b/fs/afs/afs_vl.h
@@ -134,13 +134,4 @@ struct afs_uvldbentry__xdr {
 	__be32			spares9;
 };
 
-struct afs_address_list {
-	refcount_t		usage;
-	unsigned int		version;
-	unsigned int		nr_addrs;
-	struct sockaddr_rxrpc	addrs[];
-};
-
-extern void afs_put_address_list(struct afs_address_list *alist);
-
 #endif /* AFS_VL_H */


