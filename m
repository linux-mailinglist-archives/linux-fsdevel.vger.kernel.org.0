Return-Path: <linux-fsdevel+bounces-73834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67ED216EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F4C311F891
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1093904DF;
	Wed, 14 Jan 2026 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B07gobi4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2B38A9BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426982; cv=none; b=L5jh8yVTI8ZFRpU5eJUu5gsfHLdzjttahdlOALbQbvOnpcYqJ5LQ5lobCZR1y+oxkzTw9PDTSx08ydFpLu1WYMwDSMYd2SJYfqKTIGc6T8PFmCLNVdufbp1lyC0mfXVqZpt0bVxZSIS9/bRo80ME/P3aahDkemJ2Ug6+lj45TTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426982; c=relaxed/simple;
	bh=P4J7niyHS51xHp1Q12pZ0X0vf1nlssirOmBCP6cbZ64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYU0QY5BztQ2+Ea6f7Nw7qUzA1BkVZbELmkecKVE4TyCYwWqB9pcxfyNujj3G2bngkcQ5yJ7OK1C1CFoqleXyiWVA54aGtmyHx2aDkm2c6wLwcIj1mEwusiraV4vQqKlKIq75nRnZ2V0e3Z/evKGlZNj9wDpkShFPMsE9YK3aLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B07gobi4; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7cdae63171aso209705a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426958; x=1769031758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laJJpvpihQ20m2JOTCcWi2X4Dot3SA9OG2LQvA/I7VM=;
        b=B07gobi4Py45kfcflPcaBfBuXUqerKnQ1T+2ax11FlxbDl3sTTT0iGO+/xEuwJgUm8
         FgNWk1SK2tJS1pW7SN6e3XREubW1fdK/BUuR7xRJ/81ETDeLP8C7D6o8ajeUz0OXo7cX
         8hGIFoXcEeyrzbIM7uYSfqN/wSMDsZ4mjM66SKgIaYJEPjRrLqpuNSH2L8EcnV8cfHUE
         BodLKPc3bMCJLqEclNfExQxA2NA+sYKKc5f5mto004/ew04Z1OFdUJ+lrNcQogQGIRpf
         bw3E3eFpPfP88LqsJs5kn4OpoPxRD2fzt2KunUJjRCdFtbW359WDtjc7Mbstqg0eUTV2
         20dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426958; x=1769031758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laJJpvpihQ20m2JOTCcWi2X4Dot3SA9OG2LQvA/I7VM=;
        b=Ax0d+SPa6zpwExQSZXkXvSC94IS7AP/Cyb112N0NPIABoZ/oIsg1n4y19wh4QXmKPQ
         oGU19TzrZgJI27mJSoGAPprEMcqbSXV/Xg6D1RsWrFfBnnJQGIHSdrxry+5/PdPWel46
         rE9C+TDtxMxge9Qr/v5N6v+1ib/b8g/zGlX1pwO0f7YBkWNbOtKXfIOjxMBOqMDPWN4q
         WGKXTpCfWMCBHKIyV7igL8gXl6CIdQeVtDhESRW+AxpQKVNpcBgyUBOf6s8WH8ZMn8/f
         AUXEzf5SdAHzaEYm2RTcnUiyJ4+VyQhtTpcxdXyog0MfAIoi4yxuSg4RPVsX54C7GGbn
         8Y0A==
X-Forwarded-Encrypted: i=1; AJvYcCUMj56qSvd5aeByj2Xt8wz0PNPEDLpscnn02NEtNJSOb8k1nMw07+l2sZhwaPdv9Iv3XYxqK09FIEJ9htsf@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7xGGybvcSf9CF+rKtDx0L+KHMgZwYP4mcGuK5y7cQkykI75i
	53l6RE5Qj9PEUVB5rtKFjfs1FO9PYcQZX6OmjNXlGXY+L8FDb3FHsZDA
