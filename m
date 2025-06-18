Return-Path: <linux-fsdevel+bounces-52128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B88AADF820
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B721217EBBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85721E08D;
	Wed, 18 Jun 2025 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gox1IiI7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0095C21CC61
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280057; cv=none; b=YcHmFCJAHYJoWXnP1svKiXWUB0NIbFDSC4xvlR6bR04Rv18wNq+xDVa42irO0WnQM2SKozvNg8Iv6TUyCd/5FeCVCAIqFJiQnSv/G6+CDmEtzTeffpp63B/2GKpV1ek/rRfZrs3OKSlLAUuSw8Yh0AupfGwWBHrAQ7qiPDoB4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280057; c=relaxed/simple;
	bh=eyeaNphj3UmWvhUTi6Wh0SqVe76es4UtUPu+fdmNl+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEw+mb+fmUf2H6RlNvuefNfJC/WnvxfFGpipFXUDtyFw3+cfMu3XZIrf1JSJeEPLCIGix+YYpjV4ZPISudrrLJU6jqSZsL8jvbncOOxLVYSWOTRvHW6kqDCFtW1wtCcdvxcGNY+8DwMFc5/CJdb6lVc2nX/wgcCU8R3V91jtFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gox1IiI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FB4C4CEEF;
	Wed, 18 Jun 2025 20:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280056;
	bh=eyeaNphj3UmWvhUTi6Wh0SqVe76es4UtUPu+fdmNl+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gox1IiI7w1/Ohw3TTmDj5eIE3fxn9DXa6+iLdcv7gr8dXTIgqE0g1Qz8mfydDcnsL
	 x6kafwoAqHkh5ZGd99hQD04vlQ/j/Mwlp+Elvipd5NWz2vbN7XqMBqbytShur5G3lD
	 YxOpp8aE1YFr1clLtCFijgHaTgTV04+sRv8jurv38GcSMkhFu3YgsC/1kaNLLVG2kC
	 4pjfkWIsi9xdDJLu0en4auYZQd1QiZjoQOLCT0kun2xjHc5E7KIeB1MB0Y00ptJfyO
	 rRQMVR6nJhgsUSm+y2OpcZCGx+Bac7OlOMnGIyGC9eHt8TN7LFs/QnqXJoVqX8IUjk
	 MpbH5c/5mS0Jw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:45 +0200
Subject: [PATCH v2 11/16] pidfs: make inodes mutable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-11-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=690; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eyeaNphj3UmWvhUTi6Wh0SqVe76es4UtUPu+fdmNl+s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0f+3vtagmFS4KxZ2s7KfI9eLg19cqz8hPM/7Schj
 ZUiATN+dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykcBUjw+1TgiccF2R+2tHD
 NvHbqWir7G0z/ngZ8hY2hL7dWLvQaiIjw95jV5yjWCen3XXd+fXvG9P7H3yd1++erPdO4OWrJ5f
 W3GMHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Prepare for allowing extended attributes to be set on pidfd inodes by
allowing them to be mutable.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index ec375692a710..df5bc69ea1c0 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -827,6 +827,8 @@ static int pidfs_init_inode(struct inode *inode, void *data)
 
 	inode->i_private = data;
 	inode->i_flags |= S_PRIVATE | S_ANON_INODE;
+	/* We allow to set xattrs. */
+	inode->i_flags &= ~S_IMMUTABLE;
 	inode->i_mode |= S_IRWXU;
 	inode->i_op = &pidfs_inode_operations;
 	inode->i_fop = &pidfs_file_operations;

-- 
2.47.2


