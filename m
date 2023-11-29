Return-Path: <linux-fsdevel+bounces-4233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C037FDF7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42A61C2083A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE315DF09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1SVpREi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F96C9
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 08:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701276992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPjSTDvJjKZvQqpuoRax99jzMiuqvHWjt5D7woIueGo=;
	b=E1SVpREi48e1BMrMM3+zthfshN/G648ofe9LB9kQ+tOYKyTAe20v69/CAk0i1qw9MWEz+h
	v9QVxFFzWb5hbm8XwbndUk7ttqzSDiG5l8eMj6+RPqxa1ZekgGSdiqcN+JdjTVLpFn8qzb
	OIl/4vSINNdZbBn4ul87N+NPU95TUaM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-1kcZMNfDO66ZvxPfVdWQfg-1; Wed,
 29 Nov 2023 11:56:29 -0500
X-MC-Unique: 1kcZMNfDO66ZvxPfVdWQfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 888851C0BB75;
	Wed, 29 Nov 2023 16:56:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DF0D3C15886;
	Wed, 29 Nov 2023 16:56:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size after EOF moved
Date: Wed, 29 Nov 2023 16:56:18 +0000
Message-ID: <20231129165619.2339490-3-dhowells@redhat.com>
In-Reply-To: <20231129165619.2339490-1-dhowells@redhat.com>
References: <20231129165619.2339490-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Fix the cifs filesystem implementations of FALLOC_FL_INSERT_RANGE, in
smb3_insert_range(), to set i_size after extending the file on the server
and before we do the copy to open the gap (as we don't clean up the EOF
marker if the copy fails).

Fixes: 7fe6fe95b936 ("cifs: add FALLOC_FL_INSERT_RANGE support")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/smb2ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 572d2c22a703..65a00c8b8494 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3741,6 +3741,9 @@ static long smb3_insert_range(struct file *file, struct cifs_tcon *tcon,
 	if (rc < 0)
 		goto out_2;
 
+	truncate_setsize(inode, old_eof + len);
+	fscache_resize_cookie(cifs_inode_cookie(inode), i_size_read(inode));
+
 	rc = smb2_copychunk_range(xid, cfile, cfile, off, count, off + len);
 	if (rc < 0)
 		goto out_2;


