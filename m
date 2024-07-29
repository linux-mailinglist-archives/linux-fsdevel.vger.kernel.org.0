Return-Path: <linux-fsdevel+bounces-24468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A493FA94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798AD2851DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B9185E7F;
	Mon, 29 Jul 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y01MxTMJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821115ECDC
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270047; cv=none; b=sWLk3/NWYvpmpMZY0noyB7ZYwfz3HKoBQ/vJMr9hdhnFIOK+E/tX9x0NYvlKIv6k8RaVH95dirF68FVGlsmyJbj3yzntTsv27CS2HK+cO3s+WMQR2FMUKpClP0lVvzpTzm3LoVyf3Dq011YG5JUnd7epxunqRZhsqp4IxB9DjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270047; c=relaxed/simple;
	bh=dSBDPG/FjcygfFFDbaMBvikq9ZldreOsesR4n2CHWMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dv+Lrw/qV19mzU9/rRlsyJRibVrfwan0RiomsVEYzKHu8gwP2Db4IIGH5DS/h2rWByV4qb9hE0iWlAJyAALy2jhKWaPWaKpFDID6WnjPZR5gkZkPif1y/iyBZ44Frf2nnqvRr+Quvpp0OPAYTu8wM6IEzYHIco4+IVK+vO96PWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y01MxTMJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nD8BuDcHuaWMd5Fn2FK+IU9NPvXO40RV6M0I0jL+Pvo=;
	b=Y01MxTMJaln3Y3iMS4NWKjSzksMFc5XCpaz3w/UvBWSP3mmnD9XYR7yeUVc33B+JeIaTQu
	ppjXNiRqFDjH2yCNE6h1u81TKyPKmKGhAs8sD8wwzcbdnwDvuqEt6jSOhz/LjX0OBFtOvq
	6w1Eptum1OlygxkzEtWsrOori7reAfw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-Wrs6ae_MPFKUPRt8EssjBw-1; Mon,
 29 Jul 2024 12:20:41 -0400
X-MC-Unique: Wrs6ae_MPFKUPRt8EssjBw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24DDC1955F08;
	Mon, 29 Jul 2024 16:20:38 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF3B819560AA;
	Mon, 29 Jul 2024 16:20:31 +0000 (UTC)
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
Subject: [PATCH 03/24] netfs: Adjust labels in /proc/fs/netfs/stats
Date: Mon, 29 Jul 2024 17:19:32 +0100
Message-ID: <20240729162002.3436763-4-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Adjust the labels in /proc/fs/netfs/stats that refer to netfs-specific
counters.  These currently all begin with "Netfs", but change them to begin
with more specific labels.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/stats.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 0892768eea32..95ed2d2623a8 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -42,39 +42,39 @@ atomic_t netfs_n_wh_write_failed;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "Netfs  : DR=%u RA=%u RF=%u WB=%u WBZ=%u\n",
+	seq_printf(m, "Reads  : DR=%u RA=%u RF=%u WB=%u WBZ=%u\n",
 		   atomic_read(&netfs_n_rh_dio_read),
 		   atomic_read(&netfs_n_rh_readahead),
 		   atomic_read(&netfs_n_rh_read_folio),
 		   atomic_read(&netfs_n_rh_write_begin),
 		   atomic_read(&netfs_n_rh_write_zskip));
-	seq_printf(m, "Netfs  : BW=%u WT=%u DW=%u WP=%u\n",
+	seq_printf(m, "Writes : BW=%u WT=%u DW=%u WP=%u\n",
 		   atomic_read(&netfs_n_wh_buffered_write),
 		   atomic_read(&netfs_n_wh_writethrough),
 		   atomic_read(&netfs_n_wh_dio_write),
 		   atomic_read(&netfs_n_wh_writepages));
-	seq_printf(m, "Netfs  : ZR=%u sh=%u sk=%u\n",
+	seq_printf(m, "ZeroOps: ZR=%u sh=%u sk=%u\n",
 		   atomic_read(&netfs_n_rh_zero),
 		   atomic_read(&netfs_n_rh_short_read),
 		   atomic_read(&netfs_n_rh_write_zskip));
-	seq_printf(m, "Netfs  : DL=%u ds=%u df=%u di=%u\n",
+	seq_printf(m, "DownOps: DL=%u ds=%u df=%u di=%u\n",
 		   atomic_read(&netfs_n_rh_download),
 		   atomic_read(&netfs_n_rh_download_done),
 		   atomic_read(&netfs_n_rh_download_failed),
 		   atomic_read(&netfs_n_rh_download_instead));
-	seq_printf(m, "Netfs  : RD=%u rs=%u rf=%u\n",
+	seq_printf(m, "CaRdOps: RD=%u rs=%u rf=%u\n",
 		   atomic_read(&netfs_n_rh_read),
 		   atomic_read(&netfs_n_rh_read_done),
 		   atomic_read(&netfs_n_rh_read_failed));
-	seq_printf(m, "Netfs  : UL=%u us=%u uf=%u\n",
+	seq_printf(m, "UpldOps: UL=%u us=%u uf=%u\n",
 		   atomic_read(&netfs_n_wh_upload),
 		   atomic_read(&netfs_n_wh_upload_done),
 		   atomic_read(&netfs_n_wh_upload_failed));
-	seq_printf(m, "Netfs  : WR=%u ws=%u wf=%u\n",
+	seq_printf(m, "CaWrOps: WR=%u ws=%u wf=%u\n",
 		   atomic_read(&netfs_n_wh_write),
 		   atomic_read(&netfs_n_wh_write_done),
 		   atomic_read(&netfs_n_wh_write_failed));
-	seq_printf(m, "Netfs  : rr=%u sr=%u wsc=%u\n",
+	seq_printf(m, "Objs   : rr=%u sr=%u wsc=%u\n",
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq),
 		   atomic_read(&netfs_n_wh_wstream_conflict));


