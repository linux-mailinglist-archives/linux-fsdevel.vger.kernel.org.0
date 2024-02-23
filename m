Return-Path: <linux-fsdevel+bounces-12596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624C861A23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C041B1F23C89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BECF13A26C;
	Fri, 23 Feb 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEmqD/VE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707D12FB30;
	Fri, 23 Feb 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710141; cv=none; b=k0wa853Gf/xRy/+o3uXl9mI7ChLVTLxL0PbECB359sMGyTVKB3l++v7zgtvBVONukANeWk+WyZJnfOupoxr4LUqCuaLvpIWZeFhhRaVBLBUn3iM2UxE4NIzQ7IDZCIiiUxxacKDpjiUyCrQIav8/wtWp0xX/0bqg/nppOJOCLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710141; c=relaxed/simple;
	bh=GoMsVLjZ2QsC8jpJba4e1MZuvUQxhdOSn97WPVZGJsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcDHWMjKocAiKzCnf9m/12WdwTdZ84oCLAOwf5aTQYCjbKlUvHW/lAJFxKzha9/Jc1c1Cw2YVYB9gSAL2sT9RycVoUf+//jFwhm9p21ddkLP8Dawc30bIcJJnhcCyqWtz2uhOQEb95wi55VnJctSrpj6+ujMBoqGjQu7DUP1hpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEmqD/VE; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21f996af9bdso224991fac.2;
        Fri, 23 Feb 2024 09:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710139; x=1709314939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8CWGVS5oYo9Xv5uGh2hBH5hNaU6W6dhr1j9gGPoJgA=;
        b=GEmqD/VEWtjsFRvncfHYUIc4c4A6W/QwIh7TZDE2bsce0j8tLDnCsQMFYywgSJ9GcG
         pg2bjzCP+RTC0P2g9gCY5Bc9ghPFjpMxL5jnqZEJYeEFebqji0xAtzGToLHevmisfsX/
         phZGIvAYdawpVCwytxoXD8Jkzd4ZYdJ+taDDMuuqV6N4ZgJmA4F4rCdTLuOITIOYO8Af
         2rkNu9djhUrXe1kvl6K9J8gBNF31WCfY+rbI7/Jc9ta/BPsajbrm9i++CGUw2eRhXcK2
         wsraVM14LVykJfea6bTXI1wjnPh8QezaRlPVG3fdpLORv61r286EvqY8typkWAF9mdW2
         AhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710139; x=1709314939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L8CWGVS5oYo9Xv5uGh2hBH5hNaU6W6dhr1j9gGPoJgA=;
        b=XGk9TwnKXMtIKdmwqOjORldkRPV/sdmIMdC08wCaUG5iScXjVomA29Yiz4n0T4N2j8
         THjvkcrY++jvSU5ilMs/yBswyg97lkCkOaoJds4Xepr5SUp+a2iF+ZGsi8CcGHqAIYIx
         Y24KmdONOCh0IK9QewOYc5ext0lnHWYlw0SlxTksUc2jT+oCTs/iIWCR9+ee4UOaY+WE
         Gcg0+sJykZa1CxRKD225JohaxlZnLk5FhQLZrDFg6q97UsaMdFD8LdmwrCggJyq1swla
         NsS68KfCUmnOrxxgegc5V6NcKNTsMx3853+JwyycERHMi9yB5h1S+qL8MdlM/ti4vViX
         oZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXu4Ss9ITk0N5OwRD1ZhEmYOTTsllM0euGbfe/TfpWjdS50ImNpqFw7uiXpumupXjHfZ2tge+b/rbE6BC8cap4cuiYt2EeaBABzRHefrkU3NFMgaNaQx8/YHK3+pbDBQzc1FSxZFwcCjv/aS++MLlS2FQdh29mIjikc1VNyqUI3OkXPUwaDfL5ALyfMKv/96cx/Oan8p0RgiE9/kqlbfCBPIQ==
X-Gm-Message-State: AOJu0Ywe1BbyZoyp0xoGmgdAihyCatjvkdPJSPb5xEsJoMxG4TUePvUb
	JPr0uKk9YxXuT1ylIn6Ek7yHjS9HtZnaqgtqfomyLiGwBZn5c0BD
X-Google-Smtp-Source: AGHT+IG/VHQ1jNmu0cLyUQLA9RkXGmM2Ppsm4q2QQZNlq98UjD/KtYkojX68z3AVFpsTsHIFzGrr2w==
X-Received: by 2002:a05:6870:6c13:b0:21f:c7a2:9198 with SMTP id na19-20020a0568706c1300b0021fc7a29198mr231043oab.13.1708710138780;
        Fri, 23 Feb 2024 09:42:18 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:42:18 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John@Groves.net,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	John Groves <john@groves.net>
Subject: [RFC PATCH 01/20] famfs: Documentation
Date: Fri, 23 Feb 2024 11:41:45 -0600
Message-Id: <ec08aa5a00bef714b44d61be8b3e7ed58ce7f66a.1708709155.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <cover.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Documentation/filesystems/famfs.rst into the Documentation
tree

