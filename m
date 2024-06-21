Return-Path: <linux-fsdevel+bounces-22052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC26C9118AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542D51F22A27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642412D209;
	Fri, 21 Jun 2024 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwQXlcE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AC84E0D;
	Fri, 21 Jun 2024 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937113; cv=none; b=Yj4HIT8+OzFcyEnwzgZUFKnBGAnBMC8w7Mb3xvLLSxakq+/6cEUdK+hgjaCOWToVEQ4P06eUwoAdnGoUeWbttGtyL10ST8rt+DetKxesWWt1+G7aykQi1xRKotHtb8ztDg0LnPkgc2Xw1ZUErCdlTrGoEpOvEr7xRRvjVG4qOBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937113; c=relaxed/simple;
	bh=ifRKs7FUaq2eQBo/kGf5I53pQ9emwiKOlYtEkCk86eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbuG92hwwN6ibMNcRRPC2RsmnRNtIRAxpTuPITc/SuOXDfiAV56NzuexZp09QXhLfusuRH+T1Cb45MfkKQO/rX/3N3kDUBktFFvdJB0rmZLtlZoBGm/fhYtuqajE2QOxo2dPETItQCx40RYY4L/155foo5KB9GQHFeUEnh1psx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwQXlcE5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-705b9a89e08so1382351b3a.1;
        Thu, 20 Jun 2024 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937111; x=1719541911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYd5YNknE07k5DuwDR8qZLFs+IUn8eRucnjF7OV4ohA=;
        b=RwQXlcE5hrb35+VgfdvD75xPvv7ifa8RzpW2gX//atQDNifeR+uJf9I9seePfknuoB
         +3hzeJ/I0a6hZm6f6AiH+CvhCMjGTBjtRqXziGfhML0wWUhgwVJcEKoLWRfTFXoOMh49
         WV+PZ7qVPOyFF4bkEdFC5wyF5n+VOzjJWs+6JTKzst4IdYt2xxS9qtdUZCPNSB4wvuGw
         Vm1d7v7F5ZIZ/Ili/nNG4MDVLjmee1R1hRJpb1emceC6pXO/AhqznhXIcktJHNsxSWic
         otIk8yVoetavtsR3zCKO91y2EhLLkAafOuI6SGInCLkAm/OU8s7HzR68ackWgBfBYyrv
         e2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937111; x=1719541911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYd5YNknE07k5DuwDR8qZLFs+IUn8eRucnjF7OV4ohA=;
        b=jI+s1qjyBhPHIHU1hAuUIpx9MYGqWJ3ToYVb2jhCOj7IvnpRn0T+BJh+2gqncOw8/6
         kq7dEerBDrA/ZRxWf3r6ZH9XaAaO1Hjj7iRa2qSt5xTABsjE1I2BUxBGNCQFjDVJEo7t
         AXsTRUJPheNIxhDUdsMINt2ujbz7hOBYp0xX+AqsogC7+O+9BWrSR1v4qmlqfod9YVPF
         beS0uza1qgqlpJ5+a4pz2Qh5S2GZXbSZbRlcQlRDbI99fe8WrGuKPO71PQ7YfEVMbCT8
         2GsWR3RK1Bxg66O84koI30SI2t+Yqc9UN7zIbzDyZm9upb9FkeE3uJSQHllGFFRBYvtv
         /qSA==
X-Forwarded-Encrypted: i=1; AJvYcCX/rWAUj8pVz7hxfq9s7gbwzdL9o/llonNY9CgJ6FPcRtq3gYLXV8AlJaq/UIkdJ1uprupzK0y6WB1pNcOfuQ6MvjENAyGBXwWVe0X10eHj3ZtqLIctkK7t9Q6ArE8yGAiM6DLJisNRPPqInGIWsNd6gzIBpvnFnx6j/ovhZ9U/PfgJ4TIN8DdFg/ujj2kFjQS4xF9qsTiQmN/K26ayxau0oYudma7LU/BESEFzoyOjJxIQhp3ICCVeWi2dFWV8AE6LzKoRRFCR2srzZYB77s2mb7cHg9+jgamgIYW0kjpLkW87ftkZr6eKOb6Dfu+YFXmCfzo0tQ==
X-Gm-Message-State: AOJu0YxHWxDmBeM9RpoG2/avuR1MB3pu0ud7o04m6p1ycIpTRQOZQJNa
	dHZeXxXap6kwUJHL0+4832Xt73Qp5n2RRR/8sL+EGPxHUUC0DV/D
X-Google-Smtp-Source: AGHT+IE3vqRU4TDjYUtGu1BjTuY8WxnNKb7eQY82UPvhwXZyWJtswQi4+ta6VB9SmiN5potLRkiFDg==
X-Received: by 2002:a05:6a00:853:b0:705:ed06:cc64 with SMTP id d2e1a72fcca58-70629c521cfmr9225541b3a.16.1718937111523;
        Thu, 20 Jun 2024 19:31:51 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.31.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:31:51 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 07/11] mm/kmemleak: Replace strncpy() with __get_task_comm()
Date: Fri, 21 Jun 2024 10:29:55 +0800
Message-Id: <20240621022959.9124-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240621022959.9124-1-laoar.shao@gmail.com>
References: <20240621022959.9124-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since task lock was dropped from __get_task_comm(), it's safe to call it
from kmemleak.

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/kmemleak.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d5b6fba44fc9..ef29aaab88a0 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -663,13 +663,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
 		strncpy(object->comm, "softirq", sizeof(object->comm));
 	} else {
 		object->pid = current->pid;
-		/*
-		 * There is a small chance of a race with set_task_comm(),
-		 * however using get_task_comm() here may cause locking
-		 * dependency issues with current->alloc_lock. In the worst
-		 * case, the command line is not correct.
-		 */
-		strncpy(object->comm, current->comm, sizeof(object->comm));
+		__get_task_comm(object->comm, sizeof(object->comm), current);
 	}
 
 	/* kernel backtrace */
-- 
2.39.1


