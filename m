Return-Path: <linux-fsdevel+bounces-5896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 620828113AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D60B21205
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D52F845;
	Wed, 13 Dec 2023 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRBSVNas"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31151985
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mrk0toX4iy+sa30+IfYuhvEvlz4UbttXs26cFwhG3jo=;
	b=RRBSVNas4VQS2xXAQYZFaK+7ccF7wjmBQMmLfG7IopwgbpOYsJF4iQrtWakM16/pks6+/+
	/98zuqcSJdKMJipgJGI7fnnS5OgR1PYqLX2UZ/OD/mMQlHHl4+aR5eSCU5m6/Tf5kR1Xgn
	LjSfDoCujJ47k1WyAJgpJykBrgBKQRU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-mlXMGZtnM8ijtuYFgUI6Jw-1; Wed, 13 Dec 2023 08:51:16 -0500
X-MC-Unique: mlXMGZtnM8ijtuYFgUI6Jw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83EFE101CFB6;
	Wed, 13 Dec 2023 13:51:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9F73492BF0;
	Wed, 13 Dec 2023 13:50:59 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/40] afs: Fix comment in afs_do_lookup()
Date: Wed, 13 Dec 2023 13:49:56 +0000
Message-ID: <20231213135003.367397-35-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Fix the comment in afs_do_lookup() that says that slot 0 is used for the
fid being looked up and slot 1 is used for the directory.  It's actually
done the other way round.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index ecb889a269fb..e232f713ece1 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -807,8 +807,8 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 		cookie->fids[i].vid = dvnode->fid.vid;
 	cookie->ctx.actor = afs_lookup_filldir;
 	cookie->name = dentry->d_name;
-	cookie->nr_fids = 2; /* slot 0 is saved for the fid we actually want
-			      * and slot 1 for the directory */
+	cookie->nr_fids = 2; /* slot 1 is saved for the fid we actually want
+			      * and slot 0 for the directory */
 
 	if (!afs_server_supports_ibulk(dvnode))
 		cookie->one_only = true;


