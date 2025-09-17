Return-Path: <linux-fsdevel+bounces-62048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FBBB824B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676A21B28189
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0481C313D65;
	Wed, 17 Sep 2025 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Av6XsV48"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55073313D41;
	Wed, 17 Sep 2025 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151668; cv=none; b=SJPSrOI11QXz0jAHriIDX6vK8Mr0JL/qzwqPtdmi6UlKyK7aJ9FGoA+pzIc6K6xeeHux42Y1Wz9U01Iy4cgyCzf2/zFTzOB5KeAFhDiULF45yoLnIatimtzvEjBwWrSHxfA5yvuxS88U7AQr1zTfn9mYgxBVZNARQ+LClkX8+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151668; c=relaxed/simple;
	bh=SAL2g9XdbpStoo/2tv2TO4FxWiwoeZiXVO+35uIHtTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJb1kHmrpg6ZeYon7PTtw8Rp5zHu3HNHIAi5HLb2mxt9vnEerxnlrHfgWTChu6bwEX5gEBD9te4ZAWaaIXE19dxte2OdCIsHwdfX+Q+SQjSy8tR3nvHHYsqSuMCp/j8QerMzOGA4jU0aWTw5SVJB79/Uw3eFy5UEq38oj0iA91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Av6XsV48; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=88Qf5vmFOq52mGFZZBqLLkYiwaZwrmwoUe2SLAUb41o=; b=Av6XsV48u3Xpx8Z6d3/krbZhEM
	/4u1LceZCVwe1/kEMyYUFi7JpzJGXipCOUFqn4TPepYYQjyh4KwAwvkyQ5Sc44q7akdYH60RiqfuS
	kKUTthl9IyqfFJhEqu092RSmo/RoexvmXfE6lPpnOQ/cC+xnjAzhYXOlsXotoh89ZRdvwig1x5frV
	2ks3tXqRRdPqLlY5rXnq6Onb+gukXU5gb6a2xtF7EHXJ0VLaOiuPJW5YYY6xzQb87/PsqeEj1XdVN
	WzMkYCGOUtMsCKbBlqiq9yblY/HpTt0roBRZcQnPdSPkJ9yZZBkTSr2SM5TS80A9XfrxWhC60+/IH
	yfNblMXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz1Ym-0000000Aj5Q-3WMp;
	Wed, 17 Sep 2025 23:27:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: v9fs@lists.linux.dev,
	miklos@szeredi.hu,
	agruenba@redhat.com,
	linux-nfs@vger.kernel.org,
	hansg@kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 1/9] allow finish_no_open(file, ERR_PTR(-E...))
Date: Thu, 18 Sep 2025 00:27:28 +0100
Message-ID: <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250917232416.GG39973@ZenIV>
References: <20250917232416.GG39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... allowing any ->lookup() return value to be passed to it.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/open.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 9655158c3885..4890b13461c7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1059,18 +1059,20 @@ EXPORT_SYMBOL(finish_open);
  * finish_no_open - finish ->atomic_open() without opening the file
  *
  * @file: file pointer
- * @dentry: dentry or NULL (as returned from ->lookup())
+ * @dentry: dentry, ERR_PTR(-E...) or NULL (as returned from ->lookup())
  *
- * This can be used to set the result of a successful lookup in ->atomic_open().
+ * This can be used to set the result of a lookup in ->atomic_open().
  *
  * NB: unlike finish_open() this function does consume the dentry reference and
  * the caller need not dput() it.
  *
- * Returns "0" which must be the return value of ->atomic_open() after having
- * called this function.
+ * Returns 0 or -E..., which must be the return value of ->atomic_open() after
+ * having called this function.
  */
 int finish_no_open(struct file *file, struct dentry *dentry)
 {
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
 	file->f_path.dentry = dentry;
 	return 0;
 }
-- 
2.47.3


