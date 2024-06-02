Return-Path: <linux-fsdevel+bounces-20723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D398D7327
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 04:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C8D1F215E9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 02:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0680A94C;
	Sun,  2 Jun 2024 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF/vtP6r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A04C8D;
	Sun,  2 Jun 2024 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717295937; cv=none; b=smm7081fZM92+0f7C11oOtHAQFw/aNmOfgNgLWqu33jrGgOdEmPfWnuBKlTBj3f/c/0LqsvhcQRh6K/nUgm3rkuHAlZKKmFHV6k8Y5toxLJxh++YHuI/28D1S7yWITdnZLCHadYBUhK03y9/HTFeogG+iKPt83MqmUBFm5koG8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717295937; c=relaxed/simple;
	bh=o8548Y6NN5BDp3sW7tIbS607pyx6X2zs9ez6UFvk858=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uD0U5bLZs5IYC0tEuzeVTdocN10WDZ/ejfYrzIjlil6uLjursrczWD5XrnDG67AwpCEgQQYXPxmCGFKYDa6sQIXAgf/DdH0K7TUOyJDQo0NVhgBoWw+Abz8bGFf8ipybQ2h1sn9ogkQqHeQbOQLSPHPtKgNI4bL1GjFjfcV/xZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iF/vtP6r; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b5b9de6so17110685ad.3;
        Sat, 01 Jun 2024 19:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717295935; x=1717900735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TpGu6Oq1vjxccb8W6xWjhiTwznYEKWGAfAIwahkDiA=;
        b=iF/vtP6rB/nmhygQq4v+17TtLCFCWv14a0SYMLL6wwTQpZ6RUwIRD2I6Sa1igFO2T1
         2wH//UvOR9LCyU5VJ8zgCCgEATK/awDC9ZXYqCOpb+Rg56st6YeoOFl3xYEi5+xh5Pbv
         UubxbhAH7xziATz+QihQLUBeoVhUNvbM6MW1Sziop0zHNe1SaSPTIqjlmRa+JepgQSXR
         xJVZDuwBOV/vRS+DPAmBIQeInk1XemuXcp3DKyb+f2CnosNHxwNg+EZ3Gw72Oro3WVmi
         Ui5rmy1TL7KNMkBuhoDnNDOKUrMsS0T2M2fSEyqim9hlrfTIJtM20Ci6u4DuejCTPFTA
         7nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717295935; x=1717900735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TpGu6Oq1vjxccb8W6xWjhiTwznYEKWGAfAIwahkDiA=;
        b=for2osDtBDbIBgsh5m6szJ2oqWO1wnJ2isGmiTr8gaPMGOUs67Q6GEn3WuuxT4C6ym
         ypvMZ3qjnSY7paIeiV0uVQZOV5aDuwjdFeZXjKB0aRhU5JQfebMQBVrbn38mHbFlp47N
         iEEaKGJgWxd9/2nWiRa6tdKEKvPFl3MGlKEE7L/9+RopgMekZZHmYWpe9vArk3cpLz5H
         xMaYJTpNPpdFLkYWYLpcuImFziCgR1hpOOeK+H8D+bXei0dbpjEaL0vxrgIYnxI9izg0
         wslV1EfcSuhBKOucSkB39PM3Oy6ho8tFStLZgnis93ufUdywPrHXAEbvJUqjf8Y2zdlA
         VESg==
X-Forwarded-Encrypted: i=1; AJvYcCUy1I5QGcYisMl0eB747E6m10fKPpXE77xNmPjwEBy1U8HYNrR6GGwqD/E1h0s0oyXcdw88BecbbI40HF5XXcxtZWGuZ26EJgP/WcivL8WwVNuTq0jGgO7GUWmOez3Qs34U7E/a47rpOBPnMp93A/HdNTvSkD2D1DFJGIiHxpNxDGt96R2xARX3SiYqEm1DWxaxRV2lnvw0ed0o52zdn6g+HAdINMpLcWXZFaoinf5ZCQMVVW9xUY55PIXGHGbuFhAHLFwDoVeLHZ3QlkI7j/j6v1l1UHInqh1W1TQvCA==
X-Gm-Message-State: AOJu0YxwtZbbueYFwIvpzY7/KDpkATEMrGPV6jJ7ynjjkyOuyNpfcAyV
	BGZeHN/FeA3E+1n914JaOiyrOKhvQmUxbdNEBQNP0ywCeMhwNAO1
X-Google-Smtp-Source: AGHT+IGxvOn5+cLL6IQR7JJZSFxqN/pAIswbvkNRxUdWw/EDTeYezEeBw1uxYC432gXEUnzhdS2+uQ==
X-Received: by 2002:a17:902:a38d:b0:1f3:903:5c9a with SMTP id d9443c01a7336-1f6370aa056mr64384745ad.58.1717295934923;
        Sat, 01 Jun 2024 19:38:54 -0700 (PDT)
Received: from localhost.localdomain ([39.144.45.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ea21csm39379575ad.202.2024.06.01.19.38.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2024 19:38:54 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH 5/6] bpftool: Make task comm always be NUL-terminated
Date: Sun,  2 Jun 2024 10:37:53 +0800
Message-Id: <20240602023754.25443-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240602023754.25443-1-laoar.shao@gmail.com>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's explicitly ensure the destination string is NUL-terminated. This way,
it won't be affected by changes to the source string.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/pids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 9b898571b49e..23f488cf1740 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -54,6 +54,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 		ref = &refs->refs[refs->ref_cnt];
 		ref->pid = e->pid;
 		memcpy(ref->comm, e->comm, sizeof(ref->comm));
+		ref->comm[sizeof(ref->comm) - 1] = '\0';
 		refs->ref_cnt++;
 
 		return;
@@ -77,6 +78,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	ref = &refs->refs[0];
 	ref->pid = e->pid;
 	memcpy(ref->comm, e->comm, sizeof(ref->comm));
+	ref->comm[sizeof(ref->comm) - 1] = '\0';
 	refs->ref_cnt = 1;
 	refs->has_bpf_cookie = e->has_bpf_cookie;
 	refs->bpf_cookie = e->bpf_cookie;
-- 
2.39.1


