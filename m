Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3BA457B5B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 05:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbhKTExh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 23:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbhKTExQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:53:16 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F1BC061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:14 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p24-20020a170902a41800b001438d6c7d71so5719440plq.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=GBPQGTJqAilqh8R2ionmFa146IW13gdDGdP75NfAh5o=;
        b=AI76jn8x9yBui/uf8c/CHqDoXt1YKDeQ3ejTzNhwVx3AYVrNJuNAhhKytb8tZenR1n
         kUouCLsIlq7x5otTGqJnCHWF+Bw9Wnlc9CKS1HE7EUVcypMvli7CFtv1SEGENs8iWbx1
         GYgkP8NgeT/ki8yAgKEqpdvlyUHUpAWFNsr51QSQc0EV+rtO/p+tb6SVFEMBpqwM9RqS
         hPOvveOj4yYZa6bKsotdfFz5nej3riOk6ORe20UjZEPf+7WRmHCmH0i4pmdnMUc1YcW0
         MHwiT5YAKb8IK5q8XZBxW7Rc5omvgZ9ArCrtvNm4eyxZ5lydv+aw/A+beKp73P5RVTo0
         VvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=GBPQGTJqAilqh8R2ionmFa146IW13gdDGdP75NfAh5o=;
        b=wdBMI91dCJjWGjcNhWUyDuSrk7ODoSkaTcjPL4oyToLt0HhePovChjAJ3i7JxF6RGM
         Ho7uBaJ7aeMEKG4v0m3G/UspdAbi9XxDYGpjYJFLBK5Eatv5635xIfXySgOdGPcEnrhZ
         S266VmMkD9Y+t0/rpcJJcFK13ebshQgISnhsH/Fvw92lseLNGerelP/bYAgl28UyMKgy
         4KJjv2muhoRA7KeXx999V+Ycx+Z4Ivvv5W5obMiqgFWu7LIepDLbpIJWIl7kwUGte4QK
         oycRBFiLMUDa+yFLlepviH7LGS+LGNNTWEQVTaq/MPA8d7AEq/2KVDuF3J3OZ6cFzTvS
         iMUQ==
X-Gm-Message-State: AOAM532d8vKkw2goSartLqcO5PxBVD1ECp9Ysi60y/deppRd+/RCVvta
        LRK6uzkWtEHKLi8wtjBvxcVQvy1pIwTLPzZgHw==
X-Google-Smtp-Source: ABdhPJwrO0XgJB6QQxq1EPt6/q2hs1MEyfssdTw0iP25RRfThEqdaTu1q3184prBGMof/2GyU5urMyNqZ+9MO3zZVw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:fa91:560a:d7b4:93])
 (user=almasrymina job=sendgmr) by 2002:a17:90b:1c86:: with SMTP id
 oo6mr6684834pjb.165.1637383813809; Fri, 19 Nov 2021 20:50:13 -0800 (PST)
Date:   Fri, 19 Nov 2021 20:50:06 -0800
Message-Id: <20211120045011.3074840-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v4 0/4] Deterministic charging of shared memory
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Problem:
Currently shared memory is charged to the memcg of the allocating
process. This makes memory usage of processes accessing shared memory
a bit unpredictable since whichever process accesses the memory first
will get charged. We have a number of use cases where our userspace
would like deterministic charging of shared memory:

1. System services allocating memory for client jobs:
We have services (namely a network access service[1]) that provide
functionality for clients running on the machine and allocate memory
to carry out these services. The memory usage of these services
depends on the number of jobs running on the machine and the nature of
the requests made to the service, which makes the memory usage of
these services hard to predict and thus hard to limit via memory.max.
These system services would like a way to allocate memory and instruct
the kernel to charge this memory to the client=E2=80=99s memcg.

