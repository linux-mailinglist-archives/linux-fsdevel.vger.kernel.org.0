Return-Path: <linux-fsdevel+bounces-18246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8238B68A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2E22834D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1501B111A2;
	Tue, 30 Apr 2024 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGsjAm52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4DFC12;
	Tue, 30 Apr 2024 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447713; cv=none; b=AA15OUlBVXBfZ9u1GUVXsmlmO16R4zIGOvxmRr6S64+xfNWgRJJ3WBrSy02QK9KP/zFJH+DUEqewFndf3EpZY48F+2FF0zqHGSXCGIucac4uGNi4p9N4X0x8EnzsiROyeF6qUPpKf2psWDRilEpXGwWCtJkEFlMSthKTwqcBoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447713; c=relaxed/simple;
	bh=Y8ydKds1U2pvghMYIgw6Fxe3YX2j96GNme/aPZBSYB8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOAfzLkA5bW0xzsAJVqizzpYB3bHe1bnfGFk/50fsc6SEEjGway0B9FxlKXuIBmvlyETs0/vXJ50PHDSkJ7DvaHs9ShveOLR7SE/vUGSUIanglGV+YEgtZTe2ABuHRhGTmQoZ1Zx/FRwopC0RgA1mXBNyDt1fCLbvp3HrX5YRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGsjAm52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DF0C116B1;
	Tue, 30 Apr 2024 03:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447713;
	bh=Y8ydKds1U2pvghMYIgw6Fxe3YX2j96GNme/aPZBSYB8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fGsjAm52p2L68X181ZkAValyGkrHC3kWhCynn6WOsw2BPDqjHce/h81sa6BaNQz0F
	 j4nzWiOcsxy6+PYtYJxAEFJPhoEe+xR5hPSsIfIMSzkGc63lJM9vrqEfOLTXBkzwDj
	 RH9dto0hLX07QNyWtZWkYU6EZ4elFxlDygtIn9MftN2HrWyEZ+MzogIq9+d7J82vyZ
	 HpaRFTasBVBz7FZVh7J4NxSfFPRDwxyq+rWZqMLFDWI/kUuiaKqXGhVch8cDlX23+U
	 jMbTN9ZzACkW83Hw/tA5Ajo7Ey0rlTpzPX40uF9sE7xN1tAZ/vW79EHet3gTOfYKqW
	 K/M3sN1m2fEOA==
Date: Mon, 29 Apr 2024 20:28:32 -0700
Subject: [PATCH 17/26] xfs: don't store trailing zeroes of merkle tree blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680655.957659.12064584983986798030.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
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

As a minor space optimization, don't store trailing zeroes of merkle
tree blocks to reduce space consumption and copying overhead.  This
really only affects the rightmost blocks at each level of the tree.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_fsverity.c |   10 ++++++++++
 1 file changed, 10 insertions(+)


diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index 546c7ec6daadc..f6c650e81cb26 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -874,6 +874,16 @@ xfs_fsverity_write_merkle(
 		.value			= (void *)buf,
 		.valuelen		= size,
 	};
+	const char			*p;
+
+	/*
+	 * Don't store trailing zeroes, except for the first byte, which we
+	 * need to avoid ENODATA errors in the merkle read path.
+	 */
+	p = buf + size - 1;
+	while (p >= (const char *)buf && *p == 0)
+		p--;
+	args.valuelen = max(1, p - (const char *)buf + 1);
 
 	xfs_fsverity_init_merkle_args(ip, &name, pos, &args);
 	return xfs_attr_set(&args, XFS_ATTRUPDATE_UPSERT, false);


