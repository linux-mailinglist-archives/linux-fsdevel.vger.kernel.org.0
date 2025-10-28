Return-Path: <linux-fsdevel+bounces-65881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F47C13975
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AD4F4EB2B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058392D97AA;
	Tue, 28 Oct 2025 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugptnf0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1652D8DDF;
	Tue, 28 Oct 2025 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641164; cv=none; b=s2I6dG32rNn0SO9jjaoz0GtnDkIbEQ5bZeHYHJWPGwsvDwDwJ49OaEfOO4be8Oqmy3PjhV/IGqrEDbpHehWVXcVlBkRflMNMQzMeyOgEIGT4C1YC11Hdz6sAiEIfvnRZtkBV9OCUxTamA7ngDG3kBEl2WrubBh16P01UyBNCMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641164; c=relaxed/simple;
	bh=iCVEjflOE4r84IPd8NVIEeGZIqP+XdFrXHNnZM49L+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFildR+Bx5US/WpC0iGiW6rRGvgQGHznc3t5A9vkNGuFsM+bAxTPuu+O2+lx0Fcgd2CAgEROwRljxsdQgZgaRZHxQVU/5Vv4qGl9ab2x6cqcZPTPPotVD+VpLiu+RzAEqTIQc+VZqKZC2TOZfalaVNTtRCch1rO4uKU6rzCNfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugptnf0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB76C4CEFF;
	Tue, 28 Oct 2025 08:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641163;
	bh=iCVEjflOE4r84IPd8NVIEeGZIqP+XdFrXHNnZM49L+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ugptnf0tSHJEUrKUliV4GGWQz6fHj/ybnNqPXoad0oDYPVyWmQerbnbwr5ef/vrQ7
	 SYAWC+IO2N/6ENvLAKRuo3+iT4sse5f66asP0I+r1Gs9HDK8URON5W0GvSnBeRBY+4
	 dnJi24b1OhphzMSB2ZBhThL14Eyxt3te2aP2dWvqAsH6nVDmyvReU/l9fxKDGPSxMV
	 jtjkhT5AOklZWmpCE3VGFTAoUwMN6/5Wb30VfDHJOKp6GC1CcpDgoPPkfJSeZS+8rJ
	 exybIP/Q++/ttcCSpQ2/AdGVcXTTG0hdRsV1USgXbimFw7s3ngwo5mm+mIElJjZPpa
	 6Fy6FriStOmpw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:46 +0100
Subject: [PATCH 01/22] pidfs: use guard() for task_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-1-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=787; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iCVEjflOE4r84IPd8NVIEeGZIqP+XdFrXHNnZM49L+Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB2c4NiXnaRaN3lJxAePfRkHNNQFv8dbXetONkz5t
 vaKkt3ljlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYZjMyPGa/+o9X3Oiq69yN
 lg3bqzh2qIZuL1ks/5ud2ffyCv8TNxgZLizTPzSrOe5OvVSdg773u/zt6VZtL6qCpiVkrswPdCr
 hAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use a guard().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 0ef5b47d796a..c2f0b7091cd7 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -356,13 +356,12 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		return -ESRCH;
 
 	if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask)) {
-		task_lock(task);
+		guard(task_lock)(task);
 		if (task->mm) {
 			unsigned long flags = __mm_flags_get_dumpable(task->mm);
 
 			kinfo.coredump_mask = pidfs_coredump_mask(flags);
 		}
-		task_unlock(task);
 	}
 
 	/* Unconditionally return identifiers and credentials, the rest only on request */

-- 
2.47.3


