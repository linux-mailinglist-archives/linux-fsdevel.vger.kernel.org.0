Return-Path: <linux-fsdevel+bounces-69543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C47C7E3DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 711D4349F03
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC42D7DEE;
	Sun, 23 Nov 2025 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6U0FwaW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C92264A7
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915661; cv=none; b=pC1gkV82yTeoUMuzBURBjJk1JJv68a1r06BrCha+v+DefpjbPTZg49OjwqKLFh7QiSlYHGmBFd9lPNufM96IqCqO6jw5I624OWHSaTG948uhhLfVOlWuCZIs6kfXtt6vYTI1JMmVZ/WgprNIpCeOVUjQ1sjT9lcJNmqCrdKkSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915661; c=relaxed/simple;
	bh=sjHFEgypsUh2m9oGp6cqI8RWeszMAlts71YepXbmwHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDo5jJHaum4QNA+kqAs/cMOwlsSjQpPVNU7P56wvGfpG04SvsxGmF+1dCBygeYAMEpBBNmShjnDihrRm1+mQpg1pYNQcuTg2sWYHXzKKSuR75h3bPJVw72lrTqEo3z3s/QBhwh/d+TiMgjd0NDuOlrzQoKWHtJGKOzvHLx6vydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6U0FwaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A4BC16AAE;
	Sun, 23 Nov 2025 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915660;
	bh=sjHFEgypsUh2m9oGp6cqI8RWeszMAlts71YepXbmwHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X6U0FwaWew3/DBOibx4qBNGWm5/KNSVC3H01vlka0D4myAEoPOIbPhOUz4DMa4F0o
	 orCioJrDIIIQsSahNRYeDksCuffvRwMn84mwONAp11q4Kr/0foe901SgjR/Tg+MYiU
	 qNVOIHSpqS7XB/QtFUi1xbod7MloBoNPbuRG5g7XQhXw2qR0VcWjEUM00h1XUvAjPQ
	 DOcaZPOt2RB1z+7hfE4KexvSPiC/uYJzG1WFFhbnL7MZRAXDvFqJGM8QuhRexjdeHd
	 ERSAFZLirDlu5wP+HDuWcWZUVn3GoNIFSvjsXtdnG2wFSq4Mx41tkYugmGrg0PuKg9
	 f7qt8FPXRJk0Q==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:39 +0100
Subject: [PATCH v4 21/47] exec: convert begin_new_exec() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-21-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=743; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sjHFEgypsUh2m9oGp6cqI8RWeszMAlts71YepXbmwHE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0c9MrR4qLtaoHzD7CMfU6dH3Fou9u908Q8Gpv9eK
 Y7WO6uWd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE0pKR4bDRor177v7+JHxM
 W6J88rSysiZNhZ8Sr+byzWH5fu33ZX5GhiNCuqtL896fr0y1qN7x7P3zOzGFDdZ/pNZzXxTZGjm
 5nwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/exec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 4298e7e08d5d..7d9fffb38ee5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1280,12 +1280,13 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	/* Pass the opened binary to the interpreter. */
 	if (bprm->have_execfd) {
-		retval = get_unused_fd_flags(0);
-		if (retval < 0)
+		FD_PREPARE(fdf, 0, bprm->executable);
+		if (fdf.err) {
+			retval = fdf.err;
 			goto out_unlock;
-		fd_install(retval, bprm->executable);
+		}
 		bprm->executable = NULL;
-		bprm->execfd = retval;
+		bprm->execfd = fd_publish(fdf);
 	}
 	return 0;
 

-- 
2.47.3


