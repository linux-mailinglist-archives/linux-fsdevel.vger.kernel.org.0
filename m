Return-Path: <linux-fsdevel+bounces-72672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61ECFF6DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 19:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F316431EE887
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 17:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8D034F481;
	Wed,  7 Jan 2026 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXfqp3GF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200932B994
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805862; cv=none; b=Ls4oTUBzYXfPaquSHS4VXjVFIPWc/FM49BB+olwdWFTclj4jPccwKvw8rkH4XUHqcjQflt02ZVicEKO1Y6gP1FnKPoypesyL+0WfZA20dpjZZGo7xZiaEwdCFCJ0ch0usgtQnpKXUGDB/QGbxIESZi6HVYAtw1vwBLhQ5/SwpzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805862; c=relaxed/simple;
	bh=Ttkg2XpXdV7mU4TtIvuypgDn9POxEKCuiqAdPxPROfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1Mjwk5gJ07xLM1WioEAowF2IUawhqu74NpIlfh1JeIFSkOKrHY/2OK+hVanJhytmU45MOuc+j6+20qWfG4hzzKuIsJUbvHlvgQ98hO6KZzGG8vMdqNwwKcuJB5c6F1njt/LAzb+4zmq5l+OY5RhNkMLpSaM9eH/9Lzalf2QqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXfqp3GF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b9387df58cso2687091b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 09:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767805853; x=1768410653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=smDhjw69opHcgwAO6wrw0z059aJcdcN+GUjt6JFpHNc=;
        b=EXfqp3GFB8c+VhFxpRj85jvifta5K3urWivn2trqrHQp+FEKpwQefPhGbAjhwVHtjz
         eLtoM6rTmWwJemp/WRLfVol4YRAH7eZERYOABXrsxHUGgeLNeizr75TTBiXSlsGit+V6
         pBQ4PDbH5zw+MyDxN10zrfMxTr3aQxKhngK855hifgnZGZoTp4Btyx0Fo060gEg0lbc9
         1jCE6greTegn/duy82++CTs4+uVLEMx2QJhd72FuwRetT6gsmH7ezjZBxKqDA+A5/CBu
         R+/wxvvXYY8YTHdzyc6hp2t2pik8n09mpCFSs7R1lDYcbHWkNta9Uug89usOPRmwqyjA
         q5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767805853; x=1768410653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smDhjw69opHcgwAO6wrw0z059aJcdcN+GUjt6JFpHNc=;
        b=u4JhPHJNxBB640cJTfc83lvZgOaN9Ft0ismyza+LX7BOsJv2uv0MHQtKwqymXG2KT1
         HI+Z009PPOzOgJr21elM/QXP/mDr6VCaCz7Qe52MdPG47JUj8YCCyePJFM8Nu+Ss6qeP
         O7t3NIQW3ZiMm08uUZ+Yr5arWB4CoEeudhTmH7xhUVq8TausfwMEy47xIF2EN94hKtRH
         LGVc+NegE3L2tdO8k2uN7dHFs7qvoVbpEk996w3bX4SXcUTxkwGlAlp+eqjjSsMOMZ5I
         4CJcIlweWWEkFO0HlkL9XE+D043e1Am6X7DY5xSS/zZRHWj4vF3nTAGrAxoWk0AkeZYG
         nbxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6z6esjehEZIb83Gt+wDD2wDlPm23mp5+S6nef3s1uZrEShf4SUqVm5fBRV8heC70FGFxjNFvPNRrdJHI/@vger.kernel.org
X-Gm-Message-State: AOJu0YySyhZqucbpPoe6EFcRPF+brLdzzz/4vbc5q2I16D7Nm7BnNKSK
	AOuAH9KTpJ3aZdISN63jIs00isRAJANMt1Jk3RkF9hvgb4zqCLOakf52pEW1og==
X-Gm-Gg: AY/fxX42v73aTd7FwVZ2+qPv1qXajp9ydDUxX/MfzSN/iCHwhjCqHHYU7y73BXaDh26
	FwMlKm+vQtdXiW5seB/LUpgEkvLDhRoasYgO3FRgVfedx1/r8YYzY4fHl9icaOqLncgx6Y/bSeX
	vrfdHKkMCpikmN1Wchd37hArV9KfuLl+rksJrJV2rKwZuJ8uJrf/ujCHmFgMGB0MTBj28/Y/S6o
	puPmDv1heRQUMib0skFBKRix/ECKZfKis6xcnu8XHhUFNuqSJxyMTH0k9+oyBQHtHHeMyqjlFOu
	w6n4SzWlopCrtdhRuRhxTWxiUZKQX3uSXsRJnW/32U5SFal1f+VeGOuwd0/mr8Rgtm4vCy04OMl
	5mP6va/AsE1CWEfPoOJuKxi7UAOgquPlmmTQ+lwx8jMbpPAeKrNCUSODDeI7sCUp+NY4CGlhWKx
	33GmGtp5P4x0KugqbjHRlBSnfIAVEv/NdhV7/T4o4wu/te
