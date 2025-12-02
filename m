Return-Path: <linux-fsdevel+bounces-70419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA935C99C81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 02:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A00504E2347
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 01:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7CB207A09;
	Tue,  2 Dec 2025 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PySEV1Yw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55B1F91D6;
	Tue,  2 Dec 2025 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639411; cv=none; b=aM25RwnEEHmzGwBOFsNyY0hg1T6CghjXxfbjONFn8dgFeifbL4K24SKg35zEqRegNdqVCpC11gvDFTYFd0uexi1bKHypjKhwPCBRw5O/1hS1HEAZqzX1KknQJufb+iZ0Cbj7YhJ4qgC1k4Sm5pRtQVJ2i7/f0rJj+THLG1ZqhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639411; c=relaxed/simple;
	bh=5lX5KpTfh5lp1TSAgoOcg20Ql5ovyjThTY5/ZiVpS1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSLCNRp1U6KwGzbVwprk5DEsOSbdm67O8Hr2eWjN3gd419fHwa48NtiplqnjAWlP3LrdXApCNpVBqHhvscm0pChTnIk+1Ur8zPdjxkrkULcu72WkEkzcVZtFgeEDGAC4C017upQJYp7APC8w987CdplfuQFtL8qVo297KxkBbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PySEV1Yw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AA9C4CEF1;
	Tue,  2 Dec 2025 01:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764639410;
	bh=5lX5KpTfh5lp1TSAgoOcg20Ql5ovyjThTY5/ZiVpS1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PySEV1YwxKJoFsqg6kncPujE1e2ZccxxkUO9FhYPMzz3DFeI+WEOLRABuunIiM4Ax
	 hm9UN1Q80WVmIJE/ojMnxip1frr53BJhxGVIxpyf6z4a7Ly/VR8RzPR4PI5FgIeZLd
	 xEHy16fkdfAWJU4W6f4d6IDe1Tv793k3d7BGsiouvw24q9oIbAkZDcR1iTXiuVQIXL
	 cBn0KN74vENbIejZm0yStn2PAETxDxmXwNhAu6CgyzNccZmlfqBqyMJ8YBDg01Fj4A
	 syrR1CoOEBAql3Io9ZXOxoQsoe/FiPE2qm7OFAfxXzCUTsiEm9Koynck/482UnUAPr
	 eRfgTSftn7xmQ==
From: Sasha Levin <sashal@kernel.org>
To: sashal@kernel.org
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	snitzer@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH] nfs/localio: make do_nfs_local_call_write() return void
Date: Mon,  1 Dec 2025 20:36:35 -0500
Message-ID: <20251202013635.1592252-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aS5AS-rzQfFeK94L@laps>
References: <aS5AS-rzQfFeK94L@laps>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_nfs_local_call_write() does not need to return status because
completion handling is done internally via nfs_local_pgio_done()
and nfs_local_write_iocb_done().

This makes it consistent with do_nfs_local_call_read(), which
already returns void for the same reason.

Fixes: 1d18101a644e ("Merge tag 'kernel-6.19-rc1.cred' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/localio.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 49ed90c6b9f22..b45bf3fbe491c 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -822,8 +822,8 @@ static void nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
 	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_write_aio_complete_work */
 }
 
-static ssize_t do_nfs_local_call_write(struct nfs_local_kiocb *iocb,
-				       struct file *filp)
+static void do_nfs_local_call_write(struct nfs_local_kiocb *iocb,
+				    struct file *filp)
 {
 	bool force_done = false;
 	ssize_t status;
@@ -853,8 +853,6 @@ static ssize_t do_nfs_local_call_write(struct nfs_local_kiocb *iocb,
 		}
 	}
 	file_end_write(filp);
-
-	return status;
 }
 
 static void nfs_local_call_write(struct work_struct *work)
@@ -863,12 +861,11 @@ static void nfs_local_call_write(struct work_struct *work)
 		container_of(work, struct nfs_local_kiocb, work);
 	struct file *filp = iocb->kiocb.ki_filp;
 	unsigned long old_flags = current->flags;
-	ssize_t status;
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
 
 	scoped_with_creds(filp->f_cred)
-		status = do_nfs_local_call_write(iocb, filp);
+		do_nfs_local_call_write(iocb, filp);
 
 	current->flags = old_flags;
 }
-- 
2.51.0


