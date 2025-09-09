Return-Path: <linux-fsdevel+bounces-60670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B757B4FF75
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D54B1C24274
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146C234AB18;
	Tue,  9 Sep 2025 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdqnE7vv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50739322C81
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428262; cv=none; b=OauyQ5A23rXUWI7eYGlrslyMPs8RmLmTt1Zz2Q8k0WiyaXkVPsdymihWpFWqD0/fhIobb+wh8sx+VIPLw+xpeUKncPF5ANwDdJV+SUbeyrQR+iyBVmFq8htYemtXqON/dj7OXwoKsgf9klYaQI1hDeBpvonHRTvtVY2ipa+rRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428262; c=relaxed/simple;
	bh=x1PBv3aD0wlW+7FfPCbf5hSjTgK/aotf8jlvZXuBNqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxf22bkxMPKfszUS0MqFpzfKyolKqFS4yWlv2GzXRCocOVDd59EHNnUv7NGqXgU44rvNmeMBqXqpMaIagnoPZ+rmQcKYgF/V9cAFwqPMNRYaNzB1sRIhuxsMLI4Cgs70ITcT7KTgxfW0jLM1qIT5Msgc2W+bKFRmy8bzF4GpVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdqnE7vv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757428259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bn1NTq4Z9NIjGlrSBGPZIpTuRS4KTTRxErqbaAU5O1E=;
	b=BdqnE7vviFJP0BUYno9XexgKntTD9an2H7v+5gY9CpbK7bsiIyFy169qMCf0HE+Am/GgwK
	sia/XcsewefcxV20bWB2pJqb7AlHz//FPOiH9D7jvS1UtDSJqdIzuLcR4UgoRNd/CscJPU
	eHFoNSLJcr2lzaTFoqG1WkO2B0l+dKY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-IOSIZ6g7PY23JDHTO4iDjg-1; Tue, 09 Sep 2025 10:30:57 -0400
X-MC-Unique: IOSIZ6g7PY23JDHTO4iDjg-1
X-Mimecast-MFC-AGG-ID: IOSIZ6g7PY23JDHTO4iDjg_1757428257
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dd66e1971so40435375e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 07:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428256; x=1758033056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bn1NTq4Z9NIjGlrSBGPZIpTuRS4KTTRxErqbaAU5O1E=;
        b=NDDWvWl7Fw0YWhrpXnsq9EaG1PeMSLQqbwMZkqA3LODaUGRxLGevpKY0NLdRuj0vt8
         IZb2gsEwhVtOjerTcsev058MQWCiOoEe23eSpkByhW1hNXl+bOl12hvnIy45zikM7jBD
         HkpCDxEh51Vc70oXzkxVvhtacZqzsN0ZKREb8sv24Fp2PST0kOUpEK26v28hhZwygoqt
         XuibARgIhH5EJgXzR8xZvd8D3VfJ8ZHRjrB6nLH/Z6Y1n4E0sq5wiAzwGFGtC7zDx/Ff
         L3LuOq3QDmtPWDN2j44jexsjHKTNewZOntjMg6d+WToFoIxi0qBM3oNfjDoLuBSZLq6u
         vawQ==
X-Gm-Message-State: AOJu0Yx5Hn2dc35wiqrngHAraMAZ8/7VIYQHUZwoBaKYbDfhd+FyUr+5
	n/UuXN/w3pXApmob5PBpk0xrcgrKToHi+eIUEZ128D3nROGQ1laaBrqyGSKEzvBuu+4xmk7Ec+b
	RqUKwwnUKqUR+c2dNXSvIdFHc50n7r2q7wNqCfYftqdBz47pHK9yHmS7QLxsQSNJwoPFkAc7gbS
	zc8t6Hi9S3aK+e+pWTUNJ65WFjbHQp7JnrmgfWXxh0KxhSDuPYqZ0=
