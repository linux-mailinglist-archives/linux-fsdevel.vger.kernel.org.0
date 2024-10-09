Return-Path: <linux-fsdevel+bounces-31410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BFF995E29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 05:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2AD286A1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 03:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233E214386D;
	Wed,  9 Oct 2024 03:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ayXIWZJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586D2629D;
	Wed,  9 Oct 2024 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728444726; cv=none; b=MFJRWpz8RxEzZAVsEZR8XYSg0E7Lnb9Yp1VcWtkg0LZvdtDnZES7vmY0fuSKwo9aAe1uzt2aqaB2314sT2t53KOmsHJLx2Tt9m16uYpXoqh2Y0NgnPFbZp4Ofy8WlF745xeSFk7VY4ra6xQ497MAHImS3TMjAt99zPZnpUpdFBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728444726; c=relaxed/simple;
	bh=UKvWrcN6f43QWH0vx0BHKBG4bIzgzz/qaJLB9NnLBLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aW0fcLfHgoq9V+lcIq5pO18Chi6KtZSYlw12YTPiZb2fGCboHXp0VAhwyvvrkTQK5aXeixAboo6VsRswFNlGQbn9fmDW//jU7WxRpHIXive+35PcQ+/BzPiHMaqCzATN1tIqwdPwUQTOzYRmLeSdDDGunRXpSVIvL4JSBGuje0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ayXIWZJI; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728444721; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jJSUlb11QHSKUmhauCeDGT4NZMMv9jLK3BJgLEkB/1Q=;
	b=ayXIWZJILlZk3S+yBUjLUTsz9QMxZ0MRm8wNhjq2goavG0P7taJyC1fJSh5O83hKfgFAT8HmjJGUlAoaNeIqr5btKFjhQ23fZK5h5JhBrOkQHwoshKMGwBXz5WiM3bvfd16osJgnDCpCwpJpnlzRh8bIAuodLKGVqhfEt/nKrfc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGhJfuR_1728444719)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 11:32:00 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Chao Yu <chao@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
Date: Wed,  9 Oct 2024 11:31:51 +0800
Message-ID: <20241009033151.2334888-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can pass in an arbitrary source path for the proper type of
a mount then without "Can't lookup blockdev" error message.

Reported-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Closes: https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - use new get_tree_bdev_flags().

 fs/erofs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..b89836a8760d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -705,7 +705,9 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
-	ret = get_tree_bdev(fc, erofs_fc_fill_super);
+	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
+		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
+			GET_TREE_BDEV_QUIET_LOOKUP : 0);
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
 	if (ret == -ENOTBLK) {
 		if (!fc->source)
-- 
2.43.5


