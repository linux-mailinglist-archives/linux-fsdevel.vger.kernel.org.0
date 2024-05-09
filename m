Return-Path: <linux-fsdevel+bounces-19218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9DA8C16D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 22:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5181F247CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 20:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC4214037D;
	Thu,  9 May 2024 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVZumaIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6613F453
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284992; cv=none; b=T8obd3iarSGmMCZEpErE+QbLJDNmIqKWXed7YmNUq/ztH5O2LztkGIU6KlTliLvSKj8lWzeCBqWWKeq0xO3DOs/7SiOuWA6dmmo1t0kyP79ZalzPIc1tAgem801KHfsy/4OUfGXJM3xQ0KYwxgVHf1H3jRTArm+PCQhJmogYQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284992; c=relaxed/simple;
	bh=J2aK0bE+Y7ee3E6roTqW6AAJ95EP/+G9UgxdLYbifQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ib5JVAEcwj2rkAd1qp6Tpi0pQw42svNyNIRl3TrYd5Fuy714kbC18gDqN7Y/XPTAZdKMA4Z0Qh4sUlDTWjU91ruApiqB63rU7nn7jdnyq/KVyceDYHLo3/1qskfs6S0Plu/WXJnFMp4UKFmYc9Cyq7WOSDqED5xBLaWFvNy3ROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVZumaIp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de8b6847956so3121530276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284989; x=1715889789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAfxn4Mx/opUGbIFPR6WnlOwclUxypYBhNIAU6ceeuk=;
        b=WVZumaIprE+2ec0sjBkWgm+9diDCVfR7g4ZNT9Vt/sLJryq47V9Ad76ZaWv9NIdvFP
         +s8auJidCZ5AeL3AA4EUmOTEjjd0sqaIi1trY9ij94h3UnM8YjOcP84kn+AEK0cTywpz
         FyiytGYuGOBHS4aLfno84o5E8RjBMZI3Q1XkJX6xXn76ezY+074GLlqcgobQy0YGW2pW
         KgkYTmzk22NYg0SyydISeavUdjhIa6cQac4dvLLISQNmko/dWdNW3+xrMX4Qa77h4eQu
         ckq8xAyle6SahpZeU2KwfUnEXBx2FtyMVq+SecyN/w1h5Nx0bUZMsmTk2ySPKJDSZPeQ
         PymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284989; x=1715889789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAfxn4Mx/opUGbIFPR6WnlOwclUxypYBhNIAU6ceeuk=;
        b=SgXvp/sNa0hA0CRebCN7plENwEppiC/KL59F80uCLjxmJpp1h7ujbl2AaXfIg4ULj1
         D2e73ilGHxHl6GTABPK0MqUP+hFiOpjeIKveIsQ2X5ZOuGQQil5ino4FK1Z9oCoAkTpa
         HS8n/6laJDrSTD3HbkcgEHJt+nwxt9GhbKR3wHoGLLKesO2h3sIhlYL35niZC7GS8h30
         JvirD83B0cy+D383M0h1J97ulWvZ2baZftBsDI3eSDxsuQmQpAJEmY8f53VFYraJHVXB
         G+3JX0waU7NXBvOHnbAua6grm9Noh9C6749bLFjBchPOnB0rdsYwi7PF7vqOYvPeWKc4
         xdgg==
X-Forwarded-Encrypted: i=1; AJvYcCXo7stZen8zy0V41NRrN11kBVpPxsROMgNbdbVYrVhQu1YwhIf3DDQQEheg/k92vHyPYakGgNklj/eNsdz1bRqsCKuVzfO2hH6+r/WMow==
X-Gm-Message-State: AOJu0Ywc0uSkh1+pqYcjGPtPd4GMPX0+qaoIC1awL3ejbpHc0EtwAbYt
	O3/X33MhhcOQY7qluLGbm4BcFrrJQO3fE+29VYVcYK65GHoU7gBPFofe8mxlZMF9KiWAyXDtRG3
	Hkg==
X-Google-Smtp-Source: AGHT+IF3u/75WI9MMRWQjVk+dcqFHeDZV83U9cH95eO4kO/Itl/i7zpPn9ZL2gHtlxqWHTW0V4QEbN9jQJk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:c0e:b0:dda:c4ec:7db5 with SMTP id
 3f1490d57ef6-dee4e57a059mr218127276.4.1715284989462; Thu, 09 May 2024
 13:03:09 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:39 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-48-edliaw@google.com>
Subject: [PATCH v3 47/68] selftests/proc: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca2bf..f92a8dce58cf 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -23,9 +23,6 @@
  *	/proc/${pid}/smaps
  *	/proc/${pid}/smaps_rollup
  */
-#undef _GNU_SOURCE
-#define _GNU_SOURCE
-
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


