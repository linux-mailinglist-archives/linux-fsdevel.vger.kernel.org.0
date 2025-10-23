Return-Path: <linux-fsdevel+bounces-65339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBA9C027AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 18:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858841A68590
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B6B3385A3;
	Thu, 23 Oct 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNfANo6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DFB272E61
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237848; cv=none; b=IkVjRYrrYqN1uqRq5HpnJExmufg9TqePfLwEXklH+8ek+SFeP487OffjEgCUPBi2TXvNxatoCcaVpGpHixgoRUxrwgMDgk3YkW2o7am8EocObj+cRSanRuKBpNfCVoHvKkJXwqicLos9HoX9dz944aeONem486ZbamVBT3oPZX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237848; c=relaxed/simple;
	bh=8fIX7biSbEZ4B4b77XL+f4TS9/Jp/xnQ/nE2WkTPmO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5GmCoNDfdLsnsFnCElDdoqCeKj49Qx62ocsP/dVyqblAEx4lQ4sz1jRQHjuKNNlW6BKue161xZsSO8ZI097SGaj7/M0VouZyuNPnjMFMMWKzj0Ybq32SjKxsza/2WWhLvVKAF9gWQos7OvKjOfXGOYdSaeG+5tCRWIDcCEQ6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UNfANo6B; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6cf257f325so929944a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761237846; x=1761842646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WBSNSnNcjQaKaCnCJuZwnw3e0fnN82ayIMOAkE29L9Y=;
        b=UNfANo6B8NSVzy8e1ma/B97PuCjyURVP7TRevV1niwA32P0DuFNbUX+ZWb/htdYPgf
         KCUTcWls2F5vwBfCZ2kQ0/LfYASwdQdni06efKEmlvBPpETt8DZ6cm6DuuBmIBvLBT3B
         8ZsMmRQsHRs7vFUp/gCXetMYabgeiddOMDnyjT/vilJDmf96i+RSlfIN95b9jSjDmQ4T
         i1fnBQ7GhAYxdFnJrCAXKl7t9K7JWBLTlkTWKV62wEQxsGs5BAmS7YhCKu4b6WHAC6QN
         iNNcVBTRZvQmDlPPzpdC8nCRtHg62OZJkqM7R54QQ3DD5W6pxF2Goz7lGnybBXSzDZp8
         okMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237846; x=1761842646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBSNSnNcjQaKaCnCJuZwnw3e0fnN82ayIMOAkE29L9Y=;
        b=Yd277fO9ckCfmYtozOzMIReprt4dJhpJ71ROw+8iqHLl/uye7bkaHHk7KAfYTvBeO7
         WQzOP9ojkB6v6PrzjRq9TCJYkwMTC8sVlkctgHXERMHrm95Ky9sIgPE4grQ6EV555sbK
         5IHooBU1rDcorboNBP9nwj+QKKm66RiHzyyH5d/Ufs1D72qvRsBUrdIBPMUPwDpf6Aeq
         jAy03n4Z7Mfb4K64ttMCBThuvGoRDyckL3eYuV8xNt/KVLzhsUcK1p0VkRtvpPOkv9Ar
         +M9WSDmCm97a8EeK5aIPAKhhGti5itY3WF6kxDstJ3CMO4n23FBUSD02xAtQqAp13n7t
         SaCA==
X-Forwarded-Encrypted: i=1; AJvYcCV93ba/nuLS+EyVipuMFBI+D74ZS8GBXZn5zLrh8V40cij3oBjBNC5SP4o2h9izWoSOHcGRzT1QG0yU0TfU@vger.kernel.org
X-Gm-Message-State: AOJu0YxdpVsD1anEq3JZ2avnRirTnPCc+jrQLU/SaKloHBZco7ZC6kL5
	gvCg2X6Qyoh1LKxhuMtCab2ZmknS26udLGJu/Y+ihIntSCnUAx30Urgbr1rF64rTZWE=
