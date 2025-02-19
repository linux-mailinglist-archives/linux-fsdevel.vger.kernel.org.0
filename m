Return-Path: <linux-fsdevel+bounces-42031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C447DA3AFE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 04:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3B9174339
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 03:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8E1A239F;
	Wed, 19 Feb 2025 03:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT8WpD9M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486528628D;
	Wed, 19 Feb 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739934306; cv=none; b=heOb3AOZ3l+npFT3ACxMJ41/+A5xZ9RS5RG1OgcWAh5FeO9lCatmYosTCFCurvEsZOB8eeRjyHc95osTDnoBz0FZ5UpOl+f5YZVhoP6k5IWpmS6YzAY/tm3yQKiSBRriW8lmPQu4gbH/pMPY5YG03UZsUZAX2tx4IMHBQ+JzAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739934306; c=relaxed/simple;
	bh=xqhXmRmGt10WILRVRFX0nFpaOglQ51zq5WCAt+bSjhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IWmRO7+CtR04iNTa+eCJb6eIGcWb6NrA0w3E54IApqJybhMhLD1IzVi3l7rRZE66u9YnGavXAoRAzPPGAe00NCK8GyHFW8o+SDHUO7JjhkrVuuLHyDM/Ftn6VwaaR31did4JOx7IyxAsNE6h66C+lD7mS0dOv85r4EpaTMIRGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT8WpD9M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220d601886fso82953745ad.1;
        Tue, 18 Feb 2025 19:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739934304; x=1740539104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WP6ht26zVx1Wk1KNOxJ+ObaR5Ff/xn1pNGU7t1suOmA=;
        b=VT8WpD9M3QqXLF4hQASrJnSP+8jI6R5kiOpxrwI6y7dKpzvnN45jyavRKPTkLcFuiQ
         QC9+g4Z7KXDCB7SyXR5hCAyQQmhaJ/eQsu89exVxJwLoJMhvfYecQdlSgEmZINuMg0ET
         9fVzONA3k4tM82+7x7u6fjFqwq313GV65g9GfLV1V7knGZqIWud3xsbMkG+DKNSJZf+o
         MVP1x+stPlwZ8SvXvpyL9eT2pgWR83Ca81kwU2jSbPUihOWAdSL6C6/aIC+N7r52pcdy
         /RgK3hul0jbq8M+X64+lsYWaPI9kp6gg2HNtrm5qNPSbwRarQjnIlpmZ9MUGJP9IP9j0
         SkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739934304; x=1740539104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WP6ht26zVx1Wk1KNOxJ+ObaR5Ff/xn1pNGU7t1suOmA=;
        b=trGjE91a4eB1l6UQvtAsNzOqHnd83WPiAREJwXYO2G/+td0p1MUkhMMN3aj0uvCsRa
         /x0uducI23OKyziyjuQLSRiQgMaut12UZk6xe4YN9KclTGBnDmGHBnqEVAP35MZNbJs6
         mnfsWBr4lXrVJxYYCvDKFl03JHjkK3mxXHlxKFZhrFbaVMIH7TU/Su37elisA039ueRD
         rpd13A/+XhSSRzpGboFu4z0L+EpzOBQ60AJ8tbgi/QSvt5ur+fOf5FRLmC3ZuQVKa/7K
         W/cDPab0sNVr/QnEDOgbNahgFNwikjA1iNQ0AtQ7J2CAp3oqG8yFaY97Y0NlZx1zFm5w
         TGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZSRifTC7dDxza+dcM50mSs5Ap7x7gle3/Rhz1hRGu5g1zInvu4Iz57ytjVlFGtuxI0FRy6wKKf5GCfSSEpEo0@vger.kernel.org, AJvYcCVnPfqhq4x+wrND1/WuflMXVOZ3Flp2y2QmB/yBfc18Dw7v9e577IC5QXthTtE6fxsfT23pFCY9YUr1EuzE@vger.kernel.org
X-Gm-Message-State: AOJu0YwCKjzSgObyGRF7eWDBB1OR/YHLvWuPzG8kd/mU6J9GhE1Z47EF
	dTKx0OFyYjOqBi7Fza7llkN4JiBuddSEPOgwvNlmN5yJKfPdinWBUTaBiit7
X-Gm-Gg: ASbGncvQMTDoZZV1PlLQXUgQXCjsXLwjuymCgMYsWEqwXjcrc0LNvYn0C4zsoufz4ba
	8iRj9py1jLmLAYZlZjDd4uoJBDF3GVfzQI3Mqntnd1mF75i039DiXAy7dCcZysf5WJ23i83FtIf
	+rSE3X0f9gGgdIiT/xrUgvmvABN8/gy4XQzoyqpV9rsnEemTmX/WqIVi1Wz43qDuV+c0UF8csCe
	CAwNg6/RQz9a0u8sjBoDreZgn/ws5Cs2fAE4qAotLaluUB0ZaTjGMHeeJ/A4+MJKia3DxvUspU8
	SkPFwVZsWRmlH5AEtzzR8EvrbXl2HJF4ScOXRQHMad3uobsRcMCdNdImeS+klHmpcy6iIKbFKw=
	=
X-Google-Smtp-Source: AGHT+IFZiOAQJB8BaTDOEtDlzQBo8iYTkzBhRlEHPrbyWC5TMjZeIu0sOTh7QRiax5maNSNHhbXl8Q==
X-Received: by 2002:a05:6a21:7888:b0:1ea:ddd1:2fcf with SMTP id adf61e73a8af0-1ee8cb1ddf0mr27931861637.4.1739934303922;
        Tue, 18 Feb 2025 19:05:03 -0800 (PST)
Received: from node0.suho-242436.threadtune-pg0.utah.cloudlab.us ([128.110.217.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a52af2esm9960126a12.54.2025.02.18.19.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 19:05:03 -0800 (PST)
From: Sumya Hoque <sumyahoque2012@gmail.com>
To: sumyahoque2012@gmail.com,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kees@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests:sysctl:Fix minor grammers in sysctl test
Date: Wed, 19 Feb 2025 03:04:51 +0000
Message-Id: <20250219030451.39782-1-sumyahoque2012@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,
Some minor grammer issues that I have fixed:
1. echo "If an error every occurs -->  echo "If an error occurs, every execution
2. Example uses --> Example Usage 

Signed-off-by: Sumya Hoque <sumyahoque2012@gmail.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 84472b436c07..a4d76147ed8a 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -891,11 +891,11 @@ usage()
 	echo "    -l      List all test ID list"
 	echo " -h|--help  Help"
 	echo
-	echo "If an error every occurs execution will immediately terminate."
+	echo "If an error occurs, every execution will immediately terminate."
 	echo "If you are adding a new test try using -w <test-ID> first to"
 	echo "make sure the test passes a series of tests."
 	echo
-	echo Example uses:
+	echo Example usage:
 	echo
 	echo "$TEST_NAME.sh            -- executes all tests"
 	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 number of times is recomended"
-- 
2.34.1


