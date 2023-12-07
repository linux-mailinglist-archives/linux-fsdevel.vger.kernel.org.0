Return-Path: <linux-fsdevel+bounces-5079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B3807D58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 01:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEFA1F217A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966081DDDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP7qpTDd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9EE13E;
	Wed,  6 Dec 2023 16:28:25 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5d7346442d4so931647b3.2;
        Wed, 06 Dec 2023 16:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701908904; x=1702513704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0dcKZM4xykmRW4Z1VxrCBsarnvE5RiRnBwkKf2wOH0=;
        b=MP7qpTDd42i3+X1wWD08FnwJh9hBqmipTZUjnxTTObfL8GcgxDTx0+dEgPySXE9MCW
         oiDWfwAzxf4ITz3pkRt1wnKxtyffaTsAZgqS/u0ElKMapMYdsSsQK1qldNjQPEMGJ0Qv
         5vLzNdRhz2yDyO2IeRQy18wW9ZhPkoHTHrbN7atoE90fxY8WxRPQi8urdXKlrWtaDdUz
         arMc85NQ1fQYg6n41h4WyBucuJt72LtHE6xkk/Ww4us+6XjL++IykVUgsrrco0dLE+Or
         ZLvj1miRXyImAXGtKjXbNwnnA4C1PbMd+AMYoiLIHw1O0Ts0krG7XSRPrE5D+tyDrvrq
         5+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701908904; x=1702513704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0dcKZM4xykmRW4Z1VxrCBsarnvE5RiRnBwkKf2wOH0=;
        b=o7SBneQDaO2OXB9Lq0Urp0GYwGjqvTaB1Luv2C5LH/XNA4DGDvLoJg8HPq4HutXWm5
         quhk8mLQhQA+ZD4XzfEK+2b69N7jLCuWYAsCJz0EjgOav+yBVixv/kOL3tjx6W72p6DD
         5Q6jkTwOgR+Y+jPksRZxAlT0k31ky1NGbrmsyEtgIAEswB77EE7xF3RpyWa1TDbtjwUM
         Av/XPO8gBQaEO+XHaxXfJrdHr2QFsWDcxJLSWy5JVJXehaG3dsKxGDdG96Af0scQTbqY
         dwW5TsLSPR3pN69u4JG2PBBdkOlb5Vba5HrR5kEg4s5rfZCY/T18uH9ZRWe4IsV8ZJAE
         fN/A==
X-Gm-Message-State: AOJu0YwamUd11uhE+vlS61n3WpakgHfInv8HylJ3bUROJ3gXSJMID+WI
	3pRj5wpUpwFyAjglqiLOUg==
X-Google-Smtp-Source: AGHT+IH3qdQO+H6tz7LttRhtaO2S467jx5TIEBNtqBVkQzcZpaHW+4VWRuHrPbNijy64FV0MlLAD7w==
X-Received: by 2002:a81:498c:0:b0:5d3:9f4d:dae0 with SMTP id w134-20020a81498c000000b005d39f4ddae0mr1770101ywa.24.1701908903550;
        Wed, 06 Dec 2023 16:28:23 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x145-20020a81a097000000b005d82fc8cc92sm19539ywg.105.2023.12.06.16.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:28:23 -0800 (PST)
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
	peterz@infradead.org,
	Frank van der Linden <fvdl@google.com>
Subject: [RFC PATCH 07/11] mm/mempolicy: add userland mempolicy arg structure
Date: Wed,  6 Dec 2023 19:27:55 -0500
Message-Id: <20231207002759.51418-8-gregory.price@memverge.com>
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

This patch adds the new user-api argument structure intended for
set_mempolicy2 and mbind2.

struct mpol_args {
  /* Basic mempolicy settings */
  unsigned short mode;
  unsigned short mode_flags;
  unsigned long *pol_nodes;
  unsigned long pol_maxnodes;

  /* get_mempolicy2: policy information (e.g. next interleave node) */
  int policy_node;

  /* get_mempolicy2: memory range policy */
  unsigned long addr;
  int addr_node;

  /* all operations: policy home node */
  unsigned long home_node;

  /* mbind2: address ranges to apply the policy */
  const struct iovec __user *vec;
  size_t vlen;
};

This structure is intended to be extensible as new mempolicy extensions
are added.

For example, set_mempolicy_home_node was added to allow vma mempolicies
to have a preferred/home node assigned.  This structure allows the
addition of that setting at the time the mempolicy is set, rather
than requiring additional calls to modify the policy.

Another suggested extension is to allow mbind2 to operate on multiple
memory ranges with a single call. mbind presently operates on a single
(address, length) tuple. It was suggested that mbind2 should operate
on an iovec, which allows many memory ranges to have the same mempolicy
applied to it with a single system call.

Full breakdown of arguments as of this patch:
    mode:         Mempolicy mode (MPOL_DEFAULT, MPOL_INTERLEAVE)

    mode_flags:   Flags previously or'd into mode in set_mempolicy
                  (e.g.: MPOL_F_STATIC_NODES, MPOL_F_RELATIVE_NODES)

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

    vec/vlen:     Used by mbind2 to apply the mempolicy to all
                  address ranges described by the iovec.

Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     | 31 +++++++++++++++++++
 include/uapi/linux/mempolicy.h                | 18 +++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index b7b8d3dd420f..6d645519c2c1 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -488,6 +488,37 @@ closest to which page allocation will come from. Specifying the home node overri
 the default allocation policy to allocate memory close to the local node for an
 executing CPU.
 
+Extended Mempolicy Arguments::
+
+	struct mpol_args {
+		/* Basic mempolicy settings */
+		unsigned short mode;
+		unsigned short mode_flags;
+		unsigned long *pol_nodes;
+		unsigned long pol_maxnodes;
+
+		/* get_mempolicy2: policy node information */
+		int policy_node;
+
+		/* get_mempolicy2: memory range policy */
+		unsigned long addr;
+		int addr_node;
+
+		/* mbind2: policy home node */
+		unsigned long home_node;
+
+		/* mbind2: address ranges to apply the policy */
+		struct iovec *vec;
+		size_t vlen;
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
index 1f9bb10d1a47..e6b50903047c 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -27,6 +27,24 @@ enum {
 	MPOL_MAX,	/* always last member of enum */
 };
 
+struct mpol_args {
+	/* Basic mempolicy settings */
+	unsigned short mode;
+	unsigned short mode_flags;
+	unsigned long *pol_nodes;
+	unsigned long pol_maxnodes;
+	/* get_mempolicy: policy node information */
+	int policy_node;
+	/* get_mempolicy: memory range policy */
+	unsigned long addr;
+	int addr_node;
+	/* mbind2: policy home node */
+	int home_node;
+	/* mbind2: address ranges to apply the policy */
+	struct iovec *vec;
+	size_t vlen;
+};
+
 /* Flags for set_mempolicy */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
-- 
2.39.1


