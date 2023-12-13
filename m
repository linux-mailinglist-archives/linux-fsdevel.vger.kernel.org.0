Return-Path: <linux-fsdevel+bounces-6013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D1E8121C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C100A28297A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 22:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046DD83B05;
	Wed, 13 Dec 2023 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK60BwgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE3116;
	Wed, 13 Dec 2023 14:41:35 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5df49931b4eso52462627b3.0;
        Wed, 13 Dec 2023 14:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507294; x=1703112094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHAGnEescBI+H6+nuN2AFaKvkx/2sXtk6C+MWO0ta0k=;
        b=VK60BwgVqQiBxKvd1P+gGHeDjoE9o4L7xq89cbuK70w6DQCySpRwb+KQjUE7uUL0nS
         FpqSQDlmrZV3s6v+kZ+hh01Lr5Cn7Xf3X4PrEc909HMBBtwtadXWIP0k9DdqBgOZdqp7
         QM7y+EYgSjtsyypZXf5RGZK87UCPqR105wGpnZywi1XeYRwGl/lB6p3BivhlDKaWCkeo
         0bRBEdKwT3L6lKJ/hazAPyWX2yzepbscKgIvbMbsT1EaSso/g/Rdn0gO2K4bCt/WWJFZ
         c9NOPUoa2EWGnlJVtZJXTTFVtTGF6H9y9Rk+C7dEC8RPsIm4XVNckXsUz6ox2Cjq2Gvm
         a8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507294; x=1703112094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHAGnEescBI+H6+nuN2AFaKvkx/2sXtk6C+MWO0ta0k=;
        b=eoBeiphcAraLm3n90l3hL6RVF7ogkM1cBp+4FxPNcQut1cYICtkmkfnlWhQHLnVhaF
         5gGR2uyq6/U3rrclhxdXPcZ6Ryo5Gg1PMjOJUs3etQQOUE2dTCuilTHFueHptaUBwh+h
         Heq1CmODnjHVfG/XaQEGIk9MMA7P1rebAidu5lDoMZfz1eRUv1fqyqQjVifIwFhgTCxG
         Pu0D7O3uWgzZUGxm06l0E4C0NTsWFge/elmq3Kx+O+jmnTifYkGLKo2qCtUxT1po1hSn
         2wySB2pH1dy+CXbZyYORQoX19WR/IfjDqWNOYfNllq/pfDDNC36xVz5AzvfvmfmF313j
         A4nQ==
X-Gm-Message-State: AOJu0Yz1rPGyN+9oRusb3Tua4rxXg6TtevvIce3Tmu7jqRa+6Vhcz4eI
	WaIrND7ZPTLWOjX+y+QYOA==
X-Google-Smtp-Source: AGHT+IHv8R9NV6IS3UqqyJCLRcWVS5tclufBAtomZYU4IMmZrtJVZjzPrW9IV8ffm6eLgXls8r0k+g==
X-Received: by 2002:a81:5b85:0:b0:5cd:c65c:8173 with SMTP id p127-20020a815b85000000b005cdc65c8173mr8014732ywb.10.1702507294578;
        Wed, 13 Dec 2023 14:41:34 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm5050583ywf.42.2023.12.13.14.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:41:34 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
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
	seungjun.ha@samsung.com,
	Frank van der Linden <fvdl@google.com>
Subject: [PATCH v3 07/11] mm/mempolicy: add userland mempolicy arg structure
Date: Wed, 13 Dec 2023 17:41:14 -0500
Message-Id: <20231213224118.1949-8-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231213224118.1949-1-gregory.price@memverge.com>
References: <20231213224118.1949-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the new user-api argument structure intended for
set_mempolicy2 and mbind2.

struct mpol_args {
  __u16 mode;
  __u16 mode_flags;
  __s32 home_node;          /* mbind2: policy home node */
  __aligned_u64 *pol_nodes;
  __u64 pol_maxnodes;
  __s32 policy_node;        /* get_mempolicy: policy node info */
};

This structure is intended to be extensible as new mempolicy extensions
are added.

For example, set_mempolicy_home_node was added to allow vma mempolicies
to have a preferred/home node assigned.  This structure allows the
addition of that setting at the time the mempolicy is set, rather
than requiring additional calls to modify the policy.

Full breakdown of arguments as of this patch:
    mode:         Mempolicy mode (MPOL_DEFAULT, MPOL_INTERLEAVE)

    mode_flags:   Flags previously or'd into mode in set_mempolicy
                  (e.g.: MPOL_F_STATIC_NODES, MPOL_F_RELATIVE_NODES)

    home_node:    for mbind2.  Allows the setting of a policy's home
                  with the use of MPOL_MF_HOME_NODE

    pol_nodes:    Policy nodemask

    pol_maxnodes: Max number of nodes in the policy nodemask

    policy_node:  for get_mempolicy2.  Returns extended information
                  about a policy that was previously reported by
                  passing MPOL_F_NODE to get_mempolicy.  Instead of
                  overriding the mode value, simply add a field.

Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst      | 18 ++++++++++++++++++
 include/linux/syscalls.h                       |  1 +
 include/uapi/linux/mempolicy.h                 | 10 ++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index d2c8e712785b..d5fcebdd7996 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -482,6 +482,24 @@ closest to which page allocation will come from. Specifying the home node overri
 the default allocation policy to allocate memory close to the local node for an
 executing CPU.
 
+Extended Mempolicy Arguments::
+
+	struct mpol_args {
+		__u16 mode;
+		__u16 mode_flags;
+		__s32 home_node; /* mbind2: policy home node */
+		__aligned_u64 pol_nodes; /* nodemask pointer */
+		__u64 pol_maxnodes;
+		__s32 policy_node; /* get_mempolicy2: policy node information */
+	};
+
+The extended mempolicy argument structure is defined to allow the mempolicy
+interfaces future extensibility without the need for additional system calls.
+
+The core arguments (mode, mode_flags, pol_nodes, and pol_maxnodes) apply to
+all interfaces relative to their non-extended counterparts. Each additional
+field may only apply to specific extended interfaces.  See the respective
+extended interface man page for more details.
 
 Memory Policy Command Line Interface
 ====================================
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fd9d12de7e92..a52395ca3f00 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -74,6 +74,7 @@ struct landlock_ruleset_attr;
 enum landlock_rule_type;
 struct cachestat_range;
 struct cachestat;
+struct mpol_args;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 1f9bb10d1a47..c06f2afa7fe3 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -27,6 +27,16 @@ enum {
 	MPOL_MAX,	/* always last member of enum */
 };
 
+struct mpol_args {
+	/* Basic mempolicy settings */
+	__u16 mode;
+	__u16 mode_flags;
+	__s32 home_node;	/* mbind2: policy home node */
+	__aligned_u64 pol_nodes;
+	__u64 pol_maxnodes;
+	__s32 policy_node;	/* get_mempolicy: policy node info */
+};
+
 /* Flags for set_mempolicy */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
-- 
2.39.1


