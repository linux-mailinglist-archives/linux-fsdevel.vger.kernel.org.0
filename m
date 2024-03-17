Return-Path: <linux-fsdevel+bounces-14651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F387DF4B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2358D28172A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7727D21373;
	Sun, 17 Mar 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNXpuMYh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186520DE8
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700936; cv=none; b=VOz19UfCV8a3wSXnCfa2GUK5NgacnqI2tbgIIEMymLwmwsW6iTkGxS2p3MxMv106CPZEpoVeRf6y3prPzDigTRyXH/e18AFWfkWVViH78w9/nLRVMT41esg049nCai2l+DDs74JQ3tANkm3nuQYfmGLLseCCiR6LhoaLHG1TWUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700936; c=relaxed/simple;
	bh=rX7xmVRStLhkNd5wHaN+v4sb0YCreMdMKYJ+htFqcrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=beElSW2ZQhsLNAhB0XHRgW/2/L27cdhWXIkeuQDGkFyglms0mz62AESId0puzvBWaH4OfXyCUhs/3TtpzPMPsQ29iZpYV2g2ulx+61KO1mNcB6m+mkag9844o0O551L5cbUzSELMWWozcfbTK82UQfrFnWsWuwfTlwCSIGImGKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNXpuMYh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e162b1b71so3357904f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710700933; x=1711305733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT95zX8R7Zwrvlho7vje0jbMWbCpxDzZYy0Zrphqd40=;
        b=KNXpuMYh1172FhC5XTX5qIQijUw7wqsVZelYi4iwPxzB5NfasJuT40FhLoTBsbVGBS
         dajaWCPFbvTN36qomjjDxn//jIlPule2AwffaHkzzwp+SNoY+joKdlqP9qH7yxqy9oI1
         kuakSG5zTid0FB6rx3j/rLtWIMigTqhN0h1JJbsDoRuKNl5rdYMPmH03XLsVGlM1mQrI
         t7i9kSPbGeAkbq026YGm24GwGPzNbyMKgjX8FOp9fS+lh6WBDs70p8bgm5mNkxYltvRt
         yhafdRPr6QOOzK71qhYJSonACD2wxILhi0zfh8L1/eZoeRQ17HVzfDTlC29wTKLdfmaI
         Jb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700933; x=1711305733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZT95zX8R7Zwrvlho7vje0jbMWbCpxDzZYy0Zrphqd40=;
        b=nDSHYQqQcfLtxP98lvScI+qHXh5BFwujVhRyPCFKQNCMJFGcTXadGKtxn75+u5qDZT
         mWGZXvJyzFOvljikWCco77LgZaRVVJBW40X9lFZJVTq6rG5W04cYz2uyOEgi/YRdjo4a
         vGaGX0EN6eJazNyFSCrmwUVqtz/DtFMn1cwJ5aBAuSeALuaeyL+gCLLh/RiVi7ZpF0Kw
         U2rrrzUrQ5S+SslIYqq5v0BzQ06M0XQycdl6b53VlQxyUrE3maWeCY8R7uy8eOZAmo33
         S6Fo/0M7sK2IskbAA7ZeAXbhK436zNRn+4ZADL/WpH9KbdxrzmsxcA5InnX7mQFAZnG1
         cdGw==
X-Forwarded-Encrypted: i=1; AJvYcCX3O5QVVUYMPTwoAOz//INinACIhRztlS0vEBaj9N63v7iFzxE9TNEJb2Fye9fUtDXuUdhaBFIHHVsiiRaZUWE64qbikMO4dDx3viPwMw==
X-Gm-Message-State: AOJu0Yy1MNMYnrTTIYr1SdgK3UZNo6IcLQ4GEnPKLKoTob0S8LCMO/1L
	64GGSRKfEoI3srnaXIR6x2wf566995Abc8s2BiplZa2StmgfQBrD
