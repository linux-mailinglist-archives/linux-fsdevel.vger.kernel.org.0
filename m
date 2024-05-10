Return-Path: <linux-fsdevel+bounces-19229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D474C8C1B39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 02:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B92D1F24661
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 00:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67913BAFF;
	Fri, 10 May 2024 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3UAtSei"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8513B590
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299884; cv=none; b=cps0TaCec629GvoiIqE5EKixPvkBixkkaRG9eLB6QBwnFMjXMVZBBfzW8VhyBNqTbEJgYIBQxZTFJBYh3l5SKBu29v0Z/MZEIqoaNIlQdC2VPxzsI38JwHwS9NB5S6vWx88WHd51GkvCxmb3eJ8srqmnDreataOAkK2H6uAwkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299884; c=relaxed/simple;
	bh=IyUlAGHuB4F0ACGEqw9XDD1VWDnG6Gr5lWYbpcHYvy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aM05YuGuzQ9ISIST1heNmaBYcfLcTj2N5yGr4p8txN/GpIFdHXTf0ZM+xhDwymYZ4W7m9Ae6eOZ+9ZRQmndfYmp2ENZuXYtIk4C4RPUz+2UNl1HVzn+Mdr4Y3i7hWpXNZyClXfJvQFaQUNc7ukbO9VwpzQlO2Q8lyvFMd4JPhaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3UAtSei; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61e0c1f7169so31443437b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299881; x=1715904681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=N3UAtSeiPrlt9OW2F0rY6m+iv9lq7dDYhKPowMfiXC0i4M50l9Dq0C9BY4cBKpwwg7
         4g6Mso3wfhFFxAlqDrz2MZQMJX/BVKKsTSO0W12iZ0mWIZagIVaL1MDW33UdTQmbTbE+
         lwyQuyKgkExHf0eOHbu/v+DVpB7mWUq0XdsaAJICDUe9zrvd7cg7OddH7V1tZtlvSHwD
         HKgaAxuHATqOmhoKn76xQshp45Ob9vFkc06thVQ8OpsulnW+BalfUaJQ8pXpEpDV7geb
         suWaXWhKX4tDdAjpjzOtOqlzSVoqjniLl6CS3BH4zRnuPDy/NZmeoCatx+ZfUc/pCvLo
         spTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299881; x=1715904681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=lBwhRA+7g3b9SOlOl9ZxARY8DqXIIR+K8yu6sIhIVcQ5IFcOiGpmO0PD5TVHgYIrXd
         h+79MCQbVCeZ0uk7hUi8RRbTMCWGLtcY32O/G8FyKQOAc3SU+iBWlIol86JKxxd1U4D0
         /lwLlNQYsN65R3P+vETYEeYidaHKW8sbjuDRZq25yxJHKIIplYgvzg7p/oT8KXwMYP4H
         S9gevo3uJu7QabjG7b0V9/Cqe9AF4S4BfQP2fkBeQxh0f5pyN/LwfVKV04b92dWiEZPb
         1lMULBh8s4vWaHmvIVooZefAM5yATfVLIljyrGkbRphHHONBg6w3154X8SuMXGRloTQf
         czKw==
X-Forwarded-Encrypted: i=1; AJvYcCUC9PjwVHhbaESmxxP6eWNtgRND9MdNf7p4T2rrO4YbWqvA2wxi1BxETwSjnSzQ/IUisXIww7B62870z0v5VUmQNOfy5RNVg0ElLO6GtQ==
X-Gm-Message-State: AOJu0YznVDhGOu4zl42/OiJRZxCxjUKMaknx6J8f5tBBlJmfu3Lm2oct
	Ha0vWhl4EhN5IIzIo8OrliEMaxnGHqInb3HoklyNwP3220f6kZ0LNKPPudFtmCyKSx4ghwuLRAo
	Y+w==
X-Google-Smtp-Source: AGHT+IE/x9wCS8dXfiCveNKLMUww3zuulXyRB+TBegOeq8yRgm7kXDMXOCAjHlMh4xirNEVxhfl/HnwXW8Y=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1004:b0:dbe:d0a9:2be3 with SMTP id
 3f1490d57ef6-dee4e558e2dmr363352276.3.1715299881350; Thu, 09 May 2024
 17:11:21 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:03 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-47-edliaw@google.com>
Subject: [PATCH v4 46/66] selftests/proc: Drop duplicate -D_GNU_SOURCE
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
2.45.0.118.g7fe29c98d7-goog