Signed-off-by: John Groves <john@groves.net>
---
 Documentation/filesystems/famfs.rst | 124 ++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/filesystems/famfs.rst

diff --git a/Documentation/filesystems/famfs.rst b/Documentation/filesystems/famfs.rst
new file mode 100644
index 000000000000..c2cc50c10d03
--- /dev/null
+++ b/Documentation/filesystems/famfs.rst
@@ -0,0 +1,124 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _famfs_index:
+
+==================================================================
+famfs: The kernel component of the famfs shared memory file system
+==================================================================
+
+- Copyright (C) 2024 Micron Technology, Inc.
+
+Introduction
+============
+Compute Express Link (CXL) provides a mechanism for disaggregated or
+fabric-attached memory (FAM). This creates opportunities for data sharing;
+clustered apps that would otherwise have to shard or replicate data can
+share one copy in disaggregated memory.
+
+Famfs, which is not CXL-specific in any way, provides a mechanism for
+multiple hosts to use data in shared memory, by giving it a file system
+interface. With famfs, any app that understands files (which is all of
+them, right?) can access data sets in shared memory. Although famfs
+supports read and write calls, the real point is to support mmap, which
+provides direct (dax) access to the memory - either writable or read-only.
+
+Shared memory can pose complex coherency and synchronization issues, but
+there are also simple cases. Two simple and eminently useful patterns that
+occur frequently in data analytics and AI are:
+
+* Serial Sharing - Only one host or process at a time has access to a file
+* Read-only Sharing - Multiple hosts or processes share read-only access
+  to a file
+
+The famfs kernel file system is part of the famfs framework; User space
+components [1] handle metadata allocation and distribution, and direct the
+famfs kernel module to instantiate files that map to specific memory.
+
+The famfs framework manages coherency of its own metadata and structures,
+but does not attempt to manage coherency for applications.
+
+Famfs also provides data isolation between files. That is, even though
+the host has access to an entire memory "device" (as a dax device), apps
+cannot write to memory for which the file is read-only, and mapping one
+file provides isolation from the memory of all other files. This is pretty
+basic, but some experimental shared memory usage patterns provide no such
+isolation.
+
+Principles of Operation
+=======================
+
+Without its user space components, the famfs kernel module is just a
+semi-functional clone of ramfs with latent fs-dax support. The user space
+components maintain superblocks and metadata logs, and use the famfs kernel
+component to provide a file system view of shared memory across multiple
+hosts.
+
+Each host has an independent instance of the famfs kernel module. After
+mount, files are not visible until the user space component instantiates
+them (normally by playing the famfs metadata log).
+
+Once instantiated, files on each host can point to the same shared memory,
+but in-memory metadata (inodes, etc.) is ephemeral on each host that has a
+famfs instance mounted. Like ramfs, the famfs in-kernel file system has no
+backing store for metadata modifications. If metadata is ever persisted,
+that must be done by the user space components. However, mutations to file
+data are saved to the shared memory - subject to write permission and
+processor cache behavior.
+
+
+Famfs is Not a Conventional File System
+---------------------------------------
+
+Famfs files can be accessed by conventional means, but there are
+limitations. The kernel component of famfs is not involved in the
+allocation of backing memory for files at all; the famfs user space
+creates files and passes the allocation extent lists into the kernel via
+the per-file FAMFSIOC_MAP_CREATE ioctl. A file that lacks this metadata is
+treated as invalid by the famfs kernel module. As a practical matter files
+must be created via the famfs library or cli, but they can be consumed as
+if they were conventional files.
+
+Famfs differs in some important ways from conventional file systems:
+
+* Files must be pre-allocated by the famfs framework; Allocation is never
+  performed on write.
+* Any operation that changes a file's size is considered to put the file
+  in an invalid state, disabling access to the data. It may be possible to
+  revisit this in the future.
+* (Typically the famfs user space can restore files to a valid state by
+  replaying the famfs metadata log.)
+
+Famfs exists to apply the existing file system abstractions on top of
+shared memory so applications and workflows can more easily consume it.
+
+Key Requirements
+================
+
+The primary requirements for famfs are:
+
+1. Must support a file system abstraction backed by sharable dax memory
+2. Files must efficiently handle VMA faults
+3. Must support metadata distribution in a sharable way
+4. Must handle clients with a stale copy of metadata
+
+The famfs kernel component takes care of 1-2 above.
+
+Requirements 3 and 4 are handled by the user space components, and are
+largely orthogonal to the functionality of the famfs kernel module.
+
+Requirements 3 and 4 cannot be met by conventional fs-dax file systems
+(e.g. xfs and ext4) because they use write-back metadata; it is not valid
+to mount such a file system on two hosts from the same in-memory image.
+
+
+Famfs Usage
+===========
+
+Famfs usage is documented at [1].
+
+
+References
+==========
+
+- [1] Famfs user space repository and documentation
+      https://github.com/cxl-micron-reskit/famfs
-- 
2.43.0


