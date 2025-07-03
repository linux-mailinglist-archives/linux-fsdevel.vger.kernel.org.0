Return-Path: <linux-fsdevel+bounces-53823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7530EAF8086
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA29A1C82050
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF81F291166;
	Thu,  3 Jul 2025 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lzc/vZ4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767A34CF5;
	Thu,  3 Jul 2025 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568641; cv=none; b=TvqZyvgwhZigM6Br1GQkuxVv3iWaTwA4Pk4KN2zyuj0MzRV5MsMlYIEmILoveL66xq5kOJxxsCPKF4T6zpuTE9zgvc3/uGMgeVcDZtzKNIBc8601pxj8KJpl8pBN6JebeDZz5hYoqBZuV4AAQdSqOBn3BjTpiarcgcgrZV4BIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568641; c=relaxed/simple;
	bh=o+EdHKJiZcbdh7JR73cJxK+TOscaGMrnCTKc3fb2Fx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E0E55+2JHPhM2sD70vNHsgh+8raYCH6b4RVaX/PX63BuB0Yl2TKyzAHp6RAjkzbVDSYloUPq1Ai99PfI4CVogmiH91D/b8dMRc7WsaGgXm4Upq7Yz9oJivLZAFuwrVL4QFySR92SId762nyUM/1aPFgUgRlBiy5KzwIlJhLa3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lzc/vZ4p; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73c89db3dfcso57143a34.3;
        Thu, 03 Jul 2025 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568637; x=1752173437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x6rnerVb+6GntuTp6S7DTM/J3Z6OW4j/JFypEtAu7Xs=;
        b=Lzc/vZ4pG6UBXbFM4UB/aXwptZFozYoKmMj//kkoSnFZRAWhxh87z2XZu8R9Mc93L8
         n2qeJ60ZqJ+F+uifq70sVIpKeiXUS0hACd3YLJuZjyFbqL3QZonmuxxzUreL0lqZSnO4
         T8tb020i8MsiSOFSWuuNhgH2nh0a1AUvS4dI055wuGpAdsIuwcly9tmUH0JOv3fESou+
         Eu5/MNzS9hQoKhkCgGcpcOr4nfeId4/M7FRWSxpBwynR+MAXadKxuRFdiSdTNkYB5NlY
         OOjoawKtCVL2/Lrw27HncFEnhxrUBRuAxu6Fl/2Cf9Gxqs4AM2z/zbbdLdN/kslrye7+
         hLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568637; x=1752173437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6rnerVb+6GntuTp6S7DTM/J3Z6OW4j/JFypEtAu7Xs=;
        b=VEf0J9M1nr/A75dhuuiZu4rRKhOhoMQJNeehTnWlcuLCCG1sj9eCAJMrxQE0ybBqdS
         126a9XQzc0TG/2HWMwCBdkAQ4dHjSM32XL709kWUQ3kIRhTWnoMDmbkXQhgRKHmdc7ex
         0TbgOW4yoBbZVxH4hfol8XHJpktWM0JTZevcOrDelHND8sNP2KjBsKzTc+aYgDSuBV2P
         aq9kzg3gkUtDvu7Efyr8HUYGgTkMyBcoWgiS8QJ/+8N7Hoq1urySbLeB2hy2I8+0/q/n
         yV9uoH/Jqm95577+SwACY4cbEpYMSF0/t/OIAtQ/UBPc86lTDOvsvCniRZ4ugXzrM/AT
         RgpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN38BBz9kQYcTSuzp4Dyie6/XSJt0HIz1ly0qEjhJGokRcl6arRdDKRpz5IMEMtdvFVim2Ikj0Ygpy@vger.kernel.org, AJvYcCVzWBT7wOeAbNRnhzkpP7c/uhT6bWGdC4KQK9UyQUwsQi+QCYtbVoyWrkABcMP5P/FTrOT4Py+coR9M4QwR@vger.kernel.org, AJvYcCWso1fA6mfTRHorbK0Rtx4kyZT1AlIdlMOa0uY8qBDbAiJzzZ9OgGB74o+sCUwtrt7hbiZLmyoat/0ytQZqSQ==@vger.kernel.org, AJvYcCX0/d1k6BbnZAWs4jR81ObtCTbnzOQAulb24ply1F3fpMSuqTZvaJH6QMyNn3YugrFK1fkWf3PKWYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBgWzbbH5/FALWwTaIcEfXmYmZsFlm00AA7xtoT+9kFsk3Amm
	yIqmoMdTJScg5EUZGNM5LzEIvfAdqGioHuFKNs6FOwHXJijSiH637m9m
