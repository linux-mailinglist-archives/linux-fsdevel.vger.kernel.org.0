Return-Path: <linux-fsdevel+bounces-53544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2F4AF0032
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A506D1C20348
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03E527E058;
	Tue,  1 Jul 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEAeBlhR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92227FD59
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387967; cv=none; b=cAVH/QTP+icPrr3r/h6+K2vdPMgx02OkjcGEpmFtGnlQQwAqg4OntmXjwUsuDY2BVrkjdSKJDp8+HtLWgZozz8oubnijiMo4pezJofqR9g5YkWWmLS/OdFNjE8Pxy5dUY8sJ7SjjvfCJrPljLQsNO1lFbN8aqRtxyoXhf/O3k+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387967; c=relaxed/simple;
	bh=XmSFLFC2NdEXVKzmDFBhpe2CWf4aDIaMz2C/wl0FZEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY9qQB4ThSERJTuQd0ZEyYAFQwdMXUt1BJtFcCpQYoiS1O00KnOeYxr/JM/W83zlXc4j9tQQrrB1TuayhKpafsa/rSLfCCdcv1+xDg9ZqAbeKzAgS+UGKia58C/dBGrm+e92Zhs/mUB8HsUKa0+LBWqUUgvklDSAD+e1K72SqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEAeBlhR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751387964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVQohGWSsn5ft16v0n/zQZ2NblN0ypItlKaKHmHIi8g=;
	b=UEAeBlhRF9YX1Tju0gzW0hhD4RcznDFnOtBesVd+rHKU+2HMuZ7Dwb/nct1q5tyqlszh73
	XyK/x5HuX4pMMJxM20MnACnAcYgQaSrLpM4Z/mOuIzLT6fTfIYn1g0ZxqCb7T3p3P1ow6k
	AXNgiRdqZovodvYJoJGzfWeTgs/5Qxk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-iOwTqRq5PLC3NWI1U8WibA-1; Tue,
 01 Jul 2025 12:39:23 -0400
X-MC-Unique: iOwTqRq5PLC3NWI1U8WibA-1
X-Mimecast-MFC-AGG-ID: iOwTqRq5PLC3NWI1U8WibA_1751387961
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 247ED18DA5C2;
	Tue,  1 Jul 2025 16:39:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEAC0195608F;
	Tue,  1 Jul 2025 16:39:17 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 04/13] netfs: Fix looping in wait functions
Date: Tue,  1 Jul 2025 17:38:39 +0100
Message-ID: <20250701163852.2171681-5-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
References: <20250701163852.2171681-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

netfs_wait_for_request() and netfs_wait_for_pause() can loop forever if
netfs_collect_in_app() returns 2, indicating that it wants to repeat
because the ALL_QUEUED flag isn't yet set and there are no subreqs left
that haven't been collected.

The problem is that, unless collection is offloaded (OFFLOAD_COLLECTION),
we have to return to the application thread to continue and eventually set
ALL_QUEUED after pausing to deal with a retry - but we never get there.

Fix this by inserting checks for the IN_PROGRESS and PAUSE flags as
appropriate before cycling round - and add cond_resched() for good measure.

Fixes: 2b1424cd131c ("netfs: Fix wait/wake to be consistent about the waitqueue used")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
Tested-by: Steve French <sfrench@samba.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/misc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 7f31c3cbfe01..127a269938bb 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -430,8 +430,8 @@ static int netfs_collect_in_app(struct netfs_io_request *rreq,
 /*
  * Wait for a request to complete, successfully or otherwise.
  */
-static ssize_t netfs_wait_for_request(struct netfs_io_request *rreq,
-				      bool (*collector)(struct netfs_io_request *rreq))
+static ssize_t netfs_wait_for_in_progress(struct netfs_io_request *rreq,
+					  bool (*collector)(struct netfs_io_request *rreq))
 {
 	DEFINE_WAIT(myself);
 	ssize_t ret;
@@ -447,6 +447,9 @@ static ssize_t netfs_wait_for_request(struct netfs_io_request *rreq,
 			case 1:
 				goto all_collected;
 			case 2:
+				if (!netfs_check_rreq_in_progress(rreq))
+					break;
+				cond_resched();
 				continue;
 			}
 		}
@@ -485,12 +488,12 @@ static ssize_t netfs_wait_for_request(struct netfs_io_request *rreq,
 
 ssize_t netfs_wait_for_read(struct netfs_io_request *rreq)
 {
-	return netfs_wait_for_request(rreq, netfs_read_collection);
+	return netfs_wait_for_in_progress(rreq, netfs_read_collection);
 }
 
 ssize_t netfs_wait_for_write(struct netfs_io_request *rreq)
 {
-	return netfs_wait_for_request(rreq, netfs_write_collection);
+	return netfs_wait_for_in_progress(rreq, netfs_write_collection);
 }
 
 /*
@@ -514,6 +517,10 @@ static void netfs_wait_for_pause(struct netfs_io_request *rreq,
 			case 1:
 				goto all_collected;
 			case 2:
+				if (!netfs_check_rreq_in_progress(rreq) ||
+				    !test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
+					break;
+				cond_resched();
 				continue;
 			}
 		}


