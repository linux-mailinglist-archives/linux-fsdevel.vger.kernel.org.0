Return-Path: <linux-fsdevel+bounces-35022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9F29D003A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 19:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFC22874E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56A1B392C;
	Sat, 16 Nov 2024 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="AwyHfs6h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686531AB52B
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731779975; cv=none; b=hIbIKcRv9RkoUfLfs+SelWVnyH3Cuv3NU3ku37B+wZZPHcFBdWDPwNqh89RnUG5SzheBnT2BRVTB3qACZrykQIe2Ks08YKliMUORooAceKULFPMyyvkv4Ye0YB+DOESq/4c7Bl5UggCRyU/n6hUqWmve5iAM/5Ox4I63EhotS+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731779975; c=relaxed/simple;
	bh=Be/m5c9tfoUPYrD5Iyz2jIKaFcfHV2daIDdNn5l8+1U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtBzZIDrYUaEWbqe+ECvNoQd6yxTwC24c8FpPntgHTUcQLuSqQL4CNhcmzqrhq+C31NiiwgGZ+8l49FEb+ZLAzV6d+ua3sFFlSvfN9OKXqAk43daCoc/9sl8edJkgHnLhnYlV+BfIZFwR02Z0sAkpZrNH+XIREeY/xbtNuHzcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=AwyHfs6h; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1601e853eso50256185a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 09:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731779972; x=1732384772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/iffj9AwrmFtA4v15nvK21qog5xz91IornymITaB6w=;
        b=AwyHfs6hAINkSduR2goN5Of2xtSg8Ji/hthWoNy9rheNU5VVX7b1bkb2815GopI85j
         i7rozMdfigPA70N0kpa9s+vMXTBngO3IBmb1/jOljkIcKVECxWRoQ+9o0mPAml+HFiI5
         PTPDAUrQBhiKDpUqNIVAhepnTiHSfF/pMrbjf7ZOgensFU3m71UejO4jPiTx2z/+4Qc/
         oVL/5nlS5nqgWcY11kDgHI/2TNbfl6pFSI3oVag6YlMSdGg03ouJ+KkLg9oBQ6GzCXBp
         J+E+1CPnVhTvj+G1Pmnbu3Uq8a68WU84bqYRrx9KVb10Yp/cM2EXB/NqC2dkRJOxd2gB
         3RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731779972; x=1732384772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/iffj9AwrmFtA4v15nvK21qog5xz91IornymITaB6w=;
        b=X6Vbn0ZbJUY+554RTzRwVZ26uXE7JA38bvh7NaIktxDUytW9kStzmXJIQiDdceyQ1a
         Pt4fkZs3H4gyQbUSahfk8I5y0TdmwaOqLFP23wrETMgxN3OyzZxQF1l73GLYCPmXHaSb
         HOvNuQN1Dj+UlIxwUjIigbwFWaUreAc4XJw1LHE7GXzco9Iuyb2HGbVsJvup7wbgc78W
         yy2G71g3fUCi07HgTYAF+6BmEAlD91Whaq3YJpb3qyTnnkpYs6l/rKtH8ZK8qikuvX4y
         DYilX9jz7+vaOPTelC92/mD5Dnt098qe6OpafIJoygWLDxUjwgnFg39Xkq0lPMKhIoaX
         m8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoMXXyQezHw1oSm93dMRemWwNXXBjCiqU9Q2iBSbyIN4D22gyXRgIOb7cTiYhrp+rNlafYp2szVuPQ6srw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+Bfj8rLgLYM1zvM0wfXbO00X1ChOjV0p98FXBJySNCrV84+H
	SDGAoKL7/AtgVR4AIi7N3rVOW1/cp9XyfcejxVvMvNYuSN1sH5LSGVJukocUMzs=
X-Google-Smtp-Source: AGHT+IE8nO0AKxOziuoNl9dbDG8TGtYIxbG42IN6xSk4xPBQ4y/OVn6DudmIksQC42h6NfG3SOwe+g==
X-Received: by 2002:a05:620a:3186:b0:7b1:5306:a1ca with SMTP id af79cd13be357-7b3622de46amr1114698785a.36.1731779972207;
        Sat, 16 Nov 2024 09:59:32 -0800 (PST)
Received: from soleen.c.googlers.com.com (51.57.86.34.bc.googleusercontent.com. [34.86.57.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca309d6sm280530085a.94.2024.11.16.09.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 09:59:31 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	derek.kiernan@amd.com,
	dragan.cvetic@amd.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	shuah@kernel.org,
	vegard.nossum@oracle.com,
	vattunuru@marvell.com,
	schalla@marvell.com,
	david@redhat.com,
	willy@infradead.org,
	osalvador@suse.de,
	usama.anjum@collabora.com,
	andrii@kernel.org,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	rientjes@google.com,
	gthelen@google.com
Subject: [RFCv1 5/6] misc/page_detective: enable loadable module
Date: Sat, 16 Nov 2024 17:59:21 +0000
Message-ID: <20241116175922.3265872-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export the missing symbols, and allow page_detective to be built as
a loadable module. This can be make this available in the field, where
Page Detective is loaded only once it is needed.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/misc/Kconfig | 2 +-
 fs/kernfs/dir.c      | 1 +
 kernel/pid.c         | 1 +
 mm/memcontrol.c      | 1 +
 mm/oom_kill.c        | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2965c3c7cdef..b58b4f9567ff 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -495,7 +495,7 @@ config MISC_RTSX
 config PAGE_DETECTIVE
 	depends on PAGE_TABLE_CHECK
 	depends on MEMCG
-	bool "Page Detective"
+	tristate "Page Detective"
 	help
 	  A debugging tool designed to provide detailed information about the
 	  usage and mapping of physical memory pages. This tool operates through
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 458519e416fe..84ad163a4281 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -279,6 +279,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 out:
 	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
 }
+EXPORT_SYMBOL_GPL(pr_cont_kernfs_path);
 
 /**
  * kernfs_get_parent - determine the parent node and pin it
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..89454dc9535e 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -447,6 +447,7 @@ struct task_struct *find_get_task_by_vpid(pid_t nr)
 
 	return task;
 }
+EXPORT_SYMBOL_GPL(find_get_task_by_vpid);
 
 struct pid *get_task_pid(struct task_struct *task, enum pid_type type)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 53db98d2c4a1..389aeec06a04 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -967,6 +967,7 @@ struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
 	rcu_read_unlock();
 	return memcg;
 }
+EXPORT_SYMBOL_GPL(get_mem_cgroup_from_folio);
 
 /**
  * mem_cgroup_iter - iterate over memory cgroup hierarchy
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 4d7a0004df2c..df230a091dcc 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -149,6 +149,7 @@ struct task_struct *find_lock_task_mm(struct task_struct *p)
 
 	return t;
 }
+EXPORT_SYMBOL_GPL(find_lock_task_mm);
 
 /*
  * order == -1 means the oom kill is required by sysrq, otherwise only
-- 
2.47.0.338.g60cca15819-goog


