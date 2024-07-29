Return-Path: <linux-fsdevel+bounces-24399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DBD93EBA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3465B20EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5776E8060A;
	Mon, 29 Jul 2024 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ7YE85K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C19C78C83;
	Mon, 29 Jul 2024 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221276; cv=none; b=H9B+TFmq0mGl6L0DEEnLar69qh3bKgCqiNd4FaZIyZXwDpgdgxk1FBKvGP2dKVLMuPaG5TIgWMM+q9mLOXVH37kzitPHRzrWznBMXxlzcOE4Sq1zfuiASexEB5RUTiHRE2HR3c3zhz+hhQoyAMVdr+FPrlxGDVvNTGKUQPQRFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221276; c=relaxed/simple;
	bh=wcSkD7vIjfQlJo/ird14KPUKFpdk4Q6HJbv4EbwFBc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EbNtBNOdhWOl4QgWFo7UiHiIKrA364Wz91abg1+LdZbFanGVzas7D1LGD42LHYnKNTuCgBGOYkZJ5E4A/RNOcTH257zjVTb8uqmAja2/zm/vOhVnk3KpwBUY70FFXOLDybaZxsCSgo0e+0d+3xRFQb2kBH+MeSDvjYKBirwxoJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ7YE85K; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7aa7703cf08so2048307a12.2;
        Sun, 28 Jul 2024 19:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722221275; x=1722826075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS5JkKLpH7rBBlezu3RsuBopuhXkHEJwrCmaySM0BwQ=;
        b=IJ7YE85K7ldec4vIjDqt67I2IJry7BrRpdi3g7OB4CTkq77VxGZJzl73+ma1D75XoC
         rwU4d1f6apJbFzc1CwWqHtkOOm3TNB0JYKY59P6KFwsrhO9ZBORRYmdmWaplfm4YlFEG
         TVH6+gosJIvhEI1PMMhwjDBHsi5m7bL1sInVzjAM05Aw3HqcO2pYmm8OtmOkctCmKDo7
         vUvjpgVl7vMDQsqiM7PMb7RQz8BDk4Y7oemlF8Xs0XPZzyyOXfXvvxNU7i2G21hhqeSB
         druu0hR4OSmwZ4+eYLxTPCoV1yrxPJXoYZN9U1I+s8A1QNrlJFgOB0+bn4gsPjT6QUFE
         TSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722221275; x=1722826075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS5JkKLpH7rBBlezu3RsuBopuhXkHEJwrCmaySM0BwQ=;
        b=jrjRGdWraAyNLpIRHM+KRWJDt0eoxoq2mmq0j07ozzGUd+s6kH1IxS/UhJ6j1LOLlI
         D1SgLXCo+9Em2omrj8iXw8+iNYozrCA7ZPbYlFSXG0FB8nv5JTLvZ3PEZzGpY/XLpLEm
         ASDxUUBunUuxn2lZQueNYCNtYt3Jax3GbjVJ4kSmA15e5NngMs8NSPGjF5c+QXGA7Iuv
         5BLnV2ZxNlVOgOIHyYLvk16vIiFT7NLjC+hGQvm+ALNjhysFCZcQvKnT/0kisLukG3x8
         GbNVvtHO7fBqHCsLMna2aDeeWgotqdzE92EPv40X7n35LrOZcZLucnbQz//yv1BoIsid
         qD3A==
X-Forwarded-Encrypted: i=1; AJvYcCVvsO17+tK6yBr3S7tkcpMFvTaOQB4dK8oq8h8cyKctgzB5PJKEQi/wQOXX7TbMoRCQhMNSfjDhBnotFL2/KkbKDtRBDxoT/xXrzQvpC0EiNVvNdvawJO83vKJCv0wL6dz5GImy1piGPrg3T9WUl1jgKHOIdh0IznmM9tJd5d+Rq2kLhakGCFApo9DBxn4RWSeBbnbdhbZgEU2ePl6tBLuh720YVzl10c2vXC0fBKY/53nDr07F4REcs2H2xuT0TSH0mtvFWNTa2G//B+pBCreEE54RbkldjNDQXjuaTvIb1XniyTzoLwbsLigXN9GSaY3A7TTpAQ==
X-Gm-Message-State: AOJu0YwdwES9oZ+NyQifquIOjpCFuNfCsrkPuzUBXzJNuCht+shnq6I+
	08k5JLNfS3KwynpVbZ0afeaATl4h/2K9d/F70mnOapNf9SPhAULF
X-Google-Smtp-Source: AGHT+IGXxWNnJLIJ5uPecbp6KsT2OOK8/ZuVg1FUEXn71WfglTXG9UPP1KLmHGuFVJ6pD1f6J8wciA==
X-Received: by 2002:a17:90a:e00f:b0:2c9:7aa6:e15d with SMTP id 98e67ed59e1d1-2cf7e1fac4fmr7206984a91.20.1722221274655;
        Sun, 28 Jul 2024 19:47:54 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.47.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:47:54 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
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
Subject: [PATCH v4 10/11] net: Replace strcpy() with __get_task_comm()
Date: Mon, 29 Jul 2024 10:37:18 +0800
Message-Id: <20240729023719.1933-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240729023719.1933-1-laoar.shao@gmail.com>
References: <20240729023719.1933-1-laoar.shao@gmail.com>
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
2.43.5


