Return-Path: <linux-fsdevel+bounces-34749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877949C8569
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201D428443B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40C91F76B7;
	Thu, 14 Nov 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNbFXWb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8C1EB9FD
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574779; cv=none; b=TlAi1g5+aAhcD2DeynTLdvCJPSzVvs4Zfdug9lzfv2h4/dlpvO1Su7NX7w/nOO9nvDMLf8KdR8bmKX4d2kPAyQOOACySY9LcpJ6UDy2zTdYqUG3EtxU4IVz4o/Qc4ty0vi60esoXK4BTRyhAot4mJRbxnTF3VzB+aB7Aq7ylV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574779; c=relaxed/simple;
	bh=XycamBY/nYOgqAvwbffcnYn4/Yabq7JhXqCOkrXC1xo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kqikarhztBVZE4+rQSh/8nJINcf6c1hTIK8JJHSV8n6OsEUYP0k0n4dEANM6Yk46uZY7SVYDp1DhjG4I2QHMeR4EgsUR9rYDUN1W5vBgVp1IiMpRethkhQbb4ZlQSr0Kygz5LbPy3RBvjiROsHgTd3PNGgQWrkfwGU8BYYlBwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jNbFXWb7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cf7567f369so470149a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 00:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731574776; x=1732179576; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFvv3LbF9Kdg9CtKKlONGsxCX12ovGg602Za7rDJdl8=;
        b=jNbFXWb7jcm+CDw7YVEZz23nl4UM1utKC5g3fqOHWPXKBMO0zc9aZ89LoDGSm9se1r
         cK2tPrK5YvrJJ6nFOSMXEamgQTC7+6HczQZOAvkwO5O4+dn+tKblhZJtiaKiVOazbgEX
         xadz47PXFUddSC/bEQWU/uR3dekqmuqZLEpxTgAsZwXdDbXLnYWOJ24DgrVm6+To9Myu
         y4I3y7TwIkULbdQQRRhtYpExJtqtc8brkAI+NdbgXPHPTyqqUKt9LhfqqWlR2RHKig/x
         0Ts2fEP2bKzcTRYZ/0Ist/ixEJR1vw30RHzkbjDq4sqXE9SZ7VimomJpiFIyUUW86IKl
         grJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574776; x=1732179576;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFvv3LbF9Kdg9CtKKlONGsxCX12ovGg602Za7rDJdl8=;
        b=a3KL5YJPphhI6KdMHjiIF/LLKrIQuIoyL9L2zh0RJuqW2e7TMnvuMLgeJbtsfXu9Ds
         hwhO6gkXHr7kMDhUoJrD/eC0mSAXfdTPXwJ4DYAFQ3RhqMCAYmGOBasmfmqEqq31oXUq
         4zivWvXGH5Ks++thuETFMRIkAJf9MX+Q8okhztjGzAM1f59HsVu4MPMfCVH9jngHWuUY
         iQwteiX2laGn4Lf9wGLqY+axwDhatRW5NzXoOsdByPnSHtzFMOGiWfnggQsr2pQDSmPo
         yyu+gHeAq8uquVkBwU+zA/X1NUVxxXkUP+kJntHwENrbx/fbjWIbvuio8kLHaxJuTJpl
         cayw==
X-Forwarded-Encrypted: i=1; AJvYcCV6vTi/6Y0s/k54p1KPsd7zArYiD9WHSWb5nmPjzvPeBsKCdHqL/Oy6KYoAtrp/t17VWlTBpHWkhAY5TOgk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4fxBi73FFn5gJgdaO2Zy/10D3Chy+v+gNLM8t4zp/o/bGe8T9
	RFF0zWhoO6dp2yQVLYLcsCAt9KXPWLopnmXezH1cobvDpbEDLOUjr/nQ4e4MeTXwPFDEWRTxhFu
	4
X-Google-Smtp-Source: AGHT+IERWfaAqNKqw9yYfROoHVQjEmjB8jy1fnYHJoHTg2lYc4YgdDb9SwWLsbU0fU1K76xN3CY0pw==
X-Received: by 2002:a05:6402:40d0:b0:5ca:da2:b2ca with SMTP id 4fb4d7f45d1cf-5cf630c4fc0mr5133838a12.19.1731574775753;
        Thu, 14 Nov 2024 00:59:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df56b13sm38701066b.76.2024.11.14.00.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 00:59:35 -0800 (PST)
Date: Thu, 14 Nov 2024 11:59:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Andrei Vagin <avagin@google.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: prevent integer overflow in
 pagemap_scan_get_args()
Message-ID: <39d41335-dd4d-48ed-8a7f-402c57d8ea84@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "arg->vec_len" variable is a u64 that comes from the user at the
start of the function.  The "arg->vec_len * sizeof(struct page_region))"
multiplication can lead to integer wrapping.  Use size_mul() to avoid
that.

Also the size_add/mul() functions work on unsigned long so for 32bit
systems we need to ensure that "arg->vec_len" fits in an unsigned long.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/proc/task_mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f57ea9b308bb..38a5a3e9cba2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2665,8 +2665,10 @@ static int pagemap_scan_get_args(struct pm_scan_arg *arg,
 		return -EFAULT;
 	if (!arg->vec && arg->vec_len)
 		return -EINVAL;
+	if (UINT_MAX == SIZE_MAX && arg->vec_len > SIZE_MAX)
+		return -EINVAL;
 	if (arg->vec && !access_ok((void __user *)(long)arg->vec,
-			      arg->vec_len * sizeof(struct page_region)))
+				   size_mul(arg->vec_len, sizeof(struct page_region))))
 		return -EFAULT;
 
 	/* Fixup default values */
-- 
2.45.2


