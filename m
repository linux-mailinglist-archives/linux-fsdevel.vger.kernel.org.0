Return-Path: <linux-fsdevel+bounces-29123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A5975AF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 21:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2AB28684D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 19:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBAC1BB691;
	Wed, 11 Sep 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kejn6mRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32CE1BAEF6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083802; cv=none; b=XKDAxi4Zk38cZwAqyxFI+W6+uM0Ly9BJIjY4n6fBCCUNuces3CpfG5ovmh9HNiAYIB2pid7vhV++KoWE0qZEuvSBZvIku6M1RSlJceIMUDIgIWk+T/2rADlD/dDipQbSmSuLSzp1/9n2HC40qleXeEAtgmjAfuPaVwDErrzzuJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083802; c=relaxed/simple;
	bh=JBs0Crisuw7Mx/HDlXn/qHrSZEkKs6TKeOaWubkYBpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqzoE+gEDuQFFcqyqZdQ6yQBkX1rNqb1aFNoUTk3hIoP/sbyPWxHQbWilyQaL4oJq7HPlHbFDzzw1w6rawwt+8rFfkDSQl45hoShBq7QxqBpLmunqgB6esR2M/ahur0amytRYM1fS/OLjjzIaWKK/wz435u50YYdDeRd5cj+Al8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kejn6mRh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726083798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWxsTklmkJjx+Rd0gmMs3KD/KNm3/BpXnllaXcqeyr0=;
	b=Kejn6mRhC/jZdqv3ueDwArfeUB6LzkIIJMUaz71F/ZbhdqWN4sP+Xo50sJ87z8avbBRXTJ
	K2eu1nDudFPBQCEpygkaelewa00mKLvWfgKkR7p4g6W04qA7fTlGlTcqG25NPi7FilMLby
	uLCxPqK392kZDbqhtH8F3Tp70AB0yts=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-Z7upLKxzOmitg9rb7MQx_A-1; Wed,
 11 Sep 2024 15:43:15 -0400
X-MC-Unique: Z7upLKxzOmitg9rb7MQx_A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD3981955F42;
	Wed, 11 Sep 2024 19:43:12 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93A8B1956088;
	Wed, 11 Sep 2024 19:43:07 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Ahring Oder Aring <aahringo@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev,
	ocfs2-devel@lists.linux.dev
Subject: [PATCH v1 1/4] fs: Introduce FOP_ASYNC_LOCK
Date: Wed, 11 Sep 2024 15:42:57 -0400
Message-ID: <3330d5a324abe2ce9c1dafe89cacdc6db41945d1.1726083391.git.bcodding@redhat.com>
In-Reply-To: <cover.1726083391.git.bcodding@redhat.com>
References: <cover.1726083391.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Some lock managers (NLM, kNFSD) fastidiously avoid blocking their
kernel threads while servicing blocking locks.  If a filesystem supports
asynchronous lock requests those lock managers can use notifications to
quickly inform clients they have acquired a file lock.

Historically, only posix_lock_file() was capable of supporting asynchronous
locks so the check for support was simply file_operations->lock(), but with
recent changes in DLM, both GFS2 and OCFS2 also support asynchronous locks
and have started signalling their support with EXPORT_OP_ASYNC_LOCK.

We recently noticed that those changes dropped the checks for whether a
filesystem simply defaults to posix_lock_file(), so async lock
notifications have not been attempted for NLM and NFSv4.1+ for most
filesystems.  While trying to fix this it has become clear that testing
both the export flag combined with testing ->lock() creates quite a
layering mess.  It seems appropriate to signal support with a fop_flag.

Add FOP_ASYNC_LOCK so that filesystems with ->lock() can signal their
capability to handle lock requests asynchronously.  Add a helper for
lock managers to properly test that support.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 include/linux/filelock.h | 5 +++++
 include/linux/fs.h       | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index daee999d05f3..58c1120a8253 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -180,6 +180,11 @@ static inline void locks_wake_up(struct file_lock *fl)
 	wake_up(&fl->c.flc_wait);
 }
 
+static inline bool locks_can_async_lock(const struct file_operations *fops)
+{
+	return !fops->lock || fops->fop_flags & FOP_ASYNC_LOCK;
+}
+
 /* fs/locks.c */
 void locks_free_lock_context(struct inode *inode);
 void locks_free_lock(struct file_lock *fl);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6ca11e241a24..78221ae589d9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2074,6 +2074,8 @@ struct file_operations {
 #define FOP_DIO_PARALLEL_WRITE	((__force fop_flags_t)(1 << 3))
 /* Contains huge pages */
 #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
+/* Supports asynchronous lock callbacks */
+#define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 5))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
-- 
2.44.0


