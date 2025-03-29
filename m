Return-Path: <linux-fsdevel+bounces-45250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C9A7538F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 01:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C13217196F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2CD42A93;
	Sat, 29 Mar 2025 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRxFww+t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1A182D2
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743206635; cv=none; b=CEY8wUnoHwiJ9+0WQPDinlEHR2FA9LaAK7T6cIWyEfIoJr2LYricwqVSBZuhYEq6ZVHiIvZr+o6y7ZLvWD4BzKX03AHn+6fo7dhwT1pwha3klYKu4+nFjRyZTlHVJKtRCvN2OWbdJbzzbzkaKCVT1j1szkhyPageiZlnThn5V+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743206635; c=relaxed/simple;
	bh=0GH03YEIRBHpcTs5EQTf5tRjGOZhfj5ycrE7WqRiMdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=duOnLrHc2PeDn7ZAIXa8kehSEj37MJDgE6IxyepmbNdlZnnC7i/T027Z4bXAI/t4qZmnlF4EGG1Hdrb9uWXSHNoP947Ym0VYDi79kmrfZIgtreM6q5ct3v4tF+D+XkwFfmuAwk/PuF8gsI6Qm9xzI9Qp1+FTwXQVWmUIfiz18nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uRxFww+t; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2241ae15dcbso57944815ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743206633; x=1743811433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGMonBDCtHbGxccj+//vlpjOsUsbEFJEDLrw6ctd8aw=;
        b=uRxFww+tlYNsYYB/x9abq3jT5BxzIRaJUYOfFllDJWB4ChJ2ynmwPT58DCh+oCPC0f
         /AGtzjTIL16uwwjjac9W8WKj80GqUMTR5U1Xa/JL30HNwCzN5Po2ReqW2JpYsah1BT2X
         bV8C99W9UuKAtbUgsJC7arwnbsTmvOGe756H+JQRtw4tjfrCt1x266jtMuPNkHFGiHbl
         7x6Vbij036Kgwn5V/vxuKXks11Dp5feiddn8rEQm0WKaHjof3tqdLL06kTtbUii6avWh
         3W+hnXJbZuIKCGnefvmF6gOIlJDLYDlTeb2dvCXoJUYH1p8xRfAGuBdTe6rV/sosUQWE
         KUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743206633; x=1743811433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGMonBDCtHbGxccj+//vlpjOsUsbEFJEDLrw6ctd8aw=;
        b=BQgB1TdhmtEqdlNuWSeuBfXqXyL64X4Y0f9hGBlzub7IPElKFpZQY77/CfE0081RaP
         3Lvpke34RARVcuPITs0RQV8zai+IO4bLWkOyuD8XKHVgbWeOUkWKmw9CMLrVwjTdwHCV
         I5fcEPUMPUUl1a9Wmk4ca21PCdDUck00Zu4TDGg3K7N8CBHkkX2ysQ/r3OhlEg35ZDim
         yAhdvpqHbRAqkB6e/OhzKl2nXQzlLWQ65+G4d2CoS+zKYiijIXOVpkrM45qWujSo2rPc
         L0XZRiK1/WPB4AHpGS2i8w/P5wENCVueRf2FZU/++yEP8wnmVHyqk01n5Dt6zFRFCIBf
         va4w==
X-Forwarded-Encrypted: i=1; AJvYcCWbNOxer9ZJCpKciMUp0NVKMdgoJ4cscdBvVuYup40yGlaUzbzm/U94654YOqHUDfUrT3EE0246Vqv0oR1D@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLYYP80KD9zRPAibv/JOV8pt8dTTdxKpkrzRn3GMVpj270SQ2
	w0eifkd6Ero8GnANJi6Si0yNrG2UKjTmS4Srw5V8UgnQvL8VoVXiiENtqDg9O8hbbQ==
X-Google-Smtp-Source: AGHT+IG1OCkWK6ACc2gjb+axSi3OGauLJByZEq2XzaKVmUmtuGmaBnSVPaf+lB7MT0QcfgqXjpACp1o=
X-Received: from plrc9.prod.google.com ([2002:a17:902:aa49:b0:229:2f8a:aac5])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eb8d:b0:21f:564:80a4
 with SMTP id d9443c01a7336-2292f9e5139mr16353845ad.33.1743206633220; Fri, 28
 Mar 2025 17:03:53 -0700 (PDT)
Date: Fri, 28 Mar 2025 17:03:37 -0700
In-Reply-To: <20250329000338.1031289-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250329000338.1031289-1-pcc@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250329000338.1031289-3-pcc@google.com>
Subject: [PATCH v4 2/2] kasan: Add strscpy() test to trigger tag fault on arm64
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, 
	Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

When we invoke strscpy() with a maximum size of N bytes, it assumes
that:
- It can always read N bytes from the source.
- It always write N bytes (zero-padded) to the destination.

On aarch64 with Memory Tagging Extension enabled if we pass an N that is
bigger then the source buffer, it would previously trigger an MTE fault.

Implement a KASAN KUnit test that triggers the issue with the previous
implementation of read_word_at_a_time() on aarch64 with MTE enabled.

Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Co-developed-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Link: https://linux-review.googlesource.com/id/If88e396b9e7c058c1a4b5a252274120e77b1898a
---
v4:
- clarify commit message
- improve comment

v3:
- simplify test case

v2:
- rebased
- fixed test failure

 mm/kasan/kasan_test_c.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 59d673400085f..655356df71fe6 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1570,6 +1570,7 @@ static void kasan_memcmp(struct kunit *test)
 static void kasan_strings(struct kunit *test)
 {
 	char *ptr;
+	char *src;
 	size_t size = 24;
 
 	/*
@@ -1581,6 +1582,21 @@ static void kasan_strings(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	src = kmalloc(KASAN_GRANULE_SIZE, GFP_KERNEL | __GFP_ZERO);
+	strscpy(src, "f0cacc1a0000000", KASAN_GRANULE_SIZE);
+
+	/*
+	 * Make sure that strscpy() does not trigger KASAN if it overreads into
+	 * poisoned memory.
+	 *
+	 * The expected size does not include the terminator '\0'
+	 * so it is (KASAN_GRANULE_SIZE - 2) ==
+	 * KASAN_GRANULE_SIZE - ("initial removed character" + "\0").
+	 */
+	KUNIT_EXPECT_EQ(test, KASAN_GRANULE_SIZE - 2,
+			strscpy(ptr, src + 1, KASAN_GRANULE_SIZE));
+
+	kfree(src);
 	kfree(ptr);
 
 	/*
-- 
2.49.0.472.ge94155a9ec-goog


