Return-Path: <linux-fsdevel+bounces-63433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1ABB8E0F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 15:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686AC189EDB4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A1D1DF256;
	Sat,  4 Oct 2025 13:34:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D52158538
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Oct 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759584873; cv=none; b=GCwy8QMQ5NNta4izCqkDippOaL/ndjjtggfSqwWccN51QwZ1e9q0Gq3yKaGF64Bftqh3wUlv9Wv5fqvLzigmeCwMlMlnSaE44fzIbK/m+6Gb56SIiwsoezCh5nFwijDtCJtbV+T5XzYgGrmWacW/aZ4lyaphmrv5hMrV/696uY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759584873; c=relaxed/simple;
	bh=25NCEQlhMqtDgUlIGOIzhvqkZsQ0PStYRPt7SjrnQnU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SLf4b0igH+eLorWYUNHnp+JMsZQ17P8eIKr0UcuGAVfxyA41UcpiIn0OhEth9ifQvGqfaLYTmR0vuo2GZme0od2QrKZuXBtyf7Zuq9e8NMd7F+YqXJdjqMIuw9xZpZ/5Z+W/YvJWGoyRSaOdvtaMvU5pjozzJeq2AVdZ0yJ7N+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 594DYJgj057488;
	Sat, 4 Oct 2025 22:34:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 594DYJT8057485
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 4 Oct 2025 22:34:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <10028383-1d85-402a-a390-3639e49a9b52@I-love.SAKURA.ne.jp>
Date: Sat, 4 Oct 2025 22:34:16 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] hfsplus: Verify inode mode when loading from disk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp

The inode mode loaded from corrupted disk can be invalid. Do like what
commit 0a9e74051313 ("isofs: Verify inode mode when loading from disk")
does.

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hfsplus/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index b51a411ecd23..53f653019904 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -558,9 +558,15 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 			inode->i_op = &page_symlink_inode_operations;
 			inode_nohighmem(inode);
 			inode->i_mapping->a_ops = &hfsplus_aops;
-		} else {
+		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+			   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 			init_special_inode(inode, inode->i_mode,
 					   be32_to_cpu(file->permissions.dev));
+		} else {
+			printk(KERN_DEBUG "hfsplus: Invalid file type 0%04o for inode %lu.\n",
+			       inode->i_mode, inode->i_ino);
+			res = -EIO;
+			goto out;
 		}
 		inode_set_atime_to_ts(inode, hfsp_mt2ut(file->access_date));
 		inode_set_mtime_to_ts(inode,
-- 
2.47.3

