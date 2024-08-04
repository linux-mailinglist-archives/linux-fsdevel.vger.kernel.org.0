Return-Path: <linux-fsdevel+bounces-24942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4777F946D3D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 09:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC7B7B21747
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 07:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E227A2033A;
	Sun,  4 Aug 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTZUcqzh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31747494;
	Sun,  4 Aug 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758272; cv=none; b=oOL0DHVvcj5hvrJBjBsvZn46THOTOF60rc6A2M+agRFJCmM1lOGeZn7GcPmsciwo9jwfn9LYQhK0mSF0CB6Sx7oCV5IT1+VMTbpCgt5gvojXgQbH4+KhBbiGhja+9UC5TADLzwiFjVzg7LgOXy4QFyM21Gftaxe+PISjfMb5tMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758272; c=relaxed/simple;
	bh=rlenXTcK5dY0xJX85ugd6MF85uI3ieKdNIIKjOjMRr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cGXSVrE9SGGgofgU9VqY2Gxctgn8h2d3sMFawgLVhU8W/XpQwzjalnaC8YN1438hDoAiFvWoD0GGULAnLS46zxUQOon6vKVZpqwHiDi5QQDNvP7de92fSPKZ3qX+mBxKrEOe5AXe69Z35ORUDqVWmslq6ed9zmfQobCbEYuelsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTZUcqzh; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d9e13ef9aaso6621079b6e.1;
        Sun, 04 Aug 2024 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722758270; x=1723363070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQQ3mmtZRuc+UzgaTIbXRCgMjfWu2etwx8M84uu2mcE=;
        b=aTZUcqzhYxOY0aymK8Vbeo8iASu9ZNqWVAWXcLEz4SQ9nPBKyXegAd8iwLInxjX2ZJ
         W/i5tPJFS/fTZPiI10eTGpu4ZS847B1fqdZGNqgfNpw2n7oi//QghKd/NBqesmYn063K
         Zghf2z9WokxEnQnevhG7eqSnI342MeTk51Ui4s9ku3LvsSQQ+QjfjwL6lbkS93xkkO1X
         bbJSZc5VrGL99Eo/GUapyDpeDsvp+gvakbomx1XOo2tVVbVIdiUDovIbd/n6ZpE0meuO
         F2BNJU6C/bbJxeGURq6XW59ju39sgwIIq+bCnlev9tPQYGua0Yk3q82miuVHv+6KN4vx
         tf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758270; x=1723363070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQQ3mmtZRuc+UzgaTIbXRCgMjfWu2etwx8M84uu2mcE=;
        b=L8AOO06o63KMHjHS5jnBkx6opKBWXg13DlTAa19MnJwTuWeAU+/7Rr4LhHodc2t/88
         yyk+eeW3J+yRAM7nMGdUxPZBFETls1vhM3kFWJtbL5yk5LwEtL9SEBXMFz4ZEMdogk+F
         jO0+mmdSnMMF/ST8j/L5zPr1IFs6Xwn5clCHZfjTPMCL+hvhSOHjMoKQSNS5xHpIigSC
         919bk4XO97G9wdLflNnCbSYUXiZ7arjxnemx5xRzP0W3EcHTq3GiKDXw1ht00UdwYE1r
         Qift3FwDM/wn29xEGNXDyZdoO32TQKlOk4gxbVyRM0xZEua+UAyVyxYYIDKmEZyC59yT
         hxMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnzYERYmT4gMzB1T9m2zCWCHw1SmD/0qlUB056wHFfBCCNm1ghedx747iwG++XX1qLL7cNdli9LJPN+C7t/X9IpnVuOXSajhmqi0vWRlhTEO3H2sJB0kNbIrh83K9FtVJdztcVBVR6NFU0uzhuOCG9FkcCDWqH5VZdyYHZu5jmjE75CCLv8S+EAPhm7kYWHPgBz36ycXTzSGMN+/c7tferOgcqu5V19oC3IaX3FiQ9NXSznxm+YgOZuW3llE7Mso277nlFPUxOUuNMiSj4Z9aJriDehLj6zNZqfzOwYBjOKbB6AL1cV2J3fgIedy3pppB5XbUO2w==
X-Gm-Message-State: AOJu0YxFaNF3/KMpi4eJRGGJpuw+LpTvsdJJv60ApnEMF8eA+VN7uR0K
	v6E4ydFWubG5Yqam55vVfMBJsgziWmOUsrbgQQae9R/22CDmuQYL
X-Google-Smtp-Source: AGHT+IEnK16jBONqPu6EI1AggsrrDpNbP1fkcELTlG1wIUqkHXvdRtx4NsDiXlOwAOqcDTPz63EQbg==
X-Received: by 2002:a05:6808:159d:b0:3da:ac85:3bd5 with SMTP id 5614622812f47-3db557ef9bemr11482423b6e.8.1722758269943;
        Sun, 04 Aug 2024 00:57:49 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178248sm46387605ad.202.2024.08.04.00.57.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 00:57:49 -0700 (PDT)
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
Subject: [PATCH v5 4/9] bpftool: Ensure task comm is always NUL-terminated
Date: Sun,  4 Aug 2024 15:56:14 +0800
Message-Id: <20240804075619.20804-5-laoar.shao@gmail.com>
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
2.34.1


