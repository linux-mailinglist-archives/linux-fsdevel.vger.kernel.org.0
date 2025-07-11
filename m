Return-Path: <linux-fsdevel+bounces-54660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAE5B02026
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0207B1ACE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2F72EAB91;
	Fri, 11 Jul 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKgJSxAO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02D2EAB6A
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246626; cv=none; b=bT9UdrGqr14wB7/2GpNTqbmLQi+HeAdmEl82fHh9Vm5T1JlcXuIgwT4KOwACoV1lqJFIPFTDHnALHjDlZZHWWE9nRC1E++YAviBzVGGCTUWAQCwEplVGIpaB8M1xTUWJKrT5I09aI/iwowmTHHT8STbCH0cYFG1HpIk7rNBXpM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246626; c=relaxed/simple;
	bh=MeppipE/GGmLaf57EKX5cUWRi0NlKJh6BL0PKJ8lK2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTSFNQec14IKExB1BJcLXQ1khrz6wkc71hX7LD7spLYc8M4/XDo8xhvoejrLp0KxIZLXzgDKeadXNe3KOFgSUEZhqmNmt09WLIEQo1qaIf+2wZR+38nBzb3/hyEvtfd7/OiX4N33bRIVd/1Cfk3epfQDEPBf9/MHPs9LVO4UzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKgJSxAO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752246622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pc5FzNIdg3WFubvviC+DcGJF9AwcHV22plX0nL1O8S4=;
	b=gKgJSxAObiPSjriIl6Eela7yyJvzQUKSYrS6L+WHwJw7HGuZ9ybwb6GuPp7yEq6p3eAHmk
	+tWyzYaKnJtcFO35C2PDF+MEuARqjrZx9dOrlLeoN9Bu8eojyNtSxedDx0Gn26JdJI68rz
	otTWBbgzAB9W+Ith4gGwarHBhuWJtb0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-YyjQvG9vNJSBWYOHqSxvag-1; Fri,
 11 Jul 2025 11:10:19 -0400
X-MC-Unique: YyjQvG9vNJSBWYOHqSxvag-1
X-Mimecast-MFC-AGG-ID: YyjQvG9vNJSBWYOHqSxvag_1752246617
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B3C318089B4;
	Fri, 11 Jul 2025 15:10:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A15931977029;
	Fri, 11 Jul 2025 15:10:13 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] netfs: Fix copy-to-cache so that it performs collection with ceph+fscache
Date: Fri, 11 Jul 2025 16:10:00 +0100
Message-ID: <20250711151005.2956810-2-dhowells@redhat.com>
In-Reply-To: <20250711151005.2956810-1-dhowells@redhat.com>
References: <20250711151005.2956810-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The netfs copy-to-cache that is used by Ceph with local caching sets up a
new request to write data just read to the cache.  The request is started
and then left to look after itself whilst the app continues.  The request
gets notified by the backing fs upon completion of the async DIO write, but
then tries to wake up the app because NETFS_RREQ_OFFLOAD_COLLECTION isn't
set - but the app isn't waiting there, and so the request just hangs.

Fix this by setting NETFS_RREQ_OFFLOAD_COLLECTION which causes the
notification from the backing filesystem to put the collection onto a work
queue instead.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/r/CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/netfs/read_pgpriv2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 5bbe906a551d..080d2a6a51d9 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -110,6 +110,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_copy_to_cache(
 	if (!creq->io_streams[1].avail)
 		goto cancel_put;
 
+	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &creq->flags);
 	trace_netfs_write(creq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
 	rreq->copy_to_cache = creq;


