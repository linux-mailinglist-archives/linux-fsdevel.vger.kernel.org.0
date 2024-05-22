Return-Path: <linux-fsdevel+bounces-19947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB1F8CB7E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 03:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06CA1C24415
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 01:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E6154BF7;
	Wed, 22 May 2024 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRl3zY1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA82154441
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339711; cv=none; b=dX580pvwPFrXtlOwW1omlEu90P4agsrb9n8NNpHQ0Ca+G27C7QIr4npWpiYcJcF7YfEUw7MW07/GEAg0hAWf55PpkbsxeOHxpoe6oNtoKM+WqG+CwMBD/fgpqIr8cc97letfAPMkisZglXn54cIzxt0vmx7XnG2b2hrGtGFUvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339711; c=relaxed/simple;
	bh=SmrocNUJvB/ITWCaF4rKnfFmHCtlMS6QocJOOBtpHOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B46IOCTKdIoZbhZTF6pyLOv8Rdn2DlBsiALNuHdTu+xPz/oRX89gmrQYm8DUkyLW9+tw1MuttEN9Fucs0zfzZWcXjWFgcZtK76964NY8MeVyHj+nS5i4phMNB/c3OV5JPkNQHtkMN1IkWOHX0KcuEnaQwN4meOIPscO2oJjkuh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRl3zY1b; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-658b03ebe58so5654050a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339710; x=1716944510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ddm347wncUXhvBA0WIqVxztes14b3U0yNoWhmDeDFY=;
        b=SRl3zY1bK8gwbkMgvl5YJOz9kp31ainmDDVq+xV30n8nNnDIfKiJ+3QM8zKosf888o
         mKbYXdGqXRic2kTxHEJPt9sRzHit2eLcjaqVtqRs1agaPVLOB5wz+tLm81dPqnFcugRv
         19k0SY3xbFB601gl2tqkQc48m3zRcsKDRobn5d26s+Y2p0nbZ7v2QgEyaszyAOoyRqk9
         GIs0rww0cdzOJTIb/xZL4kUYgcCiez/9SqSnhUEVkvUTgz6VoUy5fC/PJIPvsAXuwZnT
         0+QlBaReqtfr28VUCBkjgxR1q4oxCeb+Zg9CbwZ8yEH1SpoI/bat7Tye7Ra4m9u7R8lT
         kqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339710; x=1716944510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ddm347wncUXhvBA0WIqVxztes14b3U0yNoWhmDeDFY=;
        b=qPlhkl0RK5ov51k5aZDAghhGYF7upuu2ReoTWpi1E6ksTGJnOyYEwxxfFTRwMdMI1c
         tGMvxIFXrhg310uJplaO24EEBF0G6DxNXCTQsTYqisFgt9Jv88C4/spbX8WYJy18oY6T
         hrf3f7DTZ6lV3jBaF8fj83Bi4Gf71SR6EiCW9ldMwHxciTRWdXJLt87ETlbGk/PbByAS
         WJOz4L0Uxrq5Y2Y2rMCJ7Qz2n/rDuVy2K/DaZZ32NVovQeeiqDa8RlejosHh7h3uSCuz
         O153Ik1jByTssyKaJxslTrcIabuq5A4FqFEFBdmr9eckUqFvY7Gnm2BTBEvoIvQyt8xp
         gBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4or3kr8dST17p0abDFa0iyTh6nnhgDf3YQDjXE6MJ20U07twd9l04o+rsmORPUhHhaDBwvDmPNqPL+eOdcrDPedfRjSFYbG5Uuqy6Ow==
X-Gm-Message-State: AOJu0YyDIwaIDxqec8khhdU1si8R+Q9vditVXtIgxrStNBbXLprTrKic
	FfqNAOAEX1+f9icKQLcb8Zck8Hd35q9qkN/sXe7B9Owkf7qVoVtxtpqKcePioAkBC+/fJgZZI7I
	yOQ==
X-Google-Smtp-Source: AGHT+IHViMDRF07gYGA4O1kZVdy742miSAJ5o6zH/GL3MaXuWgF70gUFd0Ml+qHdUScPYudMioDDIIFR1uM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:371c:0:b0:630:dcf6:f224 with SMTP id
 41be03b00d2f7-6763f99bfffmr1357a12.0.1716339709684; Tue, 21 May 2024 18:01:49
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:32 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-47-edliaw@google.com>
Subject: [PATCH v5 46/68] selftests/proc: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..25c34cc9238e 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.45.1.288.g0e0cd299f1-goog


