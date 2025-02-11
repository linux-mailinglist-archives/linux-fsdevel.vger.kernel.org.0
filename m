Return-Path: <linux-fsdevel+bounces-41500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8126DA300FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 02:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D13F164458
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 01:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFEA1E9B1A;
	Tue, 11 Feb 2025 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9N0RKxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A026A19F;
	Tue, 11 Feb 2025 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237585; cv=none; b=MTAAm2zWCBkPoNE2BScPVVMi1ELvtmkndIBT/xx6uD7qLi+L9celQ666BjDrFzwQhhy1BdKvOTvqydasOHk6fyVa82aMvo2cGTJlggCe3KfC9d9up/d4AwuWKk3PEe5AbUzvq+CJAqc0FdieqVwspfFcKeVNMOIUnRu3xrEnOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237585; c=relaxed/simple;
	bh=fxG5dlCvkHMfVSFY/V4lmA0UjLabxaSyXibSTQm4Zco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vur2b3a7Vrz90fnHOEqBJKQPnenYrzpC0ZXXfm7zEjyvXT7gMhsH3fYYpf8mVaDv2qSx0HwYiAUHbrfBSEtcN++5INzfBUfxmi9GxzCZ99J4SR/X2Jn0A3uWmaHqRTyp0KbJmEKRVxSEGb1EtTShoG6ykaBNYcFDmQd6SKWn9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9N0RKxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE7BC4CEE7;
	Tue, 11 Feb 2025 01:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237584;
	bh=fxG5dlCvkHMfVSFY/V4lmA0UjLabxaSyXibSTQm4Zco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9N0RKxYQjiPDdHxQqtqxbV3JwndNXoux+1psilNLw5ZTsA43OxJwx35FklCuTdgl
	 PPg7Y0b4SiJJYLRjh24aJkpkSTAASW2n7ALIlGAORl3oXttYO/TiKrgcC8raazhEK9
	 WAGnmU4e5pSNj3DvalzBDZFj7V4PJrnKHJiqGBn0FP/BidQNabDi53vEIA8uiDBj21
	 IXHsEX313ZW95emcl5t85rAjoBcAHlrKkBXKU3ddzRbziFXQN/wjxl+ahl63j7aBaE
	 hzo8+iQ5fGk1uGrqKfAsvOY6gEXmlgPHtN5Bt376UiNpnUm9rxkLm28Li6Wa/ZIv1o
	 EZoHHR1sri+bw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 8/8] vboxsf: fix building with GCC 15
Date: Mon, 10 Feb 2025 20:32:48 -0500
Message-Id: <20250211013248.4098848-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013248.4098848-1-sashal@kernel.org>
References: <20250211013248.4098848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Brahmajit Das <brahmajit.xyz@gmail.com>

[ Upstream commit 4e7487245abcbc5a1a1aea54e4d3b33c53804bda ]

Building with GCC 15 results in build error
fs/vboxsf/super.c:24:54: error: initializer-string for array of ‘unsigned char’ is too long [-Werror=unterminated-string-initialization]
   24 | static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
      |                                                      ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Due to GCC having enabled -Werror=unterminated-string-initialization[0]
by default. Separately initializing each array element of
VBSF_MOUNT_SIGNATURE to ensure NUL termination, thus satisfying GCC 15
and fixing the build error.

[0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-unterminated-string-initialization

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
Link: https://lore.kernel.org/r/20250121162648.1408743-1-brahmajit.xyz@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/vboxsf/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index f11bcbac77278..4a77a5a3109ee 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -21,7 +21,8 @@
 
 #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
 
-static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
+static const unsigned char VBSF_MOUNT_SIGNATURE[4] = { '\000', '\377', '\376',
+						       '\375' };
 
 static int follow_symlinks;
 module_param(follow_symlinks, int, 0444);
-- 
2.39.5


