Return-Path: <linux-fsdevel+bounces-51685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0FADA1DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 15:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B9216FCAA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6823526A0F5;
	Sun, 15 Jun 2025 13:22:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13E1BC07A;
	Sun, 15 Jun 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749993753; cv=none; b=U7AOGkumcfIrwYRS709Zd1V5/E0xlEwmWKH4UrcUapLABEdPmT9Rx2YwvEkM1M4n+e3qnyq5eHKIIhtFKDU48d7vMmF1jkG9OKCs17uT3OvXOTDPwdC9lKClrY2398NBxvZeyFTj1doMP0hyhI47ylNRZZE8t6lta5lo0RLY3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749993753; c=relaxed/simple;
	bh=bm9j9HkN3DmglJ1pTLJS9Rx8RMb/Sg5+HWlI77noIqk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DOOkO+YLcORjcAMlgjLoc67V5//ttlRpe1laLSmRocH+PRXGiARb97JtNBL9SlbaHM3RoYjgWeVYKhTM01mqoAudSq46zGAgOzOPE8nOO+CF60tqpsKhmgUTs+OSp2ttYgQuzbnYKtjv4MRLB0SLUOmQn3bK0zoowne07vmS82M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <vgoyal@redhat.com>, <stefanha@redhat.com>, <miklos@szeredi.hu>,
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
Date: Sun, 15 Jun 2025 21:20:39 +0800
Message-ID: <20250615132039.2051-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc3.internal.baidu.com (172.31.50.47) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.42
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Since clear_bit is an atomic operation, the spinlock is redundant and
can be removed, reducing lock contention is good for performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: remove unused variable "fpq"

 fs/fuse/virtio_fs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 53c2626..b8a99d3 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -762,7 +762,6 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 static void virtio_fs_request_complete(struct fuse_req *req,
 				       struct virtio_fs_vq *fsvq)
 {
-	struct fuse_pqueue *fpq = &fsvq->fud->pq;
 	struct fuse_args *args;
 	struct fuse_args_pages *ap;
 	unsigned int len, i, thislen;
@@ -791,9 +790,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 		}
 	}
 
-	spin_lock(&fpq->lock);
 	clear_bit(FR_SENT, &req->flags);
-	spin_unlock(&fpq->lock);
 
 	fuse_request_end(req);
 	spin_lock(&fsvq->lock);
-- 
2.9.4


