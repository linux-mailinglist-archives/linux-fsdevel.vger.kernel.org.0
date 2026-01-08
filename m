Return-Path: <linux-fsdevel+bounces-72794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAEBD01BA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 10:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3D883481778
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8669037C111;
	Thu,  8 Jan 2026 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Id4Et3tB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3AD37E2EE;
	Thu,  8 Jan 2026 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858654; cv=none; b=T8/RZnhkoPMLt16thl6gCcTaPO6wpYKdczCEoMoG3q0OPGFT5J/MfZ5QKxQGWuBXLAGfrrofV7JV+eAru+iCYHPvMPdQLv1DXetbhu2h3/gJ5cVQYBqz30aWCdLE9xLjSJRDaaNQCU0MSk/jx9stW9VqgFHIg8oFu7ItGjwXCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858654; c=relaxed/simple;
	bh=ke/3Oq99/G+NhjzBp9iNmpcdEtbbqS7YOjs/lwLWzLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p124mJvUwM/Swu7cgMNgg9rBZffEwch0l4GOhE9nDftJss5Q+yvyxeVJUqJb+EGGDkYCI9S9SyK6Khx7wcrgKNK96ljlDNIu2uqn7onaYxr0d7mSN0RT63ys3da74hVklwYtGyMS1CoUiuv9OW2DmCZaEhg0k/8IvEAoCxyW57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Id4Et3tB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=4EdlEkNmSPIG3kP66v3NKZeO/wkeEzfY8gUoivj/SPA=;
	b=Id4Et3tBEdpFAZ6KRx9H0cko7bKF9bK6hQ0PXNSlI/kttx/ox0tXd1jyFd5cQ0
	QQ7DWhVFwJsknu+VpL4SXf1PCuf4WZOdy3PiYj8wRpdyCv4H7y8QPYOdf5WITWbA
	gL3mI/d8HpoXAqo4KDuamEmojsSIYiKpt+dYSH/7Ssjlo=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBH6+WpYV9pdSx_Eg--.889S7;
	Thu, 08 Jan 2026 15:50:07 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 05/13] exfat: remove the check for infinite cluster chain loop
Date: Thu,  8 Jan 2026 15:49:21 +0800
Message-ID: <20260108074929.356683-6-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108074929.356683-1-chizhiling@163.com>
References: <20260108074929.356683-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH6+WpYV9pdSx_Eg--.889S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw13Kr1DCr17tFy8uFWxWFg_yoW8XrW7pr
	WxKa15t3y3J34Duw40yrn7X3WSkas7JF4xJan3G3Wjk3yqyrsYkrn8tr90kFZ5Gw1kWa1Y
	9r1Ygw1UuwnxGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2XdUUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9w+1U2lfYa9tYQAA3q

From: Chi Zhiling <chizhiling@kylinos.cn>

The infinite cluster chain loop check is not work because the
loop will terminate when fclus reaches the parameter cluster,
and the parameter cluster value is never greater than
ei->valid_size.

The following relationship holds:
'fclus' < 'cluster' ≤ ei->valid_size ≤ sb->num_clusters

The check would only be triggered if a cluster number greater than
sb->num_clusters is passed, but no caller currently does this.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 61af3fa05ab7..0ee4bff1cb35 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -238,8 +238,6 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 		unsigned int *last_dclus, int allow_eof)
 {
 	struct super_block *sb = inode->i_sb;
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	unsigned int limit = sbi->num_clusters;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct exfat_cache_id cid;
 	unsigned int content;
@@ -279,14 +277,6 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 		return 0;
 
 	while (*fclus < cluster) {
-		/* prevent the infinite loop of cluster chain */
-		if (*fclus > limit) {
-			exfat_fs_error(sb,
-				"detected the cluster chain loop (i_pos %u)",
-				(*fclus));
-			return -EIO;
-		}
-
 		if (exfat_ent_get(sb, *dclus, &content, NULL))
 			return -EIO;
 
-- 
2.43.0


