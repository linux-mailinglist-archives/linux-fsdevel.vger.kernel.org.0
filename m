Return-Path: <linux-fsdevel+bounces-19731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67368C97C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 04:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0B1280F83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 02:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A6BC8CE;
	Mon, 20 May 2024 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AodUziKH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB130746E
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171379; cv=none; b=Dynba9DIevOnLaP8YlCjZ5ffMWmRsO/HtN95zrSmHQwS8+Kk4Nw/+J2HuI0Dkl8yoBbllCIsm6Th54+D6XDVny9w+X0VGLHppZLqTT4RtTrG44lIpuBMLuknKlZBdXdH6pm39qhzMCpmpbpNWxTKKhqUnKKt+eCbEpuF8X0j1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171379; c=relaxed/simple;
	bh=m0sCs3UZgNNm707rXtEZ6kEPFezkWis9xLUpPwvfVyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uhg4H8py+9DO9xFhiSzhY0hy1hA/nCkKAHBoY499+PN6GN62R5FuWVubUwmj8hWD5zmEmSM08DwyaDwZWcVRn+HccvwEcLe+u/pPJKLRqgKrqVCRueFlzNcsEVB+6Awy33TrXqYY13/+O5qGszNknsbMr2Z1Uf6E9RANW9otrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AodUziKH; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f12ed79fdfso934529a34.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2024 19:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716171377; x=1716776177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXk5PQZLOhlOb9f2TikaNKwPS1UYUorWP7IN+mVzocE=;
        b=AodUziKH3K1znxbSBf7VutSqTfdM0qQ5EMHvxhipi/S+Q2FjwVCymBIAjbEDmYIjuT
         9h2h5xu0SOfGlxhOTgbEkinWgfe9ilDd8iI86SYXeHj/aMg2rp9R5D5bp3CeM8S69T3G
         hlOSnOPUXaYqWRyYqOSk+N/nzjdSogKXFQI5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716171377; x=1716776177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXk5PQZLOhlOb9f2TikaNKwPS1UYUorWP7IN+mVzocE=;
        b=vxQEl3S+AD1gdV3vfEvnWbSLEOIhFng7p5BV8QW4fCe3c18JcImPhuWojZ/yFk8cjj
         oymXGsVZ92cyUqnb5PCJYypQ33l4Igz4hO2cbA8IsCe1QSqWeoMs8PUK4XH1aZGQogm2
         BzEBd6LkyZbcBNgzn4kH+oQafaDIrbKXkakkXHu9Ai+l5VnWhjGeLJDqv/xRBw9mGDyg
         aco91+5XuvQsJAqkuUhgC3bZUFJ791rlOnaFJ5uGtUxEvdpqqw/xcyLOpPma33p1LTKE
         0FsnZS70Pgo3ezcGy5aBlcRUCC5Dh4apwJopGFBbittESHEsi7SNIwVEwzDCDmQLjnHM
         n0PA==
X-Forwarded-Encrypted: i=1; AJvYcCXwYDK8m15/Y2BGrq80XMQbdNe36DGiYolthpk0xsgM8FOqHWUqsCIDBnSWzlOlfvygAFcUvjB/AqcwV5tVNXE5uMOWfkNHPrOwALjwOA==
X-Gm-Message-State: AOJu0Yx2QFgpxGujmrb6OQ/iyaQhECfO2uyXo4GD6fpoIj6BTSqJ98o4
	F/cWKU/LXq/+t6jRMMyVaXAkjuu1T8nQbDycmdHAJ4wufEN+ADu27IboY+lDFw==
X-Google-Smtp-Source: AGHT+IGCk56SRj37cV6IB9o0SSSdmvK7eIfw1zNZrwdb/ilDu1xfVdX+ZV6pQVOmzEM5QVnWzLp20A==
X-Received: by 2002:a05:6870:6b9a:b0:244:c620:7f4b with SMTP id 586e51a60fabf-244c6208e5dmr25152033fac.32.1716171376722;
        Sun, 19 May 2024 19:16:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0d88sm18130632b3a.122.2024.05.19.19.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 19:16:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] exec: Avoid pathological argc, envc, and bprm->p values
