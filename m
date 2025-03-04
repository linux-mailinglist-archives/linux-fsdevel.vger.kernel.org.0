Return-Path: <linux-fsdevel+bounces-43122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF0EA4E565
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70EA019C3CD7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA2C27817E;
	Tue,  4 Mar 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sTQjuy6Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC140278167;
	Tue,  4 Mar 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103307; cv=none; b=rYqNf2nobNTv+59KPhPwkP3W0f16NZHdqs9pGL1q4wDQGBIDxI7zYEVUYPAod7ckWAvLJbmFrO3THiZxSx+oV2o3ABGzVGyhC8F43hJwScnsA4dASyNGCWItXY6IbQT2NamdLCqmNGEED0vGADPHDOjCPddugrZlKODGf4yMbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103307; c=relaxed/simple;
	bh=1DdOz3KEhsMs3Dr0+9/DkNpFMUaE0gQzUnXsIOdvhAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u6+GUv2T/9pO3WJ7pFxSW/wjNXq805n+Rf9TAyUw7CEEEBd7fHFfzkQlIZ3pvwYcwbi7WrM4klZBfQNhWKFi+xU7cbiMbshg9ISYkfiwcbf/ns7l5LjxrT24PEbk+6P6h6zmsscCW36FPNpgv8Ak5XrRnXrLoy8+XJl+WUn5OQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sTQjuy6Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zOrlIceVWWSS603ADg2BUPx7j6TlefnAA/TeC7h1QEs=; b=sTQjuy6YA0NPe5jlzg5HickG58
	fgj6dLc9DN53z3U/dqVY5PiAMAPvRoW9L1pTrAkKj25ZJPtvK23GstVapnWK7COFi9iynxfG8WkWy
	GGNYvTwpWzokVkvYK+JOaO7s+b/KRffXl8lXXqdVeNX3X1g5dMgtNorpjsSIxFl3P+BS6ykI9OWfK
	JdnkJkSu8pElazIxQ2Wnm/WliPkYBhW4Bk4DX7MdIJlwApZS4tmh4BUV90jqekXxxOh8gSZI0mgKD
	SCjYlGODWFtozg5t4A9zIUKbGwzVVHTuJVJ/+7pqxYCO0q41d/yGJonZrUGxNQ9foORsZm2UHho0L
	zDGz0+Cw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpUVK-000000013Es-1XRM;
	Tue, 04 Mar 2025 15:48:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH] ceph: Fix error handling in fill_readdir_cache()
Date: Tue,  4 Mar 2025 15:48:16 +0000
Message-ID: <20250304154818.250757-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__filemap_get_folio() returns an ERR_PTR, not NULL.  There are extensive
assumptions that ctl->folio is NULL, not an error pointer, so it seems
better to fix this one place rather than change all the places which
check ctl->folio.

Fixes: baff9740bc8f ("ceph: Convert ceph_readdir_cache_control to store a folio")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index c15970fa240f..6ac2bd555e86 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1870,9 +1870,12 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
 
 		ctl->folio = __filemap_get_folio(&dir->i_data, pgoff,
 				fgf, mapping_gfp_mask(&dir->i_data));
-		if (!ctl->folio) {
+		if (IS_ERR(ctl->folio)) {
+			int err = PTR_ERR(ctl->folio);
+
+			ctl->folio = NULL;
 			ctl->index = -1;
-			return idx == 0 ? -ENOMEM : 0;
+			return idx == 0 ? err : 0;
 		}
 		/* reading/filling the cache are serialized by
 		 * i_rwsem, no need to use folio lock */
-- 
2.47.2


