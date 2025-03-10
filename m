Return-Path: <linux-fsdevel+bounces-43672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2621A5A724
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 23:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A781890FEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 22:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F442206B6;
	Mon, 10 Mar 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVgqByfm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490DE1F4C87;
	Mon, 10 Mar 2025 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645535; cv=none; b=mM0tc6K7wBCaOA3ZjBE7DPGiq8QxnRsyGxUicdjD8UsoKnxmLq1oGElIIP6c78dKITFR8vXp8OvQ+PGn7OaYBDOkGzNTzA0JcxWub3/x+PATp8af9ANT1E3KSxaw9ne0MNS33TiOivysIhM5NP2KZnPr72XM+SiBF2NoLnGXZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645535; c=relaxed/simple;
	bh=toNx9CLEtAH8f4PMhwMHxq60ik9H3b5D5G1iFVqwsCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OZPiY6uix4Ak/+EUgqm0/PZS7h9Y48FDuJPk/wGCLR/w4SXJNcW4YHAsthH6q7dss199XT2eWLrf5M44MYqfc45vffTS6NQdW8AAlh7+0hVAlVCyVc/hhtrOisI1xDoQ0qUrzdeoHgE9QkF6M0XYz0wIEcGuHD6MwHfMOCd1bdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVgqByfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9871C4CEE5;
	Mon, 10 Mar 2025 22:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645534;
	bh=toNx9CLEtAH8f4PMhwMHxq60ik9H3b5D5G1iFVqwsCQ=;
	h=From:To:Cc:Subject:Date:From;
	b=SVgqByfmQG5t3EUNHd5WH6CNPf7u12LskLfFkqpVHLK3J1KQVThp676+43DiMAKqx
	 yMGVx0+ZMY4rsovPju8TE3aLwr1d51ETXZOcxwh9aqNrzS02pav2B7/esbVQITHyeF
	 vLU/5WUMP5Jbfaf5geAQvA2HQ6YnxGQ4Fmv/Ft+NbScUjP8BX1GO33il0R0mKO5dtw
	 2dQ1i6bRqwfa9HG6//VCf3R86hJYklaX+W1OnBfy6jU8bvxtuIp9L6WNP1eQcF4AZO
	 8TNyPgjgxp2cYJ36T1x/l4ViYjtUpkzly7rUWpav1P5fk0RNbJNnEoWFaNKLPYXOqJ
	 cQCtZj8dN6p2Q==
From: Kees Cook <kees@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Brahmajit Das <brahmajit.xyz@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] vboxsf: Add __nonstring annotations for unterminated strings
Date: Mon, 10 Mar 2025 15:25:31 -0700
Message-Id: <20250310222530.work.374-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=kees@kernel.org; h=from:subject:message-id; bh=toNx9CLEtAH8f4PMhwMHxq60ik9H3b5D5G1iFVqwsCQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn026dMlzJw8kzLVpZ+Vno97LZV5rCPp5qqHvHtGudr NDr2+cedJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzkcznDP1Vbgb3Wp5mueLV3 XDg7s+YdM3/ohvq0/BlTJ8lqpiZd6GVkuHekmfuQhLJjlKpH9zk9+7UXJsdcluaenOa7/PqxF0d u8AIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

This effectively reverts the change in 4e7487245abc ("vboxsf: fix building
with GCC 15"), to add the annotation that has other uses (i.e. warning
if the string is ever used with C string APIs).

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 fs/vboxsf/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 1d94bb784108..0bc96ab6580b 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -21,8 +21,7 @@
 
 #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
 
-static const unsigned char VBSF_MOUNT_SIGNATURE[4] = { '\000', '\377', '\376',
-						       '\375' };
+static const unsigned char VBSF_MOUNT_SIGNATURE[4] __nonstring = "\000\377\376\375";
 
 static int follow_symlinks;
 module_param(follow_symlinks, int, 0444);
-- 
2.34.1


