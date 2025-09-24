Return-Path: <linux-fsdevel+bounces-62564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0058CB999AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676031882285
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555192FE066;
	Wed, 24 Sep 2025 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfSAtdvY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669C2820C6;
	Wed, 24 Sep 2025 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713664; cv=none; b=isHgtpXgWR8CTTzrtamNRNxtQTPYbBBs8tzYulP7+6RGmsj1Zku6Je73LKccaJPgWKP7Do7dAQagnOJGNU4YU0/+nzuKR9Pnq+mDeDvCdo5hsLCbcMJGaEb/VNTfmvgZzt8EQUT2g9sFimyBMn3xtVyTLRdQy2f6RfuWeHYoEKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713664; c=relaxed/simple;
	bh=u1TsWjKE7Ua/L0rDra9O3/zBiAiACDitU2HIeL7ATjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jiGtADzZZVOCa7xb9d54bzFGPmRZ5GPvEiJ1nAf60XTam1F8ocYBQpu+JUAIUvWk3xT97Kdp1+nJNh5T4Uuk6gaqX37rOUNu/FF5WzI2nbpMmkTaU6OEW8GjK0CQM155KrTrfYLqHblqvdHe1HJd3pfYHKo5iqzQPamNSxCZ4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfSAtdvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9370CC2BC9E;
	Wed, 24 Sep 2025 11:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758713664;
	bh=u1TsWjKE7Ua/L0rDra9O3/zBiAiACDitU2HIeL7ATjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TfSAtdvYtGKNMMA0YckaxOwCePQgb5RSRQZuTFwWZPRt5lMOugZJZDiv6cWZ0QIHC
	 RkN5aaytw/6qPRCPPt6te/62FXCgrwJ453Wy4sTDidq7RyfIHKtgpsQqscXnRTtJZj
	 H41eYFMpGVFncWcJjWNcboj2olp+AUYyhRw7vN52o0+jL5DBRgrhgMCXlH3qUVFkdw
	 8SE+x7iLsLSAym0griMpxITSTRcyDF0GblY5bY/Nar4M4B1aVG9F15XdL41CVjiIK3
	 NfAhDGCnHftS0LAcYQmIcJTQwjgJ9rzxOAnTVCKiTdgGYrO/ku9n10eI9T9Z8YokWh
	 ivUqeBNcCjfgw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 24 Sep 2025 13:34:00 +0200
Subject: [PATCH 3/3] ns: drop assert
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-work-namespaces-fixes-v1-3-8fb682c8678e@kernel.org>
References: <20250924-work-namespaces-fixes-v1-0-8fb682c8678e@kernel.org>
In-Reply-To: <20250924-work-namespaces-fixes-v1-0-8fb682c8678e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=615; i=brauner@kernel.org;
 h=from:subject:message-id; bh=u1TsWjKE7Ua/L0rDra9O3/zBiAiACDitU2HIeL7ATjI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcvq7v8KO2rlPyzbL6c18CY5MMDuyLOT/fO1xFtWFvb
 OrjjxXxHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5VMrwP8hr1v5PBeuff7SM
 S9mdqfr5+17Z94Eqkik7/I7svGXQzcLw3/XImlbD/cWqU4LVubW2nrCqmPdVJ+teG4vi07pFmtN
 teQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Otherwise we warn when e.g., no namespaces are configured but the
initial namespace for is still around.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/nscommon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 92c9df1e8774..c1fb2bad6d72 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -46,8 +46,6 @@ static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
 		VFS_WARN_ON_ONCE(ops != &utsns_operations);
 		break;
 #endif
-	default:
-		VFS_WARN_ON_ONCE(true);
 	}
 }
 #endif

-- 
2.47.3


