Return-Path: <linux-fsdevel+bounces-67505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB223C41E06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 23:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B39424653
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC33148C9;
	Fri,  7 Nov 2025 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NA0sAHf7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E03043BA
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555806; cv=none; b=po4ZneWiW2h8ysCh7xm1XE1uy1blxU70UX75SzB8TBRFtIKAgkYdainhUkkk6pBpzHbXwGe7W4GPm+rPAuksfH0t3EHDH7paiH1fA1a0XeGnl3tqk4ape3xv3lmiKqj+Io5bchLPlFpV/iHMszyZ717Cqoy2Aaub8wvWZxydnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555806; c=relaxed/simple;
	bh=MlggfO79faftTr5r5TEYzz+mGbqyBDNnNZnD0sCXLe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oGCH8ZKNpcHfcy73U+mwWVFGOxbgUGKbjWtTf/VN2FRXXuXXdrB4ook9pt8rlv/gfGOVu9Nq3AeuuVllnzCZYHVbDT111xIXnnk2u2rFrRdgXduILtgd8HaBVydDkcBh+9dVXZkGl3eB7G8Hix9VMED4UIxVMZPtMMd63fALYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NA0sAHf7; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed7024c8c5so9955851cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555802; x=1763160602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/i5+G+JXNuEj74b+jlkiB1ru0BZu3qaV0THAJdKUHE=;
        b=NA0sAHf7KcPSuhFkj2x8QXtvc+ndurMMNk4dks4zhnC+C1bVvYdWKbz2dXhGMxlqFs
         gOGonsxLixWPW/yYIbNKdL4oXDxYAwr5SN51FKRqsNpvHAhiTDth+cbfki1WWwyun2BL
         F4A96++jc/ZYNudpr1x0e1Le0iqlTY0thKkj9suJDtJRZA666KWqTpG1eh21YdMH5ugc
         iU/H7LLVFNUIbe2tO4P+gFwfvaOaIAjCB14S9e+cJn4zYwplG1nLyJnx0W/LtvgMD9Wi
         uuXW47Tasnln0eMAa3z4I3nLUplPm5GTNvkcYWjOikq/d10IFZaBCdzWPhaXMXmMaD8+
         4z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555802; x=1763160602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/i5+G+JXNuEj74b+jlkiB1ru0BZu3qaV0THAJdKUHE=;
        b=h83bIjneTMbDcjZXkqLHyRx+/Ole83JNXwKj58hYQEJIGnogI/qj04RKuiVHBR0QLL
         nhyxrD+BqZ9CGlmSESKTpdRtQco+UxFbtWD+w1MiIBbrJZ8E1VUkpVbFCkLcQMoSZxQh
         N1i7v5OhxXuRm22pwHZI+9XMggfUcrXLPi1IcTYP94Il8JSjwHgGdgS1+jKZ3twDgs1c
         E5Cw0ybdTgGAw6K30oQY3YoAfc2EzmnXjxUlpmYvS4SuPvawsU4wOsmKiqDSid19PVAL
         RbNnCtrb//lEzqEdNcdL9Jxj2/tDQo7E3TgAjYQmgyxalKBQepCjY3zlTPdX3zNTxHcy
         ZfDA==
X-Forwarded-Encrypted: i=1; AJvYcCVr//c67XEM7Y2dRbQf48UXZzM/tgkBe5ULFXZdONtz+8FRK52CDEhmmGT3dPoQnSOHY7caLPwJ/5+3HX1w@vger.kernel.org
X-Gm-Message-State: AOJu0YzWEXwfOgbMrpZsksxbTsxumXWYw8M5yjmt+Dj0EOVr3OHX4Qqx
	lhw/lPDweT8OWheb8wxQ1zmSm2BQdbVaYtMYpA9oNw2snr0tOZL0yFXabTOLzPn0V3Y=
