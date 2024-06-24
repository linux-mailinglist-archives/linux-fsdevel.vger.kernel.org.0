Return-Path: <linux-fsdevel+bounces-22282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4569915A78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 01:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7842A1F21512
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 23:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC91AB901;
	Mon, 24 Jun 2024 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FaeCaxlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3DB1A2C38
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271760; cv=none; b=fT3aFbaxbsOeVZailR3aL5RtTvlj8ppyezESwr9pNvzbM67pPJU62UF3D27KutX4HVxL+I3353oKVpU/rij84yqaL/wxkEA7OY57553sXt12cR/cUZq0/5oJyz7QNF2pbONoXxB1tmXd33cLtyavItgjMYui0y+uh8PRBWrfEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271760; c=relaxed/simple;
	bh=pWNExpY/MivG68WT1LbkW1rwtOz84qP9M9G1/+5QF7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uZS3+dSA6eQlqQhQYPxToXjeP/FOkGgeLjvxBsAI45g9KbefxSffmK/z7o3xX8pHkP3bqeJkAOtHlW3gOdaNZ+1cgTJugh0RDeH7Q9tezkTtJDofCoad4qV/0isz3eGFYd9sPm0f+g3fa68QNKddTz115w3Elg/UMsl1gmNiLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FaeCaxlC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-721d20a0807so116661a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 16:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271758; x=1719876558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdSDNYLWJB5rZ7zGFIgNmO8T8+rT5KpGbZz7pQfLV3k=;
        b=FaeCaxlCfye7b5YLfuZ6SbYpIxNGujeqgCBDFc5s4U/6+zOC5pLN2lon52z874yWny
         b3YsKNt+DS7jKNo3qE0oPx8cfvGA1dFA9+75IQ/KraBiQqJQn+g2WPV3uIyG+CW3i3wq
         Ag2dQOckgcpEgCotsJksqZ2oxkZEf5Gsby9jfVDqOfeW1y9prsQGAoboynpeE7BT7eUC
         38KmFZ+g2hdGpekag+3+St/zWMRof322lMbzz5KdzKVgJO2cuXmWHgUkj/jfeVSFy1xc
         slZIkZUb81Zc328fyiEfgpC538fEev3eEixo7+iDdvWzSaz5SWASsR0GwOcc4N+vHDZK
         PrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271758; x=1719876558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdSDNYLWJB5rZ7zGFIgNmO8T8+rT5KpGbZz7pQfLV3k=;
        b=n0tX4+mfVjv3w/5Clat9CHVT0uZ0JiTmuZbrhQE/V1qNJIWF7xuR1k1Sbel8RKZEKq
         DTKjsdOmDI1gI+W2JvsjhU5W/cp7tpR7GLnQOgTqbDP/u9pwaUN6xcAKnYAtUryZrm+p
         E/zBkbshRerzmln3yj5rhTIn/dOSUim1KcDucC+AlRO7bQVM3zDcS+afrypXudGnI1w5
         fmu97aG7jCtATFdW+8uLqSeV40cMgI0+fTw1tgMukwZMLjylWOvz4JL80I7dtcKSUYsF
         I5f1cmi4UMKQJqkOgk+UII3lDLR715D8smYOAAc4joD4Pa3lad+BVOBJ6NpwTczyTgDJ
         Qx3w==
X-Forwarded-Encrypted: i=1; AJvYcCWCC0ojwAv6S3YU3Fkcv0+mH75h+gsi30egB6PEM9sTQ/CE/xLTntT+Ax4VzzJPigNOeIQUPiXHMxWtYveNH13k5UQ+5OgkhwYiVpf7Lw==
X-Gm-Message-State: AOJu0YxIwwzvyEZRPN1MCA72HD6OHcsFaD6QcpOy5KoK7c3CVN6EtUXv
	FOQpl4rYUOsz2RA1mT0cZyflyAbpoo4SILl7LZuxudaufxk3JQs8LFXkJN+SCnatMgdoUh/lIcz
	qkw==
X-Google-Smtp-Source: AGHT+IGHwhaq3SpDsE/oDwZF6fJSdoqdJu1qur3CUdYhennVxCDTZQrp6vr5HFtn29b7yImBHRAcKRn1tcs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:3d43:0:b0:71a:1f6f:1d0f with SMTP id
 41be03b00d2f7-71b5c3db10amr17532a12.6.1719271757877; Mon, 24 Jun 2024
 16:29:17 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:13 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-5-edliaw@google.com>
Subject: [PATCH v6 04/13] selftests/exec: Drop redundant -D_GNU_SOURCE CFLAGS
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
 tools/testing/selftests/exec/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index ab67d58cfab7..ba012bc5aab9 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
 
 ALIGNS := 0x1000 0x200000 0x1000000
 ALIGN_PIES        := $(patsubst %,load_address.%,$(ALIGNS))
-- 
2.45.2.741.gdbec12cfda-goog


