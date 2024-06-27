Return-Path: <linux-fsdevel+bounces-22586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99062919CC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4554A1F2306D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D075E7347E;
	Thu, 27 Jun 2024 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwfaFDJ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2407A6FE21;
	Thu, 27 Jun 2024 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450057; cv=none; b=FkgEJl656rQ7V6RkTpAYCqtS2ni91oII2zY4E02pdN9aqQ3RaYf6iZH80MvzfbZgl8q0R/yfFmNAVK0U54TBbWglW0fe1aS2WUMqHAhSivk1EnJfdkgyup1SGb17K1/nih5qaJX3Kk8VfvH0Kf+FF09trKuGk+Pf9j1oqVwUF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450057; c=relaxed/simple;
	bh=cVjMReDf/y0/Eps4SzleHHnDCMnHwvcYHN7Dj4UkNNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VeiNBurWdn0Ftj7D7500gdk+eyTCSdobeqUDrn+c63gazqNjf5TGDC1+HQ+ROtwXJ4fPvucUTCvP/qEtDgvTfvDYAf770DybC1kI0J4Zzdi+8V9bSYOGZc92ns6qTEo3rc/bUDNvYsKshMmc/ARiRy7BBNT7cV2upn+egNW73NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwfaFDJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F045DC116B1;
	Thu, 27 Jun 2024 01:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719450057;
	bh=cVjMReDf/y0/Eps4SzleHHnDCMnHwvcYHN7Dj4UkNNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nwfaFDJ/c30GiYmVc82cD+AdVo7ASrnc05c022cx7CwFpW+ctla+QGAWhR7g1u/0N
	 FYQFKuzWEbo7DOQHlPOPzqZ9JMeE0rDVK2Z9M4eU1oHAd2ynL1MMg1rhKgKBK5LXIA
	 N57GBUcpsaC9GC0Vd33/hTbi+JuMNBPY7ftTa2coNIlhKyUl9lKFV375aDLvjgKRlh
	 W34ZJnjvdQcAdBbpmX5o392KQ/rt6/HfqCiZTEzUsxfJdRLGhocUh1i3gvv/k3wsHo
	 0HntC5Inb6+MF0og3whrwgsMnla76xGCkDZAFd7OXXdWHpqiiGu+SiRTccaF1IsHZd
	 ziBcVX92FrFqw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 26 Jun 2024 21:00:30 -0400
Subject: [PATCH 10/10] tmpfs: add support for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-mgtime-v1-10-a189352d0f8f@kernel.org>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
In-Reply-To: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=775; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cVjMReDf/y0/Eps4SzleHHnDCMnHwvcYHN7Dj4UkNNg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmfLmvmuG1qE25UPrDynn3xIhwH5hC1wcY+8bCj
 oncJyX2Q2OJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZny5rwAKCRAADmhBGVaC
 FZiQEADD/GWDUAnr+QPK/65D/8cdJ2MjbHRshcq6JjFg04ftIlKReTiXHUgZFibwslcU1/KJXqA
 AeCQYsajkGNfClYJdPooe+9fYkC/bZ9TuTbCx8vgEkdy5spW1PqMwKpcYnaOtz0rt+y7f+dDbvZ
 Il5HQomOyFFjic4OS56a9d3g7ZKHKrMT25Wr1E2xXYMp/1TFSnsZ6PzqJZC83R08MKAk9AiLN8W
 ATgs3TQWKeBloEOKCB49jcfGIHtirxKLivKHL04iaZImju21FOjEedEXy021mtUKZyS7/UIF7Vy
 7tSTQr9F9vTxs93vtzmWUDC0cLFTtfaog4o/C9zuhVTW/mjZ4JmWIalSU6uBqnFqemiucQSCe45
 q9afVDCLHijyoaX+aX1D2/8vYg//+/oDAPzmt0VmULKwekM+f3ZtbPVKqSOI9HaVAhV769zRd9u
 MWeehoAPSlcJTBKBZrQVCIX5aX7q0CQnuN7+t/nESwmDBtRnwLzpAj//XiDM68TFxPn6wHMV+O3
 e0sUqEzWfynVDKhu9OXrLQb1Pq0wfWdW/G60LQlJCK1iST4tmUat5GbRh6rexvj9nTJXgdnyJ0R
 YLi8/dD1+0aE1S1yt8LtuIzPrKFhLnTNMcmcmi1DKRiDPpKRcRqI7FY3mFi18w9FfIKybfXInFJ
 Sm7/fCDwxamE4rw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ff7c756a7d02..d650f48444e0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4653,7 +4653,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
 void __init shmem_init(void)

-- 
2.45.2


