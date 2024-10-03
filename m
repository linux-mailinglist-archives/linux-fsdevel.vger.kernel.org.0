Return-Path: <linux-fsdevel+bounces-30898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AF498F22F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 17:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A6D1C20E9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649B1A0719;
	Thu,  3 Oct 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooxUf5mT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11921823C3;
	Thu,  3 Oct 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968173; cv=none; b=XCaNvtfeOPxljzW7arp04PAemrw0MWxPIyFtR1Q23nw6l1LurixHZ3jJqlVuvvl8fKpTSnculNm9szdz5OOxdbWYsrqEiilymt9YL+b+tSRWtQ3B8/nMCtAj+eYdVCpA0sT+jD/FUKRQXReLG1/3dssKJ0b1AMACl+r7I9wmyIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968173; c=relaxed/simple;
	bh=aGck3uoHkepYDWrYE3ghqnF0P8QpTLJc960nV3wgOyw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIlxsJSpaSZ5uffANLH5zLpsx7iJcPubFq7xmkGzZ8x95nAuHO0sWfJ/9o+44y0b7ghoa4k3cx2W+HO3OJ31NyMRk8S1AZsA/DrEB+N9wFqe102EURbk7igVkvuD0umkhGWIobuC5QqGy3NvTgmTEchXxrFluVqXIgAyLaYDoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooxUf5mT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD5AC4CEC5;
	Thu,  3 Oct 2024 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727968172;
	bh=aGck3uoHkepYDWrYE3ghqnF0P8QpTLJc960nV3wgOyw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ooxUf5mTJGczGhrpitaWCOj1O1xgPJOvgVGdG/QSs8oXBfhxGZRqriPCpTXusE1qe
	 MsHvY/s+CV35ZCB0vavWzLgwsrbTwkDlmav9TLpzjg0ZJGHgyM/9mBoDMw2xdzxY3N
	 KLLZnvmWwvChsm/DcqoZ2zs8O6zPV3aspiEUvVPx82O0cQefgM6XGbx58QTlqiT2q+
	 +kyPqWnH3Q9vZtMyXyI+xps+i1oOgtnDQNRLMj/hbfrHrLqKZf+tklE/FpshWzvT2u
	 uCKNbwjCMtGvrh19bO4+e0cX2eyPsIjaoQdgmimwwl0O/K2KZogqDuM8yhP2qrWVmI
	 AjFgenXnOyJJw==
Date: Thu, 03 Oct 2024 08:09:32 -0700
Subject: [PATCH 3/4] fsdax: remove zeroing code from dax_unshare_iter
From: "Darrick J. Wong" <djwong@kernel.org>
To: willy@infradead.org, brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: ruansy.fnst@fujitsu.com, ruansy.fnst@fujitsu.com,
 linux-fsdevel@vger.kernel.org, hch@lst.de, linux-xfs@vger.kernel.org
Message-ID: <172796813311.1131942.16033376284752798632.stgit@frogsfrogsfrogs>
In-Reply-To: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
References: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
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

Remove the code in dax_unshare_iter that zeroes the destination memory
because it's not necessary.

If srcmap is unwritten, we don't have to do anything because that
unwritten extent came from the regular file mapping, and unwritten
extents cannot be shared.  The same applies to holes.

Furthermore, zeroing to unshare a mapping is just plain wrong because
unsharing means copy on write, and we should be copying data.

This is effectively a revert of commit 13dd4e04625f ("fsdax: unshare:
zero destination if srcmap is HOLE or UNWRITTEN")

Cc: ruansy.fnst@fujitsu.com
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c |    8 --------
 1 file changed, 8 deletions(-)


diff --git a/fs/dax.c b/fs/dax.c
index 5064eefb1c1e..9fbbdaa784b4 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1276,14 +1276,6 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 	if (ret < 0)
 		goto out_unlock;
 
-	/* zero the distance if srcmap is HOLE or UNWRITTEN */
-	if (srcmap->flags & IOMAP_F_SHARED || srcmap->type == IOMAP_UNWRITTEN) {
-		memset(daddr, 0, length);
-		dax_flush(iomap->dax_dev, daddr, length);
-		ret = length;
-		goto out_unlock;
-	}
-
 	ret = dax_iomap_direct_access(srcmap, pos, length, &saddr, NULL);
 	if (ret < 0)
 		goto out_unlock;


