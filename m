Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45F2F162845
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 15:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgBROff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 09:35:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52968 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgBROfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:35:34 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j43xo-0000fF-JZ; Tue, 18 Feb 2020 14:35:04 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 00/25] user_namespace: introduce fsid mappings
Date:   Tue, 18 Feb 2020 15:33:46 +0100
Message-Id: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

This is v3 after (off- and online) discussions with Jann the following
changes were made:
- To handle nested user namespaces cleanly, efficiently, and with full
  backwards compatibility for non fsid-mapping aware workloads we only
  allow writing fsid mappings as long as the corresponding id mapping
  type has not been written.
- Split the patch which adds the internal ability in
  kernel/user_namespace to verify and write fsid mappings into tree
  patches:
  1. [PATCH v3 04/25] fsuidgid: add fsid mapping helpers
     patch to implement core helpers for fsid translations (i.e.
     make_kfs*id(), from_kfs*id{_munged}(), kfs*id_to_k*id(),
     k*id_to_kfs*id()
  2. [PATCH v3 05/25] user_namespace: refactor map_write()
     patch to refactor map_write() in order to prepare for actual fsid
     mappings changes in the following patch. (This should make it
     easier to review.)
  3. [PATCH v3 06/25] user_namespace: make map_write() support fsid mappings
     patch to implement actual fsid mappings support in mape_write()
- Let the keyctl infrastructure only operate on kfsid which are always
  mapped/looked up in the id mappings similar to what we do for
  filesystems that have the same superblock visible in multiple user
  namespaces.

This version also comes with minimal tests which I intend to expand in
the future.

From pings and off-list questions and discussions at Google Container
Security Summit there seems to be quite a lot of interest in this
patchset with use-cases ranging from layer sharing for app containers
and k8s, as well as data sharing between containers with different id
mappings. I haven't Cced all people because I don't have all the email
adresses at hand but I've at least added Phil now. :)

This is the implementation of shiftfs which was cooked up during lunch at
Linux Plumbers 2019 the day after the container's microconference. The
idea is a design-stew from Stéphane, Aleksa, Eric, and myself (and by
now also Jann.
Back then we all were quite busy with other work and couldn't really sit
down and implement it. But I took a few days last week to do this work,
including demos and performance testing.
This implementation does not require us to touch the VFS substantially
at all. Instead, we implement shiftfs via fsid mappings.
With this patch, it took me 20 mins to port both LXD and LXC to support
shiftfs via fsid mappings.

For anyone wanting to play with this the branch can be pulled from:
https://github.com/brauner/linux/tree/fsid_mappings
https://gitlab.com/brauner/linux/-/tree/fsid_mappings
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fsid_mappings

The main use case for shiftfs for us is in allowing shared writable
storage to multiple containers using non-overlapping id mappings.
In such a scenario you want the fsids to be valid and identical in both
containers for the shared mount. A demo for this exists in [3].
If you don't want to read on, go straight to the other demos below in
[1] and [2].

People not as familiar with user namespaces might not be aware that fsid
mappings already exist. Right now, fsid mappings are always identical to
id mappings. Specifically, the kernel will lookup fsuids in the uid
mappings and fsgids in the gid mappings of the relevant user namespace.

With this patch series we simply introduce the ability to create fsid
mappings that are different from the id mappings of a user namespace.
The whole feature set is placed under a config option that defaults to
false.

In the usual case of running an unprivileged container we will have
setup an id mapping, e.g. 0 100000 100000. The on-disk mapping will
correspond to this id mapping, i.e. all files which we want to appear as
0:0 inside the user namespace will be chowned to 100000:100000 on the
host. This works, because whenever the kernel needs to do a filesystem
access it will lookup the corresponding uid and gid in the idmapping
tables of the container.
Now think about the case where we want to have an id mapping of 0 100000
100000 but an on-disk mapping of 0 300000 100000 which is needed to e.g.
share a single on-disk mapping with multiple containers that all have
different id mappings.
This will be problematic. Whenever a filesystem access is requested, the
kernel will now try to lookup a mapping for 300000 in the id mapping
tables of the user namespace but since there is none the files will
appear to be owned by the overflow id, i.e. usually 65534:65534 or
nobody:nogroup.

With fsid mappings we can solve this by writing an id mapping of 0
100000 100000 and an fsid mapping of 0 300000 100000. On filesystem
access the kernel will now lookup the mapping for 300000 in the fsid
mapping tables of the user namespace. And since such a mapping exists,
the corresponding files will have correct ownership.

A note on proc (and sys), the proc filesystem is special in sofar as it
only has a single superblock that is (currently but might be about to
change) visible in all user namespaces (same goes for sys). This means
it has special semantics in many ways, including how file ownership and
access works. The fsid mapping implementation does not alter how proc
(and sys) ownership works. proc and sys will both continue to lookup
filesystem access in id mapping tables.

When Writing fsid mappings the same rules apply as when writing id
mappings so I won't reiterate them here. The limit of fs id mappings is
the same as for id mappings, i.e. 340 lines.

# Performance
Back when I extended the range of possible id mappings to 340 I did
performance testing by booting into single user mode, creating 1,000,000
files to fstat()ing them and calculated the mean fstat() time per file.
(Back when Linux was still fast. I won't mention that the stat
 numbers have (thanks microcode!) doubled since then...)
I did the same test for this patchset: one vanilla kernel, one kernel
with my fsid mapping patches but CONFIG_USER_NS_FSID set to n and one
with fsid mappings patches enabled. I then ran the same test on all
three kernels and compared the numbers. The implementation does not
introduce overhead. That's all I can say. Here are the numbers:

             | vanilla v5.5 | fsid mappings       | fsid mappings      | fsid mappings      |
	     |              | disabled in Kconfig | enabled in Kconfig | enabled in Kconfig |
	     |   	    |                     | and unset for all  | and set for all    |
	     |   	    |    		  | test cases         | test cases         |
-------------|--------------|---------------------|--------------------|--------------------|
 0  mappings |       367 ns |              365 ns |             365 ns |             N/A    |
 1  mappings |       362 ns |              367 ns |             363 ns |             363 ns |
 2  mappings |       361 ns |              369 ns |             363 ns |             364 ns |
 3  mappings |       361 ns |              368 ns |             366 ns |             365 ns |
 5  mappings |       365 ns |              368 ns |             363 ns |             365 ns |
 10 mappings |       391 ns |              388 ns |             387 ns |             389 ns |
 50 mappings |       395 ns |              398 ns |             401 ns |             397 ns |
100 mappings |       400 ns |              405 ns |             399 ns |             399 ns |
200 mappings |       404 ns |              407 ns |             430 ns |             404 ns |
300 mappings |       492 ns |              494 ns |             432 ns |             413 ns |
340 mappings |       495 ns |              497 ns |             500 ns |             484 ns |

# Demos
[1]: Create a container with different id and fsid mappings.
     https://asciinema.org/a/300233 
[2]: Create a container with id mappings but without fsid mappings.
     https://asciinema.org/a/300234
[3]: Share storage between multiple containers with non-overlapping id
     mappings.
     https://asciinema.org/a/300235

Thanks!
Christian

Christian Brauner (25):
  user_namespace: introduce fsid mappings infrastructure
  proc: add /proc/<pid>/fsuid_map
  proc: add /proc/<pid>/fsgid_map
  fsuidgid: add fsid mapping helpers
  user_namespace: refactor map_write()
  user_namespace: make map_write() support fsid mappings
  proc: task_state(): use from_kfs{g,u}id_munged
  cred: add kfs{g,u}id
  fs: add is_userns_visible() helper
  namei: may_{o_}create(): handle fsid mappings
  inode: inode_owner_or_capable(): handle fsid mappings
  capability: privileged_wrt_inode_uidgid(): handle fsid mappings
  stat: handle fsid mappings
  open: handle fsid mappings
  posix_acl: handle fsid mappings
  attr: notify_change(): handle fsid mappings
  commoncap: cap_bprm_set_creds(): handle fsid mappings
  commoncap: cap_task_fix_setuid(): handle fsid mappings
  commoncap: handle fsid mappings with vfs caps
  exec: bprm_fill_uid(): handle fsid mappings
  ptrace: adapt ptrace_may_access() to always uses unmapped fsids
  devpts: handle fsid mappings
  keys: handle fsid mappings
  sys: handle fsid mappings in set*id() calls
  selftests: add simple fsid mapping selftests

 fs/attr.c                                     |  23 +-
 fs/devpts/inode.c                             |   7 +-
 fs/exec.c                                     |  25 +-
 fs/inode.c                                    |   7 +-
 fs/namei.c                                    |  36 +-
 fs/open.c                                     |  16 +-
 fs/posix_acl.c                                |  17 +-
 fs/proc/array.c                               |   5 +-
 fs/proc/base.c                                |  34 ++
 fs/stat.c                                     |  48 +-
 include/linux/cred.h                          |   4 +
 include/linux/fs.h                            |   5 +
 include/linux/fsuidgid.h                      | 122 +++++
 include/linux/stat.h                          |   1 +
 include/linux/user_namespace.h                |  10 +
 init/Kconfig                                  |  11 +
 kernel/capability.c                           |  10 +-
 kernel/ptrace.c                               |   4 +-
 kernel/sys.c                                  | 106 +++-
 kernel/user.c                                 |  22 +
 kernel/user_namespace.c                       | 517 ++++++++++++++++--
 security/commoncap.c                          |  35 +-
 security/keys/key.c                           |   2 +-
 security/keys/permission.c                    |   4 +-
 security/keys/process_keys.c                  |   6 +-
 security/keys/request_key.c                   |  10 +-
 security/keys/request_key_auth.c              |   2 +-
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/user_namespace/Makefile |  11 +
 .../selftests/user_namespace/test_fsid_map.c  | 511 +++++++++++++++++
 30 files changed, 1461 insertions(+), 151 deletions(-)
 create mode 100644 include/linux/fsuidgid.h
 create mode 100644 tools/testing/selftests/user_namespace/Makefile
 create mode 100644 tools/testing/selftests/user_namespace/test_fsid_map.c


base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
-- 
2.25.0

