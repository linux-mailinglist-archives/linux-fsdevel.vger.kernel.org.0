Return-Path: <linux-fsdevel+bounces-24946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249B8946D55
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 09:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55842818AE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774D62033A;
	Sun,  4 Aug 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI26+rA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD471BC39;
	Sun,  4 Aug 2024 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758334; cv=none; b=e4rMTxYfG6AWJOFQiUGL6rbBfSnHZfh4WhqXaIVeUTN4Rx1QOaob6dWcRlKV4oIvuv/r0syn6OS1noqQNAxKKfvlEit4VBmP40gnkEh+PsYSRfQBXBcqXKnnNpkZg2BdF1faKQKmQzMuL76O2yWk5fuWkNy3vI8Uq9KTw+SuFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758334; c=relaxed/simple;
	bh=36noEVLUmWO8B4cta+fdWNDgAFM5Qm1APLVzyVo0yvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P9tBYPGe3x+lDhuOvMd70dn4ZLN+W6NufBswBJ+muULrLlenLKfhOs6ElC3v0ijFG9HOWBQLLrW8TbwS9aapHFpoqqhQVYoCPyphq13w9mwS8Jfv2z8Ewqp6AFaYH+GfWd7WJ10TCyGi32adqtFUXzXsU/Jo7coVUDmook6ddyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI26+rA0; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db16a98d16so6095967b6e.0;
        Sun, 04 Aug 2024 00:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722758332; x=1723363132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy8s8HUuCpYYzqYVYDLibKnXKIG+UtFNyRBbbBdMpkI=;
        b=iI26+rA0qydphvU0P9ejVFsR5kMhFcI3uOZOZvkFR4q+JJ4sPswTpclVcozMUyjX/i
         uD86nydoKaHZ7QR8mMlG+avhItXhV4Wg4Kqo0I3KVXU7uTCaPj9Tndj6l7SCBHoPBHe0
         pU3pYO/Qmp3nV150sdQxZDLQJ5rhTCFoz5jMGy8LTM0w2wIKxjFkhZupGOj7QH03hurd
         h0Hp6+tMPciIGT6OtvstcVebooKkKqgCwePS1P7B0WxwwT6hGDQapKqld8bENuMzZApk
         HJH4e5lyLvys9E2DC/N7ufGT53MDu4ryQNHQ/0/cMQtXcNOm21nMY/qFsm0kFxX2Lk/u
         kIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758332; x=1723363132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iy8s8HUuCpYYzqYVYDLibKnXKIG+UtFNyRBbbBdMpkI=;
        b=UHwsmZLiOmXdVgx0+K8m8PFfrdfQ9Hb8I4NHMi/MzDaKuJisO2w+z79CoWdtEamZl8
         NNpQg4o7z9f1d5lZOZn6Gio9BlWKgcXNhX0ubdty/HvGJ4GMjRzfSFG9IKYwlWQrAqv8
         az+BEA+1UHANYbVny6Rk/f4hSVl8cgguNmZ0jl+VFnWbLWKuH4gjp9Wieem958UZl2wI
         IB0Qo0HRkSIlr6Mn/LJz+GlBHmFo6WnmldZVsOkp6GxF5b6VTwp5c9X1ltnwJkL8AdJQ
         DeYGh/1jCvoA6BXmxXF+9U1BHyebPhbNgyLQ5X4llDLHOe1AVYYGyUbOseevFqz8yQFc
         oEJg==
X-Forwarded-Encrypted: i=1; AJvYcCXi5idbceo2lWj/Q64keBSV8nqsY7y/HFmpkY5Wie1suXqSSUpITjfFn5xN4NRwK/3OiMvkBJ78EDdMZTYGdtJHL2Gnz/C4oCI3ECNM7ehii9/RzZMGnofxjvygERFWFZGachu2RtFIFPKTF1zz3D4EHTLzTb83CsdZoDgEWQ7IoJM8+r96WEIv2O5FcOeTTl0RVJFpRG48rsS50kDJeRn7m4fzQW9LsQp1XrHntRcnbaSgz0ZlcRqxF9fDwcQtEX2p8g8gqVT8dtYcqaIvBLgPE5/QCjcNtdTHVGSYB32ANP0PehQouDBgxBVi/7dy1YRT9MUvSA==
X-Gm-Message-State: AOJu0YwHxWbxQKdFpQY8hxFZkwDQ5uTUzsGsBV6nHZ17rZRqmgysEskg
	aVwYjzEEf5wuT/NNmECN7MLn+Ms7yTdtX5JFLPKYXl5U+V5OYTaP
X-Google-Smtp-Source: AGHT+IEAdxuBVNyLOuAyS4g3ON7ORD29wxk4r6CpWYYml3q2XeTU12w4OJdy/NnFgIlYXJGGtsOOlw==
X-Received: by 2002:a05:6808:1984:b0:3d9:9e78:420c with SMTP id 5614622812f47-3db5583270amr9335216b6e.38.1722758332352;
        Sun, 04 Aug 2024 00:58:52 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178248sm46387605ad.202.2024.08.04.00.58.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 00:58:51 -0700 (PDT)
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
Subject: [PATCH v5 8/9] net: Replace strcpy() with __get_task_comm()
Date: Sun,  4 Aug 2024 15:56:18 +0800
Message-Id: <20240804075619.20804-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240804075619.20804-1-laoar.shao@gmail.com>
References: <20240804075619.20804-1-laoar.shao@gmail.com>
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
index 70a0b2ad6bd7..fa3a91e36ba0 100644
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
2.34.1


