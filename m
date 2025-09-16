Return-Path: <linux-fsdevel+bounces-61599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C00BB58A2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3446717A09C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A894D1C3BE0;
	Tue, 16 Sep 2025 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaBoVXH/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16DFC1D;
	Tue, 16 Sep 2025 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983965; cv=none; b=nMYPRXyojkTo2dgs77PTdTVH0HEVHSLlMOIIDQnYYRDCtZb0A7eTVUfXVQc7HcLO72MpKFB/9GKidxT/9tUTuw6umkBoWIZNoiSjdV9KU/HfJPD8rZA6yxdrQkKRG+4/4O6TG71qB7LEolgH3UoUzt6ZprA58GaRUpohsT+JXE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983965; c=relaxed/simple;
	bh=v5UltaF6dg1op6lfB/udTZ4MGiIr5vxYDaWbP7EXQqY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfS3b74512A5WzIIaNgp+anHp/3M20qpfUV2oEgSC5vekZuO1zBzxoRGmdqgBGKci5IDCmx2MamMf4G/Gn9FbDZuMlVUSmxs6jb+nbfWtjY0Niksm9aQMsWQEjdtN2ByMXmWpfxN28vTcuZbpsZ7GxXGVl7sx7Hso6KOws39HMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaBoVXH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09E9C4CEF1;
	Tue, 16 Sep 2025 00:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983964;
	bh=v5UltaF6dg1op6lfB/udTZ4MGiIr5vxYDaWbP7EXQqY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KaBoVXH/PpNzxxqXU+N+6jNkfuM5HddSaZhOrQrJ1D23Ajoyoc7nSK2JmFljN3a8/
	 xDMQRPQaAbcKb7vy7ubKMUJgS1/YKKLbz/uQBiWxaYU0HthO7Fm5jFMPsNBdMBdo+V
	 t0Sc0FgnviIt6gDUtB1L+2ltPrf+IqLG8yprvmmx8n0Swi5s21qg9EG8p4vjU4HGcY
	 v/Tpo6IP+f5YPFpZtIdR8vukUHUZleDeDUBZYugF0vsvRtwg/JDUyvulkkvy02uC0e
	 Uag3nnjIiJAc2lWuGVK0zcrkdwfZW9L+uOBREEjoi8bGpCiF1UyxSpBMjsqGa9IK58
	 GBycNIcRJWRiw==
Date: Mon, 15 Sep 2025 17:52:44 -0700
Subject: [PATCH 08/21] cache: disable debugging
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160921.389252.14773848298551135362.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
References: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Not sure why debugging is turned on by default in the xfsprogs cache
code, but let's turn it off.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


diff --git a/lib/support/cache.c b/lib/support/cache.c
index fe04f62f262aaa..08e0b484cca298 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -17,9 +17,8 @@
 #include "cache.h"
 #include "xbitops.h"
 
-#define CACHE_DEBUG 1
 #undef CACHE_DEBUG
-#define CACHE_DEBUG 1
+/* #define CACHE_DEBUG 1 */
 #undef CACHE_ABORT
 /* #define CACHE_ABORT 1 */
 
@@ -28,6 +27,8 @@
 #ifdef CACHE_DEBUG
 # include <assert.h>
 # define ASSERT(x)		assert(x)
+#else
+# define ASSERT(x)		do { } while (0)
 #endif
 
 static unsigned int cache_generic_bulkrelse(struct cache *, struct list_head *);


