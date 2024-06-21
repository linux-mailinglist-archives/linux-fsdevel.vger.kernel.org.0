Return-Path: <linux-fsdevel+bounces-22055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488CA9118BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FC01C2126C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5312C475;
	Fri, 21 Jun 2024 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1X5K4oL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006C824AF;
	Fri, 21 Jun 2024 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937159; cv=none; b=bezzjMJXyPMzEp9objaorFqGUVmMiP4hbr3/Y0E4YFFbBA2ul4B2BdR4Rm6eB5SF9L5BaQy3Pul93vtrjvrmmnK9BEHdD40cijv1vlLEaAxLhtzvv5szXg5F8vsGYE2xwa5vAPW2xmhdkgmEmGbXlcbuOiZjWN86FVZ6fNdxdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937159; c=relaxed/simple;
	bh=bcqj+z1NoYts4nxjKW9eq+NmMzQwTovBThDBaNsM4Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jo6q/iWBb5CGhOVBTKEzHFYAd6p6lTNfBvTPjO6DgHojo9/a0ngPO6olMY6fxbxLIiyDCbFwtJIMUdU9fvDG63/l4X48Q5q827L+ssiSw0zuIKy+iFBseF9OfRRv5T55DeZghVN74VZpMZKhRDntVwLxNI01YCjtqDgJE9kHMUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1X5K4oL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7041e39a5beso1277983b3a.3;
        Thu, 20 Jun 2024 19:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937158; x=1719541958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mM/1S9T2tBYoZCgE31Q/lEbGdBggp1bwKT3yTD3UzMc=;
        b=I1X5K4oLYibIFzNVpAmBzaZkc5u/T8QjmPjdxrSNEBm55PReEOMEsb37cfayrJVM+E
         nTR1fECsdFA4JjE+9U/HYGHprjyJ1tWfZMyE/FNziVeWzzjNeCP5kHEbwtqNjMApnw18
         hIw+F63K7g2VKRVzzeJFkLA/AlSLZVWN48qAvCgNzfCOxOgspVlbYwX23TDcS5MxwfbE
         7jQoLNNbLMixOJyIIBOaD3P07wzyUkJewetnh6mL7aVYil4aD1eAV5g9X4B2P/MZ8FCo
         roGW6TMWKt1weInMEBeHkTdKmeOORSOdp8pMYpGnQCKCEs/TP2cCXjySxUmA+FSJg66e
         rc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937158; x=1719541958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mM/1S9T2tBYoZCgE31Q/lEbGdBggp1bwKT3yTD3UzMc=;
        b=m+JEmjCzPzGxBMSwiMazt1g0+WV3AAETRsthM3PUUBRHLfqEAt7H8/j/XlwhrBhgSu
         vcL/ZmYsr92VRonhSj+pfkNQSrTbiDyB3JFb3Rht6AXdXjmRnteXCUgZxANhLzUOgLX6
         XSU6DkGQjwMMLOMV+DlGAE2DHLd+qhgNoHZEjdMIvlun4jZzvRwknQ1FtZT80rZ+P6b4
         HSW9vxnTibv718ECsWxOfcuGkia93pwSdoK6EcFszlgW3yk81HcT4OCGCqHefir1GZk2
         fp+dcelkRNrEsdZogzpO8NgUK5cc12/tiXZ6MiZWG3k+k0kWKS88ZGMlG3jPuVW5F/Fa
         FYqg==
X-Forwarded-Encrypted: i=1; AJvYcCW0uF+I+CMozQ7mn57RN8wGIuaM0n2RhBBEnqq2Ma7MEgaEBp5OIyRhKhBdcQvnJvW5/JsN8tzL8NCjpWh7qrT+APNfMSFNM7A4DO1EY9si7p64U/b60vvaRGUF4UgEZlX0cjgFzxieEJA5vj9DuqhZYadrsElGs3SezZjuoe8SVadLPHIK+Cj50lPGkwiAr5brkLE0WhTKEafUkOTXl9tmZ+apIgSIreSLl4NEytkcUZN2QNtnsJU3GseN29GBps/wX8Gyy2wL4t+WSck0OOn+yvsMogif4DtpDTQri7vDLz5jzmCw3MlJOMDRzV5003INnDep7Q==
X-Gm-Message-State: AOJu0YxEgfRf2E41hFW7S7823WtJFPmV45he3M8YuVv6y+KoQrxw95L/
	eTfWYtzbzPgUikTbN4CvRKvP7GF+k935DxAnsuYxKQhrq7uIchqz
X-Google-Smtp-Source: AGHT+IHxOQrDg8mR1N6VheTp8u8eV+XoRh0OG7Yl/1zkogSK0YkzXLknkEls7rTyfvffHbYdw2ahAQ==
X-Received: by 2002:a05:6a00:9289:b0:705:9992:d8ad with SMTP id d2e1a72fcca58-70629c6de86mr9102308b3a.19.1718937157754;
        Thu, 20 Jun 2024 19:32:37 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.32.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:32:37 -0700 (PDT)
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
	Yafang Shao <laoar.shao@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v3 10/11] net: Replace strcpy() with __get_task_comm()
Date: Fri, 21 Jun 2024 10:29:58 +0800
Message-Id: <20240621022959.9124-11-laoar.shao@gmail.com>
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

To prevent errors from occurring when the src string is longer than the dst
string in strcpy(), we should use __get_task_comm() instead. This approach
also facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv6/ndisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 254b192c5705..10d8e8c6ca02 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1942,7 +1942,7 @@ static void ndisc_warn_deprecated_sysctl(const struct ctl_table *ctl,
 	static char warncomm[TASK_COMM_LEN];
 	static int warned;
 	if (strcmp(warncomm, current->comm) && warned < 5) {
-		strcpy(warncomm, current->comm);
+		__get_task_comm(warncomm, TASK_COMM_LEN, current);
 		pr_warn("process `%s' is using deprecated sysctl (%s) net.ipv6.neigh.%s.%s - use net.ipv6.neigh.%s.%s_ms instead\n",
 			warncomm, func,
 			dev_name, ctl->procname,
-- 
2.39.1


