Return-Path: <linux-fsdevel+bounces-35770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6129D83A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26CE286D0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A274B1A3035;
	Mon, 25 Nov 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="hlpyVRYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225CC193070;
	Mon, 25 Nov 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531239; cv=none; b=lgKFQd3fQkMrIbSftYXbDAhpveMrL4yfiiCxzcrE6l0eFH9QUT95IPaHlbkrs8RND9/RbaSpY59yUPaCXG2/2tsLYEl4otVSQtiYshtM6VPb4ClXLihnkL8IeEdNmVpvg2P3/zO/6vp4H2+sudDG8NE/in/9gZuJKv7w4CcPXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531239; c=relaxed/simple;
	bh=iQFabzcbeyd0VMqCL1uH7Fo+292SfpJATJ4pnluwUxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lz+PXjHnGcK+Rm5P+ugxqgCq2LdBXzZ6QRzubhw0PKu11sq23w5EtQ7LNqkPFGnMsRNaEvu0gdGq2gGkJfzmK5he9fAHa5982bdyLygmpUmLh7hENb6jklxUaFo7h5nrgLJEgnUbQE+MlEDvWM1O1jjAJ4xxbBjauzjyW8KHa+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=hlpyVRYU; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531234;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8toJKTqYgiOm8yX0/nayZUss8l7ma5sqSjl7KCBpF0=;
	b=hlpyVRYUw1z9xdZYuJDetCTFRs3+Z1lxqLniLK0tn8ZkmcWiAL0wZ78aQGq5CBamzi3BHV
	9ieNcRpM7AGfB0BdD6l6XEGEzBKC9k8riy5y0h8JJXkaR+hA4W0RSz2SHOGCNm/utmsRAu
	6scALFYJ6L6f4jz72hqrt5zCGRec5vFh8cJ8r+g/FidQPHC401sojwGuGwasJDZtsSuTG+
	MFk4OzmeTYuB9D47W/amQTcxAHVR44Kd0A40nLT+O6oXPtDHrzLhNB9/rGRLHRQDFjf6nC
	uDUoXOqRx5fDWxJ10epkJwqkfBoBKMtSxMC4LcDFdEjqZI1nPZhmdSi/iwslTA==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	cocci@inria.fr
Subject: [PATCH 09/11] fs: reorder capability check last
Date: Mon, 25 Nov 2024 11:40:01 +0100
Message-ID: <20241125104011.36552-8-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 fs/fhandle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 5f801139358e..01b3e14e07de 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -265,9 +265,9 @@ static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
 	if (ns_capable(root->mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
 		ctx->flags = HANDLE_CHECK_PERMS;
 	else if (is_mounted(root->mnt) &&
+		 !has_locked_children(real_mount(root->mnt), root->dentry) &&
 		 ns_capable(real_mount(root->mnt)->mnt_ns->user_ns,
-			    CAP_SYS_ADMIN) &&
-		 !has_locked_children(real_mount(root->mnt), root->dentry))
+			    CAP_SYS_ADMIN))
 		ctx->flags = HANDLE_CHECK_PERMS | HANDLE_CHECK_SUBTREE;
 	else
 		return false;
-- 
2.45.2