X-Gm-Gg: AY/fxX7WBLKc/fJNQkeE3fA25THlDgi8jEI3TwtJaoYfOtTjJvPboCzEVH4CiVgabx2
	cWW2NH+DiLdF30R1FEDs5yxHItwBzQkAaMZZgHdvC4dD+n3XnjwLDkOEUe7nuLN9MRjUwIqiFsm
	n24dVjlRu14yRNkJ2z6gqtccT2nH83QxG4Yu/GDXaDubf8LYknPz6YK+T3zajDgObQZUEb0gc16
	/NypBSLwXKYA5Ck8yb8SVdHGQmXVIbrJiUcxYTo+u98ouzeYNWLYeO4WEFTov+SNia7SWxsa+yX
	YTjGdwRJrB737oQ3oxl1n+GTBpEFVscjBU+LvUhfxtU1a/hnoHRM/U+KZsizfJerSsskJaN73uJ
	eAwSgl5Rwm5GkXidRqpE26CH0Ovls6PWdZSImCvIx7FkrCIfqKmWb1eZgfxJvXUipA9cBSmm9Ui
	XRLW5DBK3jZS3YKPiVj0S8l9ontwjmZvpC8v1RqyrPl/zT
X-Received: by 2002:a05:6830:4124:b0:7cf:d191:3a76 with SMTP id 46e09a7af769-7cfd1913d41mr1096939a34.2.1768426957561;
        Wed, 14 Jan 2026 13:42:37 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfcc8428fesm2063248a34.0.2026.01.14.13.42.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:42:37 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 19/19] famfs_fuse: Add documentation
Date: Wed, 14 Jan 2026 15:32:06 -0600
Message-ID: <20260114213209.29453-20-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213209.29453-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114213209.29453-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Documentation/filesystems/famfs.rst and update MAINTAINERS

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: John Groves <john@groves.net>
---
 Documentation/filesystems/famfs.rst | 142 ++++++++++++++++++++++++++++
 Documentation/filesystems/index.rst |   1 +
 MAINTAINERS                         |   1 +
 3 files changed, 144 insertions(+)
 create mode 100644 Documentation/filesystems/famfs.rst

