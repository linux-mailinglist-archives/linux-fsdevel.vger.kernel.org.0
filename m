Return-Path: <linux-fsdevel+bounces-22863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAE291DCA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7899B1F221CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7D15A489;
	Mon,  1 Jul 2024 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OowJhdWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22261591EA;
	Mon,  1 Jul 2024 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829647; cv=none; b=NqI9fzKHJ0TUcDFr/GC7zqzHRo7qbR8Ksfrx1UQHq3OH5mW+75s5bnMrNcWIStzDHB8XOTUPAFE6HWmFhm+G7gU57zMENXjR4NN0Goga5DUIeyFsIs34lc1n4f5KLYu1qcGWwl80hPVMyH4QdI5cOvmrLQs5BElQdI2woay5GLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829647; c=relaxed/simple;
	bh=Rk22CdrDmdQOqV9B263elJ8j6v40sRU7F5SFeqVcw0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RChfssgWGgemF2oVQGsmL78iOWExPNbYsVBk4HvTNSB+5dJGjGrHQbsLnJZ7RU1cygQhpVv7oj6X86LUMqNJBUMzmm3AdOxfdziJ6D+zAwgZr2HZwJKOig2sWe8BLL3nKdKRgZUVknwM9DJ3Uc/X6C+B5D0lErKvz8WY/5yBlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OowJhdWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE45C116B1;
	Mon,  1 Jul 2024 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829646;
	bh=Rk22CdrDmdQOqV9B263elJ8j6v40sRU7F5SFeqVcw0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OowJhdWfVqPKKEzYltDwB3xDFDzgsyHuZVnZFzyVf+NMt7lTQ5Xc0tuog3yyfc7ig
	 sTzsTHcSwUnEVnS/lAS8fq3DlhpJXutHyVEQhawSqrWfPNa4nSVTJ4duw3FZDlzJmZ
	 208icB/wfSVQYNHoz3qgs76HcEVXAx47suT211oSvJKgZkF+DhjT/hwRXWQrOcFMIw
	 /yDzneIZdAfeh+wno6J5k9/ixaEKqGn/02aVR05iSEdWW0ltLmB1hurn9sOluDtEcL
	 8qMhhXlOYebsXL49jTYC7zgsbjEJj8uiT4Ua+TgTzyOvdBSXN/c5JTqnhMBaP/XZCe
	 kwwaYTUjo9RZg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jul 2024 06:26:44 -0400
Subject: [PATCH v2 08/11] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-mgtime-v2-8-19d412a940d9@kernel.org>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
In-Reply-To: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
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
Cc: Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Rk22CdrDmdQOqV9B263elJ8j6v40sRU7F5SFeqVcw0c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmgoR5dUKZAApA/E/nRf8PhsAANcOPXvLXNU/zT
 iYd1qkDzC+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoKEeQAKCRAADmhBGVaC
 FSUID/9d0pO7TT9EGNH/i9za9KrWODEB5zSIIaRqI/95Bt/pwLRRr2KYiuSXiRv3RRAWDn1GijG
 LTSMRD7kVqDNCR6uPWUO5INXMOYvfypXN5mxWWXaPFsp5j6TPDOcsE6Kbf/vCDDGwmIEZZtqAqD
 CAw8fVNdszgTykJEVngG4sJ7q3c0pIZoDtuiwe8L+krK3SUU4amjj1u8rOGG7z0fDzftIqvknf9
 Ke5a1qn+cWa/DgnKPmJVhSGoY2EMvu5fELrasSun90ERTY3dS/87GUcUNY1WryIbebedaVKi6s3
 9uVrCQUygyJzW5INth1pNMSMSitS7QN2F3rKFxQaImISFY3Pvi0i5MvXsIbwUuEMDEixB/rmLd/
 axKEm6rFltjfvlmWe/VVV/H4fBXv3hhDIT2ZaT/i5rwIdghM8DaGOmiJYjvb4UgHUB3nScbdyWf
 vloMf0oOIBm1hrE0kSS2xbHYIBZAPyqlq0utguPUKPpyEn8dCBjVsS6lolhydeU+RyeLXYpLV9y
 rEvrmE5tDwSsi++UlMtX8LxIQgIq6corJIikLnTLC/wOfqqglaQqKYKu9FtUrh8NvTbe4hNgjTG
 3mgzSVxouLdteOhi11js/IIAU4lbcillebCeDLZZlqo0+7lXdoK5oYdXeNAygZ0fjpPrLg2R/Vy
 8S5NgQBdXHroK6A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

For ext4, we only need to enable the FS_MGTIME flag.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c682fb927b64..9ae48763f81f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7310,7 +7310,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.45.2


