Return-Path: <linux-fsdevel+bounces-71046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA8CB298B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 10:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BB7730329D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FE1277011;
	Wed, 10 Dec 2025 09:46:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1114972602;
	Wed, 10 Dec 2025 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765359990; cv=none; b=WiT0UhQ95DsFkrnKeLo/BPYHYgqgJ2QN7GQwHCkF9tmN5SZeiRDng35jGVuVeffjou0UvDRZkQhqwW96hE/3WxYjzx42pCekjUxEesvOyBx8KUVdA7q/Rha4dcMC5DzaLd2i2Uv3s9KxOtIfPhv6wx+FCtjnKjQaMyKSOrKrk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765359990; c=relaxed/simple;
	bh=yyV6kHZpBnLDwvokLfhAByZkAywvKZmV/6cKL4Jla0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rxb8Ps+ce8LXPIggCCci1z5L3FcxLiDI/Zh916tK86OmcSABGpI7DYJ0tP0/f07ntU8tOCQSeMtH5E8vwCg2QInTPgEOTHowJX3ttSuODmojUZOYlE1CIFWqPgx4RZDzt9zpJEPQVvlMIRlz5JLMa2j4afg9q0jObTyQq9Ay53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BA9jRcj045018;
	Wed, 10 Dec 2025 18:45:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BA9jQGA045015
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 10 Dec 2025 18:45:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp>
Date: Wed, 10 Dec 2025 18:45:26 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH for 6.19-rc1] fs: preserve file type in make_bad_inode()
 unless invalid
To: Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>,
        brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark@fasheh.com, ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, Chuck Lever <chuck.lever@oracle.com>
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
 <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
 <20251204082156.GK1712166@ZenIV>
 <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is hitting VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode)) check
introduced by commit e631df89cd5d ("fs: speed up path lookup with cheaper
handling of MAY_EXEC"), for make_bad_inode() is blindly changing file type
to S_IFREG. Since make_bad_inode() might be called after an inode is fully
constructed, make_bad_inode() should not needlessly change file type.

Reported-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d222f4b7129379c3d5bc
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Should we implement all callbacks (except get_offset_ctx callback which is
currently used by only tmpfs which does not call make_bad_inode()) within
bad_inode_ops, for there might be a callback which is expected to be non-NULL
for !S_IFREG types? Implementing missing callbacks is good for eliminating
possibility of NULL function pointer call. Since VFS is using

    if (!inode->i_op->foo)
        return error;
    inode->i_op->foo();

pattern instead of

    pFoo = READ_ONCE(inode->i_op->foo)
    if (!pFoo)
        return error;
    pFoo();

pattern, suddenly replacing "one i_op with i_op->foo != NULL" with "another
i_op with i_op->foo == NULL" has possibility of NULL pointer function call
(e.g. https://lkml.kernel.org/r/18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp ).
If we implement missing callbacks, e.g. vfs_fileattr_get() will start
calling security_inode_file_getattr() on bad inode, but we can eliminate
possibility of inode->i_op->fileattr_get == NULL when make_bad_inode() is
called from security_inode_file_getattr() for some reason.

 fs/bad_inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 0ef9bcb744dd..ff6c2daecd1c 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -207,7 +207,19 @@ void make_bad_inode(struct inode *inode)
 {
 	remove_inode_hash(inode);
 
-	inode->i_mode = S_IFREG;
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+	case S_IFDIR:
+	case S_IFLNK:
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		inode->i_mode &= S_IFMT;
+		break;
+	default:
+		inode->i_mode = S_IFREG;
+	}
 	simple_inode_init_ts(inode);
 	inode->i_op = &bad_inode_ops;	
 	inode->i_opflags &= ~IOP_XATTR;
-- 
2.47.3



