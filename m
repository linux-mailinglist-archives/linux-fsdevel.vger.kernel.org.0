Return-Path: <linux-fsdevel+bounces-67064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCE1C33C5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 03:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C67465A9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 02:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED98224AED;
	Wed,  5 Nov 2025 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="SgjWg6jJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7521A453;
	Wed,  5 Nov 2025 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309789; cv=none; b=oxkcpTPpfa2Uis7jJm+f2KaSoQGyfCJLwYi9NVzuM6fWmysrveIPLebtllIyMfstAYEK9h1f1jBYqC6YQLWYVjylv2uP0W0PB6nFRNa2+8ngmVOT0zCeOYxo8NOrxs82pXs94rPP9EPV1nE0Uo68eDrbOQmBikqK9sK0Y1o78CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309789; c=relaxed/simple;
	bh=vihv0OcwoTqfTwTZgV6Ptxqv25dxBqlI2rIR5oAbY2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hYtfkabjKFv6Vm0z72wQevUnzlx6jzoNeONrjdl+FnEhLfw1rTtynFR1Oz6PuG3KM8aZnu0rqCRI0x1KMNlXhHWkeTwEcY64d9QPSiBbHhppgZB1GS7FR42xcing9buoD1e+6SS2cRxxSzoxafiS6ytE9yP8aqVkI2FmncTthvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=SgjWg6jJ; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2869c975e;
	Wed, 5 Nov 2025 10:29:36 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] binfmt_misc: restore write access before closing files opened by open_exec()
Date: Wed,  5 Nov 2025 02:29:23 +0000
Message-Id: <20251105022923.1813587-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a51d923e503a1kunm720395536d221e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTBhDVk4aHxlITEwYHR1NGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=SgjWg6jJ8wpyCmGsWH3WTVRLOG3JzbweeWqjDcGDpbonlNJWyIFDP4Lt0u/yuOsGM9lInXLigVcnDDepki4vvA+Nb5jyFwvqwpt10FOi/iZ3WLgu2g6HhZ5o5IV07TysvZl+wCJeOllRwbp4mBntB8hyqV7hYUVxuwshUpeGVhs=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=LcRHFkNUNb4BP3TxxcV+q8/C0VDrALX19FW40WNd0fU=;
	h=date:mime-version:subject:message-id:from;

bm_register_write() opens an executable file using open_exec(), which
internally calls do_open_execat() and denies write access on the file to
avoid modification while it is being executed.

However, when an error occurs, bm_register_write() closes the file using
filp_close() directly. This does not restore the write permission, which
may cause subsequent write operations on the same file to fail.

Fix this by calling exe_file_allow_write_access() before filp_close() to
restore the write permission properly.

Fixes: e7850f4d844e ("binfmt_misc: fix possible deadlock in bm_register_write")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/binfmt_misc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a839f960cd4a..a8b1d79e4af0 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -837,8 +837,10 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	inode_unlock(d_inode(root));
 
 	if (err) {
-		if (f)
+		if (f) {
+			exe_file_allow_write_access(f);
 			filp_close(f, NULL);
+		}
 		kfree(e);
 		return err;
 	}
-- 
2.34.1


