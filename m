Return-Path: <linux-fsdevel+bounces-25970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5739523BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86681F23082
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3073F1D47A4;
	Wed, 14 Aug 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyAR4Sub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D491D416D
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668014; cv=none; b=jDPVRPF9yJ/StBQ2ykIkgR5JYFmEdQ++1A2a3W5kikjiPfygtVJ9eydBCwFA+NOVJ+ux73ZxBgZy9B3nv2uoqK69zObYu2w6bAtci9INCqiC5YZJ4czxKaUoqEomt1XBPFoXUvrSB+Dm/MBmwlfwcu1go1WIAnra8R0kpy3sBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668014; c=relaxed/simple;
	bh=gN/uhOgzLK4FiZe7gRprQlF9swk2M89zT7vCFfFie08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYLa8don407ceYz1C8iiEAzi9oHTkyPN0ym73qdgtChu7OqndXU9XpBmfLReVKGiHd0+KRY8JBLOhJMDK+EMyFQV1sSiGev0OCuI6KN5Yp3Lj627emr2ivvcamb8ICfllYDeUgBG7tBBw4kCuyz2VY/txX2qi6/NUGiLhaW/wTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyAR4Sub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ILxAt7NrlTMl997Ic8qQaZjEltu0gIkdcefwxoaQ6I=;
	b=gyAR4SubZfBZnAjycN5SqOKk9EYYPwHn9QPXZt+cnEzViVY8gAFk1QP/VqR6jJWSN0Bmaf
	KGVhpnkDz013uQLZ8whUbKHsRHYLX72BVp8+RpqL+2W1d1mthOfhAWKN69KG37OTeac9FT
	ak0wCEAgYecaSLJQ1pRC5/uPR+MyyuE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-TmxqWq9ANiW1IsbBOq97nA-1; Wed,
 14 Aug 2024 16:40:07 -0400
X-MC-Unique: TmxqWq9ANiW1IsbBOq97nA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75755195609E;
	Wed, 14 Aug 2024 20:40:04 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 917E219560A3;
	Wed, 14 Aug 2024 20:39:58 +0000 (UTC)
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
Subject: [PATCH v2 08/25] netfs: Reserve netfs_sreq_source 0 as unset/unknown
Date: Wed, 14 Aug 2024 21:38:28 +0100
Message-ID: <20240814203850.2240469-9-dhowells@redhat.com>
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

Reserve the 0-valued netfs_sreq_source to mean unset or unknown so that it
can be seen in the trace as such rather than appearing as
download-from-server when it's going to get switched to something else.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/netfs.h        | 1 +
 include/trace/events/netfs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 11fa86640d91..16834751e646 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -43,6 +43,7 @@ static inline void folio_start_private_2(struct folio *folio)
 #define NETFS_BUF_PAGECACHE_MARK XA_MARK_1	/* - Page needs wb/dirty flag wrangling */
 
 enum netfs_io_source {
+	NETFS_SOURCE_UNKNOWN,
 	NETFS_FILL_WITH_ZEROES,
 	NETFS_DOWNLOAD_FROM_SERVER,
 	NETFS_READ_FROM_CACHE,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index a4fd5dea52f4..f4105b8e5894 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -60,6 +60,7 @@
 	E_(netfs_rreq_trace_write_done,		"WR-DONE")
 
 #define netfs_sreq_sources					\
+	EM(NETFS_SOURCE_UNKNOWN,		"----")		\
 	EM(NETFS_FILL_WITH_ZEROES,		"ZERO")		\
 	EM(NETFS_DOWNLOAD_FROM_SERVER,		"DOWN")		\
 	EM(NETFS_READ_FROM_CACHE,		"READ")		\


