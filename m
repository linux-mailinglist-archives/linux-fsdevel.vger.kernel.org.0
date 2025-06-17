Return-Path: <linux-fsdevel+bounces-51936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6736ADD2FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204D7402216
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0292ED865;
	Tue, 17 Jun 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JumJ1Xns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C228E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175132; cv=none; b=d04uSgFMET8dzoDygZ/xJMHnkjn2kjNyxqpN2EWesf6lTR4cnRKGupSlehzqxGY2qW6ncAp1W8+n/gUbVDDk84TE7Q7ARpvHL5ATXsfCcP1a4MnyiyUc8Oci6shdJi6vI6TQs2LBJziPfTU4t1XEIzz/eL0wmkCvwC6YAxJgDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175132; c=relaxed/simple;
	bh=TzgQ817oPideW0OGeNJ7vQIt1tyMrwmwsKZLNhBpMZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJtL2quGzCCGWh/4MFP+1siuNL+WyHEavnnJbhzxVi9z4UpzsDI6QMecbchxtgoRfsBWR05bfHMj/IWRvNB6MZt01z6dfrBodJRnlCf8r3JWlDzUkBBUSTzP181FCEkaGldyFAVSibmK4cmZkFMdOXNgzQKtCMyGfN+pnk/+YBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JumJ1Xns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD68BC4CEE3;
	Tue, 17 Jun 2025 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750175132;
	bh=TzgQ817oPideW0OGeNJ7vQIt1tyMrwmwsKZLNhBpMZk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JumJ1XnsmUd9TsSMZiPs+buLS3csI9s00wRQ9V14PbFxFWtgoMjVjBp2xb55ViH1w
	 307rXgg5YngUk7qQzmm+ogeXcHg4ZY6b8/18al2LDBc1gCcLF/JW+R75+tfa7E7F5w
	 xRVlEjDWrk5Tj+6BR0VFrkfEQ30fzMk3vH/0I6f+r9L1KYFYNgGWj+IEn+9L0ehj+5
	 ld+AWbcVbMdVcOjNSsA08lwB3tnFQ3l8+KUm6EeK5b7CLaoWXnSqMPGx92hLACWXaA
	 qyPRRRepo192gF7DZPOaMfx+y/qktwMZdTXOkDl35zp1rp2Mgs2FLuGVVeVfIQjXEs
	 BevBVxCADKAGg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Jun 2025 17:45:13 +0200
Subject: [PATCH RFC 3/7] pidfs: raise SB_I_NODEV and SB_I_NOEXEC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-work-pidfs-xattr-v1-3-d9466a20da2e@kernel.org>
References: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=858; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TzgQ817oPideW0OGeNJ7vQIt1tyMrwmwsKZLNhBpMZk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9k7kDTt7OzPzaLhOKJvnYbNpKa1Kd0UPHa4sYm1h+
 VzTkLSro5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIGFYwMj5hF3K2FTF8cmM38
 9Yz4lm+SAUztR149+rQ45Mj37ecZORj+ZynsmWQ4SZBZ4XBMY8DlxzMW8p88butVfcztYKzLrYO
 b+QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Similar to commit 1ed95281c0c7 ("anon_inode: raise SB_I_NODEV and SB_I_NOEXEC"):
it shouldn't be possible to execute pidfds via
execveat(fd_anon_inode, "", NULL, NULL, AT_EMPTY_PATH)
so raise SB_I_NOEXEC so that no one gets any creative ideas.

Also raise SB_I_NODEV as we don't expect or support any devices on pidfs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index ca217bfe6e40..1343bfc60e3f 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -959,6 +959,8 @@ static int pidfs_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 
+	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= SB_I_NODEV;
 	ctx->ops = &pidfs_sops;
 	ctx->eops = &pidfs_export_operations;
 	ctx->dops = &pidfs_dentry_operations;

-- 
2.47.2


