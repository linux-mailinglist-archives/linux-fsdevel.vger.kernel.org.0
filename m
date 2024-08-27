Return-Path: <linux-fsdevel+bounces-27374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB6960D96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD371C2244C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BAC1C1731;
	Tue, 27 Aug 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOLpxAPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD431C4EE4;
	Tue, 27 Aug 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769007; cv=none; b=nlrmVoJCkrIz1bWuc5P/xt3Z1vC2c/19yLN2yycqX2QUche5Kgg/xMDuoKBSnZURch4VFmgJN09RaqIqAU4nFyYGwJut37VhByKNOA3KrNYdXzpEyJGM3Y39rTZ9/kaXwUeBrxUdsN5KHqc6tgQ/g/Iil2oVNh3ervj7PZ6Bm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769007; c=relaxed/simple;
	bh=Bn7g3ZRhQUFtR+qoR+xAzgONWPtKnN7FsmMA0O7VGcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d59wg/4zsd+4aYSSI06spnPmh0jZPyC1aQd/Tm6He2mkrfhhN9hnnqo6bV1rgHBK2bUCt3Z5/XdxVPRdmRG9s6jaScuWQyzv6bLdviSWTKm06YJyOKwwJFXZ/MAazBa70yo+m+85SVkLKDMHeAMFkML6XGvLvhbvvWFg+iJ5cwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOLpxAPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E341BC61046;
	Tue, 27 Aug 2024 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724769006;
	bh=Bn7g3ZRhQUFtR+qoR+xAzgONWPtKnN7FsmMA0O7VGcU=;
	h=From:Date:Subject:To:Cc:From;
	b=FOLpxAPKLGUCrbmj8+XHiwyPDGwVP7ttIsoYaWdssmTWSEDi8+3UF6Iekq1KSoTI1
	 aBIq/tmUAoytfv90NakY9mXyZ81eHf+6bzHzYgI479qUapMZh/MnEX6WKcKGxcTroU
	 c/D49VGP8QJOsrZ5M/NqqYA0SWrNzAPSZfEe9jSkOjsjMftJITBP1HVuqkoa0+PVws
	 IrxihXgM6Cr56FmaaZ+Eeu/sisSX9xnSjHJv35uZJk1Z9CMMHrI8T5zGjsD5p7MltJ
	 wq+uSjccc/Vcmw2EVVf/9vTvxEUFL7EDlgUsa3xBM7dK+uwe0iH039b6hM72d7UrZi
	 KLhaszlre/5lw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 27 Aug 2024 10:29:57 -0400
Subject: [PATCH RFC] fs: don't force i_version increment when timestamps
 change
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-iversion-v1-1-b46a2b612400@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOTizWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNz3cyy1CKQIt3EtERT4zSDRANzgyQloPKCotS0zAqwUdFKQW7OSrG
 1tQAHLrOLXwAAAA==
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Bn7g3ZRhQUFtR+qoR+xAzgONWPtKnN7FsmMA0O7VGcU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzeLq1yb8mVRVxzFO9nV2yzyUermGn89aOvtnC
 u1keHKDzk6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZs3i6gAKCRAADmhBGVaC
 FZo1D/9CMCSGywH8YRz2f4QkoXLED5nZEsp4MV5QzfpztU7U8JvvCgGx39dVtPWc1fxXp7XtcTp
 hx5c3VaEoKkFQtKPDc+HsXp9+CwIay3jg8Q1JycBQi2Q9KkNku/Li1Ch1AsuOqTAu9ep2gAQoUc
 TUGZrgNXZ91tGmP3V+HkJ4u/Qk6QQzC8o4EBxnHFoO6Wcexbz80ry+prcgYEV1jxORoF4Wwiyan
 ajiwZSVemqdfRySpR/cXVkiyzG7NovlcgGcVYU8RBH2lJoC4l5cAq4AboPa9+wZvUkmiA9FnoVP
 9tlhhNMTl/xQ86/ymyfClg+vYw9ixaYooSi2ffw4Le/YhQ/0VeTvnWz1MQ3M3EmX/WLf9X/XUA/
 kKQDiflXjYBkCg20xGlqCs5RxJ/982JdtAlbVhJR+VCx94u6G/NKmo/fKg8zRuyWEOFMHjWZel8
 iFOdEY5+IXqc6Xr1tY62kKDRJYD86L/EeZnHlzQww5mtVc8HmltG4WDxA0BAjS1sCNqH7WnD+A2
 msPRX+eyri07eulYIHPglQ8Um5PpaoXmpBTDCKGFaaIIVAjvOte4d5oCDNAwqld7uGi+YRfz0/l
 v3f544OVAzSIl/mzCBbeFxp4aNaG7L2wlWYsqtZ6PFUjl9yKQQRqGGNlFDD7++aHdTct2UJxxA2
 3WEkkxawFCChSfg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

inode_maybe_inc_iversion will increment the i_version if it has been
queried. We can also set the "force" parameter to force an increment.
When we originally did this, the idea was to set it to force when we
were going to be otherwise updating the inode timestamps anyway --
purely a "might as well" measure.

When we used coarse-grained timestamps exclusively, this would give us
an extra cmpxchg operation roughly every jiffy when a file is under
heavy writes. With the advent of multigrain timestamps however, this can
fire more frequently.

There is no requirement to force an increment to the i_version just
because a timestamp changed, so stop doing it.

Cc: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I've not tested this other than for compilation, but it should be fine.
Mateusz, does this help your workload at all? There may be other places
where we can just set this to false (maybe even convert some of the
inode_inc_iversion() calls to this.
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 10c4619faeef..2abd6317839b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1962,7 +1962,7 @@ int inode_update_timestamps(struct inode *inode, int flags)
 			inode_set_mtime_to_ts(inode, now);
 			updated |= S_MTIME;
 		}
-		if (IS_I_VERSION(inode) && inode_maybe_inc_iversion(inode, updated))
+		if (IS_I_VERSION(inode) && inode_maybe_inc_iversion(inode, false))
 			updated |= S_VERSION;
 	} else {
 		now = current_time(inode);

---
base-commit: 3e9bff3bbe1355805de919f688bef4baefbfd436
change-id: 20240827-iversion-afa53f0a070b

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


