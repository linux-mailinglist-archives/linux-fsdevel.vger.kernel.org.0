Return-Path: <linux-fsdevel+bounces-66055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 52534C17B2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0911344814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E192D73BC;
	Wed, 29 Oct 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZFS2jhh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A952277C9E;
	Wed, 29 Oct 2025 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699528; cv=none; b=jom0nTAi8brApGmYadV9RJ170wxXHEXaC+BqejxYxTjzV5PjCEvktKxX6tTNyrjL1H+ev9kE2V5b5oV0nDVBG24sem/Cezpn7ylsJgCT/o8Jywjf2HKqJ5DUIpJ16ciSB/sUgL/IHLUhFaXWJEnU2GAZfvpwmGZLkynZnKE0yCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699528; c=relaxed/simple;
	bh=VUQ5+70kkzxj4mhG7hh8UZZXjJkTJd0+iwlsBvUFCXw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+jXzY6fXJ/wn22vNEop7u/8ArC9JBWh4nwN8iexR9NXInMVxTuqepUg+rmwqBhbYMGj+p3LIeYKnOK3AErTzSizMra4zCidlFH2s/CyaYMriIcpUoywR9STJaa61AEx9z+V6kyQYba54pTmM7XsHqGN3v+Q6ZtAyIctrAF7ZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZFS2jhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3C7C4CEE7;
	Wed, 29 Oct 2025 00:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699527;
	bh=VUQ5+70kkzxj4mhG7hh8UZZXjJkTJd0+iwlsBvUFCXw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bZFS2jhhPO8bxmFyEMC2viufsARxl6EHD3wt19sGVACJx5ibw8W6aMYW9Gw7p4Z57
	 Zn8g1O8lVBXRMR0vSBjNCu8nVxuEOj36h19j26JRZBa2LQdOr4f9zsbGNpbvsdIafr
	 +aCodN8J/A4cHkUhAN7B2awbTGfpnFRCrEfxSZV7d+cJr7l/93ITqp72u/o93Bu52B
	 LpN5NKYWcBz44wiWD8hBwWQ8kBUWc5H5QSuqRe7dA/buzyn7QnGGPVYtmN+SSgdx/J
	 bx7COxN2RQu4N1T30TXXnpm37Gg7VgcV+Mu7qqGOoFVKp8Tu6f26UJRDfoUuWGJE3V
	 BTOv/AppV1nWA==
Date: Tue, 28 Oct 2025 17:58:47 -0700
Subject: [PATCH 10/10] fuse: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169812293.1426649.14459335530115245604.stgit@frogsfrogsfrogs>
In-Reply-To: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
References: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Remove the guard that we used to avoid bisection problems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file_iomap.c |    3 ---
 1 file changed, 3 deletions(-)


diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 94a9c51f3d75e5..9d77f4db32d7fd 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -105,9 +105,6 @@ void fuse_iomap_sysfs_cleanup(struct kobject *fuse_kobj)
 
 bool fuse_iomap_enabled(void)
 {
-	/* Don't let anyone touch iomap until the end of the patchset. */
-	return false;
-
 	/*
 	 * There are fears that a fuse+iomap server could somehow DoS the
 	 * system by doing things like going out to lunch during a writeback


