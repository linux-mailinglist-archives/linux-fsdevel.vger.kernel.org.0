Return-Path: <linux-fsdevel+bounces-35686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88289D7666
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E4EBC4CC8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DA220A5C8;
	Sun, 24 Nov 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2ZbJEC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA5209F56;
	Sun, 24 Nov 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455879; cv=none; b=QBNG3w5en7MLbfE/jyFzpxG8QiTrFDrxCPTH5a/9S06Ry4tBECcdGk5dVeEHB1YkIQWyl/rD+0nE4gs3DhKN9PTl7GJaWr+KTW98cqWp9WlGRJTDr0tW0TartRgTcQQq0sfMBBchzZNtT9FeM/4wXSyS3OQ+LTix9BAid/fahFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455879; c=relaxed/simple;
	bh=kuDO6c0Xi1i8u6b8BmRNFBm4DAnCEEtoeHcGrcaxLc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQijvDCioZSIJNti47Yo1s7VrHs7masyGyohrNjSRaySr3HZd4eBRGSSBPYb+4tF+FYFr3WVWJeStAFTkt+Hv1vk3pbWblZ8wyF/qm7XlqGNrEB0RP2DtDh0ZoWOD4BYsgBxNa/V3ib3IHyEP/qUvD+MHZP5iJBWhUqHXsaMPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2ZbJEC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648CBC4CECC;
	Sun, 24 Nov 2024 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455879;
	bh=kuDO6c0Xi1i8u6b8BmRNFBm4DAnCEEtoeHcGrcaxLc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2ZbJEC0hx+o5NKocINkLGcrMqeNjFa3SGg1WemZUOUuyVXBtk8X6wLK1TeCh77WG
	 PlJ8NaTDu98kUH5/8/riCuACP6GDZrzGn8ksOznbrDTWeDbZlIzdgbf/t2Tb1v3TeX
	 xnnUS7fAYJXyppLcu5+vARKK4rkLU5y+do4hh+4K451MN+E8DY91PXcCTkLXH7/rcP
	 TIz/J5eaIQ98hyHbPJyGfOSgQX7nIKWzKQPsrQ3sJVpFRCIw1Cqvq5gXZ9kHr2SkJr
	 OQZUrGRzuAV/K0BH4bA3DVh6nevZPgM3d+V2CE0XXKsTXwno41pS0SBvrUc3OIZbz6
	 H3fplp5DD5KlA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/26] binfmt_misc: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:43:57 +0100
Message-ID: <20241124-work-cred-v1-11-f352241c3970@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; i=brauner@kernel.org; h=from:subject:message-id; bh=kuDO6c0Xi1i8u6b8BmRNFBm4DAnCEEtoeHcGrcaxLc8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ768758Trlwrsrn20uTEk/Pi971rHzc+buVQx7ULdu9 Vr1GyeSd3eUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBM5OphRobpizfu6ra4dS3t eG5uFfMy9Tv7n3gJd/pzx+dY79n4UHYNI8PqJOFlVvPuanlZtvzav7G6v+6YSmJPxnGBFeslwnh TG3gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/binfmt_misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 5692c512b740bb8f11d5da89a2e5f388aafebc13..31660d8cc2c610bd42f00f1de7ed6c39618cc5db 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -826,9 +826,9 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		 * didn't matter much as only a privileged process could open
 		 * the register file.
 		 */
-		old_cred = override_creds(get_new_cred(file->f_cred));
+		old_cred = override_creds(file->f_cred);
 		f = open_exec(e->interpreter);
-		put_cred(revert_creds(old_cred));
+		revert_creds(old_cred);
 		if (IS_ERR(f)) {
 			pr_notice("register: failed to install interpreter file %s\n",
 				 e->interpreter);

-- 
2.45.2


