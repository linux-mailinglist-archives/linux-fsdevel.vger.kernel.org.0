Return-Path: <linux-fsdevel+bounces-48464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B825AAF616
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 10:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576443A56EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 08:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A898263C77;
	Thu,  8 May 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhmRAVO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A44248191;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694454; cv=none; b=rl3kmL7gX+vxjjqLJMx1I6f5n5BPxVM5+9NegVK1c4lCwU2mf3Bkx/tA4ySFmXPo8nLVthUcTCSbsnWT+nZZRVIz1EjofPwQgbIEDo/1hUwQQjut3NUY0jcyt1ZLU2KOCPfmvj1DRY4yzaxt3VCpvAQUUhisYrymDo0E29Q79IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694454; c=relaxed/simple;
	bh=jjPID4iNZ9lsWFeGx9tgwL5daAD9QihLoIV1UwG3uHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GxCvd1R9c2Wt300gG0B5J+9ttf3hxH6CocC9u1BHb6dEES7uRN3RIqcEM3LxydkN/5bc6WGQhXfG83osz3xM/yOYv8/8M5q3OaAvFYgyRBxA3oXkIKC41GhLTw/UaSAopMGusc1W1wThEytzdo/2zE538FAe6+9pCh9pJyg0sY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhmRAVO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67757C4CEEF;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746694454;
	bh=jjPID4iNZ9lsWFeGx9tgwL5daAD9QihLoIV1UwG3uHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IhmRAVO+6nPeMGxI1wPK/u5sbsPtBPew71tY/49aGHqSPfU/HBj39abjdgOEJKSwl
	 sKh8Ai9j1rCORd1ULKzL+7vm7JZsN4oG3SMV93+4Hz2TspafgWGYroT8A5GaoTVcWF
	 xPVtVgG2sl4lLD0gGn1L7jjyQmECY8gAD5j6h4h1JyNzNzbWpOwNrwuDvAWdfbMErs
	 gux6IO1F+eQsk5sPP3zprokL6TJitvkmf7CW9ySF6MKDfyvEbiyETyXV/FawX7wN+F
	 GRHz13mLIbfcdvW1ykGR5osfxK3k4OKIfVtXHT7qUtfSwvM0PRxIZPwyCfYFDpmEp7
	 21HtWv4+id43g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D030C3ABC5;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Thu, 08 May 2025 16:53:46 +0800
Subject: [PATCH v2 3/3] fs: fuse: add more information to fdinfo
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-fusectl-backing-files-v2-3-62f564e76984@uniontech.com>
References: <20250508-fusectl-backing-files-v2-0-62f564e76984@uniontech.com>
In-Reply-To: <20250508-fusectl-backing-files-v2-0-62f564e76984@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=0Usdqy+7Asx6fqMH6X+wT2PYlWAlDQn+W9qv/u/h9TY=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoHHEuCjLMX1HS7YeEQWeIQNz8go3kor8PXgOov
 RAJI8eO2XKJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBxxLgAKCRB2HuYUOZmu
 i0zyD/9UEDcvVt5Xc06A8bhf2eIwwEUupq1sIcxxbaFoZPX7gZltpT9hefdEew6/RqyG3GQgzBk
 bICfKPwTw43zc+NDfiPsFT0nuxnXeCq3XPLWgFv9BLSUFF4wr1Yws89ErCvQAnhyAnCMBWfIN76
 NH44o9vGv6BhWUh88IOIzwARwi+4NHGYEDZbz4RC0+oaF+y2I4qX134XiKGvrixDq9iK3kYR+hi
 kqjEVvcKGYK4HKusJGs2WrOIbUdl8XGTfjhdIsx/nJJg4+tP7GqNbNXVOvPhM1sHMGlRePTF0m5
 8SqeHXrQ+FvnFcn6emtJRc7d0llydUETw37wgjpQOAbdyvzuwTeFkHIx7NYPEjYHcdTmzVjF9So
 7rTSc3Dtj/Rh1jKPpR/idITbjTyH0P5FPlbXIK719IK2FLgu0O1rcfFy5tD+lFLi+cWF6MDFSdE
 jhAlHTuTXhVUcLA2qndYSrnv6JmiqkTNUfn49ZUS317QrWMo5tRD1yRho+7PIwLdWnrJxamO9CU
 nCrPB4FyLQAZi/D3VQ2XRpjzSN0fSFqxCowVRlVSV+f6sUOg95yeMkkCbfWXzH2bTIwuhxaEbpp
 081h74V2r+BEJyQnDxNNnNoe30opiOehVLkUbmZb85RMiy6eyWbjzunfUfrRlnJgEl6jSan4RYY
 FVhMxwBmzFuGMbw==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
Reply-To: chenlinxuan@uniontech.com

From: Chen Linxuan <chenlinxuan@uniontech.com>

This commit add fuse connection device id and backing_id, if any, to
fdinfo of opened fuse files.

Related discussions can be found at links below.

Link: https://lore.kernel.org/all/CAOQ4uxgS3OUy9tpphAJKCQFRAn2zTERXXa0QN_KvP6ZOe2KVBw@mail.gmail.com/
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
1. I wonder if we should display fuse connection device id here.

2. I don't think using idr_for_each_entry is a good idea. But I failed
   to find another way to get backing_id of fuse_backing effectively.
---
 fs/fuse/file.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 754378dd9f7159f20fde6376962d45c4c706b868..5cfb806aa5cd22c57814168eb33de77c6f213da0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -8,6 +8,8 @@
 
 #include "fuse_i.h"
 
+#include "linux/idr.h"
+#include "linux/rcupdate.h"
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -3392,6 +3394,35 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
 	return ret;
 }
 
+static void fuse_file_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct fuse_file *ff = f->private_data;
+	struct fuse_conn *fc = ff->fm->fc;
+	struct fuse_inode *fi = get_fuse_inode(file_inode(f));
+
+	seq_printf(m, "fuse_conn:\t%u\n", fc->dev);
+
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	struct fuse_backing *fb;
+	struct fuse_backing *backing;
+	int backing_id;
+
+	if (ff->open_flags & FOPEN_PASSTHROUGH) {
+		fb = fuse_inode_backing(fi);
+		if (fb) {
+			rcu_read_lock();
+			idr_for_each_entry(&fc->backing_files_map, backing, backing_id) {
+				if (backing == fb) {
+					seq_printf(m, "fuse_backing_id:\t%d\n", backing_id);
+					break;
+				}
+			}
+			rcu_read_unlock();
+		}
+	}
+#endif
+}
+
 static const struct file_operations fuse_file_operations = {
 	.llseek		= fuse_file_llseek,
 	.read_iter	= fuse_file_read_iter,
@@ -3411,6 +3442,9 @@ static const struct file_operations fuse_file_operations = {
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= fuse_file_show_fdinfo,
+#endif
 };
 
 static const struct address_space_operations fuse_file_aops  = {

-- 
2.43.0



