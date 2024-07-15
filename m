Return-Path: <linux-fsdevel+bounces-23695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573969314DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0184D1F226A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7CC18D4A1;
	Mon, 15 Jul 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRAlerJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB50190696;
	Mon, 15 Jul 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047771; cv=none; b=PIzSsQraK9tbVW0up8rYuMypXfJKEFcSyOsED+SxoUVJlQmLK810MFS6qvVqM9hF7pZWZ2WnDLHIAb3/p2NMGvuW+la3j7F1ktlf+qyHNH82npdUQObtW44mckRxXf6ao10HjtKZfq9mUF+TgxAnqljW/0/BIbLmgQAEqWB9foY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047771; c=relaxed/simple;
	bh=o+gyYbKvXkNExYjsuAJ8m7WMS8PZUinH23WSH2Xu+Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EwGO1TUgQLfFaqbWucN2yn7cV9ER5P6qSWGKzXbY5Ex/fLy0SZ9FX33x4H1ChMLFdhmrPL8mif1AlKca7+K/g7q4HwxaMiusHKnBBnjXNulGhtxrmmfqI3u6ZZLq3DaE35Gq2m9ihnF0vC/5wNLYADJLIsy3LW4jAsIKYYAKsmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRAlerJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B49C4AF13;
	Mon, 15 Jul 2024 12:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721047771;
	bh=o+gyYbKvXkNExYjsuAJ8m7WMS8PZUinH23WSH2Xu+Mk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dRAlerJuBd8JkM9VU84MlAHiMeZsxsf5H+2iDx8okusCUrns1bfvO0zdGul5dcknF
	 sUqrcyt5LPwrDZLTCazlsNLaZIGKgXgxUvZeTbQFYc18YKukJQpwMJjvbDCMc9VHW4
	 mYhgD/hePs6YdNdqNN8is+NjLcevZBaupiE8wiqAPjyMH1t9ae8WG23eKmp7YhcJJn
	 olDHXS8PqdS0eMKgH+2OqBfejhVSOdvmCX8lPd08AzjITxV+1375oAgz3ZJ/bXNq2f
	 HU/m9MgJ7kEvT0Q6SH1MHYwtIlWi32QJxYF9Z0AzefTrXou3tHk4wznS1XrSHc4Zua
	 6xUwhfdAHh1Pg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jul 2024 08:48:58 -0400
Subject: [PATCH v6 7/9] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mgtime-v6-7-48e5d34bd2ba@kernel.org>
References: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
In-Reply-To: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
 Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=o+gyYbKvXkNExYjsuAJ8m7WMS8PZUinH23WSH2Xu+Mk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmlRrDVHNMl9hO9HTihB98s1BA9SAsORNuI5QNF
 B0qYkAQuMGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpUawwAKCRAADmhBGVaC
 FQo8EACcB1c4yRYITKFx6X7py1QtR4U1d1NUafTeKADoWBjerJPN9fsm6ZpaaCtQbtKA4W1iXUv
 kpcrsxM8gVi+PTn7Xx8/2ehSVovURyGJnPiHesoWN1DMF3wklKzBb+p+NAJH+ur+LxQjSc8zvdG
 MObZZHN91O7WhIcM/FOXYHusZ/q5rmKog9G83gjv1kosz19oxzdVTU38iC1pgRoMpmrlNIWV2+q
 J8bQZDAm1Kf1h/+ZN5TtfknFpBDJW+XyLUWL4wwGCTMQMKSM4aJ1dVnvDF3Mf6M9FwcoMUEssCN
 +lDwW0hFcHrX5QBhbU3dzC/4M6Czi3YMz/cWz92a/mGv1+Odh1rV5lUmtZEY9MafBvN8Z79H/BI
 p00YDvjO81Mr14q+LSG4V2rT91AJlEoFYDWw+lbJb6UnTHRCzX2gP4N+HlDcdHz0q67r/pBEiFY
 URwwNnnSmogqs1l1onFf3Ea2HRACisOBllB/MQf+OorxBz/tisk9LkGBMeFJJCUH5lND2wE8jBQ
 Imzp4daiSeYfk4qX/8JN2iV3tvEBiEqQ/Ucr+AKZkm9/QYLXI2zufG9ZCwHgw69vQN5BTdQsR9B
 YjJl9/SQQz/+pqO6h3/oEvnZvO1XYn46KHM8rb754N/szjYamIA30H3k/BQHQGuK4y04RrI38N4
 PGkLTg+1A4pF3lQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

For ext4, we only need to enable the FS_MGTIME flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index eb899628e121..95d4d7c0957a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7294,7 +7294,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.45.2


