Return-Path: <linux-fsdevel+bounces-24203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C8693B32F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 16:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B9428427B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF7B15ADB1;
	Wed, 24 Jul 2024 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVfc8ZGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B985D1581F7;
	Wed, 24 Jul 2024 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832847; cv=none; b=Br6e3Z4gsyNekwA4yNdOQmSRvds0JjqJ0lUaIhqsM7cRAxQu7+ptfVOw2LKJFQZCLLe16wn/K5j/meBYgOHw3jrEyCWJFAWZLEvV7wmSXvSbsO2okRfLAwJstLquJPI9o3qn6RtucIUUBznI/h8t4IeLsHd7fJn8qb+E41QokGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832847; c=relaxed/simple;
	bh=DznkJ6BfI/6MHwOQKLT8UI2/tLwgFWt0RRM25QOdiUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MS1IuXdRGkp3kMk+N5EP91KIIkcqaDCs/WgJn2Ze8RbAwU/WNEwppZjeNf/TZqB272uYNlZnT3YUTUBG0I+CxwTmaP5wtvMne3aQ/t3mePCyppwO7ovMmhNJUNV5Ty8qK6aJ3dAEuLsRBNdOjkVumg4r+CBHz4Ka30lVrjwRqns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVfc8ZGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727D0C32781;
	Wed, 24 Jul 2024 14:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721832847;
	bh=DznkJ6BfI/6MHwOQKLT8UI2/tLwgFWt0RRM25QOdiUw=;
	h=From:Date:Subject:To:Cc:From;
	b=MVfc8ZGcR1jKrh8Z8QostBx7Yn/xS68T+xotJz4aOidS5ZrsdWN9WtRlIUTr8Blvm
	 VyPSMd/H4D90GXTumwtKIRAq78N7/GHn2gYmDKt2m/QiC5hNvtWbJv4RvN544EE7Rw
	 SYjg5tu7acVMTeaCUMQtsGsQ/iHy/354ilgyZbQFOt3k6O7c+lusShxYoLbtiAeIhP
	 5wTaARjNloGt06zw129ZV1gIiBNQxPLiawMnXRvfhwkpVuTPt48Tb1u6lvY1hCLYiq
	 qvLu320aWiZb5lysHjk9knjedrKtNR38kVzvTGdvMc2lpZNP18SG3RdZ6Pzwsct8wF
	 coLP/s1Y8nzMA==
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 24 Jul 2024 09:53:59 -0500
Subject: [PATCH] fs: don't allow non-init s_user_ns for filesystems without
 FS_USERNS_MOUNT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-s_user_ns-fix-v1-1-895d07c94701@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIYVoWYC/x2MQQqAMAzAvjJ6dtBtguJXRERn1V6mrCiC7O8Wj
 wkkLwhlJoHOvJDpZuEjKbjKQNyntJHlRRk8+hobH6yMlyZjErvyY2fEGNxCLs4taHNmUv3/+qG
 UD4f8CpJfAAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.14.0

Christian noticed that it is possible for a privileged user to mount
most filesystems with a non-initial user namespace in sb->s_user_ns.
When fsopen() is called in a non-init namespace the caller's namespace
is recorded in fs_context->user_ns. If the returned file descriptor is
then passed to a process priviliged in init_user_ns, that process can
call fsconfig(fd_fs, FSCONFIG_CMD_CREATE), creating a new superblock
with sb->s_user_ns set to the namespace of the process which called
fsopen().

This is problematic. We cannot assume that any filesystem which does not
set FS_USERNS_MOUNT has been written with a non-initial s_user_ns in
mind, increasing the risk for bugs and security issues.

Prevent this by returning EPERM from sget_fc() when FS_USERNS_MOUNT is
not set for the filesystem and a non-initial user namespace will be
used. sget() does not need to be updated as it always uses the user
namespace of the current context, or the initial user namespace if
SB_SUBMOUNT is set.

Fixes: cb50b348c71f ("convenience helpers: vfs_get_super() and sget_fc()")
Reported-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 095ba793e10c..d681fb7698d8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -736,6 +736,17 @@ struct super_block *sget_fc(struct fs_context *fc,
 	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
 	int err;
 
+	/*
+	 * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT is
+	 * not set, as the filesystem is likely unprepared to handle it.
+	 * This can happen when fsconfig() is called from init_user_ns with
+	 * an fs_fd opened in another user namespace.
+	 */
+	if (user_ns != &init_user_ns && !(fc->fs_type->fs_flags & FS_USERNS_MOUNT)) {
+		errorfc(fc, "mounting from non-initial user namespace is not allowed");
+		return ERR_PTR(-EPERM);
+	}
+
 retry:
 	spin_lock(&sb_lock);
 	if (test) {

---
base-commit: 256abd8e550ce977b728be79a74e1729438b4948
change-id: 20240723-s_user_ns-fix-b00c31de1cb8

Best regards,
-- 
Seth Forshee (DigitalOcean) <sforshee@kernel.org>


