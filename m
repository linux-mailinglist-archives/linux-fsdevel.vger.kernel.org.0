Return-Path: <linux-fsdevel+bounces-74360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4515D39D4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 04:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 822F53007682
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 03:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C240732F74B;
	Mon, 19 Jan 2026 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ygf55RJU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A81E32CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768795179; cv=none; b=rd5vGS9wkAJpM6YUYcY0TT2i4ph3zNhD5iu7yhBgJyiCoOGFLwiOOk353hYDYTMRpbU/tzZG4WmAlLypkAP9mTLypTSppqWM6Bp4+Rap6lICmoGGGOMKJG4p0B3exXEqMo+5wjg2LPlT7KOt/AsdGCHT9z3TWfEyEXey3sd9O5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768795179; c=relaxed/simple;
	bh=HcNGovgyktgJhkSDCcx0eLnGY2OnyrtiezZGa/JF7Jg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I7x7jNwi887MdT6d0buBGBBQXYmBiiZwzC+8Xw850WNUIO4k01EsBct4PlMvVnQC1puBw08v2a1KT0dqkluUJ2DGxmF48dPwvkYt+71GjstSGO7y+BRTg9l51LeUJ6iIaVqvPDLvpJYB/Gnu1i/23LomsJ6LeKAgI+c6YlWTCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ygf55RJU; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PqY0lKXi78VY6Sc0v5OHbx57G72lxRJHYsOW+bxvSGY=;
	b=ygf55RJUif4IVzfj+YcHAb9h1H7BRxnojC/byNkImC1pTT/7xW6tkIfVoZkv6prx/erNL2ccS
	YzklTefQO/xZINFQj1XpSIJsY2C/tmAJjoswTgDvqvECJ6Wan1ILLVaNpqtTHohj+YZW23dbvQB
	PqidTVWMy1JZfT6n+BUISC0=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dvc7v5YThz1cyTx
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 11:56:11 +0800 (CST)
Received: from kwepemj200012.china.huawei.com (unknown [7.202.194.24])
	by mail.maildlp.com (Postfix) with ESMTPS id B61BC40539
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 11:59:33 +0800 (CST)
Received: from huawei.com (10.113.189.238) by kwepemj200012.china.huawei.com
 (7.202.194.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Jan
 2026 11:59:33 +0800
From: x00511854 <xuqi27@huawei.com>
To: <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>
CC: <zhangzhikang1@huawei.com>, <liujie1@huawei.com>,
	<chenmaotang@huawei.com>, x00511854 <xuqi27@huawei.com>
Subject: [PATCH] fuse: Verify real bytes of readahead in fuse_readpages_end
Date: Mon, 19 Jan 2026 12:04:17 +0800
Message-ID: <20260119040417.2768067-1-xuqi27@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj200012.china.huawei.com (7.202.194.24)

The fuse server cannot guarantee every read request is done with target data length.

For example:
1.In fuse server, an IO error has occurred which makes only part of data being read,
and the number of read bytes is returned.
2.fuse_readpages_end() in kernel get 'err == 0', and set the folio uptodate without whole data.
3.The folio is uptodate, so unwritten data is copied to user.
4.The file with broken data failed to be parsed.

So to fix the problem, it should verify real bytes read from fuse server, before set folio uptodate.

Signed-off-by: Xu Qi <xuqi27@huawei.com>
---
 fs/fuse/file.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..bed36bf7d523 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -994,6 +994,26 @@ static int fuse_iomap_read_folio_range(const struct iomap_iter *iter,
 	return fuse_do_readfolio(file, folio, off, len);
 }
 
+static bool hit_folio_end(size_t num_read, struct folio *folio, struct inode *inode)
+{
+	if ((folio->index << PAGE_SHIFT) + num_read == i_size_read(inode)) {
+		return true;
+	}
+
+	return false;
+}
+
+static bool folio_read_done(int index, size_t num_read, struct folio *folio,
+			    struct inode *inode)
+{
+	if (index < (num_read >> PAGE_SHIFT) || (index == (num_read >> PAGE_SHIFT) &&
+	    hit_folio_end(num_read, folio, inode))) {
+		return true;
+	}
+
+	return false;
+}
+
 static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 			       int err)
 {
@@ -1018,8 +1038,10 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	fuse_invalidate_atime(inode);
 
 	for (i = 0; i < ap->num_folios; i++) {
-		iomap_finish_folio_read(ap->folios[i], ap->descs[i].offset,
-					ap->descs[i].length, err);
+		if (!err && folio_read_done(i, num_read, ap->folios[0], inode)) {
+			iomap_finish_folio_read(ap->folios[i], ap->descs[i].offset,
+						ap->descs[i].length, 0);
+		}
 		folio_put(ap->folios[i]);
 	}
 	if (ia->ff)
-- 
2.34.1


