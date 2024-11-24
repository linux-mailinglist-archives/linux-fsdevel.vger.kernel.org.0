Return-Path: <linux-fsdevel+bounces-35696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0779D72F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4168516530C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182620D504;
	Sun, 24 Nov 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiwsEVwl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1920D4E8;
	Sun, 24 Nov 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455899; cv=none; b=ns3qkF9OAdMPgoOX9Lwx9TnMF840sL+8Cag0DI8GjXflT5h2/UNE90a5z4z3ZZNt9ALagG2TbOLcfHvnLc1XSYJJfqQ0tdr8wp1PWPcEX0f2qLLpINopOlmt1BeMk1b0PfAj8fmElsxo3k3v+WMuBmD2TPfXjN4MMK559Qq311E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455899; c=relaxed/simple;
	bh=7+BonKFNZvP5fMRV20M9AzuaXHt6M1zBtDLiQy7THD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+314C0aaVYfMMlfsoSUNL1UpuU6L9HMVhjVAXrHulet6ujOqq+xW5tWpdiCbNB5QdiK6i7mmhxwv2mmCVJxTeFdh1NMwej5dN62OYclebCwoJ5f3RQCD86T453734ReqjYXee63jnufkWnAgc3yYsoyoKCcz/kDjCYQyBBWWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiwsEVwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DBDC4CED7;
	Sun, 24 Nov 2024 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455899;
	bh=7+BonKFNZvP5fMRV20M9AzuaXHt6M1zBtDLiQy7THD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PiwsEVwlXO8IWaBuPVVj9VVJOHRq878Y25IGeV+HF5r4OlqZfQwIlv/55lEsl/c2R
	 C+XcgL5j0X5657+IjRObCYfYy7fAK0LpO00wwbg3xHXVJztV2TIhKT1L7PSk28fnxM
	 w0NhkA7HA083N7ZeSsk+/i8u3k50lECzDb+HcahHCl8w+TE9ZJh8Rn3XkGT1QDS0kA
	 dPpDCP8QOjlohO5Npxu8gR5ekVmGtvaxIrzsrbc52wHjvVJI8b11jDeSHsjaWhDHqx
	 Cmt4hGcIuMNmmU4Nj3wFKQk4IfettGXYoxtzrKrsSSDvbdiM/6fx0k3OiuWxiGekHh
	 zvxA4TGEWjFLw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 21/26] smb: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:44:07 +0100
Message-ID: <20241124-work-cred-v1-21-f352241c3970@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=brauner@kernel.org; h=from:subject:message-id; bh=7+BonKFNZvP5fMRV20M9AzuaXHt6M1zBtDLiQy7THD4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ76y7U9P7zZElXvKkin52Iy9w2/+9ZZubeRvc4zwjMe OrPsfdMRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETeTmRkaNrkxjw1cU4uc8jC m7k8gp8KLArX3l546XJV/fuEgBbhCIb/USuF90pnNxWe9LOqv8dze0U4l/DTnCsf/boU5aI8Q77 zAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/server/smb_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index f1d770a214c8b2c7d7dd4083ef57c7130bbce52c..a3f96804f84f03c22376769dffdf60cd66f5e3d2 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -780,7 +780,7 @@ int __ksmbd_override_fsids(struct ksmbd_work *work,
 		cred->cap_effective = cap_drop_fs_set(cred->cap_effective);
 
 	WARN_ON(work->saved_cred);
-	work->saved_cred = override_creds(get_new_cred(cred));
+	work->saved_cred = override_creds(cred);
 	if (!work->saved_cred) {
 		abort_creds(cred);
 		return -EINVAL;
@@ -799,9 +799,7 @@ void ksmbd_revert_fsids(struct ksmbd_work *work)
 
 	WARN_ON(!work->saved_cred);
 
-	cred = current_cred();
 	put_cred(revert_creds(work->saved_cred));
-	put_cred(cred);
 	work->saved_cred = NULL;
 }
 

-- 
2.45.2


