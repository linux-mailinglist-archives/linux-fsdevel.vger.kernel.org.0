Return-Path: <linux-fsdevel+bounces-36305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DA9E1263
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 05:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AA2282ABF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 04:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EE014B941;
	Tue,  3 Dec 2024 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWm7AiaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D462BD1D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733199808; cv=none; b=h0u+M4EeEjJkRunX9W07Hmu+uGl3OmGJPtj9n7rF0RsQlg+cVevOFC2MgP+3UzFZcKnZ/XG+km+TgyxSVKldB/cqZefnEekOMegoT7+X0LdltW1laS6bGOf4ryJEUX+wIKgA/rCm3/KaPuK26+xrbBbi9NmfAp/gy1JzA7ksnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733199808; c=relaxed/simple;
	bh=VnAijWycY27v/ZEoUwG9XDvgf4fiUkPZp0Ki0GmZ+Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAtGiCoT2FbZiKlEywz7myExpDxZL0HAtOZWYw2MobLU7efSSglsY56rYT85SHWB1icCXEpEBaVd8Pepurs/zsUGiADYJWW2vjqOXzUfENlbnffHp8FqF4mDntqZ6prAwuseGUbrZsW19IZ+6TLUfleCrW3oVF8Lnw311+cxiOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWm7AiaZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724e6c53fe2so3760022b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 20:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199805; x=1733804605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZLXAGKXJsQaUwHOfGxb1XieHVDcZBF9xpfXO7H06r4=;
        b=ZWm7AiaZEhNEH8TXea3xkGydRYXm4WIR0UMe0+SVwdsuSFdTzjJUEM9QQFRt96LlJ8
         1wgs1Rua4S4I+g8Ih7ff5NAJl5w6GehCGKtgjTyh19CiTJTCSBzjrGXk1er3fV1Uq6gS
         4YKe0LBGDlAoEOIb8Cmb2b3n+7CjOjcZTquhZ17uH4t2x7Go385BfS8gO2n4zoZxTQYP
         4YTuqNIxuhi45qNWBlBpPChs9hhvTugbfwqnug+JB2W4/3Dkwwo2K0Xzxu7oesasbYir
         Eq6FoyusTMjdi4yObzoy6c0KlEE9ZiZQPWe0ThBM3mM7YOs4fFqgRbIV9ksTf+UWToVG
         qHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199805; x=1733804605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZLXAGKXJsQaUwHOfGxb1XieHVDcZBF9xpfXO7H06r4=;
        b=VTxkeUpc36/NOrCVut9qMzSRcEN9tUjOIHyec65dMjchwx/eGm3YU0ckiXTsYPaxXJ
         810weUC4aTEzHUM0gCRAU1Vkf2gCXIg0fltmBVq3t3WpbhnIQToyjMaGJ6fZopsm6JEI
         9QmqSswfmQ3kRCx9MuKhbG49wg9H5Kkz7cuAFRKDx6b+/lLd4LBw899InXakphXkBKxJ
         EfWLgzYnjmcf3LA0Mc0QVCJn9fLtXd0VjlcGE9bwXK0v8ZUNFrOzAf7eU3biAC/p5+M7
         zikS6YkgXrnCHhllnhBrjf+cjhNVbtccFI9cAiRESkdW1NgWw/elEMBZr9L74HO4eMFd
         Ewkg==
X-Forwarded-Encrypted: i=1; AJvYcCURJZn1SmQLMsNEkxe3PzvhBZVY+QsWEt5DvRC0btKNSRL3Yc3RvNnPvSlmT8AQRVe5FKXbQ2J24zCLA0MV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4u5/DSu6wVt2RivZ+/qdmxHIjaNjzGxwY2eMfGTNvFkE3IMpQ
	V+u7BOi/uqZdKpji+nZukfIsIEirnz5gDe0Iha+YYXqJvwdhEIRL
X-Gm-Gg: ASbGncsnwoj5k+QDEfir9WZbsFiioWNH/YxR4ciHV2pYOjKdqj1dFJZEgyfTd+s0AFQ
	2Cf65AIE7flwsm8Rns6ULiS98IU0tei3VE0VliwyIIlE1BSq7FVvVhvHts/rVPiQd2yXQqlxoPB
	mIytXiUWxwycdH2v6ALqfxTEmV0lUhekk8hhnNzGdAJo2Wrb9Z+ZOQv6AvaK7vDyRXNFfdxiXVv
	6HoII+nb/pJck5AKSGdU822N8H+kXRZ0YvR/wBk5t7jMxrKWScngPtPcUh1FUklPz2Cg6liVmO6
	ILuvr4Vw/KTLh3eV2tJl
X-Google-Smtp-Source: AGHT+IEnZhvotlCjjz+IuKEwK7J+M5+ZOMsyE8W8PZJgKuTfhkpQKEsccmo0ddOI+80XWjCWIaLEfg==
X-Received: by 2002:a05:6a00:a02:b0:71e:7174:3ae with SMTP id d2e1a72fcca58-7257fa7272dmr1565478b3a.11.1733199805137;
        Mon, 02 Dec 2024 20:23:25 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176121asm9369077b3a.39.2024.12.02.20.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:24 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id CFF0EDD39F9; Tue,  3 Dec 2024 13:23:22 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 01/13] fs: binfmt_elf_efpic: add architecture hook elf_arch_finalize_exec
Date: Tue,  3 Dec 2024 13:23:00 +0900
Message-ID: <564f58c6c893f8817b07cb192b254f760c256580.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FDPIC ELF loader adds an architecture hook at the end of loading
binaries to finalize the mapped memory before moving toward exec
function.  The hook is used by UML under !MMU when translating
syscall/sysenter instructions before calling execve.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 fs/binfmt_elf_fdpic.c     | 10 ++++++++++
 include/linux/elf-fdpic.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 4fe5bb9f1b1f..ab16fdf475b0 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -175,6 +175,12 @@ static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params,
 	return 0;
 }
 
+int __weak elf_arch_finalize_exec(struct elf_fdpic_params *exec_params,
+				  struct elf_fdpic_params *interp_params)
+{
+	return 0;
+}
+
 /*****************************************************************************/
 /*
  * load an fdpic binary into various bits of memory
@@ -457,6 +463,10 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			    dynaddr);
 #endif
 
+	retval = elf_arch_finalize_exec(&exec_params, &interp_params);
+	if (retval)
+		goto error;
+
 	finalize_exec(bprm);
 	/* everything is now ready... get the userspace context ready to roll */
 	entryaddr = interp_params.entry_addr ?: exec_params.entry_addr;
diff --git a/include/linux/elf-fdpic.h b/include/linux/elf-fdpic.h
index e533f4513194..e7fd85a1d10f 100644
--- a/include/linux/elf-fdpic.h
+++ b/include/linux/elf-fdpic.h
@@ -56,4 +56,7 @@ extern void elf_fdpic_arch_lay_out_mm(struct elf_fdpic_params *exec_params,
 				      unsigned long *start_brk);
 #endif
 
+extern int elf_arch_finalize_exec(struct elf_fdpic_params *exec_params,
+				  struct elf_fdpic_params *interp_params);
+
 #endif /* _LINUX_ELF_FDPIC_H */
-- 
2.43.0