X-Google-Smtp-Source: AGHT+IGk3VZwDE/lNocDKTrmheVpB/dJskVwCoQ351Cwl656mI6EkUE/J2SR25sUuHffBBW1+p+c1g==
X-Received: by 2002:a05:6808:668c:10b0:45a:7773:9013 with SMTP id 5614622812f47-45a77739cc0mr200634b6e.21.1767799968204;
        Wed, 07 Jan 2026 07:32:48 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af8b2sm3393292a34.15.2026.01.07.07.32.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:32:47 -0800 (PST)
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
	Chen Linxuan <chenlinxuan@uniontech.com>,
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
Subject: [PATCH BUNDLE] famfs: Fabric-Attached Memory File System
Date: Wed,  7 Jan 2026 09:32:44 -0600
Message-ID: <20260107153244.64703-1-john@groves.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a coordinated patch submission for famfs (Fabric-Attached Memory
File System) across three repositories:

  1. Linux kernel (21 patches) - dax fsdev driver + fuse/famfs integration
  2. libfuse (4 patches) - famfs protocol support for fuse servers
  3. ndctl/daxctl (2 patches) - support for the new "famfs" devdax mode

Each series is posted as a reply to this cover message, with individual
patches replying to their respective series cover.

Overview
--------
Famfs exposes shared memory as a file system. It consumes shared memory
from dax devices and provides memory-mappable files that map directly to
the memory with no page cache involvement. Famfs differs from conventional
file systems in fs-dax mode in that it handles in-memory metadata in a
sharable way (which begins with never caching dirty shared metadata).

Famfs started as a standalone file system [1,2], but the consensus at
LSFMM 2024 and 2025 [3,4] was that it should be ported into fuse.

The key performance requirement is that famfs must resolve mapping faults
without upcalls. This is achieved by fully caching the file-to-devdax
metadata for all active files via two fuse client/server message/response
pairs: GET_FMAP and GET_DAXDEV.

Patch Series Summary
--------------------

Linux Kernel (V3, 21 patches):
  - dax: New fsdev driver (drivers/dax/fsdev.c) providing a devdax mode
    compatible with fs-dax. Devices can be switched among 'devdax', 'fsdev'
    and 'system-ram' modes via daxctl or sysfs.
  - fuse: Famfs integration adding GET_FMAP and GET_DAXDEV messages for
    caching file-to-dax mappings in the kernel.

libfuse (V2, 4 patches):
  - Updates fuse_kernel.h to kernel 6.19 baseline
  - Adds famfs DAX fmap protocol definitions
  - Adds API for kernel mount options
  - Implements famfs DAX fmap support for fuse servers

ndctl/daxctl (2 patches):
  - Adds daxctl support for the new "famfs" mode of devdax
  - Adds test/daxctl-famfs.sh for testing mode transitions

Changes Since V2 (kernel)
-------------------------
- Dax: Completely new fsdev driver replaces the dev_dax_iomap modifications.
  Uses MEMORY_DEVICE_FS_DAX type with order-0 folios for fs-dax compatibility.
- Dax: The "poisoned page" problem is properly fixed via fsdev_clear_folio_state()
  which clears stale mapping/compound state when fsdev binds.
- Dax: Added dax_set_ops() and driver unbind protection while filesystem mounted.
- Fuse: Famfs mounts require CAP_SYS_RAWIO (exposing raw memory devices).
- Fuse: Added DAX address_space_operations with noop_dirty_folio.
- Rebased to latest kernels, compatible with recent dax refactoring.

Testing
-------
The famfs user space [5] includes comprehensive smoke and unit tests that
exercise all three components together. The ndctl series includes a
dedicated test for famfs mode transitions.

References
----------
[1] https://lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.net/
[2] https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.net/
[3] https://lwn.net/Articles/983105/ (LSFMM 2024)
[4] https://lwn.net/Articles/1020170/ (LSFMM 2025)
[5] https://famfs.org (famfs user space)
[6] https://lore.kernel.org/linux-cxl/20250703185032.46568-1-john@groves.net/ (V2)

--
John Groves

