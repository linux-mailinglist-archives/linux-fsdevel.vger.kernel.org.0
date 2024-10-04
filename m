Return-Path: <linux-fsdevel+bounces-31036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F19991097
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59711C22F59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6461ADFFA;
	Fri,  4 Oct 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEWkw0Pj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7185231C80;
	Fri,  4 Oct 2024 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073767; cv=none; b=LrRYG9SNM2ZUtwe5za29NgowUWipHxxTTm8J0QERq+gvcA5BLj/adYHFzRYr+gI941vCQS5oEYkewiK3XMYRa67qhNQBvKMJ9L0ECnuTAMTP/gVnQOaszzlT3OpJnQEvP7xeEcQ40SARxkEYd1/DufkUODIiAeAas0cFsYxvH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073767; c=relaxed/simple;
	bh=EAWikPEgBRDcPQVvYschVwTUbFp2A2GnHRw6U8lWf/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VABEZp7RhrEDRC0bLKY3AemLxWK05MUPr9z3sLt0UgtkIX64jIcFgTD916GvhSmOm19irKwHjrdE3WNfVrj+Cy9CTvnAvqlzHoBrirksM3Fts+3z1wLZUmK+mREvKUZ5AQFA/+tHc4b18RqrZ9v5B0ab5WLm7KLQSixcna9a/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEWkw0Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D85C4CECC;
	Fri,  4 Oct 2024 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728073767;
	bh=EAWikPEgBRDcPQVvYschVwTUbFp2A2GnHRw6U8lWf/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uEWkw0Pjiw8jWyrIk2sOJs1WxJD6fhDL5sW+VYmqI0nc3SGdkPygyhUxxwc0bzj+V
	 cXQ5UgKZnCepgNi+H2KM0G5wCYdo4q4vr5bIIbnTDtsCtAXdSnsEYW+dffGpgI3fTK
	 Fh1QkZIjmcIzIseor/Xhe18NXFqX0sG9KBXGJHZs3LIrpry8QjgbmdsKuk6+UNjI1w
	 LoteBJfguzR23NfKBz0dVwmUQxwyQmsxkuQuPWyl80AY/5RW4Lzf0AyWMsIu6fIsOs
	 1oJoyLqck5qguyPFWxUA9pvK3aYNl+inpbYtCYdoq1wj8m9ZSc0FB4LfNNUNQ5cw64
	 vv/HaYpDnwD8A==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 04 Oct 2024 21:26:29 +0100
Subject: [PATCH RFC v2 1/2] binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-arm64-elf-hwcap3-v2-1-799d1daad8b0@kernel.org>
References: <20241004-arm64-elf-hwcap3-v2-0-799d1daad8b0@kernel.org>
In-Reply-To: <20241004-arm64-elf-hwcap3-v2-0-799d1daad8b0@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2313; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EAWikPEgBRDcPQVvYschVwTUbFp2A2GnHRw6U8lWf/4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnAFAfEtsuUDv/4hQuE+NlcqOoKmOut3E+Mphu2SzM
 02DaJeaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwBQHwAKCRAk1otyXVSH0PYRB/
 4k1lZXzkyNW2MOkIOzxzR9UIzyGg7f6hVKp6g+zvkR+sWx+qyl3ES0fxiZ7dlzvY3dA1v3smeW27hF
 l8a+Je0xn2rLSYd6IuoiacEn57zEUd0Hzkdzzw4O2mVH2WwIkWw/7YnYe6PVRLuxunkhrVS6Aalmjp
 pbbuL94P0JufS2k9tsv4cQA2a7jWsv2k7iHFEKB8XDH4Dwp/EV+wTtHL/TR6BWCeR1a+qBp2/0oQf5
 dZRK07kZ9H2M8/3ioktfSs75pAHwT63xDy7LvCJHrneU4HrdeoZVADkBhdbfVuoFOVKerP2+qrKmmj
 QK3OHTRSMnREjhop7O/MS2MPVcomaD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

AT_HWCAP3 and AT_HWCAP4 were recently defined for use on PowerPC in commit
3281366a8e79 ("uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector,
entries"). Since we want to start using AT_HWCAP3 on arm64 add support for
exposing both these new hwcaps via binfmt_elf.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 fs/binfmt_elf.c        |  6 ++++++
 fs/binfmt_elf_fdpic.c  |  6 ++++++
 fs/compat_binfmt_elf.c | 10 ++++++++++
 3 files changed, 22 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 06dc4a57ba78a7939bbde96bf181eefa950ea13a..3039a6b7aba4bd38f26e21b626b579cc03f3a03e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -257,6 +257,12 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
 #ifdef ELF_HWCAP2
 	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
+#endif
+#ifdef ELF_HWCAP3
+	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3);
+#endif
+#ifdef ELF_HWCAP4
+	NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4);
 #endif
 	NEW_AUX_ENT(AT_EXECFN, bprm->exec);
 	if (k_platform) {
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 4fe5bb9f1b1f5e0be6e8d1ef5b20492935b90633..31d253bd3961a8679678c600f4346bba23502598 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -623,6 +623,12 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_HWCAP,	ELF_HWCAP);
 #ifdef ELF_HWCAP2
 	NEW_AUX_ENT(AT_HWCAP2,	ELF_HWCAP2);
+#endif
+#ifdef ELF_HWCAP3
+	NEW_AUX_ENT(AT_HWCAP3,	ELF_HWCAP3);
+#endif
+#ifdef ELF_HWCAP4
+	NEW_AUX_ENT(AT_HWCAP4,	ELF_HWCAP4);
 #endif
 	NEW_AUX_ENT(AT_PAGESZ,	PAGE_SIZE);
 	NEW_AUX_ENT(AT_CLKTCK,	CLOCKS_PER_SEC);
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 8f0af4f626316ed2e92204ff9bf381cd14103ae9..d5ef5469e4e620f6ee97f40ce9cbbfa48e37e33c 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -80,6 +80,16 @@
 #define	ELF_HWCAP2		COMPAT_ELF_HWCAP2
 #endif
 
+#ifdef	COMPAT_ELF_HWCAP3
+#undef	ELF_HWCAP3
+#define	ELF_HWCAP3		COMPAT_ELF_HWCAP3
+#endif
+
+#ifdef	COMPAT_ELF_HWCAP4
+#undef	ELF_HWCAP4
+#define	ELF_HWCAP4		COMPAT_ELF_HWCAP4
+#endif
+
 #ifdef	COMPAT_ARCH_DLINFO
 #undef	ARCH_DLINFO
 #define	ARCH_DLINFO		COMPAT_ARCH_DLINFO

-- 
2.39.2


