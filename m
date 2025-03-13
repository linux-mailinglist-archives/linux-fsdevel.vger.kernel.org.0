Return-Path: <linux-fsdevel+bounces-43979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04076A605E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFF94223A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D282B20FABB;
	Thu, 13 Mar 2025 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfCrOwv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91C20F086
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908946; cv=none; b=Mhr8HXnm4PvEYQxzKzdIX2WsM9uSLBL3vV95G+sAwOYIU71rI3zUVrY8dMDU8rleHYNi00OudQxiKJEuP+LPbbhrGZPX8EnaghYmkaCTakPQCfc701YiOG5KkBJoyHFpAKHqEWtM5COxZjT56bJytaQboQ9KeByuQ11EwMvtMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908946; c=relaxed/simple;
	bh=uny3v++/iPmenzGDz3NHnhj0MBwuYiajQoqDAzVy0pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrKv/+9pizl00ep2/JrgHBm3FFX8QD2d48eygkLQMoPLYipKk3BEFWJc/nPEkPaIOFw5zGjcz8lQzOwvxoWuSmuLXByP2iJdJBUlmvodoconoi7YTwMml8yQf0JedVXIZyxzPsMgogn3vM2vmbkS3gHIFhB/HhwwTvX2SL7IMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfCrOwv6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCZDwnJsjHU0vEGdI7THy8y1XEAMyhcYhOuUJ0O6NiA=;
	b=BfCrOwv6awKee7wV4rPTtHecLTHJBQNg5gcs3kpIupPwf4nm40kZtfgGnqAw/tKceBGhx4
	qRRcoStHiSqGu6sPnM8SPgRLLo9czNyquU6WTmf+81RoYSKYp9g1/bTPZbpwutNVM7ARMj
	7DyTsEiS3ts6R76DotJhGgdgzEyoIbs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-EjBfogNUNre6JggkmeyI-w-1; Thu,
 13 Mar 2025 19:35:42 -0400
X-MC-Unique: EjBfogNUNre6JggkmeyI-w-1
X-Mimecast-MFC-AGG-ID: EjBfogNUNre6JggkmeyI-w_1741908941
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35D461955E90;
	Thu, 13 Mar 2025 23:35:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFE501955BCB;
	Thu, 13 Mar 2025 23:35:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 30/35] netfs: Make netfs_page_mkwrite() use folio_mkwrite_check_truncate()
Date: Thu, 13 Mar 2025 23:33:22 +0000
Message-ID: <20250313233341.1675324-31-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Make netfs_page_mkwrite() use folio_mkwrite_check_truncate() rather than
doing the checks itself (and it doesn't currently do all the checks).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 12ddbe9bc78b..64a0f0620399 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -506,7 +506,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 
 	if (folio_lock_killable(folio) < 0)
 		goto out;
-	if (folio->mapping != mapping)
+	if (folio_mkwrite_check_truncate(folio, inode) < 0)
 		goto unlock;
 	if (folio_wait_writeback_killable(folio) < 0)
 		goto unlock;


