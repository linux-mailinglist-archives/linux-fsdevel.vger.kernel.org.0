Return-Path: <linux-fsdevel+bounces-22053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A699118B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C171F22A11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC912F37F;
	Fri, 21 Jun 2024 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMEQqzI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ECA12C489;
	Fri, 21 Jun 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937123; cv=none; b=aE01EBViQM8nI4MWzZO+13le9eNlvmAUkWbiJo3xJmWnNA+xuc4sFzO+N67RuPKT27UhrXuMtIwEdqnjEL7x5QPJZqC1FVeAGNEzulHClmMCoTg08G5tw1w6k49Fz0C7YIB6r+Kou4eYFcPqwj/GcnBT53Ng9JTXFyG2uBGxE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937123; c=relaxed/simple;
	bh=xJqJZWbEhk8Nib3lnX/uTBcWIy8/xwBU6awufruH+d0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vv4ruh0wHH7enF7uJOIOTlSkgaQB5vkOvHfbnRpTflZg0shxHUmLGXIxnb2CMoo+agt2WrDWOKLkdMsqaD89EfhvVS/uAYx1Geh8E2TkInT1QuchB84fjcBIRn/aMqJJK71xYGEtsKfi3xOEZ49+McVWd+ra//PaFf2MEdLQDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMEQqzI8; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d21c4eec2dso741769b6e.1;
        Thu, 20 Jun 2024 19:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937121; x=1719541921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqSWr/pfZwtTIRxMBQN6sYuDk2R2VvioPDgEPjsCPow=;
        b=IMEQqzI80+hsHAllY+c9YAXVitoMwSkV139Jswy2vVlO769OjdC/MITLAF4C+qs8q4
         uE9IUNxMCjv2bE4PxytiDJ/5mg+WXo/08Y2IGxhOIs5dwxZHfiLQdNRrtrhqN8aSrUcZ
         +V5aD1t4bPF8cD61lUTy4ke/7KoDzrSY6OT+5Gq7MVzFGtfsPKUwnwhv1xQQqx+UKCSK
         U7TJeERRMV2HnHSyDCPj29ChLb2LAhWFhfxH9XO4qsMC+BQ+iiGkknt5cC4zrg3krsyz
         MuLtJrBurNJos2RtdCQHfz9ba1t4n7wmDwqzT5nBS5EenxJ9XPIHotEhNgqYamlZGQwM
         b7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937121; x=1719541921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqSWr/pfZwtTIRxMBQN6sYuDk2R2VvioPDgEPjsCPow=;
        b=Mc0/aHhx2FKxxfZvOe0tm2Sj9e9kYULGLaFk0kjFJrghVdxN2eJEq0BtZbZ2gWWOxP
         2/DIZ6EEGZfqVbozRDXgJdB9MYwtu8MyIpgJJTXEUh9kVm+o1qcgT8qowsAs61p1BXW4
         WaDIhFl9QmrQiGdXFqrsENz/fDkHM70zv8ntmvhofJAemu/SFahZArPclpoKluFNxmyd
         hLohmpzEXqX86Sm0ADDsMtZ8FuV25bhhGn3STxQ/rJqGVVI9A784hTy6vEU7KhtUDP0L
         xXDoZDT7pFXh8FLst/DkNsFsTxz6yuMIw7XyUfljIH9M9yxEVEzJjkcwZN+7U4wpt6jW
         F0/g==
X-Forwarded-Encrypted: i=1; AJvYcCVbnFPCj+p+xXZ6m/azxpwRVREeNsEZ3eqAxIeSoHf8vVyT2d+BkeyZZ5/8t6oudi/PhLDaYOZdIv71KV2vAZ3DjOyzWCMJxxaBTXSR3lBvRUO3HudjnPjAqRg1M6TYCM9kxYmS85F4BjliVFxhLM1oLJ+FgowujWppac04NaMkhbpyX0cJuI4OzAVZmjtNLW4DPiqrsFdhJcseNL16zLb9Pl8PIYfkR71P2weG/l7D/GLT8O3/Z7k00tU+2v8ZSG+rOAheR6g+IjFvTBGaTHr2MxD94RuY/4wPEca8NaqVl/8OqpaFMXS7gTqBMeRnMoPYJ6k5qw==
X-Gm-Message-State: AOJu0Yy8L+4d+l6Y5eHOW7VmC/Rrh275UE5m2M8QWE+6xnFWvt+4Wmnk
	HX1QpgieJHZfIfgOXyn56EjwFuvR2/73MRgXnOsgh5fcUbOVVHs8
X-Google-Smtp-Source: AGHT+IEDLpdYIw99Uz7LWzb9Zy/b+1+lbeIcbqra7aNgXOpLlSyDlDvG9wKvxKsFRnB2arbPqu9IVw==
X-Received: by 2002:a05:6808:130b:b0:3d2:4a08:2cc8 with SMTP id 5614622812f47-3d51b9b4558mr8069073b6e.23.1718937121450;
        Thu, 20 Jun 2024 19:32:01 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.31.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:32:00 -0700 (PDT)
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 08/11] tsacct: Replace strncpy() with __get_task_comm()
Date: Fri, 21 Jun 2024 10:29:56 +0800
Message-Id: <20240621022959.9124-9-laoar.shao@gmail.com>
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

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/tsacct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 4252f0645b9e..6b094d5d9135 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -76,7 +76,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	stats->ac_minflt = tsk->min_flt;
 	stats->ac_majflt = tsk->maj_flt;
 
-	strncpy(stats->ac_comm, tsk->comm, sizeof(stats->ac_comm));
+	__get_task_comm(stats->ac_comm, sizeof(stats->ac_comm), tsk);
 }
 
 
-- 
2.39.1


