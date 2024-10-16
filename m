Return-Path: <linux-fsdevel+bounces-32131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7A19A10ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 19:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7674A285B09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA65210C37;
	Wed, 16 Oct 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUb/mmYo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CAD18BC23;
	Wed, 16 Oct 2024 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100996; cv=none; b=MxD5RbLNc6dPr7EHnkfbaJNieLKyWAPLeDqLoXfcnFlvl94S+JUY+sVOffjwss8dn17IJxkU9LDKYJT0+IK58KJKRkawTbGPxa07BINAM/okXxNCE938jFAza/JPebpjq8jkcT+OEMNEv8Z5CMZ/WfehhDjaPMUKTdNOeSNSDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100996; c=relaxed/simple;
	bh=BYimcUhWbKXz9APz4douIFEmI3RMmXp3Pucc9V3D4+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8J6Xc96IXG23aBWX6sdWKi/WSA0qb13nDyTYRKBesRMwLyPNVrdFouYwD6uXhgChW8pDqLoHsq5xV2sgzbsCNrxPFfIrwggIEgANSL5wMo6D7fnUCVoIQ+akSyu+XUBblu5P3sO/j31wlGs3e7AjCJdLA4MwyqdN1w8S+eTl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUb/mmYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB5CC4CECE;
	Wed, 16 Oct 2024 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729100995;
	bh=BYimcUhWbKXz9APz4douIFEmI3RMmXp3Pucc9V3D4+g=;
	h=From:To:Cc:Subject:Date:From;
	b=UUb/mmYot/mVtseLROoMEXoIw67Sqc8AI34Kjmus8LuPfHJRmkCu32TxJndYe6MeF
	 iwKxy3oAHrrKP79SfQBiONa0Vzcf/Q2YAHtYjnENF+g92aBUdNsozOTJXYfGQQsa1c
	 vki3LzQ3/pa1JKzyyvedE9TV2hCfTWmNlkGLmom1361uKweiI1bNmnHICZENM+54EP
	 wNu3vnv7bhpIy3sa091QBdNF9GtxGHsqA/DCc/nrdDbkTEXa67rTkibUo0F4sDiqeC
	 dzVr2cEDLHRUyJhq7B7+qs3aa2ywDScf7H7luQEsu32RnHObKrLDg4xPjGXG6zyoIj
	 UiP8t6ldrTN8A==
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Brad Spengler <spender@grsecurity.net>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs: don't try and remove empty rbtree node
Date: Wed, 16 Oct 2024 19:49:48 +0200
Message-ID: <20241016-adapter-seilwinde-83c508a7bde1@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=brauner@kernel.org; h=from:subject:message-id; bh=BYimcUhWbKXz9APz4douIFEmI3RMmXp3Pucc9V3D4+g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTz/9mzSsMrUso6WEEoLfvu+pYpwbfqjxyMrm6IZfqzy +5I+R3RjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInwdjH8r9yoYjapenc766rr r49kbjBZFPBowgvXgh2ZDyR+xUcnTmX4p1BtwVLyNXjhydvMCef3Hjz2ImHFtnfM6ybsLSt/6fb iEgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

When copying a namespace we won't have added the new copy into the
namespace rbtree until after the copy succeeded. Calling free_mnt_ns()
will try to remove the copy from the rbtree which is invalid. Simply
free the namespace skeleton directly.

Fixes: 1901c92497bd ("fs: keep an index of current mount namespaces")
Cc: stable@vger.kernel.org # v6.11+
Reported-by: Brad Spengler <spender@grsecurity.net>
Tested-by: Brad Spengler <spender@grsecurity.net>
Suggested-by: Brad Spengler <spender@grsecurity.net>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
In vfs.fixes unless I hear objections.
---
 fs/namespace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 93c377816d75..d26f5e6d2ca3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3944,7 +3944,9 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		namespace_unlock();
-		free_mnt_ns(new_ns);
+		ns_free_inum(&new_ns->ns);
+		dec_mnt_namespaces(new_ns->ucounts);
+		mnt_ns_release(new_ns);
 		return ERR_CAST(new);
 	}
 	if (user_ns != ns->user_ns) {
-- 
2.45.2


