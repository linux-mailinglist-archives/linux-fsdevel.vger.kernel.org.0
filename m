Return-Path: <linux-fsdevel+bounces-21590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA669061F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519831F217CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB67E12EBCC;
	Thu, 13 Jun 2024 02:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gcy2BYQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B62B664;
	Thu, 13 Jun 2024 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245920; cv=none; b=R3ZA6bNdE48ErC5hliZenH7FpAi+cXf0agqYakJDOLXDqq3fd4UO8DCYNwIM+IAqbLK9Is4aLbCSSERs27QpuCsMp9aaWNh6Lzc5wsokZi7/VSrc4zz7sCJty7QyTvF7Eo+cLMbp+3tVQnXLeZVjO/4rvdsJ7bFggoTg/czFOiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245920; c=relaxed/simple;
	bh=xJqJZWbEhk8Nib3lnX/uTBcWIy8/xwBU6awufruH+d0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rhzgCHewfrJBB+NHhu3/zaZusD6WHuZDTEXQ9yhXf1U0vYtdvGuoH1sJDVdIw+posP6jAQ+O19teruLv2jQ9HuD8igF7RvnAd1zoivfZKdDWQyVMSV7j9z5aTXKHs4xa2N3FoPtAFYULSSGU9JDpboH+AhsmyCSv4s1mBCpN09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gcy2BYQy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f8507aac31so3954225ad.3;
        Wed, 12 Jun 2024 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245918; x=1718850718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqSWr/pfZwtTIRxMBQN6sYuDk2R2VvioPDgEPjsCPow=;
        b=Gcy2BYQyOsefyUte/EUfJJOCRpshy1zp/x4bERJEDGxNFYW0qsy33LoZLlyvm7J9V+
         H1vQIPXMrEW/O4rDNO4jWp6W1zT4U6Fq0mM9DGtPM7j0c4AyIK4pIGfOKtWOH7azfmPQ
         Qd+ngLWEFwFZ1jR8a+edjDt7+FqqwxX+Saf+p1qmOyfUyz4+DzALwwVQ0K4FxuHJSf4Y
         YvBrirpwsCfJCAqME6GyrkBwIR4t7lPEv16TuTZ7iGCYTa1XxFvWM7yjThNYYdhEUxDJ
         C45MyZZSc/KAU8pWRnZC8LkHXGHyV3qgryebeTUuxhmRL+zyNMFoksxjYil5iGlWt8RT
         KI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245918; x=1718850718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqSWr/pfZwtTIRxMBQN6sYuDk2R2VvioPDgEPjsCPow=;
        b=YhrMilOtkkZ30FfZFKww4pz3sxu0OqYZJ1684/zi4k9I/z9/1XgyrmJtgc91dbY97f
         9MSJbxsBS4lPOEBDg4cdZdHIPg1IOk47vBYF4hdkiZ/FnKzBiu52zc5s5qzPzvLgdyw6
         VzBjVPapyqJgwbITbiL6wYx/vKVZM6xGMctFVFQswQxpm7BzoMqrkih27FEtoGATVsoO
         6wOW4lzEd2Ey2Yznh+uEJJ+PrCctjsIBVyDFIsUmlY+Og4KwW3TPnHU0WC2phX87admX
         gare5vcwjFzZMdlgJAXvNmoIWQIwK64HRY7rdVTVoPK5XsV0FWwWyb9pW1poOzokLkVW
         8jTg==
X-Forwarded-Encrypted: i=1; AJvYcCUWNP/Yp50yOmNNKOnXGUKtkLa9sgsvuAVHkQ6K3NmBX0zJhRM2Y3bNKg8H6yx8smqXjnu/Hm4NnzpHsSkPsWc6UypzAXuaaLNCXszsoz2cnc013QKj+B3oZHXqQfuxeCegSvZCh91aoVJgBcAGbJcvsaE8okE4sFSBgoHTae08fe1ZKttDRSUM8+/07UmEsU9vPDGYxFmh5Kc3nZ/L8PVQQ0ixzBGFFbvAGXB6CmBZztX9+XjldPemunZJ0P/5zD5uFvdILobk/BywMnxr8n/Cu7u6C9ZMIKSMu4sIij9dueIyj6stMl9tgEN7kElGNPQtQGPeOA==
X-Gm-Message-State: AOJu0Yw3XJUvbdsqQwkDaYS6Od17hHYc5M2OaVkOJaojc4gVmAi0ZrpZ
	pt+LoaahbOo6BNcjppF3XdN17f+/Lti+L7Kxx2d9qUber31/DQB5
X-Google-Smtp-Source: AGHT+IF+JYjBn0OjZmgrQWU2wgsy8ofTmlVYqxM2KmLwEfyu1c8K7LtQBzzKH0FH1zCzrNJ76ASDQQ==
X-Received: by 2002:a17:902:d4c6:b0:1f7:1893:2587 with SMTP id d9443c01a7336-1f83b55b817mr42002945ad.14.1718245918153;
        Wed, 12 Jun 2024 19:31:58 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d159sm1755695ad.289.2024.06.12.19.31.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:31:57 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
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
Subject: [PATCH v2 07/10] tsacct: Replace strncpy() with __get_task_comm()
Date: Thu, 13 Jun 2024 10:30:41 +0800
Message-Id: <20240613023044.45873-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240613023044.45873-1-laoar.shao@gmail.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
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


