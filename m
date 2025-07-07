Return-Path: <linux-fsdevel+bounces-54095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA11AAFB2F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4AAD7AB863
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95429A9F9;
	Mon,  7 Jul 2025 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh7IAwWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F6191F98;
	Mon,  7 Jul 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890281; cv=none; b=uVdjFVbFcYp4vDxr2Qw7K1jxjztqzZ9H5Yfa/d2jM2e9e5MUuKtGYwuVtI0WPy1OQ8JbZc/QKYL4O5ErmPuVhSHPKr3PIqKph29rO2Un2xv/+5MtMzXxqmcCSYzwDKXoJQDz7Nbt8XxWwZNXWW0VkoXZPo6GTy2VBaq73gQTIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890281; c=relaxed/simple;
	bh=lsOOAuuRgZ/1Zzl7Ct4Beit7aJDhP4JEWVq3p+KA7Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFTez1tvD7tFjOhwBtlQAPzHbRANTcyR28r3wxx32DETcp7Ts/hVEh6gKy9YHF+f6rPNMjqvOhQBfK97DgFW41DMcLkTvrl2DfKe3kT35/p5vkjxaEoAAqtPadP6PcqHOJVhIaOtNej8pm4vw0Dm7tZAfte4DR25VU8Mn9SdtjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh7IAwWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F501C4CEE3;
	Mon,  7 Jul 2025 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751890279;
	bh=lsOOAuuRgZ/1Zzl7Ct4Beit7aJDhP4JEWVq3p+KA7Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fh7IAwWX1P1aRJwFRstlL5TOl/YffRTqJiZzXvfxxkBVJ0HUfoukIPaGfkacuKWXD
	 l5Yx977l7ZMpVXJ0JFCBoIbNdvWtXdb2PhAHNLkJcwneqF96LDgg6HR2KTb+yhL+aF
	 QGkHR+3xURsZSg+KUcy8Vt5PNfqsyafhV1BrzWEv8c/NP1zKZuyfQljaGlfPEtz4yW
	 esZnTQZR9T13+Z03HGVsrdutUp67/vOqOGPwHj8+OFi7C/m0HO4a+UBsM6cVGuC2zg
	 0dRfjkXMAtnisVSr2ojBvOIcA/xjj1cRJOYG/HayJLfuG98ZZSlzgpbQ83npqp+/T/
	 H2qnEfTRGutMQ==
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	syzbot <syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com>,
	jack@suse.cz,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH] secretmem: use SB_I_NOEXEC
Date: Mon,  7 Jul 2025 14:10:36 +0200
Message-ID: <20250707-heimlaufen-hebamme-d6164bdc5f30@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707-tusche-umlaufen-6e96566552d6@brauner>
References: <20250707-tusche-umlaufen-6e96566552d6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3574; i=brauner@kernel.org; h=from:subject:message-id; bh=lsOOAuuRgZ/1Zzl7Ct4Beit7aJDhP4JEWVq3p+KA7Zs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRk70xYtmldZunchaYLPrbOkih51bM1OMJe7n69e1pio 7XUDoW6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInkyTL8FVyw5e21iOSTEjV5 647nzf05eZv64aYpTyN1FKt9WSbfncjI8HTtrS07NoSqVsV1SzinfIxf8SFlptY2v/qvQZpnVlo IMgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Anonymous inodes may never ever be exectuable and the only way to
enforce this is to raise SB_I_NOEXEC on the superblock which can never
be unset. I've made the exec code yell at anyone who does not abide by
this rule.

For good measure also kill any pretense that device nodes are supported
on the secretmem filesystem.

> WARNING: fs/exec.c:119 at path_noexec+0x1af/0x200 fs/exec.c:118, CPU#1: syz-executor260/5835
> Modules linked in:
> CPU: 1 UID: 0 PID: 5835 Comm: syz-executor260 Not tainted 6.16.0-rc4-next-20250703-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> RIP: 0010:path_noexec+0x1af/0x200 fs/exec.c:118
> Code: 02 31 ff 48 89 de e8 f0 b1 89 ff d1 eb eb 07 e8 07 ad 89 ff b3 01 89 d8 5b 41 5e 41 5f 5d c3 cc cc cc cc cc e8 f2 ac 89 ff 90 <0f> 0b 90 e9 48 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c a6
> RSP: 0018:ffffc90003eefbd8 EFLAGS: 00010293
> RAX: ffffffff8235f22e RBX: ffff888072be0940 RCX: ffff88807763bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000080000 R08: ffff88807763bc00 R09: 0000000000000003
> R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000011
> R13: 1ffff920007ddf90 R14: 0000000000000000 R15: dffffc0000000000
> FS:  000055556832d380(0000) GS:ffff888125d1e000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f21e34810d0 CR3: 00000000718a8000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  do_mmap+0xa43/0x10d0 mm/mmap.c:472
>  vm_mmap_pgoff+0x31b/0x4c0 mm/util.c:579
>  ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:607
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f21e340a9f9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd23ca3468 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f21e340a9f9
> RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000200000ff9000
> RBP: 00007f21e347d5f0 R08: 0000000000000003 R09: 0000000000000000
> R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000001
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001

Link: https://lore.kernel.org/686ba948.a00a0220.c7b3.0080.GAE@google.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 mm/secretmem.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 9a11a38a6770..e042a4a0bc0c 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -261,7 +261,15 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 
 static int secretmem_init_fs_context(struct fs_context *fc)
 {
-	return init_pseudo(fc, SECRETMEM_MAGIC) ? 0 : -ENOMEM;
+	struct pseudo_fs_context *ctx;
+
+	ctx = init_pseudo(fc, SECRETMEM_MAGIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= SB_I_NODEV;
+	return 0;
 }
 
 static struct file_system_type secretmem_fs = {
@@ -279,9 +287,6 @@ static int __init secretmem_init(void)
 	if (IS_ERR(secretmem_mnt))
 		return PTR_ERR(secretmem_mnt);
 
-	/* prevent secretmem mappings from ever getting PROT_EXEC */
-	secretmem_mnt->mnt_flags |= MNT_NOEXEC;
-
 	return 0;
 }
 fs_initcall(secretmem_init);
-- 
2.47.2


