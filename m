Return-Path: <linux-fsdevel+bounces-42904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C42AA4B2E4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 17:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA03188D901
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 16:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1321E9B21;
	Sun,  2 Mar 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="msLWUylx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE41EB9EF;
	Sun,  2 Mar 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931637; cv=none; b=KaXgUIPxQfASbcfyemA3BxwmtNrXi6NV1cLE3qM15jBCY6wL8V1ADOMcE6Av130tWxxdBpIEz9h0sp5fkzvy1mDGcNxKdJjyy39EwmyEvIhBHCxVR/zx/Pdi7BN0XYWFV0WQF5WonhQnaSdFbgcp5DxVIA7aIp9Vz+7xqYpKl8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931637; c=relaxed/simple;
	bh=MRV1BzXFzVKuXXCzfT8MZMYwjH+JUp8WlpwQIsq6O88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxkUli/Z6yaa0S36/EjBivt5qVvYP73bOPuDORUaNbXuAyOPdqycJboSxIHm8OwdxEYOmpxcbr6gejanJDX5MP6Dk8WcQ4ukaWmA/OYUmmwsLsNxEzZDqQP50UeMMjs4jgS7KrRZyTRg/RVaHj30UvaHDxwPAo08viMPRBgyjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=msLWUylx; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931634;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRfdkDgvTkBq7bn29Gpn8MyAqWDeCH+tjzpw5UYm82I=;
	b=msLWUylxKZrkZloeSFN5bZFcbLSbFE1cttvSkO/sbcFYzOZMJ7QrfX7q/KeJKDTCCqgTwE
	Cmy7gxyKITqqPUSpsCS7G1MqMRTPEE0rGESChTm4bdOm11qcFfU19VdeWkGdCDRk2erDxx
	kDdrSiGJC8bqVFfFWelDM4gaS0EX1FJAHjToIV4v7qro8N7Udd/eU2b50vvHw4+nCCyDVp
	iMV4JdyinVFOmyN1MzYoME93xKcoQ8EPz6PyS8U/d1Bw/PaS5g5Ib0iiqfD+QrZDeUyCFv
	aH0d4JvaWftIryzqqBPR8zUxtU31fm2LuQe5b2oX22cLwFz/FOLen82uN8NLOQ==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 09/11] fs: reorder capability check last
Date: Sun,  2 Mar 2025 17:06:45 +0100
Message-ID: <20250302160657.127253-8-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
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
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 3e092ae6d142..5b77b38f0510 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -303,9 +303,9 @@ static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
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
 		return -EPERM;
-- 
2.47.2


