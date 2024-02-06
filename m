Return-Path: <linux-fsdevel+bounces-10437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E0684B26C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C9A1C23918
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 10:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67512E1E9;
	Tue,  6 Feb 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eswa3XIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5F12B14E;
	Tue,  6 Feb 2024 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214973; cv=none; b=hUUdYruvnstyAKzG6GSJUoRXzW8X73Hi2AR3ShlZMqJnyBzg5oYuQNBsfdBALsKHUZcnJArXkzAgKUMpO+y/TSsqd3QVhT8DbVnkZZpggUWS117BemsZkL2vuCcDSLBcIIPS/r5PHTfKQLMe77DF5IbWTzo3mbPDHscu9uixjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214973; c=relaxed/simple;
	bh=lDcrFbajOxQJyzMqUqx8TzZ9sBClVUvvVl6hgim3mhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dYXOQrCPAGrW2Wks3j+NCEVB7dUMDmKkGqhOHo0D0Ap48N55Zmi/qUI1rT6ZKclipyUeDA2k29/XPA/TBoafGpxbF2XRBnKjv0wLkJoMYLlcyQsRBuq9aDjnAJuLo57vFQY9tdFvbm2F5hxs+bhtGGPDnYtHqCuQDkzwOkcy1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eswa3XIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9AAC43390;
	Tue,  6 Feb 2024 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707214973;
	bh=lDcrFbajOxQJyzMqUqx8TzZ9sBClVUvvVl6hgim3mhA=;
	h=From:Date:Subject:To:Cc:From;
	b=Eswa3XIVSWu2WDQllGuNSIPaKzkygH/cVXrhv5lbeRn1Kyd9LluwUQgEzTnSciWE4
	 aQYZNhKhxduye2SpKASqfF1Jy84HLyD10L0jU1e5IklTTKMKzLmZipcqjJUPEVW3zz
	 PXF6vOW4v35UiRc7MYEdzexWuwQOtSFVp3SRykyMPl/TPFVFKrmi4z1WJDIKTtxXcJ
	 VHP9IKaXhiXS/7KfaKlYD2EnY89w9l6dkMnfs6/30F3NKfR4nIh7q9i9ptJ7NQTmIL
	 sDeJVGuP24vF1/P8SlNaLBAC74EBCBsuVCdGkRsTnOvT3jZ6viZcZ4t+OfM773aJPi
	 nLiB6MV4VTQ0Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 06 Feb 2024 11:22:09 +0100
Subject: [PATCH] fs: relax mount_setattr() permission checks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-vfs-mount-rootfs-v1-1-19b335eee133@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFAIwmUC/x3MwQ6CMAyA4VchPVszp0LwVQiHMTrpgc20QEgI7
 271+B3+/wAlYVJ4VQcIbaxcsuF2qSBOIb8JeTSDd/7hvKtxS4pzWfOCUspiaFxIydO9fdYjWPY
 RSrz/l11vHoISDhJynH4j668za4Tz/AK7P7yffQAAAA==
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Karel Zak <kzak@redhat.com>, stable@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lDcrFbajOxQJyzMqUqx8TzZ9sBClVUvvVl6hgim3mhA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQe4qhOL5Cfo558v0SVtUDd2n7LpAST6Mi6SwL/Erjcb
 Do2siR0lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATGSOMCNDz9a7a0UCdrfZ1Z+d
 MSuvyYHBsCnUqoLP3ttruqa9S5EII8OkY9vnpioWyG5LMjq5zPyKcoLI4RO7jyZUS6Z12UW1GTE
 AAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When we added mount_setattr() I added additional checks compared to the
legacy do_reconfigure_mnt() and do_change_type() helpers used by regular
mount(2). If that mount had a parent then verify that the caller and the
mount namespace the mount is attached to match and if not make sure that
it's an anonymous mount.

The real rootfs falls into neither category. It is neither an anoymous
mount because it is obviously attached to the initial mount namespace
but it also obviously doesn't have a parent mount. So that means legacy
mount(2) allows changing mount properties on the real rootfs but
mount_setattr(2) blocks this. I never thought much about this but of
course someone on this planet of earth changes properties on the real
rootfs as can be seen in [1].

Since util-linux finally switched to the new mount api in 2.39 not so
long ago it also relies on mount_setattr() and that surfaced this issue
when Fedora 39 finally switched to it. Fix this.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2256843
Reported-by: Karel Zak <kzak@redhat.com>
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 437f60e96d40..fb0286920bce 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4472,10 +4472,15 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	/*
 	 * If this is an attached mount make sure it's located in the callers
 	 * mount namespace. If it's not don't let the caller interact with it.
-	 * If this is a detached mount make sure it has an anonymous mount
-	 * namespace attached to it, i.e. we've created it via OPEN_TREE_CLONE.
+	 *
+	 * If this mount doesn't have a parent it's most often simply a
+	 * detached mount with an anonymous mount namespace. IOW, something
+	 * that's simply not attached yet. But there are apparently also users
+	 * that do change mount properties on the rootfs itself. That obviously
+	 * neither has a parent nor is it a detached mount so we cannot
+	 * unconditionally check for detached mounts.
 	 */
-	if (!(mnt_has_parent(mnt) ? check_mnt(mnt) : is_anon_ns(mnt->mnt_ns)))
+	if (mnt_has_parent(mnt) && !check_mnt(mnt))
 		goto out;
 
 	/*

---
base-commit: 2a42e144dd0b62eaf79148394ab057145afbc3c5
change-id: 20240206-vfs-mount-rootfs-70aff2e3956d


