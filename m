Return-Path: <linux-fsdevel+bounces-8803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5FB83B23F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 20:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3FAB2462F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90740132C19;
	Wed, 24 Jan 2024 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jPzTIbJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C312FF86
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124221; cv=none; b=AxjOTO+pOcAgM+GfdhGmUfkhoHjEE0KHXgDvc81vQ1XRrlhFrxo3CHADD92jDpAqI3IRFd3/owhv5YePhddZRrfGWy7X9YOj1qCuOa8uO9hCM5hsYRLudSEcV26T9cTGLHXUUBoE1DQyawiYHwshPc4wLt1iYRj/4fpstyuz0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124221; c=relaxed/simple;
	bh=VR9kpbQ0DKQJADcCvje12k4QMRw3v2j7EWNUrR5Qufc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FpZ2oS/B/17r/rFDdQbPOHv2WQIyIPQP7e+7MwuGvsN6rUq8xEnScUpu2YiyJAQ42nZnHnIdkLw2Y0eRil0tpLAVrbvgmxeulvU6+1jAVrXQaed+ohigpPFYUUjS60eq510roaokJTKAdybf+aR4QSq8pPW60i/A+oxmxgvgMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jPzTIbJ2; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2971927a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 11:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706124219; x=1706729019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4OCyr5pSg26Go2Q3o/nYX227mKURIEY3hyUdQOlpImo=;
        b=jPzTIbJ2Qhu9UYjSVG9yWbLHSmn2aa8JecRC349pRlmv6UmpBuxC1A339CYcBniC+1
         Wy5UmR5FbduNuQ/yroo4TLfOSb3FzZ98QYQ2HGE+smVcmBoW8ubqP3rUQg57HfgT2kAM
         QxeZ9bRKBi+uedfMapefXXT5qx6IOdaa7J+1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706124219; x=1706729019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OCyr5pSg26Go2Q3o/nYX227mKURIEY3hyUdQOlpImo=;
        b=dxXFn/K+/uVnjRzwqGR0hTpBNE43UwNPXbUSR51onich2gLDSLsmqMDbo6Zy6vM73R
         nVqla3OtasQDOTFBYrsBWLX32rh+S/z2kvYcc6l+9i8bNulibXzgOwShnNagg4xE7z79
         Mvu9SEgKPwHcxZkh0OOXdwKwGnyvlgWTp//1Uhk56EDrvwdbCFguHf14itqVxOyHfuyi
         JAa1/4ywKhOIxVFg+J15pxWwASyF2Nxe+rvXlmPhy1AoLlMi0xsMw7/vuK202MBYBSZG
         lGFSrZ7MzCTa5TAqJ3jL+or/zAvN5VgNZjjxUZzG0fqy/q4QtArw2pvg93FE0KDFJfuM
         l6yg==
X-Gm-Message-State: AOJu0YxgFbghyGgpnrBOA+jP5k1yhA3Fo4v3mRicQefZkUw3ZKkwMGow
	aeL3W+ybx+R0gCSzRnKAZtn7SMvUSICvix8pbH2vddr0FvZUS0oezDJ4pivwsg==
X-Google-Smtp-Source: AGHT+IHJyVGEDKONb5N+QJmOiSDJSmei1sELC71O2denBprxp6vv4OD8lz0PhgNPTwOyl9RHYLBoYg==
X-Received: by 2002:a05:6a20:c907:b0:199:e6d0:646f with SMTP id gx7-20020a056a20c90700b00199e6d0646fmr1372021pzb.62.1706124218867;
        Wed, 24 Jan 2024 11:23:38 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i18-20020aa79092000000b006d9a7a48bbesm14077211pfa.116.2024.01.24.11.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:23:38 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Kees Cook <keescook@chromium.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] exec: Distinguish in_execve from in_exec
Date: Wed, 24 Jan 2024 11:23:36 -0800
Message-Id: <20240124192336.work.346-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2067; i=keescook@chromium.org;
 h=from:subject:message-id; bh=VR9kpbQ0DKQJADcCvje12k4QMRw3v2j7EWNUrR5Qufc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlsWO4+WfxI39wun33oA9LOez8cVdNcQbQe0jig
 /3TTk5FmSuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbFjuAAKCRCJcvTf3G3A
 JgR4EACebytLFIu8RYZJITvGsNEcqZqvOSILHoYE48QXsSIUs9g9QRKFIkJ5vh/QPgwtsmhGiIJ
 JnV/zDBcSQkSPdc7dZ+v+imUpKhe0fPzsBQdcUaP8UGjlJCBlA6DMd+YAeXkZF3+WG3CkKBzPMP
 QJhvssc4dQ4XW5o0KGGNetMWLG/mJhLpka5HJ8pZkAAcSycsLT1wJFXYgWy51n/TMAwdOfHVMiK
 Ivzzjiz0hWK81C8SqqaGbFhGU7+2KnIg7Zfs5bUbe/8zIjXkOQiO+VfjxLGyB9daFfbNrtXNPGK
 okEYC4+omNvm5517jvtuSE5N6dvcOhtF34mgDV9UBdZnc6NFYWDuDUBNv89HWXAKpHkGIChV8jB
 28gO71T0qDIno9Bz00/utOA/8B84rw5srxL5+ABi/HjCxAxYIqisZym150VKYGSV5ro68qp5nLM
 28X4+mbOdOHyybgFGME8CPBGkYqAVP3t28aS94mz29mU0bAIBHlErmfjKnPc7qNvEzpazZA1Jt+
 B/B80aaP+TPl7Z+Rpud+gXpkVQ17jFmTjyD04rF1xIOHm941DQJ+hzZRf9F8fQWDOhafdSkSm9p
 xh3y/wcuEkSaGIh1mk6sYDNzpb7lnAXGJc2VDc2kPKUsrCwf5T6x+eEP/e6aHudoJHP7GNVAFCJ
 b1tnmrQ J0V5evIQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Just to help distinguish the fs->in_exec flag from the current->in_execve
flag, add comments in check_unsafe_exec() and copy_fs() for more
context. Also note that in_execve is only used by TOMOYO now.

Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c             | 1 +
 include/linux/sched.h | 2 +-
 kernel/fork.c         | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 39d773021fff..d179abb78a1c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1633,6 +1633,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	}
 	rcu_read_unlock();
 
+	/* "users" and "in_exec" locked for copy_fs() */
 	if (p->fs->users > n_fs)
 		bprm->unsafe |= LSM_UNSAFE_SHARE;
 	else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index cdb8ea53c365..ffe8f618ab86 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -920,7 +920,7 @@ struct task_struct {
 	unsigned			sched_rt_mutex:1;
 #endif
 
-	/* Bit to tell LSMs we're in execve(): */
+	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
 #ifndef TIF_RESTORE_SIGMASK
diff --git a/kernel/fork.c b/kernel/fork.c
index 47ff3b35352e..0d944e92a43f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1748,6 +1748,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		spin_lock(&fs->lock);
+		/* "users" and "in_exec" locked for check_unsafe_exec() */
 		if (fs->in_exec) {
 			spin_unlock(&fs->lock);
 			return -EAGAIN;
-- 
2.34.1


