Return-Path: <linux-fsdevel+bounces-7315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08324823874
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67782B24EEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A041120B2D;
	Wed,  3 Jan 2024 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXfB9/au"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4C20B1E;
	Wed,  3 Jan 2024 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d43df785c2so29626565ad.1;
        Wed, 03 Jan 2024 14:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704321787; x=1704926587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3MMRetX85ZbA15jPANVawmPvaaHqiRw+Z96q91FHVo=;
        b=TXfB9/auQvbjsB07xSHn3entFn3oHz1t5zaJ3yw4pQ3jHX4xAc9FzP7fd10F8EL9Wf
         jsgIt5/MBihYUDVG4aVJqZBgaHyejw8NuAF2Vr4EG2e9U+tUQVlADkxp7caKmF2ukLDO
         CVNiXcXQKXf0SSmE9okgFNw34/z+Kt8Ngrl+ogZQ+viiXl2p7JlsCxAwap2h3rwqGHdk
         PT2VvrWu+hIsoLSAkI/nLvbUxpJwvpMl1QG8E4C4Zwc4oNKPP9R165+39u5PsVRtxndN
         IytgRVeyNjGm+D70I1aQcbwL7CmkkpqVorXg16QUQ6C62sz4aY3lXM7QBHQzMVX9mxxB
         pjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321787; x=1704926587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3MMRetX85ZbA15jPANVawmPvaaHqiRw+Z96q91FHVo=;
        b=Y3WO7yA51kSGLXVZ1QGXFS1NQy0E8taqDfko3/Ond+NKjIt5G7J08eizfToO/VX6W3
         dX5daAU6LJ6723jL8xqQqMTKpSce+Fj194UPMlNRzBx8/MT6WuxMOqExXahWHQHVqj69
         /fE6F/8pqYV9KVmHd4y5cJ4LIF+IZ53evomVgSj6YsMZiwMgl+fED73FPP5szHb7sfwY
         E4KgEqjHZ20hrx/0vEDR4c+If0zLFxCr4jZ0BKHi3236CLGRMVowh2AiWkZWMOtLsreU
         rhUXz7zs1aC8+c38oDbmKDlj90YjDuCKcDxs/VsvMKkPCD68UMI/ZarO6wEVeLd7V6/e
         DQfA==
X-Gm-Message-State: AOJu0YyUsj1+0lzdi1MCnE57SyqFV4/frPecUzaMQxpZ200vYa7b4fbn
	5bRtFogORt2fZ945421SOQ==
X-Google-Smtp-Source: AGHT+IEk+VNPDcr69ZjxoMb3QEMmNUTZNO2GzmWL5L5QjmMOV28LtEm1X3yzYpnuphwNA+gyM8/kwQ==
X-Received: by 2002:a17:902:db04:b0:1d4:ac2b:7d9 with SMTP id m4-20020a170902db0400b001d4ac2b07d9mr3356598plx.129.1704321787158;
        Wed, 03 Jan 2024 14:43:07 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001d36df58ba2sm24269426plj.308.2024.01.03.14.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:43:06 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: [PATCH v6 07/12] mm/mempolicy: allow home_node to be set by mpol_new
Date: Wed,  3 Jan 2024 17:42:04 -0500
Message-Id: <20240103224209.2541-8-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240103224209.2541-1-gregory.price@memverge.com>
References: <20240103224209.2541-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the plumbing into mpol_new() to allow the argument
structure's home_node field to be set during mempolicy creation.

The syscall sys_set_mempolicy_home_node was added to allow a home
node to be registered for a vma.

For set_mempolicy2 and mbind2 syscalls, it would be useful to add
this as an extension to allow the user to submit a fully formed
mempolicy configuration in a single call, rather than require
multiple calls to configure a mempolicy.

This will become particularly useful if/when pidfd interfaces to
change process mempolicies from outside the task appear, as each
call to change the mempolicy does an atomic swap of that policy
in the task, rather than mutate the policy.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index db290cf540d7..4a566341cf43 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -321,7 +321,7 @@ static struct mempolicy *mpol_new(struct mempolicy_param *param)
 	atomic_set(&policy->refcnt, 1);
 	policy->mode = mode;
 	policy->flags = flags;
-	policy->home_node = NUMA_NO_NODE;
+	policy->home_node = param->home_node;
 	policy->wil.cur_weight = 0;
 
 	return policy;
@@ -1634,6 +1634,7 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	param.mode = lmode;
 	param.mode_flags = mode_flags;
 	param.policy_nodes = &nodes;
+	param.home_node = NUMA_NO_NODE;
 
 	return do_set_mempolicy(&param);
 }
@@ -3002,6 +3003,8 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		mparam.mode = mpol->mode;
 		mparam.mode_flags = mpol->flags;
 		mparam.policy_nodes = &mpol->w.user_nodemask;
+		mparam.home_node = NUMA_NO_NODE;
+
 		/* contextualize the tmpfs mount point mempolicy to this file */
 		npol = mpol_new(&mparam);
 		if (IS_ERR(npol))
@@ -3160,6 +3163,7 @@ void __init numa_policy_init(void)
 	memset(&param, 0, sizeof(param));
 	param.mode = MPOL_INTERLEAVE;
 	param.policy_nodes = &interleave_nodes;
+	param.home_node = NUMA_NO_NODE;
 
 	if (do_set_mempolicy(&param))
 		pr_err("%s: interleaving failed\n", __func__);
@@ -3174,6 +3178,7 @@ void numa_default_policy(void)
 
 	memset(&param, 0, sizeof(param));
 	param.mode = MPOL_DEFAULT;
+	param.home_node = NUMA_NO_NODE;
 
 	do_set_mempolicy(&param);
 }
@@ -3296,6 +3301,8 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	mparam.mode = mode;
 	mparam.mode_flags = mode_flags;
 	mparam.policy_nodes = &nodes;
+	mparam.home_node = NUMA_NO_NODE;
+
 	new = mpol_new(&mparam);
 	if (IS_ERR(new))
 		goto out;
-- 
2.39.1


