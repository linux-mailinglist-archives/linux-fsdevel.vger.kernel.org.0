Return-Path: <linux-fsdevel+bounces-44032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A61DA61689
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 17:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B37A19C4B29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4639204094;
	Fri, 14 Mar 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/DDBcMO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A68320371E
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970541; cv=none; b=egYJip1Cly9ap/L1jCKRLNb2kehYoGzh9/VAsfn6KvibRDGzs40XQa6g9O1jbu2NZg+LufIR7cymahNgsFRjBy/fG8p9LI8KbltjtCduIkzTbGeL4KVOLYljqF4ZF49brJcxjsV4ieVqYHjBPY3h5Od9imwYW7+A44xp67QmQKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970541; c=relaxed/simple;
	bh=B9Vtra/fnEBpKgEEZtL6KtLlOQSwA0RKlcyiC2kzEyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHfNOFEGt4ZTHow3ANErIHiOlMGnA1xkbRl4u3u1GSRExR/Aa+1GPVTqKv3ZrJOclqez0PCKjvG89CfCGiPvApZbs5eomr7hrAZlHvT7rq9/uIf1qIvsgok8x/eL12hFjq9gZDTPCcfeWKVnTFjdkpeh+/Ufnn+xOebab99CfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c/DDBcMO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741970537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhnkeTmMNPtZirIgcqaZw7T9FbU/59e8CM+lvG4aOLw=;
	b=c/DDBcMOw9/DHRk60NJ2HzbrzErzJgAuIzdy2hgxxzhTCbHBDt+B2+4P7m2EoP4sBKnccJ
	oDiu7qZDHggryqRXDW8M/Ex0HXz8UjI1DhF2JMgq0Vm70FbbvXgwMSyTOo2lzkTwzlGnif
	G6/nUpxFdRHQS45+liphYBu4KF7M4mY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-4ARRaLLIPiy4bGFWO9Q0nw-1; Fri,
 14 Mar 2025 12:42:15 -0400
X-MC-Unique: 4ARRaLLIPiy4bGFWO9Q0nw-1
X-Mimecast-MFC-AGG-ID: 4ARRaLLIPiy4bGFWO9Q0nw_1741970533
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF0421800262;
	Fri, 14 Mar 2025 16:42:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E819F18001F6;
	Fri, 14 Mar 2025 16:42:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 1/4] netfs: Fix collection of results during pause when collection offloaded
Date: Fri, 14 Mar 2025 16:41:56 +0000
Message-ID: <20250314164201.1993231-2-dhowells@redhat.com>
In-Reply-To: <20250314164201.1993231-1-dhowells@redhat.com>
References: <20250314164201.1993231-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A netfs read request can run in one of two modes: for synchronous reads
writes, the app thread does the collection of results and for asynchronous
reads, this is offloaded to a worker thread.  This is controlled by the
NETFS_RREQ_OFFLOAD_COLLECTION flag.

Now, if a subrequest incurs an error, the NETFS_RREQ_PAUSE flag is set to
stop the issuing loop temporarily from issuing more subrequests until a
retry is successful or the request is abandoned.

When the issuing loop sees NETFS_RREQ_PAUSE, it jumps to
netfs_wait_for_pause() which will wait for the PAUSE flag to be cleared -
and whilst it is waiting, it will call out to the collector as more results
acrue...  But this is the wrong thing to do if OFFLOAD_COLLECTION is set as
we can then end up with both the app thread and the work item collecting
results simultaneously.

This manifests itself occasionally when running the generic/323 xfstest
against multichannel cifs as an oops that's a bit random but frequently
involving io_submit() (the test does lots of simultaneous async DIO reads).

Fix this by only doing the collection in netfs_wait_for_pause() if the
NETFS_RREQ_OFFLOAD_COLLECTION is not set.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Reported-by: Steve French <stfrench@microsoft.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 636cc5a98ef5..23c75755ad4e 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -682,14 +682,16 @@ void netfs_wait_for_pause(struct netfs_io_request *rreq)
 		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
 		prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
 
-		subreq = list_first_entry_or_null(&stream->subrequests,
-						  struct netfs_io_subrequest, rreq_link);
-		if (subreq &&
-		    (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags) ||
-		     test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags))) {
-			__set_current_state(TASK_RUNNING);
-			netfs_read_collection(rreq);
-			continue;
+		if (!test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags)) {
+			subreq = list_first_entry_or_null(&stream->subrequests,
+							  struct netfs_io_subrequest, rreq_link);
+			if (subreq &&
+			    (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags) ||
+			     test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags))) {
+				__set_current_state(TASK_RUNNING);
+				netfs_read_collection(rreq);
+				continue;
+			}
 		}
 
 		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags) ||


