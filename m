Return-Path: <linux-fsdevel+bounces-29388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E939D979286
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 19:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A91B21AAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8441D79A5;
	Sat, 14 Sep 2024 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG7KWITq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF61D131E;
	Sat, 14 Sep 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333667; cv=none; b=tgjVp4RgcWClfUVilXexWJhILVho0gWV1jtH9QatQPs1K6nM2OQFM7WdQ+ita41TCQz4NWoYI/gEgxfOIa69TksM3MzsXk1K0jYRzBLXNqmBEKzGmAs34foWNObpFelLd0fkAce/4zNmHMAz6Prq+i+2P+0xv7z4nolRNrE60HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333667; c=relaxed/simple;
	bh=Fd5IxgHtKcN7b8Mow1VZm20amle3gCRV/bljD+jCFMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHgNpq0FbkaBQ2aaQT/mrWnsWQ8O0vsovzoks2YkSov0lEzAOT/7WbIh6jZlrpbARX1LItWCaN5EH2FjB1lesF0Hj3R6cAj7Ns5Sm6opvTDcOwNlx/sb964xuIdksMI9oAHTv0Aq3URjDGijpVOIXtdRf1Prgn7eLL/2tb64z/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG7KWITq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91458C4CECE;
	Sat, 14 Sep 2024 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726333667;
	bh=Fd5IxgHtKcN7b8Mow1VZm20amle3gCRV/bljD+jCFMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lG7KWITqZ0JTULqD7K9VNOzVeIcKW5pDUATUsN0srkR/FaTU34rCalh4fQLd0NiDz
	 ayuWAUjH/b0F6+2dSPyidYV2vGekaNEFlst+DGGLDZJp9KDjfwEp7fFvmRbLLGpgXQ
	 VKp25sywWngfmZlWl3znmMEZJ2xwbKrYa3+nQL+VkAIDTbthpmqHHGPh0xozWOzWA3
	 tdQLKrY/X3SFm2oYyzfnF6oETy80+BgJ1JlbjHE2pKOJGAY5EBgFE2vN7/MpyNIKib
	 DxwIgODNV99Racaj1tVRZSo5DgF94J49k5zNoIAj9ZI+9aj+TWw8u/SluzXG2HZjNI
	 dCovHd/yHMRbA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 14 Sep 2024 13:07:22 -0400
Subject: [PATCH v8 09/11] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-mgtime-v8-9-5bd872330bed@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
In-Reply-To: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Fd5IxgHtKcN7b8Mow1VZm20amle3gCRV/bljD+jCFMs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5cLGaLrdQdloS9SHdXwjs/lx9Z+m43owb/WYh
 Ced8DtcfP2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuXCxgAKCRAADmhBGVaC
 Fdf/D/43c/84XJBxc2MJzrsOgo8VKaf8OhXukqOqa4RnPa4E5mj1ttGDtErs8lIQmzt45brcimw
 cxGf4byRL5N91O6Cv5PFmSlZiKV/MGMucjoc+YCRT6PPP+L14YxaP0mnxjK7DSxNPiEXtPytkk/
 pMnbw41G5nHWCvJXaZnH2iV628zZgovKt9rGi05T+YvxjfYZhRRxZBc2r5q5OHsFYRlvlCFWnYh
 Uiy4soYIg6KZNopRh28NC75kVeKzbJm9OjYuSO8Eklbhbn1ew6n1TEudO25zyMSL1gimXSzU28o
 WXRf+DYyfpaWR1ZSCFRhYUvhslFN+gJ23qo7BwI3R1HmQmObfhuRUFPQGRRGq3YWfZkWTRoL+h8
 ktSVEFwBZZ8jJw3ZyF18d2WM5rUZXtQTYj6ZjBfLq0viDaj+whmVXP5WKcyjqHNc8+9tf3IjRNM
 QICRarciWhavol197vxmJ9xwMm/whTgX6Zn90+/2JwlxsNNey+3aFRKKTJLC4rVZcwNnfPaOTbD
 8D9w21RW913ovXTTJz61yn+MWHnrTlcjJ1Q3nWPY/XbvNQyXJoT5xrMBZ6ew2mhamHbgTC+jZvi
 +ZzebH+GhoqU0MBAOmPVX6nNE3BiL1nAq1UPunG3Vivc/vxhkn/LxCuFW/8esGLfkACeXqVNf7X
 aVUfw8gUCfn5HNw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

For ext4, we only need to enable the FS_MGTIME flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..a125d9435b8a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7298,7 +7298,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.46.0


