Return-Path: <linux-fsdevel+bounces-68335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC5BC58FFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8683E4A071B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD8536A036;
	Thu, 13 Nov 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgC3fE8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959C36A00D;
	Thu, 13 Nov 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051927; cv=none; b=POSnFparI1mLNCjisjF5WYkbrMtK8cCxjB6K4KBxLcam/eTWsCZrNC43T3nl9v+jnK91byk3JdNuklSbsS9WI0dGgo/GkNXerZPJBgNBuTvmg4lgSuxOkRfvG2Fkoa31ijl298mbwgXNhNluvXtJWhXH/YP2kec67P529MCgUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051927; c=relaxed/simple;
	bh=hJii1S5TPrgsZOcgVV0ADZVBuDyGKXP9zHQY6mXDctw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDMw7qE6FbFUb0R5y9JVMMBfz8XBb82jdfI2+eO1kWmBwuvEzM/eycnDtKmMe28HcvkBKZ8Iwii4XInaoAt4ZbcKRSSGV4bvs6kY69d3TrliMi7lbDkjArKYkGBYrE7YR2LN7mU7uZJGti7DpqrNCG8mevHs5w4+b2rd/DOMcUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgC3fE8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24FEC4CEF1;
	Thu, 13 Nov 2025 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051927;
	bh=hJii1S5TPrgsZOcgVV0ADZVBuDyGKXP9zHQY6mXDctw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fgC3fE8ekAGH44qW3L0tVOYLSXROaWXGK+albypMjnDU/oXOn43/4bSV/BPCWIyfZ
	 10kcskrsbk6GS9wGAIvVQq1Ni1s8mB8ek45lOfRwrgM82bCbkDRo3GtEB0Rv2vpyf7
	 PcmK1LnElOEK0VZqZPnXtowaD4sh4ACv5Nagx7ET8Qm0ARHfWMvCzRufE5dbcyknAB
	 0+vh7QNjWpZF5xqOBCLBxaQbcVWys0buaUMLJWnY5IvjexyNVaI5VAK2TL/5AJxJ2c
	 QyL9D5Uxx1XKh+ruAFizUcjcQhDjt6t515c1U3SujQjH1MioL1sWyyhxvIMtYifJN4
	 jGfVKDv65dzWw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:47 +0100
Subject: [PATCH v2 42/42] ovl: detect double credential overrides
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-42-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=828; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hJii1S5TPrgsZOcgVV0ADZVBuDyGKXP9zHQY6mXDctw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcXoUdCzs01uYFPrXLZUxXU1OKlbPb94euY+x0xZay
 8snV2V0lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATOR0OsP/cBGfzhXGVzWMzK5N
 aotmPHOjXmptY0XJVsbN9xbW7bb4ychw66fSwaB5h/f/WZZ7eZ+7Dcfu+ItzW602lhiuVUlKPSL
 LAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Overlayfs always allocates a private copy for ofs->creator_creds.
So there is never going to be a task that uses ofs->creator_creds.
This means we can use an vfs debug assert to detect accidental
double credential overrides.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index dc521f53d7a3..f41b9d825a0f 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -66,6 +66,8 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 {
 	struct ovl_fs *ofs = OVL_FS(sb);
 
+	/* Detect callchains where we override credentials multiple times. */
+	VFS_WARN_ON_ONCE(current->cred == ofs->creator_cred);
 	return override_creds(ofs->creator_cred);
 }
 

-- 
2.47.3


