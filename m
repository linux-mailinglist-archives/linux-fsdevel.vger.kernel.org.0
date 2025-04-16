Return-Path: <linux-fsdevel+bounces-46584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018DFA90BCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 20:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C3244123A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F59224220;
	Wed, 16 Apr 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vs2cjXa8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7D223710
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829925; cv=none; b=N8naXefkdpDlNCfInwGsUT9WZbA2X6F/tP8q8kv1odd+WFsO/KuSZbbOQ1Pt7aKRVZ8pEYFbvY4r62Nc7eYkfv6Er+RRKomSK06CfGJ/K30AUjrKqfLYk2m+ZbQsyF4yNLerXsun+qcAbqYatEl33qqvElSyQV42hxKk+A7REUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829925; c=relaxed/simple;
	bh=NV2T/d30uMUYCMSEQrN+qGxUfWVBYywQA3pZxGO0KM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfcO9feTALqdkDsAI5MoUS/EswzoOxpldjoTfxD9t+gpDglkvGtxyQf7BiY9bDaQtW9H3kGaKZCHujO4s9DBMGyG/udClWrp0W5xdqe/8DR5ONl2VUjiO824HVK25zLGtHbH7smSXfN379YDP+nz0ubfYR54h5L5rj9QuF8K96w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vs2cjXa8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240b4de12bso236795ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744829923; x=1745434723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MX73opmKqNRlFQa1u/fhWDcEoVHRwt6HMlJzJmD+odo=;
        b=vs2cjXa8xn4cjaZGH576ef8jpDwJAhcYDq/wc7ncBhW0h+oXMvsyfC9WsxCDvdPm+s
         x6dxyQChtzbfu6JQoIm2YatPZ80KQ6UMUHf76DwjblUK6KRgcowqEIDP3JgYjiqDCRDN
         o97STGofmC1QUk0ber/CV0hEDOdOVCGWJJd+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744829923; x=1745434723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MX73opmKqNRlFQa1u/fhWDcEoVHRwt6HMlJzJmD+odo=;
        b=ZnnqBOF1VTnUu4x09akAeJ2D4DVOpe+RHbSsdqE47cJtN6C9xwiuMSwjWOk6OR1hh3
         OtUkDSgrrhjqeXAnejktmuquQmsqa7IVkZEb+ojADHUToQ8RhV8cyDJZtWAG8w1TrVJl
         mW3ty0maZMgXnOJN6yB8/odiGmC293ywPfBtxJAp8PoKXFvMWYyULzXcy7lrByerxj4Z
         TkHxiF0Qxfi/b7CeKznVAzcKeZurXBH5iwY5EmaErj3c2v97CfOBxwaX44THLCdPHAhr
         4PKrP9ImavpUa7wFtjSkK7XA5CW3MAWKB35pqNBr6RCowbS9VLVuHhAdrNVli63R/2a2
         zLeg==
X-Gm-Message-State: AOJu0YxKyQ/Swh15/IxcRFClKDh+aynroe+tCgOgYgVzfd8hAaDxfuBB
	nOAYFzNuS7uiYHLTUIcsx/GIqVcKPtY+L0kbPwAi55Uhw4PwIRcMz+QCAD1kS2/M5cgd2PI4ne/
	psCDpdJ40W2hZE/onVHx2vrL/ATwX/3EPpG0QBmC6LDYLAw/i1j8qoNpySJ64vb270CvmVtHEeo
	meT1Z+hxI0wr5UE258FoQcwfR8Apvp5+0rxCp2kQUtBivr