X-Gm-Gg: ASbGncu5bf9QUVqskY3Pss0MPBiWmRnY2pGWDDEqJXbmMzpSBXZr1oBMy+1s7Xy0HOn
	ab1JQibW6xRS3E5mpmeFgrIHUgrmAocsF5qRYxnCDlgNnG31219XIc2BC+pGIjcM4qPPMeHpz24
	Rq19EEIQ14bjbEMOmvEWDdZXVtpsQJ23N6y2au4ImmJ+WRJHw4/ch0jtK4xc6EVwsB+6xndbHVA
	dbNbWFqoL5c9R42qSCnxn1bjitPSd9iOPioD7HkOiblw+uYAquEWZAhjMgm9AT81oSaB6zkhlHG
	NKMnYKwhyed5d72lsSJKnYhAwovo+fYyBtO/JYw0pWrxyo59gBoI3PxqAgmKkG7oV5GxbfzyhoS
	sMtKDzNFxWhfjKA==
X-Google-Smtp-Source: AGHT+IE+E1IWX7VMM/gMEp2jGkXbXaFvLr8rm6roo9GKJvXZOlTw4XO/kvvDm6fgP6T7/ve0x09MLg==
X-Received: by 2002:a05:6830:4d86:b0:72b:8297:e988 with SMTP id 46e09a7af769-73c897162f6mr3056566a34.25.1751568636648;
        Thu, 03 Jul 2025 11:50:36 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.50.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:50:36 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [RFC V2 00/18] famfs: port into fuse
Date: Thu,  3 Jul 2025 13:50:14 -0500
Message-Id: <20250703185032.46568-1-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:

- The GET_FMAP message/response has been moved from LOOKUP to OPEN, as was
  the pretty much unanimous consensus.
- Made the response payload to GET_FMAP variable sized (patch 12)
- Dodgy kerneldoc comments cleaned up or removed.
- Fixed memory leak of fc->shadow in patch 11 (thanks Joanne)
- Dropped many pr_debug and pr_notice calls

Open Issues:

- This is still marked RFC because I have not tackled the "poisoned page
  problem" yet (see below the original description below). That's next on my
  agenda for this patch set; I'm planning to address that in V3, and to drop
  RFC and make V3 mergeable.
- Note: this patch is still against 6.14 because of the interaction of the
  poisoned page issue with Alistair Popple's multitudinous recent DAX
  patches. ;) I have some work to do to move forward, but the next rev will
  do that.
- Because I haven't moved forward past 6.14, the related libfuse patch [2.1]
  is out of sync with the libfuse master branch. This will be addressed in the
  next version.

Other Notes:
- This patch is available as a git branch at [2.2]

References to V2
[2.1] - https://github.com/libfuse/libfuse/pull/1271
[2.2] - https://github.com/cxl-micron-reskit/famfs-linux/tree/famfs-fuse-v2


Original Description:

This is the initial RFC for the fabric-attached memory file system (famfs)
integration into fuse. In order to function, this requires a related patch
to libfuse [1] and the famfs user space [2]. 

This RFC is mainly intended to socialize the approach and get feedback from
the fuse developers and maintainers. There is some dax work that needs to
be done before this should be merged (see the "poisoned page|folio problem"
below).

