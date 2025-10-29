Return-Path: <linux-fsdevel+bounces-66161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296FEC17E8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2C84252EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F962D7DDF;
	Wed, 29 Oct 2025 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxA7M6jN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284016A395;
	Wed, 29 Oct 2025 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701186; cv=none; b=ICIDHmVQFL3/SY6pSSfDljvkmN3TcpMZ5J+OMIMUjZG5RVvwdFhrHJBg7zYQGCOljpDAu3EtEuS0h3dnjyO3Czo0xgrpvaD4JSV9EfaceUWvjdQpaRa8xgP1Bl7GIumsQwVtIU+uAcAPNzp2XnC6BmCNfRNrW0ufMXx77YBtE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701186; c=relaxed/simple;
	bh=Vxv3e3IlyJ/K+HKpqdDCj2OmAj18QHDoYbdp2fDtIfI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlIJhfN2S0WEwgZHiUBXyvUBRKgE8BlNMAELTeUp0qerMf0M1RAAjlUHQKmBI8XFAWFgf5IUWrmGwCFHWFr3iWWibGk1z+jWUq84iDR1WfQQAZpFseSZeUHDCw2gOYczjtdgJrwsup3XNd4oeiTsZ8GPfvhy+9F/8I0sb9qdgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxA7M6jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE86C4CEE7;
	Wed, 29 Oct 2025 01:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701185;
	bh=Vxv3e3IlyJ/K+HKpqdDCj2OmAj18QHDoYbdp2fDtIfI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fxA7M6jNTeMdw4yROecSY+CSdob5ksKZH2csVy5OJlY/Xjh33EKK8ZsbEK4w9yv3a
	 4EAZCSnQfshIeCkyy7KQ0BhWlNy3PPHUamTRTmWZsag9Dmh4j0NmmqU2B4kc3ut2i4
	 WLRkV1OQ3N/TBk60iJNDAVU73TyH6LghO7gTHuP59ckqDZYTwANzfNKxz9RfyB+fBd
	 cDdURw45ChLJyJ5WyArr30NRuPSCtvD0Yi30hHd053VPrZ6tCLyOAcf8kbJJkAnaay
	 VpNk4TVKhObiHlufnp+tmIKqTRKdiQZ63uB42bUO/dvLLhA+a3/tOVWIE/p/n0o1Rq
	 e/i3suJIR6A4Q==
Date: Tue, 28 Oct 2025 18:26:25 -0700
Subject: [PATCH 23/33] generic/{409,410,411,589}: check for stacking mount
 support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820405.1433624.15490165287670348975.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

_get_mount depends on the ability for commands such as "mount /dev/sda
/a/second/mountpoint -o per_mount_opts" to succeed when /dev/sda is
already mounted elsewhere.

The kernel isn't going to notice that /dev/sda is already mounted, so
the mount(8) call won't do the right thing even if per_mount_opts match
the existing mount options.

If per_mount_opts doesn't match, we'd have to convey the new per-mount
options to the kernel.  In theory we could make the fuse2fs argument
parsing even more complex to support this use case, but for now fuse2fs
doesn't know how to do that.

Until that happens, let's _notrun these tests.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc         |   24 ++++++++++++++++++++++++
 tests/generic/409 |    1 +
 tests/generic/410 |    1 +
 tests/generic/411 |    1 +
 tests/generic/589 |    1 +
 5 files changed, 28 insertions(+)


diff --git a/common/rc b/common/rc
index f5b10a280adec9..b6e76c03a12445 100644
--- a/common/rc
+++ b/common/rc
@@ -364,6 +364,30 @@ _clear_mount_stack()
 	MOUNTED_POINT_STACK=""
 }
 
+# Check that this filesystem supports stack mounts
+_require_mount_stack()
+{
+	case "$FSTYP" in
+	fuse.ext[234])
+		# _get_mount depends on the ability for commands such as
+		# "mount /dev/sda /a/second/mountpoint -o per_mount_opts" to
+		# succeed when /dev/sda is already mounted elsewhere.
+		#
+		# The kernel isn't going to notice that /dev/sda is already
+		# mounted, so the mount(8) call won't do the right thing even
+		# if per_mount_opts match the existing mount options.
+		#
+		# If per_mount_opts doesn't match, we'd have to convey the new
+		# per-mount options to the kernel.  In theory we could make the
+		# fuse2fs argument parsing even more complex to support this
+		# use case, but for now fuse2fs doesn't know how to do that.
+		_notrun "fuse2fs servers do not support stacking mounts"
+		;;
+	*)
+		;;
+	esac
+}
+
 _scratch_options()
 {
     SCRATCH_OPTIONS=""
diff --git a/tests/generic/409 b/tests/generic/409
index eff7c3584b413b..cbd59b0162da2c 100755
--- a/tests/generic/409
+++ b/tests/generic/409
@@ -39,6 +39,7 @@ _cleanup()
 _require_test
 _require_scratch
 _require_local_device $SCRATCH_DEV
+_require_mount_stack
 
 fs_stress()
 {
diff --git a/tests/generic/410 b/tests/generic/410
index 69f9dbe97f182d..d5686ddbc64091 100755
--- a/tests/generic/410
+++ b/tests/generic/410
@@ -47,6 +47,7 @@ _cleanup()
 _require_test
 _require_scratch
 _require_local_device $SCRATCH_DEV
+_require_mount_stack
 
 fs_stress()
 {
diff --git a/tests/generic/411 b/tests/generic/411
index b099940f3fa704..1538ed7071781a 100755
--- a/tests/generic/411
+++ b/tests/generic/411
@@ -28,6 +28,7 @@ _cleanup()
 _require_test
 _require_scratch
 _require_local_device $SCRATCH_DEV
+_require_mount_stack
 
 fs_stress()
 {
diff --git a/tests/generic/589 b/tests/generic/589
index e7627f26c75996..13fde16505b7ab 100755
--- a/tests/generic/589
+++ b/tests/generic/589
@@ -42,6 +42,7 @@ _cleanup()
 _require_test
 _require_scratch
 _require_local_device $SCRATCH_DEV
+_require_mount_stack
 
 fs_stress()
 {


