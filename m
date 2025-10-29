Return-Path: <linux-fsdevel+bounces-66077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5D9C17BCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFC71C6114A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0876D2D7DC8;
	Wed, 29 Oct 2025 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1czh+iL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA623B638;
	Wed, 29 Oct 2025 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699873; cv=none; b=lPfiYf2F+pgyXj7RmxZgdbdY8LPxGTUP2KbKCpghao+5lmS/l/l+rGNefy8/bGbTL0xnxYkmCBNiwWs6WKURVCuEBHcHYLXrCGO2Z3e4L3Dzq4YcEwm01LIejBqBzluBlUGVceWgEk50vCVWOwhOcGSwkBk46tPaq2PMmZnKJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699873; c=relaxed/simple;
	bh=WmWtdnOjFKElP8rAa1iZpOnFGbNF06RW4BiWKQNQdZg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWjlp7Ke9YbjDwXaXT/H/npDsZ0Wzh0TTycu+BwFQpy+gKWZn0G3BYzKcCKnp24jWxKG9+jNeBP3aZ+grMCu1lyxUbZ9e1pGOJNB3UIcS5NwOY86EGixr48/T3dYYE4JcNOEZ2k/+Tl8ZqlR9jThEM3hEOcsonn+4X9KO/KRU0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1czh+iL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BDDC4CEE7;
	Wed, 29 Oct 2025 01:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699871;
	bh=WmWtdnOjFKElP8rAa1iZpOnFGbNF06RW4BiWKQNQdZg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=n1czh+iL2hWCnzrrwYa/q+WV545bWWA9DZo4P8xaLjMu2/zrfTYHORBD2ARorLzvY
	 Uj4iOr9EEd5dJADWFSm3yv20udFA0GC/4fxvss0HD+OduwegYlT8ed2Nq9ADGgOVyt
	 WVfZHofT+dlZAfAtIpgGpGjS2qWCjSPobty7CWxopsESa3my5Fv+fJVrdHskY+TPcB
	 sWcfqCtA7GBoYIdcMT0bJ+t564VGLpXWWWYh5cpQ4QAmbgxPZR401jCJ/7AJGNStfg
	 /Bzvf4p0LMHTUWSVF+fFxYZLHPxT1AsMHptGRKxCVFqjGFeiM/VYxEF1WFws+ogBab
	 FykSu94lDgvaQ==
Date: Tue, 28 Oct 2025 18:04:31 -0700
Subject: [PATCH 20/22] libfuse: add swapfile support for iomap files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813894.1427432.14190543050440526022.stgit@frogsfrogsfrogs>
In-Reply-To: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
References: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add flags for swapfile activation and deactivation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    5 +++++
 1 file changed, 5 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index eb08320bc8863f..83ab3f54f54a2e 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1190,6 +1190,9 @@ int fuse_convert_to_conn_want_ext(struct fuse_conn_info *conn);
 #define FUSE_IOMAP_OP_ATOMIC		(1U << 9)
 #define FUSE_IOMAP_OP_DONTCACHE		(1U << 10)
 
+/* swapfile config operation */
+#define FUSE_IOMAP_OP_SWAPFILE		(1U << 30)
+
 /* pagecache writeback operation */
 #define FUSE_IOMAP_OP_WRITEBACK		(1U << 31)
 
@@ -1229,6 +1232,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
 /* is pagecache writeback */
 #define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
+/* swapfile deactivation */
+#define FUSE_IOMAP_IOEND_SWAPOFF	(1U << 6)
 
 /* enable fsdax */
 #define FUSE_IFLAG_DAX			(1U << 0)


