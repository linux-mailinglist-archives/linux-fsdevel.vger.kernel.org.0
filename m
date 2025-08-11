Return-Path: <linux-fsdevel+bounces-57254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F13B1FF9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 08:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC58717B3F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 06:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A72D8782;
	Mon, 11 Aug 2025 06:50:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8F12D63E5;
	Mon, 11 Aug 2025 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895044; cv=none; b=CJvHGsamropZCC9Y4zRpX+xXgLTIX3GkNpdQnwy0tpuEXhRDPoivAoz/iD/z9DBRh0JFM6yXbNDqxMZkUVavIVlXk/+5Nvz+MGKqSWu4p+NLTnP+hwSp0R579oTyusPlw9vy52ByVX875SSPIcjizm+t9K+Cp35XO2HSmZoTJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895044; c=relaxed/simple;
	bh=VCyAlTuUnhXaDYpfNxL+t/XJTPx/5KAlsAChG7OYHR8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MVE3VlJC3MVJYWSUw0uEifDwbRBQdRhY5w52kyaB72ciS5D1gdkZI3DES8RjXoXW0jaMj2rmAYdHMd+ID+qkdY1X6LRAmaUFJH4ESA4jjzQtraZXskQ/YoMRkshWJa0byvI5KljZ6+gtxqbh03+rHDTU9gmlAwOCmxOxzAiX5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57B6oRqp035409;
	Mon, 11 Aug 2025 15:50:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57B6oRkP035405
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 11 Aug 2025 15:50:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ceaf4021-65cc-422e-9d0e-6afa18dd8276@I-love.SAKURA.ne.jp>
Date: Mon, 11 Aug 2025 15:50:28 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] vfs: show filesystem name at dump_inode()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

Commit 8b17e540969a ("vfs: add initial support for CONFIG_DEBUG_VFS") added
dump_inode(), but dump_inode() currently reports only raw pointer address.
Comment says that adding a proper inode dumping routine is a TODO.

However, syzkaller concurrently tests multiple filesystems, and several
filesystems started calling dump_inode() due to hitting VFS_BUG_ON_INODE()
added by commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
before a proper inode dumping routine is implemented.

Show filesystem name at dump_inode() so that we can find which filesystem
has passed an invalid mode to may_open() from syzkaller's crash reports.

Link: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 01ebdc40021e..8a60aec94245 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2914,7 +2914,7 @@ EXPORT_SYMBOL(mode_strip_sgid);
  */
 void dump_inode(struct inode *inode, const char *reason)
 {
-       pr_warn("%s encountered for inode %px", reason, inode);
+	pr_warn("%s encountered for inode %px (%s)\n", reason, inode, inode->i_sb->s_type->name);
 }
 
 EXPORT_SYMBOL(dump_inode);
-- 
2.50.1

