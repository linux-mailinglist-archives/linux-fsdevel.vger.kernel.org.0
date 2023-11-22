Return-Path: <linux-fsdevel+bounces-3477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5277F5222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0099DB20F46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B891BDCB;
	Wed, 22 Nov 2023 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMN/NCn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E821A4;
	Wed, 22 Nov 2023 13:12:05 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso225062b3a.2;
        Wed, 22 Nov 2023 13:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687525; x=1701292325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndk4aGNdhF9GXKkpyyjsozTJ5amtXqJPp+cG2mKjtD0=;
        b=VMN/NCn/0ASAQmZ66hu4oESJL0srvFqyTlN0Uzf4h/QE9KDJ14ibkDOxebGQDBkWe4
         hzTSwiH8UTDvauJj5bIk4mEmxcGkF2eAXJglQCPFyE5yETJaV/jFigT3ZW9Dfgb+FY8h
         RPRa6ZUjSpEZ007Cb7K8XcWpgh41vN7M6Ai6aq9fbnfjRJdv+phB0zTLpl7IFVbbid3A
         B+iBWdf/vv9Ydfe/D6kWQJkpNmcpS1FStiGWo4NcsnPrSPNlTgYtuomKRVgdmX6fhjKg
         mDONSLCe5wFPb89F3oDFROwkdMNqk8i5Tjt1Imb8ab6Zuc1su/nUQEgMGmbtEuDRx5BG
         sjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687525; x=1701292325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndk4aGNdhF9GXKkpyyjsozTJ5amtXqJPp+cG2mKjtD0=;
        b=JeJQ3VqkcpnGaCbvXw6Vl7bbQE0SYJzbEkILqXoR8OxZQBGxNnv6frIEMnwnmbLEPk
         p9qnPOptTurKSEHtSQOpxlGVGOB22fpv1TeeVsoHD/pW7cv3XMkg9ObxF4EFhW4KRcps
         rGlkzA6vVN/hFDFU//KYHHAGx17IWuATqkRFNcsccKlt+JRTOtgSj+OkOOLZ7op2zRn5
         Betn7mZMwxzSQNS8Xp82YGa41WZBJKfucWv/wA/sPhGhiDA4SCkhpG+c+jHqslvaisjG
         LNm3vwcSAOFfhh28FR2ZyVIXnKE/mPR9e7mpjNRDmQ3ASb5f7oIubDg4bvcmOKGNJZ4v
         S1Rw==
X-Gm-Message-State: AOJu0YzOgWEEJC+DERJKHSMA6Fmle4jOvorap+aXMZXnPehYaWJZf8CN
	SsEZ/Ir+ZUfyjMnfhfstEQ==
X-Google-Smtp-Source: AGHT+IHtVS6qiXCVuICpjIo9v1ArG+K49q8MxhuOD/We1+xNdIENUBBwie8jAWodVY5lm/jNcHZQ+w==
X-Received: by 2002:a05:6a20:12cd:b0:189:3748:f060 with SMTP id v13-20020a056a2012cd00b001893748f060mr3765980pzg.26.1700687525147;
        Wed, 22 Nov 2023 13:12:05 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:04 -0800 (PST)
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
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 00/11] mm/mempolicy: Make task->mempolicy externally modifiable via syscall and procfs
Date: Wed, 22 Nov 2023 16:11:49 -0500
Message-Id: <20231122211200.31620-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch set changes task->mempolicy to be modifiable by tasks other
than just current.

The ultimate goal is to make mempolicy more flexible and extensible,
such as adding interleave weights (which may need to change at runtime
due to hotplug events).  Making mempolicy externally modifiable allows
for userland daemons to make runtime performance adjustments to running
tasks without that software needing to be made numa-aware.

This initial RFC involves 3 major updates the mempolicy.

1. Refactor modifying interfaces to accept a task as an argument,
   and change existing callers to send `current` in to retain
   the existing behavior.

2. Change locking behaviors to ensure task->mpol is referenced
   safely by acquiring the task_lock where required.  Since
   allocators take the alloc lock (task lock), this successfully
   prevents changes from being made during allocations.

3. Add external interfaces which allow for a task mempolicy to be
   modified by another task.  This is implemented in 4 syscalls
   and a procfs interface:
        sys_set_task_mempolicy
        sys_get_task_mempolicy
        sys_set_task_mempolicy_home_node
        sys_task_mbind
        /proc/[pid]/mempolicy

The new syscalls are the same as their current-task counterparts,
except that they take a pid as an argument.  The exception is
task_mbind, which required a new struct due to the number of args.

The /proc/pid/mempolicy re-uses the interface mpol_parse_str format
to enable get/set of mempolicy via procsfs.

mpol_parse_str format:
            <mode>[=<flags>][:<nodelist>]

Example usage:

echo "default" > /proc/pid/mempolicy
echo "prefer=relative:0" > /proc/pid/mempolicy
echo "interleave:0-3" > /proc/pid/mempolicy

Changing the mempolicy does not induce memory migrations via the
procfs interface (which is the exact same behavior as set_mempolicy).

Signed-off-by: Gregory Price <gregory.price@memverge.com>

Gregory Price (11):
  mm/mempolicy: refactor do_set_mempolicy for code re-use
  mm/mempolicy: swap cond reference counting logic in do_get_mempolicy
  mm/mempolicy: refactor set_mempolicy stack to take a task argument
  mm/mempolicy: modify get_mempolicy call stack to take a task argument
  mm/mempolicy: modify set_mempolicy_home_node to take a task argument
  mm/mempolicy: modify do_mbind to operate on task argument instead of
    current
  mm/mempolicy: add task mempolicy syscall variants
  mm/mempolicy: export replace_mempolicy for use by procfs
  mm/mempolicy: build mpol_parse_str unconditionally
  mm/mempolicy: mpol_parse_str should ignore trailing characters in
    nodelist
  fs/proc: Add mempolicy attribute to allow read/write of task mempolicy

 arch/x86/entry/syscalls/syscall_32.tbl |   4 +
 arch/x86/entry/syscalls/syscall_64.tbl |   4 +
 fs/proc/Makefile                       |   1 +
 fs/proc/base.c                         |   1 +
 fs/proc/internal.h                     |   1 +
 fs/proc/mempolicy.c                    | 117 +++++++
 include/linux/mempolicy.h              |  13 +-
 include/linux/syscalls.h               |  14 +
 include/uapi/asm-generic/unistd.h      |  10 +-
 include/uapi/linux/mempolicy.h         |  10 +
 mm/mempolicy.c                         | 432 +++++++++++++++++++------
 11 files changed, 502 insertions(+), 105 deletions(-)
 create mode 100644 fs/proc/mempolicy.c

-- 
2.39.1


