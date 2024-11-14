Return-Path: <linux-fsdevel+bounces-34745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F2B9C8513
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E14A1F21E06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C7C1F892B;
	Thu, 14 Nov 2024 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMiAW2jZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1E81F7570;
	Thu, 14 Nov 2024 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573882; cv=none; b=m9kEul/kFrvozOfUDNGgQIzeWBmAWYpkXDWTAWvGSxMtyqniEqxUl57ZrrkJC1N+xUjfsPi+6O6DUKHP2UrfJUL3KNBucSLnc30G5y1g7tQ9JanoXYOKlNpy3abUFgUh0LITUGY+yutHi3chptMYcziqW7Iznsh+NEAkhzS5iko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573882; c=relaxed/simple;
	bh=vqv7nsoFBXs3JlMYaca6LaUZbsVJm6kN4tNuO7C36Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTMOaD4uefmCSI57zT5Err2I/O8dea+twEpfAGSFbx91KOnnfOCRKNn/2ioJ//y9EIwph18BMR/8lYxcdJWU4y2YBLTw3oNFon0a0aOehuWLPGEztm8zaCsd1EWslR+Yj4bWcFMBD8kwxcNJ6ygxkcgb6llwwmv0s8qx10AYqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMiAW2jZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E191C4CED6;
	Thu, 14 Nov 2024 08:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731573882;
	bh=vqv7nsoFBXs3JlMYaca6LaUZbsVJm6kN4tNuO7C36Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMiAW2jZ6sNdS7VmecsJKbiYAglOcU6SWUX5b+8sGA09GyeHdwreENhpB8dpBe5QC
	 zbhoOH8VcqVbNqqU1PLyMWFMtnDCqiDtG4yTCuBJSshEpg52aunoBZfoTvY4No7C+O
	 ifLK/nKc+GH4TPg/LWoIEsZdfTLm3ereJ6hlY9uS4UCWOPYIeWVHvdDamEnVLfnxi3
	 h1j6Hg/0aWEAktkB8ELaT2SiOXs4X9WCEDxO7Ixwg72p4fvVvlY64gTl/+Ex3w5v3U
	 fj2nodsaB9FHgg+qNgGmDxs6vBipu1ZNzR1t6drCLbrnxEb0qBSJrFgbZ9270ToE0V
	 /o8Z6455xWctQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [RFC/PATCH v2 bpf-next fanotify 5/7] bpf: Allow bpf map hold reference on dentry
Date: Thu, 14 Nov 2024 00:43:43 -0800
Message-ID: <20241114084345.1564165-6-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241114084345.1564165-1-song@kernel.org>
References: <20241114084345.1564165-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To save a dentry in a bpf map, proper logic is needed to free the dentry
properly on map termination.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/helpers.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab28..5e3bf2c188a8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3004,6 +3004,12 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	return ret + 1;
 }
 
+__bpf_kfunc void bpf_dentry_release_dtor(struct dentry *dentry)
+{
+	dput(dentry);
+}
+CFI_NOSEAL(bpf_dentry_release_dtor);
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3046,6 +3052,8 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release_dtor)
+BTF_ID(struct, dentry)
+BTF_ID(func, bpf_dentry_release_dtor)
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
 BTF_ID(func, bpf_cgroup_release_dtor)
@@ -3105,11 +3113,15 @@ static int __init kfunc_init(void)
 			.btf_id       = generic_dtor_ids[0],
 			.kfunc_btf_id = generic_dtor_ids[1]
 		},
-#ifdef CONFIG_CGROUPS
 		{
 			.btf_id       = generic_dtor_ids[2],
 			.kfunc_btf_id = generic_dtor_ids[3]
 		},
+#ifdef CONFIG_CGROUPS
+		{
+			.btf_id       = generic_dtor_ids[4],
+			.kfunc_btf_id = generic_dtor_ids[5]
+		},
 #endif
 	};
 
-- 
2.43.5