2. Shared filesystem between subtasks of a large job
Our infrastructure has large meta jobs such as kubernetes which spawn
multiple subtasks which share a tmpfs mount. These jobs and its
subtasks use that tmpfs mount for various purposes such as data
sharing or persistent data between the subtask restarts. In kubernetes
terminology, the meta job is similar to pods and subtasks are
containers under pods. We want the shared memory to be
deterministically charged to the kubernetes's pod and independent to
the lifetime of containers under the pod.

3. Shared libraries and language runtimes shared between independent jobs.
We=E2=80=99d like to optimize memory usage on the machine by sharing librar=
ies
and language runtimes of many of the processes running on our machines
in separate memcgs. This produces a side effect that one job may be
unlucky to be the first to access many of the libraries and may get
oom killed as all the cached files get charged to it.

Design:
My rough proposal to solve this problem is to simply add a
=E2=80=98memcg=3D/path/to/memcg=E2=80=99 mount option for filesystems:
directing all the memory of the file system to be =E2=80=98remote charged=
=E2=80=99 to
cgroup provided by that memcg=3D option.

Caveats:

1. One complication to address is the behavior when the target memcg
hits its memory.max limit because of remote charging. In this case the
oom-killer will be invoked, but the oom-killer may not find anything
to kill in the target memcg being charged. Thera are a number of considerat=
ions
in this case:

1. It's not great to kill the allocating process since the allocating proce=
ss
   is not running in the memcg under oom, and killing it will not free memo=
ry
   in the memcg under oom.
2. Pagefaults may hit the memcg limit, and we need to handle the pagefault
   somehow. If not, the process will forever loop the pagefault in the upst=
ream
   kernel.

In this case, I propose simply failing the remote charge and returning an E=
NOSPC
to the caller. This will cause will cause the process executing the remote
charge to get an ENOSPC in non-pagefault paths, and get a SIGBUS on the pag=
efault
path.  This will be documented behavior of remote charging, and this featur=
e is
opt-in. Users can:
- Not opt-into the feature if they want.
- Opt-into the feature and accept the risk of received ENOSPC or SIGBUS and
  abort if they desire.
- Gracefully handle any resulting ENOSPC or SIGBUS errors and continue thei=
r
  operation without executing the remote charge if possible.

2. Only processes allowed the enter cgroup at mount time can mount a
tmpfs with memcg=3D<cgroup>. This is to prevent intential DoS of random cgr=
oups
on the machine. However, once a filesysetem is mounted with memcg=3D<cgroup=
>, any
process with write access to this mount point will be able to charge memory=
 to
<cgroup>. This is largely a non-issue because in configurations where there=
 is
untrusted code running on the machine, mount point access needs to be
restricted to the intended users only regardless of whether the mount point
memory is deterministly charged or not.

[1] https://research.google/pubs/pub48630

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

Mina Almasry (4):
  mm: support deterministic memory charging of filesystems
  mm/oom: handle remote ooms
  mm, shmem: add filesystem memcg=3D option documentation
  mm, shmem, selftests: add tmpfs memcg=3D mount option tests

 Documentation/filesystems/tmpfs.rst       |  28 ++++
 fs/fs_context.c                           |  27 ++++
 fs/proc_namespace.c                       |   4 +
 fs/super.c                                |   9 ++
 include/linux/fs.h                        |   5 +
 include/linux/fs_context.h                |   2 +
 include/linux/memcontrol.h                |  38 +++++
 mm/filemap.c                              |   2 +-
 mm/khugepaged.c                           |   3 +-
 mm/memcontrol.c                           | 171 ++++++++++++++++++++++
 mm/oom_kill.c                             |   9 ++
 mm/shmem.c                                |   3 +-
 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/mmap_write.c   | 103 +++++++++++++
 tools/testing/selftests/vm/tmpfs-memcg.sh | 116 +++++++++++++++
 15 files changed, 518 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/vm/mmap_write.c
 create mode 100755 tools/testing/selftests/vm/tmpfs-memcg.sh

--
2.34.0.rc2.393.gf8c9666880-goog
