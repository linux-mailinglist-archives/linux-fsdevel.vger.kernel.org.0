Return-Path: <linux-fsdevel+bounces-15738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BB589286B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA38282B43
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF71366;
	Sat, 30 Mar 2024 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/LQBOA2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A591197;
	Sat, 30 Mar 2024 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759324; cv=none; b=V0KTDuduNwTPcj4Vxlg+1Pzu8qF303MiqjSIn4gvkcZunXgHyabGB5FNI9VOYSf+4l6+nQzW0Eqr+kfpyILdOt0JTOCyLhoWAmrEYnNly576SaE65rDT+C2pwpcRgJ2ASlbMdGTUehrlkQNYRxA09kWUKDkw2ZZtO7EOMSB+gDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759324; c=relaxed/simple;
	bh=fSkN4zp4s80ZogAritYq8K500LzdaGDK5iHf2yU4sPw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWltnNIUct1Ij4UMnqObXnL85SKKBuE1s7/ItRgY0nHHjNQyUlqF/jG+jRHf+5rRHPx0oiXp7yoAdANl2Fc+BJMLSnc00r+iCrPuiABGpyEnJf5CG6AqALlCmq7sVGBVbx2KEeFCuM7kIUFRoIqjW78z03B2YQepMgSxSkPnMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/LQBOA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71560C433C7;
	Sat, 30 Mar 2024 00:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759324;
	bh=fSkN4zp4s80ZogAritYq8K500LzdaGDK5iHf2yU4sPw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=R/LQBOA2Du7+7NgzMgXzAdOCOMz8Tj17t7KbqJXV/Nel/UyRTN32GAr+r9Io7dkty
	 5fg/jEdQFoZJZhnZPgUuMejPW0siaooeR8pdeeH/Hp5NCQFtaAYSuy2PSbevdmNEPH
	 qgFPOmVVZMCsyndKl/t/FETlTFV14qM20bLQ4077uy8Vml8/qbGSC4N80VwJ75Wr6G
	 YD9YJCkpd8OrtErAZRuzbpeOctIfoAUlDgqoiBVPa3Fv6xet1rrivwHEutzCz7+nW4
	 0/yPZtap4UnuOqPMePyrbM8LivsZT8cjblrikfz879lfq6xMud3LXAMAgOQKris1cd
	 5hq+tuuTaIZAg==
Date: Fri, 29 Mar 2024 17:42:03 -0700
Subject: [PATCH 23/29] xfs: make scrub aware of verity dinode flag
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868940.1988170.11383189307618531974.stgit@frogsfrogsfrogs>
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
index 1608d1e316c99..2e8a2b2e82fbd 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -514,7 +514,7 @@ xchk_xattr_rec(
 	/* Retrieve the entry and check it. */
 	hash = be32_to_cpu(ent->hashval);
 	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
-			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
+		     XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT | XFS_ATTR_VERITY);
 	if ((ent->flags & badflags) != 0) {
 		xchk_da_set_corrupt(ds, level);
 		return error;


