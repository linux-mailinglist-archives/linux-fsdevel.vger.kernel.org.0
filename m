Return-Path: <linux-fsdevel+bounces-14349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B7087B0B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FD41F23F32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AB25A0F1;
	Wed, 13 Mar 2024 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqHVl3k0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE415A0F2;
	Wed, 13 Mar 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352777; cv=none; b=XS1R5Bmv4OCUTquVa0txGn8IdkOYVUATnFzi61Gz6Uf+uI6wiYgQ9rv5EqRiOsZkT9G5+0gLeJdDclrJEN1TZKsLa6xMvp8XGhwOBZiyk+xUgDPzy7dJbasRFMWyjNiRu0mBetZqoX/RkX/vw4mBHZT25aCNnnvg3+s1MV2mero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352777; c=relaxed/simple;
	bh=PJf7MhulP7KKfLxtmjzccQbLC0uIEQngYqJwN54SY7Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTthoBAS6A/3yfKjWKXAAWr5cgR9hBuMtXG9h8IGdfhmzZ2K6mviWegaYyUUzSxk5UMoD3vqCmiAVrgUdx1FGg/A2rffMnx/dlNxUQ73JAfAiJTB4GtlW/kNLk6a4vGOm62V5uxF3KaSvXUtGItALo3c0hTRCc0EGpZzaHDIuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqHVl3k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3335AC433C7;
	Wed, 13 Mar 2024 17:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352777;
	bh=PJf7MhulP7KKfLxtmjzccQbLC0uIEQngYqJwN54SY7Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HqHVl3k0XwBOmrE9c+hyoBNAkXospKmHXOpb+RZ+N6ZiZaLla0tUn4JD9sAO5nhuw
	 3tUPJAujQpqkH8/QDyekEdZeakeiOw8wrSpzDutX/CV3+9R6iM1WOOWdPwHR3IF0cr
	 Fzk/gz9JQ1IIFS+Qd896iX+/lQz6Tq5h8lBmGbz6iwzb6IcF9UyBd8aMDnzKJwsuBr
	 Kipk2MG35eFyQatyg35cZWCeSH8pbGkqfuQMVCakP3oeuxlqo+Bll4GvbOM901jBWA
	 w/xXq0ATnAmZ6c+nTI5B2SR0kFKA0W2fvC1RvBBejE8KIuAYzC9h02kU0O0HjXC4yy
	 PgmfA6k6B+aNQ==
Date: Wed, 13 Mar 2024 10:59:36 -0700
Subject: [PATCH 27/29] xfs: make scrub aware of verity dinode flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223789.2613863.9923257124399937228.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

fs-verity adds new inode flag which causes scrub to fail as it is
not yet known.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/attr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 9a1f59f7b5a4..ae4227cb55ec 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -494,7 +494,7 @@ xchk_xattr_rec(
 	/* Retrieve the entry and check it. */
 	hash = be32_to_cpu(ent->hashval);
 	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
-			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
+			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT | XFS_ATTR_VERITY);
 	if ((ent->flags & badflags) != 0)
 		xchk_da_set_corrupt(ds, level);
 	if (ent->flags & XFS_ATTR_LOCAL) {


