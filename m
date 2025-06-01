Return-Path: <linux-fsdevel+bounces-50270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91584ACA3B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 01:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B333216827C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 23:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56EE2609C6;
	Sun,  1 Jun 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srodZ61c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BC028A1E1;
	Sun,  1 Jun 2025 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820615; cv=none; b=HUQsQSWw5HwuEMy4p3n/dQQLosW3uKBpVzKUjjwe+A95GzIy5k3aNecnFGC1cCb02yS5TH7dTGj6TVx+GMw3wMakhU52qUCcaanJKMq/dnVvPEc3GV1yBc68AQrC3TV7kEQtG4iMyhHzg+E1RdhUjnOry8pDpAzSVpWPq1vKF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820615; c=relaxed/simple;
	bh=qeaYsChK5nr9rSe+pp5hAEu/C1ACGe+t3EnImvBNz2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kw09Vs4PCg9/C32YkQxnAq+lRxTxl1KKPPaSijljsXBxvb5IfZN4FzAiaJnfQ60ZrbPbdCMKyi1iM/um8qrjyzAaq/FQ2UWwmfF8jEcmdtqsswmhOh6y70NiSrWRKsK3boRlBFGP4TKTIJ3uSs158p4jnKCbtHOqzoHghfUOl0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srodZ61c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73E3C4CEE7;
	Sun,  1 Jun 2025 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820614;
	bh=qeaYsChK5nr9rSe+pp5hAEu/C1ACGe+t3EnImvBNz2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srodZ61cpPXEHmc0AJ6O0fGOGArtJmXE1CbTIS0/Y0pKAljP+R7lqelKcNMUR1GM3
	 UQH9sh2Psm+DwTEc17e8thqHsTNlcOEvqt8m2OMr+Iq8e0keKlxh97LerEFiNvob6N
	 7CS2FOfTTJCTU7HZGmIowssVK/AoxnjwXjVKiQA/otQi9DyMqpl2Pr2QvtBeb4dJ6w
	 gCkKNO5FEGTv0+uy5362KIIkr3qJ3oaVRzZBwpukEDGuee1oiy/pP1mhfYwzAY0xY5
	 jwXQ+azBnTBMdsre1G4Nmzq9w58kwaHwe3i4Aa0fJlKyBqvv1anMUAyYGzns4s/HJe
	 +8/vraq8OYNhQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Jianzhou Zhao <xnxc22xnxc22@qq.com>,
	Sasha Levin <sashal@kernel.org>,
	sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 014/102] exfat: fix double free in delayed_free
Date: Sun,  1 Jun 2025 19:28:06 -0400
Message-Id: <20250601232937.3510379-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 1f3d9724e16d62c7d42c67d6613b8512f2887c22 ]

The double free could happen in the following path.

exfat_create_upcase_table()
        exfat_create_upcase_table() : return error
        exfat_free_upcase_table() : free ->vol_utbl
        exfat_load_default_upcase_table : return error
     exfat_kill_sb()
           delayed_free()
                  exfat_free_upcase_table() <--------- double free
This patch set ->vol_util as NULL after freeing it.

Reported-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my thorough analysis of the commit and examination of the
kernel tree, here is my assessment: **YES** This commit should be
backported to stable kernel trees. Here's my extensive analysis: ## Code
Analysis **The Problem:** The commit fixes a classic double-free
vulnerability in the exfat filesystem. Looking at the current kernel
code, the vulnerability exists in this execution path: 1.
`exfat_create_upcase_table()` calls `exfat_load_upcase_table()` which
may fail 2. On failure (`ret && ret != -EIO`), it calls
`exfat_free_upcase_table(sbi)` 3. Then it goes to `load_default:` and
calls `exfat_load_default_upcase_table()` which may also fail 4. When
the filesystem unmounts, `exfat_kill_sb()` → `delayed_free()` →
`exfat_free_upcase_table(sbi)` is called again **The Current Vulnerable
Code:** ```c void exfat_free_upcase_table(struct exfat_sb_info *sbi) {
kvfree(sbi->vol_utbl); // No NULL assignment - vulnerable to double free
} ``` **The Fix:** The patch adds `sbi->vol_utbl = NULL;` after the
`kvfree()`, which prevents the double-free because `kvfree(NULL)` is
safe. ## Backport Criteria Assessment **1. Bug Severity: HIGH** - This
is a memory corruption vulnerability (double-free) - Double-free bugs
can lead to heap corruption, crashes, and potentially security exploits
- The bug affects the reliability and security of the exfat filesystem
**2. Fix Quality: EXCELLENT** - The fix is minimal (just one line:
`sbi->vol_utbl = NULL;`) - Extremely low risk of introducing regressions
- Follows standard defensive programming practices - The fix is
contained within a single function **3. Backport Suitability: PERFECT**
- Small, isolated change that doesn't affect any APIs - No architectural
changes or new features - The fix addresses the root cause directly -
Compatible with all kernel versions that have the vulnerable code **4.
Historical Context:** Looking at the similar commits provided: -
**Similar Commit #2** (Status: YES): Also a memory leak fix in exfat
with `Cc: stable@vger.kernel.org` - **Similar Commit #4** (Status: YES):
Another memory corruption prevention fix in exfat - Both demonstrate
that small, targeted memory management fixes in exfat are appropriate
for stable backporting **5. Impact Assessment:** - **User Impact:** High
- prevents filesystem crashes and potential data corruption - **Risk:**
Very low - the change only affects error paths and adds defensive
programming - **Complexity:** Minimal - single line change with clear
semantics **6. RCU Context:** The commit a13d1a4de3b0 introduced the
`delayed_free()` mechanism that made this double-free possible, making
this fix essential for kernels with that change. ## Conclusion This
commit represents exactly the type of fix that stable kernels need: a
small, surgical fix for a potentially serious memory corruption bug with
minimal risk of regression. The double-free vulnerability could lead to
system instability and the fix is trivial to apply and verify. Given the
similarities with other exfat memory management fixes that were
successfully backported, this should definitely be included in stable
kernel trees.

 fs/exfat/nls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index d47896a895965..1729bf42eb516 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -801,4 +801,5 @@ int exfat_create_upcase_table(struct super_block *sb)
 void exfat_free_upcase_table(struct exfat_sb_info *sbi)
 {
 	kvfree(sbi->vol_utbl);
+	sbi->vol_utbl = NULL;
 }
-- 
2.39.5


