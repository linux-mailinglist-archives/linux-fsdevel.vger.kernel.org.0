Return-Path: <linux-fsdevel+bounces-26167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 356B3955524
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C813DB22FA5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 02:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1913A416;
	Sat, 17 Aug 2024 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKjYZMzD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482C138E;
	Sat, 17 Aug 2024 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723863473; cv=none; b=kFUBLCgplyaYIfcjVuRzc9xVo3ijXkf80y+mnMBMJ/Ir9SJY4hUu3Kq4i/AeAgTopdrrpB6wfZVqSk0GWjfh++IjkaSUKFCoeSfAwwTaE0xNVJhw0tN/CDvRGBKwy+nifVJjOY1bd9c/kizJxhcbiqs9rVDsyE8D9oKkIT99Tek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723863473; c=relaxed/simple;
	bh=FtBaKx9PDORn4iYpuWT19RXQJ9QLrEKduWU7EA87sCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHVapK3hk3v8LJW83YYcJo6bJ6vjgqvPH6wpLsBp1hQiUZkCs+ni5OoOL4+O/rMBaShgzGs91/g0Dwwz33UvfEVxI4HPTe9ZyVA8wq6WIUtfvmGB0ak6rrEYgsV1GenBlISrw9hlbAgqELpb+F302NI069zHWmMYASEeWCbxLZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKjYZMzD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20208830de8so10214705ad.1;
        Fri, 16 Aug 2024 19:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723863471; x=1724468271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by1YCv/9fNhFKuS7v7AkJGwNY9Y/YBFp3hXhZ5CbnE4=;
        b=hKjYZMzDDf8shog0E8jdPAXpQkg6xXvZA9j5kIjJkTigAaPk4y0B03a1+Iovo1paJn
         XyBOQJkBlRHPAKkSCTZ/SoIpdBM2Jl1kIUUc+i1DwLsUOS0II0S59IL14Oc9HelcbFHq
         N7NSEOHZTUvlMTbHRrtmNt9jUfWiqJ5sPM/bJBw3+PwpU5mKrghcrYKobEx03E8g0odV
         G4ZCBZgE7qgwEeX6yL7DTJj5N7F9LrIdtkaP6bx0rJ8GFNRCW7p+zrDeEtE1rkiHCFCM
         2ph7aTAr3h/7fPW0QP0yJ5wlsaTe66F5uHEk8z7JPaZdPJy5XcW4aOTauGIkin7dwqFk
         bh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723863471; x=1724468271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=by1YCv/9fNhFKuS7v7AkJGwNY9Y/YBFp3hXhZ5CbnE4=;
        b=X5pTpUk9RhcxJWzZ+lHvMKnTW4M2HoZes/8x0fp3gNs9iflTDeUtBcZdpXE86lIIlc
         HonZAsgj9dO1JZfOWoCRwyRuUNj1EIRzA7p9uKVT47lVFhv/mYXN65i4tybjmyYd4lGh
         MtmdLphggY2BFVz86McMUSaBgPE7nJHCFeCsY30mnhKiWm8TdPE8bAA5objQ3dkZkovs
         c+JNkVQKMs9zu5khwlXAN5m54c5OURpHy/uig6iJl4hUKIe1iGGH3EHilbHtbRn8mQ8N
         zHgBGkN8TOXpje5k70+6ctPlkfYHFwYv3V6IoPMEPHMLMkfzL7of3LByc/ugnnLCFNgi
         VFaA==
X-Forwarded-Encrypted: i=1; AJvYcCWp70noyavLqt+it11Fpg/1TL6RpicBmbf4q4jmSSVgGrJJZ25F0Nqdh8U9VBBL5VIUdJdtrAEB2UAn2cgADyndk4Fs23y7L/q+zhlJfvLz3yp+N//QpUammdkBaHTDW5Q2C9A5ani+nkTasDdXHPuznLh/+NONF3vQFGsNutikymwyFEME390KebcS6xXfVfZt+d99etw20qBb3ifkrqAapuMRXYtvygXDwPv1e6nwboAwv9xOqu79xr2aUYU8AYYDawN45Onx6DEbFmFRTSiJjIv3ttAMWIboWfv5s5OEJqkkdNbLo5Ijed8YD5ukKOart8muLA==
X-Gm-Message-State: AOJu0YxjJT1u327vRmjM3AkiHC0nqdX9DsphPE+C0l+h7U2SDIqOS398
	h+pInwWXsvg3fYLbCagzfw1IWkdw3Gxt7tq6qeZTUAvsvfgLVnGR
X-Google-Smtp-Source: AGHT+IGmy8Jt8i1r5v72uMgbTh9QfFBoOAd1ReOek6MsKKuMaUCDeTlIuXQ+GXacq0NZtUUeDKoREg==
X-Received: by 2002:a17:902:e542:b0:202:162c:1f36 with SMTP id d9443c01a7336-202195ff1e3mr12511865ad.36.1723863471180;
        Fri, 16 Aug 2024 19:57:51 -0700 (PDT)
Received: from localhost.localdomain ([183.193.177.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm31801785ad.94.2024.08.16.19.57.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 19:57:50 -0700 (PDT)
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
Subject: [PATCH v7 7/8] net: Replace strcpy() with strscpy()
Date: Sat, 17 Aug 2024 10:56:23 +0800
Message-Id: <20240817025624.13157-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240817025624.13157-1-laoar.shao@gmail.com>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
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
index 254b192c5705..17f2e787e6f8 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1942,7 +1942,7 @@ static void ndisc_warn_deprecated_sysctl(const struct ctl_table *ctl,
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