This patch set fully works with Linux 6.14 -- passing all existing famfs
smoke and unit tests -- and I encourage existing famfs users to test it.

This is really two patch sets mashed up:

* The patches with the dev_dax_iomap: prefix fill in missing functionality for
  devdax to host an fs-dax file system.
* The famfs_fuse: patches add famfs into fs/fuse/. These are effectively
  unchanged since last year.

Because this is not ready to merge yet, I have felt free to leave some debug
prints in place because we still find them useful; those will be cleaned up
in a subsequent revision.

Famfs Overview

Famfs exposes shared memory as a file system. Famfs consumes shared memory
from dax devices, and provides memory-mappable files that map directly to
the memory - no page cache involvement. Famfs differs from conventional
file systems in fs-dax mode, in that it handles in-memory metadata in a
sharable way (which begins with never caching dirty shared metadata).

Famfs started as a standalone file system [3,4], but the consensus at LSFMM
2024 [5] was that it should be ported into fuse - and this RFC is the first
public evidence that I've been working on that.

The key performance requirement is that famfs must resolve mapping faults
without upcalls. This is achieved by fully caching the file-to-devdax
metadata for all active files. This is done via two fuse client/server
message/response pairs: GET_FMAP and GET_DAXDEV.

Famfs remains the first fs-dax file system that is backed by devdax rather
than pmem in fs-dax mode (hence the need for the dev_dax_iomap fixups).

Notes

* Once the dev_dax_iomap patches land, I suspect it may make sense for
  virtiofs to update to use the improved interface.

* I'm currently maintaining compatibility between the famfs user space and
  both the standalone famfs kernel file system and this new fuse
  implementation. In the near future I'll be running performance comparisons
  and sharing them - but there is no reason to expect significant degradation
  with fuse, since famfs caches entire "fmaps" in the kernel to resolve
  faults with no upcalls. This patch has a bit too much debug turned on to
  to that testing quite yet. A branch 

* Two new fuse messages / responses are added: GET_FMAP and GET_DAXDEV.

* When a file is looked up in a famfs mount, the LOOKUP is followed by a
  GET_FMAP message and response. The "fmap" is the full file-to-dax mapping,
  allowing the fuse/famfs kernel code to handle read/write/fault without any
  upcalls.

* After each GET_FMAP, the fmap is checked for extents that reference
  previously-unknown daxdevs. Each such occurrence is handled with a
  GET_DAXDEV message and response.

* Daxdevs are stored in a table (which might become an xarray at some point).
  When entries are added to the table, we acquire exclusive access to the
  daxdev via the fs_dax_get() call (modeled after how fs-dax handles this
  with pmem devices). famfs provides holder_operations to devdax, providing
  a notification path in the event of memory errors.

* If devdax notifies famfs of memory errors on a dax device, famfs currently
  blocks all subsequent accesses to data on that device. The recovery is to
  re-initialize the memory and file system. Famfs is memory, not storage...

* Because famfs uses backing (devdax) devices, only privileged mounts are
  supported.

* The famfs kernel code never accesses the memory directly - it only
  facilitates read, write and mmap on behalf of user processes. As such,
  the RAS of the shared memory affects applications, but not the kernel.

* Famfs has backing device(s), but they are devdax (char) rather than
  block. Right now there is no way to tell the vfs layer that famfs has a
  char backing device (unless we say it's block, but it's not). Currently
  we use the standard anonymous fuse fs_type - but I'm not sure that's
  ultimately optimal (thoughts?)

The "poisoned page|folio problem"

* Background: before doing a kernel mount, the famfs user space [2] validates
  the superblock and log. This is done via raw mmap of the primary devdax
  device. If valid, the file system is mounted, and the superblock and log
  get exposed through a pair of files (.meta/.superblock and .meta/.log) -
  because we can't be using raw device mmap when a file system is mounted
  on the device. But this exposes a devdax bug and warning...

