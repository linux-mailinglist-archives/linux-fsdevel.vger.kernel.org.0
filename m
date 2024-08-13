Return-Path: <linux-fsdevel+bounces-25837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B78D951045
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71941B26661
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198851AE879;
	Tue, 13 Aug 2024 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW5ztAkV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C81AC427;
	Tue, 13 Aug 2024 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590218; cv=none; b=g3ntH4vRVImBGLE64Q5c+s21o0HWuYbdDakFqXGfA3YbSUkG+QV+OMvnQAMO3L+uxsRHBJ9CKYumt0wMRYC2HKzcq/GSeMPLgWkxC6aiv3Spq42+VJ63hDSHhURuxSxSqZifUcYw14C2b70dIIO378L2+thViyUqIqrH2GhAUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590218; c=relaxed/simple;
	bh=aFjrlhkayKPX3G36/i+lQmbPMJDdAqx+NoxLgJo3/oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9cqM4X2TIxBENZlYiEeWRTDXjWLx5wC7N54FbnNTsn9Jgkd4Fuji4cf3Dc9B45mkCO9RxuhZUnuIfDVsa09RjHqwfgpslefStqDA5rl/vnoDeHCgBFvpoGTxyzt7l5APTWMaGB6xso8nyh50KfxozsYM2cRtN0/JimFabcbxeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW5ztAkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB43C32782;
	Tue, 13 Aug 2024 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723590218;
	bh=aFjrlhkayKPX3G36/i+lQmbPMJDdAqx+NoxLgJo3/oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oW5ztAkVcOkCLu2K17pzi7WefR1yIri+agXg8fdUG3Z3qn+VanHrYl+0+xggCfkzb
	 9AVOFbDj1Y/cmyM15HaYhWKvr8I35Bb1phFRVKD69Tv35l62KvRu4jzOnZT1zfRybp
	 rze18C1ITJD0t76qvn9ahIGoqDDjKD7HKoQzgSOvYQvHC3iHPr1huPe8aWq8+QzwtQ
	 X6LsUzlcrquE5MjRQjnh4wDfOSUsGgvcDRllrhXxT9ooJDpkvahOkwBwtJ2vVYTmab
	 2ldkuVKvxnSQ+nYsxo4jcFnqPUJu9xRvVkEvey+gqQgUyWoViHRC6dKK6dc/MoCilp
	 ZseEUZhlmd5tQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: viro@kernel.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH bpf-next 7/8] security,bpf: constify struct path in bpf_token_create() LSM hook
Date: Tue, 13 Aug 2024 16:02:59 -0700
Message-ID: <20240813230300.915127-8-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813230300.915127-1-andrii@kernel.org>
References: <20240813230300.915127-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no reason why struct path pointer shouldn't be const-qualified
when being passed into bpf_token_create() LSM hook. Add that const.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 4 ++--
 security/security.c           | 2 +-
 security/selinux/hooks.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 855db460e08b..462b55378241 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -431,7 +431,7 @@ LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
 	 struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
 LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr,
-	 struct path *path)
+	 const struct path *path)
 LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
 LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
 LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1390f1efb4f0..31523a2c71c4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2137,7 +2137,7 @@ extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 				  struct bpf_token *token);
 extern void security_bpf_prog_free(struct bpf_prog *prog);
 extern int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
-				     struct path *path);
+				     const struct path *path);
 extern void security_bpf_token_free(struct bpf_token *token);
 extern int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
 extern int security_bpf_token_capable(const struct bpf_token *token, int cap);
@@ -2177,7 +2177,7 @@ static inline void security_bpf_prog_free(struct bpf_prog *prog)
 { }
 
 static inline int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
-				     struct path *path)
+					    const struct path *path)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..d8d0b67ced25 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5510,7 +5510,7 @@ int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
  * Return: Returns 0 on success, error on failure.
  */
 int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
-			      struct path *path)
+			      const struct path *path)
 {
 	return call_int_hook(bpf_token_create, token, attr, path);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 55c78c318ccd..0eec141a8f37 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6965,7 +6965,7 @@ static void selinux_bpf_prog_free(struct bpf_prog *prog)
 }
 
 static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
-				    struct path *path)
+				    const struct path *path)
 {
 	struct bpf_security_struct *bpfsec;
 
-- 
2.43.5


