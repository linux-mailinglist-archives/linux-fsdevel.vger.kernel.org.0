Return-Path: <linux-fsdevel+bounces-49412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E58ABBFB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE31189B8D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B62628136C;
	Mon, 19 May 2025 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NV8BqTZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA42820C4
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662527; cv=none; b=lMVcqFTGlBPJ/BWVd/robAR5Ten4GTzjROB0UBUQ+LUixjHLi9HYc/VEfN2kh3OOTgDfPrB3476tZ8vvGqucQdNJaGKfF11gxMknc1Kde4gj6qMLdYP652NLEItKjAcC9lpSzK3uCspzZ2aXiZ3P8g9y650rlF7RRMcQMlDkT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662527; c=relaxed/simple;
	bh=z/2NQrpZU7XHMd73sVYXyM1s0LI4RxI1UroY+nJgPY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5zow551V9w2OAbyuTlZTturhkz6PH/r0xgBPDakaCAJwKfpK3c7doxXNOizVLeePdkD2UOHnmEyaj5tNQPqKGN5GRAPkENFG98yl6YRQv2SCTrXh5K0l9ST9+ecXiayafZnsDyVclW7om+3SDmKRxujTBu0LJHeEZ+SEd0YIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NV8BqTZF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMsLiP3XGQV7eXcZqnf/CvDaoUPHhrXnSqmgsY7y1Vw=;
	b=NV8BqTZFlunuOgAjmkWrDYlzUfgC1FwrCjyZ/qYe4AncBKZI9HzTCRzF+m0W/pSVNeVYXO
	d8GNAmBq/aaOcxzHiWCwm3qMB6GjCwcjRtYAO0RwcTGgaDil3akDB+XzSZqSyZU3PGmN3T
	UnZWdOFWHSo9CoPPa5prtkTi7rNZW1U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-fuzhTDqrOYKUh0siHdF2vA-1; Mon,
 19 May 2025 09:48:40 -0400
X-MC-Unique: fuzhTDqrOYKUh0siHdF2vA-1
X-Mimecast-MFC-AGG-ID: fuzhTDqrOYKUh0siHdF2vA_1747662518
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38D3D195608B;
	Mon, 19 May 2025 13:48:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A22F01956095;
	Mon, 19 May 2025 13:48:34 +0000 (UTC)
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
Subject: [PATCH 02/11] fs/netfs: remove unused flag NETFS_SREQ_SEEK_DATA_READ
Date: Mon, 19 May 2025 14:47:58 +0100
Message-ID: <20250519134813.2975312-3-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Max Kellermann <max.kellermann@ionos.com>

This flag was added by commit 3d3c95046742 ("netfs: Provide readahead
and readpage netfs helpers") but its only user was removed by commit
86b374d061ee ("netfs: Remove fs/netfs/io.c").

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 Documentation/filesystems/netfs_library.rst | 5 -----
 include/linux/netfs.h                       | 1 -
 2 files changed, 6 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 939b4b624fad..ddd799df6ce3 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -712,11 +712,6 @@ handle falling back from one source type to another.  The members are:
      at a boundary with the filesystem structure (e.g. at the end of a Ceph
      object).  It tells netfslib not to retile subrequests across it.
 
-   * ``NETFS_SREQ_SEEK_DATA_READ``
-
-     This is a hint from netfslib to the cache that it might want to try
-     skipping ahead to the next data (ie. using SEEK_DATA).
-
  * ``error``
 
    This is for the filesystem to store result of the subrequest.  It should be
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c86a11cfc4a3..d315d86d0ad4 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -191,7 +191,6 @@ struct netfs_io_subrequest {
 	unsigned long		flags;
 #define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
-#define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
 #define NETFS_SREQ_MADE_PROGRESS	4	/* Set if we transferred at least some data */
 #define NETFS_SREQ_ONDEMAND		5	/* Set if it's from on-demand read mode */
 #define NETFS_SREQ_BOUNDARY		6	/* Set if ends on hard boundary (eg. ceph object) */


