Return-Path: <linux-fsdevel+bounces-61089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D31FEB550CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F801C81B8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B112FE04F;
	Fri, 12 Sep 2025 14:19:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567819E97F;
	Fri, 12 Sep 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686746; cv=none; b=VObv7E71AS6zQ7vkTIUZ5Y/ApT0KGWF3cfJNmP7X4gFc56Xud2znYxJjruzdS2hch3dUpeR5sWmP+VD6Ab93PFrqTuodZrMeSVCe3Lfr67BvApu/wuadBeg+oPTgUkGkv2frRO1TM98vmjRpaw1eApn4muA1Ex/6cswohC0XQSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686746; c=relaxed/simple;
	bh=6RetG6d9arvqGjc45Er4QYjKNn7jAA1o1cdB/iDSH3M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tMUCkarzuABCMZRedXmvT2mT8FROe07M8123O60M99fxskmVMcKSbmMqq66O0Ur/Q/GS0dxyLVYAdmCrz2kLs/vzDfUuRh+EBlMDROQBhG9f1Q1q21xRLy6WSP7SGWhUqECLQMqJ2r/TXyTnMXMI8aitX3htSWmnM2YWMpq3uPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58CEIiUn050764;
	Fri, 12 Sep 2025 23:18:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58CEIiov050760
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 12 Sep 2025 23:18:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a471c731-e6ae-408d-b8b8-94f3045b2966@I-love.SAKURA.ne.jp>
Date: Fri, 12 Sep 2025 23:18:44 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH (REPOST)] jfs: Verify inode mode when loading from disk
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
References: <1cd51309-096d-497f-8c5e-b0c9cca102fc@I-love.SAKURA.ne.jp>
 <dce0adb2-a592-44d8-b208-d939415b8d54@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <dce0adb2-a592-44d8-b208-d939415b8d54@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp
X-Virus-Status: clean

The inode mode loaded from corrupted disk can be invalid. Do like what
commit 0a9e74051313 ("isofs: Verify inode mode when loading from disk")
does.

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
This fix is similar to fixes for other filesystems, but got no response.
Do we have to wait for Ack from Dave Kleikamp for another month?

 fs/jfs/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index fcedeb514e14..21f3d029da7d 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -59,9 +59,15 @@ struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
 			 */
 			inode->i_link[inode->i_size] = '\0';
 		}
-	} else {
+	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		inode->i_op = &jfs_file_inode_operations;
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
+	} else {
+		printk(KERN_DEBUG "JFS: Invalid file type 0%04o for inode %lu.\n",
+		       inode->i_mode, inode->i_ino);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
 	}
 	unlock_new_inode(inode);
 	return inode;
-- 
2.51.0


