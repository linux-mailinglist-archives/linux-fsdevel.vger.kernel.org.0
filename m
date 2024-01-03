Return-Path: <linux-fsdevel+bounces-7316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E15D823878
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CFDB252B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B435C20DD3;
	Wed,  3 Jan 2024 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyg52bOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349820DCE;
	Wed,  3 Jan 2024 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1d3e6c86868so84051535ad.1;
        Wed, 03 Jan 2024 14:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704321792; x=1704926592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUHKocyjko4JE9NI2Z1eJ5WM6U4OAc9XzLqGoGJ7CFY=;
        b=eyg52bOiw4mTVvjV72SkXROesTBkAlvz+KsCpor4lvz4B6cIxpbt13cSjHEpAhuiRU
         Smjkl+hYd607nyhRQrrqUXSGJE7Nfy8wErEixjnxxaC1ppOvQDjsUPghV6yb+PJE/CLy
         +VFXh8fH8PNsnXen4kQcgzmL5cbMcO4nBf7oahu808lzbFitojaS9RUv/BepwWhtmZyD
         pU3aiJplJh7YH5gBGoLCtMhKbGq8Kty9DtNhxM3VjLTlR3fMOaRwJbIjRMoB7NxDHunM
         vyVHtJfDy+rVYwAFbq2Z6Flo0jiRX3SjAE9XYBcgiMAm6t8pL8OffYAkuKPVbJCgSdjQ
         Xyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321792; x=1704926592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUHKocyjko4JE9NI2Z1eJ5WM6U4OAc9XzLqGoGJ7CFY=;
        b=sS2bGPmjb7+FT6wLmk8yYuzu5ozYcC+xV445wvy3t2kOfHYi3KYyolaixhb4iBFJ3M
         4I/46xZBOd4d9u2nm8k+6p/YnFFZGnKCYNYQLSnTean6GPqYOhhAM9QwVSp3Fe7jb82P
         nSWuSzfiCJcKtxzmQ3uhEPZQHXin1yXokU/BI3mVunUHijNqCUezf+SlePPBWKj294cf
         q9F2PbJ9QtktK+vlY951UmnMkO3pAE3zwt6ey4x2cfqOt5hFp7XWGI7ubUnHWipAFWcu
         1cUANRxSf40wfrqOJnYSvxk0/eVlDX14/PBKNPR8UpnPVv2qujbSaeXazY2Mr+m1D7QK
         pQtA==
X-Gm-Message-State: AOJu0Yx6c5vDTre6FXcbAjeLOgTeWxXfJqHP35vlyjcRM/an8wg9wuou
	tOHp4G3qzp7nbmDG+V9tsA==
X-Google-Smtp-Source: AGHT+IE6dzpobsqtQII2rv9CF4X53MepsPxqTJ4TnvU9EOom4dXLh7CLzaRiTQ2kttaU5pcRlRYB3A==
X-Received: by 2002:a17:902:d503:b0:1d4:576e:91cc with SMTP id b3-20020a170902d50300b001d4576e91ccmr19465094plg.7.1704321792227;
        Wed, 03 Jan 2024 14:43:12 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001d36df58ba2sm24269426plj.308.2024.01.03.14.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:43:11 -0800 (PST)
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
	seungjun.ha@samsung.com,
	Frank van der Linden <fvdl@google.com>
Subject: [PATCH v6 08/12] mm/mempolicy: add userland mempolicy arg structure
Date: Wed,  3 Jan 2024 17:42:05 -0500
Message-Id: <20240103224209.2541-9-gregory.price@memverge.com>
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

This patch adds the new user-api argument structure intended for
set_mempolicy2 and mbind2.

struct mpol_param {
  __u16 mode;
  __u16 mode_flags;
  __s32 home_node;          /* mbind2: policy home node */
  __u16 pol_maxnodes;
  __u8 resv[6];
  __aligned_u64 *pol_nodes;
};

This structure is intended to be extensible as new mempolicy extensions
are added.

For example, set_mempolicy_home_node was added to allow vma mempolicies
to have a preferred/home node assigned.  This structure allows the user
to set the home node at the time mempolicy is created, rather than
requiring an additional syscalls.

Full breakdown of arguments as of this patch:
    mode:         Mempolicy mode (MPOL_DEFAULT, MPOL_INTERLEAVE)

    mode_flags:   Flags previously or'd into mode in set_mempolicy
                  (e.g.: MPOL_F_STATIC_NODES, MPOL_F_RELATIVE_NODES)

    home_node:    for mbind2.  Allows the setting of a policy's home
                  with the use of MPOL_MF_HOME_NODE

    pol_maxnodes: Max number of nodes in the policy nodemask

    pol_nodes:    Policy nodemask

The reserved field accounts explicitly for a potential memory hole
in the structure.

Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst       | 17 +++++++++++++++++
 include/linux/syscalls.h                        |  1 +
 include/uapi/linux/mempolicy.h                  |  9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index a70f20ce1ffb..cbfc5f65ed77 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -480,6 +480,23 @@ closest to which page allocation will come from. Specifying the home node overri
 the default allocation policy to allocate memory close to the local node for an
 executing CPU.
 
+Extended Mempolicy Arguments::
+
+	struct mpol_param {
+		__u16 mode;
+		__u16 mode_flags;
+		__s32 home_node;	 /* mbind2: set home node */
+		__u64 pol_maxnodes;
+		__aligned_u64 pol_nodes; /* nodemask pointer */
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
index fd9d12de7e92..fb0b4b2b9bea 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -74,6 +74,7 @@ struct landlock_ruleset_attr;
 enum landlock_rule_type;
 struct cachestat_range;
 struct cachestat;
+struct mpol_param;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 1f9bb10d1a47..109788c8be92 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -27,6 +27,15 @@ enum {
 	MPOL_MAX,	/* always last member of enum */
 };
 
+struct mpol_param {
+	__u16 mode;
+	__u16 mode_flags;
+	__s32 home_node;	/* mbind2: policy home node */
+	__u16 pol_maxnodes;
+	__u8 resv[6];
+	__aligned_u64 pol_nodes;
+};
+
 /* Flags for set_mempolicy */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
-- 
2.39.1