X-Gm-Gg: ASbGncvkHUfTBUS6vk0BopY6H/uwx/SvJKOt2TboG4eTqZ8nkHMKJoMKQXW7QG76ikh
	ylRY5K1rUuQCqWecJMpWSwEg+kl8PgcqfRYCrSrZ+Gc2n/4UsYSLSsXi9LnvrEQYEBbhpCAepD2
	DEkQQAJpaI+1gTcvA3zouCrWTRZd2fAtKBm9Pwx9BCUALnr3o8jhkci2VOUSfUiZLjM1cBtT5tP
	kqDyz+eDYyaZ1aGlIJ0taiYZJMPgP6rWRh+YPQ93UHfqlaAalV61ShkLNLc7FpRrzyLGwJGrpd/
	rjP94azd098ouKq68IG6iTaG4RHIRRmZolhCwFYFFql9FhPTtE0ekS95m4Zu4GoD0DH5Afbp2aP
	Y3NTSnjdacINTCEcq3B8whwjZDZpxoOfltiEvEaTFmEZiPjXh+i8y+O0Sleqa17FgbvqYFxXPt2
	PUDKYuOxeMvb8yRE5NCYyHT1GP9Zeo/Q8gRA/1wpboxx/jRImbttX6pydklAthCryWeeySRoFkW
	Rei0pfXtv6ExQ==
X-Google-Smtp-Source: AGHT+IEnnHkz/BZSg5DKCpmGTuSxg9EESDNIjBwNYfeFy3KOQNMlwaNzTyo63eXXhJ12ZyZIPB9YSg==
X-Received: by 2002:ac8:59cb:0:b0:4b6:299d:dfe4 with SMTP id d75a77b69052e-4eda4f0a4a4mr12390191cf.32.1762555801614;
        Fri, 07 Nov 2025 14:50:01 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:01 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC LPC2026 PATCH 0/9] Protected Memory NUMA Nodes
Date: Fri,  7 Nov 2025 17:49:45 -0500
Message-ID: <20251107224956.477056-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Author Note
-----------
This is a code RFC for discussion related to

"Mempolicy is dead, long live memory policy!"
https://lpc.events/event/19/contributions/2143/

Given the subtlety of some of these changes, and the upcoming holidays
I wanted to publish this well ahead of time for discussion. This is
the baseline patch set which predicates a new kind of mempolicy based
on NUMA node memory features - which can be defined by the components
adding memory to such NUMA nodes.

Included is an example of a Compressed Memory Node, and how compressed
RAM could be managed by zswap.  Compressed memory is its own rabbit
hole - I recommend not getting hung up on the example. 

The core discussion should be around whether such a "Protected Node"
based system is reasonable - and whether there are sufficient potential
users to warrant support.

Also please do not get hung up on naming. "Protected" just means
"Not-System-RAM".  If you see "Default" just assume "Systam RAM".

base-commit: 1c353dc8d962de652bc7ad2ba2e63f553331391c
-----------

With this set, we aim to enable allocation of "special purpose memory"
with the page allocator (mm/page_alloc.c) without exposing the same
memory as "Typical System RAM".  Unless a non-userland component
explicitly asks for the node, and does so with a GFP_PROTECTED flag,
memory on that node cannot be "accidentally" used as normal ram.

We present an example of using this mechanism within ZSWAP, as-if
a "compressed memory node" was present.  How to describe the features
of memory present on nodes is left up to comment here and at LPC '26.

Important Note: Since userspace interfaces are restricted by the
default_node mask (sysram), nothing in userspace can explicitly
request memory from protected nodes.  Instead, the intent is to
create new components which understand different node features,
which abstracts the hardware complexity away from userland.

The ZSWAP example demonstrates this with `mt_compressed_nodemask`
which is simply a hack to simply demonstrate the idea.

There are 4 major changes in this set:

1) Introducing default_sysram_nodes in mm/memory-tiers.c which denotes
   the set of default nodes which are eligible for use as normal sysram

   Some existing users noew pass default_sysram_nodes into the page
   allocator instead of NULL, but passing a NULL pointer in will simply
   have it replaced by default_sysram_nodes anyway.

   default_sysram_nodes is always guaranteed to contain the N_MEMORY
   nodes that were present at boot time, and so it can never be empty.


