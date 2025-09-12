Return-Path: <linux-fsdevel+bounces-61045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD54B54B99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A2B467D37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88DF301485;
	Fri, 12 Sep 2025 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyhOAe9Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55F2957C2;
	Fri, 12 Sep 2025 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677980; cv=none; b=MKTw6A/X7iHjMGXfqTKRCNhKQgHMmWpx0OtYXMx9uClu+XYSreCY+cWTn5VMx0RUbQuqJ9zOCV3Bd0aD8cwTo1A36O1k98f3BtwIIJLO6r8niqfbnV4FunmfayphlwRuud4f2DZ4GJbxbVjqj/DMslZI49pqM0FKoAetdjil0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677980; c=relaxed/simple;
	bh=NmIyJJYs4LCcRYXbb9KAw9QgbmU7rJnHEjrNjnl2vwc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YmU785W0kb/qXUziohO0fgdUaJESy8D6k6+Xp6VA5VTsbV82g3kBki3R3QguBYzObf3lMXPL3Z+x0GVbY47iNwSq/vKv6+68IPssCCEGR5ocV3jWGQ3ILL2ZV3Z4kX/bc5JJb7fPrsN++OsI2GVMRubP5CuPuCPxEsC2KNFZrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyhOAe9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662D0C4CEF1;
	Fri, 12 Sep 2025 11:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677979;
	bh=NmIyJJYs4LCcRYXbb9KAw9QgbmU7rJnHEjrNjnl2vwc=;
	h=From:Subject:Date:To:Cc:From;
	b=hyhOAe9YjTHpuvO3AierKWjw5OD6myMMT9p9EcAITM9Pb1+NMH1wNQliBW4upbO8R
	 QKLEJTkZOFgy6Z7Rcv0TWlRM6KFx3wbCWIslNfJQePl2ar/NACLfIVPK0JL1g/FEk2
	 UVzJTaTZwpeS5oDpzxAq2Q0XeiyJAmJkrbdCsrmzy/2O5EdknZbZXqkgKD34w5Kt60
	 cXZutEgXWMkzZ5SfXX25tYjEbHnq08JT7p33wBaq9iN79MiJHJtDg+uiC57+8BNmVQ
	 sWORuSN82YYjCx/iPj7SywZx6RHpiSzNU9r/RWlkjqF0ywWC/uz9ptnOTs498c9DxA
	 YX25RtJ36IZdQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/33] ns: support file handles
Date: Fri, 12 Sep 2025 13:52:23 +0200
Message-Id: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHcJxGgC/12OQQ6DIBQFr9KwLgaooHbVezQuEH6VWMF8DG1jv
 HvRdNXlLObNW0kEdBDJ9bQShOSiCz6DOJ+IGbTvgTqbmQgmJGuYpK+AI/V6gjhrA9SouhbKWs1
 sSbI0Izzc+xi8t5k7HYF2qL0Z9plJxwWwSKrgFUXDd2VwcQn4OS4kvou/Gmf/tcQpo6W1UkF1k
 Y2tbyOgh2cRsCfttm1fpsF3PNAAAAA=
X-Change-ID: 20250905-work-namespace-c68826dda0d4
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=5785; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NmIyJJYs4LCcRYXbb9KAw9QgbmU7rJnHEjrNjnl2vwc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZwyI2lNaoVFPNf3BDnj5GaDXQxxN1I1fs9oWW367
 9frOfqeHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxu83IMH/VM39dsQ/zo04o
 iZVfafW8PHXXwzC+1TEyHJazH7zzns3I8DP76XfDrJULMx9GbpZJjbKKmZBxfmPTEbX26vULXRk
 dmAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

For a while now we have supported file handles for pidfds. This has
proven to be very useful.

Extend the concept to cover namespaces as well. After this patchset it
is possible to encode and decode namespace file handles using the
commong name_to_handle_at() and open_by_handle_at() apis.

Namespaces file descriptors can already be derived from pidfds which
means they aren't subject to overmount protection bugs. IOW, it's
irrelevant if the caller would not have access to an appropriate
/proc/<pid>/ns/ directory as they could always just derive the namespace
based on a pidfd already.

It has the same advantage as pidfds. It's possible to reliably and for
the lifetime of the system refer to a namespace without pinning any
resources and to compare them.

