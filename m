Return-Path: <linux-fsdevel+bounces-79379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCqgFCU8qGl6rQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:05:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CFB200F27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74B973051DEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA23AE19A;
	Wed,  4 Mar 2026 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cu6CoMHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95C3A7825
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633051; cv=none; b=nYNxIki1ev2rI9BARaujcI6AVG8h0hmppR3i9bk1dwxGd75zu1YrxMdtrhzTlxfEshzrijmqvL0nmW9ZLhO5p8vd4kgvw2uCoHFGvX+IvNrKPrNArVOfwYQpemE4yQ35MtVsbOQ5TsAuH3J7GNmvtQ4+YRWZNl8RNWY7gjAmjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633051; c=relaxed/simple;
	bh=HROgkIywW9fGPMpKBzdZ5dgkdd1AaKOCkuJgEneRTqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy9FAruwnzmLmd3qfku3FMG2LSXbtYjjNxwX6BcKNhwWLnNOG8bS0aYocUqEfzCkYTMeGIfrhemmJgyESdlsnFJzPhGp4yAkMXqlFEWFnOEJJQic7lfgLeKOc3Q6iGmLESNNOxn3pUeVz1WDzFa1rOf2T5RzB6jEAXL2VEgsAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cu6CoMHr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gQFJg7RkppjPQakl5EHx+t4GLbWiGOypk7Lzf+iCHM=;
	b=Cu6CoMHrmS8fIVxNr4irrHeGEh3aBFzpPUrAq1NmzHJKtLVfALaY+otmu/ysYcikZKSP09
	RClj/g4PvBd3Ll7P8biYzWV8rNOwZZIcoNUG+P8NJg5CpMvLmvw4yplvLNCJDTYaMiKu7b
	PyFzbpKmoMR9aB/bWrIvOFufofjzvSI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-ETw9p9BzOrycTv6CnItv0g-1; Wed,
 04 Mar 2026 09:04:03 -0500
X-MC-Unique: ETw9p9BzOrycTv6CnItv0g-1
X-Mimecast-MFC-AGG-ID: ETw9p9BzOrycTv6CnItv0g_1772633040
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B28C818005B9;
	Wed,  4 Mar 2026 14:03:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CE8E1800767;
	Wed,  4 Mar 2026 14:03:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 02/17] vfs: Implement a FIEMAP callback
Date: Wed,  4 Mar 2026 14:03:09 +0000
Message-ID: <20260304140328.112636-3-dhowells@redhat.com>
In-Reply-To: <20260304140328.112636-1-dhowells@redhat.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 04CFB200F27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79379-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:email,infradead.org:email,talpey.com:email]
X-Rspamd-Action: no action

Implement a callback in the internal kernel FIEMAP API so that kernel users
can make use of it as the filler function expects to write to userspace.
This allows the FIEMAP data to be captured and parsed.  This is useful for
cachefiles and also potentially for knfsd and ksmbd to implement their
equivalents of FIEMAP remotely rather than using SEEK_DATA/SEEK_HOLE.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: Namjae Jeon <linkinjeon@kernel.org>
cc: Tom Talpey <tom@talpey.com>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/ioctl.c             | 29 ++++++++++++++++++++---------
 include/linux/fiemap.h |  3 +++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1c152c2b1b67..f0513e282eb7 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -93,6 +93,21 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
 	return error;
 }
 
+static int fiemap_fill(struct fiemap_extent_info *fieinfo,
+		       const struct fiemap_extent *extent)
+{
+	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
+
+	dest += fieinfo->fi_extents_mapped;
+	if (copy_to_user(dest, extent, sizeof(*extent)))
+		return -EFAULT;
+
+	fieinfo->fi_extents_mapped++;
+	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
+		return 1;
+	return 0;
+}
+
 /**
  * fiemap_fill_next_extent - Fiemap helper function
  * @fieinfo:	Fiemap context passed into ->fiemap
@@ -112,7 +127,7 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 			    u64 phys, u64 len, u32 flags)
 {
 	struct fiemap_extent extent;
-	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
+	int ret;
 
 	/* only count the extents */
 	if (fieinfo->fi_extents_max == 0) {
@@ -140,13 +155,9 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 	extent.fe_length = len;
 	extent.fe_flags = flags;
 
-	dest += fieinfo->fi_extents_mapped;
-	if (copy_to_user(dest, &extent, sizeof(extent)))
-		return -EFAULT;
-
-	fieinfo->fi_extents_mapped++;
-	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
-		return 1;
+	ret = fieinfo->fi_fill(fieinfo, &extent);
+	if (ret != 0)
+		return ret; /* 1 to stop. */
 	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
 }
 EXPORT_SYMBOL(fiemap_fill_next_extent);
@@ -199,7 +210,7 @@ EXPORT_SYMBOL(fiemap_prep);
 static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 {
 	struct fiemap fiemap;
-	struct fiemap_extent_info fieinfo = { 0, };
+	struct fiemap_extent_info fieinfo = { .fi_fill = fiemap_fill, };
 	struct inode *inode = file_inode(filp);
 	int error;
 
diff --git a/include/linux/fiemap.h b/include/linux/fiemap.h
index 966092ffa89a..01929ca4b834 100644
--- a/include/linux/fiemap.h
+++ b/include/linux/fiemap.h
@@ -11,12 +11,15 @@
  * @fi_extents_mapped:	Number of mapped extents
  * @fi_extents_max:	Size of fiemap_extent array
  * @fi_extents_start:	Start of fiemap_extent array
+ * @fi_fill:		Function to fill the extents array
  */
 struct fiemap_extent_info {
 	unsigned int fi_flags;
 	unsigned int fi_extents_mapped;
 	unsigned int fi_extents_max;
 	struct fiemap_extent __user *fi_extents_start;
+	int (*fi_fill)(struct fiemap_extent_info *fiefinfo,
+		       const struct fiemap_extent *extent);
 };
 
 int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,


