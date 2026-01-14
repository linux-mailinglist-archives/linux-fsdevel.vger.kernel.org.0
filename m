Return-Path: <linux-fsdevel+bounces-73605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1398DD1C9E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64FD330B7F2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 05:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F8C36BCF6;
	Wed, 14 Jan 2026 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IstCCbD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783291CD1E4;
	Wed, 14 Jan 2026 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768370193; cv=none; b=PN1KObr8vFFOU5nywrxJSIq7L68V2owY+Q/bJf54nP69XRW4qBkv/543QpU3rdA49+LSmxR7QdtuR3EJq0FyY/3PmDKup3SuwtSdvz15lA3Zma4StUAdyso1ng7XulXm5eRLkru7wF7d0z7LMVlfBqX04uvlDP69nOKQdKPI8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768370193; c=relaxed/simple;
	bh=Y/NqgNU+RzXHdq+jyrX0/QIiUtJ6yYt8n3IZ8dfuNtg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nUaPx5MP1GR3UcK1yKySLbaqoIUGyFJyIJ+lyPg9ZznmUP73lzQE3HTcYx+7Bk5Rnj25dwMe2069/V1wD/sV9C6O9gPv1GOMmP4VKdnh9P8Xyh+oyz4Yleyd3S5GQrOnm5h8c/FFZDE8I4+tlNrbe4zbO5IGVivkZXaybjlgfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IstCCbD3; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768370176; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4oSebG9dbymzCO5r09ecbpgUKefMLVyvEkILvccjlwM=;
	b=IstCCbD34bmxp53YjOnk5tEuDLHfYynBeBrQCsyRw/Cla4TGCrFPn3QEYOxM1viar5q39tcyR6j/6woszVss0I4JnzYbEWGl8SivGlTDfv/lWoICrTSZ0qVMGCXDN5zY6Z60CXHMdNu0X/hquVzJ33XYR+bfuvyhYrunVj9JTvI=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wx1EJy4_1768370175 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 13:56:15 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ak: fuse: fix premature writetrhough request for large folio
Date: Wed, 14 Jan 2026 13:56:15 +0800
Message-Id: <20260114055615.17903-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When large folio is enabled and the initial folio offset exceeds
PAGE_SIZE, e.g. the position resides in the second page of a large
folio, after the folio copying the offset (in the page) won't be updated
to 0 even though the expected range is successfully copied until the end
of the folio.  In this case fuse_fill_write_pages() exits prematurelly
before the request has reached the max_write/max_pages limit.

Fix this by eliminating page offset entirely and use folio offset
instead.

Fixes: d60a6015e1a2 ("fuse: support large folios for writethrough writes")
Cc: stable@vger.kernel.org
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/file.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 625d236b881b..6aafb32338b6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1272,7 +1272,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 {
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
-	unsigned offset = pos & (PAGE_SIZE - 1);
 	size_t count = 0;
 	unsigned int num;
 	int err = 0;
@@ -1299,7 +1298,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
-		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		folio_offset = offset_in_folio(folio, pos);
 		bytes = min(folio_size(folio) - folio_offset, num);
 
 		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
@@ -1329,9 +1328,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		count += tmp;
 		pos += tmp;
 		num -= tmp;
-		offset += tmp;
-		if (offset == folio_size(folio))
-			offset = 0;
 
 		/* If we copied full folio, mark it uptodate */
 		if (tmp == folio_size(folio))
@@ -1343,7 +1339,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 			ia->write.folio_locked = true;
 			break;
 		}
-		if (!fc->big_writes || offset != 0)
+		if (!fc->big_writes)
+			break;
+		if (folio_offset + tmp != folio_size(folio))
 			break;
 	}
 
-- 
2.19.1.6.gb485710b


