Return-Path: <linux-fsdevel+bounces-7261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702A5823703
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9532879E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 21:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E800E1DA46;
	Wed,  3 Jan 2024 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csxKLHo1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FD1D6BC
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704316554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz9BpuJT9ZqjBzLEQFTtycxe4tbIVPZFPrNygtaFHDI=;
	b=csxKLHo1dLIRI41aBVgchwKMJP2JKbNckE4MT3QbtXCiMtNVnl4WyzXbJAmKITCLevnE81
	16M2kDMWDOipj6FYECdts+CYruFIh0/EAOFWVp2hqY4rdGH+GuryP1VX+RAEPut4cazEGW
	m4Rl6fIRW0ZJGZ3gA0t9j13dAvbX7Ss=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-1v-GWHbRM9e1RxN52-Av-w-1; Wed,
 03 Jan 2024 16:15:48 -0500
X-MC-Unique: 1v-GWHbRM9e1RxN52-Av-w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5354F3806710;
	Wed,  3 Jan 2024 21:15:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 576BF492BC6;
	Wed,  3 Jan 2024 21:15:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240103145935.384404-1-dhowells@redhat.com>
References: <20240103145935.384404-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Jeff Layton <jlayton@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>
Cc: dhowells@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/5] netfs: Fix proc/fs/fscache symlink to point to "netfs" not "../netfs"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <900276.1704316543.1@warthog.procyon.org.uk>
Date: Wed, 03 Jan 2024 21:15:43 +0000
Message-ID: <900277.1704316543@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Fix the proc/fs/fscache symlink to point to "netfs" not "../netfs".

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Christian Brauner <christian@brauner.io>
cc: linux-fsdevel@vger.kernel.org
cc: linux-cachefs@redhat.com
---
 fs/netfs/fscache_proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/fscache_proc.c b/fs/netfs/fscache_proc.c
index ecd0d1edafaa..874d951bc390 100644
--- a/fs/netfs/fscache_proc.c
+++ b/fs/netfs/fscache_proc.c
@@ -16,7 +16,7 @@
  */
 int __init fscache_proc_init(void)
 {
-	if (!proc_symlink("fs/fscache", NULL, "../netfs"))
+	if (!proc_symlink("fs/fscache", NULL, "netfs"))
 		goto error_sym;
 
 	if (!proc_create_seq("fs/netfs/caches", S_IFREG | 0444, NULL,


