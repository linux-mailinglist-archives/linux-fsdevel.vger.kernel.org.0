Return-Path: <linux-fsdevel+bounces-45846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C36ACA7DA73
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C63E16E8A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729DE231A2B;
	Mon,  7 Apr 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qArOxwDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAA823098D;
	Mon,  7 Apr 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019675; cv=none; b=nLdf9pHQuWH1YXr85YM7jB1fMJBUsKzOSHEavSm3uqe977Is+Rsa1PhCB73ZhGQBKtwno2Zz5OE6YwCD8R4XoRbpQ2Y53aNwL8W5jicrrak/jaCv/cc5wRBFh9WzkkGiiSyI6gMAWRTXPyicmlXeK28nXK2qKt/+CBmrnNRMMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019675; c=relaxed/simple;
	bh=W1GQjaNtsMtwRDBCK9P9pv77FM0gjd/w8nwBlGfuh2o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sAjXf7mcIKUQN8gMhs5/XYATfMzo1mG0lYQVOFzOpyK53Bxwb75UiX6EeKb9n8JOkHsmv6HVZN0xTHyaCq/HFqW1Sqj3s3ox3Jm0ZIGENoOfoIZ67J8X8J+DQoti/mi58vBmGiAgTw2UQ122K58YGDn/xM1BjV0UhJzQaIf8pFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qArOxwDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1210AC4CEDD;
	Mon,  7 Apr 2025 09:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744019674;
	bh=W1GQjaNtsMtwRDBCK9P9pv77FM0gjd/w8nwBlGfuh2o=;
	h=From:Subject:Date:To:Cc:From;
	b=qArOxwDlOXBur9XIDOl7H9lqhnLsauoGdjp8+bDfDamKpVPpYIDg9mtVjbJEsqH/F
	 MpmRdkmZ7Klhy/LFBN5O+jIkrhHd5uOo1P7RopQH8PXip/QZh9Xe5x7Ev+gsSpnHA6
	 Bfz4xTdI2fsWQhS76Lp2hpbItpaceNHnPK9jR03WMiwdbMyXTOpcDtJg9S73VOONkB
	 dBe5Rhe/6/IZuQCtl/Wcb8XDF721NNp43GQ4BPF5UvzfVfmgvkh+nMZ1sdUv1HprJN
	 33bL64gs2VdYBb5pRclE2F1hEC1ocBA3GsHK1fRBOeTfGiI8LmvFxLWujkSiZ4UBpE
	 lSakzi9Bw4H3w==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/9] fs: harden anon inodes
Date: Mon, 07 Apr 2025 11:54:14 +0200
Message-Id: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMeg82cC/x3M0QrCMAxA0V8ZeTajLZtj/ooMSbvogphKKlMY+
 3erj+fh3g0Km3CBU7OB8SpFslb4QwNpIb0xylwNwYXedW7Ad7Y7kma9iOaZkUOI0dPQjWOAWj2
 Nr/L5H89TdaTCGI00Lb/Pg8qLrV2Pre/Rkod9/wLqUA/6hAAAAA==
X-Change-ID: 20250407-work-anon_inode-e22bb1a74992
To: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
 Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2120; i=brauner@kernel.org;
 h=from:subject:message-id; bh=W1GQjaNtsMtwRDBCK9P9pv77FM0gjd/w8nwBlGfuh2o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/XnDdbu/iFRPqI5t5fm/Tfdel6rQ1/UToZ2On/SsvC
 N+7cLHbq6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiOjMY/hcVslgIaRo+NCyK
 +DdJifF2xtro9qmNHEpC/Zm+DbO2FTH8017q/XjnpRc6ya9XblnuKKReZLZv+4Qf7+u55bgD78T
 aMwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

* Anonymous inodes currently don't come with a proper mode causing
  issues in the kernel when we want to add useful VFS debug assert. Fix
  that by giving them a proper mode and masking it off when we report it
  to userspace which relies on them not having any mode.

* Anonymous inodes currently allow to change inode attributes because
  the VFS falls back to simple_setattr() if i_op->setattr isn't
  implemented. This means the ownership and mode for every single user
  of anon_inode_inode can be changed. Block that as it's either useless
  or actively harmful. If specific ownership is needed the respective
  subsystem should allocate anonymous inodes from their own private
  superblock.

* Port pidfs to the new anon_inode_{g,s}etattr() helpers.

* Add proper tests for anonymous inode behavior.

The anonymous inode specific fixes should ideally be backported to all
LTS kernels.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (9):
      anon_inode: use a proper mode internally
      pidfs: use anon_inode_getattr()
      anon_inode: explicitly block ->setattr()
      pidfs: use anon_inode_setattr()
      anon_inode: raise SB_I_NODEV and SB_I_NOEXEC
      selftests/filesystems: add first test for anonymous inodes
      selftests/filesystems: add second test for anonymous inodes
      selftests/filesystems: add third test for anonymous inodes
      selftests/filesystems: add fourth test for anonymous inodes

 fs/anon_inodes.c                                   | 45 ++++++++++++++
 fs/internal.h                                      |  5 ++
 fs/libfs.c                                         |  2 +-
 fs/pidfs.c                                         | 26 +-------
 tools/testing/selftests/filesystems/.gitignore     |  1 +
 tools/testing/selftests/filesystems/Makefile       |  2 +-
 .../selftests/filesystems/anon_inode_test.c        | 69 ++++++++++++++++++++++
 7 files changed, 124 insertions(+), 26 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250407-work-anon_inode-e22bb1a74992


