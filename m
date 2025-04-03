Return-Path: <linux-fsdevel+bounces-45580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D644A7993E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 02:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B95172555
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 00:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40C625776;
	Thu,  3 Apr 2025 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1RYD+5/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6716EAE7
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638923; cv=none; b=fXsOvb5tmhBXTIWq+FEpE8Di/DXTQzUb10tzh6EtZD4Hw7hDmZeIwj8pCaC113b6datEWIxuH9MEtzSmLitpzHt5ylp5ZUHXk/PwMxFRo/oni4XocSHj35VzsuTk7BSE+A3TGj1AS8BAbr8ZeQBST2JAYc4vFqctFTWzJdwiktE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638923; c=relaxed/simple;
	bh=SEXoMgfO871mcJmIm6KSXpbtvdsiD+EaJJqUWAfrQ38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jSc5QTu6pPMC8AfbJh7wwbRFAq/E1LxLsv/vRk/sQnVhUy2o+F79uNwckyU9oNq1WPwKlqyUVA4KkTXH4r3frh4tm8yO104MZCr4BjJTXakv8ANQevKwITWgSmSGDC130CpU4a+BAstiE+WEhzXOjfa2E4ZpCkZ56ZlyG2b6+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1RYD+5/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4eacd8so275599a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743638921; x=1744243721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NyoF5i3nxCUfNVJkAVl8GCLqKKAkd0DOEReeKsHnmjw=;
        b=r1RYD+5/EOTB26KkaCiqFXm/gJHwFDfSeWt8ZVgicOm249ixyGNyfZNLF/Sm4ZfjgL
         K/dP39BbVPOq0j+UtVdqeXyjvbk4edgV3QwLWD01iK1kcJv3MmGO8RgKMN+8nIVcHHbq
         5RjsDecbyHK6aAfav4rWdnCKeOWGRGDqcTxKrNX82hCtxNjDGQcYEFCed1XjXrqXNSzh
         akZXSOlvlhIOIFig78Oh/uT5pp5D6pRpWai2ywbMTYNZJeT2qCT7TfZbmRhODR6kt1Df
         hWF+sZ8ETYjJ54sYlLMTa3IB6i6FB9VlVRWT4liAt/og60yUAu/1+sY+haZbl5nQSNiC
         SaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743638921; x=1744243721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyoF5i3nxCUfNVJkAVl8GCLqKKAkd0DOEReeKsHnmjw=;
        b=K66UQ+bfvQreu92a8Capb86s1FSIudZKl2Ol0q8cIqv/KMWrl+UcxXHrwdml2HRFQh
         NWNvv4+sZrpisrk4QlxJB9WzscG6kY9zGNkXAwJiy88aJ4mXKZZ8sm7QaMqpw5YbTl/x
         8apIVVHyEqa2u9vt4FhRcXbYUw/TD/OjT8pzERTz/Cynu+WYLXsMEebZQw43jCvEbpVt
         s4xHYq70jiYtLAJQWljII5ztqHETiD6JeqYSRaK22dCyHNBPT5pw6bcg0uTeSHtK2fvY
         ii9k/rERSgzlc2xkrDst6ilDuT8i/cal29KPD7aGhARFrI88T2ockcVak+SpJfI+tUvn
         JAng==
X-Forwarded-Encrypted: i=1; AJvYcCX/jX8K6CijA48uG9HnRokQkJ/rHIcVW7iM/CjP9LIzXGwkXq2tcVBAD37ahpruxOrXpXQcoR0VYpCsXRXg@vger.kernel.org
X-Gm-Message-State: AOJu0YzQj3BcWAchvaJQTkXSl90dG2uThourDrIbWG1x/Hne93gDeK0S
	cAJV1wPT1Dfsuxu16s/rHDmF9w6CnKBd6uuNYDdc9FTA8nstpjaX1VrdFsYhdCMoag==
X-Google-Smtp-Source: AGHT+IF9PPSWYluV28LHjIAQYtoCIsrCyo2nNzgTlCfOaTtLczxhcR0/cQHFz16AjBy9tsQ09yZBi4s=
X-Received: from pja11.prod.google.com ([2002:a17:90b:548b:b0:2fc:3022:36b8])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfc7:b0:2ee:b875:6d30
 with SMTP id 98e67ed59e1d1-30531fa4dd6mr27878978a91.9.1743638920951; Wed, 02
 Apr 2025 17:08:40 -0700 (PDT)
Date: Wed,  2 Apr 2025 17:07:00 -0700
In-Reply-To: <20250403000703.2584581-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403000703.2584581-1-pcc@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250403000703.2584581-3-pcc@google.com>
Subject: [PATCH v5 2/2] kasan: Add strscpy() test to trigger tag fault on arm64
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
v5:
- add test for unreadable first byte of strscpy() source

v4:
- clarify commit message
- improve comment

v3:
- simplify test case

v2:
- rebased
- fixed test failure

 mm/kasan/kasan_test_c.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 59d673400085f..e8d33af634b03 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1570,6 +1570,7 @@ static void kasan_memcmp(struct kunit *test)
 static void kasan_strings(struct kunit *test)
 {
 	char *ptr;
+	char *src;
 	size_t size = 24;
 
 	/*
@@ -1581,6 +1582,25 @@ static void kasan_strings(struct kunit *test)
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
+	/* strscpy should fail if the first byte is unreadable. */
+	KUNIT_EXPECT_KASAN_FAIL(test, strscpy(ptr, src + KASAN_GRANULE_SIZE,
+					      KASAN_GRANULE_SIZE));
+
+	kfree(src);
 	kfree(ptr);
 
 	/*
-- 
2.49.0.472.ge94155a9ec-goog


