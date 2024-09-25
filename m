Return-Path: <linux-fsdevel+bounces-30066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD8985982
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 13:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440491F223EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 11:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62AC1A2C16;
	Wed, 25 Sep 2024 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny0ThQfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1471A2876;
	Wed, 25 Sep 2024 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264357; cv=none; b=DogMXocR346GFQ74gnLLWuOo1YvreuFKpMncMvCvMiVM/0eiGB4H9vPuWuo4eN7aK5pQHlLEFPljSysYrSSh6jjzE6Y2jqbGB+tZPBPxXxClepFYEccnEWTn8LAVqPHA1TTVvwVrYPdbQb+Ll1U1tG3E/JpJ3WJowcIsDkyU3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264357; c=relaxed/simple;
	bh=aZy31E4vt0NxJ85lQDoHOYZXKA0PmkZnB3TAgogm9WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah4cZOWq5orypswiGlvVai9+8WmnBLEd70HWxyvuEw29MWUK2/TVbOuzHw9Oqn8IH5AHQhz3EMIS0fw5IevzjzgBCvZUN1dl1HLHeayXD5aMcZ9BpN/MLbGOS/rUDoxEi1h1F8a0HemLJ0oclrXrB0VXlzHuuxI08L3ieABZGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny0ThQfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1508DC4CEC3;
	Wed, 25 Sep 2024 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264357;
	bh=aZy31E4vt0NxJ85lQDoHOYZXKA0PmkZnB3TAgogm9WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ny0ThQfhPmMBJ4NIrUImZ+ydtEUVxIk3XqmrKJoiK/IMzVC6FMJCeFEMwBo6VqWTb
	 YnfyaGdXMUve2SuLZWidvPlA18Ntk/hViF+Kt/2ar3/crprPW4t4FuARBHLISGyhUo
	 wLR2akEiU6tboSDxoeinWZRvBBT+uGaFq1XW+qemLdXXhqQenKJ3KFLdjZIl2PkHQL
	 a34ojEkxv6Pl5JNtpugd5n7zl5Jo1uX2eHO+5q478+8N3mpuVYOo7eAfRNi6urB9Vu
	 VhK98Nz/Hb6+Dngxr8Hx4qYez65gZqyyIxw4jXMvM2sAnTmU7WTi1AUuh8i1hlSLR5
	 WnclYKsWHzWmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 065/244] vfs: use RCU in ilookup
Date: Wed, 25 Sep 2024 07:24:46 -0400
Message-ID: <20240925113641.1297102-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Mateusz Guzik <mjguzik@gmail.com>

[ Upstream commit 122381a46954ad592ee93d7da2bef5074b396247 ]

A soft lockup in ilookup was reported when stress-testing a 512-way
system [1] (see [2] for full context) and it was verified that not
taking the lock shifts issues back to mm.

[1] https://lore.kernel.org/linux-mm/56865e57-c250-44da-9713-cf1404595bcc@amd.com/
[2] https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Link: https://lore.kernel.org/r/20240715071324.265879-1-mjguzik@gmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d1a098e7d4087..a2af540102d7a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1574,9 +1574,7 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
 again:
-	spin_lock(&inode_hash_lock);
-	inode = find_inode_fast(sb, head, ino, true);
-	spin_unlock(&inode_hash_lock);
+	inode = find_inode_fast(sb, head, ino, false);
 
 	if (inode) {
 		if (IS_ERR(inode))
-- 
2.43.0


