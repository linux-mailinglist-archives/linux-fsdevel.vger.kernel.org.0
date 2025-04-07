Return-Path: <linux-fsdevel+bounces-45851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60B0A7DA62
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD06188DDF3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DEC234972;
	Mon,  7 Apr 2025 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy0DgunI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF0233D91;
	Mon,  7 Apr 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019690; cv=none; b=oEgNCfYF4fXo0UZnA/fw4GikT0eX6cOL5RaMjeXiPZJF0yhEzVXxFmKCnT9PIgbNHNE5Cnt/HyA4WXYF2PQyzVvcXYPwegr0e385dIDkJeXqky9tDVixiBWr8OP+KyatFwUmnsqmytrzi0pOGMFgU/m0wNGnYrwg+p+wsz1LkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019690; c=relaxed/simple;
	bh=IMyaaRhNbHINxvRwQWTPO6x2oZELjyNpk11Fp2LW0F0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFHNXv5u8u+OTSuu+IeFw72DTC1SVcYSUZ7e/NybbXypbPGHXA3GHJ+2CvVZ95FPmpXoEEYndl1yYWa6HVViLwG+HMkZTBU204P3patHtmmZxpEaULL4Ra6Qm5KQU7Zz7CxmC0SWKxSU+CUraUxCsnMhKu/3ROJYq33jxuN1rws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy0DgunI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35383C4CEED;
	Mon,  7 Apr 2025 09:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744019690;
	bh=IMyaaRhNbHINxvRwQWTPO6x2oZELjyNpk11Fp2LW0F0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vy0DgunIxgQg/V9RNVlUSd9buorfK7Z17FoPGcnAkfxnN8fOppzB9HtEvdTf8od/a
	 0E6AsYIxzvsiUonemaAd54PRjM0ZryLtEIBPYt3pWinq5zEs1UlQHeowY7VMkoqvyO
	 BK0z9IUF8RR3/b6hsoWu15vhTVzfGjqHvHNi5wE5fT4KSzVNUQAw2KMGX6NLJ9AFvl
	 /hrnig2GErGO2IZhXWSMoFNjJ8nXFVq3qflR/I46MVSQbM3/IUYDkeijE9j4TQCkXp
	 aw0wjpmUKTASwZf2Zy+ZM85c7IeeA1Ji8xZ1vSDSMoOqzYIzrX5wJCNbvecNyVuF/F
	 lDSwPKA1Mkgvg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Apr 2025 11:54:19 +0200
Subject: [PATCH 5/9] anon_inode: raise SB_I_NODEV and SB_I_NOEXEC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-work-anon_inode-v1-5-53a44c20d44e@kernel.org>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
In-Reply-To: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
 Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IMyaaRhNbHINxvRwQWTPO6x2oZELjyNpk11Fp2LW0F0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/XnDdWJNNOeTJx7afsb1RHw3vqVx937U51rOFeX2Dw
 5b+g35rO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSs4+R4aVZ1cFPz+9LfO2a
 oX41vCZkye997RH3OhZ/utPXsnbTu4kM/0u3fuk3ZVDQu1o82zRoL2/iY2/3h9UhTLdFKk5rNS1
 8ygsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It isn't possible to execute anoymous inodes because they cannot be
opened in any way after they have been created. This includes execution:

execveat(fd_anon_inode, "", NULL, NULL, AT_EMPTY_PATH)

Anonymous inodes have inode->f_op set to no_open_fops which sets
no_open() which returns ENXIO. That means any call to do_dentry_open()
which is the endpoint of the do_open_execat() will fail. There's no
chance to execute an anonymous inode. Unless a given subsystem overrides
it ofc.

Howerver, we should still harden this and raise SB_I_NODEV and
SB_I_NOEXEC on the superblock itself so that no one gets any creative
ideas.

Cc: <stable@vger.kernel.org> # all LTS kernels
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/anon_inodes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index cb51a90bece0..e51e7d88980a 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -86,6 +86,8 @@ static int anon_inodefs_init_fs_context(struct fs_context *fc)
 	struct pseudo_fs_context *ctx = init_pseudo(fc, ANON_INODE_FS_MAGIC);
 	if (!ctx)
 		return -ENOMEM;
+	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= SB_I_NODEV;
 	ctx->dops = &anon_inodefs_dentry_operations;
 	return 0;
 }

-- 
2.47.2


