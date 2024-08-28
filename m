Return-Path: <linux-fsdevel+bounces-27499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88221961CA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B288B211C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A04F14A604;
	Wed, 28 Aug 2024 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW23865s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B23AC2B;
	Wed, 28 Aug 2024 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814274; cv=none; b=V9twv6n9sy8lRh/0988qSnCEQTuoT7SJzS04F6ibAR+0IKB202Bv95ocRvQ26nP8ybOTGIrXwMyrlKIRhPGORJrOx+iR3pQfbSU0DnuFoJIa7V096ByXYfS7aJZNvx1jEDmstiKdSiExsKz0YPrg09MEAMdOP4YB3ZsA7dloUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814274; c=relaxed/simple;
	bh=Q/ccAtoYqO3u8X9Ue4dTvCxK0m9BnFNMdv5kHBNaFRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MXckLI0Qo8PrkOulT7oju8M40JPs6X8EV0azlYeSmTVHB5KoL48Fx77ogsgirrkLUB/HTa2m9rb2TuMkzxPyhwBHVmV/EqswzTTjZriZzMMmjbhRZprto5+Mzw7D5mholegDeZoc2bQKOgptlwBjQHg6/CceCU3GiiPP2mpGHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW23865s; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso4809878a91.2;
        Tue, 27 Aug 2024 20:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724814272; x=1725419072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVdwfZoyZWde9aSN6zhMbNNaJxIyi5X3Dr8kaez296Q=;
        b=nW23865sF0/mBeLQHD04jNVipIxIWlvO5TODsVQNNTPgUnsVDsHUZaQylUA11cUGSF
         LoAKb3GBjtTFzje86c1TWIqTVJBO8XOiCk0LO9GRqYGGFLret7XLss6cIgG9OTRsU1pE
         diMWZa8GDvQsP7kwXhO78crl9pKtR5cUsFl6N4pjbV9lghJTU+oPnshrH995Tcc4CwsK
         Lf/3LO+i0aSYLrZlonlnJdiQUaBK1mhbaiPjIvvDFHQgh/ONnjEzrZ6urDHu7bLrBupI
         LgKfAC/KwR0VKexV4E4vkwju8JMrfTWIHPepB9T1bWnn39caeSlnsRogB3pxvzmh7gc3
         kweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724814272; x=1725419072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVdwfZoyZWde9aSN6zhMbNNaJxIyi5X3Dr8kaez296Q=;
        b=NAXiVyeiRB5PftoduwVYDWkoEPgrUv3sayifAa8sJiC/7iQnJxnAxFxmZNi7MRm8Ho
         mWeZGG9sd7UEY72tUZ4wFXKImQOITQCajWWXLIU5bycYWBqrix3K8sxIPoZ9Sq/GsnRd
         LMj+obacFrwPcFTAjabyHE1tQzBXsYIkms8pxcSmFO1lhqrYXN3vYi1mhB/rLjELl9yr
         53/3twk3BiAd5VdAkLLRWA0BjFiKS72rXbGAjyKDkZ+hwhpM9c4av2A6LjVc2pf3R1PF
         XPNTmSjK7+wc9cqzv/4m3NoVcjRESMsoQv6pJv2z4OWbbzLFrcs/pmXmChwLyPslL6eX
         w5lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn8ZvsRLsYXcU7VACNNFdq1rEA5CLZRaZ2AACLkm9e0T40WnoQ8HTnzqz63J4eopMBS00g/XQMqw==@vger.kernel.org, AJvYcCV1hX5U9OK+XcxWXrSQTOWl6Lwdo+2EFn+dIY+sPvit1YZIzTbtd9mQdi9ZMoKuSo+9VQ/L3LtEkPDJ2y7kurifYNxW@vger.kernel.org, AJvYcCV972f1v5rYqE6xpwL42EXDoOmXIisEwDE1ufR1npdp8U67mvCf+j8NQHJv4FNz58Zi5YwvTbEx@vger.kernel.org, AJvYcCVa7MYA+fMEZ8A3x/RNAw0+fu2Oc1SS/cll50pMucqzOQBH2UD23DSqwoK41eVNksSOizqPLdswryZomfeyQg==@vger.kernel.org, AJvYcCXIzGD2abXQIW5PiiesqQ6u/u93npEwlgwXJc//YnQpVQ6zFJQQArWgUJUM+Jd9wHhOgYz1Vw==@vger.kernel.org, AJvYcCXboPl0wP1CxULId4IfzvLJ+OS4LFGv5yeapCzFpoJBuI8I65FdSSEcUbO7b/4hBvd2mLtD@vger.kernel.org, AJvYcCXhmJizTNzz2lsDqkBjGtf1vVZOf1tL4Zf0j+8S+B0fnbWuZP1JF1dYKYtHCzeoOAeIDzshizMHHKEjfF2G8gPB4QA9vYPl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Zwfm2tMdcwzWtt8UaVNB+Mc6n0M+Uvkw3nBm1IAePSLl2T6r
	eP405Haqb/Uje8tZRa3KzJJWZE5BfFNxxoC6QzpYfXnAuzXMLwiZ
X-Google-Smtp-Source: AGHT+IFb9q9yq9VVSwLC6AkI1/p1bhkyyRxy6O/7jYlaHznbpdfEJAgSG3Tzmhmlf5xXUEBbcGAPmA==
X-Received: by 2002:a17:90b:356:b0:2c9:61f9:a141 with SMTP id 98e67ed59e1d1-2d646bf605amr17374556a91.16.1724814272564;
        Tue, 27 Aug 2024 20:04:32 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445db8f6sm317977a91.1.2024.08.27.20.04.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:04:32 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	alx@kernel.org,
	justinstitt@google.com,
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
Subject: [PATCH v8 7/8] net: Replace strcpy() with strscpy()
Date: Wed, 28 Aug 2024 11:03:20 +0800
Message-Id: <20240828030321.20688-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240828030321.20688-1-laoar.shao@gmail.com>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent errors from occurring when the src string is longer than the dst
string in strcpy(), we should use strscpy() instead. This approach
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
index b8eec1b6cc2c..cf7c36463b33 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1944,7 +1944,7 @@ static void ndisc_warn_deprecated_sysctl(const struct ctl_table *ctl,
 	static char warncomm[TASK_COMM_LEN];
 	static int warned;
 	if (strcmp(warncomm, current->comm) && warned < 5) {
-		strcpy(warncomm, current->comm);
+		strscpy(warncomm, current->comm);
 		pr_warn("process `%s' is using deprecated sysctl (%s) net.ipv6.neigh.%s.%s - use net.ipv6.neigh.%s.%s_ms instead\n",
 			warncomm, func,
 			dev_name, ctl->procname,
-- 
2.43.5


