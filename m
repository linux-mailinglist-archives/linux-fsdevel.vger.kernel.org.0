Return-Path: <linux-fsdevel+bounces-53799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0AAF7502
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 15:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3FB3A2294
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF912E8E19;
	Thu,  3 Jul 2025 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vhqc9//+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E052E92A8
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751547950; cv=none; b=HkVLe287VDjyrXRIJt3w8CClhh9JyNM28zJPrMrOXES6IsuHiee3Fc2SsGwFruibFHXY0gXcxmCwIGrIvjjeCRxeFaZfl5615fp0F3EZHYe71vRLZuBLECGWp15d6JbKaa8KD1mCp+1qXzeYBJA8JTuYnW+05SAstXeaGwHKaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751547950; c=relaxed/simple;
	bh=WvI4dCZ2TArDRdO0M34DvL4trFNUDAIzqJbS2DdNJ7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7JNdRbu/+pNlUXwRmGaeXsRG+KuEeh5ZCLs/EknhPhIK0Jm76RKAvTSs0clokUwCm0GuZ7TJfTW+6B8ybWTjVeS37LboF5XsY9YNtN44lZAiNo1Xqs2GgIg9PYTO5mvYFenBUW1g1KqKZjhTYkEGXPqk6FRhosfDPo7cOXHAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vhqc9//+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751547946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xELjE5Fr4VK7I0PQ5m2zei9ZXTaGqcKLCxvJH0YJTJA=;
	b=Vhqc9//+zaWIix4xL2DP64ua/TyZeD9pHW/CLCdXuFE+bpTtMvBEy+XNBqmBImR+FHvN8T
	7ToBjGTCWiHY3q85FwBLAFVi6Y6/cUczRhhUGlToA7HxVyE/P6+7pBDC4UgUXJTjfcJJho
	yRKCR5HCAXrm//+U0sINzK/J3UTmUsU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-ikrtp1lMM2CljTmaIHtjhA-1; Thu, 03 Jul 2025 09:05:45 -0400
X-MC-Unique: ikrtp1lMM2CljTmaIHtjhA-1
X-Mimecast-MFC-AGG-ID: ikrtp1lMM2CljTmaIHtjhA_1751547945
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a6d90929d6so2249169f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 06:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751547944; x=1752152744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xELjE5Fr4VK7I0PQ5m2zei9ZXTaGqcKLCxvJH0YJTJA=;
        b=L73AmFRsTB3WXMB1rlh1QKq6lNWVDDhPc4bZTZqT4Mlv1cAjhApnl0dVt7OVj3DSyy
         r2beEv3M6HI9eoTCWozT2MZuxiHtDmZRCBMcHnb+54EZEl0dNu1sIJm9vnqqRchvDfKF
         dFT5UXlMpRd4jDL/nozlNCcYIRSJZJAqDCwaR7JmwSOVFIC/7ecXX/l9YOPyyHbovdsm
         0OSafBrf3xA//OcyWBdrvhsRQLYK/AbZOorJVn8V8rlkKe/eXOAcoMZnISEvfj67sDV8
         4RtR+FpUZe3UkkhLkgHk+zNdElwQqWYwosD6WOvL1ht2mOn1v82dFT7DC8T6acU06W7a
         Pt2w==
X-Gm-Message-State: AOJu0Yyzx164w5l0W0LE1j1twXp26C2ujHKKPNAG47KguPapNBadmSpS
	M4em4nayXEMPJJ1HqwpQoJCyq90vS3+px8ryKtUFbkpcy1d8dHLHMVCDZFy+8UJP5N9ymxAkGUK
	qME6QLD5ggs+SPl/c+1t8sF62+/jUlyHYG2N3J3fVV0DUpzECGVdQ0otWQsFEqHjwG2lYnmTPPf
	uZV9+HQFRgWAq8I1eK4pKH1bups42VGqVOu4IaOoQiyvfKRHiiZpc82Q==
