Return-Path: <linux-fsdevel+bounces-25971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894269523BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47606284DF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951C1D4171;
	Wed, 14 Aug 2024 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5FW5E9J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02E1C825C
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668021; cv=none; b=lGHWevoi/RFw+aNPMt26SlkrGjIYX0FwBr3y2131/TmJzwJ93lTT16+NI7eUSBn/ETzjZgRTUGEj3T0tVLTNj19aQv+mgytgYGa1O/+VAC8S4xb+aHI9dGZtQ0NpNCBBeNNQt2B4qBtNwuNbKiZMTwuptQpApGJikn37nRNVioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668021; c=relaxed/simple;
	bh=07YMkBeA58pj90nG16JAYod2YQz41Y/z6EB04qgkE98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1yzJZeBuFiafLvBOfMOW10ocRzd0BxQzuk6rQFmR8c93GAUmRyYJUhiRQP4vr9LdJzocI0oTBQm9fpUUhthc6Lvwe3BB/RbKWpXvI2jEtAYIJbFSxVk+VUBvLRBKFkEcV/augC6VTPWqLLH2+pedOyECBdL4nLOnaERIkn10IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5FW5E9J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqmeAIFtHY/CwyA/vjZ+IfoBU5cuDLNukUcIV4khXxI=;
	b=L5FW5E9JI2tC7+EGIOSAhvLpfMDSYrNUguA2cW2Y5SaV6U2moJNjLDxr6DPBmHTKVj63iJ
	3gwlI+QUY1jh6fRAz7OeiHD/WMRxBka/9IPz+ovy0LeW5Fhxo3IqkoWS0+/KHAlXcgqe8H
	0BWBqXV6Sotej8NDL/6OSb46oknMPII=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-VGEIqNK5Ox-3wfRG2S8vKg-1; Wed,
 14 Aug 2024 16:40:14 -0400
X-MC-Unique: VGEIqNK5Ox-3wfRG2S8vKg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78B6D1955F43;
	Wed, 14 Aug 2024 20:40:11 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D09D119560A3;
	Wed, 14 Aug 2024 20:40:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/25] netfs: Remove NETFS_COPY_TO_CACHE
Date: Wed, 14 Aug 2024 21:38:29 +0100
Message-ID: <20240814203850.2240469-10-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Remove NETFS_COPY_TO_CACHE as it isn't used anymore.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/main.c              | 3 +--
 include/linux/netfs.h        | 3 +--
 include/trace/events/netfs.h | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 5f0f438e5d21..1ee712bb3610 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -37,11 +37,10 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READAHEAD]		= "RA",
 	[NETFS_READPAGE]		= "RP",
 	[NETFS_READ_FOR_WRITE]		= "RW",
-	[NETFS_COPY_TO_CACHE]		= "CC",
+	[NETFS_DIO_READ]		= "DR",
 	[NETFS_WRITEBACK]		= "WB",
 	[NETFS_WRITETHROUGH]		= "WT",
 	[NETFS_UNBUFFERED_WRITE]	= "UW",
-	[NETFS_DIO_READ]		= "DR",
 	[NETFS_DIO_WRITE]		= "DW",
 };
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 16834751e646..ae4abf121d97 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -206,11 +206,10 @@ enum netfs_io_origin {
 	NETFS_READAHEAD,		/* This read was triggered by readahead */
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
-	NETFS_COPY_TO_CACHE,		/* This write is to copy a read to the cache */
+	NETFS_DIO_READ,			/* This is a direct I/O read */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
 	NETFS_WRITETHROUGH,		/* This write was made by netfs_perform_write() */
 	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
-	NETFS_DIO_READ,			/* This is a direct I/O read */
 	NETFS_DIO_WRITE,		/* This is a direct I/O write */
 	nr__netfs_io_origin
 } __mode(byte);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index f4105b8e5894..47cd11aaccac 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -34,11 +34,10 @@
 	EM(NETFS_READAHEAD,			"RA")		\
 	EM(NETFS_READPAGE,			"RP")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
-	EM(NETFS_COPY_TO_CACHE,			"CC")		\
+	EM(NETFS_DIO_READ,			"DR")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
 	EM(NETFS_WRITETHROUGH,			"WT")		\
 	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
-	EM(NETFS_DIO_READ,			"DR")		\
 	E_(NETFS_DIO_WRITE,			"DW")
 
 #define netfs_rreq_traces					\


