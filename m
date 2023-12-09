Return-Path: <linux-fsdevel+bounces-5401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8052F80B287
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 08:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CADB20DE1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 07:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4ACA51;
	Sat,  9 Dec 2023 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkGhhDNE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37FB1994;
	Fri,  8 Dec 2023 22:59:47 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so2900852276.0;
        Fri, 08 Dec 2023 22:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702105187; x=1702709987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fJWjKBdWhZssADuPucbwh57xIICZA8yt0Ti8FZ2CXY=;
        b=JkGhhDNEe7KJuLH8UcKhvnje9xzLzaxjvm4D8RBuCCbsKQU+BFvnoWOG7DJoKCc1oG
         iU2u/NjEiRP7gU5SLHjx8PBLtwE6BC1S6Vwt8Aqas1Iqhz6EG4sN3V18HZ7F7mc5RmF7
         oKeEHBJEPuh2x+3Q9qGMgP55UZHpGHMtPWidqQxIlWyOE84hxQXOMsIOYKmXO/cj1Exn
         ZCgAmlXMne/M4czLx5UtWOXTfZbPifLxaZGUXiSZtTCrtJwb7ZXCk4KjhAp3gnqCr2Dp
         bTIGx0Y2NRl25jm6+XD6xSURKKlo+gBsbVVXIqAM99azbOuvzc3uiN+B/VY9cM8ysO3v
         juoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702105187; x=1702709987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fJWjKBdWhZssADuPucbwh57xIICZA8yt0Ti8FZ2CXY=;
        b=xNW3moEE3NmusDVyZPSb4ympSqzl15Il3p5wbaa76HgskamWKndxnuoomGqcZz0xIA
         omsdTab1SL1RWhs8sXT4oT9P9prRrfjYbkOqhVRb8kbOvMRmOJYXDu6/G/mGKD3ml0NC
         DDY5ThptZalj7/Y4qFvHNWZhpeeMAc2GDYD0463LSuyGcKYHw8liQy/axYFjrtpJ07cX
         M0ZI0SILYk9SprQwe/bItikgTlCwSMYSvoTgySouLkeZdPw+4iSV6bm3CUq6zHy0m32/
         U1loRiicYGwzEPdFujjvoGKHT1z7aTxENbsvu+Rp83Eunf97gaqFqN7Z4pzQoSiSdfmb
         F8SA==
X-Gm-Message-State: AOJu0Yy5/TZEDS3eZO/90akBJ/3CSIQE9QDYAUwlOSMmjioJOu5tXCFI
	WAOF2rSgXI4v540eC5xCCQ==
X-Google-Smtp-Source: AGHT+IHF8XUqVMPhCWme+bTJUc1wnYluDhMFCId+PO64vQhrQCMsy2CrIazKg3YTeo7a1cynsK6z/A==
X-Received: by 2002:a0d:d48c:0:b0:5d3:e835:bd67 with SMTP id w134-20020a0dd48c000000b005d3e835bd67mr948296ywd.41.1702105186764;
        Fri, 08 Dec 2023 22:59:46 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x8-20020a81b048000000b005df5d592244sm326530ywk.78.2023.12.08.22.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 22:59:46 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
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
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: [PATCH v2 06/11] mm/mempolicy: allow home_node to be set by mpol_new
Date: Sat,  9 Dec 2023 01:59:26 -0500
Message-Id: <20231209065931.3458-7-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231209065931.3458-1-gregory.price@memverge.com>
References: <20231209065931.3458-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the plumbing into mpol_new() to allow the argument
structure's home_node field to set mempolicy home node.

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
index ce5b7963e9b5..446167dcebdc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -308,6 +308,7 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
 	policy->flags = flags;
 	policy->home_node = NUMA_NO_NODE;
 	policy->wil.cur_weight = 0;
+	policy->home_node = args->home_node;
 
 	return policy;
 }
@@ -1621,6 +1622,7 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	args.mode = lmode;
 	args.mode_flags = mode_flags;
 	args.policy_nodes = &nodes;
+	args.home_node = NUMA_NO_NODE;
 
 	return do_set_mempolicy(&args);
 }
@@ -2980,6 +2982,8 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		margs.mode = mpol->mode;
 		margs.mode_flags = mpol->flags;
 		margs.policy_nodes = &mpol->w.user_nodemask;
+		margs.home_node = NUMA_NO_NODE;
+
 		/* contextualize the tmpfs mount point mempolicy to this file */
 		npol = mpol_new(&margs);
 		if (IS_ERR(npol))
@@ -3138,6 +3142,7 @@ void __init numa_policy_init(void)
 	memset(&args, 0, sizeof(args));
 	args.mode = MPOL_INTERLEAVE;
 	args.policy_nodes = &interleave_nodes;
+	args.home_node = NUMA_NO_NODE;
 
 	if (do_set_mempolicy(&args))
 		pr_err("%s: interleaving failed\n", __func__);
@@ -3152,6 +3157,7 @@ void numa_default_policy(void)
 
 	memset(&args, 0, sizeof(args));
 	args.mode = MPOL_DEFAULT;
+	args.home_node = NUMA_NO_NODE;
 
 	do_set_mempolicy(&args);
 }
@@ -3274,6 +3280,8 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
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


