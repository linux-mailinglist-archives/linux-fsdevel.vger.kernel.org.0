Return-Path: <linux-fsdevel+bounces-15587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B81589068B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 18:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1521329ED0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5D2130493;
	Thu, 28 Mar 2024 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NB3ALg1u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFD13048B
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645189; cv=none; b=dCJtJ42jpOa8auLV0H+iaClkzLqAe1rt3rq7C2Z3stTwJZx7/sL6nYQ3cpr4FfLuTkNI7aMQ0wt3lMQQ134c2Dw/1P+LwHd9IYOHTJayMw8IeijqervuRGF/vI0wbAU9RsD4krtSQTAYPG/TSDY1gSSRCct8aSt39r4XhtFkm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645189; c=relaxed/simple;
	bh=NaiYCpKD/naLFX/mBnWa0fNHnJcl1Aa3tXqEyM0Fyuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHbgn4iB3mdxHvBNz3KtRbyH8xtaQEAfZelJ9HbtKSx/wApJKe7UbciMCKb6pJvi5Kv1K6vjOUxt5vpPVwCZHez4e40hZzBgm54+gH8oVWuWbvobPzMekDBBXUYHDtcn/2nh2D8Qav0lALF2wIMIyRZFfc/BwmKLlNr9eSTxM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NB3ALg1u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711645186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FP3I6/3Lail3PRtRjCFYUrK7RtWmkgk5AkVOW5arfmM=;
	b=NB3ALg1uL8n59eM1cXyUvKLeFcXNDR4v5p2YxqJuUJzt4xcAbQJ44G+tyhaXi48dPSN8YY
	kQ8qc6nCeRmoTdhPlq8zOhNUlEKMVwmHIx8odBOsp7533356dmxg1dcZB5AOhU75qqAdhz
	5FiOzXGBPSgsmszfSQGLDqmihIW8eV8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130--_LPE4uLM_G2IXbLkWEMMQ-1; Thu, 28 Mar 2024 12:59:43 -0400
X-MC-Unique: -_LPE4uLM_G2IXbLkWEMMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0A5680026D;
	Thu, 28 Mar 2024 16:59:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C5C27C4C7A0;
	Thu, 28 Mar 2024 16:59:40 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v6 05/15] cifs: Replace the writedata replay bool with a netfs sreq flag
Date: Thu, 28 Mar 2024 16:57:56 +0000
Message-ID: <20240328165845.2782259-6-dhowells@redhat.com>
In-Reply-To: <20240328165845.2782259-1-dhowells@redhat.com>
References: <20240328165845.2782259-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Replace the 'replay' bool in cifs_writedata (now cifs_io_subrequest) with a
flag in the netfs_io_subrequest flags.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/file.c    | 2 +-
 fs/smb/client/smb2pdu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 76bfefa9b669..6f6459b506d1 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3246,7 +3246,7 @@ cifs_resend_wdata(struct cifs_io_subrequest *wdata, struct list_head *wdata_list
 			if (wdata->cfile->invalidHandle)
 				rc = -EAGAIN;
 			else {
-				wdata->replay = true;
+				set_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 				if (wdata->mr) {
 					wdata->mr->need_invalidate = true;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index ddd69db1f0a8..2e29c6c2dca6 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4819,7 +4819,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	struct cifs_io_parms *io_parms = NULL;
 	int credit_request;
 
-	if (!wdata->server || wdata->replay)
+	if (!wdata->server || test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
 		server = wdata->server = cifs_pick_channel(tcon->ses);
 
 	/*
@@ -4904,7 +4904,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	rqst.rq_nvec = 1;
 	rqst.rq_iter = wdata->subreq.io_iter;
 	rqst.rq_iter_size = iov_iter_count(&rqst.rq_iter);
-	if (wdata->replay)
+	if (test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
 		smb2_set_replay(server, &rqst);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (wdata->mr)


