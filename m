Return-Path: <linux-fsdevel+bounces-62106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C399B84047
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FEB1C218B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7F4306B1B;
	Thu, 18 Sep 2025 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS7a3k9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82E2D1F7E;
	Thu, 18 Sep 2025 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190376; cv=none; b=deFzNvVX2Nm6Pssu74euqG++h3yXDzfoJPYyNgtRxSbVc/oR5tKPBRq4jePdhxJ6NOtz0w+y5RVHH7gFqtL5SdTFPl+lDCwMMAobXSq+S38VcA7gwlNw+0mSa3LpAStwBbakGRnSTuhnCLQnCiMp7aRZD3tk245G73NZbAaJlaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190376; c=relaxed/simple;
	bh=WYPZnqjxov5ySJTeGcj2T3GXXFm1K7BCUPGggxoHaCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9AEwCWk3T6ED0JiPOT76Chzwlw6bKrEEoNBigKNvvEWhv/zEW5TbNZ1rdTAVsOKa6VWBnnoRrexc1K+/BzqOLXeSfWTa3JL10mEZOiCjYCFzoY8d8t4wbXIsd0/WIWqYKTOAXAp4o5+rKAcHyQjK1U+EHtFwogjJFep3PV+Sjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS7a3k9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CCBC4CEE7;
	Thu, 18 Sep 2025 10:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190376;
	bh=WYPZnqjxov5ySJTeGcj2T3GXXFm1K7BCUPGggxoHaCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bS7a3k9icI9hiXKIodkziOGlDJ3kP3ucZvNXIqJwwJYs9b/Hm8xLLFYW/tJfzbQpu
	 5KRXlZjPRV5QCXZ3PIBqMZTU47aO7j1ynvmctbZxUIe0RpMpsHoL2lJ64OIqTAmx7T
	 gcH9NwNXC3GiJzChge0toV7KOlaGHQ6XASjbJAsXRrUWV4pQPaa7s0vSqinDqECRoE
	 ahdm+ayXXARlMK9++SEFCi2F2ZriELeN3s9RSYTTWyzhEJu0Xkg4NShHuhvY1SP8Np
	 R5akMEtxFWV3W9uiTsZJi5H1v1AKWOCL9e07tsYlkSnzEItQn4zBwup4Teo12v2CmU
	 94ePxuf87LG+w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:58 +0200
Subject: [PATCH 13/14] nsfs: port to ns_ref_*() helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-13-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
In-Reply-To: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=594; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WYPZnqjxov5ySJTeGcj2T3GXXFm1K7BCUPGggxoHaCA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvVs1v5NLKd5YsOuyrrOZPBhrXy66f22r5nysRLP8
 6c9yvr/tKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi/MkM//23Hct/krOXa+qP
 Db0BFW4aD46fYEpzKDmnLW5/84/Lo0kMfziM3hXtcxRer3b949PvpS+6m6rlvlcckrrosUWxUfr
 rLkYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stop accessing ns.count directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 8484bc4dd3de..dc0a4404b971 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -492,7 +492,7 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 		VFS_WARN_ON_ONCE(ns->ops->type != fid->ns_type);
 		VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
 
-		if (!refcount_inc_not_zero(&ns->count))
+		if (!__ns_ref_get(ns))
 			return NULL;
 	}
 

-- 
2.47.3


