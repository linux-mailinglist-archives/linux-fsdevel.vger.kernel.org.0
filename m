Return-Path: <linux-fsdevel+bounces-11952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC6A859724
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 14:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E135C281D60
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324306BFA6;
	Sun, 18 Feb 2024 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5AnTcbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2131A66;
	Sun, 18 Feb 2024 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708263218; cv=none; b=nfyMYK5SRQbk3jYsgi5rJkX/TbdIvxPccPLY4cwqYP9pShVocX/TeFACtuR36dIJ4DEkzMZgR61ZFlN4fQk8KE+zQOXsNIqK9AMi7BxfSDXcb7x4I2JNYuFt5DmCTL7h6o1uNg0jJniHUi32jrhWJ2jBeZNxBDmallszlJXLU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708263218; c=relaxed/simple;
	bh=IDweYqBpmZlAsv7IhKK3kBhul5F5hUUql81YNN0YZ1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JGBsDDJ2fDJERkpcc5GFObHG4aZHbQonFSn5xPyOhp3tjJj+aapDU3RPYtrj0FdoCoLqCG9k78Qb+NbmBkQ7mODbw4bg41rBpP+tikxDFcGTf3MGC5mR4FPuEsMxxVox6bqf4S6U/MFtUU3HJe321g8JwUAPmag1ewxXR6kLe8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5AnTcbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB8AC433F1;
	Sun, 18 Feb 2024 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708263218;
	bh=IDweYqBpmZlAsv7IhKK3kBhul5F5hUUql81YNN0YZ1Q=;
	h=From:Date:Subject:To:Cc:From;
	b=A5AnTcbZVZwx5KC449LPsCqwMUWmYNN8yYfvxOOuPTApiuyUwV6PIHDQgpjZiNFnB
	 FXgDtAQiAzDyEX3CZs1rwWVzKiQ64icSCkM0ulDOWCtuhmhaYcwIiRvOJ4Q0iT88Tx
	 fQHzPGEOB2Y9MoFGNNOC1vnt1GIeEsXKn3UoXpG9pYylwOHeIyt5jljfpCaN1A/sH8
	 WGB9t8fQV/wYCgfvDNSGbPpg8YVBopBB0YkA76sQtHv1f1T1xaDsDZLuJ/UYjYLqH/
	 aCIIXDyc4wLFsu9snrIGPAso35O5ZHFOQsqLs5+mDWhOmxWlAV8XixfLnUuaNFNyE7
	 KCoZyj2xbYMPg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 18 Feb 2024 08:33:28 -0500
Subject: [PATCH] filelock: fix deadlock detection in POSIX locking
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-flsplit4-v1-1-26454fc090f2@kernel.org>
X-B4-Tracking: v=1; b=H4sIACcH0mUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0ML3bSc4oKczBIT3VQLE2NTY7M0k2RDQyWg8oKi1LTMCrBR0bG1tQB
 y/KxWWgAAAA==
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, NeilBrown <neilb@suse.de>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <oliver.sang@intel.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IDweYqBpmZlAsv7IhKK3kBhul5F5hUUql81YNN0YZ1Q=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl0gcq+QwOhaWuQJAls6+uG0WF8F76TKJ6MfEug
 DeeIqVt6B6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZdIHKgAKCRAADmhBGVaC
 FTbLEACbVUKzyO1ficrtYrsnH14RnDccj6+5uQ2KLn2lxHDrjViEHMOw7JqIDwqk+d7KmlITzFO
 mARHJd1kLBhW6LZrEuvsZp7DOG11qFrdg1RxuYoFPxs/u6vpmS3r8ZXv1Ie3EjipQ0qgf1CAP4W
 5HhxmhacHgOafjFDR9tKtogkQK6cW78LDRHgj3m3LUn3hn6keyXIBWQk3IxWYV2uir1QhSGb0kG
 M3nO9Z25j7zdITcYoaLBiumZfAX9vM6Yd+jp297vgGaLaovXkQ+VNgJWOEG4EEaT11za5Zd830X
 BDoqqyEctFwxiLN+dUcu/cob3KCRf8jEMrKG3kPiKZ0fGeuXMRZpCg+tyjAoB7AARe3Jb0JwsR/
 xISfawginnqn4b7NJRmqKEESb58qi7fNmxYjYY9dFZCDfCbxBSe8AoNKmXCxe+wMBY92g3yUERM
 +wDBitj1MWUmTVIJnJh4HUI+vCymUW4ZNJtVQnP99gTR9cqHo3DLbRv7OjeDW/Q+GGAPDxvhq81
 91nwpL5QCDcNNfpIvHt8TGPBdmb4KWmxdTl0OAmLys8dNCQj4zlcHFv2C/DklKnMyhLDVw1VvKz
 rTfJH6FSoSyJAAfCMvag9lWWASJtmADB4M75ehtju+pWb0Vqpwm2KBJUJ4aKVkdF4npBlz0O8cY
 mJClbxOtcjg3nDw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The FL_POSIX check in __locks_insert_block was inadvertantly broken
recently and is now inserting only OFD locks instead of only legacy
POSIX locks.

This breaks deadlock detection in POSIX locks, and may also be the root
cause of a performance regression noted by the kernel test robot.
Restore the proper sense of the test.

Fixes: b6be3714005c ("filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202402181229.f8147f40-oliver.sang@intel.com
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Disregard what I said earlier about this bug being harmless. It broke
deadlock detection in POSIX locks (LTP fcntl17 shows the bug). This
patch fixes it. It may be best to squash this into the patch that
introduced the regression.

I'm not certain if this fixes the performance regression that the KTR
noticed recently in this patch, but that's what got me looking more
closely, so I'll give it credit for reporting this. Hopefully it'll
confirm that result for us.
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 26d52ef5314a..90c8746874de 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -812,7 +812,7 @@ static void __locks_insert_block(struct file_lock_core *blocker,
 	list_add_tail(&waiter->flc_blocked_member,
 		      &blocker->flc_blocked_requests);
 
-	if ((blocker->flc_flags & (FL_POSIX|FL_OFDLCK)) == (FL_POSIX|FL_OFDLCK))
+	if ((blocker->flc_flags & (FL_POSIX|FL_OFDLCK)) == FL_POSIX)
 		locks_insert_global_blocked(waiter);
 
 	/* The requests in waiter->flc_blocked are known to conflict with

---
base-commit: 292fcaa1f937345cb65f3af82a1ee6692c8df9eb
change-id: 20240218-flsplit4-e843536f4c11

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


