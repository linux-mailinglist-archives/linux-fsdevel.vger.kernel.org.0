Return-Path: <linux-fsdevel+bounces-61905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83F1B7F8B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C206A327988
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7DC368087;
	Wed, 17 Sep 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyzXfDbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AD32D5D3;
	Wed, 17 Sep 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104940; cv=none; b=QX/hn10n7Wpu3wl9lhtbAM8rnHSI7P1+l2+MkPw+j7FocHSucW6KuB1uPiW7sCvi5hATKxmROXPPhLcwZd+0yi6wzO+rAt275XGKWjmBbVBPR3EIloboKo/goIUDVW4TV3KbEVEdv23h/WKc+1WDtSuMfrQrRwz4VlJItkvHLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104940; c=relaxed/simple;
	bh=6GX+edfqAtvCu/yle/NskZ5IXtOjExmscE2dvb5jQ6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/peenwdxtkyTA8wPKrU00r2gNrrobKoa7ov3eS6F9rZwogwXDOE6qsBK+EgXu3LnYZA4drJHkFYoVXdhDqs4JS76u5GQmAJ6KOERWnHnbglbbilwt45L5Rd4SdeKkuwSxB4tU6JmET/FTrG06m2r6ZsWW8jgSxMTalHb9Bbts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyzXfDbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E6EC4CEF5;
	Wed, 17 Sep 2025 10:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104939;
	bh=6GX+edfqAtvCu/yle/NskZ5IXtOjExmscE2dvb5jQ6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OyzXfDbimMLy0Fx6M58fD+mofgMhOwDSKHAjSn2Q8XEqZHN5uehbaG7Oxt7hco8dX
	 S/Yc6LyoBOqiKFLjtWmPdkRf0jEBbV31vpcxLHIChjd4ZIyFe6KSJqw8xrm7tp61EP
	 9ESUpyC6cjj7RjwIME8gUaS3mFolg1WPBcYNGxk6TWueEv4UycIDrzYXbP1t5UruA+
	 bUNfD+9OasjHXjGm044YKg8+t8CubPsrsP6H8uFMDH9C+nGhKdJA3Xh0y9fyYdjCl3
	 iqi9Xub1hGIhpnWhZjvCwRCBcTIMCBNup6lIW4KKLVZg1ZZV2wcPluUsq+sw2aa42R
	 QXKUH22emII/w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Sep 2025 12:28:04 +0200
Subject: [PATCH 5/9] nsfs: add inode number for anon namespace
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-work-namespace-ns_common-v1-5-1b3bda8ef8f2@kernel.org>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
In-Reply-To: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=610; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6GX+edfqAtvCu/yle/NskZ5IXtOjExmscE2dvb5jQ6M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc6vXbcW4j+6HSZy4aqupNiQ7HlKKdM7huMdxWmvLxi
 OCqJw35HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5c4jhf7ho4xn59Gfsq/Vk
 juzJilotpCe+a+7jhl1H+aMn5E96Zsbwz8gwuE21Pzfx/GSba0bO+TZ/Wplm+p/mv8RqYfHmqbk
 mGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add an inode number anonymous namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/nsfs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index 5d5bf22464c9..e098759ec917 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -53,6 +53,9 @@ enum init_ns_ino {
 	TIME_NS_INIT_INO	= 0xEFFFFFFAU,
 	NET_NS_INIT_INO		= 0xEFFFFFF9U,
 	MNT_NS_INIT_INO		= 0xEFFFFFF8U,
+#ifdef __KERNEL__
+	MNT_NS_ANON_INO		= 0xEFFFFFF7U,
+#endif
 };
 
 struct nsfs_file_handle {

-- 
2.47.3


