Return-Path: <linux-fsdevel+bounces-61556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66BCB589E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1653BB2FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D39B1C3BE0;
	Tue, 16 Sep 2025 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9ODGYWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E115665C;
	Tue, 16 Sep 2025 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983246; cv=none; b=Zf2gXDGzKaKbLmQExgn/5tc0jhMCUaTrKTAmUvKMxFxsxHIxqJL/ZhNKSlALFZwgvyozcnhrwjasHQDVCGSgrpPCT5Gd6W5GQa/ywX7Y7Z0FETDAEuP2g630cztnfTthwHAeMJIEChAG5CCG3lWuuuoT5OzTQk5JZ+kqVhO6ViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983246; c=relaxed/simple;
	bh=QN4mstiyymBCHL+3OCA7XiUXIT3Zuea2wsCN77lFtUI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NatW7NiQpVoevlxi2fm5FQtXfdt4zmJw8c/hma+tCV38cZytJG9ZIzD7AexITV6KlFB3ePgKt44JFpvgG+Ag/8veBOGACbcQhA93zbYg4xHN2f/pH12m1d8aFjTB/dEnanjT1jD8RjFcks0ymgz9xZnbIyX2DXunEd5wQVJPdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9ODGYWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA03C4CEF1;
	Tue, 16 Sep 2025 00:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983245;
	bh=QN4mstiyymBCHL+3OCA7XiUXIT3Zuea2wsCN77lFtUI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=k9ODGYWRhSLrbCWA094XV61F4FBpnvkgeKJWseJP1gxBWWjJ31dHsRHUE3BpavjVl
	 5A6p8wOFjxw52P0Nh0gMc9nwixWcH8lZOZK/HJ8GSdhSlVwTohgDAEHF9O9C93qKAS
	 sY1euYYZyfuQH3CGuecPqhoFhDG89xbaL76QVThFpF9wHv0pps8w4EbQg9DPat8w/M
	 eKPybnpptrgulpn89P4seg1rlBj1nd2dvXZKANuu7s8+6xnsYvf1EhE2nll4G5jM9O
	 /suoZLcNgkcZZeFTr4xQyzilVIY04zYp9cPe3DcchbARaApTSSMsde1hXyrwlDk4S8
	 i+3MKTEGzG6sA==
Date: Mon, 15 Sep 2025 17:40:44 -0700
Subject: [PATCH 09/10] fuse: overlay iomap inode info in struct fuse_inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798153119.384360.13338873407390469715.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152863.384360.10608991871408828112.stgit@frogsfrogsfrogs>
References: <175798152863.384360.10608991871408828112.stgit@frogsfrogsfrogs>
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
index d42737bac0af88..8238c1cfd9c481 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -197,8 +197,11 @@ struct fuse_inode {
 
 			/* waitq for direct-io completion */
 			wait_queue_head_t direct_io_waitq;
+		};
 
 #ifdef CONFIG_FUSE_IOMAP
+		/* regular file iomap mode */
+		struct {
 			/* pending io completions */
 			spinlock_t ioend_lock;
 			struct work_struct ioend_work;
@@ -206,8 +209,8 @@ struct fuse_inode {
 
 			/* cached iomap mappings */
 			struct fuse_iomap_cache cache;
-#endif
 		};
+#endif
 
 		/* readdir cache (directory only) */
 		struct {


