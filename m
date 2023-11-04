Return-Path: <linux-fsdevel+bounces-1972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF57E0FC8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 15:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C8E281B24
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDBE1A59A;
	Sat,  4 Nov 2023 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJC5Kd72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0F3D6C
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 14:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDBEC433C8;
	Sat,  4 Nov 2023 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699106436;
	bh=8+N8MCYDB8OY/FIV1GnWN4LjZr3OSxrdYESV2mJG1Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJC5Kd729t8tMVtPG2dz134jm76WMaDtulnPedoBXX6uvWJRJr4R41or/PQE7yYu2
	 qZKUe7UybzFMD/wrR77dztbxdqcaPhFTFd9zd1z/EadpXK3MBOwXU322kcFzy1+Nmn
	 U+d6LThh8gRVwwShEiV0ud0C2xkBBNcXqO9JqsCA7MpxjLtHFs5CqMTY65WY0XbH+I
	 2RtSKwlhXTTvuG1GwKDHZYzHKFoF0/KxsTSEX2KJ4cbr2nMkgNQLMEYhMDvm5byUhx
	 hEjdxCVMrq3H1OxqPbiByJRVCdCVngXJyHjUHWPj6IvUBEsOtaYUj6cvuB41Zf5byy
	 4qyXrvNnmu3+A==
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] fs: remove dead check
Date: Sat,  4 Nov 2023 15:00:12 +0100
Message-Id: <20231104-vfs-multi-device-freeze-v2-1-5b5b69626eac@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=832; i=brauner@kernel.org; h=from:subject:message-id; bh=8+N8MCYDB8OY/FIV1GnWN4LjZr3OSxrdYESV2mJG1Ao=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS6+aWelwl0naNQso8nxyv9UPNZ3rCWrrzXiVvmN1y9Ef0n gf1yRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETyNjH8j+GKblZX2fciO0tWdFVw6r vWW3n5e27kTlKZt2Gx/NXWVQz/XeSe+Z4yq3Mu4zcX7Hqwpnq1ic3hwIlZP6+Vay0JVV7NBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Above we call super_lock_excl() which waits until the superblock is
SB_BORN and since SB_BORN is never unset once set this check can never
fire. Plus, we also hold an active reference at this point already so
this superblock can't even be shutdown.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 176c55abd9de..2d32e60daef7 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1993,11 +1993,6 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 		goto retry;
 	}
 
-	if (!(sb->s_flags & SB_BORN)) {
-		super_unlock_excl(sb);
-		return 0;	/* sic - it's "nothing to do" */
-	}
-
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
 		sb->s_writers.freeze_holders |= who;

-- 
2.34.1


