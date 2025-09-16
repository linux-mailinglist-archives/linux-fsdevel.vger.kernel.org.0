Return-Path: <linux-fsdevel+bounces-61705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F515B590A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 10:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8361A189D778
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22D22ECD1A;
	Tue, 16 Sep 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NQtZ/ul9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457562EB5C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011382; cv=none; b=hmt5/npc9JMBUVyvzp29p8VyXMkkAEM6n3HgCecpz/e27zAZ+8o7XQdnpUoyKcLGCHiYhPPbyPrPJsh/lugpvbRmPIL3Yl4eYhcq97BXLg9sJtGNbQELO4KER526QLvM6sjrfuB2loUEU7oHJS1gDuk+pexZFBmILk1825MP0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011382; c=relaxed/simple;
	bh=/i+TGxphlbcwtQ06iusDU6Wu8PnYL1IFwfBvQeHM9/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkXXgpCWVP9QEhftN7yRw54P4mVbmTLVROlO3zfFxdyVMkicLlJSpVv0bv6BNfXanr19kDbCRT4L34Oq54Mb+nXLOPm/en6iT4CgCOsn01iZS83MZdpX4Na5wPi4CQSlB4C7+O1frLrY88Fkt8HHTX9SQHcYmGQ+yRsVyw+OZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NQtZ/ul9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e9042021faso1808908f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 01:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758011378; x=1758616178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBilMR31EpsMq6XriB2xtLqKoFrteD6oJai1ocFwypA=;
        b=NQtZ/ul9tHEnvrATlBpnNo5IVupgZK2MTroPP11X6e64n9UX/psg4qwR2aG+5BLKUS
         rXf1M4qw443YtjRDt8pKAYFPVa+MXnfp2g/LzuR7l4P8qJn+m8zUEP91e+l8BrEQkttv
         dqjiW2LBuKwbLf+KmR8UfYGYhjaVH6u/qm51cmK7QG567bRghc0hZyhbXQqxhRgr7k4b
         dvgEuuwsBHnZNCLgDyY6ZdddC1wTzATqlUG/3JA/uB4ZHVVki3H3aLAm4AgGShBadI/Y
         o8hmx26XE8SDdYW9CcU0Gdv8FFxbwPWz8sMV1le1P1x2MyePJhd5tGTw8FcpEyMOyqsp
         GE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758011379; x=1758616179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBilMR31EpsMq6XriB2xtLqKoFrteD6oJai1ocFwypA=;
        b=taB9V3mgS3Ms1miQYWY/Tu+uy0rsO/lwQ7yKieh8yvB+P7ADph6fBWS3uOmIAvbN1+
         fd4s+3ETDnkQjGxMES8zEIeNuPZ84Mu8AXK+P+22Zo25W1+eFE9/jB46Pt0LpjmjVCzx
         TywarFtRK3BSFSLWwn/8jPZKlMm0pwnvymjc8J68HjGMN54KQ31afGrfYA4rTA8GtVca
         PPu9rCfszPCrvcYS+ScVMZVpNcqrUvUncLrPij2nF9/gQTLv8DYHZbUNVhBzKhbfA6gL
         7+iPBgIMizlsruBAnE2d2UHh/t7AO8xT80jx2ES9HTXYtQnCHdUPFpGXSe/US4q2u5b7
         rjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlqnlVUeA+onmEJuWG2PtPmYkOdE1QC7hZfLUjcHUn1lK8e1EzbfHTWxsWksMdQtYX+Fhdt0y7skDNywKC@vger.kernel.org
X-Gm-Message-State: AOJu0YxUA4qKIvmrY8QVhGQR/yNw2EVsF6c6u0ZBqDjWmFPwRwtVVbwK
	jMDirjDfEF13bIrLTqxUU5GBsOcn6rU6LaYiAL5EYIjInZPqpnQXSrOxgNa4F5HB4jg=
X-Gm-Gg: ASbGncsGkmASHSCbs4HXRCnztQcKbPfO7LnxQTL1g2JWZHO2e8a806DMbBTzQ7RUEq2
	z6AVHbZc2xQ0u8Jde3bVPbLOu7jDs55C3irECRJqHgYo7LBpw9MRe1bViLeOAevlz2nDSBsJGn3
	IYjRjHS+OQ6yJE0gbu/NS99lKlOZKNCu84ddM5QvFnEEW/1ZC/mPdhY2M2A59mdZsFxyW0bNShE
	AVLd/ntAac8+k2G3BsXY+e+1tbWlw9giieYzYydTcJqCjmWsB/c1lUYQ0JrETPk1R2qKPzPD7gP
	FrEYJHSquEaHvnNKrvftN3uyeGdO5EGxLDk9WKjQR0nbih7G8lq31jws9N/XiJGoEo2vROw9q4v
	kcs7qEnptcuwc0laoVMOtcQssSL7nCSoRsaqsk+5OTlqqdwQ=
X-Google-Smtp-Source: AGHT+IECcPkK/uCDcwuj6Jp8VaNKrf3F0LNpSEAIH7H9DBNggSNoOwxQSChtkKRsK7+vN0Ie0bYeOA==
X-Received: by 2002:a05:6000:25c8:b0:3ea:dd2b:5dc with SMTP id ffacd0b85a97d-3eadd2b09f0mr5198924f8f.14.1758011378538;
        Tue, 16 Sep 2025 01:29:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e95b111b68sm11006125f8f.32.2025.09.16.01.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:29:38 -0700 (PDT)
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
Subject: [PATCH v2 2/3] fs: replace use of system_wq with system_percpu_wq
Date: Tue, 16 Sep 2025 10:29:05 +0200
Message-ID: <20250916082906.77439-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916082906.77439-1-marco.crivellari@suse.com>
References: <20250916082906.77439-1-marco.crivellari@suse.com>
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
index 7fc7b6221312..6002617f078c 100644
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
index a07b8cf73ae2..21aaed728929 100644
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
index e80cd8f2c049..8520eb94c527 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -119,7 +119,7 @@ void fuse_check_timeout(struct work_struct *work)
 	    goto abort_conn;
 
 out:
-	queue_delayed_work(system_wq, &fc->timeout.work,
+	queue_delayed_work(system_percpu_wq, &fc->timeout.work,
 			   fuse_timeout_timer_freq);
 	return;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 67c2318bfc42..1e044c4f4a00 100644
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
index 7f1ec9c67ff2..f9a3a1fbf44c 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -335,7 +335,7 @@ static int param_set_nfs_timeout(const char *val, const struct kernel_param *kp)
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


