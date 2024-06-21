Return-Path: <linux-fsdevel+bounces-22049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D86891189A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E34B21FDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C684A27;
	Fri, 21 Jun 2024 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4fzS+ip"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728D84A5B;
	Fri, 21 Jun 2024 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937081; cv=none; b=T3of2x7ot+AwRzNhO1pD8yjYw6lgaPeQwlPQIJ562p5/KCoh+LLv6EUN1aQuSt9foZJ2pRmcFM/TqCIqOGeWI7NDu/rqqA2NDx/qJB6U99YWt6/I+IH0VP/dZW/ZqXx7Z7+hL9SXwOr0slxhQptSnwjiuNHhm1Yb/rC10bQQMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937081; c=relaxed/simple;
	bh=a+jRmBNObp02hqUJFQx9ZHvGN1Vdde7wossr4Oq8bKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCfmAe7Q1WhYZR3VWDZmvg+THc7zLFFgeMnXY3o5Fz9QSk1UBnAL9YPy0DGDxaSxxoxpJRdzez40ukCy/H/ho99cRvI8oYWT3l/CUwjkLSqkRFJdymMkX7Mk1gXvtHJw4cD4fvpCOZAm739HGnowtQLR0Mt70JLydWqk3eX4Fy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4fzS+ip; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d22378c59eso888231b6e.1;
        Thu, 20 Jun 2024 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937079; x=1719541879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7QH8g7nY2INvVrL4NU75ftNhN6FL7HL04IiCAjwJmE=;
        b=g4fzS+ip8eAN8OoA0sPVgfMtS7X5NeNZXUhNbWRvFHwhjkRKrexnp1qgMKHNtdsHbH
         NeirQBqwFa3exmtAvTiLoXAtrlohcFFXtXPqrVWXGQvv6IX0shoipdOzpYNh13EBaCez
         wUBlP7bSP4xSckBrgTSJLBB62/dVWYBjpRRpmR4urucFao9R3i5tWfPMB7+2mMBc8Ulc
         sTbO2jKNgcNlo/L3I9rh8LLZAQ9caSMi8GDDyTQu+lLrFQWpjlgG5d2+ODNzmRWuYroc
         ZJveNvIp2CPqNuTGD67Ofyhhfqs6ed7PV3SkeBxH9SV8ciCYmY7R91tjK85kDW/5G0Wt
         xNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937079; x=1719541879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7QH8g7nY2INvVrL4NU75ftNhN6FL7HL04IiCAjwJmE=;
        b=N96F1KLEnILGPQ5Ze3sGWuQLvbTrxnTivpYMiKeO0kfE0ki2UvvxiujAt7lzmXbmSD
         DVdYd+EivuLPtxSZWBRrsInXGxskQt0LsI9A/dguiWZtyCNbo5auEeJwfokytcyaMPim
         K1oV7nRPTjuEZPGLRs+bzEiQh+GGLW+Ba6qZpSDXmV1yMPEAT31oITDcWCeLuuOMMnF0
         Z0Svs5FhWje5JafPb2UOwQFGq6BbA7Vn2k8v+69NhQjsV++q6VvKfnW1x7XnnsqTm0+I
         IozcV1CoTETnfxj8ntsSg9Is8tbOfC4OMDqCAq+LBSoGBWaMMWjEjdkV52qwlhgC/cOb
         wDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBSfjLL70f/YsZ/Y/RS3VXiGjmlxMVWSCrRHSR3pfMy+5Ki+V5bKBbgucD+Vd0JgZjqBl7i8gP/8o+H8RezhpShlqzh8eMio4Kwrl2M7RoHWkKlsP8cWp+/1koYNCfm0GKnJ8yWe0f64ND2xK2mJ+FPPqqFbRZPvK43Iyt24YAFHs2NmYt9jZznpxVZg9j5bNlkqVAmk7BIiith+2ThHV1plVkehQUaZbIMn1kYYCKVvrhOj7Ez0rJOYkLhYxfeln3G8KVg7+Zdb/QAsi7i4EAOw94MeDytSFFMo591zcxAysZZrmsL4GjVR6c7JXrUSnfzGZXhg==
X-Gm-Message-State: AOJu0YyBQ2X/WfdqGuTbPXGDBDmIvMmGX1Zuj4e94Wq8Z44ohzzOEQhL
	SHgJ0jVsKIHV6L2Po/z74nvPH5WoxlLBg+tJe8l5Jv+Rv3jI4etw5an2Ka79
X-Google-Smtp-Source: AGHT+IED/biJ/4HZ3XKtIPvcAUdQBx9cm4PcU9a703LBYQtgmllriwsa8W5+N5BARKh/qYuDuJagiw==
X-Received: by 2002:a05:6808:f07:b0:3d2:21a7:8629 with SMTP id 5614622812f47-3d51bac4b56mr7794777b6e.41.1718937079354;
        Thu, 20 Jun 2024 19:31:19 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.31.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:31:18 -0700 (PDT)
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
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH v3 04/11] bpftool: Ensure task comm is always NUL-terminated
Date: Fri, 21 Jun 2024 10:29:52 +0800
Message-Id: <20240621022959.9124-5-laoar.shao@gmail.com>
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

Let's explicitly ensure the destination string is NUL-terminated. This way,
it won't be affected by changes to the source string.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
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


