Return-Path: <linux-fsdevel+bounces-22754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3555691BB05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E21285857
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C88E156875;
	Fri, 28 Jun 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knfkixXQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043015217B;
	Fri, 28 Jun 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565582; cv=none; b=t+SC6v5b7baA9692ZJHl3nJrGF67hKgmt5Thjvf16Yc25Hco+IEyYtNBkBTPlhNN5lLKhA6WYzqY5gnVLh/otnPbv1TvWsFS8Y4mGWJYhqA6XVqjcEWKtZtt/KZVZZuBkhkQTZzoGgu/tTZAgBYZX2M3wKysHOPpr6zbAbX1UBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565582; c=relaxed/simple;
	bh=MRhgjtwGX2vJNzrN2ayxMYZ3geY9fsSR5HOs6exTklc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGVoWfJ0U0G396+NdH/SJYomypF3lYnTIZfGsw2BzT71djSAMlTrmraSn+ODxUYkRSQC+SiH5Vk3PvzrSBu6G2HSHot7uc8EFp+HDT9hq0XAyRqFlY8vbqVfykZ86Xo2BM+IeEMK6gprZFATbYIH5G0m2hETszYBSsAhJzU6LYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knfkixXQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f480624d10so2276965ad.1;
        Fri, 28 Jun 2024 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565580; x=1720170380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Cv3tjdGG97YCwgOlXgEBsrvlHrrgiTFYRDjMKYVYxc=;
        b=knfkixXQ3TW2vjRvM84nBeVPHhGrsITUdG1E27kw0EKFT9nNcrNMNA0D5D8xacuDQt
         CsvAmp7DXAcKadMearvGc9t/pcgWwEhW81wkn4dsIFRjHl+YgI1YGBvqIY/aHG91FUt4
         +WczwFqoDNlxa4hKcXCLbLKQCHM+lZvPSGG/KF+BX7XRho8d9qsr8raoLKr+mDp/B+Pz
         aL6a3ioBRTo1PfmjnC8hBqAuMzxV9Bm9Vm6mCwrPAxiBURb945XE7M5VCkcWY40jDyyw
         Ql4c/NdAHOH8ApMGDLIdTNRPbtnXWLCSena9pQTA8mep5A9YcVtQy1XzAdtpvBRdO0FR
         SZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565580; x=1720170380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Cv3tjdGG97YCwgOlXgEBsrvlHrrgiTFYRDjMKYVYxc=;
        b=kQdCQPFe3CPjXcXsrj40btdnNzWVpS6D84Ycdy9WxKu8J8ifuyLRYDj674oJiZEUvx
         o1ORYyZIJl3r5A2N9NiBRL+/k/Uuen/pZJr5GL9cm5Yt1+68oObE545zWWSyBDNiCAKw
         XjYURAYWGnfZ/m8ccpn6FWKUAActv++jhb+10NkHRHp3O6i/1YGQ+jIKhWbpyvRfX7/D
         hJmzD26Z46AbbGs6eVKXxW9PL/Yu7ZyMxuQPfCfOQ5zFjSwBsu7sUZwOWhawsWBF8gbd
         mTwO9lzJRw5dtnu+QptjNg1l1tefGbrxusgVclXzOh6NLje2rvZbDJzUoVSUUGFU1BA+
         /gzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFolFp2bDjNCKliK51kggPiMH5lpOOUNknOmomj4DNJymhWMgi0lMnnqood9I+cGSuddQfuqfNECGMwhAKCAU/gG+5D5F3yxxOtB79oR82jEaLj2w1ifxoHVcUUk0dwI7whdRNytXUva1eKBSRC05BQMBSQddJnoR1af+SJ/oCFQTwA+MgTvecYVFriGWvux/DTHVAnAe+bVDP2f9nSQt680TAArvSevCvzO7BJZVK1eceFzyF/+e79GN5yEeyIhozDp5LKzdEvEyFRAmLREYPVAiJ2hXHtkoxfEwAz4daERrPyxi49VYFg+xF0KZNckS4FK0FVA==
X-Gm-Message-State: AOJu0YxMaX4qshIwvZOysFIyXNUekBgVCHhW7GVAErU55QJx+vFN4/0C
	clQ2+nLyqST/sEmx9VLzBI4pXm+7xzxheyqoNqdUTgfyxePPqBGN
X-Google-Smtp-Source: AGHT+IHxho2IY/KPtiPSOQ+4V3CqX1HJNyhpaejcbnnpb1PpTk/59mlf95gQnvz1ll6XSDBM+JJ4SA==
X-Received: by 2002:a17:903:1c3:b0:1f9:9cdd:dc76 with SMTP id d9443c01a7336-1fa1d667d19mr200814765ad.47.1719565580537;
        Fri, 28 Jun 2024 02:06:20 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm10473085ad.68.2024.06.28.02.06.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:06:19 -0700 (PDT)
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 09/11] tracing: Replace strncpy() with __get_task_comm()
Date: Fri, 28 Jun 2024 17:05:15 +0800
Message-Id: <20240628090517.17994-9-laoar.shao@gmail.com>
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

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/trace/trace.c             | 2 +-
 kernel/trace/trace_events_hist.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 578a49ff5c32..ce94a86154a2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1907,7 +1907,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	max_data->critical_start = data->critical_start;
 	max_data->critical_end = data->critical_end;
 
-	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
+	__get_task_comm(max_data->comm, TASK_COMM_LEN, tsk);
 	max_data->pid = tsk->pid;
 	/*
 	 * If tsk == current, then use current_uid(), as that does not use
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6ece1308d36a..721d4758a79f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1599,7 +1599,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
 		return;
 	}
 
-	strncpy(comm, task->comm, TASK_COMM_LEN);
+	__get_task_comm(comm, TASK_COMM_LEN, task);
 }
 
 static void hist_elt_data_free(struct hist_elt_data *elt_data)
-- 
2.43.5


