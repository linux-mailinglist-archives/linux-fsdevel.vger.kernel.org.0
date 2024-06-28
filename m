Return-Path: <linux-fsdevel+bounces-22755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4293F91BB0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40C2B209BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462E156972;
	Fri, 28 Jun 2024 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie4YukQd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828D14E2F9;
	Fri, 28 Jun 2024 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565591; cv=none; b=WUdV3MzE3BmFP493N9LwWuPkbv55I96g3PUdoQ+/v2r7X2TFkppPckk32x+x5qEEElLo5XJdBuu9fg2BMnNnMM96Nc8x2k+fXgKxaWN/eP36rtmqP653g8we58tza8StrI2QEkAfDrNpLThNx9w81xgCZOwqTBsqbQ5mK19YXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565591; c=relaxed/simple;
	bh=wcSkD7vIjfQlJo/ird14KPUKFpdk4Q6HJbv4EbwFBc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjFApsmyE5uqaNae9m5xFIHXFfpQMsT8a5PIuIZHwboVRICkTwSSUuQcvAWZjNp1AdIMzoAugpZCGQwFWQN4eH8fv9VeHbqccbIt8d7KXAlrighQm93ftcRcuaFXKQcANjsDBDeqZ2/isQtFMkvCzpZHVb8Ei4qk3qFcKe5lSt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie4YukQd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-718b714d362so230193a12.0;
        Fri, 28 Jun 2024 02:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565589; x=1720170389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS5JkKLpH7rBBlezu3RsuBopuhXkHEJwrCmaySM0BwQ=;
        b=Ie4YukQdo5yG0/exL8gnrHKq13FLKvw6mFz70plGXXVsRZJkOzxoCPh+WYcIMB8U24
         Eta5ts/AoyEKaNjmH1f4tj0zwBnGn8WqLOf420W0zXg1x1lN7CZqGBqWVKeYF5XK15XD
         BkOE34jOs/0HUg3wZcMlEIyjuaZYrTxGAJQRxtiXH/oiVt62MO1rn6Swsia96ugi5rl3
         t3vdLvSAUyoiBCacM1a2Y743brwC5O5H1roJ/nAxrH6izwN8P4pZvREsVsFmtB4yhfvR
         pfFKoSXzkTo//KXZgBXvckVhpO9ysOp3KZib86nIAaCzseQ/knzfgMjclqBiMZfeD4Nu
         GkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565589; x=1720170389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS5JkKLpH7rBBlezu3RsuBopuhXkHEJwrCmaySM0BwQ=;
        b=SvHoA6G8S2FQPi2YQ9AzDRGKrF/Mxt0oLsoRpkCoaOx5cRS9It6kG82e5wtoni3lRu
         XKU5225J0xaH0CrJPiEI0zumtYq+UnsbCw3sMf+STTBrhpB6/eJQtjJJ7RWqIiQTf2Ee
         TNWO+t0PiwES1FpD4jV/W7L/j426U63BomyJVbbv0wR5uMlz34KrCNHSGkV3beFblml+
         d0n2ra67Wsjmnm0g2uGvaHQbcmLzV08uk0ioOr7hfuKELw427501pjVZWF6KtBl7QE7b
         N7K93JICvFHHfGOF2ctAytxhPDL+AYxNaQFq4BnNp5vsh4PrB7HIunXR3jgZmCCZhByu
         ALXw==
X-Forwarded-Encrypted: i=1; AJvYcCVm7pzmre3nkRjbyxTynSUj+Lmq5uR7XDtMOiC7ygdNiLC8+C9htgwjodVCYhAIwecFghZ5hGSxVsAUjSqGgKQ8SX9nztiiBabq85afj0pwr2XxCswhWkpFAtTopcB6oIRzfmGDaAOLO0Do7vqrJ2M0fGxDkaE774QUfjkw+UWEZqeFL/2KfeXhvmaxQxdqgb4yNkHnncnXbST5SCWVwcmjWi1AwrYV1pg/BxKPoMI96iFJ5bbGlG4Whq61N71/uh+VlashJrHiVeFeWiIE4bk42rptb4u3VaSeUhU//4L/JYUMX2vT+hwC/ktjg2kBUIbMt0N4Nw==
X-Gm-Message-State: AOJu0YyZdwhGMDk2mNk+z5q9C5/ueQMhy9MzqOn7suj7vdMMsfFLQTeX
	SVKJ30npeg0ekoEDtmlzW7Tq65UHt9+tKFr8kDNRbkM+CF2dkNzA
X-Google-Smtp-Source: AGHT+IGOKlpBVO+d+BglzrA1U38WRrINDjYkTk3SrZCioD4n2rLQ44T0idrxtclcQs0Zl0I35xoQFQ==
X-Received: by 2002:a05:6a20:b391:b0:1bd:2200:23f5 with SMTP id adf61e73a8af0-1bd2200244amr8943793637.39.1719565589157;
        Fri, 28 Jun 2024 02:06:29 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm10473085ad.68.2024.06.28.02.06.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:06:28 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	laoar.shao@gmail.com
Cc: akpm@linux-foundation.org,
	alexei.starovoitov@gmail.com,
	audit@vger.kernel.org,
	bpf@vger.kernel.org,
	catalin.marinas@arm.com,
	dri-devel@lists.freedesktop.org,
	ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	penguin-kernel@i-love.sakura.ne.jp,
	rostedt@goodmis.org,
	selinux@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v4 10/11] net: Replace strcpy() with __get_task_comm()
Date: Fri, 28 Jun 2024 17:05:16 +0800
Message-Id: <20240628090517.17994-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240628090517.17994-1-laoar.shao@gmail.com>
References: <20240628085750.17367-1-laoar.shao@gmail.com>
 <20240628090517.17994-1-laoar.shao@gmail.com>
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


