Return-Path: <linux-fsdevel+bounces-75621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIXgNxPXeGmUtgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:17:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C9F9682E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AE7A3118461
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5C135CB7A;
	Tue, 27 Jan 2026 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA032jrZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C345311596
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526296; cv=none; b=nUiRHcebIkfxjlkaRNHsQxkYBRYQVLTREbavG/BRHK/mezr/2IMjZ1HD1WleK4mTUMY4bc80RBwogPvz4CGqC4lzv6i9uwR2ue9j/X2jX2HbH3XdIjYKHo90w31GPtmE38XEVOfbydC8cFmCiqIP2Nw+n6+Yq2eOsYcgyAa81sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526296; c=relaxed/simple;
	bh=fzAvvFvg2NMOEmxo0qD2egnIC0422shul4ad6BkvdIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sfd7M2o60W0+Q0k/Zrkfv9rHa2+4ZSnOeD9Or5L5/Efd5EW96/dxdfEVe6bcl9ILG/ZC8Xpk3/I2yzF86f/4ItG3zWe8L9x5+AfzfnJYU9fj9PaRgue4z7fV4DKNvqtRX1kGBqEVPTPlOeMErHa/v3VYYxHwNsBXzYjPmOxg/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA032jrZ; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b729f4c154so10109907eec.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769526294; x=1770131094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZVogJ27pgSKdZ5YmHMcdX+mPuBmmbvugZHLoT7NyCA=;
        b=UA032jrZ1Yb4EeTQZKG0x/ZGGaJsOo5k8Vu9sYQ8rmhC6jPTz53t7Be/Bct11F+mUo
         JyVVUYXLM8esu/Xi2g2MIT7Wk6mvTBnCniNtyyHD5TSrepcCHYlGzMO0YxE3u/bMXXLY
         Cf6znNouYnJC75Zlb8WDVJz3dHUy8Xg/QfOcr8+ggP/2EodAN+JC8+EGcaaLOMgioDOx
         GPcDferKBrRhat1KnAfDXVfgSgKZJUJiCtJPV8HCCHwY+y8oagf8nvux6FtBzgW5aIpn
         sv8R7dU6Xu4WdxgzXfiTZE6LwoPJbheozfUj7NF+FeIJY4kymrC5Lx4R4bLthx4r6O0/
         6UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769526294; x=1770131094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZVogJ27pgSKdZ5YmHMcdX+mPuBmmbvugZHLoT7NyCA=;
        b=K6sM2tr0gxvmIGmnxSWtyiAb5qx8VqxEv/cyvtLtLoXoX3i/qNdMf1XaFeMaJRRMve
         LykGg/cWW08BDQg5YynPnrf1K1qBRPJzJ8+qLjnE2msZk5XZhV/uEouw/zI5WHMVhxTw
         Bm47sc2O/KpnPcQ3ax066hlnIUzMGZxw02KRJiLaBONnKqTVUF1IeSvJszMSbQ/sR1ue
         WOsmZoyHa+Lq5rHW3lcB/QCRYfDg+kH0blrloh7i1SLrLdoyS0rmV6c8SjJZV75heqDI
         G3GIW5sysqxad+ubLz/93tXdFeRmf/6Y29DR4Kkz7IP/hR2A2vCwN703z7BKhqROVBEd
         JqDA==
X-Forwarded-Encrypted: i=1; AJvYcCXqGg6xjsBSxKnP6qdP7fgCzFDWzro47In6W3pqUMgjb2acubEz773gePDRnKRelW0qpm3du6RRG+2yheyP@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBKCcplIyhPbYwasQhiIoUMlKkAky62Gh7gIXfZ4OmUk09ESz
	q4VHrG1HufDp8a5zt3sD81/v2ZE90psSbgsbb5u28EFq4+0bvYYCmnFV
X-Gm-Gg: AZuq6aLJ7yCaPd3JYd7oTtr6P3mZlXF4m3aEKl/Vq4UP2/R8i7KOcOOq8zfKbqipX6t
	ZoQYpXZyf6lr/M69V2I96VdOwVSF8E+tZEhxwAOlKrDjuzbFdstThIXC9YJfHEyYcjUx/KuPANE
	mZ1NvqSU6+iEIw73yx8u9clPugpN0qp8E/Ri33Y3OtXIA7/aHRoMIJlpgwNHb2UmBOqbhX1HK7a
	7eQ80mZdGiC/Dglw85m7uE6QMtO8v1NxwhVQjTEXlSVyg8POLrWyv0HlHzDjY1cWztJQP9NfAW3
	/TjWS2t9nEknp85+DW/3jWHodTmytJPYFRD1sCMCcEfqd6OKGWMzJaNUeRjm0foDAUCnIFBqvjJ
	O1Hi9PHvNdYpDL/kxLcjDtqGfRQ1JXJQZ7syytRRX1KRDl3zjnJru2QTOX6Jf+p3AKUqJynTDLd
	TaLpfobczwsFH9EbMKWRZMtME=
X-Received: by 2002:a05:7300:cc12:b0:2b7:1a4a:d564 with SMTP id 5a478bee46e88-2b78da4a239mr1345551eec.42.1769526294106;
        Tue, 27 Jan 2026 07:04:54 -0800 (PST)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6925d3sm17964031eec.7.2026.01.27.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:04:53 -0800 (PST)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: oleg@redhat.com,
	usamaarif642@gmail.com,
	david@kernel.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	alexjlzheng@tencent.com,
	mingo@kernel.org,
	ruippan@tencent.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] procfs: fix missing RCU protection when reading real_parent in do_task_stat()
Date: Tue, 27 Jan 2026 23:04:50 +0800
Message-ID: <20260127150450.2073236-1-alexjlzheng@tencent.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75621-lists,linux-fsdevel=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,kernel.org,linux-foundation.org,oracle.com,tencent.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: 72C9F9682E
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
      rcu_read_lock   <--- Too late!
      task_pid_ptr    <--- UAF!
      rcu_read_unlock

This fix adds proper RCU protection similar to getppid() in kernel/sys.c
which correctly uses rcu_dereference() when accessing current->real_parent.

Fixes: 06fffb1267c9 ("do_task_stat: don't take rcu_read_lock()")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/proc/array.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 42932f88141a..3c2eea2c551a 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -528,7 +528,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		}
 
 		sid = task_session_nr_ns(task, ns);
-		ppid = task_tgid_nr_ns(task->real_parent, ns);
+		rcu_read_lock();
+		ppid = task_tgid_nr_ns(rcu_dereference(task->real_parent), ns);
+		rcu_read_unlock();
 		pgid = task_pgrp_nr_ns(task, ns);
 
 		unlock_task_sighand(task, &flags);
-- 
2.39.3


