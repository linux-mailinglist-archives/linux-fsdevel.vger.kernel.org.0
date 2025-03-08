Return-Path: <linux-fsdevel+bounces-43501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9658A577A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 03:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD3F1610BB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 02:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261C114A0B7;
	Sat,  8 Mar 2025 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0PFhym6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB62E545
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741401199; cv=none; b=SUMxavOAG1EU04qCekLe7F6QuirQLMwlxBHYYise59n95Zi1ULf9gEbYqXtaZvaJ+Dy8p8fQWvtcx9LTkGBnoDq8E+F9O9C0jkApIEjQGPUhnGXoOt80IgBh+yHBkiPWUHMhU61KKEcGIsg7yAk1VH/ki1Mh5UpEAZ+rA33ZZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741401199; c=relaxed/simple;
	bh=8y7jXNcb6ARWEXok82aZRH5T5isSwP8i7PMYGI1wjuI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EHdYNQPV27h+GVxq0UCt+GMw+z2Xg6igvOoG0OLkRGkonqnspGhFQeNMEpcAbUmox46PG0U+igIoW1l76+Qz3AeAhcfgzOqK0MI312oprLWtvLh8v08lZw4QOHPQwhLkBhavDU0yVrhmfZXF+06Lml3qbNLcBF2JaWfQHTLFJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0PFhym6; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-5feaeffd84cso796657eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Mar 2025 18:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741401197; x=1742005997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jKzjjHkyghJxAnuAXwC3PWRJfez3LkNv1m9ZaRZ16eg=;
        b=k0PFhym6QKycn58ms3PcuKzU7mFgWoQakPp97JPvFg7L27Cc71YeteHgTaTZZaMlnJ
         ogd3lgesN/Dr84dReNV7LCtztys27zpM1ZEg7Hm7KRMF3OZfZrj4vt/mt/uv8cOK+W/1
         sUH6gukIFwTe9ddB0ik2DoaH0VftCFTA4RbJSMqK/D9ROb0EJ1v/c1cC66LdIYpeX/I6
         UDm6hcQPo18bW9XLQVGIrBWhVmSLkhbUw1IXoHVyWUYlR0+aHMCsJNx6TWQ+oU92JJrG
         A1evKqbcjClZZ541zWLBbHkTtuzdlcC1g+XH+LQbrbgNh36Lit7QcEJKKuv4hF1b4KpG
         Yv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741401197; x=1742005997;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKzjjHkyghJxAnuAXwC3PWRJfez3LkNv1m9ZaRZ16eg=;
        b=Pb3EERZFek6PuJuB1lYNVKKxYXLR6dFaTflbcDDXjdlXIYVvqZ6H+1tZNNuceVUoEC
         B66y8VFxEumtCDb4QG4UWHboI0qejZ4RlH4A5+5kLxrU+fNjVW4FurBAa+FTIN0vjrtc
         x1fd3yuQWQohPnUOGZAfKAx97X4AIHjyuDyL65U/3BrPbdFw+aCI/oEH/3t46i2PEFSy
         r/VkCergJ593mFR/agP4xytAVJY0vjWpAkYvZX80gNkgqtgGAW6NLr1vxVmxOq2n2VKn
         NpxA9ICtmkJJItKbQrrR2VZnDZnbYgBMj5rKwE8Io4r6/aYH7qEwRB7gclWs1t1KRzwh
         nhog==
X-Forwarded-Encrypted: i=1; AJvYcCXd1ZmnhZsRnJHO1qcaEhONfnI6bAecizQc1fovoMAvKgEJTcKIvZRZliHw5fuY+YECwoQLSPi1VXsdApJi@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHoSxerESyl8SgrvavSpT8AB7QpagFo546DgC5VfDj7JMfK8Y
	tdfq+OJLOrv4pJBApF9mTRlNTr113/0/hrJOpx4otvxQ98JojHxVPqnDQUHreKFeKA==
X-Google-Smtp-Source: AGHT+IFFZMokntAqkxOEmyT2cvJ9U4fSWph4TCXA8wvZ1kT5cN4sra8A6sENMM+l+kubdYKyBOP+ETg=
X-Received: from oabnw7.prod.google.com ([2002:a05:6870:bb07:b0:2c1:c983:48c1])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:264e:b0:727:345d:3b7b
 with SMTP id 46e09a7af769-72a37b41aafmr3231129a34.5.1741401197125; Fri, 07
 Mar 2025 18:33:17 -0800 (PST)
Date: Fri,  7 Mar 2025 18:33:13 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308023314.3981455-1-pcc@google.com>
Subject: [PATCH] string: Disable read_word_at_a_time() optimizations if kernel
 MTE is enabled
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The optimized strscpy() and dentry_string_cmp() routines will read 8
unaligned bytes at a time via the function read_word_at_a_time(), but
this is incompatible with MTE which will fault on a partially invalid
read. The attributes on read_word_at_a_time() that disable KASAN are
invisible to the CPU so they have no effect on MTE. Let's fix the
bug for now by disabling the optimizations if the kernel is built
with HW tag-based KASAN and consider improvements for followup changes.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
Cc: stable@vger.kernel.org
---
 fs/dcache.c  | 2 +-
 lib/string.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e3634916ffb93..71f0830ac5e69 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -223,7 +223,7 @@ fs_initcall(init_fs_dcache_sysctls);
  * Compare 2 name strings, return 0 if they match, otherwise non-zero.
  * The strings are both count bytes long, and count is non-zero.
  */
-#ifdef CONFIG_DCACHE_WORD_ACCESS
+#if defined(CONFIG_DCACHE_WORD_ACCESS) && !defined(CONFIG_KASAN_HW_TAGS)
 
 #include <asm/word-at-a-time.h>
 /*
diff --git a/lib/string.c b/lib/string.c
index eb4486ed40d25..9a43a3824d0d7 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -119,7 +119,8 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
 		return -E2BIG;
 
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && \
+	!defined(CONFIG_KASAN_HW_TAGS)
 	/*
 	 * If src is unaligned, don't cross a page boundary,
 	 * since we don't know if the next page is mapped.
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


