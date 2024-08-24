Return-Path: <linux-fsdevel+bounces-27027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754AF95DDAA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 13:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165591F22393
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801B617625A;
	Sat, 24 Aug 2024 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik6E3l3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2F1714B9
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724500631; cv=none; b=m9g8fDtPl79FQyFSvx4CqiHGpWyG+vo2JJYC8ktExF1MA8VJ95q0saO+9Gx+rLihtUwEueevJDsiPo2S4qv/vwxbrjYHHKUbVelzc1AEzlPdHdCOqm167oj85Cj/2xp41O7c8Fc0utZF7tQsf427NOd8HjErOOoOl43Nynm+BR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724500631; c=relaxed/simple;
	bh=IMUjvNv1A8WNE3OqnOHhUAD1EEtgyW1G59Xb24cgceQ=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=eSqK4rSL6vK4RQYpVbBtS/dunMTyPIGP9W6r1mRf+k+jpYImMY2uD5gZn54d4t4diNEgWe+w+xgCVWod8qDmc5MrUPTPsGk/2+Ef2FHJ1Sb6BOoKvr+cWcDGikUCuH8h3VPSPceJ5gju9Nn0bqTimNlD50hEqza7Rs5RpgFnZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ik6E3l3i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724500628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7MlSZRgX4NtPTJfbL1OG/C/fCyXDm1yZsFhC7WYkkOo=;
	b=ik6E3l3ihYfC39vb/oZ1HuAsevce3MQPmPa++1Es3+3CQi9VCPvJDOv6Gg3eBLjD/Hax8P
	Zpt/SpUnIOWnHqnPNGaXI7jziEY50WiRs8cUpHjFrfnZA2mF8jXoW1sqf+CvbhEZNaSSOU
	ebhcDsjom0RQFb/n/H+xukjm/ryC5D0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-dsco4DIKOqS_7UEUarFQjQ-1; Sat,
 24 Aug 2024 07:57:03 -0400
X-MC-Unique: dsco4DIKOqS_7UEUarFQjQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A55D61955F43;
	Sat, 24 Aug 2024 11:56:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C96919560AA;
	Sat, 24 Aug 2024 11:56:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Steve French <sfrench@samba.org>,
    Pankaj Raghav <p.raghav@samsung.com>,
    Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH 10/9] netfs: Fix interaction of streaming writes with zero-point tracker
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <563285.1724500613.1@warthog.procyon.org.uk>
Date: Sat, 24 Aug 2024 12:56:53 +0100
Message-ID: <563286.1724500613@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

    
When a folio that is marked for streaming write (dirty, but not uptodate,
with partial content specified in the private data) is written back, the
folio is effectively switched to the blank state upon completion of the
write.  This means that if we want to read it in future, we need to reread
the whole folio.

However, if the folio is above the zero_point position, when it is read
back, it will just be cleared and the read skipped, leading to apparent
local corruption.

Fix this by increasing the zero_point to the end of the dirty data in the
folio when clearing the folio state after writeback.  This is analogous to
the folio having ->release_folio() called upon it.

This was causing the config.log generated by configuring a cpython tree on
a cifs share to get corrupted because the scripts involved were appending
text to the file in small pieces.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_collect.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 426cf87aaf2e..ae7a2043f670 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -33,6 +33,7 @@
 int netfs_folio_written_back(struct folio *folio)
 {
 	enum netfs_folio_trace why = netfs_folio_trace_clear;
+	struct netfs_inode *ictx = netfs_inode(folio->mapping->host);
 	struct netfs_folio *finfo;
 	struct netfs_group *group = NULL;
 	int gcount = 0;
@@ -41,6 +42,12 @@ int netfs_folio_written_back(struct folio *folio)
 		/* Streaming writes cannot be redirtied whilst under writeback,
 		 * so discard the streaming record.
 		 */
+		unsigned long long fend;
+
+		fend = folio_pos(folio) + finfo->dirty_offset + finfo->dirty_len;
+		if (fend > ictx->zero_point)
+			ictx->zero_point = fend;
+
 		folio_detach_private(folio);
 		group = finfo->netfs_group;
 		gcount++;


