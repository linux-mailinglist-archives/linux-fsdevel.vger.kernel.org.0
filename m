Return-Path: <linux-fsdevel+bounces-35690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6C19D72DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208B9287B8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC21620B212;
	Sun, 24 Nov 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHW14Kci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E66420B201;
	Sun, 24 Nov 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455887; cv=none; b=k9RBYK002pIN+3dsNkrMtYS8ZHgnO3+5/Oy311LriguRDK+SUMlSH6ji12ElPWYGMLmXmQSHXvNozTnC9Jm0dk5VYsVTntd5FZDPJirq6lbDZffGJOKplw5zWZ0qj8nc683JTnIVg1mbWdGe5IeBsHdf89VgejgywC3CAQX4qZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455887; c=relaxed/simple;
	bh=lB66TPcFOcydsf/s9WmTXYzL0+fjEt3pLA7eh38aVwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gylhprgWm/o7hwAlLlqsI13QvsYiWeaDRVMjJ+mOr8ri2OskaZn4CWmji07RsYKd13u8o3cqBvD7Vx1D4/a86swK238XFW4aT9C+sXoLVJFODBx+4u7OksQNJ1KXa7RM+lN/E6xBIMh5OXMN8QbZ79LHfTe+qjnYgggq7k2Hv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHW14Kci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC17C4CED9;
	Sun, 24 Nov 2024 13:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455887;
	bh=lB66TPcFOcydsf/s9WmTXYzL0+fjEt3pLA7eh38aVwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHW14KciLv/z7pM2IMFSaT0uLfQVVVS9jFRay4AEmMECA+sLMT0xyM4bS8fildSHK
	 scNUdhpvvx5qAwoc1Cgc/X3woxG14kX0LyQ83PC65NRZTmuvSa/m/2jPG/TgttljRY
	 uHC/dMjCznhWqjmQ+hw5zaYu4PeWXCZe0TtPPZrH9mmR3vHqzX+deVGp/McqNh0YgS
	 jiW2U70IV5nOmzDGlll1sLL+Kme/mkubqbjyU2lv+y6y8rjMWsQ24G07DwPD0ROfiT
	 9/YFBZ1jCEIEtjVl8nMDPUIvRxsSceDtKB0XvmTss06GU6F+vqOl51ZhJZSdWS/ecb
	 d/6V7vFQQVXEA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/26] nfs/nfs4recover: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:44:01 +0100
Message-ID: <20241124-work-cred-v1-15-f352241c3970@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=696; i=brauner@kernel.org; h=from:subject:message-id; bh=lB66TPcFOcydsf/s9WmTXYzL0+fjEt3pLA7eh38aVwY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7684rbXSM3X+/88rlEpaM9znaGZIdCZZbOT5c+m2nK x3w8+vajlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn48TIyrDh0nc1fZcG1XW0R dz4oeh4oe1JXpXZWoaFL1zhU3dwmkJHhi/P1X2vdHiafWv5oLaPXimvOG0uLLfT+dKzkMFoWL7i EEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfsd/nfs4recover.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 2834091cc988b1403aa2908f69e336f2fe4e0922..5b1d36b26f93450bb14d1d922feeeb6c35399fd5 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -81,8 +81,7 @@ nfs4_save_creds(const struct cred **original_creds)
 
 	new->fsuid = GLOBAL_ROOT_UID;
 	new->fsgid = GLOBAL_ROOT_GID;
-	*original_creds = override_creds(get_new_cred(new));
-	put_cred(new);
+	*original_creds = override_creds(new);
 	return 0;
 }
 

-- 
2.45.2


