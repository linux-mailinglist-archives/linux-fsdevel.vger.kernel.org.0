Return-Path: <linux-fsdevel+bounces-17093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358CD8A7A48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 03:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB331C214ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483414685;
	Wed, 17 Apr 2024 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jvX/klM9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D31860;
	Wed, 17 Apr 2024 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319186; cv=none; b=dmUZI7PgkY9sHggwPG/zKrJ/oNKW/3xjdQatlc+aWnqSbPp0H3LYSVjEgAq3kBbgTb+yw4Bd3kFODQNU1c6p+X4knP6rsaxO1NEoby/AHiv9EM/UrMx9uQdaTk+ePRCcFG6gdOox2y7QyuYq9cGK8FaQR93kR7X9Q/tja9Trwz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319186; c=relaxed/simple;
	bh=xeypXJ2Q9SFCnMjfSlsBKbWmqmK+siVkxTj7D11imCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brNkJrmc/vVBBE0YWHhY8TAWthTw+4s/78feVJ1mWn4pYi5b8s1C3oasYSBU0WHmc9fKagGaXHihPC7fGLI/7RGcxCawL8FcpishI8nHdo59KuufZeCgtNqZvXnf4J3Q1upgrGAWTudtaW1lRayCen6NeH5lipIgoPAsy8khW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jvX/klM9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Kv3VfAk1BQu5/cwkBbfz4nnBYslqYgF87PHMpfFu3gA=; b=jvX/klM9FdrtR/1KSEzfu8CvP+
	CtLuIU6DAEccvpT6Ei3RLpiaXaLskisGiA0Kchj2/4JcC2AdAPeF1U8lWzoZ3K5RzPUz97/C/ga+d
	hkxKct9oGGcqKEtf0vgsbiLIhM8eJqPtclthMD/yJjRvto4G2mB7nG4K0Rr5P+ioctUZwyMCcngvH
	xBi2KJrZSCjg8I0kTCx6qExlYwJlSp9Wc+41Xu2XFJEPCJjczlNBbz6bk3tuxDb/1itbJf67aDsga
	EYKAucqC20KYTJbw9+72YRC64zm9kO2ijqPhvmn0QlITp4dNLNk3eI8x0VHsncwNtjTXKBYAtq00J
	Kadns6eg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwuaF-00000001u4A-29MN;
	Wed, 17 Apr 2024 01:59:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v3 8a/8] doc: Split buffer.rst out of api-summary.rst
Date: Wed, 17 Apr 2024 02:57:46 +0100
Message-ID: <20240417015933.453505-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416031754.4076917-1-willy@infradead.org>
References: <20240416031754.4076917-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffer heads are no longer a generic filesystem API but an optional
filesystem support library.  Make the documentation structure reflect
that, and include the fine documentation kept in buffer_head.h.
We could give a better overview of what buffer heads are all about,
but my enthusiasm for documenting it is limited.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/api-summary.rst |  3 ---
 Documentation/filesystems/buffer.rst      | 13 +++++++++++++
 Documentation/filesystems/index.rst       |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/filesystems/buffer.rst

diff --git a/Documentation/filesystems/api-summary.rst b/Documentation/filesystems/api-summary.rst
index 98db2ea5fa12..cc5cc7f3fbd8 100644
--- a/Documentation/filesystems/api-summary.rst
+++ b/Documentation/filesystems/api-summary.rst
@@ -56,9 +56,6 @@ Other Functions
 .. kernel-doc:: fs/namei.c
    :export:
 
-.. kernel-doc:: fs/buffer.c
-   :export:
-
 .. kernel-doc:: block/bio.c
    :export:
 
diff --git a/Documentation/filesystems/buffer.rst b/Documentation/filesystems/buffer.rst
new file mode 100644
index 000000000000..b8e42a3bec44
--- /dev/null
+++ b/Documentation/filesystems/buffer.rst
@@ -0,0 +1,13 @@
+Buffer Heads
+============
+
+Linux uses buffer heads to maintain state about individual filesystem blocks.
+Buffer heads are deprecated and new filesystems should use iomap instead.
+
+Functions
+---------
+
+.. kernel-doc:: include/linux/buffer_head.h
+.. kernel-doc:: fs/buffer.c
+   :export:
+
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 1f9b4c905a6a..8f5c1ee02e2f 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -50,6 +50,7 @@ filesystem implementations.
 .. toctree::
    :maxdepth: 2
 
+   buffer
    journalling
    fscrypt
    fsverity
-- 
2.43.0


