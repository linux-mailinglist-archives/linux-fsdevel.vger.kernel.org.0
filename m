Return-Path: <linux-fsdevel+bounces-14609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDAF87DEA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F82B210DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE3E4C84;
	Sun, 17 Mar 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4CuLmWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379291B949;
	Sun, 17 Mar 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693105; cv=none; b=qN7fG/3RPfuvZXx/7wGod8O4gF5+EOXGY76BJI7PdIstzybbov3D3O/7X7Y3vfJ0QpWm/6nq82A3lUhXglLXAHtWDdjB5Ngs5SROYMshF8wtvPTvSobuQmjlBD/eKOfxrGGcbgM99KTnphTyMTrw0NU/30dl4zfh+MgcvHJMvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693105; c=relaxed/simple;
	bh=PJf7MhulP7KKfLxtmjzccQbLC0uIEQngYqJwN54SY7Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwIdc9/CANrpv7+iZNHuABxjL+7vd1dT5L/iFp5wjDtwQvTcqrlSXA3FGlil1MV+sh5I0jd67OiEiudclKnNvVmVQk4iUVOHp5vv7mvnt2cvyNY179KD/9wreXE3lUJH5puSN3yzoODW7ctD4G7msD5DPGecs8FzxxCIhsLKSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4CuLmWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C032C433F1;
	Sun, 17 Mar 2024 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693105;
	bh=PJf7MhulP7KKfLxtmjzccQbLC0uIEQngYqJwN54SY7Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=J4CuLmWx+vJKNWGZd4RlzyX1O1iMhDxXB+8gO90kJmejQy5Ccib1+HtTAuSzcLyzq
	 mAsUow9cO0kLiJn7NeF2NuRoc/yK0VPs5QNT5qWAXWh+4osGIn4Au+KAEB0LV+ZKOi
	 yom8KMDAf7wH9lABaefiYEQKFPhLRCCrFXiUSXS4dxr+oYD8M5mHeM8kBL+odWpL6j
	 OKWk/owzkQTt3ne60zBWt/05hDs8cqvsYcpQBlrbzbX4Ap34DPjDkSarfbkrvvMAnS
	 VYHQ82wSmohCso+LWOxzhxjQLWSxQZECosZH0zpoC81rEvrSc4IUBH4jV0kGyzClp9
	 O+LtKWfKO0hrg==
Date: Sun, 17 Mar 2024 09:31:44 -0700
Subject: [PATCH 32/40] xfs: make scrub aware of verity dinode flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246423.2684506.11981674588788931642.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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