Permission checking is kept simple. If the caller is located in the
namespace the file handle refers to they are able to open it otherwise
they must hold privilege over the owning namespace of the relevant
namespace.

Both the network namespace and the mount namespace already have an
associated cookie that isn't recycled and is fully exposed to userspace.
Move this into ns_common and use the same id space for all namespaces so
they can trivially and reliably be compared.

There's more coming based on the iterator infrastructure but the series
is large enough and focuses on file handles.

Extensive selftests included.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Address various review comments.
- Use a common NS_GET_ID ioctl() instead of individual ioctls.
- Link to v1: https://lore.kernel.org/20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org

---
Christian Brauner (33):
      pidfs: validate extensible ioctls
      nsfs: drop tautological ioctl() check
      nsfs: validate extensible ioctls
      block: use extensible_ioctl_valid()
      ns: move to_ns_common() to ns_common.h
      nsfs: add nsfs.h header
      ns: uniformly initialize ns_common
      cgroup: use ns_common_init()
      ipc: use ns_common_init()
      mnt: use ns_common_init()
      net: use ns_common_init()
      pid: use ns_common_init()
      time: use ns_common_init()
      user: use ns_common_init()
      uts: use ns_common_init()
      ns: remove ns_alloc_inum()
      nstree: make iterator generic
      mnt: support ns lookup
      cgroup: support ns lookup
      ipc: support ns lookup
      net: support ns lookup
      pid: support ns lookup
      time: support ns lookup
      user: support ns lookup
      uts: support ns lookup
      ns: add to_<type>_ns() to respective headers
      nsfs: add current_in_namespace()
      nsfs: support file handles
      nsfs: support exhaustive file handles
      nsfs: add missing id retrieval support
      tools: update nsfs.h uapi header
      selftests/namespaces: add identifier selftests
      selftests/namespaces: add file handle selftests

 block/blk-integrity.c                              |    8 +-
 fs/fhandle.c                                       |    6 +
 fs/internal.h                                      |    1 +
 fs/mount.h                                         |   10 +-
 fs/namespace.c                                     |  156 +--
 fs/nsfs.c                                          |  201 ++-
 fs/pidfs.c                                         |    2 +-
 include/linux/cgroup.h                             |    5 +
 include/linux/exportfs.h                           |    6 +
 include/linux/fs.h                                 |   14 +
 include/linux/ipc_namespace.h                      |    5 +
 include/linux/ns_common.h                          |   29 +
 include/linux/nsfs.h                               |   40 +
 include/linux/nsproxy.h                            |   11 -
 include/linux/nstree.h                             |   89 ++
 include/linux/pid_namespace.h                      |    5 +
 include/linux/proc_ns.h                            |   32 +-
 include/linux/time_namespace.h                     |    9 +
 include/linux/user_namespace.h                     |    5 +
 include/linux/utsname.h                            |    5 +
 include/net/net_namespace.h                        |    6 +
 include/uapi/linux/fcntl.h                         |    1 +
 include/uapi/linux/nsfs.h                          |   15 +-
 init/main.c                                        |    2 +
 ipc/msgutil.c                                      |    1 +
 ipc/namespace.c                                    |   12 +-
 ipc/shm.c                                          |    2 +
 kernel/Makefile                                    |    2 +-
 kernel/cgroup/cgroup.c                             |    2 +
 kernel/cgroup/namespace.c                          |   24 +-
 kernel/nstree.c                                    |  233 ++++
 kernel/pid_namespace.c                             |   13 +-
 kernel/time/namespace.c                            |   23 +-
 kernel/user_namespace.c                            |   17 +-
 kernel/utsname.c                                   |   28 +-
 net/core/net_namespace.c                           |   59 +-
 tools/include/uapi/linux/nsfs.h                    |   17 +-
 tools/testing/selftests/namespaces/.gitignore      |    2 +
 tools/testing/selftests/namespaces/Makefile        |    7 +
 tools/testing/selftests/namespaces/config          |    7 +
 .../selftests/namespaces/file_handle_test.c        | 1429 ++++++++++++++++++++
 tools/testing/selftests/namespaces/nsid_test.c     |  986 ++++++++++++++
 42 files changed, 3257 insertions(+), 270 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250905-work-namespace-c68826dda0d4