X-Google-Smtp-Source: AGHT+IHeENFfvE2LJEVwnoqkPgmNWEmm7J+AmSWR/Mv/v5loHcvEKLIcXVuBOyUWhEfJzFxZrjVAFA==
X-Received: by 2002:a05:6000:246:b0:33e:b1e7:7423 with SMTP id m6-20020a056000024600b0033eb1e77423mr6958281wrz.11.1710700933466;
        Sun, 17 Mar 2024 11:42:13 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm3070716wrb.75.2024.03.17.11.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:42:13 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/10] fsnotify: use an enum for group priority constants
Date: Sun, 17 Mar 2024 20:41:53 +0200
Message-Id: <20240317184154.1200192-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317184154.1200192-1-amir73il@gmail.com>
References: <20240317184154.1200192-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And use meaningfull names for the constants.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 11 +++++------
 include/linux/fsnotify_backend.h   | 20 ++++++++++++--------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ee2b5017d247..9ec313e9f6e1 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1516,13 +1516,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	INIT_LIST_HEAD(&group->fanotify_data.access_list);
 	switch (class) {
 	case FAN_CLASS_NOTIF:
-		group->priority = FS_PRIO_0;
+		group->priority = FSNOTIFY_PRIO_NORMAL;
 		break;
 	case FAN_CLASS_CONTENT:
-		group->priority = FS_PRIO_1;
+		group->priority = FSNOTIFY_PRIO_CONTENT;
 		break;
 	case FAN_CLASS_PRE_CONTENT:
-		group->priority = FS_PRIO_2;
+		group->priority = FSNOTIFY_PRIO_PRE_CONTENT;
 		break;
 	default:
 		fd = -EINVAL;
@@ -1774,12 +1774,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	/*
-	 * group->priority == FS_PRIO_0 == FAN_CLASS_NOTIF.  These are not
-	 * allowed to set permissions events.
+	 * Permission events require minimum priority FAN_CLASS_CONTENT.
 	 */
 	ret = -EINVAL;
 	if (mask & FANOTIFY_PERM_EVENTS &&
-	    group->priority == FS_PRIO_0)
+	    group->priority < FSNOTIFY_PRIO_CONTENT)
 		goto fput_and_out;
 
 	if (mask & FAN_FS_ERROR &&
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index ec592aeadfa3..fc38587d8564 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -176,6 +176,17 @@ struct fsnotify_event {
 	struct list_head list;
 };
 
+/*
+ * fsnotify group priorities.
+ * Events are sent in order from highest priority to lowest priority.
+ */
+enum fsnotify_group_prio {
+	FSNOTIFY_PRIO_NORMAL = 0,	/* normal notifiers, no permissions */
+	FSNOTIFY_PRIO_CONTENT,		/* fanotify permission events */
+	FSNOTIFY_PRIO_PRE_CONTENT,	/* fanotify pre-content events */
+	__FSNOTIFY_PRIO_NUM
+};
+
 /*
  * A group is a "thing" that wants to receive notification about filesystem
  * events.  The mask holds the subset of event types this group cares about.
@@ -201,14 +212,7 @@ struct fsnotify_group {
 	wait_queue_head_t notification_waitq;	/* read() on the notification file blocks on this waitq */
 	unsigned int q_len;			/* events on the queue */
 	unsigned int max_events;		/* maximum events allowed on the list */
-	/*
-	 * Valid fsnotify group priorities.  Events are send in order from highest
-	 * priority to lowest priority.  We default to the lowest priority.
-	 */
-	#define FS_PRIO_0	0 /* normal notifiers, no permissions */
-	#define FS_PRIO_1	1 /* fanotify content based access control */
-	#define FS_PRIO_2	2 /* fanotify pre-content access */
-	unsigned int priority;
+	enum fsnotify_group_prio priority;	/* priority for sending events */
 	bool shutdown;		/* group is being shut down, don't queue more events */
 
 #define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
-- 
2.34.1


