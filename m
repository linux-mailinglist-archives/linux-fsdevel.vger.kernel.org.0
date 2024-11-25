Return-Path: <linux-fsdevel+bounces-35806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931759D877D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F329168A42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807B21B81B2;
	Mon, 25 Nov 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncUJI9b0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E61B6D02;
	Mon, 25 Nov 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543842; cv=none; b=aYXit5ReMy6WZGjRcFaSDloJVSmS0dM5GuTm++kfSqrkQru8/NuRJeP3S07JfWsV+8QPDDgKL9+P52+L/DrAaKgpmrfx5TE71fw1GRbHDfeGUndGVFQUvTiDDebGyYAsVueQD5Y1rnVDDO8Vsjg89Hk+IR2ZbS2ZgF7HaCIcLeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543842; c=relaxed/simple;
	bh=DitPWXlJL7W9zAvssowYYvwe4Rxzt3oAYriF89UVjcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBUx1zzDJ49M1DKrvTHS9xguBvktj0IE9yYJGK3za5j/6ddLvurzznbHHGPpOKdIl3HEuQfQgM4bHUkb2jHeKYIZTr3nOeoxQSMAvsIMXX6zPoWGHk3WHmi/zTOE7AHRkxRY6u7bV7ph65A4iZxdQvoAbOghlv/R92NHGvpTTUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncUJI9b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97D8C4CECE;
	Mon, 25 Nov 2024 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543841;
	bh=DitPWXlJL7W9zAvssowYYvwe4Rxzt3oAYriF89UVjcw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ncUJI9b0dpl7BGqsLzUwH5bN7eUGuh2lp+c2J5EfdKmbpW2DlQugWlOqFLDpNBXnR
	 yKL5oYH5GsRDKkc3CZ2M+hNjqRrFijL5NF5rtrFmqdcGB0FQM3rk2zt/dMKR+CBjOD
	 qQUTj23FEJTI6E3evF0lLXIWQxGOswKvlK8tanov+RaZ3b1E1Ra5zUHl9tmj/Uq80n
	 KfLwkBkOX4jHccf8KmG6x/Mt9CN47fk0A08LUli97QEVufnjMYfZroQhJUEZfwoqXd
	 Q+WfGE6fDwjbZCHzSJunUu+xn3HCJUHmIS8sEgN62Saj83OmPzuMHZiVFiOvuChJb3
	 Y/nYK3mkHdfpw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:05 +0100
Subject: [PATCH v2 09/29] target_core_configfs: avoid pointless cred
 reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-9-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DitPWXlJL7W9zAvssowYYvwe4Rxzt3oAYriF89UVjcw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHpWtf5/KzVrTbpuHavC6kV73tVGNWRIW2z11tv3N
 16Pt+VARykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQW6TEy3F+dLn84eCtz/oNC
 sYl8fZ57mF8f7pRfIMrAspap3e/4W4b/xW1OD/ib3BTubpsYwVLzpLrCxf+bvelq08j+kwobtvj
 yAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The creds are allocated via prepare_kernel_cred() which has already
taken a reference.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/target/target_core_configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index ec7a5598719397da5cadfed12a05ca8eb81e46a9..c40217f44b1bc53d149e8d5ea12c0e5297373800 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3756,9 +3756,9 @@ static int __init target_core_init_configfs(void)
 		ret = -ENOMEM;
 		goto out;
 	}
-	old_cred = override_creds(get_new_cred(kern_cred));
+	old_cred = override_creds(kern_cred);
 	target_init_dbroot();
-	put_cred(revert_creds(old_cred));
+	revert_creds(old_cred);
 	put_cred(kern_cred);
 
 	return 0;

-- 
2.45.2


