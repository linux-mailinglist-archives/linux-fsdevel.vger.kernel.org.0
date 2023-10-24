Return-Path: <linux-fsdevel+bounces-1034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F907D50F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F12E1C20D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2C29413;
	Tue, 24 Oct 2023 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSHHBKlP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF8229410
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EEAC433C7;
	Tue, 24 Oct 2023 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698152782;
	bh=A2F7xcCPQijS5nHDzQ+tLk6QIWnmUFSEgNKGFeyRhaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NSHHBKlPJsDEt4IatYffF/lhq0ZUKai75TiZICyt5hQAgaCBasobzvagHul6pNUgD
	 t8d4+uQbpbvxV61uX6rL6pMReq7zD1ikx19xPonZdSy/gil/x27VCDesZ3Z9Dn+r9c
	 Vi8ZVakQH+/URWW0KopDfDaWWl2UX7MInKixsMZXyZIFQ5gYA2HZFadUVL5Iujk8ji
	 Z/PL+AJvyOQFCTKgKxhsFhxuzs43rxCB8UNv+xbtDux+jOB8oz69u16Ys3gDY2/4VE
	 LROf5/QrqH884gfhPJPypL9GW5nxsYDHIIWELMcE+2Q1CRcI3/EDwb8/JjrC6JPfYB
	 bn6TDnk0Tf+jQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 15:01:13 +0200
Subject: [PATCH v2 07/10] super: remove bd_fsfreeze_sb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-freeze-v2-7-599c19f4faac@kernel.org>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
In-Reply-To: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=brauner@kernel.org;
 h=from:subject:message-id; bh=A2F7xcCPQijS5nHDzQ+tLk6QIWnmUFSEgNKGFeyRhaw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSaH3S87XLkbrS4YXrRq137n2x7uzns4iohwQnzA/u3nrCw
 WLiktqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiQiKMDA9vP7NIZImsKXELnWhxPC
 phQdylTu/FBb7q81KkTP/V7Gf4Z3/UctHJLWXPbumV5Lj3n5JsuiA6SzFX/WOD+LLrWQKr2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Remove bd_fsfreeze_sb as it's now unused and can be removed. Also move
bd_fsfreeze_count down to not have it weirdly placed in the middle of
the holder fields.

Link: https://lore.kernel.org/r/20230927-vfs-super-freeze-v1-5-ecc36d9ab4d9@kernel.org
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/blk_types.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 88e1848b0869..749203277fee 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -56,14 +56,11 @@ struct block_device {
 	void *			bd_holder;
 	const struct blk_holder_ops *bd_holder_ops;
 	struct mutex		bd_holder_lock;
-	/* The counter of freeze processes */
-	atomic_t		bd_fsfreeze_count;
 	int			bd_holders;
 	struct kobject		*bd_holder_dir;
 
-	/* Mutex for freeze */
-	struct mutex		bd_fsfreeze_mutex;
-	struct super_block	*bd_fsfreeze_sb;
+	atomic_t		bd_fsfreeze_count; /* number of freeze requests */
+	struct mutex		bd_fsfreeze_mutex; /* serialize freeze/thaw */
 
 	struct partition_meta_info *bd_meta_info;
 #ifdef CONFIG_FAIL_MAKE_REQUEST

-- 
2.34.1


