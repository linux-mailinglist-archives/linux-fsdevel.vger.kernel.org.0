Return-Path: <linux-fsdevel+bounces-22412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48221916CF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DE51F29286
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C446D17165B;
	Tue, 25 Jun 2024 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdoHwJ4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026C16EC08;
	Tue, 25 Jun 2024 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328914; cv=none; b=tRO7zx+iW4cxuziXU2RDT/Q/IaRLZzL30DdAeqqXG0LuxukJjRCyk40EwGzSrnutNUsRrGumReDk2o2bWmjTFkW+kTm64CuEtyLbHM+jpPdXoME28c7sP1nD0n+qKJxFli/yEwPT/h6LEcJyegu9KRZmAAHoyyrCVLEPt/JTxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328914; c=relaxed/simple;
	bh=7113lzuAwhu5YW/fvVxHMqH6c7oZq1285w6QOgZ+v7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KhjHJZQFb16xlMng4GyLDnotUe41ZGQJ6edJXm354YGLAo+Gf4voIuo6r8CW3Y6hsoQbk4qnnZkO88MR2N9/s70LH3hE1/6HOaC7AyIPYjSoCyFRNW6/gW1DyzXbaY68U+D9X7seOG6hcYyBBgqkHeA9140y1jDRbjO7qg27rLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdoHwJ4/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70699b6afddso648809b3a.1;
        Tue, 25 Jun 2024 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719328912; x=1719933712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udsj8F3Gmu1nPkmB0pulDBxb9TSeq9nck/kC3senj6E=;
        b=TdoHwJ4/FBz3yo2khF/lQ3dX020WEJ6wAw9EG4s/Ve8iVAsiNWFgru2bRF1PaTx1c+
         qyk66Dfa2iSoQK3y/hnB4Q79zXD1tsz35cDT2qShQMojPpj3bTPAVNWBYVh0BhGi53Wn
         1eQ5MFQD8fej094K5uAjXs4Ueq1w6pWGTYfgnenywiajqnQIxfl7olTNeGzhzLp7mHFX
         M5lIwa38yJziCps0LpZ4yAwK3Eul2gg6tuSpVYqZxUwxw/3AhlYRD9EdR6+vNYirrtU9
         Ia+xtEWUTmSXGIOnusz38mBtwSwykuzVmXipv7h2JYC/8Dro1tr5c+zZwzyYjJOE5mxX
         MPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719328912; x=1719933712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udsj8F3Gmu1nPkmB0pulDBxb9TSeq9nck/kC3senj6E=;
        b=B2afylGNQYNbXZ3w9s7iIrlgU9p4LZJmH2xbDAJ1mXqbTVw0J2a7jcEUcoZ5I0Fqex
         MJD1po98sNavQbW3OhcXqFWUSgycZqSML0eVL3a1gn6ypI4Has/jsusaSmn6F2enLM4e
         k/LdPWjha5RsdjQI2S/pPooqOaygywInHtciz62ByoHWwJ9OXDTk2pE5r2aB6k6UG149
         YAsxwznFqompAVq9DRIJwYT7Iw2Oc/l9iP7yDWEpYfiKWEtkAImrWMEpyG2tVvDMCdYL
         VmEDKS1lfKYlc73ek09mxgiag2sKlq8z8bqvkGepSUXMeXgHlNqjHUpWY2p1T4yKFVUm
         4/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVCjYYNVXETAk0egRjEYGCoqvmwcWC89T1s7iUWdnLH0bnzt8cFKxOXhCdkfQppYxv0FULiIPwpgbK1crzOKWRhMmKyuqIETQK3E+gRuuHP1+y39iEfI1jMixqsz7C2uQU3+xt34KK7+bW1w+By1jvdAb+3PTkG06glGJDP7J1p3huuHD5ezuz7MiXfbQ==
X-Gm-Message-State: AOJu0Yxw7BMR7NicMZpB/AC/QV20cCZTktPrb53HkX7IDZ5AMwe2rL3U
	QZYcgmY0qC3s/52XW20T+JL6KuUgc1HQROCSn586lZqVafPu1suc2efebMUl
X-Google-Smtp-Source: AGHT+IHq8aYqHC0HMA/+3VF56wT+YmOaj05hwTBl2KQCTVeVodMKv7yIknzEAGprV2NlXt7lE59YVw==
X-Received: by 2002:a05:6a20:1aa5:b0:1bd:1d0e:90fc with SMTP id adf61e73a8af0-1bd1d0e95d8mr2030571637.1.1719328912110;
        Tue, 25 Jun 2024 08:21:52 -0700 (PDT)
Received: from dev0.. ([49.43.162.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7068c719371sm3324620b3a.102.2024.06.25.08.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 08:21:51 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH] selftests/proc: fix unused result warning during test compilation
Date: Tue, 25 Jun 2024 15:21:39 +0000
Message-Id: <20240625152139.16412-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Check the return value from write function to get rid of the warning
during test compilation, shared below.
Tested by compiling after the change, the warning disappears.

proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’
declared with attribute ‘warn_unused_result’ [-Wunused-result]
  385 |                 write(1, buf, rv);

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca2bf..510ab4a5330a 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -382,7 +382,12 @@ static int test_proc_pid_statm(pid_t pid)
 	assert(rv >= 0);
 	assert(rv <= sizeof(buf));
 	if (0) {
-		write(1, buf, rv);
+		ssize_t bytes_written = write(1, buf, rv);
+
+		if (bytes_written != rv) {
+			perror("write");
+			return EXIT_FAILURE;
+		}
 	}
 
 	const char *p = buf;
-- 
2.34.1


