Return-Path: <linux-fsdevel+bounces-51551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47247AD82BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA8217B7E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 05:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C15A25332E;
	Fri, 13 Jun 2025 05:52:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6B2F4311;
	Fri, 13 Jun 2025 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749793951; cv=none; b=mIoV4x1fcQhTNGeQjsIfqTyigPysntDWUDG6sV7dwBcaCPUY/PX4pOQ1VTc9Ec5QZGw3+kH7lJsajNAL9oLuBUSIUjQ6kkrL5h6KUwPXbGheL45ExF1seQq1LRkvhkhio37zwsALagVwtSZMacm9a5MbqruKC//SgZjzaDM/vSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749793951; c=relaxed/simple;
	bh=283HEQqRYfIsNiaMfyVunhuCtCyn94g73x9xYXlByAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H4Yk9KLK7uKOMxFbGirmtcZRbsoWWqyCVVTyT5Ua06g3/9q5kFlwnmSFVB8LhsdZ57Fg/swDeQYp4Xwb6ZvJgWepQuG+yQFY/fiBDN4yCc/yqkznjUwYy9dGzEEIgpKSEF3rGtgxknARAP9tL1AIwUlWnmzrIgBz5IbspmWSuT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <vgoyal@redhat.com>, <stefanha@redhat.com>, <miklos@szeredi.hu>,
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
Date: Fri, 13 Jun 2025 13:50:51 +0800
Message-ID: <20250613055051.1873-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.51.57
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Since clear_bit is an atomic operation, the spinlock is redundant and
can be removed, reducing lock contention is good for performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 fs/fuse/virtio_fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8f2e2f3..de34179 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -791,9 +791,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 		}
 	}
 
-	spin_lock(&fpq->lock);
 	clear_bit(FR_SENT, &req->flags);
-	spin_unlock(&fpq->lock);
 
 	fuse_request_end(req);
 	spin_lock(&fsvq->lock);
-- 
2.9.4


