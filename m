Return-Path: <linux-fsdevel+bounces-22749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E091BAD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9D9284B7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A56E152190;
	Fri, 28 Jun 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBAiivsm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3913FD9C;
	Fri, 28 Jun 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565550; cv=none; b=LJ7sAvZaeNmnqkq7Lc+ZBO06US4jDJm5I13RjiHQu37pETwNoF5oFOeZVbc9SwBgPp8Es4vG7iYwVcu8yYywbfPCDIfuX8ClMtv7tyeB1AuH0Tc6TMu3NERD0LdOJlRZ2zufAaX7E0Slqb1JEfZ0NQHb9PizjhWuGYUGQNGTrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565550; c=relaxed/simple;
	bh=56ESQtaoBbBqZU/saKgTljkr5U/isylgWUhSQpUUDZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M03Q6QZxGCfN7JcrGvBKx0wkHd2j8FZFRAv36tQ05X9P4Apo+nyebGbA6/B2ES5xoX3g7vu+kHAJclbaPgGSKGqZG/CEhGyvKEjgXAyRMuN9L0HyKEzSbOAjSCTjojFuOW0gcyWiMlsdIFpBQ4elg74M+e3upjynubl6SjQHBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBAiivsm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so215745a12.1;
        Fri, 28 Jun 2024 02:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565548; x=1720170348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=CBAiivsmAqatmPO8Mr+bbLPhjY6pNO10+HWKtWPdNbYcB0z0Ar9r8Z6xT838uTzZHz
         2u1OLarW77kbSC5GFi1ubd8/e044PKRai/T7Ia4xa6+T6WDa1/kni3NAv6iswFFGpILH
         WEeCnfw8YJW66GCbiLED6RAq0tsnPb5J4CkSLYVfewXS4t7fkN4iBEO0GnTCS+xCTRzb
         2XCrqX69nw6lr/Dbm0WjgKblSKa7INUYeqTqY0WCfRcFQD6s5rvjqsIDz2L7vjbD9yk/
         GgqMd4Ha7kVn1aNuKKv29nsZAowEDpJgaWn9eXDF92ToqZCrjNBugp+8Uc8QCjwl0hGL
         UGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565548; x=1720170348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=uvlLqjBqS5Wzlg9ktXWQ2qIGV4Mb+rHJjFcjlI+AAr9gWLhA12a68qaDgTvGQ1vJxm
         8CYMOM9yq+oK97AJ5LroRyGXuC4NgBIkjlS7l+gU6PW/bKSFFAi3aazPT/RVFWaNoFjg
         4xyy/fwap2Onc7dQd8ZUAqf2yumiX14V7E57Val/UtFDe2JNhkW/CpWvUmMPbEMMrA3S
         nYTB+S7NJE25X2JmfRduQzvu9Hl9XqdiYwDMvYMjPFmTb3GgsJwa27BT6zDH0qI7pq7e
         c1O/H5bPp2mqPb2tx+t4Z0TDuRy2b0P1Loko0ZrN8bygaR6zV8qdyAQvb2ej5dICncKo
         ahIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDjaNFRs+JDDudWMVY6MO+X2rffied4mth85cCavMqV+HuGs6+SXkqgddXlosd/h65SqkpGIgaqa3DscgrrI6j0eidBzs3jSzueHCezngKDnmOqwAY7pnzbkN/9bmDyJfskys71n761icVT56wQxduNOpPwxGBpEdIXCgVSDfSXrpRccJ0dCzMGh82mJTDD2Y9ibUees4sYH++b3SEYHxVIJpayt+3wH4WoURTlZuQESYKWGy0iTKPIiLK/UPsq+0tmXvNVfzdDAdbTHlRbFkiB62fVHUky5csiSnTEIXI0VRbP6u2firci5PNobGONnbu/rGetA==
X-Gm-Message-State: AOJu0YzQvHI9H8Wg5lpJ0TsOwmwXJSthbdCh76f/HfFrj8lFBXcnwpbC
	cOT1Ewnxsm14pfpG4V4f1NECeslHWBDyMmHBbMni2nb4VcrsZAFJ
X-Google-Smtp-Source: AGHT+IFMoCwH/epxCGvG8TCVrNgBjmP2Ft1l1xXAwKN56cpOIayJsWQPU41hiw8mZOfUPZaXevc3Mg==
X-Received: by 2002:a05:6a20:6a04:b0:1be:d9fc:7f03 with SMTP id adf61e73a8af0-1bed9fc824fmr4655522637.23.1719565548310;
        Fri, 28 Jun 2024 02:05:48 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm10473085ad.68.2024.06.28.02.05.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:05:47 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	laoar.shao@gmail.com
Cc: akpm@linux-foundation.org,
	alexei.starovoitov@gmail.com,
	audit@vger.kernel.org,
	bpf@vger.kernel.org,
	catalin.marinas@arm.com,
	dri-devel@lists.freedesktop.org,
	ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	penguin-kernel@i-love.sakura.ne.jp,
	rostedt@goodmis.org,
	selinux@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH v4 04/11] bpftool: Ensure task comm is always NUL-terminated
Date: Fri, 28 Jun 2024 17:05:10 +0800
Message-Id: <20240628090517.17994-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240628090517.17994-1-laoar.shao@gmail.com>
References: <20240628085750.17367-1-laoar.shao@gmail.com>
 <20240628090517.17994-1-laoar.shao@gmail.com>
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


