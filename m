Return-Path: <linux-fsdevel+bounces-61738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7C8B5984A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223A9463000
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E1933CE98;
	Tue, 16 Sep 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WbSYwM5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971D931E10D;
	Tue, 16 Sep 2025 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030816; cv=none; b=Bo01P3vpKtVPdfYbA6Nbgne6iDiP2NsfzwQmohBajlvqVBi/Yi3We/XyGGK6M9xCgtrhgPC7niGFzPzJBheRN8EPWFrNlHzwflgF2mgMaIDUroBKwPYYw0hdJCbW3kS1gm/rEYA7Ng55gq/9qRcN5YzsGBrxODU0ntCPe2WzApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030816; c=relaxed/simple;
	bh=ObnaGSSBvgRTHsZ5n03hXV6xIAMyav8R1ErbqsEiEhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUk5xyf0SRkvLSjDBNyjjlW54WAwzePQ964320pdHY1ehf8chZSSzSYAFdImsUyFmGH6XbXQsWjH70fYlJGApJj3JWa4HRsQZ15O7ih2QHVUHWcoUBDR+l8D9UFSsPFie0jf8WBL2s/hw62SU03/YxmQbMRlaiPbTulKZ4Twh7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WbSYwM5K; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tmF4OccLdgsVZtebYdUSAH/Uj8VZI2v9HZazcjtFpKE=; b=WbSYwM5K/xXnlv6OFRqIKbvhTE
	Q7GNx330eOSHOZYHyRpwGioaWEfeaOJvkTTkIy3gfbt4aK9oI2DTwNGCkk3sFvjfc4Njt447sXY00
	gt/JISVukiRQyueQmJN0195DChxDn69Q2tx91EZOarn4qDJKJy+6oTBZ9KCsJIl7zM1rD1YLwAr/J
	nTNZkeKbBfwXyilPt4ryKIkRg0fXKEF9HbiFHaZNUrVzvczU6mK7dRZdqjGAZH6JrPYMytQSj/Ny4
	6+36AcSI9k2byN6M595xNzEf3bY/Ni7dFUiznFX2S3KYjAu8qFHqdihvgC8lzbFUz+VQeWOKysKOw
	4iVBYcow==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyW7T-00CH0w-H5; Tue, 16 Sep 2025 15:53:19 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	Laura Promberger <laura.promberger@cern.ch>,
	Dave Chinner <david@fromorbit.com>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v6 4/4] fuse: refactor fuse_conn_put() to remove negative logic.
Date: Tue, 16 Sep 2025 14:53:10 +0100
Message-ID: <20250916135310.51177-5-luis@igalia.com>
In-Reply-To: <20250916135310.51177-1-luis@igalia.com>
References: <20250916135310.51177-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no functional change with this patch.  It simply refactors
function fuse_conn_put() to not use negative logic, which makes it more
easier to read.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/inode.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c054f02e661d..80cce3bb6b00 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1012,27 +1012,28 @@ static void delayed_release(struct rcu_head *p)
 
 void fuse_conn_put(struct fuse_conn *fc)
 {
-	if (refcount_dec_and_test(&fc->count)) {
-		struct fuse_iqueue *fiq = &fc->iq;
-		struct fuse_sync_bucket *bucket;
-
-		if (IS_ENABLED(CONFIG_FUSE_DAX))
-			fuse_dax_conn_free(fc);
-		if (fc->timeout.req_timeout)
-			cancel_delayed_work_sync(&fc->timeout.work);
-		cancel_work_sync(&fc->epoch_work);
-		if (fiq->ops->release)
-			fiq->ops->release(fiq);
-		put_pid_ns(fc->pid_ns);
-		bucket = rcu_dereference_protected(fc->curr_bucket, 1);
-		if (bucket) {
-			WARN_ON(atomic_read(&bucket->count) != 1);
-			kfree(bucket);
-		}
-		if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
-			fuse_backing_files_free(fc);
-		call_rcu(&fc->rcu, delayed_release);
+	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_sync_bucket *bucket;
+
+	if (!refcount_dec_and_test(&fc->count))
+		return;
+
+	if (IS_ENABLED(CONFIG_FUSE_DAX))
+		fuse_dax_conn_free(fc);
+	if (fc->timeout.req_timeout)
+		cancel_delayed_work_sync(&fc->timeout.work);
+	cancel_work_sync(&fc->epoch_work);
+	if (fiq->ops->release)
+		fiq->ops->release(fiq);
+	put_pid_ns(fc->pid_ns);
+	bucket = rcu_dereference_protected(fc->curr_bucket, 1);
+	if (bucket) {
+		WARN_ON(atomic_read(&bucket->count) != 1);
+		kfree(bucket);
 	}
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		fuse_backing_files_free(fc);
+	call_rcu(&fc->rcu, delayed_release);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_put);
 

