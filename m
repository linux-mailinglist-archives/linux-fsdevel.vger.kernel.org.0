Return-Path: <linux-fsdevel+bounces-58492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8F8B2E9FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A0C7B8FD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62F41EDA26;
	Thu, 21 Aug 2025 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxrybohT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237D1B87F2
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738348; cv=none; b=pHJPMVIq2g5ZxXdnF3Cxg4aESn153z4EzFuXhOGKxHM3DMx9WcbRgvUFRzFUTrdVbeWlk9rUQMu49T8f3GXikEECFUPZy64XWxkqlDv9MYDuNhAivOEyMcWMfRaba7SWMA8JSeOAMpdWipPhArq+BeK6CPBG+msKcE9ZRx9Yozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738348; c=relaxed/simple;
	bh=Pd4fRhFlYU7lnzqmwX2KhC2HVd3ecLhT8XeXjR2XtUU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QA59Xolvi+t5djUXa9jw/xX1wO16WNLBZ+NdgdPjOyl0Zzmkq0GSaUWrJTL3Kwr4/H25zNiYZxQDDUxDEnVDqSJCNyT1Wv1B4YfWwRh7sJpXJ+2ogXGh441DTfnohDFeYn3m/BipbP8A2pq/W6fLLzpuGrRGC60k0/NE+1+51eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxrybohT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BCDC4CEE7;
	Thu, 21 Aug 2025 01:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738348;
	bh=Pd4fRhFlYU7lnzqmwX2KhC2HVd3ecLhT8XeXjR2XtUU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VxrybohTStAHSbCBCk6xR9aq0u96cwDzviw4KqQBM5P8rttw0zJ5HgbaSKC2BvXfW
	 0mFF+L5TyVEoni6Vt6qVbzDUVyhltfaS7QeCBhqIiALDLbGLsf/MfFrGRI1HFq1uPj
	 F4OkPL1OWl4LIV1LNFus6OIP9flmTeI0hnNCGOT33/Mg0/5xrqblrCF11IHmn2qTjx
	 qJbI7Rp1BmHMiGJ/q4z4Hw6h1JxY7I6U7Xx7TzqBOzBz4Dx1+rlvLNdOy/AHN3iNxA
	 buB2i5jw5ZwZrSpId+vUKkUeerSR+OSZUKPhyfvfCTrOPZTLaPIR+lfCw5WMhrivbF
	 v+pyk+fKcFu/w==
Date: Wed, 20 Aug 2025 18:05:47 -0700
Subject: [PATCH 17/21] libfuse: allow root_nodeid mount option
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711603.19163.2659302881409752887.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow this mount option so that fuse servers can configure the root
nodeid if they want to.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/lib/mount.c b/lib/mount.c
index 2eb967399c9606..140489fa74bb55 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -100,6 +100,7 @@ static const struct fuse_opt fuse_mount_opts[] = {
 	FUSE_OPT_KEY("defcontext=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("rootcontext=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("max_read=",		KEY_KERN_OPT),
+	FUSE_OPT_KEY("root_nodeid=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("user=",			KEY_MTAB_OPT),
 	FUSE_OPT_KEY("-n",			KEY_MTAB_OPT),
 	FUSE_OPT_KEY("-r",			KEY_RO),


