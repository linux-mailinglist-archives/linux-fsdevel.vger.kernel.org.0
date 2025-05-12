Return-Path: <linux-fsdevel+bounces-48768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E73EAAB432E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 20:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC39E7B68A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2770E2BFC8D;
	Mon, 12 May 2025 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH8t0BP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774572BFC72;
	Mon, 12 May 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073137; cv=none; b=flQ9CE2QCY31uyRtZRZYZOSkN4vewCIJjzb2TUL5pXGve382HqYi/fo3uaRImrT0h78BK4tYgqsKo+ZiEEaW4M1bXKFBP5sX2iNJ5byb6oQhi6IM6y1/7AguY/W6lgWU5nHEZuZxEvIrJSLevhcoH1HKJG1f5JpWXMkQvCmpv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073137; c=relaxed/simple;
	bh=xuwcdzp+yOKlnUsHE+/kS8E8z/VbD6yCi+gpHECzW3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1f4Yi4XuPFYipBhYn9Q7ST4axDRDmdF1nOb4J75mL8bUaTmSyjx/spGrDRrLRScngB1jKn2HxXWroczAYi4kU0ZzqGd8iw3WIBU0EVuUi+K3AVakh6klkmq6tPzoRbboMpSXcdImB31J1mY87ewBdYu+62NpuxbWJSQOBjh0q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH8t0BP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFBAC4CEE9;
	Mon, 12 May 2025 18:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073137;
	bh=xuwcdzp+yOKlnUsHE+/kS8E8z/VbD6yCi+gpHECzW3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rH8t0BP87J6l2WvGedulXsIIF41m93RCx8gxtU8y3CQsqgs4rqeARI0SUuJY8hohc
	 ct/us+VDQYTexXALyoWE+v5mHSvGfx1xQP+hkCFuyKB4WiV1f5fn7CbAgwCeBoPC7u
	 EiAFMatm9rdEvS/dQw32+BG9MOTOktdptv5Lxm2dtoGXx/JzsacaOyStRWP4CzqJpu
	 feGooq/jDjoaxUs/skEfHNdXUeniGqt79C5FL+Auq9Okvzqj+pk24Cpd8an1r5DHjf
	 7uo4rz0KpUeFnHzMIrFXcBZ0qmxlTBYHwzy50b5H7E98SsKRalZm7eblXyccTyCAbN
	 vXWmqvf7dYiiQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/3] __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock
Date: Mon, 12 May 2025 14:05:28 -0400
Message-Id: <20250512180528.438177-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180528.438177-1-sashal@kernel.org>
References: <20250512180528.438177-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 250cf3693060a5f803c5f1ddc082bb06b16112a9 ]

... or we risk stealing final mntput from sync umount - raising mnt_count
after umount(2) has verified that victim is not busy, but before it
has set MNT_SYNC_UMOUNT; in that case __legitimize_mnt() doesn't see
that it's safe to quietly undo mnt_count increment and leaves dropping
the reference to caller, where it'll be a full-blown mntput().

Check under mount_lock is needed; leaving the current one done before
taking that makes no sense - it's nowhere near common enough to bother
with.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2f97112657adc..9f9d0d9ba4dc7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -572,12 +572,8 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 	smp_mb();			// see mntput_no_expire()
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
-	if (bastard->mnt_flags & MNT_SYNC_UMOUNT) {
-		mnt_add_count(mnt, -1);
-		return 1;
-	}
 	lock_mount_hash();
-	if (unlikely(bastard->mnt_flags & MNT_DOOMED)) {
+	if (unlikely(bastard->mnt_flags & (MNT_SYNC_UMOUNT | MNT_DOOMED))) {
 		mnt_add_count(mnt, -1);
 		unlock_mount_hash();
 		return 1;
-- 
2.39.5


