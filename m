Return-Path: <linux-fsdevel+bounces-52940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E99AE8A67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823DD680224
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF972E174E;
	Wed, 25 Jun 2025 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0ut7z7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36A2E0B49
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869771; cv=none; b=TS6jnjdnoEt9NB7lh07VjDq453g2kOso/1GjfGdQBCy/rWUWaezcrqfhv9MPCpR8sVm+Jvxy2qewmPcDizDs3tJH8zuvPNZ8r1GFb1nVbsGhPvk1TurTY98iCUsNrM66AfXrrnPJoqSzExe7Hk/bKjDpaV1etf4+7eaAD8xw/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869771; c=relaxed/simple;
	bh=07QhRdilqXWsGvIKYtBmbEG8HHnxJ4Q9ZP/AqIx4Gps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8H4qclbXDrPCkrW64fq2UsdhlQYEWOOM6+rjGHa7vZK6zjmlwB4Gb1eYY06oSv9xSJJGFzCo0pIS3IvMtrIrl1AE18EBjmewaTLRoz6K8TNMXxDbhZpNZgoLydNtvFT3mRGNxg5QtBoxYk+V8TRNvloRBTphOcTjpFI+Gd8TiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0ut7z7z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750869768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8W/Za/PVXlw/P7/FEoPhVbFeCumw/U1klE0WJ600kKc=;
	b=I0ut7z7zT506lzRWB/39R6MdvpmUrjK8GwfyCbtL+ghgKBs/5C/h7iwxKahKjOihBocovL
	UA+9F8A5h6fJiEYDM7WHvz/j40V9a9lNR2aIbWdrWnBYxrAPgEhNx3YXbOAkzC2P91UVnU
	Axf+wyRddbr+aq+okuWkMpzL7gzaIXs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-oXyJyk2-PGy-IT93ESHbEg-1; Wed,
 25 Jun 2025 12:42:45 -0400
X-MC-Unique: oXyJyk2-PGy-IT93ESHbEg-1
X-Mimecast-MFC-AGG-ID: oXyJyk2-PGy-IT93ESHbEg_1750869763
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 711871800290;
	Wed, 25 Jun 2025 16:42:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AF9F19560A3;
	Wed, 25 Jun 2025 16:42:39 +0000 (UTC)
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
Subject: [PATCH v2 04/16] netfs: Fix looping in wait functions
Date: Wed, 25 Jun 2025 17:41:59 +0100
Message-ID: <20250625164213.1408754-5-dhowells@redhat.com>
In-Reply-To: <20250625164213.1408754-1-dhowells@redhat.com>
References: <20250625164213.1408754-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


