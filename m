Return-Path: <linux-fsdevel+bounces-41987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3968A39BB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 13:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2466E3A551E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 12:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A815423FC6A;
	Tue, 18 Feb 2025 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aQRw741K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF632405F4;
	Tue, 18 Feb 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880138; cv=none; b=dWEVvDB+E39eaw5z00yigLH78B6uGSo7Bnyvpc0yaEU2XJK4FGYVS4MADlxoMXsK3rp6faQpZX+wAmLpzuB6RKEe7FrXaJUpJomgvS3/72XFK/yAe9JdOy5FtKDzS3A5cpyW1gSCAbEByOqTn7g9kREDe8q3AQJki/AAHXsY8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880138; c=relaxed/simple;
	bh=nM1XAO5eqp6vtR9efrMqEu/JQNy+fzh77uKaHlP7S9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tlLVUkpXRQSswGLzA+jjLv0v+rqrWZnuLg4T2+A5GICPhe3vqX7wvbTIHfZBlrnYDwTJvaJop2SkZ8xJQ71KiROw4lVw4RZUbQLbNHT4VBXxIPy6VtPnCfX++XOjPvimis/Y2IyvnZeIm82GQ22CnEprvDxCrdGisfBajG4XjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aQRw741K; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739880131; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ELWahEziw1ddKeNrxVKn7NIq0FKyA7vh3KDs9oWRZaM=;
	b=aQRw741K2yfuoBWZ+U4TakRkc/wD5Go4eUXa3hzXJ01UGtLCaRb6zj6KeD1aDvSEiuveKqNDGJtmQBYechs/8rowQaSZYfllYZQ8OLx5CKmdoBMYHdbXQH3zWbd2zrq6MiNKU+FSHwijkaS4NETKNusn807gn8dnd73PvcnTNpE=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WPlpQxT_1739880130 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 20:02:10 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 1/2] mm/filemap: fix miscalculated file range for filemap_fdatawrite_range_kick()
Date: Tue, 18 Feb 2025 20:02:08 +0800
Message-Id: <20250218120209.88093-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iocb->ki_pos has been updated with the number of written bytes since
generic_perform_write().

Besides __filemap_fdatawrite_range() accepts the inclusive end of the
data range.

Fixes: 1d4457576570 ("mm: call filemap_fdatawrite_range_kick() after IOCB_DONTCACHE issue")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/linux/fs.h | 4 ++--
 mm/filemap.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2c3b2f8a621f..f12774291423 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2975,8 +2975,8 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
 		struct address_space *mapping = iocb->ki_filp->f_mapping;
 
-		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos,
-					      iocb->ki_pos + count);
+		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos - count,
+					      iocb->ki_pos - 1);
 	}
 
 	return count;
diff --git a/mm/filemap.c b/mm/filemap.c
index 804d7365680c..d4564a79eb35 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -445,7 +445,7 @@ EXPORT_SYMBOL(filemap_fdatawrite_range);
  * filemap_fdatawrite_range_kick - start writeback on a range
  * @mapping:	target address_space
  * @start:	index to start writeback on
- * @end:	last (non-inclusive) index for writeback
+ * @end:	last (inclusive) index for writeback
  *
  * This is a non-integrity writeback helper, to start writing back folios
  * for the indicated range.
-- 
2.19.1.6.gb485710b


