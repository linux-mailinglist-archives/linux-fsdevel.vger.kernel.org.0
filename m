Return-Path: <linux-fsdevel+bounces-37299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D939B9F0DF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25A51882534
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B41E5716;
	Fri, 13 Dec 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDpay3Wf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2E1E3DF4
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097878; cv=none; b=oup+95/NhGrER0TiaEjT91gdzXXsTpBZeof/mnoijQUvrwxJ4FVKEQgAOwVM4e46YYTmaCQmKLyjNV2DuQMQu0Ekypvnew4aCdZEGTgwoO1HgMJKN1Ft1gL++a43uOhrAOmHxJAxzQFMfiwO6yWH818MNVFLmQfJyzensN3u5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097878; c=relaxed/simple;
	bh=TNL20qCc0MX1tuLmO8EoKTeZbpy0VsJcMbuSs3LqxOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLeW7jSjLPG+tVX2p5bg6YkmImVjHfj3ZiXPyZPyOiM1rKc4mI77UmrAbuL+oSreT5Ss9cZrzNNYzdXX/NaQaRAIeB7EsEZ6I/+YKYRG34RbmiP1gmRzT67PCTYH/wQ1RK1/jfRMIk2Wft6dYjbNHKCPuVWOKf3WZhQ3oMtggGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDpay3Wf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iv9WM7D/h/d7OTq2M7QoeqOwEbcTnPmdrMlMHFXuPOU=;
	b=KDpay3Wf9N1bk21dHvAPJJ+WN/h/WJHQThySi0mDDrxZdRfdNE6a/odtPsJduKZ3MwCaKb
	Q2Oi6yV4wxZYq1beavzcYWz9g19KrCnM3Gh/lyn3UpVrBlxBhOCenzVFn4m3zgTZMRB9/q
	G+rquVcYZns3CxIjhE0NcllkA3SxaV0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-Z0u6tnJ2N66YU4thKkuufg-1; Fri,
 13 Dec 2024 08:51:11 -0500
X-MC-Unique: Z0u6tnJ2N66YU4thKkuufg-1
X-Mimecast-MFC-AGG-ID: Z0u6tnJ2N66YU4thKkuufg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4184F1956089;
	Fri, 13 Dec 2024 13:51:08 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E5001956086;
	Fri, 13 Dec 2024 13:51:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 07/10] netfs: Fix missing barriers by using clear_and_wake_up_bit()
Date: Fri, 13 Dec 2024 13:50:07 +0000
Message-ID: <20241213135013.2964079-8-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Use clear_and_wake_up_bit() rather than something like:

	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);

as there needs to be a barrier inserted between which is present in
clear_and_wake_up_bit().

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Zilin Guan <zilin@seu.edu.cn>
cc: Akira Yokosawa <akiyks@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c  | 3 +--
 fs/netfs/write_collect.c | 9 +++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index b415e3972336..46ce3b7adf07 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -379,8 +379,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq)
 	task_io_account_read(rreq->transferred);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 	netfs_clear_subrequests(rreq, false);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 1d438be2e1b4..82290c92ba7a 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -501,8 +501,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 		goto need_retry;
 	if ((notes & MADE_PROGRESS) && test_bit(NETFS_RREQ_PAUSE, &wreq->flags)) {
 		trace_netfs_rreq(wreq, netfs_rreq_trace_unpause);
-		clear_bit_unlock(NETFS_RREQ_PAUSE, &wreq->flags);
-		wake_up_bit(&wreq->flags, NETFS_RREQ_PAUSE);
+		clear_and_wake_up_bit(NETFS_RREQ_PAUSE, &wreq->flags);
 	}
 
 	if (notes & NEED_REASSESS) {
@@ -605,8 +604,7 @@ void netfs_write_collection_worker(struct work_struct *work)
 
 	_debug("finished");
 	trace_netfs_rreq(wreq, netfs_rreq_trace_wake_ip);
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
-	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
 
 	if (wreq->iocb) {
 		size_t written = min(wreq->transferred, wreq->len);
@@ -714,8 +712,7 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
 
-	clear_bit_unlock(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	wake_up_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS);
+	clear_and_wake_up_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 
 	/* If we are at the head of the queue, wake up the collector,
 	 * transferring a ref to it if we were the ones to do so.


