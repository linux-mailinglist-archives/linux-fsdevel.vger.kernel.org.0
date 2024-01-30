Return-Path: <linux-fsdevel+bounces-9552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E63842A25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 17:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB1CB24126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 16:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FFE12DD84;
	Tue, 30 Jan 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pqI8Vxqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC75129A87;
	Tue, 30 Jan 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633594; cv=none; b=X3IFE9rfaYiN+tYXQWl+mXr3/L6xZpmoqif7dkLP8RjBcjSm3apYV5088VgZ8sEyhk4kZfa1IsPQmvLK1PbchVuRxjzyG3tB/uo4+f6WGLV+jsc7SnTZcj+XtM5+L5Fdc7ZwRyaBS45y/h3WeltMSfMipx+jGpwQF5G0WdiiGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633594; c=relaxed/simple;
	bh=TeqAlXONUU5nqUDfGe4PPPm1rluqnLU8fKx0/5MP6+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wmb1QKayYTQitkR5w9ma60QSUn6PenVGQdXlrZyDDtUy7+6qkLFWIG10HSpdglKBifOzgwTM4CbRJ9aAXKqOR9uJFwQAjiyYkB1ciYfGxl8TiIZJ8Q+pB/ssb1eEIrvq2NzoiEfkv4cKBZLIipx3CNFYIQu8+gJ5e61X7eusv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pqI8Vxqf; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706633584;
	bh=TeqAlXONUU5nqUDfGe4PPPm1rluqnLU8fKx0/5MP6+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqI8VxqfmApmjaDjKQX349yC1ZLj6cXG8NnjM6GRv0T0PqIXwhiwEPrza6mt1yGYj
	 bPAMgS7faIoPvOFK2j2p8dbPw+IGautTYGnIeOJ8GcJ/S/4+3Tgn4lSKJxsLiC/5sG
	 4fvfrTpcL6JBjlv+dua8XbJsXqQyTP0mHbPrjpe3/oKtSxJQUFlSzrrBBSK3nUXR69
	 4Q7uQJi1R+AfVFW2LhIChPTjmyLDehNjjBOeS0GsHokH9TPg3wr/Lki3C6hyecKDio
	 UYOhuErVYy275XFsBOAFeY8gqUTg1T9MkuzoJO0Owfc488XdmddiKhpHV0zLY4x73X
	 JoaEMIwFP6lkA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TPWSc0vhmzVgK;
	Tue, 30 Jan 2024 11:53:04 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH v2 5/8] fuse: Use dax_is_supported()
Date: Tue, 30 Jan 2024 11:52:52 -0500
Message-Id: <20240130165255.212591-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dax_is_supported() to validate whether the architecture has
virtually aliased data caches at mount time. Silently disable
DAX if dax=always is requested as a mount option on an architecture
which does not support DAX.

This is relevant for architectures which require a dynamic check
to validate whether they have virtually aliased data caches.

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
---
 fs/fuse/dax.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d170bb..36e1c1abbf8e 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1336,6 +1336,13 @@ static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
 	if (dax_mode == FUSE_DAX_NEVER)
 		return false;
 
+	/*
+	 * Silently fallback to 'never' mode if the architecture does
+	 * not support DAX.
+	 */
+	if (!dax_is_supported())
+		return false;
+
 	/*
 	 * fc->dax may be NULL in 'inode' mode when filesystem device doesn't
 	 * support DAX, in which case it will silently fallback to 'never' mode.
-- 
2.39.2


