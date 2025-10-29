Return-Path: <linux-fsdevel+bounces-66054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6218C17B26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA3454E2FC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BAB2D6E55;
	Wed, 29 Oct 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY1Fg6/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E2281531;
	Wed, 29 Oct 2025 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699512; cv=none; b=PpGK446WZre9sgsuO5i4o8Mft8d5OAEmfdKJn6nDEYXSK2EInRaH+cSxzq1i9pGu75YFiP4bK0ZOGDyfjnQLLM461y5As2xBUyqKw8vn7n6c8uMp092O6JkAHD7uze0huDg+s803e+ywQC3G3QEft6fcRz+OfFPMowmc8YlOCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699512; c=relaxed/simple;
	bh=AUZD5kEP210ns+aHOOdFY+SxvCq5aSjRdoTaj9N2isc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AotDp/U3zO6QH6QFm4R4/bfrmJDU2QkKpsc2VWjk6CnK++dh4gPhQ0AJfgD32TIibMt3n0LvPdffsW2qC8G8XVIYQJSSYfgdIHq6Qrl21il1ELr99/XRzICI3+Bb9xmt665I6U1ZM21o3TkqnkjQiGDBMT1LexH7AYdf5TrpPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY1Fg6/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9BAC4CEE7;
	Wed, 29 Oct 2025 00:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699512;
	bh=AUZD5kEP210ns+aHOOdFY+SxvCq5aSjRdoTaj9N2isc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DY1Fg6/TArQiTz1NozfcUswZpPU2cDC+ahq0PgFMAocuKPb7tc6mATjvSSI15PgdV
	 jbHM1kseDla6C4XDquDh1nOUFmBOVLmuvd2vFLTAoY6xGLnrvV3KeN5VeAzdMxaWDr
	 IDFjCAQInFUGCF95bhHrmOY3n6YUfWi+9SFAa7HYUwc24gj0y2vb2z1EVUQHDPb0Kf
	 XvjTppLS+E6hYIR2MWA5SRfEyxVNnsaytpbCNmPtnOQVkmhQUp3/rKZaC16QzYJLfP
	 +Mi8JQ2aOkFhh2BJr/k/FDSvmh0t4zQXU4mVm++sBZwVqbw2dZBLTQZfuocEe7Cd1b
	 +TxdbPgqBAx8A==
Date: Tue, 28 Oct 2025 17:58:31 -0700
Subject: [PATCH 09/10] fuse: overlay iomap inode info in struct fuse_inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169812272.1426649.9645304318968023284.stgit@frogsfrogsfrogs>
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

It's not possible for a regular file to use iomap mode and writeback
caching at the same time, so we can save some memory in struct
fuse_inode by overlaying them in the union.  This is a separate patch
because C unions are rather unsafe and I prefer any errors to be
bisectable to this patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 03fecb3286c29e..0f49edaf951a6d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -199,8 +199,11 @@ struct fuse_inode {
 
 			/* waitq for direct-io completion */
 			wait_queue_head_t direct_io_waitq;
+		};
 
 #ifdef CONFIG_FUSE_IOMAP
+		/* regular file iomap mode */
+		struct {
 			/* pending io completions */
 			spinlock_t ioend_lock;
 			struct work_struct ioend_work;
@@ -208,8 +211,8 @@ struct fuse_inode {
 
 			/* cached iomap mappings */
 			struct fuse_iomap_cache cache;
-#endif
 		};
+#endif
 
 		/* readdir cache (directory only) */
 		struct {


