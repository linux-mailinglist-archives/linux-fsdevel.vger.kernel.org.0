Return-Path: <linux-fsdevel+bounces-15741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A67892871
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602261F22177
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DCA187F;
	Sat, 30 Mar 2024 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3PQhDW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B417CD;
	Sat, 30 Mar 2024 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759371; cv=none; b=PwTOP9Y6SY8WXgziRK379S0XBAeOxbKkpUlDk2aJcn5VzysYnrkwOV5j4YHL76o69sN6SLKqNpAv973hNBGEqiC7h4v0AAona86wrBCapug2i7zOSZ4KoZBKcSfZ6Aa28aN/84gd9lVrZSNeZIqFt6YxwCGWYMm7MBQJC4TnBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759371; c=relaxed/simple;
	bh=VeUFn0jOOl2M9lCOTEpG5cert/hTikiKx5Ali9PEIco=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dx94gx9GB1VRH2eUMAgaXQh4y9kcBgoSUt0uQXwRUDuIW0vcFOGaFw1XsyAayANTS/ddWimhZfsR2B9032MaZ+/7Ce8w/P14ZDs/ipRMVNgVYBitIokfQyOHkstHv69E46DTkxmJWDUdg+20GIDyERsMBTAOyyBtvepg9Kdd2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3PQhDW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5828BC433C7;
	Sat, 30 Mar 2024 00:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759371;
	bh=VeUFn0jOOl2M9lCOTEpG5cert/hTikiKx5Ali9PEIco=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=B3PQhDW61mYPA96QxGqJ+M8W4Qo7dHu+DO/gXFg0mG9LknskptNSIn0mc4eNhP37g
	 cjxEgofkX5pPUR60eQotrzQEWz8pvzYqFP9xrBjCpfWXu61X1vOZsnbtLq19f1BFc3
	 16msum/rPa7mFJg1kefHmdHk584f40T6ENYiPQVFkuwg64FRmSL6YIiTYsNTfT3ii/
	 504NkSgJ57GysHVf5VZzdivX39V1ST9rVoEdMr460wHcfHHk+WofltX/G6qFhbqyRX
	 1D+EDmW3kchPGYd+MTj2iddvtkNr5o5SzvfZqSP+S6AjUqcla4SY+2/8FtZlBm/c6P
	 UnKEAIsh89bnA==
Date: Fri, 29 Mar 2024 17:42:50 -0700
Subject: [PATCH 26/29] xfs: clear the verity iflag when not appropriate
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868990.1988170.5463670567083439208.stgit@frogsfrogsfrogs>
In-Reply-To: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Clear the verity inode flag if the fs doesn't support verity or if it
isn't a regular file.  This will clean up a busted inode enough that we
will be able to iget it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/inode_repair.c |    2 ++
 1 file changed, 2 insertions(+)


diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index fb8d1ba1f35c0..30e62f00a17a6 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -566,6 +566,8 @@ xrep_dinode_flags(
 		dip->di_nrext64_pad = 0;
 	else if (dip->di_version >= 3)
 		dip->di_v3_pad = 0;
+	if (!xfs_has_verity(mp) || !S_ISREG(mode))
+		flags2 &= ~XFS_DIFLAG2_VERITY;
 
 	if (flags2 & XFS_DIFLAG2_METADIR) {
 		xfs_failaddr_t	fa;


