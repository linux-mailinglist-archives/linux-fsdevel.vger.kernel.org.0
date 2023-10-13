Return-Path: <linux-fsdevel+bounces-284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FF77C89B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81632282E41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC642134D;
	Fri, 13 Oct 2023 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ghg2IehH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DD1CF9A
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:05:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FD0CE
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697213100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od1nOg0d5KcBROFP/nmLvEU1/p7aWHgHI8UqWVAfctw=;
	b=Ghg2IehHeDqTSkuZhDoYAbzJ64R04xteVNDNf5GW64Z7vQc4QEwjVv/o3ZI9p9Rr2x5CJQ
	S3nOjegh0ZF23JuIM89irm1iVWXg5auOKaWKZiWOojdKrp1LA0GQ23P/05G0AiwDtJPh1o
	18O6gPRsSX7ET7pV6bWmCHRmDntmR8s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378--MYQi_f-M-Sjm_LBP-JE9A-1; Fri, 13 Oct 2023 12:04:55 -0400
X-MC-Unique: -MYQi_f-M-Sjm_LBP-JE9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB9F53C40C2F;
	Fri, 13 Oct 2023 16:04:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 253CB1C06535;
	Fri, 13 Oct 2023 16:04:52 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cachefs@redhat.com
Subject: [RFC PATCH 08/53] netfs: Add rsize to netfs_io_request
Date: Fri, 13 Oct 2023 17:03:37 +0100
Message-ID: <20231013160423.2218093-9-dhowells@redhat.com>
In-Reply-To: <20231013160423.2218093-1-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add an rsize parameter to netfs_io_request to be filled in by the network
filesystem when the request is initialised.  This indicates the maximum
size of a read request that the netfs will honour in that region.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/afs/file.c         | 1 +
 fs/ceph/addr.c        | 2 ++
 include/linux/netfs.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 3fea5cd8ef13..3d2e1913ea27 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -360,6 +360,7 @@ static int afs_symlink_read_folio(struct file *file, struct folio *folio)
 static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	rreq->netfs_priv = key_get(afs_file_key(file));
+	rreq->rsize = 4 * 1024 * 1024;
 	return 0;
 }
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ced19ff08988..92a5ddcd9a76 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -419,6 +419,8 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	struct ceph_netfs_request_data *priv;
 	int ret = 0;
 
+	rreq->rsize = 1024 * 1024;
+
 	if (rreq->origin != NETFS_READAHEAD)
 		return 0;
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index daa431c4148d..02e888c170da 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -188,6 +188,7 @@ struct netfs_io_request {
 	struct list_head	subrequests;	/* Contributory I/O operations */
 	void			*netfs_priv;	/* Private data for the netfs */
 	unsigned int		debug_id;
+	unsigned int		rsize;		/* Maximum read size (0 for none) */
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
 	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */


