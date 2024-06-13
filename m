Return-Path: <linux-fsdevel+bounces-21589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5F69061EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFC51F224D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592712E1C7;
	Thu, 13 Jun 2024 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0Kjamqo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941512C468;
	Thu, 13 Jun 2024 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245912; cv=none; b=VlkwHQgrlb27kBiWtk/438hVnGbYC1WwBUTZeGUAYL9j+FBHhNfF82zBS1UdlbDgEh8yfUInRpUJVv6FtXyGHCEsWZMVYD0p5j79nyiAJrBcc77RcTKPrPO4UoL24ZF+AOfw3bYGYcogkV1wyIFcb+2KaLF93l2ivHdw0JoZaRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245912; c=relaxed/simple;
	bh=+dQ99ROKczL9d1RCLteLM9GCbPMd/sWNoUanj2AALC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bSr/kC3wat/TtasdkE9bRgY+7SuKdg8snJF6KKWmRWlaeP0w4QnWZRSxNbLeQxXeieYuiBR4eJxBPH1ByDX1ugHoggyKXz9NpT426ICYQVuHyoIfccJS71W61ZjRDL36FZmF7iPCOZjEPbMv6gRr3/ss7ptRQ2l60vXIW25B4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0Kjamqo; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso448071a12.2;
        Wed, 12 Jun 2024 19:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245910; x=1718850710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI/qiwYumUf9WdznWs8PjjNV1aSEYVRYeuHEKQmKc7Y=;
        b=Y0KjamqoH+K4NlliQhFv2UJEvWzMnXXZSdpxNzotQKPW4PAFLSAz0mGhwl7nIfdwQZ
         Djm8Wy4NYlh4xPEf/u1N8VZAqPSW98gXzR1fkBjIJ5IvtCR92KO55JrIvmBL/MRiivjS
         as8KCFKqtfFxl4v9oifn3dK+qk9rWu4Ss0of57QViOFc9+nA9knKi7Yde4fbv0lFIDHA
         R2u9FeuC0/JWo2jztoKIcFlw+Ts5+SWAa2XvjflfriruDy1iyzmQJJrA4UkvPWePrplU
         UEKw2cHXDXmQtm1qClr5Bvcf3okaXmCv+eUdPlSmmOckKJL3pgNlA7/+z2EGw448hXLP
         o88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245910; x=1718850710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI/qiwYumUf9WdznWs8PjjNV1aSEYVRYeuHEKQmKc7Y=;
        b=wMxCbuC3ib2WhSU2AZems/ikwU+7wv2m1oq6s5j6Vgs2rNGz03dhXByVsz9gvCT+7o
         74cGsMmWGq4f38L7eoIrAxxiCQ5o3dwwSh12QI0sC6ALpxTEf3z4ZsWGOl2g8Hmu1u+E
         9tuv3TJKK4f870xf/aQKPSwRkl7x0I+rHj9VUTdIMXw1k/2U5BSqDoeBJ31Mvy2VtII3
         qCpWf0KeuiMo0aHlF/pDE0+ObmOWdD384R4zYtOO7tRZPMvHMF2NvWRdCJhJiVXKSSRB
         GSkdYRu/x3kj8BANTkxYJ+02OmcvFI+DcNBvrYFlVh19YxMy8884Bsiz3DP1/tatH9Vo
         DG8g==
X-Forwarded-Encrypted: i=1; AJvYcCX9E0OTPRZ+U3ThL71BXEkazXQi292ZADihiM+ql9v+Yjy/ZNRm8QN0LPOsRu/PjSVH453v9ALrErhLc0htVVDQ3iq2PoVYRujDatniAMeWE/G5Q15tFagDWVSkaBWnnsjbM46e+SVRhqD/k+GkNV2zpFmpDGCGFadPBWw3lmst4EYKmsw2DhvCWossJw96hewBQL6amE8GBujiHFodhw3+e7XAGQmAHyB1KWLM9lwDBlGhqcSwSeISFa0aFtFKDZ424H+PMIpLIOLYRfrI3g0s6jn3VMUoBrVrfYsHCU8ukz8kNIk2RTaNr/4wpSzCMeimz/1vXQ==
X-Gm-Message-State: AOJu0YxYcqrx3Jk+xADeIogMivjW8jnj+yehpY6F2kT3oP6Qju1qPYsl
	36kd7GeYcPdYpBD/w8A0nadVrcMlCQ0CefQ33YGQwrUg6rhg9evx8l/nFaDryfY=
X-Google-Smtp-Source: AGHT+IEHZPxKX/RP4SBm4cAnIghTfWMy7FOuVWWLSjXVUtL6OKmdClkmrYCnnZGc6EFhsF+GbPMHHg==
X-Received: by 2002:a17:902:d2c9:b0:1f7:22bf:57f4 with SMTP id d9443c01a7336-1f83b730b3dmr43536295ad.55.1718245910002;
        Wed, 12 Jun 2024 19:31:50 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d159sm1755695ad.289.2024.06.12.19.31.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:31:49 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 06/10] mm/kmemleak: Replace strncpy() with __get_task_comm()
Date: Thu, 13 Jun 2024 10:30:40 +0800
Message-Id: <20240613023044.45873-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240613023044.45873-1-laoar.shao@gmail.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
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


