Return-Path: <linux-fsdevel+bounces-24398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2F293EB9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03944283FEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A25D80034;
	Mon, 29 Jul 2024 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT2AE896"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3711E49E;
	Mon, 29 Jul 2024 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221241; cv=none; b=VICpSyrRzu/Av8tOZ7eKrHYMueEHY6N+3Qp5epw620yNn3pzLuMZ2AziEYownagodmVgm8bVvOAt3ncMS6RPUfcZuuht/49u7XOUVzoP1xm0Y9TJD/OSsq1dxzQ6amNaINFNMP+vzcSvkG3FTTSB2HwyR+TGZL6TtOHTFffWsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221241; c=relaxed/simple;
	bh=MRhgjtwGX2vJNzrN2ayxMYZ3geY9fsSR5HOs6exTklc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mIEQdWSBqs1T8qSQjQzbFf6UZ49Z+VI3hayGh/+ZSe7aclPpVqY75ntLQ/U45YRrhxZ2OPCVZk+oC8qvij6rBZqAzDBQqwjPp+L/HqdMsP1/CaZ5d9s6ofLXN7zwHwkVyUPfQB560RG3gHoAjE+oUNYD/rO22wIWGGAMT8KeW5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT2AE896; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so622170a12.3;
        Sun, 28 Jul 2024 19:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722221239; x=1722826039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Cv3tjdGG97YCwgOlXgEBsrvlHrrgiTFYRDjMKYVYxc=;
        b=cT2AE896we4YA/QNY7C0+dsWjhrnCxZ0lczl56mHF/hSyUboedoehIKwhCjJW4S3jp
         zAHUVDhixRXgDiDCdQLK4yTg80DvN91YKu8bJvRWPR5WxvEUenUbDOdOCK880Cuo3q0P
         EJt0z3oSyxDIcMe4PnyAm+Rn+2QrgWGsJokH+P9PEC/CzTjN8mpoKoTgYPPfVizU6ecK
         csYDpHgKD1sYBu0VofenBHKHSdMwQLktwS+uvF1kzu2XKd9manv4Mb9wVJLU0Cpyfl6c
         g3yGv6uI7hSFefn/dh8mRMyvUBl6NLSeZlCAWWIcKkAOGALiveFaHJCpCoIyEEwBmVT+
         EaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722221239; x=1722826039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Cv3tjdGG97YCwgOlXgEBsrvlHrrgiTFYRDjMKYVYxc=;
        b=QUSNC94qpqzPbSQEccrXbc+jZtF+HQMCsTzenLMvqqCPeFH2N7FZRmEduP5ch478xA
         RDeu+DDvK5Vc0DNPOCDNpX0QW0WOQP27JGGZnPQiJwrwNUOMXoMfHZHrzwUg8Bq8PSc3
         7vjOkr7iXtQcocAZg3b6qU0HqBWtFTW6hg2uvAxBC945G/jQBjqSSaqWibu7MPgg3E/j
         ILkdRThK0tOc1pPEt09VFLs7l2BfINBAdrfe2cGZlISio2yVxjVkOOesvdm2jKWBAGeJ
         dch9/sQEHduDRQHeaeq9sC+GkrSN283geGVU2BdkwMVChPKzDgYQLhpFtnymNK8PAvw1
         oCzg==
X-Forwarded-Encrypted: i=1; AJvYcCUqoLV6/aRteouGOnIYP90qFDJeWrDTEsiegH2NDXmVoF8ms2pfkAzRHOWWJafLzVrHLFDrZ8Lrgc5u38KHBLKmLim3+PjeYSb/W3vCdWs2GUuasfQz8mgfWeQhqkPFXJnEFa8YQTIhfAG2cToOPP7JbxomgU/nc0NbsQedf2CzrpyZM8F5QuL6qUkdYyzQy8lMDvhVk3nr/HIdl/2AA/6EVBKWaeQOfKmB5uptaJnnu1Lobj8VDqHqKtyYDydWcFUFNRdqhiTPZvVs+Zk/fjRJnZbtRwNKvDvfGqNN0wAkyehPVO+ezXZhIODI0cC1qZDmZR4BnQ==
X-Gm-Message-State: AOJu0YzTby9Zy+bKvJQp+qgC5eMHI10vNzdZf0msECj4nG15ieIAFf/F
	JBJUPpzAKU3RxmYBg+kM1B2iAszxEfBK2HqxV3KMCTBjwjmflwxV
X-Google-Smtp-Source: AGHT+IFj28K/vh2Wo2JpPTzYf/GZmJskWb9fJ0b0sRrDd73+gDsWQ9AUVDG1zRV3AS7zIGO4lNszYQ==
X-Received: by 2002:a17:90b:4ecc:b0:2c9:6d07:18f4 with SMTP id 98e67ed59e1d1-2cf7e71b7b6mr7068182a91.35.1722221238743;
        Sun, 28 Jul 2024 19:47:18 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.46.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:47:18 -0700 (PDT)
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 09/11] tracing: Replace strncpy() with __get_task_comm()
Date: Mon, 29 Jul 2024 10:37:17 +0800
Message-Id: <20240729023719.1933-10-laoar.shao@gmail.com>
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


