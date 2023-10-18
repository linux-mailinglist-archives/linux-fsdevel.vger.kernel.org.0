Return-Path: <linux-fsdevel+bounces-686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F97CE4DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B53A1C20E0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4983FE3B;
	Wed, 18 Oct 2023 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYfoYs3O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF003FE23
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 17:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6728C43395;
	Wed, 18 Oct 2023 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697650909;
	bh=4p7KAc4dsK8dQOeLACIwEbavFhpYUlO+UH4AD1OreDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YYfoYs3OV3OwOoWHJrW77sJgKOC9d7+Xq2vmQwl+Dj5UFhipFADNwQ3Z5KsSsLnjj
	 UVCEUAP+RmDftyHzLhd05wa4Wr9JjLoXLiMNGfHoXxPtQw6AiZe1Lab31EqC9nkk+X
	 SLlEIufv3uKJdxWt2FX2w4ro0YBLs4r3yGGJ2HiiiEmoFU5P7wRsFwR78QI3BZcJKQ
	 JrJadB8JAr5Za++uEa/DHUlvVAmSgMmyDqMs/P/f1w9aWxEst8sifhkZCulFbhCaER
	 HIdZH+kCXuPghYLEvCgDz0lXzMwGopN027mxaYxLLXwTEd1iaD7Uf5TKOI7ecwuiA6
	 nO8L4XBZg8rPA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Oct 2023 13:41:14 -0400
Subject: [PATCH RFC 7/9] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-mgtime-v1-7-4a7a97b1f482@kernel.org>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, 
 David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4p7KAc4dsK8dQOeLACIwEbavFhpYUlO+UH4AD1OreDY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjJsAbzUTfA1QPqzg0MuGg3swqrFXt6uvW1m
 bGS00EFnDmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYyQAKCRAADmhBGVaC
 FfeYD/98fNSYqHhHFEvbqhES3uKXfBN7CAx91j661F9ZNuvn2CUIquUaA+FfPt5NpL/7OW1KiHo
 hcxzhv+n0ws5nkme7kVxjI1jfLKkHNNOrue4gPlc1uU8+6SJ/oW//BRSV+nVkhZJtmIBtz7FJh9
 yHdA4QbXq2qZwMBMlh3eRQTV913fwSRViLHiYkQYST4FOCORzm2QDfAeQNTscPvOI4ewlnaD/ep
 9OIszxsNlLeabXq5eTdHb+tAWYRAcLzGpRDDB+mmxJsTBYPx60lODA9tFAUBrGmwxlDIHNmYx+P
 TornDYcILN2sWjoW0bqNmlRzp6iY037toqRYrQ7JjWhqpujus+aarDdugYY+r4CECwvRypVhGxK
 uWz3jjn1nlJmmBZmavbScjo3jReAgwtwxuTgmQQrYqPxwZS0ts3pBhvgk2atABZVejYvtAmZw93
 QlP8V1GdxhdElp/hHiUK+LBRy0pKGK0lUt4yzOM5udaB7LCwRCIClVUhQ/IygAEikJXhCqX1de9
 ogvCF5Orn0HR0YUZ4mKJ3WD3Oc2V7bfeDJ3zo6hBvWjbiSr6ZXixhXHy03d0TlCIyP+pPfmib9O
 Hzz0pNgcBzA4WTTYeDb6RhPTqh9IfJli9Ntp5lFmYh+Juwu/yH1cI4E5jnLXa4TO/ziZvclczEQ
 7oglGUSvni3TcVQ==
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
index c642adf54599..1b111cf4ebe7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7314,7 +7314,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.41.0


