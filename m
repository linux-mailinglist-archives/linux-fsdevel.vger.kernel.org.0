Return-Path: <linux-fsdevel+bounces-60338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09365B45263
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 11:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84EF16EA5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 09:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60EE28642B;
	Fri,  5 Sep 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZuCCrQDK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE522701CF
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062952; cv=none; b=SqSY3/UiL46U5XdprVfugxuIHm037kEgQ3NijSBD+soctm/5nQGjleFTpZXKCEQTHqKw5ez6L9ET5o+1L81JUxLXJpRC0C3AtbaIN+piVkB16NhDX7UUP1U0jcudLOcY/nihA7K5LEe7fr8P5BKf3vI5HiaTJjXuSIzkSXCfJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062952; c=relaxed/simple;
	bh=HkVsUxd8i7iuNGh42viXIYRZPf8l9Ki5QLNRoUyrqhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zw4ef+s+PV6iBDTrbSeF3lVBWFighfgi3wWJLYSovVsP+k51YX4eMgKj0cqwhe4Md41lMKJcJpmOJYLsKAwwyh6IppR6ffbEWSXmKzKLZxYkn9Ux0fBGj5qbVZyCWeeEBRACkqbrLMBlZgYFND3CA+w0xZu5b/4kvfq6223WvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZuCCrQDK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b84367affso16873825e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062948; x=1757667748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmDIFRXAv1xZChIociSBZ0cJ3vqXOut7oWyeaUjJHUk=;
        b=ZuCCrQDK/zZA+BNDojzU1qHF1dD9yqL6T5gzSV61WY+G5sDevhtxhwXUCx9Dx4AgPw
         jMxtkDz0vAk365Ctid6JQTAXSHEwb/S9DgGBWfFlugCqpoaJxetZGlTnDkDOdDNLSzeJ
         MxHVp+AVy+LrNIGV865T8iB1stJeiyYDxynv7Ie6FLY7OpWtISjn1DGAGo1ontBy33wZ
         FmS+LK8NmEZxHmRN20DoeZ6J94SGYUPh7qEQzUryEvzb5NL/bpfDcdMifLvsrukd4fhH
         qqXc6Sv1uRT97cGNRJq5vsxb0EYthpR6JmuFlte2R/YdH+58vfuYxtB4FHcC6mQ7hdgj
         xoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062948; x=1757667748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmDIFRXAv1xZChIociSBZ0cJ3vqXOut7oWyeaUjJHUk=;
        b=BUoyu5I/OH28lKh9CcRvf8LpiiwLN62Rsbrnbom1+PibAE28L4sSFysRdA2qiWaOCg
         BfBvonBn4ODXeHzi/BRlHWtp0UqLKNPXo5m3Vru00iaVN0wkaN0o4HOMT7cGdW6Vpq+/
         y6QdWHxrUqjZ3pCCCAY95waa4mFDsafAKqndri9zIw+HcBmDpGRAdGzBOhEUbEahRQlJ
         JbUlchkj+Eg60j5lDVKYxkkyH/EBBZAKdaU75pJMwcHxxLP5pInWH48eWZoLXVOs29iD
         Mu20C1WyAZziBwhJolahZ7FNUi/QR2R3koTNdU2otJC7uUtGwuysKRGl3idfTRxK2K4C
         th/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhLRlxB9NpJRZfmnqGJybqTTbefRH/OwlWYoNGKVEpU8Mwr3v1b2tR5cS1VmWl5oZspWx8PiOnRUwBUTvT@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjjzsyDHYEIz+VLp8ZrKckzis2iAbWeL7tJDfcgvTC+R6OSRL
	Fpp8L0DGRuXk1RPmpdHM66Kbe6wjTl8xVOOENuHBwH6L9R4GW9NeZe+8HWIBIQ0in74=
X-Gm-Gg: ASbGncvq+vZ+nvMVyrzGtkNn9UEcuqENVxX6WqBzz4j8TDiKn3Qw2+Lc6blXipoFU/h
	3/vB3R6xiedcLJQCWK7i3YpCyIustoS4OuibxpbTtkjwMaQ9vD9D/eVLGwy+av8x3uuNd+Ir/YZ
	KfIlvivB1vC/coHaRDaCliwtaJvlhngqYEWpI7Nkt4QiMPKXcmmlDcsU/oaWYmcEW45XebVPS+7
	5aCLDU46fQ+XZtNFA/VbNtWu7nddGUBA9LZMp6E800XTGS9xd+WzYO7M2/+7az/GQ4r6HCZrYdh
	meiJ7AKtJldY7i1LlU40Nw4UWN26pp3DnbDYsSiS2HreTv0PW3xVlwa42ecYbJwC9rG1i7rOdsZ
	rQjwc9xrHt83AqzF31tm0mdwd0nEYX/Tf8mJ1P1w4TmuRWT2Uzkl0OEdwtA==
