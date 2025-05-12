Return-Path: <linux-fsdevel+bounces-48769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFC3AB4266
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 20:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A733F188814A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCBA2C1792;
	Mon, 12 May 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="intxJmg7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB62C10BA;
	Mon, 12 May 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073146; cv=none; b=STBZw0bmvqxTD0h9/X11t/xX5nBArzEZt/L5WSSiUEwR7p/qSoaUh4IsuiGolnXaA73lxfoK5nMRI3TsHDiEeBnExbm9DbSbZUeaQB3ae3KHjTO6w61rZam11jJ5dY8s/4ee8xaVSLtDsy/i1nRQHVyL8ES4DM85/CvU9LszBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073146; c=relaxed/simple;
	bh=rYb+ddR5SWeXeQV4IfopwKe1+HwZ+8NKAMXuEfEmvrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o538YI7pfxzVZ138BjpC2VwFDNNRHFYw3s47leO84iiZM8E/ttkz5grnVqI9fPCxHqgnlq3K4oKmArL82qYqhcx4hhDuFT1LI2ob2O2R7mSq/6Bx13zzvowdfKAoS5R6zsg7A63UxDyNyH3lfK1QxDPDHOAGyOTZzJwyPHIGUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=intxJmg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1904AC4CEF0;
	Mon, 12 May 2025 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073146;
	bh=rYb+ddR5SWeXeQV4IfopwKe1+HwZ+8NKAMXuEfEmvrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=intxJmg72n7VuIAS/lSNOmbyZyR2BtW7QOkYlImlo84ITJuLtLEkDTXZoPFKvyS7d
	 Ebqdxet2ADzeOdN73MrdONJ13Cteh5G/4koHoiMMJ9x/3hX4eTcMizarrJj7hxRFLM
	 36IppU0VdH47T0MdnqCdkGuxOfvpkpwEUCyeillckondoH31tS4U0jHVY7Vbehdwjx
	 sXmJ+3gV9SR5O76rKbStJlzG+COY+XIawmbjkGn+skLgiSdTR8nqvubURt44PWG+9L
	 w42zdsJKraiaIt4yT1LQJzO4tOjn0c9j8Xi1IUYYWFi1pfoGEk8rAp6i2f16J+A3Oq
	 5jx4lZnP5Ph5g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/3] __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock
Date: Mon, 12 May 2025 14:05:37 -0400
Message-Id: <20250512180537.438255-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180537.438255-1-sashal@kernel.org>
References: <20250512180537.438255-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 281f08eaba5b9..c1aa46f780f16 100644
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


