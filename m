Return-Path: <linux-fsdevel+bounces-75702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFixMWvJeWkezgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:31:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C3F9E38A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D23FB301703E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 08:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA75A30FC39;
	Wed, 28 Jan 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO1jMpWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126362EE611
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589013; cv=none; b=MI/wYWbdGOTyY7+Ok2xZmLJxUBKePT8CHYFx8CAQ39L/T7EikSdMk/H1761IpN8ULTIe2WLShDVEaOhwA+TS9MdZ2dIS7mk5uH2P/sHwgGWkMc9FlkFAI6wf3ZKCMHOKYw9brFZWIme42LZXKwXQn5bHkJu4wxGDi8xR76VGADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589013; c=relaxed/simple;
	bh=i7jIMtgn5v7k2mHdb0BICegbJX4JV3eIH5WClHRS1vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1VcFhj0w5KR2c+OA8UBpjLiHrIh2DfaMxB9GY4AmfaS/U85G0JcDsTqBML4Ml7T9c4teEvXI9iU2hWp0Vtb8BJEjkcsy8msV96Qvj6N5jjC4n83yKRH5sbtQeN0FIPEymhIkZrWMLM1S/etmG1G45xTXv0G8hQdp6S8y/KAgkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO1jMpWX; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-11f36012fb2so9364504c88.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769589011; x=1770193811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWNDXOn4e3ISKUfrp4YI7kPUB09IKnTiOMAEzDBRtkg=;
        b=cO1jMpWXOrxr8Lok2WclqSPtn2IfZUmiR5LCksNoHWTvJJgKxmqW4bpNn7BZPi2TSe
         FQspOQHTiKpHEXDey44xKcutCJBaCDbQbkSI+VY287+JUv6g4/Ro/i/6XXCKHQ9ZasLs
         MxmgRjH5bsxs16KLeHfRryuM251P3AOVMMW/ZScIniZj0WgMQ5InS3bY/nUb0B0iJyBk
         tzoD1UPq/IPrMLDPCu7FPSWr9AzK9+BBW+pZLPO1akDt56jXfWlbltSBXsy2MQk845Zz
         fmZTEIV5qISTvJ6AYeAVxCXErWZHfoeyjFDHkQEOmSQhblzMfZbwzN9wRmX8C+JafDc8
         QCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769589011; x=1770193811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWNDXOn4e3ISKUfrp4YI7kPUB09IKnTiOMAEzDBRtkg=;
        b=Fw8FB2cC2fcMpjB1eZiAH66iX3eJ6l5gJkhLDWHqmZnkuSwMLmDLJ5+M4empy806N8
         lIBriu+CyCeoTkbiJckrwP+CvpmvmRRvlZDVTwQ/hxTN6HKyYA5pCGUW7VQJ6Td96gXL
         7sBPmS/9pTZxoBx/PLaJjTL9Pppu/Bcf48tg+S738gajcfA6A9EJ11yGXlw1Azoa3GYQ
         XAQQpfP2uut3vNbCQ/nRf5xuVxWBMlHH8ppbSHHQWBjYCUb/LilNAPXyuRMRAy7g9AnE
         FgK5BtaWAmECsDv3SdUqIVWdTRl007N+m/v7GF5tnK1JXX30fpabdJgaz8/KyrYvizFt
         XSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2VXDHpjf5Hc3cRakF3r3aSkbgEpuP24v3z37+tNQGnH5zIOj3N7po1hZKS0N9ofi/8Xc9keJpWmX6mbXo@vger.kernel.org
X-Gm-Message-State: AOJu0YyjqyXsDZojH4c2PBGh8P8ox9z1j23uXy/Ko8iUrdpvaaVtIulj
	SwLN7lUqnvXy01N6/s5t1DoXXh0K9Nll/3onjaX6hwprFamMQVczpFOM
X-Gm-Gg: AZuq6aIf2K6OsLO2TUQ6wwqXfVYEvjihws5GNNiFUQ1IODiLWMuMTiuDp0xzeUPbDvE
	W66g+gtVbhu1ZzR1P4uG0MzfJjxZPewDG8Y0hiJaqcwrmrN9WxdwNaCQFPW76P3lTxG6UbhW0cx
	3EpZLomgPJ49IMaYUAH1mNzrTUd7Jw8bXTSsT/roIaHWcGl5QHk7Zw2Vel5z0TE8PtArFRRWwTJ
	+4e94Bd0cxHZ/kdbpL/f5qWkksmY7PTu6ZzjkLi1vtUPNAiksb0gvvOfA5grhJtu5qyFz6Lf5JM
	L/oDZJ2Ki6iBqjAmWEqXONzQfZPwcqonPj/gLv7S1lM0f8tt1rKKpfdoFZWXHduUDzE/fd4KQ6Y
	d8leQsIthhDE3iyu9h1zbHICq1zOX/jdc6/JVZxYF4zwoZ+txVE0Rbzfxx8IJDlxufE4TdFEk1a
	TilTSVBReBWlXFPqxC2CEjp6TPrAR8XFQPJw==
X-Received: by 2002:a05:7022:b90:b0:119:e56b:91da with SMTP id a92af1059eb24-124a006e3b7mr2906966c88.11.1769589010506;
        Wed, 28 Jan 2026 00:30:10 -0800 (PST)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe938sm1750841eec.16.2026.01.28.00.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 00:30:09 -0800 (PST)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: oleg@redhat.com,
	usamaarif642@gmail.com,
	david@kernel.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	mingo@kernel.org,
	alexjlzheng@tencent.com,
	ruippan@tencent.com,
	mjguzik@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] procfs: fix missing RCU protection when reading real_parent in do_task_stat()
Date: Wed, 28 Jan 2026 16:30:07 +0800
Message-ID: <20260128083007.3173016-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75702-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,kernel.org,linux-foundation.org,oracle.com,tencent.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,linux-fsdevel@vger.kernel.org]
X-Rspamd-Queue-Id: 27C3F9E38A
X-Rspamd-Action: no action

From: Jinliang Zheng <alexjlzheng@tencent.com>

When reading /proc/[pid]/stat, do_task_stat() accesses task->real_parent
without proper RCU protection, which leads:

  cpu 0                               cpu 1
  -----                               -----
  do_task_stat
    var = task->real_parent
                                      release_task
                                        call_rcu(delayed_put_task_struct)
    task_tgid_nr_ns(var)
      rcu_read_lock   <--- Too late to protect task->real_parent!
      task_pid_ptr    <--- UAF!
      rcu_read_unlock

This patch use task_ppid_nr_ns() instead of task_tgid_nr_ns() to adds
proper RCU protection for accessing task->real_parent.

Fixes: 06fffb1267c9 ("do_task_stat: don't take rcu_read_lock()")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
changelog:

v2: - use task_ppid_nr_ns(), suggested by Oleg Nesterov
    - clear commit message

v1: https://lore.kernel.org/linux-fsdevel/20260127150450.2073236-1-alexjlzheng@tencent.com/
---
 fs/proc/array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 42932f88141a..5571177e0435 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -528,7 +528,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		}
 
 		sid = task_session_nr_ns(task, ns);
-		ppid = task_tgid_nr_ns(task->real_parent, ns);
+		ppid = task_ppid_nr_ns(task, ns);
 		pgid = task_pgrp_nr_ns(task, ns);
 
 		unlock_task_sighand(task, &flags);
-- 
2.49.0


