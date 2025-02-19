Return-Path: <linux-fsdevel+bounces-42087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B97DA3C53E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122E41736E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756B71FECDE;
	Wed, 19 Feb 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIPmJNhV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73F1FECC9
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983235; cv=none; b=Iuehbp8B6Jut4zvOsPYHLz6B2zWbg2zhKpWTdUkKXdgxSEAuYApV5IMQGchEedMRZks/kiAcDl7w5I4MLLNn3vmV90rxmOGU5iAstkXumYEXmtNS4rX2KA0iU3F4JX4SEgsn3uEcYVRiVXGjgdTqrLUywCs10YPNSISbdurvf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983235; c=relaxed/simple;
	bh=pfUzip/9ZUqIio8NrY0Vu7ZdeL0+rEWGOMkV9a1ck6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgCRbwp3P+wKmrJ9/3lzVVEpdyXrWwjCGxgj7P5dd4xvQYlT+7/mgDE1onR13xsDhlPXv35lr2wxbjZ10kgPhFJ88bBXOZFFTho0X4ZkEtCMqa+6uubCuu99gIDJHTHW59QR2OndiRiFwoQPd6pCJLkYEwzMszuDKoMRPuRQ0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIPmJNhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326FAC4CEDD;
	Wed, 19 Feb 2025 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739983235;
	bh=pfUzip/9ZUqIio8NrY0Vu7ZdeL0+rEWGOMkV9a1ck6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RIPmJNhVFC0hkIY8bfgFzlQeq1ZGCBFWvvqFxS4PbUHUNwQwCHzPB723mHnB+HL9o
	 VdBqIBVCiRtCPkGqq/5wnrgiGyvfEK2LVRSq1Hfh5WOItuzYtI5CA4mK0+I2sQdET6
	 MToWOWl97h2Dfpjt0R2cthRnOUjKTXvLzwWfZ4gdg/G2QoMeFQScI1TFzj2THu8Jo4
	 KSi3UBIFwF5LrkWhqVJYAJtIzle0dplMj+CeTvESoOkghqz9l7hSh+o2E2kUNxxKkw
	 unpispb4CcLJeMhAi+Q5TQ4Box9nmUoZi790byifBKXUX9knrYcslR6xZuoKZHJ+SF
	 ealrx4m/Vb9tA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 19 Feb 2025 17:40:28 +0100
Subject: [PATCH 1/2] nsfs: validate ioctls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-work-nsfs-v1-1-21128d73c5e8@kernel.org>
References: <20250219-work-nsfs-v1-0-21128d73c5e8@kernel.org>
In-Reply-To: <20250219-work-nsfs-v1-0-21128d73c5e8@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pfUzip/9ZUqIio8NrY0Vu7ZdeL0+rEWGOMkV9a1ck6U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRv42yYF3ZisY5mWMzGlW19VnH/uOojCpJ3xOmG1Dps8
 2pvrpDsKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEjhIob/vn+2Tohp3THRZJO6
 qYay0a1Z26w644p609O5b+jcr412Zvinz7jcPLfs78mHupl6Hz8Gu83wLT40/Rh3ZMoR3TXTc3g
 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Nsfs supports extensible and non-extensible ioctls. Validate both types
to prevent confusion.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 663f8656158d..1ab705bb9386 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -152,19 +152,49 @@ static int copy_ns_info_to_user(const struct mnt_namespace *mnt_ns,
 	return 0;
 }
 
+static bool nsfs_ioctl_valid(unsigned int cmd)
+{
+	switch (cmd) {
+	case NS_GET_USERNS:
+	case NS_GET_PARENT:
+	case NS_GET_NSTYPE:
+	case NS_GET_OWNER_UID:
+	case NS_GET_MNTNS_ID:
+	case NS_GET_PID_FROM_PIDNS:
+	case NS_GET_TGID_FROM_PIDNS:
+	case NS_GET_PID_IN_PIDNS:
+	case NS_GET_TGID_IN_PIDNS:
+		return (_IOC_TYPE(cmd) == _IOC_TYPE(cmd));
+	}
+
+	/* Extensible ioctls require some extra handling. */
+	switch (_IOC_NR(cmd)) {
+	case _IOC_NR(NS_MNT_GET_INFO):
+	case _IOC_NR(NS_MNT_GET_NEXT):
+	case _IOC_NR(NS_MNT_GET_PREV):
+		return (_IOC_TYPE(cmd) == _IOC_TYPE(cmd));
+	}
+
+	return false;
+}
+
 static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			unsigned long arg)
 {
 	struct user_namespace *user_ns;
 	struct pid_namespace *pid_ns;
 	struct task_struct *tsk;
-	struct ns_common *ns = get_proc_ns(file_inode(filp));
+	struct ns_common *ns;
 	struct mnt_namespace *mnt_ns;
 	bool previous = false;
 	uid_t __user *argp;
 	uid_t uid;
 	int ret;
 
+	if (!nsfs_ioctl_valid(ioctl))
+		return -ENOIOCTLCMD;
+
+	ns = get_proc_ns(file_inode(filp));
 	switch (ioctl) {
 	case NS_GET_USERNS:
 		return open_related_ns(ns, ns_get_owner);

-- 
2.47.2