X-Gm-Gg: ASbGncuTR7o5M6gPaLEpuU9qKUxh/+KxgJea36jy2f1JL3ykRQ4qgoGmPEb+iwrkdGD
	iapNx2DyVNMyNwKH+qd0P9ghBki/+xXFLC+le0L390YS1POgYGaET+tsxPkyxLbD2WSOMB/WImJ
	e0oPnPvXYFT2RQnPvuIrGWdmhefQD2ZTgnUe9p8y/qk3dMLeBbAMi+SB1/yJVv+YilSHqSMM2Cw
	Zl9H78AokIHhtud5v0LCEzs6Bmc7FEQkHy7NHKJrKmWODZ2hZVIgxcP/pEFGqI4AHQkMUJl8SC4
	zof0jorEUD/mB0OpAAg8CSv+lZE3rRtDUFiKzy/kwQv/wL2T4cE5xH9uDk1NqrBtYNgPD8WUapM
	GR7Vl1PqUXsEnCEXf3ESPkXAu
X-Received: by 2002:a05:6000:40da:b0:3e2:b2f0:6e57 with SMTP id ffacd0b85a97d-3e642f91589mr10665535f8f.36.1757428255970;
        Tue, 09 Sep 2025 07:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMXw4vYeezs6ZUbLH7RYqGUQvQV7da+VmJ+Lu/p2vc4HjNEz1n2KX01BZE9HJQGFF2pVhOKw==
X-Received: by 2002:a05:6000:40da:b0:3e2:b2f0:6e57 with SMTP id ffacd0b85a97d-3e642f91589mr10665478f8f.36.1757428255358;
        Tue, 09 Sep 2025 07:30:55 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-246-106.pool.digikabel.hu. [193.226.246.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bfd08sm2850877f8f.4.2025.09.09.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:30:54 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2] fanotify: add watchdog for permission events
Date: Tue,  9 Sep 2025 16:30:47 +0200
Message-ID: <20250909143053.112171-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to make it easier to debug issues with AV software, which time and
again deadlocks with no indication of where the issue comes from, and the
kernel being blamed for the deadlock.  Then we need to analyze dumps to
prove that the kernel is not in fact at fault.

The deadlock comes from recursion: handling the event triggers another
permission event, in some roundabout way, obviously, otherwise it would
have been found in testing.

With this patch a warning is printed when permission event is received by
userspace but not answered for more than the timeout specified in
/proc/sys/fs/fanotify/watchdog_timeout.  The watchdog can be turned off by
setting the timeout to zero (which is the default).

The timeout is very coarse (T <= t < 2T) but I guess it's good enough for
the purpose.

Overhead should be minimal.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
v2:
	- removed config option
	- rename pid to recv_pid
	- remove from union
	- add sysctl
	- prevent race for list_empty check

 fs/notify/fanotify/fanotify.h      |  4 +-
 fs/notify/fanotify/fanotify_user.c | 95 ++++++++++++++++++++++++++++++
 include/linux/fsnotify_backend.h   |  2 +
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index b78308975082..1a007e211bae 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -437,11 +437,13 @@ FANOTIFY_ME(struct fanotify_event *event)
 struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
-	const loff_t *ppos;		/* optional file range info */
+	const loff_t *ppos;	/* optional file range info */
 	size_t count;
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
+	unsigned short watchdog_cnt;	/* already scanned by watchdog? */
 	int fd;		/* fd we passed to userspace for this event */
+	pid_t recv_pid;	/* pid of task receiving the event */
 	union {
 		struct fanotify_response_info_header hdr;
 		struct fanotify_response_info_audit_rule audit_rule;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index b192ee068a7a..033333c90393 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -50,6 +50,7 @@
 
 /* configurable via /proc/sys/fs/fanotify/ */
 static int fanotify_max_queued_events __read_mostly;
+static int perm_group_timeout __read_mostly;
 
 #ifdef CONFIG_SYSCTL
 
@@ -85,6 +86,14 @@ static const struct ctl_table fanotify_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO
 	},
+	{
+		.procname	= "watchdog_timeout",
+		.data		= &perm_group_timeout,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
 };
 
 static void __init fanotify_sysctls_init(void)
@@ -95,6 +104,84 @@ static void __init fanotify_sysctls_init(void)
 #define fanotify_sysctls_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+static LIST_HEAD(perm_group_list);
