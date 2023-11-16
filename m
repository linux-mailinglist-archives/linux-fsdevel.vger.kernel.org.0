Return-Path: <linux-fsdevel+bounces-2965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044AF7EE4B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 16:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3462F1C20A5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0561381DD;
	Thu, 16 Nov 2023 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6kK9Rxf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50614A5
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 07:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700150004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhGgF4sumcSjliim6dBu5rLnVa3iX5fUGEGQb8mJ0/o=;
	b=T6kK9RxfqbYq56EHp5M2wz7KVbobm/DK28JWHClFE6P5pnMUWLxHUPAW0G8w1ozrdw1TfA
	xsYtM10JaZpla3FEfGOGvjOo8LOqw7gavaxaRE/5/UbxQd1t97rAEqIT09KMa6GfaVaj4I
	RiBomOvVXrtrltgoXDFXJvjnrBp6K6w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-IHcKw8DrMNmlMuRkkWz2ZQ-1; Thu, 16 Nov 2023 10:53:20 -0500
X-MC-Unique: IHcKw8DrMNmlMuRkkWz2ZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 912E4185A782;
	Thu, 16 Nov 2023 15:53:19 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8BDE47ACE;
	Thu, 16 Nov 2023 15:53:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Jeffrey Altman <jaltman@auristor.com>
Subject: [PATCH 2/5] afs: Make error on cell lookup failure consistent with OpenAFS
Date: Thu, 16 Nov 2023 15:53:09 +0000
Message-ID: <20231116155312.156593-3-dhowells@redhat.com>
In-Reply-To: <20231116155312.156593-1-dhowells@redhat.com>
References: <20231116155312.156593-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

When kafs tries to look up a cell in the DNS or the local config, it will
translate a lookup failure into EDESTADDRREQ whereas OpenAFS translates it
into ENOENT.  Applications such as West expect the latter behaviour and
fail if they see the former.

This can be seen by trying to mount an unknown cell:

   # mount -t afs %example.com:cell.root /mnt
   mount: /mnt: mount(2) system call failed: Destination address required.

Fixes: 4d673da14533 ("afs: Support the AFS dynamic root")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216637
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dynroot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 4d04ef2d3ae7..1fa8cf23bd36 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -132,8 +132,8 @@ static int afs_probe_cell_name(struct dentry *dentry)
 
 	ret = dns_query(net->net, "afsdb", name, len, "srv=1",
 			NULL, NULL, false);
-	if (ret == -ENODATA)
-		ret = -EDESTADDRREQ;
+	if (ret == -ENODATA || ret == -ENOKEY)
+		ret = -ENOENT;
 	return ret;
 }
 


