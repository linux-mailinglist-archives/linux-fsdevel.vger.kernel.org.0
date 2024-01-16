Return-Path: <linux-fsdevel+bounces-8025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35182E6C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 02:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD181F22CC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 01:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094CE1E4BC;
	Tue, 16 Jan 2024 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCgzzAIb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA081DA4A;
	Tue, 16 Jan 2024 01:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66640C433A6;
	Tue, 16 Jan 2024 01:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367158;
	bh=QXsxDVG+mDeikixD/NQuUBu5j3wwemKNZLGM6l6dV6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCgzzAIbimdO/4eUNWGIfayRMrIi18E1NakYVI1FMHU3QEPM3aQsMkcLuEf62MgAv
	 ttFyz3oRhLmuTX4Kqgoj/Nh3uOUmOZ4gLoFKaLoGzG/QJz6aMFAwbDUeHQleLuqIMe
	 OTspt0+fLoyLxy5QVq/P/ow6gN57jVYvyfyaPwRbCImXyyZcjK7oi/GRUah+50Mf8a
	 IMVttPMUKw7HHHT+HK0UHgdjmBoveb7rAQr+k9pBXkU3UscdnBOT44u27F18A923Un
	 iAqHN+RK4a/lcBb1ggiF1AcHAuhbsNNTUpKH+vpZqcr1AETUHPKkAm7n/vc+qxT8T3
	 x9mZDLRRAguUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joel Granados <j.granados@samsung.com>,
	kernel test robot <oliver.sang@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	keescook@chromium.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/19] sysctl: Fix out of bounds access for empty sysctl registers
Date: Mon, 15 Jan 2024 20:05:03 -0500
Message-ID: <20240116010532.218428-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010532.218428-1-sashal@kernel.org>
References: <20240116010532.218428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Joel Granados <j.granados@samsung.com>

[ Upstream commit 315552310c7de92baea4e570967066569937a843 ]

When registering tables to the sysctl subsystem there is a check to see
if header is a permanently empty directory (used for mounts). This check
evaluates the first element of the ctl_table. This results in an out of
bounds evaluation when registering empty directories.

The function register_sysctl_mount_point now passes a ctl_table of size
1 instead of size 0. It now relies solely on the type to identify
a permanently empty register.

Make sure that the ctl_table has at least one element before testing for
permanent emptiness.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202311201431.57aae8f3-oliver.sang@intel.com
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/proc_sysctl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index de484195f49f..5b5cdc747cef 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -44,7 +44,7 @@ static struct ctl_table sysctl_mount_point[] = {
  */
 struct ctl_table_header *register_sysctl_mount_point(const char *path)
 {
-	return register_sysctl_sz(path, sysctl_mount_point, 0);
+	return register_sysctl(path, sysctl_mount_point);
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
@@ -233,7 +233,8 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 		return -EROFS;
 
 	/* Am I creating a permanently empty directory? */
-	if (sysctl_is_perm_empty_ctl_table(header->ctl_table)) {
+	if (header->ctl_table_size > 0 &&
+	    sysctl_is_perm_empty_ctl_table(header->ctl_table)) {
 		if (!RB_EMPTY_ROOT(&dir->root))
 			return -EINVAL;
 		sysctl_set_perm_empty_ctl_header(dir_h);
@@ -1213,6 +1214,10 @@ static bool get_links(struct ctl_dir *dir,
 	struct ctl_table_header *tmp_head;
 	struct ctl_table *entry, *link;
 
+	if (header->ctl_table_size == 0 ||
+	    sysctl_is_perm_empty_ctl_table(header->ctl_table))
+		return true;
+
 	/* Are there links available for every entry in table? */
 	list_for_each_table_entry(entry, header) {
 		const char *procname = entry->procname;
-- 
2.43.0


