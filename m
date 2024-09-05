Return-Path: <linux-fsdevel+bounces-28800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CD796E610
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 01:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17194B2380A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 23:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C41B81DE;
	Thu,  5 Sep 2024 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvcd7lyX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB313D638;
	Thu,  5 Sep 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725577616; cv=none; b=DFh70B2C8I68JsHOAbGN/WeaJzTTY7P8Qs9v9bVRll2mA3FuBaCWzxLm/XmA0qHelj4kPoWUifoPB8ZL9kAKPC2bVYQKWJVoTl+/NRwScILXcCOv/WCtlJDVOYjq/WiAL2RNVPlyn09T3vYKT90er1pmmaZ2GbC6JKGqeu/sxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725577616; c=relaxed/simple;
	bh=1CvHL3X1djqDDP3CHNqU2LnQvflMkgfKJ74BejW/qME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e1xDdtuXAxJ7yIX3Ko7Rt3M7XmFgq9QFxNO3f69QE2jM0482RXcW1BLPEARFeP2UQOSbQNoxVDC0YBujjHxs1UykVaEYkEPfKRZvWRWoV4x8vR7r5HOqFuzqRUGB4MlNJt+JS3HkQvSSoIUrDlxIpiNCKzMAQnhR57xFA8hb/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvcd7lyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C961C4CECB;
	Thu,  5 Sep 2024 23:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725577616;
	bh=1CvHL3X1djqDDP3CHNqU2LnQvflMkgfKJ74BejW/qME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pvcd7lyX1KomLXt/dqsCYSLKNtxZbL34j7YsWjdm+D58Rn3qDSfmpe3xAEOq/2xey
	 UKXPAVFb/SaeC7C6QJQEitBfhd/0CCKh1HRQ3H+PX9RfTmuXPE1RbiTNgEkD+1NuZJ
	 Qa/6sFKvp8ax8EQHXPhtQ6TDtDiXR4zsheMiSmsPfSEFF0+RcQb59CdfOqwbQtOzut
	 VIsnHQ6jAOYujY7P4/hISWe5GmHGSmkcm1ue+l05+sU+Kb7ipZmuj8AVkJiil4FokG
	 I8v2OVLoOvJ8oECDILspnAfWKWvAtP9+u8iRL1Rw8dVm2U3UwTfgGvUbSuNZ4aOn97
	 zxMSKXrNT9Z+w==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 06 Sep 2024 00:05:24 +0100
Subject: [PATCH RFC 1/2] binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-arm64-elf-hwcap3-v1-1-8df1a5e63508@kernel.org>
References: <20240906-arm64-elf-hwcap3-v1-0-8df1a5e63508@kernel.org>
In-Reply-To: <20240906-arm64-elf-hwcap3-v1-0-8df1a5e63508@kernel.org>
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
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1CvHL3X1djqDDP3CHNqU2LnQvflMkgfKJ74BejW/qME=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm2jmHlUSCTyEan9xj94QRH1fAPoiO8sniob91kWqs
 wH6MgeeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZto5hwAKCRAk1otyXVSH0DGUB/
 sFykES43Vs38+h/g2aRkA7jtFVqXh7lOkhSkwiC5Rr4cxo6nLWNN46KSAenJ8uhtF62W+4pUoxtqnI
 r/MAM5CrzP9nw5o7N58DXaqk6uu4Aycy28541fxl8CfoyxPbS0fI1+pxzoIJ2+xTLs8fsalDNl7INS
 QjY4YmTG1HUSjFhZWRD3D3jDYEYafz0KSJh/im4w994yOuWHrRzuW5pM5GQv17vsFmtiCo1DnuxPZS
 dpljF575hDc2xKb/MGfNkqgr//E9dy/pvF6YAg7d9flsPxHyF5INnnzXYKdt1ebM6nEhFzT1OTBdFZ
 hJAgfovynsR+qGSYI5lCrPuvhN9rZ+
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
 fs/compat_binfmt_elf.c | 15 +++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 19fa49cd9907..32e45e65de8f 100644
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
+	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP4);
 #endif
 	NEW_AUX_ENT(AT_EXECFN, bprm->exec);
 	if (k_platform) {
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 28a3439f163a..9365f48598a1 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -620,6 +620,12 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_HWCAP,	ELF_HWCAP);
 #ifdef ELF_HWCAP2
 	NEW_AUX_ENT(AT_HWCAP2,	ELF_HWCAP2);
+#endif
+#ifdef ELF_HWCAP3
+	NEW_AUX_ENT(AT_HWCAP3,	ELF_HWCAP3);
+#endif
+#ifdef ELF_HWCAP3
+	NEW_AUX_ENT(AT_HWCAP4,	ELF_HWCAP4);
 #endif
 	NEW_AUX_ENT(AT_PAGESZ,	PAGE_SIZE);
 	NEW_AUX_ENT(AT_CLKTCK,	CLOCKS_PER_SEC);
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 8f0af4f62631..0a219e26692a 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -80,6 +80,21 @@
 #define	ELF_HWCAP2		COMPAT_ELF_HWCAP2
 #endif
 
+#ifdef	COMPAT_ELF_HWCAP3
+#undef	ELF_HWCAP3
+#define	ELF_HWCAP3		COMPAT_ELF_HWCAP3
+#endif
+
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


