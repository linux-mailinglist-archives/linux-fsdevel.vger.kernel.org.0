Return-Path: <linux-fsdevel+bounces-40220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A760A208B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 11:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892913A3D3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B039219DFA5;
	Tue, 28 Jan 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWhDSFhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2719199EB2;
	Tue, 28 Jan 2025 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060763; cv=none; b=G265IS/FCfz2t3mZh4xRjRi2gy5dYbOLe2U/yY5vUuM0zztlkeY5Yzovzrzf/gN6ynWveDeiNrc8uwdojW6BpdhDTvhgjMl4YkICGdya755s2HNGgRKOfUreHxgL2coZfgzu8uLaZiWj/xHn34QlYGcSRwI0/UhR1ooeY9qQ/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060763; c=relaxed/simple;
	bh=VLy9LLdyqKC61hljttIwuJnD92HQYO3mRBVi1icex5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kk6WaJV/zG+z0wO811bQ518W1s0EfSr98ZPBkbYty1aGWktFdnG32NJAqkPjbaHjyU5s6C9KTZ0vjO0wiXConPxdbwK52s5SMe5DTiRKl/l5U/uQEOZh8zNpAwAczh8QIt0aiKm46fME6ip4USBWfCm8Z7CEj0y9tEaawej3osI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWhDSFhk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21619108a6bso93091545ad.3;
        Tue, 28 Jan 2025 02:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738060761; x=1738665561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=APq1HFpsZy4S0RGnEFmQ684aZOqR+qlyiCYe7Preps8=;
        b=JWhDSFhkL+ofSBtEhG/23De2cUDuKL4/YVaptNinDyv03RxHgRr++3W1WRlBe1lErx
         WX+3Hr+DvihhWGPMFIzvvSYoprcUQL+JBKNLPukY0mZvz5NCTepNqgm0MNDYIUpM9XV2
         FA+qpyK72eKVfOgSWe0l5vxCZbiSvxzhvDt0WuNuo/l91cKpa1O5cqE99U1AH1KJr/wg
         7a0W2Fg93E+EyBP1IqGckL5z1Ilndin9HwSu9BvcMxYAaWfEIc4YQLSQe3gHBUoxst4I
         YN1O4/g0sw41alFg2avuLwFpUDXNDEddjyzRl+X2ZtNZd/O9T1OSEXRRzFUAQrXiOkOk
         cylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738060761; x=1738665561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APq1HFpsZy4S0RGnEFmQ684aZOqR+qlyiCYe7Preps8=;
        b=Oo8Pa5mE5tcbfvyvoWCTK7fbxBtAQfYaD0Q2cDahr9RuwzKOM4NZSoGgiZ+qxsLARm
         kkfBUudNymRGKmmK+2uE0L+bVeZylBi9Jk/pJfNOuJ8G9LT0+7G4uBRPSBN7kOIe8fdk
         Skmbj24JPP9e0w0QG7HfsQAjTXwqjiM+4E5y1BpxobicpP4PSDX2RFLhFNnixg2iG+qA
         BSEkw7GtAQ477t6xZb+G7F5Qrr6uZ1K/rykyr+2gVkQM6iJC1G6c7P+/iktjtoQNkuQF
         H1R1bBvwhmZ/jdLp00EKrzk9SffQSaASua6AnEYQl8AbKvw0s08/nVVAnIJuerDPXZT0
         1Hqw==
X-Forwarded-Encrypted: i=1; AJvYcCV2xCG8Gj8UbmRUpWa5sB5q7VNKb3mxdV3zdTT6bWlE3fJ222muTH548j6CezNU4HV/51HYc1H5RZ5Sv/JzvIu/@vger.kernel.org, AJvYcCVR/6KE64tfri/CuaUVGqktcxtTRAY+oRMUmHAaJwQFT5+rGB8Q7pnHM0+kMnYe8pZTyQ+l9B9T8EO7MeGv@vger.kernel.org, AJvYcCWTaMnFHz15csIJuMPWppTLdJAJryxGMbe5tWQ/rDD2J+k2CvcOAC0yDsju2kYc1eVzt3w1rVhVLsv3OPkG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4eilq2k0hLPTryaJUWOtKpTHzZI2MbKnaAGlTOi5qCUAY8b6h
	5nBw4/uI6jp07UrLfoSJ2jx44oP80dbiClYndzSSe3gwr4yR8jZIYmlsgA==
X-Gm-Gg: ASbGncu7YNP8qzCoDa7bP9JmFXWeMZSGIaMOLAT+wB1iefGz4RV2Kdl4eNgRt98vgP/
	5dLdL/H61vPUH6n6AqykR0aroKrKDBXBHi3/ovCU5A/yYVQ/qfUjGxq6okyeZnUoNtG45WzbzGj
	Q8H22eVOHvmHUfIazuW2+XKm9swwpIqEtt6uRi+UTKeh/XrDbFJ/vauq1NGlXOJotG/J1dRRak9
	h08VbERkfbF67Y+eUt9zSEZ5mFiGqydxqpjxjKjSxGZLWJE5EN/A1Ikcl0qOzcflfuAVFGWVryU
	1Q7dOIPBrG+vzXOBBj7SSz6wnc2p/V9Tiw==
X-Google-Smtp-Source: AGHT+IGAlZQLpix8DubipXT7VaqWxugPpes6Dq+mAangYVIPw0azjF51IArYwe78SeCwoZAu5gQmsQ==
X-Received: by 2002:a17:902:f393:b0:215:a2e2:53ff with SMTP id d9443c01a7336-21c352d6cbbmr499938975ad.11.1738060760870;
        Tue, 28 Jan 2025 02:39:20 -0800 (PST)
Received: from Ubuntu.. ([27.59.87.238])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21da3d9cacfsm78702015ad.31.2025.01.28.02.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 02:39:20 -0800 (PST)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: kees@kernel.org,
	joel.granados@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH] selftests: fix spelling/grammar errors in sysctl/sysctl.sh
Date: Tue, 28 Jan 2025 16:06:55 +0530
Message-ID: <20250128103853.7806-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.48.0-rc1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the grammatical/spelling errors in sysctl/sysctl.sh.
This fixes all errors pointed out by codespell in the file.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 84472b436c07..f6e129a82ffd 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -21,7 +21,7 @@ TEST_FILE=$(mktemp)
 # ENABLED: 1 if enabled, 0 otherwise
 # TARGET: test target file required on the test_sysctl module
 # SKIP_NO_TARGET: 1 skip if TARGET not there
-#                 0 run eventhough TARGET not there
+#                 0 run even though TARGET not there
 #
 # Once these are enabled please leave them as-is. Write your own test,
 # we have tons of space.
@@ -764,7 +764,7 @@ sysctl_test_0007()
 	fi
 
 	if [ ! -f /proc/cmdline ]; then
-		echo -e "SKIPPING\nThere is no /proc/cmdline to check for paramter"
+		echo -e "SKIPPING\nThere is no /proc/cmdline to check for parameter"
 		return $ksft_skip
 	fi
 
@@ -898,7 +898,7 @@ usage()
 	echo Example uses:
 	echo
 	echo "$TEST_NAME.sh            -- executes all tests"
-	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 number of times is recomended"
+	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 number of times is recommended"
 	echo "$TEST_NAME.sh -w 0002    -- Watch test ID 0002 run until an error occurs"
 	echo "$TEST_NAME.sh -s 0002    -- Run test ID 0002 once"
 	echo "$TEST_NAME.sh -c 0002 3  -- Run test ID 0002 three times"
-- 
2.48.0-rc1


