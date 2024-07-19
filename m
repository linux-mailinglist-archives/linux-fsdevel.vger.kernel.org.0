Return-Path: <linux-fsdevel+bounces-24019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF929379D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331E1282AC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D236144D15;
	Fri, 19 Jul 2024 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8fkFT64"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759481726
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402735; cv=none; b=JfX1WIb8ajSu1yCHbZxte/hgq92w4bk4wmH8EvO4eHVtxa8/HbNg7ZjC13ffhOt50P8aEbHYWmrSIWMcNL3yHZNeQ5aICxbkPhIwm0yeSq2NVxvF7d6eSc5uUje0difbs8DW5RJUuzaNc5Nmw7b+QGPyohL2g7As634Zqw4pBmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402735; c=relaxed/simple;
	bh=mgUBsqL5rcAA+qWQkpLdwJAUSDe+xIRX5y6sRZgCJ7M=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=qL36Pjh/uDnQwH8McMluEssxWANCqcehp7HAwOEsnaFA9cpdo6bK84JWRf/P982BZtkKzr7thPtFahbbjXvgnhG/xn5jVe27q8XYB54heB5uSSTr0gK0nkLpOZLSVhj9venUS5jpT/xmCrzB3Bh6oCqcwj9oypjq/XrZNSWfHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8fkFT64; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721402731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukK9Kli4MxU+D+3/q5r6CBIx8Atg8ED3S4uzlwX+2YE=;
	b=C8fkFT64SkqyYgU+RsxSgFyqn59SKHQbChjutw8OBzqZoBc5brV336Wm4PksgBHrQ6d1Aw
	TDrFFDOInHvHTApGCwxLsVhc4uKJDqnKjBAjX+L53uS7nhrt6KiKz9uzmackrhczBZ5/2d
	klUXWssBDZWBFBzF1kPlWAWfT7SOZiA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-5epOSSVxPpyiW_8yPAzRbw-1; Fri,
 19 Jul 2024 11:25:28 -0400
X-MC-Unique: 5epOSSVxPpyiW_8yPAzRbw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0EDB1955F0A;
	Fri, 19 Jul 2024 15:25:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A724C195605A;
	Fri, 19 Jul 2024 15:25:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240719140907.1598372-1-dhowells@redhat.com>
References: <20240719140907.1598372-1-dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/4] cifs: Fix missing fscache invalidation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1742062.1721402723.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jul 2024 16:25:23 +0100
Message-ID: <1742063.1721402723@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

A network filesystem needs to implement a netfslib hook to invalidate
fscache if it's to be able to use the cache.

Fix cifs to implement the cache invalidation hook.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
---
 fs/smb/client/file.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index f8d6ad88335e..b2405dd4d4d4 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -133,6 +133,11 @@ static void cifs_issue_write(struct netfs_io_subreque=
st *subreq)
 	goto out;
 }
 =

+static void cifs_netfs_invalidate_cache(struct netfs_io_request *wreq)
+{
+	cifs_invalidate_cache(wreq->inode, 0);
+}
+
 /*
  * Split the read up according to how many credits we can get for each pi=
ece.
  * It's okay to sleep here if we need to wait for more credit to become
@@ -337,6 +342,7 @@ const struct netfs_request_ops cifs_req_ops =3D {
 	.begin_writeback	=3D cifs_begin_writeback,
 	.prepare_write		=3D cifs_prepare_write,
 	.issue_write		=3D cifs_issue_write,
+	.invalidate_cache	=3D cifs_netfs_invalidate_cache,
 };
 =

 /*