Date: Sun, 19 May 2024 19:16:12 -0700
Message-Id: <20240520021615.741800-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520021337.work.198-kees@kernel.org>
References: <20240520021337.work.198-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4282; i=keescook@chromium.org;
 h=from:subject; bh=m0sCs3UZgNNm707rXtEZ6kEPFezkWis9xLUpPwvfVyU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmSrJsc9KHOfxr0Wciwne6IO1ZYX00AOmo6RSzn
 ssGypyJUcmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkqybAAKCRCJcvTf3G3A
 JsKKD/9uBa8Jg3Y7sh77JlX02ZEuM20xIOhSZRe/yX+ttzgjv6KsJ9e3EIzgOYyNTIetZdFOmUb
 t7Mw60rDwAc5bbFe12eX/hkmt1YSB65lOeZh46s0Pvb0yVyjdgvu7JNmVJav2jDq97QQfVjpbQL
 8Lyv6j+6foBWoBRnIwTVPXKlVz1By4gwEVfkh7B1vHQyDU1T0uC3LJ3cI4TtM0Q5kf/OdNrG7Go
 dkULpZMKwZJXiLDtJxOWAzncvtbcHJpMh2a+kEde/uu48+ASF8pQYWAa7uHHnhmF5ic5z6+Sp0u
 H+c2g3O+CnK7HKpNC6/kPNQktzYH0YHsn6SZTovtLwkgHJctXZMNx+6u+0i+9HT4konRiJttZUf
 tJXAxAljiX1a9z2NcyqjkRymJmABRN+tnuT7PU4QwPrzcrzMWPNRQyo9Tkt6Wcnyqyv/OcGcuZI
 Qx+xQCDv+Pmjn5D3ccDOTJ3Xmp5ZmZzVCw3CJBAM05GyVuKO0dm6b9i/hATOiP8oNQztwOHg671
 NES0OBKauNxcL9Ob7iGOT8Jtc+gZkkrdNw/8K6IGViwNkZY9lzH5Lt14+HgRT8jpKdmC5GlEdDL
 YhbDjJZJ0aJNroXppjbZpDpNNuiHqPewUDpRlFh5orwTPevgk8c9hGJXEn1xDtG/0cpcx1Vesj6 xd0fVBCgpYbeRWQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Make sure nothing goes wrong with the string counters or the bprm's
belief about the stack pointer. Add checks and matching self-tests.

For 32-bit validation, this was run under 32-bit UML:
$ tools/testing/kunit/kunit.py run --make_options SUBARCH=i386 exec

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 fs/exec.c      | 11 ++++++++++-
 fs/exec_test.c | 26 +++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1d45e1a2d620..5dcdd115739e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -503,6 +503,9 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
 	 * of argument strings even with small stacks
 	 */
 	limit = max_t(unsigned long, limit, ARG_MAX);
+	/* Reject totally pathological counts. */
+	if (bprm->argc < 0 || bprm->envc < 0)
+		return -E2BIG;
 	/*
 	 * We must account for the size of all the argv and envp pointers to
 	 * the argv and envp strings, since they will also take up space in
@@ -516,11 +519,17 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
 	 * argc can never be 0, to keep them from walking envp by accident.
 	 * See do_execveat_common().
 	 */
-	ptr_size = (max(bprm->argc, 1) + bprm->envc) * sizeof(void *);
+	if (check_add_overflow(max(bprm->argc, 1), bprm->envc, &ptr_size) ||
+	    check_mul_overflow(ptr_size, sizeof(void *), &ptr_size))
+		return -E2BIG;
 	if (limit <= ptr_size)
 		return -E2BIG;
 	limit -= ptr_size;
 
+	/* Avoid a pathological bprm->p. */
+	if (bprm->p < limit)
+		return -E2BIG;
+
 	bprm->argmin = bprm->p - limit;
 	return 0;
 }
diff --git a/fs/exec_test.c b/fs/exec_test.c
index 32a90c6f47e7..f2d4a80c861d 100644
--- a/fs/exec_test.c
+++ b/fs/exec_test.c
@@ -8,9 +8,32 @@ struct bprm_stack_limits_result {
 };
 
 static const struct bprm_stack_limits_result bprm_stack_limits_results[] = {
-	/* Giant values produce -E2BIG */
+	/* Negative argc/envc counts produce -E2BIG */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = INT_MIN, .envc = INT_MIN }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = 5, .envc = -1 }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = -1, .envc = 10 }, .expected_rc = -E2BIG },
+	/* The max value of argc or envc is MAX_ARG_STRINGS. */
 	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
 	    .argc = INT_MAX, .envc = INT_MAX }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = MAX_ARG_STRINGS, .envc = MAX_ARG_STRINGS }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = 0, .envc = MAX_ARG_STRINGS }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = MAX_ARG_STRINGS, .envc = 0 }, .expected_rc = -E2BIG },
+	/*
+	 * On 32-bit system these argc and envc counts, while likely impossible
+	 * to represent within the associated TASK_SIZE, could overflow the
+	 * limit calculation, and bypass the ptr_size <= limit check.
+	 */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = 0x20000001, .envc = 0x20000001 }, .expected_rc = -E2BIG },
+	/* Make sure a pathological bprm->p doesn't cause an overflow. */
+	{ { .p = sizeof(void *), .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = 10, .envc = 10 }, .expected_rc = -E2BIG },
 	/*
 	 * 0 rlim_stack will get raised to ARG_MAX. With 1 string pointer,
 	 * we should see p - ARG_MAX + sizeof(void *).
@@ -88,6 +111,7 @@ static void exec_test_bprm_stack_limits(struct kunit *test)
 	/* Double-check the constants. */
 	KUNIT_EXPECT_EQ(test, _STK_LIM, SZ_8M);
 	KUNIT_EXPECT_EQ(test, ARG_MAX, 32 * SZ_4K);
+	KUNIT_EXPECT_EQ(test, MAX_ARG_STRINGS, 0x7FFFFFFF);
 
 	for (int i = 0; i < ARRAY_SIZE(bprm_stack_limits_results); i++) {
 		const struct bprm_stack_limits_result *result = &bprm_stack_limits_results[i];
-- 
2.34.1