* Pages that have been memory mapped via devdax are left in a permanently
  problematic state. Devdax sets page|folio->mapping when a page is accessed
  via raw devdax mmap (as famfs does before mount), but never cleans it up.
  When the pages of the famfs superblock and log are accessed via the "meta"
  files after mount, we see a WARN_ONCE() in dax_insert_entry(), which
  notices that page|folio->mapping is still set. I intend to address this
  prior to asking for the famfs patches to be merged.

* Alistair Popple's recent dax patch series [6], which has been merged
  for 6.15, addresses some dax issues, but sadly does not fix the poisoned
  page|folio problem - its enhanced refcount checking turns the warning into
  an error.

* This 6.14 patch set disables the warning; a proper fix will be required for
  famfs to work at all in 6.15. Dan W. and I are actively discussing how to do
  this properly...

* In terms of the correct functionality of famfs, the warning can be ignored.

References

[1] - https://github.com/libfuse/libfuse/pull/1200
[2] - https://github.com/cxl-micron-reskit/famfs
[3] - https://lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.net/
[4] - https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.net/
[5] - https://lwn.net/Articles/983105/
[6] - https://lore.kernel.org/linux-cxl/cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com/


John Groves (18):
  dev_dax_iomap: Move dax_pgoff_to_phys() from device.c to bus.c
  dev_dax_iomap: Add fs_dax_get() func to prepare dax for fs-dax usage
  dev_dax_iomap: Save the kva from memremap
  dev_dax_iomap: Add dax_operations for use by fs-dax on devdax
  dev_dax_iomap: export dax_dev_get()
  dev_dax_iomap: (ignore!) Drop poisoned page warning in fs/dax.c
  famfs_fuse: magic.h: Add famfs magic numbers
  famfs_fuse: Kconfig
  famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
  famfs_fuse: Basic fuse kernel ABI enablement for famfs
  famfs_fuse: Basic famfs mount opts
  famfs_fuse: Plumb the GET_FMAP message/response
  famfs_fuse: Create files with famfs fmaps
  famfs_fuse: GET_DAXDEV message and daxdev_table
  famfs_fuse: Plumb dax iomap and fuse read/write/mmap
  famfs_fuse: Add holder_operations for dax notify_failure()
  famfs_fuse: Add famfs metadata documentation
  famfs_fuse: Add documentation

 Documentation/filesystems/famfs.rst |  142 ++++
 Documentation/filesystems/index.rst |    1 +
 MAINTAINERS                         |   10 +
 drivers/dax/Kconfig                 |    6 +
 drivers/dax/bus.c                   |  144 +++-
 drivers/dax/dax-private.h           |    1 +
 drivers/dax/device.c                |   38 +-
 drivers/dax/super.c                 |   33 +-
 fs/dax.c                            |    1 -
 fs/fuse/Kconfig                     |   13 +
 fs/fuse/Makefile                    |    2 +-
 fs/fuse/dir.c                       |    2 +-
 fs/fuse/famfs.c                     | 1087 +++++++++++++++++++++++++++
 fs/fuse/famfs_kfmap.h               |  166 ++++
 fs/fuse/file.c                      |  124 ++-
 fs/fuse/fuse_i.h                    |   67 +-
 fs/fuse/inode.c                     |   59 +-
 fs/fuse/iomode.c                    |    2 +-
 fs/namei.c                          |    1 +
 include/linux/dax.h                 |    6 +
 include/uapi/linux/fuse.h           |   96 +++
 include/uapi/linux/magic.h          |    2 +
 22 files changed, 1961 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/filesystems/famfs.rst
 create mode 100644 fs/fuse/famfs.c
 create mode 100644 fs/fuse/famfs_kfmap.h


base-commit: b9d5d463c216763cec719c04536ea9e14512cad4
-- 
2.49.0


