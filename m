Return-Path: <linux-fsdevel+bounces-63772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A75A2BCD83E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BF634FE8BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D7B2F532F;
	Fri, 10 Oct 2025 14:24:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4117597;
	Fri, 10 Oct 2025 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106283; cv=none; b=iBzO37PfhAzoCQIgGsUebXlpeVcIFr1ttP8+yBmqbRBX+8EmnqAuS6RZ+dxxSNeEUahx++VB0SzWY1MjkLFWdk5wAV4NqPUjvJmOxjd+pho/Pe2M64aaHt+SRX1cvFajxF4nNUmRZSgG9rccwSmGQ/Xj6JaDgxxMImtqkXLaO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106283; c=relaxed/simple;
	bh=Pz7+mjh1n3Qe8eGtPGRpSgsSzVEMrqELhgJbZ3QZR9g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DMiACIftTzmBqwLrx41KowW2MKEUYw9R3sIfY3DwPgzfVUFf911uaT8Br/+wIrK+7nbofMSBIVJ0rkyceIUA8fghkIa+Pt6C4Ak9fBNNCOUCRcxJPr4XYcampexQ939SGnIDZYgOqW0m5TwaWFkOTQpBe15nwZ5LqYAskKnA9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59AEOVhl069941;
	Fri, 10 Oct 2025 23:24:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59AEOVmt069938
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 Oct 2025 23:24:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp>
Date: Fri, 10 Oct 2025 23:24:30 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] bfs: Verify inode mode when loading from disk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp

The inode mode loaded from corrupted disk can be invalid.
Since Boot File System supports only root directory and regular files [1],
reject inodes which are neither directory nor regular file.

Link: https://martin.hinner.info/fs/bfs/ [1]
Reported-by: syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Since reproducer for BFS is not yet found, I can't test this patch.
But I assume this is the only location which can store bogus file mode.

 fs/bfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 1d41ce477df5..6cc552f77d51 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -72,6 +72,12 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_fop = &bfs_file_operations;
 		inode->i_mapping->a_ops = &bfs_aops;
 	}
+	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode)) {
+		brelse(bh);
+		printf("Bad file type (0%04o) %s:%08lx.\n",
+		       inode->i_mode, inode->i_sb->s_id, ino);
+		goto error;
+	}
 
 	BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);
 	BFS_I(inode)->i_eblock =  le32_to_cpu(di->i_eblock);
-- 
2.47.3


