Return-Path: <linux-fsdevel+bounces-62709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE5B9E65A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 11:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26DC94E2E12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3432EA729;
	Thu, 25 Sep 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GprGV2PL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478B2DE1F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792749; cv=none; b=DByAG3Twv3XETLrrxQwhIGFl2M2CGryscZWHGJLKAfzh6NjRr6ba+AZFXEkxPFDZQEpDO7eUCWuKnZiyJh7kFcVpq39Q/KA4U/A1ggxaq4+oAABJe3yR8aS+uVv9hCXcSBJyhqLKjDFOgsPkKYV5jS/W2kMQngXXD3mrmpD0iYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792749; c=relaxed/simple;
	bh=w+wRGkfFlefiHe2vuSI0+027BGk8IAf2LG/faqW14R0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ixk6are9vQN7xWQxRkMCIi+pRnCs0sG7hpDV9Nv9DHvw5jWSzztG/ahgYwzDGbSonDN0AzW0aloV4kS7XQ1XrxXdiu5LsENSKenuSIvTmlnwgpwcrqAJH1wFpVl24IxT85TtEhusyowcXqME7S4E7eJEc8ap09D58D3tJ9QrhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GprGV2PL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758792746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpA/mPguId3ShnwfmaxNMYxpZ21uSeZf1okIs7+WTaQ=;
	b=GprGV2PLdc4xhKwHP+m+srUtE1kNWcYYZbfovXntb6mQjs8m+43a0lPR1geRGQh9CZFWfM
	WGPiNJjh/7qtUyVS36ySg0PuUdnwzgWjyTQbDECODrl8YmijEo/sTdcwWsl0NAzGP01NrR
	A20xRA4XNmRJ/NxW1VpYs40hAfdcgJk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-X-La797lPx-ltAEHxjmL-w-1; Thu,
 25 Sep 2025 05:32:21 -0400
X-MC-Unique: X-La797lPx-ltAEHxjmL-w-1
X-Mimecast-MFC-AGG-ID: X-La797lPx-ltAEHxjmL-w_1758792739
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84C30180057A;
	Thu, 25 Sep 2025 09:32:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61AC9180044F;
	Thu, 25 Sep 2025 09:32:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250924185558.3395930-1-max.kellermann@ionos.com>
References: <20250924185558.3395930-1-max.kellermann@ionos.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH v2] fs/netfs: fix reference leak
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <928029.1758792736.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Sep 2025 10:32:16 +0100
Message-ID: <928030.1758792736@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Max,

I'm going to make the attached change to log the refcount and then post as=
 v3
for Christian to pick up.

David
---
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 39d5e13f7248..40a1c7d6f6e0 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -179,13 +179,15 @@ void netfs_put_request(struct netfs_io_request *rreq=
, enum netfs_rreq_ref_trace
  */
 void netfs_put_failed_request(struct netfs_io_request *rreq)
 {
+	int r =3D refcount_read(&rreq->ref);
+
 	/* new requests have two references (see
 	 * netfs_alloc_request(), and this function is only allowed on
 	 * new request objects
 	 */
-	WARN_ON_ONCE(refcount_read(&rreq->ref) !=3D 2);
+	WARN_ON_ONCE(r !=3D 2);
 =

-	trace_netfs_rreq_ref(rreq->debug_id, 0, netfs_rreq_trace_put_failed);
+	trace_netfs_rreq_ref(rreq->debug_id, r, netfs_rreq_trace_put_failed);
 	netfs_free_request(&rreq->cleanup_work);
 }
 =


