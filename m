Return-Path: <linux-fsdevel+bounces-35264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3AE9D336A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 07:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CE21F2313B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 06:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D8158208;
	Wed, 20 Nov 2024 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xeqo0yeq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0729156F3B;
	Wed, 20 Nov 2024 06:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732082834; cv=none; b=GhJwR3Yg8qAGLdHQBxzyC/414QBHFbbQTu3XAABwNoMIKurM8OpsUckOGu0BbJ1n6SLCyAmw6FHwGo//ztngcUDidQ92b82wKXUVhbs4l0tNdFu96w6gFMjapxnOXATg02wsUUhyRQWhbSVBjhoH6ddCEAYytf4ZGMRlXSQ7oEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732082834; c=relaxed/simple;
	bh=4cJTCxsXY62cB6J/+hqc9xCi6TO4Z3RkavknfpO2fHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xm9F9D6cLMvrNFgrHrXq0rPx93zDZdQn05q0dQ5lZVV77sikyihu3rnNSk7pnTMbs9IilUWXicMLjj0umm1uYCno1uwA4yrPcU2V9jkYaBc2whdBvbuy/xhpx66ONnp3zXZJuAhSuqVdTI3jPxykuylp+E2Z2NhFKmXfJNAoJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xeqo0yeq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ce54rqK/J86f7QozBZMKMORdeVk/86bdPT1aNkQxOQg=; b=Xeqo0yeqS2o7RcsKA4M/96mx4F
	1rk5cr9C2VsLlre4eEoU6w6tC04w1m/Na+gaYW4Su9nZwl1Py4D0xfuh3Gp01xAFrRzmbtbDBf1ea
	a+gYnU+vFBNtW0l3v0fuFDwiCvHHjbBts33hqWj9VzAVTZjqevHeBXdvzVKqDi/FlUWKWSjqdl8qm
	wlwgZkKF6qYCqqRbhC4WTAsiYWVCJIVylQKnn5b2usrV+v14rRys2mbYwScsL4f/oS6XK5LBx0913
	LsXSdP5Mca3lHSmeJNic9tdVbRLAT/NbASjptK1CWbaJA+EWRykRmt/j7v4hnGtDkkxYwqMgATcFT
	13G1SICw==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDdrr-0000000ETXK-2nVV;
	Wed, 20 Nov 2024 06:07:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] Documentation: core-api: add generic parser docbook
Date: Tue, 19 Nov 2024 22:07:11 -0800
Message-ID: <20241120060711.159783-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the simple generic parser to the core-api docbook.
It can be used for parsing all sorts of options throughout the kernel.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 Documentation/core-api/index.rst  |    1 +
 Documentation/core-api/parser.rst |   17 +++++++++++++++++
 lib/parser.c                      |    5 +++--
 3 files changed, 21 insertions(+), 2 deletions(-)

--- linux-next-20241118.orig/Documentation/core-api/index.rst
+++ linux-next-20241118/Documentation/core-api/index.rst
@@ -53,6 +53,7 @@ Library functionality that is used throu
    floating-point
    union_find
    min_heap
+   parser
 
 Low level entry and exit
 ========================
--- /dev/null
+++ linux-next-20241118/Documentation/core-api/parser.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+==============
+Generic parser
+==============
+
+Overview
+========
+
+The generic parser is a simple parser for parsing mount options,
+filesystem options, driver options, subsystem options, etc.
+
+Parser API
+==========
+
+.. kernel-doc:: lib/parser.c
+   :export:
--- linux-next-20241118.orig/lib/parser.c
+++ linux-next-20241118/lib/parser.c
@@ -275,8 +275,9 @@ EXPORT_SYMBOL(match_hex);
  *
  * Description: Parse the string @str to check if matches wildcard
  * pattern @pattern. The pattern may contain two types of wildcards:
- *   '*' - matches zero or more characters
- *   '?' - matches one character
+ *
+ * * '*' - matches zero or more characters
+ * * '?' - matches one character
  *
  * Return: If the @str matches the @pattern, return true, else return false.
  */

