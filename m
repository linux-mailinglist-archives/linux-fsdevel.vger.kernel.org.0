Return-Path: <linux-fsdevel+bounces-37242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5DF9EFFC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9CC1887214
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2681DE8A9;
	Thu, 12 Dec 2024 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZj4/fwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539881B07AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044641; cv=none; b=VpCSYJiB0wYMJlQqTyHfCMzMkqxKfLnuoON6RskQktjWpgKgIjB8AS3cP++EagfiUk0HbZZLYs15LlUjkgKoY5+FIZiMC9zwFLLEX6Vfht8fzZ23cmOysJoqqBxUahv+oIoaqu5AIQX7wI5z/jkSo5tAChAPVXgbc9dKLz6DqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044641; c=relaxed/simple;
	bh=jkMKbLRTLoaucwliP/7pN/v0DVUIV8X0yAaVu+aF01E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=reOJ8FdyXkeKa5xxRS6SGdzrTRC22PQzx5Ol3AUfJNVx3b01dJYXo+Rd4CLJ0yGfY+qYWFcCnO00fFi9W+4ECsZMWJzBqteD8NGJrUpUNhn2JGg3JYxdbVgWr8+KlDKarkgzWA+rYKpy+gX3mijtdCSEBvZgFHMvSDKE3lCG4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZj4/fwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F20FC4CED3;
	Thu, 12 Dec 2024 23:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044640;
	bh=jkMKbLRTLoaucwliP/7pN/v0DVUIV8X0yAaVu+aF01E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tZj4/fwJB4iitJHdgFsr98ZbQGPViKur9uHXzLCAxA/yzTfryaoHPhQ2RWJo9Q2zQ
	 SxeM4QD4QgGUZYkwJIP4jao5ocB04QrfM1VicZSYlEbSqaq1YgCwa54Wjhv+35cYjk
	 p/mkKf18Gy4wvbuOEKOtskBc2S/J8hEW0QEqSdA4UDUZ7Mg3sLRRfmWq7MzMc54a1E
	 S/rMqPf91ZACzbl6of2l3Jw7x7YqqMuKZ/ne4chOTZoWpp0zVz6kNyJgY4oJnpkl7Z
	 0pohXEtgN3YvwGBCzrhIP/FfewaCllVsxRKeH5LqfGLlZtzjlGuyA1CUL7zbjKV54s
	 0lBHWBJGesnXQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 13 Dec 2024 00:03:41 +0100
Subject: [PATCH v3 02/10] fs: add mount namespace to rbtree late
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-work-mount-rbtree-lockless-v3-2-6e3cdaf9b280@kernel.org>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jkMKbLRTLoaucwliP/7pN/v0DVUIV8X0yAaVu+aF01E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHZ9+yMug5WmoyJTWjPMsiwTuwtfDzFXM/rS3FXscbV
 +22dY3uKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmAjLVIZ/NnU9XhoWP7fW5Qqe
 XuncO/Phxw5R/W97c0y1e9pmmO06wsjQWZMkov5Zhztuk6ar7s+8+psnFn5+q2H75Zx3YErVIxU
 mAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no point doing that under the namespace semaphore it just gives
the false impression that it protects the mount namespace rbtree and it
simply doesn't.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c3dbe6a7ab6b1c77c2693cc75941da89fa921048..10fa18dd66018fadfdc9d18c59a851eed7bd55ad 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3983,7 +3983,6 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		while (p->mnt.mnt_root != q->mnt.mnt_root)
 			p = next_mnt(skip_mnt_tree(p), old);
 	}
-	mnt_ns_tree_add(new_ns);
 	namespace_unlock();
 
 	if (rootmnt)
@@ -3991,6 +3990,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	if (pwdmnt)
 		mntput(pwdmnt);
 
+	mnt_ns_tree_add(new_ns);
 	return new_ns;
 }
 

-- 
2.45.2