X-Gm-Gg: ASbGncuQSuRGBVSSKuLBwNl2Sn/D1eoITEzbENoERDivjBVm/X4EQtPHeksGQccYAQ7
	jDnOiQCvCgEJRV5Vbs4yvuB0cWRNVFv7N0DEgkCG1ylKFmp3wK8Vf0ccAA+wDiDHIo8+cbNJhdA
	mZVkR7sv4cjlsuMmk2J5qYefi6l1NSPVs+8aMRB4LXXqE4B7+hu/sS3TkmDu+f24/ObCtM7uBjH
	MUhJCHSGOGobjqeGC2iPGku6z0gWHMyJpcuQLK3hA15itUPN93zwqJgAvhKbKmtsGb8WTmmn/zQ
	dkVRt7C/KeaHBylI585N6dYUQ3RTcY9PdjhN9d16BoUcM77y
X-Google-Smtp-Source: AGHT+IF+JrK09M013V8S/Bwyq8dJiFjoIV5fFBaSZEN4bgsctgbYf5KCkq1hNreYBTGPUyYHjWyOww==
X-Received: by 2002:a17:902:e94f:b0:220:cb6c:2e30 with SMTP id d9443c01a7336-22c359a39ccmr48032375ad.49.1744829922962;
        Wed, 16 Apr 2025 11:58:42 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2334468sm10746797b3a.169.2025.04.16.11.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 11:58:42 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz,
	brauner@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH vfs/vfs.fixes v2] eventpoll: Set epoll timeout if it's in the future
Date: Wed, 16 Apr 2025 18:58:25 +0000
Message-ID: <20250416185826.26375-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid an edge case where epoll_wait arms a timer and calls schedule()
even if the timer will expire immediately.

For example: if the user has specified an epoll busy poll usecs which is
equal or larger than the epoll_wait/epoll_pwait2 timeout, it is
unnecessary to call schedule_hrtimeout_range; the busy poll usecs have
consumed the entire timeout duration so it is unnecessary to induce
scheduling latency by calling schedule() (via schedule_hrtimeout_range).

This can be measured using a simple bpftrace script:

tracepoint:sched:sched_switch
/ args->prev_pid == $1 /
{
  print(kstack());
  print(ustack());
}

Before this patch is applied:

  Testing an epoll_wait app with busy poll usecs set to 1000, and
  epoll_wait timeout set to 1ms using the script above shows:

     __traceiter_sched_switch+69
     __schedule+1495
     schedule+32
     schedule_hrtimeout_range+159
     do_epoll_wait+1424
     __x64_sys_epoll_wait+97
     do_syscall_64+95
     entry_SYSCALL_64_after_hwframe+118

     epoll_wait+82

  Which is unexpected; the busy poll usecs should have consumed the
  entire timeout and there should be no reason to arm a timer.

After this patch is applied: the same test scenario does not generate a
call to schedule() in the above edge case. If the busy poll usecs are
reduced (for example usecs: 100, epoll_wait timeout 1ms) the timer is
armed as expected.

Fixes: bf3b9f6372c4 ("epoll: Add busy poll support to epoll with socket fds.")
Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 v2: 
   - No longer an RFC and rebased on vfs/vfs.fixes
   - Added Jan's Reviewed-by
   - Added Fixes tag
   - No functional changes from the RFC

 rfcv1: https://lore.kernel.org/linux-fsdevel/20250415184346.39229-1-jdamato@fastly.com/

 fs/eventpoll.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 100376863a44..4bc264b854c4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1996,6 +1996,14 @@ static int ep_try_send_events(struct eventpoll *ep,
 	return res;
 }
 
+static int ep_schedule_timeout(ktime_t *to)
+{
+	if (to)
+		return ktime_after(*to, ktime_get());
+	else
+		return 1;
+}
+
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
  *           event buffer.
@@ -2103,7 +2111,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 		write_unlock_irq(&ep->lock);
 
-		if (!eavail)
+		if (!eavail && ep_schedule_timeout(to))
 			timed_out = !schedule_hrtimeout_range(to, slack,
 							      HRTIMER_MODE_ABS);
 		__set_current_state(TASK_RUNNING);

base-commit: a681b7c17dd21d5aa0da391ceb27a2007ba970a4
-- 
2.43.0


