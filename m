Return-Path: <linux-fsdevel+bounces-51478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC87AD71E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA8317DD8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AE625B303;
	Thu, 12 Jun 2025 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3CTsva0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94722459CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734765; cv=none; b=QxnamAg/tTmweYwADHLjLpHcaO3OaUG72CPqYo+Vp5ru2h/j+V0TTlaeD+5R+ANy4fHPtPwbj3+AUn7NaKx6goxqUHi+amIG7FTQlB/Rv24N/KfKtVeSWfyII7k2+6D/8sSq7M/31uoM1R0ZvAdKknj4kTh/GHHshnQLA963bEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734765; c=relaxed/simple;
	bh=8z8jRYS65ySEEnT3DFKOiSpIbs1wXHDoKBkOLAcIIks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSqitNOYeBn3lVgLLlCGd2uWKswWquNdeVLGwIkBKDRUuHB5pNh62HwTAMuBbv5M6ymWCWP8wPxDWC1MKCkdP++6+oVqx09ZcRY3ISVA09qjufP+Syhvi7QHk8zmmXPFsz/dyMZWtyod1sF0jZ2ctQd/5kdZZsTOc7O7we+X/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3CTsva0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA13C4CEEA;
	Thu, 12 Jun 2025 13:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734765;
	bh=8z8jRYS65ySEEnT3DFKOiSpIbs1wXHDoKBkOLAcIIks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f3CTsva0PHZ01M9L8PZsVMNBO1ifB5paicK/vr94SbWctb1QJR73zJkH9O28Q7hAo
	 Vb5zTdPrdenKQ5sVxS9dn5sKFe6NkmWJgtz4j+agkzvG9E+mpUnar/VohkRrynUZ8N
	 6LuLAo59WZAw/8p731LoEh2YqpOBDRzBPuoIndyzsz2GbB6xT3WAcstjOWq2gURnf+
	 2CoMb2xGlWMlQy+2Txk0Bu8JMnBeBBjdKpOoet64LHqzJZP/xlxp6dlxKhw9/oGpm0
	 fX9OGB2+1DjtXIIwaBJ7oxpwstfwktp8w76zS7328D50y0FWV9v5ExO7IK2xJuNlNh
	 9+ogSdDh9oukQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:31 +0200
Subject: [PATCH 17/24] coredump: auto cleanup argv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-17-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=831; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8z8jRYS65ySEEnT3DFKOiSpIbs1wXHDoKBkOLAcIIks=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXWf8OT3i/91WSl/LSXUrmVoTjAp+XZmZ72a74b90
 09dfr0ovqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi11wZ/pk8sE4K/eOzjCP0
 4MyN1VsD2Z8Uf3sepjnlmLF4gcHE1HZGhn8iTsaLn2rmzf5hfi/+g8TtNt9dv9wTi7ZlHq4svvy
 8jwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

to prepare for a simpler exit path.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index f980a7920481..f8d5add84677 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1076,7 +1076,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	const struct cred *old_cred;
 	struct cred *cred;
 	int retval = 0;
-	size_t *argv = NULL;
+	size_t *argv __free(kfree) = NULL;
 	int argc = 0;
 	struct coredump_params cprm = {
 		.siginfo = siginfo,
@@ -1189,7 +1189,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 		atomic_dec(&core_pipe_count);
 	}
 fail_unlock:
-	kfree(argv);
 	kfree(cn.corename);
 	coredump_finish(cn.core_dumped);
 	revert_creds(old_cred);

-- 
2.47.2


