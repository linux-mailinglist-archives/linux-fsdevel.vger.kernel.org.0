Return-Path: <linux-fsdevel+bounces-49415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EFDABBFD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AB34A3295
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19B283FFC;
	Mon, 19 May 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxM4jygU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033CB27D78A
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662542; cv=none; b=l6u13SkREryZxdjkIn4m6ez+qvQn063YAa5ABljfHL8wn1gxUJQSWAOjFkjGbdTttKGmmuNnCZcK5z+4vxnuC0HDI5BQktShKA/mB10zZGUUL6UWu56bvzM3wfzRhpZsFxINm6p9AWNgiRoeEp8mHg9HUiVK7yJsrHIccdPFC2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662542; c=relaxed/simple;
	bh=PS+NUQx/dRaK8zkRQ8j0I6E2vC/kjo33X7Ng1OnFsw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2KO+1Yua2tDO1mWST+GbXJBGbFOpXMC2C3MBbQccK4zpISEdswmrvSMs8/3zf5hqvtYeoxi95lzbBca9/5RxNWz8JirpeL4ijAbj5R4qhO5bI1GUJzJpsgUUib7Nshm3aaSUM2YDzLq8zz+iey3btY0rMCrSjLUAVWPrXk3kS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxM4jygU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TU97Kv9PHvyzyW6wDrwIHb7qBNLH0Tc71g7goojU80s=;
	b=QxM4jygUqr8BpGkTek3PRRf26fnMYaUr1il9oyJs66z6n57nYFy7ESy0o6/LKIog/mk/1W
	2+/LaHUyV3nqartOI2xHbQvNOz4FbsFFt/WENsQkHYzqZMWBZBOK561nc1P8ReVn1+fga+
	YwC0dYOhVmU90rtaMwc/uuF4gCJAjpY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-gVv8AggkMXS3w71SKoBdrQ-1; Mon,
 19 May 2025 09:48:54 -0400
X-MC-Unique: gVv8AggkMXS3w71SKoBdrQ-1
X-Mimecast-MFC-AGG-ID: gVv8AggkMXS3w71SKoBdrQ_1747662533
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5F25180087F;
	Mon, 19 May 2025 13:48:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97327180047F;
	Mon, 19 May 2025 13:48:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] fs/netfs: remove unused enum choice NETFS_READ_HOLE_CLEAR
Date: Mon, 19 May 2025 14:48:01 +0100
Message-ID: <20250519134813.2975312-6-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Max Kellermann <max.kellermann@ionos.com>

This choice was added by commit 3a11b3a86366 ("netfs: Pass more
information on how to deal with a hole in the cache") but the last
user was removed by commit 86b374d061ee ("netfs: Remove
fs/netfs/io.c").

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/fscache.h | 3 ---
 include/linux/netfs.h   | 1 -
 2 files changed, 4 deletions(-)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 9de27643607f..fea0d9779b55 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -498,9 +498,6 @@ static inline void fscache_end_operation(struct netfs_cache_resources *cres)
  *
  *	NETFS_READ_HOLE_IGNORE - Just try to read (may return a short read).
  *
- *	NETFS_READ_HOLE_CLEAR - Seek for data, clearing the part of the buffer
- *				skipped over, then do as for IGNORE.
- *
  *	NETFS_READ_HOLE_FAIL - Give ENODATA if we encounter a hole.
  */
 static inline
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 242daec8c837..73537dafa224 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -318,7 +318,6 @@ struct netfs_request_ops {
  */
 enum netfs_read_from_hole {
 	NETFS_READ_HOLE_IGNORE,
-	NETFS_READ_HOLE_CLEAR,
 	NETFS_READ_HOLE_FAIL,
 };
 


