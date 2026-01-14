Return-Path: <linux-fsdevel+bounces-73698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB6D1EE61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05FAF304EBC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1637C399A74;
	Wed, 14 Jan 2026 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="APPnD6aw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC2399A58;
	Wed, 14 Jan 2026 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394722; cv=none; b=YtLCj5ksBmqEKymxPpRqkgwBCIzj38JsAGu04Gm5MpguTRENhSPeJkwE74srAnznbPGDWB1/8ZH7ngKF2MnIvNCDnXHLp/aaVPTVVV8e8oeHMy4/ZahNLaTEYqzChhDbze9Hzl0S+RTWYu7FAzDPd/SBD59nIIbilwziIEwgVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394722; c=relaxed/simple;
	bh=hKLh138cSx7rqIf++kIcTaaGXUe5JO8wuVK7F1kWj/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zmmbf/DfCEfl751f6CAElHDO6CFOsWeEawqP1ybb6WW6YWvZGDTPgvweJLfsSIIoVEVntfhiCZlsyb6aeHLbNBJCC9+3zeOfgwm6GiQbNOY1BjTxjdlHncIpvUaGRvWOGOmfXhLvHYe+tFnR5aJJSK0CJsUBOOvJxm6n1CXA+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=APPnD6aw; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768394715; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Nz6uk6oDmaJ4NnMcHYU6DbTkp7dnm2Gg+LCvO1tieEY=;
	b=APPnD6aw/0n2emgOBnflx5tZdIxc/rhQO3fofNZ6CmNdI7y6zZTgmzSviuEdSRaBcZ7AoRISm6n2Tztrk3x81si1obDybLNIz8dZMtVDm7tLmDtNa2uWqBcy8AAzkXx2/AvTX3drsfQLfqTNSTOHkzhS4LkYLrH0HsMJrA/EkpQ=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wx2OxPM_1768394714 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 20:45:14 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com
Cc: linux-kernel@vger.kernel.org,
	horst@birthelmer.de,
	joseph.qi@linux.alibaba.com
Subject: [PATCH v2] fuse: fix premature writetrhough request for large folio
Date: Wed, 14 Jan 2026 20:45:14 +0800
Message-Id: <20260114124514.62998-1-jefflexu@linux.alibaba.com>
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
Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
changes since v1:
- add Reviewed-by tag (Horst)

v1: https://yhbt.net/lore/all/20260114055615.17903-1-jefflexu@linux.alibaba.com/
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


