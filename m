Return-Path: <linux-fsdevel+bounces-22046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85341911886
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88571C21E88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87E85956;
	Fri, 21 Jun 2024 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgPhc6IH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507684A5E;
	Fri, 21 Jun 2024 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937048; cv=none; b=kMaxsJsW9UPIdOal7sgKcguNs8ssEpZbQIwj7kPIK6OoMS8345rTvOUifaynpujUX52zXZbMnIA+cBZTnGCZG9sh6i+R95ReWSAzcslX2mdZOzajVTibWFYwSQf9WzZEyL8lPA69jNYeeJbejKH/KVxxic2kMGBRKKldZuwuDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937048; c=relaxed/simple;
	bh=LX61AqcJNexywhWKUem5c5kFXTCQtXdiKlDqbpWt6oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B78wbKl7AsbbbbIAM+9w86+zMqN8jOs/Tds87OpBFip3uiCWB5bZaDB0/lsfyaRZZUDRrpI6EtfY/sxfTLGQglrKGp0AF1eLFfvov/fa2aJv0CUeLrwrwF6+1E02+cGkd8zFceQ1eeXud8K7Km/A7c85zKazHDuypzzUT/uhxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgPhc6IH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70436048c25so1557849b3a.0;
        Thu, 20 Jun 2024 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937046; x=1719541846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt6Zo0BQwE9mYz3Q0zCJOWUGA/XKEFxfC7Idotg6GZ4=;
        b=OgPhc6IHdpjn/0c2Upp3ejw9WrJdsJdolcOgS/13YQSr0+pb/eGm7bmlMtqkZS0P9J
         Fiy3oiq/7dCqNroVcEFM1xrl14IDKMoCnJU+Lhupyr3GCRMDqiSkIj/gTlpz1ZTh8mSs
         hceAjNxykx25jYH8VRxAuQUhKQy005XClqxkGN1z2jut1pZh1pD1Ri0MclhLhlXV8Zi6
         PbFvqXNMTfmhRQxp5Cni1oLc+/B3rIrA+jF0EkmkLQPCUO2f8CqlEUrZVVTbkUvUMllf
         kwzDrE37vwBLb692YCuqxurBjUZBFq87xINqufC+JTsGQQ1XmjATe9n/bFRewHDgk20S
         CREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937046; x=1719541846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zt6Zo0BQwE9mYz3Q0zCJOWUGA/XKEFxfC7Idotg6GZ4=;
        b=IUeGfmhzzhJ6omrIclY8Vqi1QpL2eGjWMPobmNb0BqFcQev/mrYfSiWQXvgt8BWtnq
         8uFwffrReaZdbKudTcB8q90bsOW+B6Pkj9PfinPJ8DPIW7DxKHmeLV8YDqSrLNsnlT51
         NwzlwC09k4PbwXj6DCGMu6K4o6t+9jRGoIPVewPvSjl+vsHV5xADK8l/fTlAzXMauN9C
         j/Lgxh4hIWFu5SB1hymHwRyL9+TLngu9CuTWNsm7rqaEFPdq4Ofp0hdRtHplJgTfwTF1
         zmlpi8CJGSC59FwLzgO7iUoJyCpGxi/05WuGjvZ73EjFrVz6j1Abykl5oHujR6BxKMcT
         lEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcXnt5sgbCcowgje+LZf8JiiKE2PPMLU9aTdT9jploeHBJzhZQFw1pt2hq89X1IwhTOWDVuAISvJLAnsJDG41sXBRd3QGc3Xr5suTcH1DoB3x3KP+2nibMdHm0U0Y9NrKYa1O70TDxcXxNy1zm9DaElpPCOAbq7/x0zta9S60yZrIXxbQ6+/4xLEAXiSOWAs4NqHhVaNAoI6sU7keAf3fD4i3WYnzmvCwz9gQew1viC/oH8EpPp5IiCgdAkT/TT+b6TWuJ53fsNacevhvHHbYVtOH0iSZ1qmt/HrKW5iN1Tn0Wjl+6mevFr85PnypHgamrCgwmPg==
X-Gm-Message-State: AOJu0YxxWp21w64ZrAlK53LkTslSs1U5NYYzYoavgIvDjv9nRuBV0yC/
	5vwrzNevzRcN4+Y5k6iy974dInvT/HvdoI2A2DLxN9NvrwEyxMVw
X-Google-Smtp-Source: AGHT+IGtfjPn4RgUkASb+Xbc5n3FAl++/e74fQb3jmqCcMo9NRTzTfAqzNgZkCzFDeDT/EYbemTCfA==
X-Received: by 2002:a05:6a00:22c5:b0:705:ddbf:5c05 with SMTP id d2e1a72fcca58-70629c4204cmr9525016b3a.11.1718937045659;
        Thu, 20 Jun 2024 19:30:45 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.30.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:30:45 -0700 (PDT)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Matus Jokay <matus.jokay@stuba.sk>
Subject: [PATCH v3 01/11] fs/exec: Drop task_lock() inside __get_task_comm()
Date: Fri, 21 Jun 2024 10:29:49 +0800
Message-Id: <20240621022959.9124-2-laoar.shao@gmail.com>
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

Quoted from Linus [0]:

  Since user space can randomly change their names anyway, using locking
  was always wrong for readers (for writers it probably does make sense
  to have some lock - although practically speaking nobody cares there
  either, but at least for a writer some kind of race could have
  long-term mixed results

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matus Jokay <matus.jokay@stuba.sk>
---
 fs/exec.c             | 10 ++++++++--
 include/linux/sched.h |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 40073142288f..fa6b61c79df8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1238,12 +1238,18 @@ static int unshare_sighand(struct task_struct *me)
 	return 0;
 }
 
+/*
+ * User space can randomly change their names anyway, so locking for readers
+ * doesn't make sense. For writers, locking is probably necessary, as a race
+ * condition could lead to long-term mixed results.
+ * The strscpy_pad() in __set_task_comm() can ensure that the task comm is
+ * always NUL-terminated. Therefore the race condition between reader and writer
+ * is not an issue.
+ */
 char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
 {
-	task_lock(tsk);
 	/* Always NUL terminated and zero-padded */
 	strscpy_pad(buf, tsk->comm, buf_size);
-	task_unlock(tsk);
 	return buf;
 }
 EXPORT_SYMBOL_GPL(__get_task_comm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..95888d1da49e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1086,9 +1086,9 @@ struct task_struct {
 	/*
 	 * executable name, excluding path.
 	 *
-	 * - normally initialized setup_new_exec()
+	 * - normally initialized begin_new_exec()
 	 * - access it with [gs]et_task_comm()
-	 * - lock it with task_lock()
+	 * - lock it with task_lock() for writing
 	 */
 	char				comm[TASK_COMM_LEN];
 
-- 
2.39.1


