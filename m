Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE5D400BF4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Sep 2021 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhIDPr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Sep 2021 11:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230312AbhIDPr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Sep 2021 11:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630770385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KB4LyBJtSm5CI3uG6bfxxb/7LkVLVb9zKUda/iwjkb8=;
        b=L0O6B4QvHv0h+4oW1F+sBrVClMVgzxrTkFrQs3Uj1Nck8MkvSxxVCf2G2OFIgk4BxzKs0T
        fEoHU7BZCqcBy0KzHxpJomzlus1gDtv6ZOTdWPOGxiPBs4U65blceEKkWWs9uDZqYZSn0U
        njVVvI1iPR4SRsfR7QxzcDDq9qYqTrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-jPXRAm-mOjKLcyoUZRMJDQ-1; Sat, 04 Sep 2021 11:46:24 -0400
X-MC-Unique: jPXRAm-mOjKLcyoUZRMJDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 854E3779;
        Sat,  4 Sep 2021 15:46:23 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 593E55C1D1;
        Sat,  4 Sep 2021 15:46:18 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>
Subject: [GIT PULL] Remove in-tree usage of MAP_DENYWRITE
Date:   Sat,  4 Sep 2021 17:46:17 +0200
Message-Id: <20210904154617.4189-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

as discussed ...

The following changes since commit 7d2a07b769330c34b4deabeed939325c77a7ec2f:

  Linux 5.14 (2021-08-29 15:04:50 -0700)

are available in the Git repository at:

  https://github.com/davidhildenbrand/linux.git tags/denywrite-for-5.15

for you to fetch changes up to 592ca09be8333bd226f50100328a905bfc377133:

  fs: update documentation of get_write_access() and friends (2021-09-03 18:42:02 +0200)

----------------------------------------------------------------
Remove in-tree usage of MAP_DENYWRITE

Remove all in-tree usage of MAP_DENYWRITE from the kernel and remove
VM_DENYWRITE.

There are some (minor) user-visible changes:
1. We no longer deny write access to shared libaries loaded via legacy
   uselib(); this behavior matches modern user space e.g., via dlopen().
2. We no longer deny write access to the elf interpreter after exec
   completed, treating it just like shared libraries (which it often is).
3. We always deny write access to the file linked via /proc/pid/exe:
   sys_prctl(PR_SET_MM_MAP/EXE_FILE) will fail if write access to the file
   cannot be denied, and write access to the file will remain denied
   until the link is effectivel gone (exec, termination,
   sys_prctl(PR_SET_MM_MAP/EXE_FILE)) -- just as if exec'ing the file.

Cross-compiled for a bunch of architectures (alpha, microblaze, i386,
s390x, ...) and verified via ltp that especially the relevant tests
(i.e., creat07 and execve04) continue working as expected.

Signed-off-by: David Hildenbrand <david@redhat.com>

----------------------------------------------------------------
David Hildenbrand (7):
      binfmt: don't use MAP_DENYWRITE when loading shared libraries via uselib()
      kernel/fork: factor out replacing the current MM exe_file
      kernel/fork: always deny write access to current MM exe_file
      binfmt: remove in-tree usage of MAP_DENYWRITE
      mm: remove VM_DENYWRITE
      mm: ignore MAP_DENYWRITE in ksys_mmap_pgoff()
      fs: update documentation of get_write_access() and friends

 arch/x86/ia32/ia32_aout.c      |  8 ++--
 fs/binfmt_aout.c               |  7 ++--
 fs/binfmt_elf.c                |  6 +--
 fs/binfmt_elf_fdpic.c          |  2 +-
 fs/exec.c                      |  4 +-
 fs/proc/task_mmu.c             |  1 -
 include/linux/fs.h             | 19 +++++----
 include/linux/mm.h             |  4 +-
 include/linux/mman.h           |  4 +-
 include/trace/events/mmflags.h |  1 -
 kernel/events/core.c           |  2 -
 kernel/fork.c                  | 95 +++++++++++++++++++++++++++++++++++++-----
 kernel/sys.c                   | 33 +--------------
 lib/test_printf.c              |  5 +--
 mm/mmap.c                      | 29 ++-----------
 mm/nommu.c                     |  2 -
 16 files changed, 119 insertions(+), 103 deletions(-)

