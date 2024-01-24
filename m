Return-Path: <linux-fsdevel+bounces-8656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D1839EEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C3D284B9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B217589;
	Wed, 24 Jan 2024 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOHULlN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA517544;
	Wed, 24 Jan 2024 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062957; cv=none; b=kOaEWn4IGVfMdALj9Qv8W4NlIV6G0JHdreAlKMUylor2n62xXMq3hTzmUIZmZ06tIMLkinBOeDWNxG74ownGDMl4sbJOnbVrKm2lKaa2IKQEMSPVhhJxH79r7nTK2PemLjnxnfKmdH7KyD76GbbVqcMlaLjdKhgX11n7+MmcDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062957; c=relaxed/simple;
	bh=9A2h+cQm1NePRunwfP+ArwgVlh76SYO321XvdCirfjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pa9gRUCWyTmeGwXOicA8xYJX2ef55ljWKX5+YgLAxIdplfpVyqK6NNDBP6uw8W0utHaBdS7f0Olm9aeYWIuYBEnEZUSqreDZVASO/fmF6dlmF+/nCr8j2VpyqnKcFwRd7VHyq9otjXEFMf6fPSEyTFm87IknBpa2NbG0++0BMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOHULlN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5ACC433C7;
	Wed, 24 Jan 2024 02:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062957;
	bh=9A2h+cQm1NePRunwfP+ArwgVlh76SYO321XvdCirfjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOHULlN2r5XRvpdqbuVYcuEGGKLHQ1DM5Pb4GSop4U5w9/aWXe86OI0I13qGy3E9n
	 zcttbCj8qYwn38M+P66I9OlOAJFPaDNMbhtCvh5cqAFLcUfQUkWoQym0auqaSDxcc0
	 6+rxcAQu2D+7p4Swp+mVIzqahryVuBQWqn1iNwMhFiY3x22STu5162XYcZ4RNCRBiD
	 TXAKajEo4gin5/vMFFi8Jf7XYIISixWnOBOIF7Ufxn3G/LEqtcWahTCOvXtr9/+IV0
	 J6OVpMZs3pr7umgdX9quOD9wHyyxMnIyjWAtLhO4ul1qEddRSBAmeooQUUB7Y3tkZX
	 XOk/c005vVseQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 18/30] bpf: fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
Date: Tue, 23 Jan 2024 18:21:15 -0800
Message-Id: <20240124022127.2379740-19-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124022127.2379740-1-andrii@kernel.org>
References: <20240124022127.2379740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's quite confusing in practice when it's possible to successfully
create a BPF token from BPF FS that didn't have any of delegate_xxx
mount options set up. While it's not wrong, it's actually more
meaningful to reject BPF_TOKEN_CREATE with specific error code (-ENOENT)
to let user-space know that no token delegation is setup up.

So, instead of creating empty BPF token that will be always ignored
because it doesn't have any of the allow_xxx bits set, reject it with
-ENOENT. If we ever need empty BPF token to be possible, we can support
that with extra flag passed into BPF_TOKEN_CREATE.

Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/token.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 64c568f47f69..0bca93b60c43 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -162,6 +162,15 @@ int bpf_token_create(union bpf_attr *attr)
 		goto out_path;
 	}
 
+	mnt_opts = path.dentry->d_sb->s_fs_info;
+	if (mnt_opts->delegate_cmds == 0 &&
+	    mnt_opts->delegate_maps == 0 &&
+	    mnt_opts->delegate_progs == 0 &&
+	    mnt_opts->delegate_attachs == 0) {
+		err = -ENOENT; /* no BPF token delegation is set up */
+		goto out_path;
+	}
+
 	mode = S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
 	inode = bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
 	if (IS_ERR(inode)) {
@@ -191,7 +200,6 @@ int bpf_token_create(union bpf_attr *attr)
 	/* remember bpffs owning userns for future ns_capable() checks */
 	token->userns = get_user_ns(userns);
 
-	mnt_opts = path.dentry->d_sb->s_fs_info;
 	token->allowed_cmds = mnt_opts->delegate_cmds;
 	token->allowed_maps = mnt_opts->delegate_maps;
 	token->allowed_progs = mnt_opts->delegate_progs;
-- 
2.34.1


