Return-Path: <linux-fsdevel+bounces-17014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CA48A6174
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 05:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544311C20830
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 03:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E622F1E;
	Tue, 16 Apr 2024 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nGYV5Bl6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D703179B7;
	Tue, 16 Apr 2024 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237481; cv=none; b=U3w58IHWgZw9qM1FQFQEDfsInBygeHCDycxgmprhibU5r34CGM9lDmDyFdRqMmQfirgGzP2CLPUoZq6kZEPU6HOjCnpYmN13pxhI2kFdfObMNIjUNMv5cY5sU8p+m7dkeN4c0sPZgzrh2HEIBXRUlQtAvuBikokvpXHmF6mwcnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237481; c=relaxed/simple;
	bh=R4zR/ggMbwsDDsz3YLFyJdFeeu1DsOVGY8QCJ7KprCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANXuuGl1CzWjJbv7R92SGn9H6oj6hTsp+9WM6SaOaZcgzbuG4xMzuhHtXvlerJ2d5xZkfMzNw5wlJRWTXhmXfYyo6RMYCmPW0biJ0T7kiCP27UrwZFe19KYj+8EohWMpx5Xi3/fqWT3p2AiptuHLbcpUZsEMDSkueOmOnCDnP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nGYV5Bl6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rmgDp3RNfkN3sPWJ9s/SxWrF46fF3oO8saAb/9v0RQU=; b=nGYV5Bl6OTUcQaFxNJ8Qd5UDRD
	rAZf93AsDmTmmnsbAF7QNxF4QaDilQLQfZXDXuuUiaQB/EnzJP3bEY2Vg0JbuQIwoaGL5S5muyyVk
	yi7iuAsew9HdGeZIU8JCyd5l6s3HnRcPVXBPM0+Xky88JGsPwPl5W584FM2EEg6eQLF90UI7w4cdn
	XCG0B9WZoaNSvxeaMr28h4z5EZ0Htcg2yWkP+xlAkssYi9W/VgfW4yEPyg5tgxJfChOI3VLSjzW4I
	V5z6y/B6NB7TnvZ7UKzRs2OVIOiqojSuU/iPAl9H5zGeuHWXzmzXCHYwX3M7Yxg1WmWrHa1cTLOMe
	NGkFXbaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwZKW-0000000H6bI-25ds;
	Tue, 16 Apr 2024 03:17:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 8/8] doc: Split buffer.rst out of api-summary.rst
Date: Tue, 16 Apr 2024 04:17:52 +0100
Message-ID: <20240416031754.4076917-9-willy@infradead.org>
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
 Documentation/filesystems/api-summary.rst | 3 ---
 Documentation/filesystems/index.rst       | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

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


