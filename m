Return-Path: <linux-fsdevel+bounces-72711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47223D01097
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 06:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E39630386A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 05:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379A52D7801;
	Thu,  8 Jan 2026 05:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQm7idG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E012C3259
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 05:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767848875; cv=none; b=pAZAeyarrN8KEfVy5cM49QeEc8dlxGWlqsXgGT5sUCgNbICJcmsNtjmk1KEcVaTcx1Ql7gmH4c3iOaaes+hDSIWeOWHrVqPSXzCLUfmi5wLYfgaCXM2R+8aqIe7/ZHG/6n5vlZigSQZhSHBhwDoXd9uRbJ8DyWH4L9EyJ6qBxQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767848875; c=relaxed/simple;
	bh=LNdHpOYhkvVAHh3PEnvRLPGEb6i8i1k190yRkr69lE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rzVvl5q+t0E4hQdyiFSRJB2eoy2qUeSoJf6LNUxFhqhJzQFRwHPKdWBi6EhHhbSSuu86//cvvo/cUjylpHugXm4mat+ezU3ZiktPZjh0pDZx7VggVSQ3pKChHuS6WrtKSXbpa7kAhK05/XwyyvnWamN6avpnuRI+tMXgN2ZxGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQm7idG6; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-65b26eca9c7so5727341eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 21:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767848873; x=1768453673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZQOsX2pgJ2tnboOIsX6ynvBnKeb3FSCcqmuKWQBi3o=;
        b=aQm7idG6Y8g87Tiq+iYeWpgRtGJyR9GxZJL2qWkk1Mpex0dYB2FSa+FlKn2huOXG5X
         IOsATT1PUDq60qH3nOXOR9M+ldjznDn+KVVHQDSZeTBOpln0U0bAQmqwbxgo+p7huEmv
         F0RGbDBs8Il9IVQ9I2AW0j9fhLalHaZcFyIEruGDprYEUD1atGDRyFgBcPnKXGFAxHRN
         BV2t4Vw3Z5LGdBQkc86YsVkuAGFOMNec+OA7a4bxLFawz6bcCvXdIOr08GnFergcQarp
         /1bCRZnr9M4xev5emzx33g7F8pSEVxjcPTsSdtTe8TdoBkmKew/RkQai3lSprfLuCDr0
         12zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767848873; x=1768453673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZQOsX2pgJ2tnboOIsX6ynvBnKeb3FSCcqmuKWQBi3o=;
        b=wAZjkYsIb+Xw+L96QR2PEVYNDTVpwZLVHRqLphzC1Tqr+mlZfYsBWFTZ3v/KmLukBn
         OTeIQnlWN6l7gkan/Vr20g9wqfyEzajRfj6tRQyFpkw590FWhpShPhvytVmrWT+KbTRv
         Z/ND2rNH0xsBCwL6aESJ+94r4vcwfC0O6d78EIMIiZHjZtNogGxhOO2bjR3XlqYkWiqF
         G8Gj9DFTFGDukhQrw89a99vNzYQQ7LVIEj8hmjfI8otM/c8YROMxDjbWJIVJVbMB7YcH
         Xd9UKZECyWV0bicAENXSVkV7viOsQNEH9QnA23/CBDC2ISBQX7GlyRMOmsy4unKB9aqo
         HDfA==
X-Forwarded-Encrypted: i=1; AJvYcCXiAJZap7QDbqtQ7i+oI9VJZW8fZbyLGfEXCFNRmi+NrXGq7kEHFJcoRrAinSaNbAn8fPjr2G5O6As5VTY8@vger.kernel.org
X-Gm-Message-State: AOJu0YzCwEOMBkomZobynYDK1wzyq9JeuOyp6LkKTkTgfsRu3XaAaDTw
	+Qnh0FBinolDdPxyt5RsB3c41RU1mqHtY7ZkwijhFyK4GKLKP9N6TVsv4tCkMVvbtanQQz9XM6r
	Q3MDeSA==
X-Google-Smtp-Source: AGHT+IFrclr5UQo7zl+uW+fx86un/1H6WIw+B6ZZGi+Mh3xwDR/cU/G0W87Tu8yHbTlESc7N66Kjw62yaIA=
X-Received: from ilbdr9.prod.google.com ([2002:a05:6e02:3f09:b0:439:46f3:4729])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a4a:d666:0:b0:65c:f12c:e74e
 with SMTP id 006d021491bc7-65f54ec7815mr1678998eaf.6.1767848872864; Wed, 07
 Jan 2026 21:07:52 -0800 (PST)
Date: Thu,  8 Jan 2026 05:07:46 +0000
In-Reply-To: <20260108050748.520792-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108050748.520792-1-avagin@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108050748.520792-2-avagin@google.com>
Subject: [PATCH 1/3] binfmt_elf_fdpic: fix AUXV size calculation for
 ELF_HWCAP3 and ELF_HWCAP4
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, criu@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Koutny <mkoutny@suse.com>, Andrei Vagin <avagin@google.com>, Mark Brown <broonie@kernel.org>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Commit 4e6e8c2b757f ("binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4") added
support for AT_HWCAP3 and AT_HWCAP4, but it missed updating the AUX
vector size calculation in create_elf_fdpic_tables() and
AT_VECTOR_SIZE_BASE in include/linux/auxvec.h.

Similar to the fix for ELF_HWCAP2 in commit c6a09e342f8e
("binfmt_elf_fdpic: fix AUXV size calculation when ELF_HWCAP2 is defined"),
this omission leads to a mismatch between the reserved space and the
actual number of AUX entries, eventually triggering a kernel BUG_ON(csp != sp).

Fix this by incrementing nitems when ELF_HWCAP3 or ELF_HWCAP4 are defined
and updating AT_VECTOR_SIZE_BASE.

Cc: Mark Brown <broonie@kernel.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Fixes: 4e6e8c2b757f ("binfmt_elf: Wire up AT_HWCAP3 at AT_HWCAP4")
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/binfmt_elf_fdpic.c  | 6 ++++++
 include/linux/auxvec.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 48fd2de3bca0..a3d4e6973b29 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -595,6 +595,12 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 #ifdef ELF_HWCAP2
 	nitems++;
 #endif
+#ifdef ELF_HWCAP3
+	nitems++;
+#endif
+#ifdef ELF_HWCAP4
+	nitems++;
+#endif
 
 	csp = sp;
 	sp -= nitems * 2 * sizeof(unsigned long);
diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index 407f7005e6d6..8bcb9b726262 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -4,6 +4,6 @@
 
 #include <uapi/linux/auxvec.h>
 
-#define AT_VECTOR_SIZE_BASE 22 /* NEW_AUX_ENT entries in auxiliary table */
+#define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
 #endif /* _LINUX_AUXVEC_H */
-- 
2.52.0.351.gbe84eed79e-goog