+static DEFINE_SPINLOCK(perm_group_lock);
+static void perm_group_watchdog(struct work_struct *work);
+static DECLARE_DELAYED_WORK(perm_group_work, perm_group_watchdog);
+
+static void perm_group_watchdog_schedule(void)
+{
+	schedule_delayed_work(&perm_group_work, secs_to_jiffies(perm_group_timeout));
+}
+
+static void perm_group_watchdog(struct work_struct *work)
+{
+	struct fsnotify_group *group;
+	struct fanotify_perm_event *event;
+	struct task_struct *task;
+	pid_t failed_pid = 0;
+
+	guard(spinlock)(&perm_group_lock);
+	if (list_empty(&perm_group_list))
+		return;
+
+	list_for_each_entry(group, &perm_group_list, fanotify_data.perm_group) {
+		/*
+		 * Ok to test without lock, racing with an addition is
+		 * fine, will deal with it next round
+		 */
+		if (list_empty(&group->fanotify_data.access_list))
+			continue;
+
+		scoped_guard(spinlock, &group->notification_lock) {
+			list_for_each_entry(event, &group->fanotify_data.access_list, fae.fse.list) {
+				if (likely(event->watchdog_cnt == 0)) {
+					event->watchdog_cnt = 1;
+				} else if (event->watchdog_cnt == 1) {
+					/* Report on event only once */
+					event->watchdog_cnt = 2;
+
+					/* Do not report same pid repeatedly */
+					if (event->recv_pid == failed_pid)
+						continue;
+
+					failed_pid = event->recv_pid;
+					rcu_read_lock();
+					task = find_task_by_pid_ns(event->recv_pid, &init_pid_ns);
+					pr_warn_ratelimited("PID %u (%s) failed to respond to fanotify queue for more than %i seconds\n",
+							    event->recv_pid, task ? task->comm : NULL, perm_group_timeout);
+					rcu_read_unlock();
+				}
+			}
+		}
+	}
+	perm_group_watchdog_schedule();
+}
+
+static void fanotify_perm_watchdog_group_remove(struct fsnotify_group *group)
+{
+	if (!list_empty(&group->fanotify_data.perm_group)) {
+		/* Perm event watchdog can no longer scan this group. */
+		spin_lock(&perm_group_lock);
+		list_del(&group->fanotify_data.perm_group);
+		spin_unlock(&perm_group_lock);
+	}
+}
+
+static void fanotify_perm_watchdog_group_add(struct fsnotify_group *group)
+{
+	if (!perm_group_timeout)
+		return;
+
+	guard(spinlock)(&perm_group_lock);
+	if (list_empty(&group->fanotify_data.perm_group)) {
+		/* Add to perm_group_list for monitoring by watchdog. */
+		if (list_empty(&perm_group_list))
+			perm_group_watchdog_schedule();
+		list_add_tail(&group->fanotify_data.perm_group, &perm_group_list);
+	}
+}
+
 /*
  * All flags that may be specified in parameter event_f_flags of fanotify_init.
  *
@@ -953,6 +1040,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 				spin_lock(&group->notification_lock);
 				list_add_tail(&event->fse.list,
 					&group->fanotify_data.access_list);
+				FANOTIFY_PERM(event)->recv_pid = current->pid;
 				spin_unlock(&group->notification_lock);
 			}
 		}
@@ -1012,6 +1100,8 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 	 */
 	fsnotify_group_stop_queueing(group);
 
+	fanotify_perm_watchdog_group_remove(group);
+
 	/*
 	 * Process all permission events on access_list and notification queue
 	 * and simulate reply from userspace.
@@ -1465,6 +1555,10 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	fsnotify_group_unlock(group);
 
 	fsnotify_put_mark(fsn_mark);
+
+	if (!ret && (mask & FANOTIFY_PERM_EVENTS))
+		fanotify_perm_watchdog_group_add(group);
+
 	return ret;
 }
 
@@ -1625,6 +1719,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	group->fanotify_data.f_flags = event_f_flags;
 	init_waitqueue_head(&group->fanotify_data.access_waitq);
 	INIT_LIST_HEAD(&group->fanotify_data.access_list);
+	INIT_LIST_HEAD(&group->fanotify_data.perm_group);
 	switch (class) {
 	case FAN_CLASS_NOTIF:
 		group->priority = FSNOTIFY_PRIO_NORMAL;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d4034ddaf392..7f7fe4f3aa34 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -273,6 +273,8 @@ struct fsnotify_group {
 			int f_flags; /* event_f_flags from fanotify_init() */
 			struct ucounts *ucounts;
 			mempool_t error_events_pool;
+			/* chained on perm_group_list */
+			struct list_head perm_group;
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
-- 
2.51.0


