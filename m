Return-Path: <linux-fsdevel+bounces-73341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A1D16065
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B36A3015ADA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37CF279795;
	Tue, 13 Jan 2026 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMShLpJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C079278161;
	Tue, 13 Jan 2026 00:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264333; cv=none; b=X0Fi3xorHkgIYfZZzJsyIAaMBMnSfsuqL1TqCQ5HKpUHF1Xaug0Qs4PgPuESCAkDSvjfKCpgrO7p+OeUmLAtAZ2/veFdqs4OJe33IrSPnebYYi1jpEIPuANHu4c549NjMWivXULi9Cq4NP4Kw1ojyp/CYQ659cg+fTBmJokjS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264333; c=relaxed/simple;
	bh=ASGRq2uOi7VLB8DFhTSIvJcQ2RAyDeg+vzHvuYF8HDY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKSfDtP9tw5TyQYKF5nfMVM9I+vJVbVZbTVjLwAQiqZcBDphkGpyfwA94mk7LocdXnn6hFNYcxS1gAxq2OR8rAP1G/voUrquLofXeHxo2fzJbPrDvqJKQ5uLh8QXLFU504BDKQEVQtrprAgdBrxsTcUec1uJnTwSOrR33uI+VYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMShLpJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B749FC116D0;
	Tue, 13 Jan 2026 00:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768264332;
	bh=ASGRq2uOi7VLB8DFhTSIvJcQ2RAyDeg+vzHvuYF8HDY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nMShLpJHMZhVpTpcy2IzrnYuQSNHkXS8dmm57KMEW+IgNcO6E5y/IsLGQAaWCmft5
	 wefwURxCDb1PxtHFhYOksa04dBXwWL3bxP77pQtcnCgk3sBzv5mxPJ/CPZKHPjk9em
	 9kDQ4Blh8C/PpwdSsVKepf0POaQWBdJIzrcNciKnKtuMWXeRmAqpY6GUaP5rjrQxJl
	 0C9vTM5iLlCG/NN9R8oe/eT2qzDNqfnoc8qMtFWXnWf0I2L93Zah01xehx73EbvgnM
	 O1oP7yqG0VjFZykO9KhZmVveKNguJCiIhCUfAsN9dcKA1dXWhopVD9U2gkmszznXF6
	 pZvZM7fclwYKA==
Date: Mon, 12 Jan 2026 16:32:12 -0800
Subject: [PATCH 5/6] xfs: translate fsdax media errors into file "data lost"
 errors when convenient
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, brauner@kernel.org
Cc: hch@lst.de, linux-xfs@vger.kernel.org, jack@suse.cz,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gabriel@krisman.be, hch@lst.de, amir73il@gmail.com
Message-ID: <176826402673.3490369.1672039530408369208.stgit@frogsfrogsfrogs>
In-Reply-To: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
References: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Translate fsdax persistent failure notifications into file data loss
events when it's convenient, aka when the inode is already incore.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_notify_failure.c |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index b1767288994206..6d5002413c2cb4 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
+#include <linux/fserror.h>
 
 struct xfs_failure_info {
 	xfs_agblock_t		startblock;
@@ -116,6 +117,9 @@ xfs_dax_failure_fn(
 		invalidate_inode_pages2_range(mapping, pgoff,
 					      pgoff + pgcnt - 1);
 
+	fserror_report_data_lost(VFS_I(ip), (u64)pgoff << PAGE_SHIFT,
+			(u64)pgcnt << PAGE_SHIFT, GFP_NOFS);
+
 	xfs_irele(ip);
 	return error;
 }


