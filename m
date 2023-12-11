Return-Path: <linux-fsdevel+bounces-5522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3103280D1ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9FBB2133A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DC4FC06;
	Mon, 11 Dec 2023 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWdKHqoH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E888A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 08:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702312467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+ZZc9tpbDfGr90pM2vQWil9uTsRvVuBO2QwM72BV7A=;
	b=JWdKHqoHHzQV5u/KfDVb3r/vmpBWRB/MGa+aFtBeb+8HgNUjlxB09yXdt6SlvrGG0Z2Bvp
	DgzCX4oPeqzDwYR23voMuvFqFBhnBnotePbqDg12Yk50EYzp4BNpOQ/IWDsb7sbK7oIdVe
	nnJW7Q2sqUxHQ6E54zr7FmB34b0CISk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-6usZ8FX2O2yi5a9xxVOF8A-1; Mon, 11 Dec 2023 11:34:21 -0500
X-MC-Unique: 6usZ8FX2O2yi5a9xxVOF8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D6D6185A786;
	Mon, 11 Dec 2023 16:34:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 72C992166B31;
	Mon, 11 Dec 2023 16:34:20 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	keyrings@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] afs: Fix dynamic root lookup DNS check
Date: Mon, 11 Dec 2023 16:34:11 +0000
Message-ID: <20231211163412.2766147-3-dhowells@redhat.com>
In-Reply-To: <20231211163412.2766147-1-dhowells@redhat.com>
References: <20231211163412.2766147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

In the afs dynamic root directory, the ->lookup() function does a DNS check
on the cell being asked for and if the DNS upcall reports an error it will
report an error back to userspace (typically ENOENT).

However, if a failed DNS upcall returns a new-style result, it will return
a valid result, with the status field set appropriately to indicate the
type of failure - and in that case, dns_query() doesn't return an error and
we let stat() complete with no error - which can cause confusion in
userspace as subsequent calls that trigger d_automount then fail with
ENOENT.

Fix this by checking the status result from a valid dns_query() and
returning an error if it indicates a failure.

Fixes: bbb4c4323a4d ("dns: Allow the dns resolver to retrieve a server set")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216637
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dynroot.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 34474a061654..4089d77a7a4d 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -114,6 +114,7 @@ static int afs_probe_cell_name(struct dentry *dentry)
 	struct afs_net *net = afs_d2net(dentry);
 	const char *name = dentry->d_name.name;
 	size_t len = dentry->d_name.len;
+	char *result = NULL;
 	int ret;
 
 	/* Names prefixed with a dot are R/W mounts. */
@@ -131,9 +132,22 @@ static int afs_probe_cell_name(struct dentry *dentry)
 	}
 
 	ret = dns_query(net->net, "afsdb", name, len, "srv=1",
-			NULL, NULL, false);
-	if (ret == -ENODATA || ret == -ENOKEY)
+			&result, NULL, false);
+	if (ret == -ENODATA || ret == -ENOKEY || ret == 0)
 		ret = -ENOENT;
+	if (ret >= sizeof(struct dns_server_list_v1_header)) {
+		struct dns_server_list_v1_header *v1 = (void *)result;
+
+		if (v1->hdr.zero == 0 &&
+		    v1->hdr.content == DNS_PAYLOAD_IS_SERVER_LIST &&
+		    v1->hdr.version == 1 &&
+		    (v1->status != DNS_LOOKUP_GOOD &&
+		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD))
+			return -ENOENT;
+
+	}
+
+	kfree(result);
 	return ret;
 }
 


