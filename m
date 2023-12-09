Return-Path: <linux-fsdevel+bounces-5403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BF880B28C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 08:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF261F211C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 07:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5512A3FF4;
	Sat,  9 Dec 2023 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEJuVWm9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C9719AC;
	Fri,  8 Dec 2023 22:59:56 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 6a1803df08f44-67adac40221so18310316d6.2;
        Fri, 08 Dec 2023 22:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702105195; x=1702709995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jpJNV10Y4Aq3La+SspO/hMcopvAOMbrsn8P/kGKMEU=;
        b=nEJuVWm9ToQyex+z6jFKMTLatqoMtbPQIl5prMit2E/NVm8EWHIUytJNBKYY+McwLX
         XVd3B4QVCDPkNXyjVkcS2ihPPV5Lg4tsAj4608p7blqgIQ1V0WgfqCYqRsjVbVvzSAnx
         BMJqglHYiFkZPXsIrYUqTrVdjspIl6aHoo7xfY77QMRGekkFsXvdh5EPtFZ50LavXaFt
         tvUqvZrqEg1trihThRi1e+SGCFPAXWw+1LeujEn+nmR0vXYxzIjxf1Cj6r2G513ioJ50
         xUdNFnOzauGfbS8U2vQH5LJkp8hEmuLpBPfEsNvXwSdCINig3+Pkt+r2uc+HvIw4EBWv
         +bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702105195; x=1702709995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jpJNV10Y4Aq3La+SspO/hMcopvAOMbrsn8P/kGKMEU=;
        b=RN49pTpSrhrFqB8DMYT3PJnWUIEYOTIEHvsOiRp2VnQhcK96hFnB1Wi45QpEwvHODD
         0U0OwGXWgPd/ILAmb7QnLFYwVS683k5nMHytsfBvsNEfuZN5NUsoC+bx6/IVSH++7cIW
         4E4pt38nMO4tm0obVfn4S/tJ3n5K87OPjq//4ihgA+s4LqulZNu/O8/AQFytZeVx2O/I
         37yvBE+vL+kjIGmz1t5sO91DMwjlhM32TB1/MMY1TlmOBLKU0PXCP5xgSSpfTxnHMR2i
         wd7GEmctYZsOFAkSLYv/9ne0WynF3PJErZoUzn76wYk/qI2/iDS1YfPDSSXoWqypvGU2
         AvQQ==
X-Gm-Message-State: AOJu0YzwC/Ekalt84X4tRs4Z/hZtWeXSUzM3L+NoSxrO9+bP95Lmj3h3
	2qOjFEowPPw9eU0tF0mtxw==
X-Google-Smtp-Source: AGHT+IGq7B5WE+Xyw4YblcWAaIb3zQDtffG9M6pUeoRlky0GQTbpT4Cg4FD2j38+EVMPor4kTHolGw==
X-Received: by 2002:a05:620a:2a10:b0:77f:3161:9147 with SMTP id o16-20020a05620a2a1000b0077f31619147mr1748373qkp.19.1702105195576;
        Fri, 08 Dec 2023 22:59:55 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x8-20020a81b048000000b005df5d592244sm326530ywk.78.2023.12.08.22.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 22:59:55 -0800 (PST)
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
	seungjun.ha@samsung.com,
	Frank van der Linden <fvdl@google.com>
Subject: [PATCH v2 07/11] mm/mempolicy: add userland mempolicy arg structure
Date: Sat,  9 Dec 2023 01:59:27 -0500
Message-Id: <20231209065931.3458-8-gregory.price@memverge.com>
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

This patch adds the new user-api argument structure intended for
set_mempolicy2 and mbind2.

struct mpol_args {
  __u16 mode;
  __u16 mode_flags;
  __s32 home_node;          /* mbind2: policy home node */
  __aligned_u64 *pol_nodes;
  __u64 pol_maxnodes;
  __u64 addr;     /* get_mempolicy: policy address */
  __s32 policy_node;        /* get_mempolicy: policy node info */
  __s32 addr_node;          /* get_mempolicy: memory range policy */
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

    addr:         for get_mempolicy2.  Used with MPOL_F_ADDR to run
                  get_mempolicy against the vma the address belongs
                  to instead of the task.

    addr_node:    for get_mempolicy2.  Returns the node the address
                  belongs to.  Previously get_mempolicy() would
                  override the output value of (mode) if MPOL_F_ADDR
                  and MPOL_F_NODE were set.  Instead, we extend
                  mpol_args to do this by default if MPOL_F_ADDR is
                  set and do away with MPOL_F_NODE.

Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     | 20 +++++++++++++++++++
 include/uapi/linux/mempolicy.h                | 12 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index d2c8e712785b..64c5804dc40f 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -482,6 +482,26 @@ closest to which page allocation will come from. Specifying the home node overri
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
+		__u64 addr; /* get_mempolicy2: policy address */
+		__s32 policy_node; /* get_mempolicy2: policy node information */
+		__s32 addr_node; /* get_mempolicy2: memory range policy */
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
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 1f9bb10d1a47..00a673e30047 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -27,6 +27,18 @@ enum {
 	MPOL_MAX,	/* always last member of enum */
 };
 
+struct mpol_args {
+	/* Basic mempolicy settings */
+	__u16 mode;
+	__u16 mode_flags;
+	__s32 home_node;	/* mbind2: policy home node */
+	__aligned_u64 pol_nodes;
+	__u64 pol_maxnodes;
+	__u64 addr;
+	__s32 policy_node;	/* get_mempolicy: policy node info */
+	__s32 addr_node;	/* get_mempolicy: memory range policy */
+};
+
 /* Flags for set_mempolicy */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
-- 
2.39.1


