Return-Path: <linux-fsdevel+bounces-24393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C0593EB71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2171C2163F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C770F7E0FF;
	Mon, 29 Jul 2024 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcB2/bmA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676726AFC;
	Mon, 29 Jul 2024 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722220784; cv=none; b=BGSJw09AxW0G5wc24SIwUwVFVleq9jW5Hhs96pXELe1sn9hsrGXm4JPcjQo99PLam0VvKnfpeJ+L6i+RFQYc0bWD/g56813BrQeKl1IBDi6cu/hn8IS9uIiliY8emXdu9aPG8S0q0r3qFO6FiuNu8WqGDK3lpayKOcs2NcT5Azw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722220784; c=relaxed/simple;
	bh=56ESQtaoBbBqZU/saKgTljkr5U/isylgWUhSQpUUDZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJ/OOhn4FMDttt3LTwPEEnApi+r6SobEWjYTPNESFg+VPU+2OgGcbqxP6J6W1c09VDo2nsNfWekZcbUndrVMtIliNkOg3kUF6Sbi9zQJFaeUB9PG71Ucn3tfTG+PATq+nCa5f0aCkPP6J0hDNCfFn6ZW9eN/qmRGcgl+hcpsZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcB2/bmA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1459777a12.0;
        Sun, 28 Jul 2024 19:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722220782; x=1722825582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=EcB2/bmAWFYODMlXFBim+/nzcdEPy580EgjIQ+hEc+XuhpauULwUwtbTO2fHYQfh0U
         wIaMqM4LTH+P06diYzk9sYwUg5yK73OwUzpa4hKjuu0+TqnVgsEII9vq8KN5aBMj33bB
         21TIlHS29X773RV9HbDxTpNE+D+2iS3VvZxE2xYCe5VPHJyN+QKQzT30/JWe5jSYU8Qt
         qGNq7F4ILvHH+G50mst4RLXnhVkb/HSpA3vL4GGxp2h+mOxzXxOTtHdWfaoEBn2VoOFV
         /vQ5uUyVkwOyBHMqGmCLz8oXoH0KLrkVDjs596CNxYLaz4iGbqmzciFkontY4ims1D/q
         moqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722220782; x=1722825582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=tCuQjrmwUnEApliYBdtz0TVdlalJVGM85TrFyVcZWSWAPiADLBxbZzrgL1IcItj+7A
         UIPmVFvmj8YskawX+UwKEjZ5c6mb8WO1YX/SFvkCLJTI19mPy4Yu7iQz03uELq6ryBlI
         jii9G/Ojizk00hpAPw0Y7wZi6s98rAx2qW2NLqgxDoJSweYuOgkY5zLG8uFt8N1/gyZy
         oSsA83oW/km2TCOZA31x1/X+X8wznNevgJDfWEmXA19tD+mVceASbGkHXNRGnIxVIULK
         BOrgN87kaqnn7VIOgHUMM4FHKMqRBSTL4j9Z05+wYrItsy8FqxsP7BbPZCES7jvpaHsp
         w3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZexdgsx+3NJdSKjIH7zwgubvAElaJOn5Q361Z0xpnUHx5Gz1gIYMvnXUEn8DydPtnYRMd7lL/u0v0MUx/e+0k/s+NisDwsIrnB6d4+Sf8c/bo0W9FGSU0zu48AC0RObt7egNfFH22Mq5ZEkDytt2q5bYbv6t18Ij94AY8C2wdMYeG/bRLfy4+WSnj3wHSmdKYGsiBhKX8pbhST2zqWjxBbrmeslu5IpKOHoyX/+1mI2QY5OA6iEKj4r/vk0dJiS90O9CAo63iFNdYxTI4mXAdeaz9RCFADa29NqPBLp0Ako/jLj4YFTZ8b3PjWwUnNr6r2TCBVg==
X-Gm-Message-State: AOJu0Yy4vqdjcpAS90S9dJdRGsL8F0FAVn+3uYxgvtNbv/dTGQA0IKpF
	Sc3/ickPc0SFfJ0CoUyoar6f4SMncIwVPbS5i1HBojmLDVYnDuWN
X-Google-Smtp-Source: AGHT+IEB8l3Gwpw2EoLQWPXs9e5ig3IiPuxqtfGfuMuw62eXKcBpM2d5t6Uy/en6iDAcfcY1gaCpLA==
X-Received: by 2002:a17:90a:6581:b0:2ca:8684:401a with SMTP id 98e67ed59e1d1-2cf7e5f27a9mr4176294a91.32.1722220782084;
        Sun, 28 Jul 2024 19:39:42 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.39.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:39:41 -0700 (PDT)
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
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH v4 04/11] bpftool: Ensure task comm is always NUL-terminated
Date: Mon, 29 Jul 2024 10:37:12 +0800
Message-Id: <20240729023719.1933-5-laoar.shao@gmail.com>
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


