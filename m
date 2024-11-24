Return-Path: <linux-fsdevel+bounces-35691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC39D749D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 16:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E3BB44D08
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D220B81F;
	Sun, 24 Nov 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVdTktDF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A320B80D;
	Sun, 24 Nov 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455889; cv=none; b=Gaq0aXTxoKf/OOXmGPeh2raQZgiufK40Q8cILRrpYgwdQODi+T07s1xlNbR9GlrN1uXFGECL1ljgbKtK+UO9mX0tiE9KVWdxO8HjsX0LSvP9rquLPRiREOqLO69AKBeuZgbGZgP3C4k0ucioGqBkafEiopxW2qm1YtmeO3XlQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455889; c=relaxed/simple;
	bh=cGAtL0IdSL5OIXyZPY4NHjrBposxrRNGFqPn12ctCts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nr5vRb94h5RdpCIDtEoglhx1dOFNnImxJqYDKYCO28/FeJ2TabavKLgqOChWjLMvShzbp5xs8Z4TrkIUzFucIgBoSMDTiFwF/9l8sIp96PcCw+sGJ4IM5a1XRLX/67ZmUQO6IAQfRH/9b8A2h7JHtN+t8/QYyGwUBmD4LapRx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVdTktDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A46C4CECC;
	Sun, 24 Nov 2024 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455889;
	bh=cGAtL0IdSL5OIXyZPY4NHjrBposxrRNGFqPn12ctCts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVdTktDF9OqnxXZHPQYIyy17fiN3Ey2QZVHkTtBZWX8bOjiVkjJEdPOuE0VUrdQAJ
	 bvaiGs0dVP6PI9ONX9+Y1NbRT3gSPLPd2G3U2n2UJUx55QNSh16TeFZUN5P2OnGwHQ
	 dtWA4PpzxtINxuSpwHzbDYdg+TqF0KnYwYTVW5qk3qYNhpBuxOXSrDfmzVZMe0/CDd
	 dpsoJOul4Ozs2aQG03Prc8Qo1mjXxHKo5SEXFKg4VixgZiHODJm7t+zwU0So+Dl1fe
	 9kKDKqrU8BXsa037EH45jJKt+iA4N3MLiiixHoetXooSZxcdB0XiDjKZgucemcA+S8
	 Vz8rso9SHXZLw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/26] nfsfh: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:44:02 +0100
Message-ID: <20241124-work-cred-v1-16-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=774; i=brauner@kernel.org; h=from:subject:message-id; bh=cGAtL0IdSL5OIXyZPY4NHjrBposxrRNGFqPn12ctCts=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7687TVVTdMmcbg8luu3aZotjva9559jxiXDltdWzaA T71z/rbOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayaz/Dbxbd0jctr3fz2Xgt kXPwEM9ssyvisPe6mLyFIdw86dlkFkaGL28WKUp4LVvSX1A/vVJoY89LrSwhcZEYpwPJNxZdvLG KFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfsd/nfsfh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 60b0275d5529d49ac87e8b89e4eb650ecd624f71..ef925d96078397a5bc0d0842dbafa44a5a49f358 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -221,8 +221,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 		new->cap_effective =
 			cap_raise_nfsd_set(new->cap_effective,
 					   new->cap_permitted);
-		put_cred(override_creds(get_new_cred(new)));
-		put_cred(new);
+		put_cred(override_creds(new));
 	} else {
 		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 		if (error)

-- 
2.45.2


