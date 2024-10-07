Return-Path: <linux-fsdevel+bounces-31201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF1992FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485EC28554A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806E21D9324;
	Mon,  7 Oct 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtrYdtMm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD6F1D7E41;
	Mon,  7 Oct 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312622; cv=none; b=so38UZGRv5DIzwogrfKiiHudY34C1HfNQg73ZgvUpLp/sCMsU290FXswynbyd+pYXKfcoDfakB6KZ5xO8RL1j3O8+dEsRhJneKj4YMu46G3quEr8i+gLXzmTRUHWIgRbCPRkapQzhDo/a+QWBu1nxZhZTY5UsAZfCd6j8gwBJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312622; c=relaxed/simple;
	bh=56ESQtaoBbBqZU/saKgTljkr5U/isylgWUhSQpUUDZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HROxTGOvOkyHIy/10GeBZJ0dtayDd8XpI1TzTNL6dZ61xxhCiDvJp0vYa1vJs+7sFZ7kajpYVDAo3CfnaEYAIjstMwen3kE+pwsELLV4nGaM4J9gDE2ey4XyJ7GcCMDgpNgSQA96pQbHHz9IoD9qpkACnUkzq4n2024ZRFV/lTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtrYdtMm; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso576568a12.3;
        Mon, 07 Oct 2024 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728312620; x=1728917420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=gtrYdtMmh/ZUka/K778EFWlj2oajBLeN5R3sTnWsm3+KDYj4IIWrBLE0R127i71/IP
         3zqnXMpjt0DenzY0GShXCwPJq89pqN2Zu2PQ8il11RJZSnMOuE3zDaXePMzqYd+LtrCa
         tv++6lZKFWEt0CKqAg02dI/Bh4L1o56bmc/6IS6c21S3Uztk7JJwH41Ask8e/S7NAPn4
         BzSmJZeWVs5js36ffwMESJXzXbAkikQSeYEI0Gdyy6ca3JfDwD8umLYQFGfptQj8JuOP
         5b94tZsg+mvgTbe5KgsQ++yrXfVfx3RLtFto+p484iMN3fCDePnoBLHs+b07vzrE8mqi
         Sxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312620; x=1728917420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=c00UglUVN1bEeYAH6kmwIHNyKVBLlnPfS6m3sy0zUYuR7LzF8NhY3sEWhvqn1wPZrd
         ympy6hXHUwSjpc0oSVpC73mLORYkwWf3z5oYd8VEO1Zd31OP2NK/+XPvx39NtiyZZWcM
         /2p+G9GwmAxDFhMy4Et8kxso+BvNvM/6XqHgDkpfTST8u8LVZEOIckXR9rRR9FwPEFuH
         DsVFLErLMxNJzOcsDJXoPEC/I66a+P38uJJpreoXOUrQQMwWPK5rwh8IAUmtywp2s96r
         qEy5iTZ5rucb+G0aJM/j8Nm+jbSSbkX4/32G7ArhGTOW2WR4ayxWlHJJTzHPca+N5Swg
         PLUA==
X-Forwarded-Encrypted: i=1; AJvYcCUGaKKnr2Qm/j7nzbnEMXKxEcTF4e0ki5pJ09ALhHxFn/wVXdCxBCutsAeJcR7zSefgncMnDjbqMVvd4OzoLA==@vger.kernel.org, AJvYcCUm1x//w0AD1/4hTiUHuZZDkjhSK+NQmE1eqQ+mGwHhqGGp3z31SJzsgrovvvWVkd1fUgKC@vger.kernel.org, AJvYcCV+QKgnbaYh2vjNUPoljvJsBWxSZNBqAJ1neTXcQkAnyGtYsvcrcX9dXjLMntyUVswQPYwom42nvjv5dUj2KFGS2s3ghZ8h@vger.kernel.org, AJvYcCVyxY17vbnEA8U7/EHQ7wy6UT/a6r3j+Vc8W7W28R7WdaiAja+YyIGBbAJ5jBPzrhK402asnmbKig==@vger.kernel.org, AJvYcCWDIpMiO3r5LdswIszRErk54zUCs71qBzevZ83pjkdnmAbZd1Kx/WNCEQbTWLo79TuyMSJrughqhpkKFwoqUJaIbNtV@vger.kernel.org, AJvYcCWROuQ+ZrdRatouGdD07Isua7I40/w10wQvMUPZddFobXv2z+rA7t6kLKBPI6qg7lNnWy9zQ0Ta@vger.kernel.org, AJvYcCWoQWRfmJ34/Qyj+AjvaN7AFRQwZTwZa+QUOagyoiLEml6oRGi2vQbCcenFwux/5sGu6UqOZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52il1YnzVR68dSgGWUPPiPfOZSgWFX7uHtZ2oNHUoZ5Q6lhJ8
	ihwAG/Cv86KutR09ZiqOIAaWb7dE7y+W6l1k+JLAFesOWVgSApiH
X-Google-Smtp-Source: AGHT+IGdJ8333QIHr9VJupVLpNtoPXxXbiV/WsIALKPyiyHXyFn3qrINZ3iUgrsX4T7ZKXd0XBWepw==
X-Received: by 2002:a05:6a21:9201:b0:1d5:1729:35ec with SMTP id adf61e73a8af0-1d6dfa27a24mr21138343637.7.1728312619784;
        Mon, 07 Oct 2024 07:50:19 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7cf82sm4466432b3a.200.2024.10.07.07.50.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:50:19 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	keescook@chromium.org,
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
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH v9 4/7] bpftool: Ensure task comm is always NUL-terminated
Date: Mon,  7 Oct 2024 22:49:08 +0800
Message-Id: <20241007144911.27693-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241007144911.27693-1-laoar.shao@gmail.com>
References: <20241007144911.27693-1-laoar.shao@gmail.com>
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
2.43.5


