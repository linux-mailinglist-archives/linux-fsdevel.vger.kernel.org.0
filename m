Return-Path: <linux-fsdevel+bounces-25621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFCF94E501
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AACB281C10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C76614C5BD;
	Mon, 12 Aug 2024 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqepQF8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706B79CD;
	Mon, 12 Aug 2024 02:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429880; cv=none; b=JNliJ1Cycyo6ut2jkp40OXiqIC5niQvDaZ3/KuoqRJ8fdY+NSzgwPaPI/S3fwR19ilcmsPuIZ5cQu37S+7JKDJ7eqYYVgZf1nD7cg7ct9sREC/pQ9ulDVnemvo/UXKksj/thBXB5U7lTZx4I85YNtOegjk6rZ7hja7ONotQnx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429880; c=relaxed/simple;
	bh=elilKSeW7RC/r2eDi1ZiMc5m3lD+uUhK1+n2V/KSBmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ET+PtF6OeL8gPUj3YO8KM3XqGAWwyPtLPJUXksljJv/dPk5ALH2c0TP73uwgVpynxNKFNQbxUV0PvsVJBaZ/Mk3BD5AO9NckEhQnbS6K5MuyR6TLOIMLy1IHZOhUJdI2CniC0YmXHbp5N1i1Nvt/qdwIOwQgHbwbboW3dfhj14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqepQF8E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd9e6189d5so28754945ad.3;
        Sun, 11 Aug 2024 19:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723429878; x=1724034678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdEfItmwefU07w76SDkXtsO/LaxPCVZAR+StHmo8iTc=;
        b=lqepQF8EvumDl8aj1vFqEbEkxLbEaG8Dk+q6XyYqBov5SOKvuiw7t85CzJYyfOv/gp
         S5XnzO3lhTO4WqlxMBVBPQ7wpeUFRK5I6mfutEwqDJKYJPSwzSk7iVN2Gqv2zDV68ksQ
         OW4eMTCLfXwXoQMxdocQhIOnaHcjk0r5vcOCcXmmklioXsT4o006MEZZTYBNc7inHbRN
         zGQg7oSQIL9FUH+syfzh4hnFqHr6sEYi/2s57CaN052fsWAX9irhlQDxLs43795OiRwT
         BQYx7YRgHdbUl1egFvlr3M/Vnaaxh9Mm0uwKF9xcIuHyEgU+OG98FrVbrKSeiDLhFxsl
         yRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429878; x=1724034678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdEfItmwefU07w76SDkXtsO/LaxPCVZAR+StHmo8iTc=;
        b=xMik287QhAJGVjULEGXDLXp4br3iAcTgwySRmFL9R4ujrvIzC2xllQwj3tc6MjWFOR
         MZQwAGC596dwJ5M4/Tz/Wj7l0gq6ESsAlf72al0eaA6W1uY8uuolGnxZsGcsn4wciRu0
         XdF0zMeTPJPD5QT5T4CApNpQ8SdRrPrAuEM2Ws0t91djAZVPseOsNy/cbojWGZShh5Va
         C4FMGJSbLOPiDCRT3iBvVqNCAI6P7+3akW/MNg3FUc1T6bFBw7dkBed3CHf4nq23w2si
         kK1cPY2V3jiqBWuzxJPF1+Ex4qC+HN67PWjwx3wjmvO5HmKIPdgG4oPWOKYMwnnuZK/V
         X3PA==
X-Forwarded-Encrypted: i=1; AJvYcCXSYVWEsfW8y1krM1q62iIxZ/8c5jjj/uCqAzTvq4lit4Vl14aCBJ7EJ2zg0VYT9KIsTbweu4UVYxf7B12eSwfAuFh3OjNL5unuvYWJiyfBJxtCLCfCb1/uepkRwmDj18nFInyak8veAtErJGGW/io8IiCOVBGPA+dST5+X5DxoJhPMMVpl4xSh8KFPD3mffMo2ZK42sp484MLjBnkWFwtFIujGVG2gmSlckR0C2oUintAeUz3pADcLgoxnqXgGScieTvNgDJndaPvWF8R4N5sAYy9f5IanMudUYshfcnZE9i7bhYGGPSJJ3+3NZY1kYdxQ/LNgow==
X-Gm-Message-State: AOJu0Yzdv0F0WIklJ5AQjcH3Nr9IuB+jhu6knBqP9iPNg4KtsRSujU9Y
	n3Mq+PeJfCOI2onW3eyez06vmtJfSnM0SrjrBAeCWdWC4JipOQDd
X-Google-Smtp-Source: AGHT+IGvMeJ1WDvZRyKICOlWBdf489ybDgp4ZGppLiFztYYS3nDRhT+W8sx80+j2UnrjElUuwI0I0g==
X-Received: by 2002:a17:902:e804:b0:1fc:57b7:995c with SMTP id d9443c01a7336-200ae4dba44mr56315805ad.7.1723429877770;
        Sun, 11 Aug 2024 19:31:17 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fed69sm27884765ad.188.2024.08.11.19.31.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2024 19:31:17 -0700 (PDT)
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
Subject: [PATCH v6 7/9] tracing: Replace strncpy() with strscpy()
Date: Mon, 12 Aug 2024 10:29:31 +0800
Message-Id: <20240812022933.69850-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240812022933.69850-1-laoar.shao@gmail.com>
References: <20240812022933.69850-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using strscpy() to read the task comm ensures that the name is
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
index 578a49ff5c32..1b2577f9d734 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1907,7 +1907,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	max_data->critical_start = data->critical_start;
 	max_data->critical_end = data->critical_end;
 
-	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
+	strscpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
 	max_data->pid = tsk->pid;
 	/*
 	 * If tsk == current, then use current_uid(), as that does not use
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6ece1308d36a..4cd24c25ce05 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1599,7 +1599,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
 		return;
 	}
 
-	strncpy(comm, task->comm, TASK_COMM_LEN);
+	strscpy(comm, task->comm, TASK_COMM_LEN);
 }
 
 static void hist_elt_data_free(struct hist_elt_data *elt_data)
-- 
2.43.5


