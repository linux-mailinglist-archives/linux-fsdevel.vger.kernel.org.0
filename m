Return-Path: <linux-fsdevel+bounces-68295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB6DC58E4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF533BB94D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C9E328B5F;
	Thu, 13 Nov 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cyo7puvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086223F294;
	Thu, 13 Nov 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051853; cv=none; b=WcybaRAkC13eBWHX/gEYHRUlBpkmuI5lKZ0JUSkwgmlYzlfBvSqzgWq0bCIEYDo8nJzPpFH1nLtNxr7SpXHtVBK/PcHKCl4BidD8msl3yUMlqP6UdpqC0eBU10AJxT9v8ta9juMcsgi8islrj5vk5bBppgnbiB6qVqGT1QbKWsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051853; c=relaxed/simple;
	bh=JQkkm7Inl7v7mfQ7uetkHJysie3VsUXDpKlDJW6ZVOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vDjU0VkQ/EXkVq7u7VUPcGf+twufZ6f/9ZKpdVpP3vTNnw6UV3g1tb7fu2FvjMU4/J5VBtJRPVY01xPtbosH/B5qF9xQC5B56yVznCju97azmYbTr+UbLode4V9u0TqJfQId38jNgcCO3kb2KBz6cN4uDteJsa0C/lAisZkOcXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cyo7puvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE0CC4CEF5;
	Thu, 13 Nov 2025 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051853;
	bh=JQkkm7Inl7v7mfQ7uetkHJysie3VsUXDpKlDJW6ZVOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cyo7puvsb3ukJ+lPPBJ4rtaNzeNxOyR57SMrhCpT1Pexy9SJ0JJ1mTG/wRYEEdKjo
	 VJjeFpZInDYEjAHqRN+0OCXjCzT/t+6bpWi2dD0tngy7scshUh6pCHKe2L+ME1MATw
	 O5qGX8nYi1VHNLNOeYptEqvJ6TPHyplxO64CzfzqUYMAQOzi8PIBbIaMfwab/EfLax
	 dF5iuL4xwZ8Ee+YY6xqs++yBGzqSnayNpclx0dJYrCmNY2YVfspyvZiLP/AGTX0YUn
	 tA33NZWa7koIhMaDr0+u+1JZsKPgeNen1cRTbfQE9jB6QqKFcO4NlGX4fh8CWkYBlU
	 xhF2vovSG5IAA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:07 +0100
Subject: [PATCH v2 02/42] ovl: port ovl_copy_up_flags() to cred guards
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-2-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JQkkm7Inl7v7mfQ7uetkHJysie3VsUXDpKlDJW6ZVOg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbrqvO/9Eij9/s0Flnt7XRyrHlz0O/LgCnv+U/NHK
 9Y1TODP6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI1zqG/64ezPrr/k3MZleQ
 KjDkSJxmefnP3wXbGB2nbpdQ2FPB6MTwP3xlfhBvV86m8gvXrqf5WzXcerVHgvWAifi6RzNdtKS
 PMgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/copy_up.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 604a82acd164..bb0231fc61fc 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1214,7 +1214,6 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 {
 	int err = 0;
-	const struct cred *old_cred;
 	bool disconnected = (dentry->d_flags & DCACHE_DISCONNECTED);
 
 	/*
@@ -1234,7 +1233,6 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
 	while (!err) {
 		struct dentry *next;
 		struct dentry *parent = NULL;
@@ -1254,12 +1252,12 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 			next = parent;
 		}
 
+		with_ovl_creds(dentry->d_sb)
 			err = ovl_copy_up_one(parent, next, flags);
 
 		dput(parent);
 		dput(next);
 	}
-	ovl_revert_creds(old_cred);
 
 	return err;
 }

-- 
2.47.3


