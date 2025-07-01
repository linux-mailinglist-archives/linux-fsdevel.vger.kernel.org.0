Return-Path: <linux-fsdevel+bounces-53566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D84AF02D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 20:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840B01C203A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0662C27E075;
	Tue,  1 Jul 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qror3dzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35123BF96;
	Tue,  1 Jul 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751394695; cv=none; b=j/Gwfe6ReQCIWp5PU91ZuQ4WfGlEhswGz0WOmrpl5eLBtgudWrxuVXu2WqDbDRomBHlhR93DDGIkZEZMLeyCTAIZRRXfnEIrMow6X+WeCeoCibk2b4zoZFb7gdEdIYu4EXXCwyUkozsL7fIB3SeyMSgWOwNz35L22L940VBIqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751394695; c=relaxed/simple;
	bh=8f5T/z/d9mkXgNIGoAFY6PAJ6uLHSygkYSo7LU0k71E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBoBaoLASA9HW7zWZgEB4iWfRZeuOdghEcuu9ENaG6Hb/lHWb+nxj19hSm+rW9RJlvN/jMtTcbepSyyvw6dnpZp+ks8yQzblLFYMQj/leIilOcn3mDOvSXIJHPNEIaQVnpp8kx1AjTrrUjdWM1Li37qapH19VXbZ8uajONzD6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qror3dzs; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so15174910a12.1;
        Tue, 01 Jul 2025 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751394692; x=1751999492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGSR1+268qXSnAbGFjg52/5RelVsYrvQ6RHRNOoVlp4=;
        b=Qror3dzs3p26zs6epwDYnDES+LF5Jw/K3WZQI6OoICu0NNWhiiwrjDPKoTVLBQnkVm
         Am0bOWeOANAspLVM4nOtCIpAEtye/Q54jsEyxUCwT8LDMta52DJ4CkEO+N0n9M4BRA6L
         v1FsTny2O4kO6yWucbH6ciYO9FQH1MDHxcjpXAEH+lB7jtIM31GsGBbxhrtWAxrGOszV
         AJlSatCotJ8jygdsO51zFaGir9nYBORJf0LAOobOpVQCDugd3YqfjEPB2x3w60w3kOfn
         FniMF4kZSd15hjn+vtUu4Llwc1tR5B4f5KP15evV72Ycr27t5dFFzmCSGNd/EdBTD60Q
         nysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751394692; x=1751999492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGSR1+268qXSnAbGFjg52/5RelVsYrvQ6RHRNOoVlp4=;
        b=ndi5dW3kiZ+VHn89XSWukiiONcgZP62Vvy4sjOrFrSgeT3NozrFlF7Uib2LR/IcDIS
         eRY3G4Uakq2AkGSWl2QiyST8Rvk5vuIai3GirVSmo3ql8Bc1I+AHKFfFZEpbvOPJe/I6
         LeDaZpxkw/GWxFyCMgwf3qWpKtqOTvbuybZ4FiKnnkeXIboBYG1M59QE+6myFZ6Ushgv
         8bj7LLgCKYqDFnonSLFE/ih7oUtg89KYCJecdjJ3P342l0tluMUZDo+bdmJpLrhaFIXm
         UfmW3DVE99crhBx7O/j893TZsDzAWnXPz1GzdQI3iq01K5SOBj4V5LBPDGOlJYviWJ8N
         WNvg==
X-Forwarded-Encrypted: i=1; AJvYcCWCcHDTxshM1tDHA57XmCtWj67mWyqkzPQdEBh9MbgHWY8upESXwr0v/1LO4zja1z0UZMuWTyaAuDK4y/ua@vger.kernel.org
X-Gm-Message-State: AOJu0YylPq4iF4LOW66o0spmpQwAoVIvslGi/ZuWe94nGukB/RULtyaN
	EnN8parlRY5iYJmaPoGmKWgbI45T9hBa5P+abB6eLjSiIX08FUq7mTbZoayh3PU6
X-Gm-Gg: ASbGnctWJivWb66FcL44G1+UOkHG1VbS5oEJnC4cwV6PecuJ24QMQjERLEUN5htIPWc
	KsmSE/dHdMD+12vVwRs8mVxBLkHaA7Pno2Q4Mujd3i4nePlvxgnvcbFy/PgQygGufi/ny+QsWHE
	WkTimOj05xBCFmjvpgh9VjDanFANiMe4QQMzc0WpsSx1bUhr9RbYAvU8hQ3rZ6K0umlNp9qRQDM
	L5sp2FEgBReRRTIVWU8iJovcsx//VKGqUUNznfnfBZ8wtruCoPBtEv/Wh6Sg5yUIi8Qus5f3ZR1
	vlYje1CAs35dkFi0QrE9G+0bZFZm9Ce0AKr7KLJ2eZWv4VrGwKJSXvZ82o01LdBcpM+Kqo7s7h3
	2faG6rda0a92RgCKrTUV3b1KqDd9wjWZL
X-Google-Smtp-Source: AGHT+IFblHAzwzGC7Z820EiJieU1PxcRCD6BEorQmoDKlU2lrnoIDmdqYqVbQVjSsIiIEW3Z/ponxg==
X-Received: by 2002:a17:907:3f8d:b0:ae2:3544:8121 with SMTP id a640c23a62f3a-ae3c17a2a3bmr14416866b.9.1751394691636;
        Tue, 01 Jul 2025 11:31:31 -0700 (PDT)
