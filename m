Return-Path: <linux-fsdevel+bounces-58507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAA9B2EA1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4723C7BD84C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DB42080C1;
	Thu, 21 Aug 2025 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMFZvGmp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020251DF97D;
	Thu, 21 Aug 2025 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738583; cv=none; b=ohavqaQ2NrjPpxHUnPerBUNq7XK6IjW48RRW4u/AuIyC7lYlxUptv7VpdKQep/dg32LG+W4i228PZ4q6CgZR5swmC533F+7vlfNIRTtlsV/rvGhJWpyGTtip+bomHjrLxpT6vO6+jOrUCgnzGuJEmxOjcoc0cp2D7mQjzlDP9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738583; c=relaxed/simple;
	bh=v5UltaF6dg1op6lfB/udTZ4MGiIr5vxYDaWbP7EXQqY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRmXPPaDylwm7zw98Cv3OMpBu6fK9be5Pp0CsiVDqMYG0OAqXPZSBmPhtMCdiYoA10qylCZgyPf7WdCuMhtWgmXIXmjZACttn3zBySInif1Gb/gHGeNdNaXjlSUzIcsxTqEl+KzJvWINXr2MT1omu4pEx5gSGEcieTqtDrWFUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMFZvGmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAC0C4CEE7;
	Thu, 21 Aug 2025 01:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738582;
	bh=v5UltaF6dg1op6lfB/udTZ4MGiIr5vxYDaWbP7EXQqY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EMFZvGmpIG9we7MQ9trQMDowGByaGTmLll8M6tdAn/CtVygzDh0IXVj3snxy0FYtO
	 y1hulXc97UUP1KpmDAP2sMkK/H1l6Cr0la2PZIRdzZbs1fkD66t4C+Tu4ZNwplqd1M
	 4YqGzmnHDuLfZbfqQfL4E21GYYu5AxEM9RZZwfF+P6M8HvBzRoBtCzPNVElJvS9H9P
	 ls9RUqM5HlQ7g5954mJblyFqkP+2vk8s/2AqDMIA7rXASy9/L0CN9D5xA2XfI1NslG
	 xs3obRpsB0tT0coiFUa2lt8vjRhdnKgHmut9C7OPFibYpHdx9dVaLYIyiX0WKXWu9Y
	 mvRYNdfOH0Lfg==
Date: Wed, 20 Aug 2025 18:09:42 -0700
Subject: [PATCH 07/20] cache: disable debugging
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573712934.20753.3776554977380229215.stgit@frogsfrogsfrogs>
In-Reply-To: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
References: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
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