diff --git a/Documentation/filesystems/famfs.rst b/Documentation/filesystems/famfs.rst
new file mode 100644
index 000000000000..bf0c0e6574bb
--- /dev/null
+++ b/Documentation/filesystems/famfs.rst
@@ -0,0 +1,142 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _famfs_index:
+
+==================================================================
+famfs: The fabric-attached memory file system
+==================================================================
+
+- Copyright (C) 2024-2026 Micron Technology, Inc.
+
+Introduction
+============
+Compute Express Link (CXL) provides a mechanism for disaggregated or
+fabric-attached memory (FAM). This creates opportunities for data sharing;
+clustered apps that would otherwise have to shard or replicate data can
+share one copy in disaggregated memory.
+
+Famfs, which is not CXL-specific in any way, provides a mechanism for
+multiple hosts to concurrently access data in shared memory, by giving it
+a file system interface. With famfs, any app that understands files can
+access data sets in shared memory. Although famfs supports read and write,
+the real point is to support mmap, which provides direct (dax) access to
+the memory - either writable or read-only.
+
+Shared memory can pose complex coherency and synchronization issues, but
+there are also simple cases. Two simple and eminently useful patterns that
+occur frequently in data analytics and AI are:
+
+* Serial Sharing - Only one host or process at a time has access to a file
+* Read-only Sharing - Multiple hosts or processes share read-only access
+  to a file
+
+The famfs fuse file system is part of the famfs framework; user space
+components [1] handle metadata allocation and distribution, and provide a
+low-level fuse server to expose files that map directly to [presumably
+shared] memory.
+
+The famfs framework manages coherency of its own metadata and structures,
+but does not attempt to manage coherency for applications.
+
+Famfs also provides data isolation between files. That is, even though
+the host has access to an entire memory "device" (as a devdax device), apps
+cannot write to memory for which the file is read-only, and mapping one
+file provides isolation from the memory of all other files. This is pretty
+basic, but some experimental shared memory usage patterns provide no such
+isolation.
+
+Principles of Operation
+=======================
+
+Famfs is a file system with one or more devdax devices as a first-class
+backing device(s). Metadata maintenance and query operations happen
+entirely in user space.
+
+The famfs low-level fuse server daemon provides file maps (fmaps) and
+devdax device info to the fuse/famfs kernel component so that
+read/write/mapping faults can be handled without up-calls for all active
+files.
+
+The famfs user space is responsible for maintaining and distributing
+consistent metadata. This is currently handled via an append-only
+metadata log within the memory, but this is orthogonal to the fuse/famfs
+kernel code.
+
+Once instantiated, "the same file" on each host points to the same shared
+memory, but in-memory metadata (inodes, etc.) is ephemeral on each host
+that has a famfs instance mounted. Use cases are free to allow or not
+allow mutations to data on a file-by-file basis.
+
+When an app accesses a data object in a famfs file, there is no page cache
+involvement. The CPU cache is loaded directly from the shared memory. In
+some use cases, this is an enormous reduction read amplification compared
+to loading an entire page into the page cache.
+
+
+Famfs is Not a Conventional File System
+---------------------------------------
+
+Famfs files can be accessed by conventional means, but there are
+limitations. The kernel component of fuse/famfs is not involved in the
+allocation of backing memory for files at all; the famfs user space
+creates files and responds as a low-level fuse server with fmaps and
+devdax device info upon request.
+
+Famfs differs in some important ways from conventional file systems:
+
+* Files must be pre-allocated by the famfs framework; allocation is never
+  performed on (or after) write.
+* Any operation that changes a file's size is considered to put the file
+  in an invalid state, disabling access to the data. It may be possible to
+  revisit this in the future. (Typically the famfs user space can restore
+  files to a valid state by replaying the famfs metadata log.)
+
+Famfs exists to apply the existing file system abstractions to shared
+memory so applications and workflows can more easily adapt to an
+environment with disaggregated shared memory.
+
+Memory Error Handling
+=====================
+
+Possible memory errors include timeouts, poison and unexpected
+reconfiguration of an underlying dax device. In all of these cases, famfs
+receives a call from the devdax layer via its iomap_ops->notify_failure()
+function. If any memory errors have been detected, access to the affected
+daxdev is disabled to avoid further errors or corruption.
+
+In all known cases, famfs can be unmounted cleanly. In most cases errors
+can be cleared by re-initializing the memory - at which point a new famfs
+file system can be created.
+
+Key Requirements
+================
+
+The primary requirements for famfs are:
+
+1. Must support a file system abstraction backed by sharable devdax memory
+2. Files must efficiently handle VMA faults
+3. Must support metadata distribution in a sharable way
+4. Must handle clients with a stale copy of metadata
+
+The famfs kernel component takes care of 1-2 above by caching each file's
+mapping metadata in the kernel.
+
+Requirements 3 and 4 are handled by the user space components, and are
+largely orthogonal to the functionality of the famfs kernel module.
+
+Requirements 3 and 4 cannot be met by conventional fs-dax file systems
+(e.g. xfs) because they use write-back metadata; it is not valid to mount
+such a file system on two hosts from the same in-memory image.
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
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f4873197587d..e6fb467c1680 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -89,6 +89,7 @@ Documentation for filesystem implementations.
    ext3
    ext4/index
    f2fs
+   famfs
    gfs2/index
    hfs
    hfsplus
diff --git a/MAINTAINERS b/MAINTAINERS
index 6f8a7c813c2f..43141ee4fd4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10385,6 +10385,7 @@ M:	John Groves <John@Groves.net>
 L:	linux-cxl@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
+F:	Documentation/filesystems/famfs.rst
 F:	fs/fuse/famfs.c
 F:	fs/fuse/famfs_kfmap.h
 
-- 
2.52.0


