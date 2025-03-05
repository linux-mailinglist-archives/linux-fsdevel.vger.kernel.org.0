Return-Path: <linux-fsdevel+bounces-43305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CC9A50CCD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1263AD945
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16A25523E;
	Wed,  5 Mar 2025 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lMyjVDY1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3D2580C2
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207665; cv=none; b=WS+0waer0iKXkUJ/+Uk1/cMOLl4ny273nNunvWtqBDlNaPAUC9YgvGuuxj1FZk8q8Gx7YD6ynCnKOaEHNAzdJNvJS3VZ8BHEezx2pfNQ9nseUrAbMEVmKajr34wTAdyFZZVj8fy8Nv6aOYt+/dtuo/W44Xi5Ug63xzEAYSReIIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207665; c=relaxed/simple;
	bh=P9BiaB8GU3F/U3fkyNOLTk/DmK+ojI7iT+j29iK8LGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1d1iD0vU8yjLFr0OLi6w3lOkK8HfYZrUsdSZBw/nz3loUzGebDaeh1/lsPjeZkU40E0gVfLbnBApfrUYchZOG143h38eREl06yK2hYtWzFbi4w2PxzaLwSUO0lib9jIiOdts0JzHJNNecrq3op19tVCAjUxb9wYUlRJaqoY/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lMyjVDY1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1kekQQ4S2DXYL2wViV13EFeHuXe3fpARyuID7EwOzzk=; b=lMyjVDY1q6FsA3rKWhY3dZL0Tn
	kmffeG57Vv+vAVS2UTJexldN+ljkyheQwdSAkqt20QLV+4vv1RSOam+j7esjM3SC5+xljuBbOdPhj
	VFwivRqzC9z6DsINN0ECKSCjVJGaBLqtv8IR/ZcycHcSYn0GrDq9zdTYScoeMOmztckCFCYUer2wg
	0XPZqT7Yub0gX9Q2BfR03SwAOGztnCBLDJCm8FSUVUyMyaqsbV7xGNgwDkSwe3pITbddvvE/zso7v
	y9Ivw0++cnd8+9nJLmvs1EypsfwXjGQyIcY5TJJDI8QU5uaXZcxHQO6YG8Jl+NGCTsWsrMWU+Mbpd
	TTlBrSLA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpveT-00000006Bmz-0Wup;
	Wed, 05 Mar 2025 20:47:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 3/9] orangefs: make open_for_read and open_for_write boolean
Date: Wed,  5 Mar 2025 20:47:27 +0000
Message-ID: <20250305204734.1475264-4-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204734.1475264-1-willy@infradead.org>
References: <20250305204734.1475264-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparse currently warns:

fs/orangefs/file.c:119:32: warning: incorrect type in assignment (different base types)
fs/orangefs/file.c:119:32:    expected int open_for_write
fs/orangefs/file.c:119:32:    got restricted fmode_t

Turning open_for_write and open_for_read into booleans (which is how
they're used) removes this warning.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index d68372241b30..90c49c0de243 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -57,8 +57,8 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
 	int buffer_index;
 	ssize_t ret;
 	size_t copy_amount;
-	int open_for_read;
-	int open_for_write;
+	bool open_for_read;
+	bool open_for_write;
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_FILE_IO);
 	if (!new_op)
-- 
2.47.2