2) The addition of `cpuset.mems.default` which restricts cgroups to
   using `default_sysram_nodes` by default, while allowing non-sysram
   nodes into mems_effective (mems_allowed).

   This is done to allow separate control over sysram and protected node
   sets by cgroups while maintaining the hierarchical rules.

   current cpuset configuration
   cpuset.mems_allowed
    |.mems_effective         < (mems_allowed ∩ parent.mems_effective)
    |->tasks.mems_allowed    < cpuset.mems_effective

   new cpuset configuration
   cpuset.mems_allowed
    |.mems_effective        < (mems_allowed ∩ parent.mems_effective)
    |.mems_default          < (mems_effective ∩ default_sys_nodemask)
      |->task.mems_default  < cpuset.mems_default - (note renamed)

3) Addition of MHP_PROTECTED_MEMORY flag to denote to memory-hotplug
   that the memory capacity being added should mark the node as a
   protected memory node.  A node is either SysRAM or Protected, and
   cannot contain both (adding protected to an existing SysRAM node
   will result in EINVAL).

   DAX and CXL are made aware of the bit and have `protected_memory`
   bits added to their relevant subsystems.

4) Adding GFP_PROTECTED - which allows page_alloc.c to request memory
   from the provided node or nodemask.  It changes the behavior of
   the cpuset mems_allowed check.

   Probably there needs to be some additional work done here to
   restrict non-cgroup kernels.

Gregory Price (9):
  gfp: Add GFP_PROTECTED for protected-node allocations
  memory-tiers: create default_sysram_nodes
  mm: default slub, oom_kill, compaction, and page_alloc to sysram
  mm,cpusets: rename task->mems_allowed to task->mems_default
  cpuset: introduce cpuset.mems.default
  mm/memory_hotplug: add MHP_PROTECTED_MEMORY flag
  drivers/dax: add protected memory bit to dev_dax
  drivers/cxl: add protected_memory bit to cxl region
  [HACK] mm/zswap: compressed ram integration example

 drivers/cxl/core/region.c       |  30 ++++++
 drivers/cxl/cxl.h               |   2 +
 drivers/dax/bus.c               |  39 ++++++++
 drivers/dax/bus.h               |   1 +
 drivers/dax/cxl.c               |   1 +
 drivers/dax/dax-private.h       |   1 +
 drivers/dax/kmem.c              |   2 +
 fs/proc/array.c                 |   2 +-
 include/linux/cpuset.h          |  52 +++++------
 include/linux/gfp_types.h       |   3 +
 include/linux/memory-tiers.h    |   4 +
 include/linux/memory_hotplug.h  |  10 ++
 include/linux/mempolicy.h       |   2 +-
 include/linux/sched.h           |   6 +-
 init/init_task.c                |   2 +-
 kernel/cgroup/cpuset-internal.h |   8 ++
 kernel/cgroup/cpuset-v1.c       |   7 ++
 kernel/cgroup/cpuset.c          | 157 +++++++++++++++++++++-----------
 kernel/fork.c                   |   2 +-
 kernel/sched/fair.c             |   4 +-
 mm/hugetlb.c                    |   8 +-
 mm/memcontrol.c                 |   2 +-
 mm/memory-tiers.c               |  25 ++++-
 mm/memory_hotplug.c             |  25 +++++
 mm/mempolicy.c                  |  34 +++----
 mm/migrate.c                    |   4 +-
 mm/oom_kill.c                   |  11 ++-
 mm/page_alloc.c                 |  28 +++---
 mm/show_mem.c                   |   2 +-
 mm/slub.c                       |   4 +-
 mm/vmscan.c                     |   2 +-
 mm/zswap.c                      |  65 ++++++++++++-
 32 files changed, 411 insertions(+), 134 deletions(-)

-- 
2.51.1


