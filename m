Return-Path: <linux-fsdevel+bounces-20818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD458D8297
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B99CB2268D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 12:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA9512C7FD;
	Mon,  3 Jun 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCvfpsXI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE377105;
	Mon,  3 Jun 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418585; cv=none; b=Xi7u/rjTpyznmSUhhKDWAUGPeUP3RRwFDZRahxNM0Us1l9QCsWviS1tCW2Ldu/WnKnUGwmCgVFdUNRWD+K+4sp+21a/Nzc6aW3El1JzW18JBONc7GTLOnd1vrkkUDkZ9Zm77CFC0MQ4Qxeuh09ol4hNP11QmBFcOJPAQKWTjK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418585; c=relaxed/simple;
	bh=H4fmjwOwpParEuoJtbAW3YxLLR84hx0EJGLqThf2o7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBFGk2XfChOxkNY3zZX1fX1EVoer3VxunBUf9FIr8CQX0PXf6VSoEnvDoHPn0GgNZcr4CFUupBlOWnghcG5bCnLqN3sifksyGES8OVygyvJe5AkNGDlO335exBZkGUdVY5eiwFblqI8MYrtiPRdjop+Vvr23BheKlY+vtVmDUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCvfpsXI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso3669828a12.0;
        Mon, 03 Jun 2024 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717418582; x=1718023382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqoQJRN01PNk+bAVmoa7Kjw5CtJf1nAglZVWYHoV7wI=;
        b=lCvfpsXIwAo9toNGzUb0N6DsQmbNsPu3Wpzr16CwuRRAMlp71LzBBCINSlVvB625No
         sgvRKJoVvHuYk/QNsxt1xgGrelUR4fg2pWxGEEPcsxuY0oMv8HbTrgVxreLaUPW28rW6
         LFqNKxUteTA6HYyoR3utRgWBxcS92Kk7vYsTE/C+TK78fCxBRyPTnCNAoO2JoEWPS1/u
         b6Z21goylK5qS7xs3l99Ovrlx1+yCVSxjV/TiuYuM5GvVG/vUJXEqZbKpsyMpsCPWl9L
         P5D51lJdz5riTCpl5vr8f7L9Lb7mpV6WlGYA6RpeVXT61yJbfpBlVp8dfYw12QZujtDj
         Jtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717418582; x=1718023382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqoQJRN01PNk+bAVmoa7Kjw5CtJf1nAglZVWYHoV7wI=;
        b=avT85eDTlpAjlEKVZKlD3sqw032P8IquGhQc0wR1o23uI+onFwfTPtGegqpWx8px6Z
         4WPFaJACHjtPZMp6pnJMAT3Z2kGB126/McXj5lYuBju6uXKQR3wbrSMWuCJUYty4yYnI
         7yxQplebmDzLVTtKobZA/xpWVu9zsxiNPnLPCDoKA9y6eUGkcgQQKjRigkEruJ1POG99
         oSKL/exeMGe4AQc4Il86ouRd3hSCfJ9FmuVKFupjdNRaooFd1KfGunuTOA74fUij6hW5
         XR+I/tV6CKjKD7ldDUN+RmpWOPYrswKhoSP6+z7tV8BtHoPltiEurLcgz+zOEklu+rBB
         L3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQcu8CZLPKfZCAosZzCsiOpdFmK5IukY3Irarc/914BD43eyUfuZvSs+FMp5pK1MF23ByqJBvMylckX7IuSg7S7UVMDpV11qrhkz4IWukM0s/a+1A3/Tx+rtufAjbdl/JtYEDqQBOLNdgtgvlZ5o0UeOvTzn36Ocoi2j2ZH9SqIQmRYltyhwwl0C7Lxg==
X-Gm-Message-State: AOJu0YybQzXzy/H9OTEGK88tPus1inCY0vyimnLvr1RYaXxToN5JLWK6
	KHRJdg0o8oLS0SkH+CeBEPIQ8XrThH6qR8QNU7z0k9tYjQTxzHVI8skFGF4Elb0=
X-Google-Smtp-Source: AGHT+IEVUqFQKNVU07/Yn+CcKliW8whW8qzl9ojbUF81UIpNNC/tIg+ZIK/esE7bOiPUPXXCUi5xLw==
X-Received: by 2002:a50:8ac4:0:b0:57a:4af6:319e with SMTP id 4fb4d7f45d1cf-57a4af632b3mr3729283a12.1.1717418582387;
        Mon, 03 Jun 2024 05:43:02 -0700 (PDT)
Received: from xps-15.. ([91.90.123.30])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57a3e776c47sm4658364a12.20.2024.06.03.05.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:43:02 -0700 (PDT)
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Amer Al Shanawany <amer.shanawany@gmail.com>
Subject: [PATCH] selftests: proc: remove unreached code and fix build warning
Date: Mon,  3 Jun 2024 14:42:20 +0200
Message-ID: <20240603124220.33778-1-amer.shanawany@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202404010211.ygidvMwa-lkp@intel.com>
References: <202404010211.ygidvMwa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fix the following warning:
proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’
 declared with attribute ‘warn_unused_result’ [-Wunused-result]
  385 |                 write(1, buf, rv);
      |                 ^~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202404010211.ygidvMwa-lkp@intel.com/
Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca2bf..b3f898aab4ab 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -381,9 +381,6 @@ static int test_proc_pid_statm(pid_t pid)
 
 	assert(rv >= 0);
 	assert(rv <= sizeof(buf));
-	if (0) {
-		write(1, buf, rv);
-	}
 
 	const char *p = buf;
 	const char *const end = p + rv;
-- 
2.43.0


