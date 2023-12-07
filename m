Return-Path: <linux-fsdevel+bounces-5078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A6F807D57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 01:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDEF61F2132C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8A156EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvAGigHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD6910C4;
	Wed,  6 Dec 2023 16:28:22 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-5d7b1a8ec90so819167b3.2;
        Wed, 06 Dec 2023 16:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701908901; x=1702513701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtcIT3+1Vvf1IPQzjETz2qs5AIWZRfMHd/0ujKiNxjc=;
        b=AvAGigHsIaQj0KF+YJNWdgVdg/RwkGvr+0yuC2i/nZt2+SC80H5h+7H6yaNJd2/dO+
         dlAWQKSl3PzCem9BgAjIhMdt/eMLI++mI0lV1kzIiruUqqtm/o6Ts5Eq95q4qM2Fr/Dp
         GK3we/jOv+jyLZhGHcAGUwBR/dd5oFVLAycZYLnylxiTOqdo9ZREUp1NGVdrWoj4nhc6
         lokgAyeSVe5BOS/qKYQ1lV4eMUh1MEKct7JCikljgKWWZpU2jcXDBJIXJJOc9SfHK10q
         jzqTLgMVz1Ign/7pDKC5YkZpTY0lUfzlXGwI+pp2YyNf8nKGte43rIFIj24U8/Jr+FwW
         p8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701908901; x=1702513701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtcIT3+1Vvf1IPQzjETz2qs5AIWZRfMHd/0ujKiNxjc=;
        b=hLNUeYrH/HDB6GbuupeJO0cC7vrR5Qecyd3nszZImMpcAQMFY9R1izmrr5SyePVgU7
         8LAyFzIpLJi0b3CRsNQCsoyuyYKElmLiYURtMh2ju95SLqw2OoBo8mJX1zrcWp9GYbZm
         ChlfdyV8BuOq9ohkxh72wDsNSkVpMnUqY2wssNr5VQQ57KBM78GoL++Jc7qyzsRUk6VY
         lZa4tatjLW67a9GwIkGiQ0o9V/W9j4gLwzxC2IXB3Vu7wCg6Ixi1MdFGutopoehvE6jw
         FBZumcrNp7Z3TsS3Y9iPi5qU/GJrRK+8poVhZqxeBxsT81drnTvRneL2j02miruJVBVM
         PNLw==
X-Gm-Message-State: AOJu0YxA/KPQjvM8pzW+0+WPAarGUB9vtMDUGlv83WeVy/SCHWxrGnO8
	EbPPomYRpmwK1p/HEMJrsnSo9es5UDc1
X-Google-Smtp-Source: AGHT+IFoGq3TrZUWxjktHdZLHqPXr2V42GWf5snPEHWFcJWvB6pDjTGUOlR+5ktf6yPv5nEOg/mPRg==
X-Received: by 2002:a05:690c:a06:b0:5d7:1940:8dd5 with SMTP id cg6-20020a05690c0a0600b005d719408dd5mr1208041ywb.60.1701908901467;
        Wed, 06 Dec 2023 16:28:21 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x145-20020a81a097000000b005d82fc8cc92sm19539ywg.105.2023.12.06.16.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:28:21 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
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
	peterz@infradead.org
Subject: [RFC PATCH 06/11] mm/mempolicy: allow home_node to be set by mpol_new
Date: Wed,  6 Dec 2023 19:27:54 -0500
Message-Id: <20231207002759.51418-7-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231207002759.51418-1-gregory.price@memverge.com>
References: <20231207002759.51418-1-gregory.price@memverge.com>
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
 mm/mempolicy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fecdc781b6a0..4be63547a4b3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -311,6 +311,7 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
 	policy->flags = flags;
 	policy->home_node = NUMA_NO_NODE;
 	policy->wil.cur_weight = 0;
+	policy->home_node = args->home_node;
 
 	return policy;
 }
@@ -1624,6 +1625,7 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	args.mode = lmode;
 	args.mode_flags = mode_flags;
 	args.policy_nodes = &nodes;
+	args.home_node = NUMA_NO_NODE;
 
 	return do_set_mempolicy(&args);
 }
@@ -2967,6 +2969,8 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		margs.mode = mpol->mode;
 		margs.mode_flags = mpol->flags;
 		margs.policy_nodes = &mpol->w.user_nodemask;
+		margs.home_node = NUMA_NO_NODE;
+
 		/* contextualize the tmpfs mount point mempolicy to this file */
 		npol = mpol_new(&margs);
 		if (IS_ERR(npol))
@@ -3125,6 +3129,7 @@ void __init numa_policy_init(void)
 	memset(&args, 0, sizeof(args));
 	args.mode = MPOL_INTERLEAVE;
 	args.policy_nodes = &interleave_nodes;
+	args.home_node = NUMA_NO_NODE;
 
 	if (do_set_mempolicy(&args))
 		pr_err("%s: interleaving failed\n", __func__);
@@ -3139,6 +3144,7 @@ void numa_default_policy(void)
 
 	memset(&args, 0, sizeof(args));
 	args.mode = MPOL_DEFAULT;
+	args.home_node = NUMA_NO_NODE;
 
 	do_set_mempolicy(&args);
 }
@@ -3261,6 +3267,8 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	margs.mode = mode;
 	margs.mode_flags = mode_flags;
 	margs.policy_nodes = &nodes;
+	margs.home_node = NUMA_NO_NODE;
+
 	new = mpol_new(&margs);
 	if (IS_ERR(new))
 		goto out;
-- 
2.39.1