Received: from fedorarm (net-37-182-2-165.cust.vodafonedsl.it. [37.182.2.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca371csm929782566b.179.2025.07.01.11.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 11:31:31 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: don't call fsopen() as privileged user
Date: Tue,  1 Jul 2025 20:31:23 +0200
Message-ID: <20250701183123.31781-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

In the BPF token example, the fsopen() syscall is called as privileged
user. This is unneeded because fsopen() can be called also as
unprivileged user from the user namespace.
As the `fs_fd` file descriptor which was sent back and fort is still the
same, keep it open instead of cloning and closing it twice via SCM_RIGHTS.

cfr. https://github.com/systemd/systemd/pull/36134

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 41 ++++++++++---------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index f9392df23f8a..cfc032b910c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -115,7 +115,7 @@ static int create_bpffs_fd(void)
 
 static int materialize_bpffs_fd(int fs_fd, struct bpffs_opts *opts)
 {
-	int mnt_fd, err;
+	int err;
 
 	/* set up token delegation mount options */
 	err = set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds, opts->cmds_str);
@@ -136,12 +136,7 @@ static int materialize_bpffs_fd(int fs_fd, struct bpffs_opts *opts)
 	if (err < 0)
 		return -errno;
 
-	/* create O_PATH fd for detached mount */
-	mnt_fd = sys_fsmount(fs_fd, 0, 0);
-	if (err < 0)
-		return -errno;
-
-	return mnt_fd;
+	return 0;
 }
 
 /* send FD over Unix domain (AF_UNIX) socket */
@@ -287,6 +282,7 @@ static void child(int sock_fd, struct bpffs_opts *opts, child_callback_fn callba
 {
 	int mnt_fd = -1, fs_fd = -1, err = 0, bpffs_fd = -1, token_fd = -1;
 	struct token_lsm *lsm_skel = NULL;
+	char one;
 
 	/* load and attach LSM "policy" before we go into unpriv userns */
 	lsm_skel = token_lsm__open_and_load();
@@ -333,13 +329,19 @@ static void child(int sock_fd, struct bpffs_opts *opts, child_callback_fn callba
 	err = sendfd(sock_fd, fs_fd);
 	if (!ASSERT_OK(err, "send_fs_fd"))
 		goto cleanup;
-	zclose(fs_fd);
+
+	/* wait that the parent reads the fd, does the fsconfig() calls
+	 * and send us a signal that it is done
+	 */
+	err = read(sock_fd, &one, sizeof(one));
+	if (!ASSERT_GE(err, 0, "read_one"))
+		goto cleanup;
 
 	/* avoid mucking around with mount namespaces and mounting at
-	 * well-known path, just get detach-mounted BPF FS fd back from parent
+	 * well-known path, just create O_PATH fd for detached mount
 	 */
-	err = recvfd(sock_fd, &mnt_fd);
-	if (!ASSERT_OK(err, "recv_mnt_fd"))
+	mnt_fd = sys_fsmount(fs_fd, 0, 0);
+	if (!ASSERT_OK_FD(mnt_fd, "mnt_fd"))
 		goto cleanup;
 
 	/* try to fspick() BPF FS and try to add some delegation options */
@@ -429,24 +431,24 @@ static int wait_for_pid(pid_t pid)
 
 static void parent(int child_pid, struct bpffs_opts *bpffs_opts, int sock_fd)
 {
-	int fs_fd = -1, mnt_fd = -1, token_fd = -1, err;
+	int fs_fd = -1, token_fd = -1, err;
+	char one = 1;
 
 	err = recvfd(sock_fd, &fs_fd);
 	if (!ASSERT_OK(err, "recv_bpffs_fd"))
 		goto cleanup;
 
-	mnt_fd = materialize_bpffs_fd(fs_fd, bpffs_opts);
-	if (!ASSERT_GE(mnt_fd, 0, "materialize_bpffs_fd")) {
+	err = materialize_bpffs_fd(fs_fd, bpffs_opts);
+	if (!ASSERT_GE(err, 0, "materialize_bpffs_fd")) {
 		err = -EINVAL;
 		goto cleanup;
 	}
-	zclose(fs_fd);
 
-	/* pass BPF FS context object to parent */
-	err = sendfd(sock_fd, mnt_fd);
-	if (!ASSERT_OK(err, "send_mnt_fd"))
+	/* notify the child that we did the fsconfig() calls and it can proceed. */
+	err = write(sock_fd, &one, sizeof(one));
+	if (!ASSERT_EQ(err, sizeof(one), "send_one"))
 		goto cleanup;
-	zclose(mnt_fd);
+	zclose(fs_fd);
 
 	/* receive BPF token FD back from child for some extra tests */
 	err = recvfd(sock_fd, &token_fd);
@@ -459,7 +461,6 @@ static void parent(int child_pid, struct bpffs_opts *bpffs_opts, int sock_fd)
 cleanup:
 	zclose(sock_fd);
 	zclose(fs_fd);
-	zclose(mnt_fd);
 	zclose(token_fd);
 
 	if (child_pid > 0)
-- 
2.50.0