X-Gm-Gg: ASbGncvUdTsejngjJ3+3uiLYZzVEynYFw0Vnu8NoI5fZK9hODVdLg+hzWyFZUXQVJuB
	MKFbX8is5a570/jaaf8FkBUUO714ZipBTSjLa8jYCCMAEDTG5UoV2zWSqbaE+am5fU4QkLacpB3
	GlW5pEuiPBL91vbWpNbH6AnpXQ2rFJG6cfY//40CNPl7L9HtQVg+Pd5gjlAcH01TqUUV5UVR6b3
	6loRSutTweLZRZF1hHEnx5BNPIK/DJ4WiZ4vLY6ogym+Nv88aY70vd8GC4h0iTTgA2S6Xz+AM56
	WoeIh+ew73rAWV1mMQHiILAuDSSLcMzNa7S8o5e++dEgG0NmFqSdc/pFGD93N+gMWUphFkqR7BJ
	XEaC0E+COujVmtcHDT5qjGxWmgELNd352hbiJ
X-Received: by 2002:a05:6000:1786:b0:3a4:d0fe:42b2 with SMTP id ffacd0b85a97d-3b1fee672aamr5618375f8f.19.1751547943669;
        Thu, 03 Jul 2025 06:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTEYhU23+ycvUCUqOMnk6QT+gpGE63BzsIYSnp7cdGeECIfp7qgbXWR0lHc0jWm32/sUBNtg==