X-Google-Smtp-Source: AGHT+IHqK9NaJpjvHLojOBdvStEYEORJxBDgmmtOnmc5YCVGkSBh2N6whpYmOsTcOykBgPN/mHJ4Gw==
X-Received: by 2002:a05:600c:4f50:b0:45b:9c97:af85 with SMTP id 5b1f17b1804b1-45cb50689admr104022495e9.17.1757062948184;
        Fri, 05 Sep 2025 02:02:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfd000dasm35324565e9.5.2025.09.05.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:02:27 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 2/3] fs: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:02:13 +0200
Message-ID: <20250905090214.102375-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090214.102375-1-marco.crivellari@suse.com>
References: <20250905090214.102375-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users.
Make it clear by adding a system_percpu_wq to all the fs subsystem.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 fs/aio.c            | 2 +-
 fs/fs-writeback.c   | 2 +-
 fs/fuse/dev.c       | 2 +-
 fs/fuse/inode.c     | 2 +-
 fs/nfs/namespace.c  | 2 +-
 fs/nfs/nfs4renewd.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7b976b564cfc..747e9b5bba23 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -636,7 +636,7 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
 
 	/* Synchronize against RCU protected table->table[] dereferences */
 	INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
-	queue_rcu_work(system_wq, &ctx->free_rwork);
+	queue_rcu_work(system_percpu_wq, &ctx->free_rwork);
 }
 
 /*
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cc57367fb641..cf51a265bf27 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2442,7 +2442,7 @@ static int dirtytime_interval_handler(const struct ctl_table *table, int write,
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write)
-		mod_delayed_work(system_wq, &dirtytime_work, 0);
+		mod_delayed_work(system_percpu_wq, &dirtytime_work, 0);
 	return ret;
 }
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6dcbaa218b7a..64b623471a09 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -118,7 +118,7 @@ void fuse_check_timeout(struct work_struct *work)
 	    goto abort_conn;
 
 out:
-	queue_delayed_work(system_wq, &fc->timeout.work,
+	queue_delayed_work(system_percpu_wq, &fc->timeout.work,
 			   fuse_timeout_timer_freq);
 	return;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd48e8d37f2e..6a608ea77d09 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1268,7 +1268,7 @@ static void set_request_timeout(struct fuse_conn *fc, unsigned int timeout)
 {
 	fc->timeout.req_timeout = secs_to_jiffies(timeout);
 	INIT_DELAYED_WORK(&fc->timeout.work, fuse_check_timeout);
-	queue_delayed_work(system_wq, &fc->timeout.work,
+	queue_delayed_work(system_percpu_wq, &fc->timeout.work,
 			   fuse_timeout_timer_freq);
 }
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 973aed9cc5fe..0689369c8a63 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -336,7 +336,7 @@ static int param_set_nfs_timeout(const char *val, const struct kernel_param *kp)
 			num *= HZ;
 		*((int *)kp->arg) = num;
 		if (!list_empty(&nfs_automount_list))
-			mod_delayed_work(system_wq, &nfs_automount_task, num);
+			mod_delayed_work(system_percpu_wq, &nfs_automount_task, num);
 	} else {
 		*((int *)kp->arg) = -1*HZ;
 		cancel_delayed_work(&nfs_automount_task);
diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
index db3811af0796..18ae614e5a6c 100644
--- a/fs/nfs/nfs4renewd.c
+++ b/fs/nfs/nfs4renewd.c
@@ -122,7 +122,7 @@ nfs4_schedule_state_renewal(struct nfs_client *clp)
 		timeout = 5 * HZ;
 	dprintk("%s: requeueing work. Lease period = %ld\n",
 			__func__, (timeout + HZ - 1) / HZ);
-	mod_delayed_work(system_wq, &clp->cl_renewd, timeout);
+	mod_delayed_work(system_percpu_wq, &clp->cl_renewd, timeout);
 	set_bit(NFS_CS_RENEWD, &clp->cl_res_state);
 	spin_unlock(&clp->cl_lock);
 }
-- 
2.51.0


