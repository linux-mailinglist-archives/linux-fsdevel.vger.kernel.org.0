Return-Path: <linux-fsdevel+bounces-46113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE6BA82BBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A4D461F6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF508267F72;
	Wed,  9 Apr 2025 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyDZVNkg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429D21A422;
	Wed,  9 Apr 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214120; cv=none; b=H+pwbqabq/DvXArsO3dIc5lmtjrIMSEx5zALuvSsN9LUW4Ofirrn9oCMC2GiiLBSHZUuDsrJHbDgXWgChxtXw0dJUj48LzyxJK61SSDZDa/FWiFANE+n/audHfB61piYq/73XN9g+f99oIKb68chClDe28x3cy6Pltve0G6mOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214120; c=relaxed/simple;
	bh=Z/u/y9H7bfrbhw7EKyJc7oXjEouvThyVHbJQ7zqQJAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lJJurgi+cw29k2eKt9EYORNr8EfvFUFvEBbP7a3Lvac0pUHGWdwtxIOkxPZ69b76Yk5WXeypiUzq+3S3H/lkmc+ixDAHaiNdrBhWPD26MSkS+FkalTzrfFu/z3uIKInZeFuUoJ/P7nKquCmWJA6FjJCntUpQ0yPAS1FGYn9E8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyDZVNkg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so4317305f8f.0;
        Wed, 09 Apr 2025 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744214115; x=1744818915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96rYjwJIel7XEnNFVJz6mXlV9QKD/8bYydzJ5fW5Jfw=;
        b=KyDZVNkgF23xPtkolHniJFzGMEIgjNLVotLAEwi/sAtHM7iWPcT/WNYdjIrQS4wGE+
         l0k5EZh84XW6220bctNmB9OwTnTrurnSgi3ofDKHtBByGSseyZKnDtLP7Atg5FM4/mVo
         gE52Pykb8KtUlPbMX2GDcgSEfNEargrtMrY6KncbokPi6lNVKqYNqzCLuoHKC+yrIctS
         XoyrhJmdfyV2Uq1ms0fxMUsZ6uYaalyHVSCpmnj+/vFqeOTj8e9NckNFq1s1kEOxvD7g
         taVr5dK+LguBTfzAVYoCHaCPeKs8GOiCeY8e5u4ZUKNMBEk4aVVqf2yC2bElS26HXhga
         QTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744214115; x=1744818915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96rYjwJIel7XEnNFVJz6mXlV9QKD/8bYydzJ5fW5Jfw=;
        b=Dj5FakiZcKqYGctdYG6mjuARYm9PUgVWtY6m6HqhLFShtPMam3sgQUgtmHzQWunb7Z
         Lm2jYdNdHrjuoR4QNOQTgpYzUpe4ClND07f0Qf8tODbob2/IaAKfTC4t2irbmiNALv1Q
         yHkPLetU9JLvxX4SiaDsQ5WR6Mp51hORnSVonVVjUGc/jmZcRfiTIsmUNUNxT/L2EpG8
         ZKI5WXh3eea8ZzyoukAnfWdHKwMaSA+8gMsZHCkh+fYNILZA43Tbev4Efmu4NDRjaV53
         dL5bpZOoovZ1JSbNSbF+E9RPvU87ojSqoU0YtzN19nxEHMTKm2aHJ4aqtJMFcZyH7DOO
         AGFw==
X-Forwarded-Encrypted: i=1; AJvYcCV8mcAbDtnYYa13cCxMWKVyw7Bt06wDhXaWJp7GMZ1ouC6+EEcadtTxgHyeXqaZYbxoimKLYui24D1XfjuW@vger.kernel.org, AJvYcCXuxFIFYHctcwt8jUs24pn/uzMQrJ78D61yPvI3fYps1oq/BpMf6Y4BwrNrHQI9iCn+OGoctCZEXXS5GOFz@vger.kernel.org
X-Gm-Message-State: AOJu0YykzBhsymzKa56QaQpig8TI1ua0MDcd/06Ll69zYJPqhYrIIsAi
	3qf4WtzC7PhpFLXNwnJvGGw+xCNTT6oa4Wh0EMGHFzNpXylVuCINxdbtYO1H
X-Gm-Gg: ASbGncv9gknQNclYVhYDIHEMjM9ycBfBDq7GBwfe6f6d3VFq3+8+4EckSdrd7twUWi9
	lbm1y9ANfwv42kV3ED9yqVO4tEwPVhIn0IjzeKVad6bqiLDyHoV4eOg86c98z2+UWc3ful6A6Nf
	ULLoan/NqLLD0uVort4QrSHhnszPeluvleQPqS0RmeQSZ6jhtH0UMDvk+olO28XM9QB5xkbAO88
	ETnclwB+LIRr/Xc2yUTVrRW/HyPuKGIk4VB5ziJCU7DHyRe8hnf9J0FpwkhqtSYndoEfpsRD4/0
	Tgu9hNpR/6ZwT5t5i/rrLdxR6M3wABpzvRGhn3AOwG3FtHU2zjzY
X-Google-Smtp-Source: AGHT+IHr37EuT6rktM5MvALsQLaLzfvBH30bEBRwNNyCckdtfvbLhW4XZugzfoE7BQicQ9uyDyhe4A==
X-Received: by 2002:a05:6000:2585:b0:391:2306:5131 with SMTP id ffacd0b85a97d-39d87cd329fmr3448191f8f.45.1744214114754;
        Wed, 09 Apr 2025 08:55:14 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43f20625592sm23893915e9.10.2025.04.09.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 08:55:14 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][V2] select: do_pollfd: add unlikely branch hint return path
Date: Wed,  9 Apr 2025 16:55:10 +0100
Message-ID: <20250409155510.577490-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Adding an unlikely() hint on the fd < 0 comparison return path improves
run-time performance of the poll() system call. gcov based coverage
analysis based on running stress-ng and a kernel build shows that this
path return path is highly unlikely.

Benchmarking on an Debian based Intel(R) Core(TM) Ultra 9 285K with
a 6.15-rc1 kernel and a poll of 1024 file descriptors with zero timeout
shows an call reduction from 32818 ns down to 32635 ns, which is a ~0.5%
performance improvement.

Results based on running 25 tests with turbo disabled (to reduce clock
freq turbo changes), with 30 second run per test and comparing the number
of poll() calls per second. The % standard deviation of the 25 tests
was 0.08%, so results are reliable.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: replace mincore with poll() in commit message to fix a cut-n-paste error,
    add more info about the gcov analysis

---
 fs/select.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index 7da531b1cf6b..0eaf3522abe9 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -857,7 +857,7 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 	int fd = pollfd->fd;
 	__poll_t mask, filter;
 
-	if (fd < 0)
+	if (unlikely(fd < 0))
 		return 0;
 
 	CLASS(fd, f)(fd);
-- 
2.49.0


