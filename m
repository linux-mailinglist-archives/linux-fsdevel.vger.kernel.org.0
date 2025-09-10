Return-Path: <linux-fsdevel+bounces-60774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C9EB5198E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFE63BB44C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C1132BF24;
	Wed, 10 Sep 2025 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ply1gfTD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C38298994;
	Wed, 10 Sep 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515025; cv=none; b=AuyL4qBADfwLAg/18HjZOLlKYmW57Bg1VHfvs3dkvVCkaVjMoxrpQTwexyrPLCyaF3XbaPiT2y7PtWSS6zk41LK4miBhro3E/r/L8a5Z1ZAv9RrGltESccok14OXQssjncj2QPLSjVbclylwIqg6opx93ZVDgP7j3Pjhve3xpFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515025; c=relaxed/simple;
	bh=29JCSfGuYzyRn8o97QCN0am5XLSW+0yBJ9vdb9NvVOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E0xP+0uAAn8/MAn4SJoL8TttFC/jh3wEUUrzH7HnQ7lNq1Vzmr24sgo+o7Nn2+HcWTCgcm2CcxKYWjibRy7d1ZPt0JwiqaIkZ2YN/Xdak2JMvf4oPQfgQOozR20aYc/uNJilklqXh0dAG6Mljf6Sxi7ljU8ZZHlou3iv+rtOEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ply1gfTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0677C4CEEB;
	Wed, 10 Sep 2025 14:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515024;
	bh=29JCSfGuYzyRn8o97QCN0am5XLSW+0yBJ9vdb9NvVOA=;
	h=From:Subject:Date:To:Cc:From;
	b=ply1gfTDPLahptTIk5N6WND1mewN4KFa9zI23F4ZjeXo9zwOxuxediKAZ8dgvhSrW
	 G3G2F8OjR+28VHNwRpAk7FotLKfVoOs4f+aiMIqjExP7xmCaOaV3XqVwmjzdlw0G03
	 ptK8BQfTvt7lpG1dvYiMxF5GqI7V+lNuPL07WFmYTB7qnopFGmFZd98POouRUU4xM+
	 bHPV1NRgYeJEJNwZFo9yvQ6vY44rxX4JkiI73hGZuWiVzw+E5ds/vAKqpVsz3jeD05
	 icqB9S3DaY+Bp6t5PEn7RBafOmRmZ9o5QZicpgbKJKStFEosSHhXP71AYDov3Eqct2
	 7HfgR//jDf6EQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/32] ns: support file handles
Date: Wed, 10 Sep 2025 16:36:45 +0200
Message-Id: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6MwWgC/x3MwQ6CMAyA4VchPVuyLTLRVzEeSldlMQzSGjQhv
 LvT43f4/w1MNIvBpdlAZc2W51LhDw3wSOUhmFM1BBc6d3Ydvmd9YqFJbCEW5Nj3IaZELh2hRov
 KPX/+w+uteiATHJQKj7/NRPYSbdfY+hMqe9j3L+fOymWDAAAA
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
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=5591; i=brauner@kernel.org;
 h=from:subject:message-id; bh=29JCSfGuYzyRn8o97QCN0am5XLSW+0yBJ9vdb9NvVOA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7GU/cGwNl6TVTYXIpcb7q5bN3rt9Mve/4mB15VYxy
 6Iwb0b5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgJvsxcgwJVb7npojv+6Jix9S
 ito5N9szLrwW/Gzz9uTb5n1rL93azMjQq7xrwykO5xxm/Vsf/VxsYoMesnhwhkry77y27kpoUSc
 fAA==
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

Extensive selftests included. I still have various other test-suites to
run but it holds up so far.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (32):
      pidfs: validate extensible ioctls
      nsfs: validate extensible ioctls
      block: use extensible_ioctl_valid()
      ns: move to_ns_common() to ns_common.h
      nsfs: add nsfs.h header
      ns: uniformly initialize ns_common
      mnt: use ns_common_init()
      ipc: use ns_common_init()
      cgroup: use ns_common_init()
      pid: use ns_common_init()
      time: use ns_common_init()
      uts: use ns_common_init()
      user: use ns_common_init()
      net: use ns_common_init()
      ns: remove ns_alloc_inum()
      nstree: make iterator generic
      mnt: support iterator
      cgroup: support iterator
      ipc: support iterator
      net: support iterator
      pid: support iterator
      time: support iterator
      userns: support iterator
      uts: support iterator
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
 fs/nsfs.c                                          |  266 +++-
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
 include/uapi/linux/nsfs.h                          |   12 +-
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
 tools/include/uapi/linux/nsfs.h                    |   23 +-
 tools/testing/selftests/namespaces/.gitignore      |    2 +
 tools/testing/selftests/namespaces/Makefile        |    7 +
 tools/testing/selftests/namespaces/config          |    7 +
 .../selftests/namespaces/file_handle_test.c        | 1410 ++++++++++++++++++++
 tools/testing/selftests/namespaces/nsid_test.c     |  986 ++++++++++++++
 42 files changed, 3306 insertions(+), 270 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250905-work-namespace-c68826dda0d4