X-Received: by 2002:a05:6000:1786:b0:3a4:d0fe:42b2 with SMTP id ffacd0b85a97d-3b1fee672aamr5618309f8f.19.1751547942794;
        Thu, 03 Jul 2025 06:05:42 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (2A001110012A9D9C43D3937EDAF845C7.mobile.pool.telekom.hu. [2a00:1110:12a:9d9c:43d3:937e:daf8:45c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454abed940csm19750325e9.0.2025.07.03.06.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 06:05:42 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Ian Kent <raven@themaw.net>,
	Eric Sandeen <sandeen@redhat.com>
Subject: [RFC PATCH] fanotify: add watchdog for permission events
Date: Thu,  3 Jul 2025 15:05:37 +0200
Message-ID: <20250703130539.1696938-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
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

With this patch a warning is printed when permission event is received by
userspace but not answered for more than 20 seconds.

The timeout is very coarse (20-40s) but I guess it's good enough for the
purpose.

Overhead should be minimal.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/notify/fanotify/Kconfig         |   5 ++
 fs/notify/fanotify/fanotify.h      |   6 +-
 fs/notify/fanotify/fanotify_user.c | 102 +++++++++++++++++++++++++++++
 include/linux/fsnotify_backend.h   |   4 ++
 4 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
index 0e36aaf379b7..eeb9c443254e 100644
--- a/fs/notify/fanotify/Kconfig
+++ b/fs/notify/fanotify/Kconfig
@@ -24,3 +24,8 @@ config FANOTIFY_ACCESS_PERMISSIONS
 	   hierarchical storage management systems.
 
 	   If unsure, say N.
+
+config FANOTIFY_PERM_WATCHDOG
+       bool "fanotify permission event watchdog"
+       depends on FANOTIFY_ACCESS_PERMISSIONS
+       default n
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index b44e70e44be6..8b60fbb9594f 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -438,10 +438,14 @@ FANOTIFY_ME(struct fanotify_event *event)
 struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
-	const loff_t *ppos;		/* optional file range info */
+	union {
+		const loff_t *ppos;	/* optional file range info */
+		pid_t pid;		/* pid of task processing the event */
+	};
 	size_t count;
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
+	unsigned short watchdog_cnt;	/* already scanned by watchdog? */
 	int fd;		/* fd we passed to userspace for this event */
 	union {
 		struct fanotify_response_info_header hdr;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 87f861e9004f..a9a34da2c864 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -95,6 +95,96 @@ static void __init fanotify_sysctls_init(void)
 #define fanotify_sysctls_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+#ifdef CONFIG_FANOTIFY_PERM_WATCHDOG
+static LIST_HEAD(perm_group_list);
+static DEFINE_SPINLOCK(perm_group_lock);
+static void perm_group_watchdog(struct work_struct *work);
+static DECLARE_DELAYED_WORK(perm_group_work, perm_group_watchdog);
+static unsigned int perm_group_timeout = 20;
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
+					if (event->pid == failed_pid)
+						continue;
+
+					failed_pid = event->pid;
+					rcu_read_lock();
+					task = find_task_by_pid_ns(event->pid, &init_pid_ns);
+					pr_warn_ratelimited("PID %u (%s) failed to respond to fanotify queue for more than %i seconds\n",
+							    event->pid, task ? task->comm : NULL, perm_group_timeout);
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
+	if (list_empty(&group->fanotify_data.perm_group)) {
+		/* Add to perm_group_list for monitoring by watchdog. */
+		spin_lock(&perm_group_lock);
+		if (list_empty(&perm_group_list))
+			perm_group_watchdog_schedule();
+		list_add_tail(&group->fanotify_data.perm_group, &perm_group_list);
+		spin_unlock(&perm_group_lock);
+	}
+}
+
+#else
+
+static void fanotify_perm_watchdog_group_remove(struct fsnotify_group *group)
+{
+}
+
+static void fanotify_perm_watchdog_group_add(struct fsnotify_group *group)
+{
+}
+
+#endif
+
 /*
  * All flags that may be specified in parameter event_f_flags of fanotify_init.
  *
@@ -210,6 +300,8 @@ static void fanotify_unhash_event(struct fsnotify_group *group,
 	hlist_del_init(&event->merge_list);
 }
 
+
+
 /*
  * Get an fanotify notification event if one exists and is small
  * enough to fit in "count". Return an error pointer if the count
@@ -953,6 +1045,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 				spin_lock(&group->notification_lock);
 				list_add_tail(&event->fse.list,
 					&group->fanotify_data.access_list);
+				FANOTIFY_PERM(event)->pid = current->pid;
 				spin_unlock(&group->notification_lock);
 			}
 		}
@@ -1012,6 +1105,8 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 	 */
 	fsnotify_group_stop_queueing(group);
 
+	fanotify_perm_watchdog_group_remove(group);
+
 	/*
 	 * Process all permission events on access_list and notification queue
 	 * and simulate reply from userspace.
@@ -1464,6 +1559,10 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	fsnotify_group_unlock(group);
 
 	fsnotify_put_mark(fsn_mark);
+
+	if (!ret && (mask & FANOTIFY_PERM_EVENTS))
+		fanotify_perm_watchdog_group_add(group);
+
 	return ret;
 }
 
@@ -1622,6 +1721,9 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	group->fanotify_data.f_flags = event_f_flags;
 	init_waitqueue_head(&group->fanotify_data.access_waitq);
 	INIT_LIST_HEAD(&group->fanotify_data.access_list);
+#ifdef CONFIG_FANOTIFY_PERM_WATCHDOG
+	INIT_LIST_HEAD(&group->fanotify_data.perm_group);
+#endif
 	switch (class) {
 	case FAN_CLASS_NOTIF:
 		group->priority = FSNOTIFY_PRIO_NORMAL;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index fc27b53c58c2..5276fb3ada34 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -272,6 +272,10 @@ struct fsnotify_group {
 			int f_flags; /* event_f_flags from fanotify_init() */
 			struct ucounts *ucounts;
 			mempool_t error_events_pool;
+#ifdef CONFIG_FANOTIFY_PERM_WATCHDOG
+			/* chained on perm_group_list */
+			struct list_head perm_group;
+#endif
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
-- 
2.49.0