X-Gm-Gg: ASbGncv2Q/KmZYUTjJO3ta3muhgxnIEXaWMGNrGfsamYlsKAAjOxAfYma8o6P+Aeo6C
	CFiVxbCkh4g/8lppg2cnrukRyRx96KzmL5vIzgDb63FV9WUoUsLnS8keN1rPgoBgNsHUMu9CZ8U
	WpiJtArRjI26IbsyFNDCPtyVo6yRV4K/Xxla5gcUeOkf1EZu/Vc0N3pni85gbL8Nz1BE5Gwtaj2
	3Z05B6wVEw16aSetSgXMbNk9JG47O0tIXzjfBV0SASX5sB5U0Bq2yFuhUwVf2X3wz/j/t1ODJIq
	DTP1tTozXvH9KfbEmzIDaYbSVf3YXYmeQc5FBmvvVyI3ocIKwjPNdmrCxto0moaJcawqMdtWuS3
	lRcirQjsYbKbzSw4uxzX0LmWra97LsvWFbzpyXyFuLXjlbqkyiCl/+169qOhM9dS5ZWQd68Fm6g
	Iv6VwD+sVwHObHVR7GxOFY2bI3qGIhZTXW1iCMkurvA50WK5O2IA==
X-Google-Smtp-Source: AGHT+IE4pFFH1ySU5m3ad6i6VUzfPRs66wcF55zEy8vDarPljKErMuGfeUnYnh7PBCKkJQkt4U7EUg==
X-Received: by 2002:a17:902:cec2:b0:282:eea8:764d with SMTP id d9443c01a7336-2946552521emr61649525ad.35.1761237845759;
        Thu, 23 Oct 2025 09:44:05 -0700 (PDT)
Received: from localhost ([2405:201:c00c:2854:d184:69e6:58bf:965c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de0c894sm28713685ad.47.2025.10.23.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:44:04 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: ltp@lists.linux.it
Cc: lkft@linaro.org,
	arnd@kernel.org,
	dan.carpenter@linaro.org,
	pvorel@suse.cz,
	jack@suse.cz,
	brauner@kernel.org,
	chrubis@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	regressions@lists.linux.dev,
	aalbersh@kernel.org,
	arnd@arndb.de,
	viro@zeniv.linux.org.uk,
	anders.roxell@linaro.org,
	benjamin.copeland@linaro.org,
	andrea.cervesato@suse.com,
	lkft-triage@lists.linaro.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH v2] ioctl_pidfd05: accept both EINVAL and ENOTTY as valid errors
Date: Thu, 23 Oct 2025 22:14:01 +0530
Message-ID: <20251023164401.302967-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer kernels (since ~v6.18-rc1) return ENOTTY instead of EINVAL when
invoking ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid). Update the
test to accept both EINVAL and ENOTTY as valid errors to ensure
compatibility across different kernel versions.

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index d20c6f074..744f7def4 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -4,8 +4,8 @@
  */
 
 /*\
- * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
- * happens when:
+ * Verify that ioctl() raises an EINVAL or ENOTTY (since ~v6.18-rc1) error when
+ * PIDFD_GET_INFO is used. This happens when:
  *
  * - info parameter is NULL
  * - info parameter is providing the wrong size
@@ -14,6 +14,7 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 #include "lapi/sched.h"
+#include <errno.h>
 #include "ioctl_pidfd.h"
 
 struct pidfd_info_invalid {
@@ -43,7 +44,12 @@ static void run(void)
 		exit(0);
 
 	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
-	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
+
+	/* Expect ioctl to fail; accept either EINVAL or ENOTTY (~v6.18-rc1) */
+	int exp_errnos[] = {EINVAL, ENOTTY};
+
+	TST_EXP_FAIL_ARR(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid),
+			exp_errnos, ARRAY_SIZE(exp_errnos));
 
 	SAFE_CLOSE(pidfd);
 }
-- 
2.43.0


