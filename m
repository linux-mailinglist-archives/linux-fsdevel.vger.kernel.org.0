Return-Path: <linux-fsdevel+bounces-22287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6973B915A93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 01:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F224288255
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 23:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0101B4C55;
	Mon, 24 Jun 2024 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuYj4ap5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE31B29BF
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271788; cv=none; b=tPPbrXzVUbFNnr+O2M943RjF0VcGr2pi2Bo/eR76y+xxnsL/sIdkHAmAq4bs00NT7c5oQ3wZYFsgkorxXXmDyB2TvyHyR1QmiATMNWbkAd+Tx0VfHi21MjkeiUqCqhOX2L/HSr9XJkoQG6YAg7nvziBZ9NmAziUHYmTIHItYmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271788; c=relaxed/simple;
	bh=7x4LoDZgR5E/QVoS9cmfJRmJxj+4a44E8Ep8Vb6AuSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JCtjwvYCjadLhkr+U9lBnjAc2Wzlxfy39McBkSqSgrIln5gjLXQmiKw52wtI5UEt3dHo4pctI5VfuCFA0ZIpuyArjF+QXyo4KlxBGfL9YqeNqLchSdNlomRKKuw47MBAoaxIMALgp+NPLyQvRZChUSqJXJOsSuVzr0jLdbREc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuYj4ap5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-715e59afb63so5540006a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 16:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271786; x=1719876586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJFiGCZar+q63pIILXV1m5S/VTx8srfmbdTO812oVXc=;
        b=XuYj4ap5BBVHxp6cnA/Krxeluc7KtWQdOXexVpa39vo3mc9NtKJp3n3Pi5EVyXUeh6
         DpS2xhdegtD8uvViwIzrh2kKdQSugCe1APCyQFltR/FoJ5+ZCMSjAj1qL3mG9NFR/wL8
         vmw5n63XC6Id/iNS/urDnbh3hkYHCxDGOi7HMicwuGQIfLwWcipGbmTgkZAMTu9utr3M
         JCfQc4l6tDIsJAG2o2F/M7TJgC3MkKHHQJurbnK5jR9ECA/SQ2AlCi2yEkUWz9s7uP0s
         H0iGAhjbu11f1L2TE8HxZNj/7O4ftsPKBs2sIUWHCEMFJ3ofiijj69/BzL6ZNCfvtxHs
         iWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271786; x=1719876586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJFiGCZar+q63pIILXV1m5S/VTx8srfmbdTO812oVXc=;
        b=LA1tH6nxUqoe+KZt0Ay+7g0FSk+UCxNCWehXCg3zK/wJJ9mLZfBJUBSsHD0SYshyji
         mfBOJUDdHwyl794lpnYq06f6kkQ84QR7ZNchpKY+qkOxi7ZQoVO0QzM+EMa4UfOPlUKZ
         nXQ0BCYN4vriq5c/9sUxxgDzK1m7YcohivTwykIblS+79RYXnDE56Zu7I9eED8ypfY05
         Af4XiG1ueojMstAu+4H1WIGoOP0Oyb1V2+iEpssC+NJOvLkkvTmXOoNPxHsWYffeFCRN
         KtwbedErSpA2oe2BX4hKLQ8xuwlIrbpQIK3fKctNPj6LN3SdkW6oWE90mE4+ymInxDth
         g1ww==
X-Forwarded-Encrypted: i=1; AJvYcCVxjDgZZ+d8VBptEx9po9tqTxM8d0747RwQ9MU7rUzHNTSLW5aK2+oUQ9ZC03t+DPbZHr7q/t6QM0iRN3cqFiCoqmBwb8ZRyz0G6J0hHw==
X-Gm-Message-State: AOJu0YwtafKKokR1HLUulYF3Rf8V8K4HUvTwAFRQQ9Ys/BzTvjGXuN0m
	BVr4hKBAyIL68g3fZDOuOApGqB0k/A+aRoEOCFVXR2pZ6ilspBqHETT5Gk7YQLQ0APuuQV9XTaP
	ung==
X-Google-Smtp-Source: AGHT+IHZaXS4lSce/uBBUIpFuXCH7I0BpPEaAf3VbI7ppnPDWzJgDOW4eIq57gPJilnwaCJeffaGJD+7rCQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:6dc1:0:b0:6c0:3f:cd46 with SMTP id
 41be03b00d2f7-71b5b395b46mr19980a12.2.1719271786190; Mon, 24 Jun 2024
 16:29:46 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:18 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-10-edliaw@google.com>
Subject: [PATCH v6 09/13] selftests/proc: Drop redundant -D_GNU_SOURCE CFLAGS
 in Makefile
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE= will be provided by lib.mk CFLAGS, so -D_GNU_SOURCE
should be dropped to prevent redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index 6066f607f758..ee424a9f075f 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.45.2.741.gdbec12cfda-goog


