Return-Path: <linux-fsdevel+bounces-52019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC0EADE50B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 09:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE1E1895C0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32527EFE8;
	Wed, 18 Jun 2025 07:58:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6747027442;
	Wed, 18 Jun 2025 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750233518; cv=none; b=swUliCERqFFwOPIh+vpJtCMgA9Zssg5vUM2Mt+WaESLdPN0wT4KVmPXGjheJUMyMAAIW8FoyNf2+/QgMxIXRdmfJ2CU/f8ILx6nQzB7QRffOKWWH9Vby2eKZlS/dR6UufSQXkCwpu7GAFSQHI1UyFCCPWpLd/cqGk16fG5Ly+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750233518; c=relaxed/simple;
	bh=EJDoq0UQGCTKftFym7aZqOmhudWniKAnk8XABrNLrSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9fGOnFWEENZRH/xdLob5Rd2kM2SNHA3tEwzwHrZ2O+MpE21EsFr8MNF77afP6zNbr5engqgb4lvBZb6MV6YWjIDbTr9GO697tDn9OAv4GvLNuRIQyaQ3fUj5vTKxKvfSoFVuF9DdismByGQAr/QpXUjD6eg+lX7JOLQ0LI/1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bMbhf0GGvz9scZ;
	Wed, 18 Jun 2025 09:58:26 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Cc: kernel@pankajraghav.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2] fs/buffer: remove comment about hard sectorsize
Date: Wed, 18 Jun 2025 09:58:21 +0200
Message-ID: <20250618075821.111459-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bMbhf0GGvz9scZ

Commit e1defc4ff0cf ("block: Do away with the notion of hardsect_size")
changed hardsect_size to logical block size. The comment on top still
says hardsect_size.

Remove the comment as the code is pretty clear. While we are at it,
format the relevant code.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8cf4a1dc481e..a14d281c6a74 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1122,9 +1122,8 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 {
 	bool blocking = gfpflags_allow_blocking(gfp);
 
-	/* Size must be multiple of hard sectorsize */
-	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
-			(size < 512 || size > PAGE_SIZE))) {
+	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
+		     (size < 512 || size > PAGE_SIZE))) {
 		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
 					size);
 		printk(KERN_ERR "logical block size: %d\n",

base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.49.0


