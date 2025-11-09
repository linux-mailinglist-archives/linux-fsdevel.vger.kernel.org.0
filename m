Return-Path: <linux-fsdevel+bounces-67608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5EBC4471D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 22:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D2394E4784
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460BF26B955;
	Sun,  9 Nov 2025 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXvP0mpx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572D537E9;
	Sun,  9 Nov 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762722799; cv=none; b=fwRo4gXk7c5jA0tJPNN0+92BkVgWtLCp+5YSkl94Gc1oAI15n5B2/7MTYmdMpY1nreWz4hU3aWK1WtIEvs38hhTqjoqgMhbXEDh6cRa1kGoVnUHs9b2H1jAUvhjV9CdD18aSXmrYlzuyG98Y8qWe6/bCe4V9ps+NqxmMS2wq5cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762722799; c=relaxed/simple;
	bh=7XNqneAJZkD31+B87Un/9oPOJDMkEukENXKqvVQgFwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Oz89mSZ4k9+JpXiZ0qbNoFpZybTjPIQ4plW5qiTtaHw+FcWB6VswkVd1sZva24Wdcd5e2T4Wz0i8B4tYe5l1ag9346mE8t2aFbSGbvml3xm/dttto8y6sc2YIrPFD+vr1QxXEjk1umU9qWXUuA8UtlfWSWIZBTfX5S8bd0DKr/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXvP0mpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7BBC4CEF7;
	Sun,  9 Nov 2025 21:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762722798;
	bh=7XNqneAJZkD31+B87Un/9oPOJDMkEukENXKqvVQgFwo=;
	h=From:Subject:Date:To:Cc:From;
	b=ZXvP0mpx2GZlmqqGorpb0j2F325nIpl6OZSi+z14gKFxUbRbwAkaKzbifFZ6bc92Y
	 +xlGKZ+IP1q0jgnVLPiQ2GwJ6ck0b3vOsBOyKha21SF6THjb7qnOxJR9BfRuqv9mK4
	 fqpU0Jx7x2N1zkd4hNTvZmQRSh4ii5FMSzR/FG8fOflJlnhmEdGJlTs+cSd68wtVzG
	 RcHH9uNfhGoTPCVO+yd8fyyTX7E+adNY8UwVhPy7NsVpAidckdYmthqM1HY98dmW37
	 x8ei81kE4vbiPapdLqEa6ihOy0R6e1wE6DYkiw+nlR3t2ZB3Hgc8886E67Js4+x1lP
	 pc/nq17c6kvvg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/8] ns: fixes for namespace iteration and active reference
 counting
Date: Sun, 09 Nov 2025 22:11:21 +0100
Message-Id: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkDEWkC/02MwQrCMAxAf2XkbGQprFJ/RTykNXU5WEcDIoz9u
 9lOHh+P91Yw6SoG12GFLh81fTcHOg1QZm5PQX04QxjDRDQmbPwSW7gIRqSEVb9iOOVca6olhng
 BT5cuh/DydnfObIK5cyvzPvt7nCnBtv0ACoz8G4cAAAA=
X-Change-ID: 20251109-namespace-6-19-fixes-5bbff9fc6267
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5203; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7XNqneAJZkD31+B87Un/9oPOJDMkEukENXKqvVQgFwo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKMr/YfvmA7FrlZeYP1Bi9pshbVHhaGqefctlXEuzgM
 81z5Ya0jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInoejIyNF2pvWNgdXrelIas
 sqoItuc/LGeGl4Vw9qz548cszbJuEcNv9rPHc8sFjfyzrtRl3oiVctz6aKbodE6rn+nLE3aHT/j
 NDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

* Make sure to initialize the active reference count for the initial
  network namespace and prevent __ns_common_init() from returning too
  early.

* Make sure that passive reference counts are dropped outside of rcu
  read locks as some namespaces such as the mount namespace do in fact
  sleep when putting the last reference.

* The setns() system call supports:

  (1) namespace file descriptors (nsfd)
  (2) process file descriptors (pidfd)

  When using nsfds the namespaces will remain active because they are
  pinned by the vfs. However, when pidfds are used things are more
  complicated.

  When the target task exits and passes through exit_nsproxy_namespaces()
  or is reaped and thus also passes through exit_cred_namespaces() after
  the setns()'ing task has called prepare_nsset() but before the active
  reference count of the set of namespaces it wants to setns() to might
  have been dropped already:

    P1                                                              P2

    pid_p1 = clone(CLONE_NEWUSER | CLONE_NEWNET | CLONE_NEWNS)
                                                                    pidfd = pidfd_open(pid_p1)
                                                                    setns(pidfd, CLONE_NEWUSER | CLONE_NEWNET | CLONE_NEWNS)
                                                                    prepare_nsset()

    exit(0)
    // ns->__ns_active_ref        == 1
    // parent_ns->__ns_active_ref == 1
    -> exit_nsproxy_namespaces()
    -> exit_cred_namespaces()

    // ns_active_ref_put() will also put
    // the reference on the owner of the
    // namespace. If the only reason the
    // owning namespace was alive was
    // because it was a parent of @ns
    // it's active reference count now goes
    // to zero... --------------------------------
    //                                           |
    // ns->__ns_active_ref        == 0           |
    // parent_ns->__ns_active_ref == 0           |
                                                 |                  commit_nsset()
                                                 -----------------> // If setns()
                                                                    // now manages to install the namespaces
                                                                    // it will call ns_active_ref_get()
                                                                    // on them thus bumping the active reference
                                                                    // count from zero again but without also
                                                                    // taking the required reference on the owner.
                                                                    // Thus we get:
                                                                    //
                                                                    // ns->__ns_active_ref        == 1
                                                                    // parent_ns->__ns_active_ref == 0

    When later someone does ns_active_ref_put() on @ns it will underflow
    parent_ns->__ns_active_ref leading to a splat from our asserts
    thinking there are still active references when in fact the counter
    just underflowed.

  So resurrect the ownership chain if necessary as well. If the caller
  succeeded to grab passive references to the set of namespaces the
  setns() should simply succeed even if the target task exists or gets
  reaped in the meantime.

  The race is rare and can only be triggered when using pidfs to setns()
  to namespaces. Also note that active reference on initial namespaces are
  nops.

  Since we now always handle parent references directly we can drop
  ns_ref_active_get_owner() when adding a namespace to a namespace tree.
  This is now all handled uniformly in the places where the new namespaces
  actually become active.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (8):
      ns: don't skip active reference count initialization
      ns: don't increment or decrement initial namespaces
      ns: make sure reference are dropped outside of rcu lock
      ns: return EFAULT on put_user() error
      ns: handle setns(pidfd, ...) cleanly
      ns: add asserts for active refcount underflow
      selftests/namespaces: add active reference count regression test
      selftests/namespaces: test for efault

 fs/nsfs.c                                          |   2 +-
 include/linux/ns_common.h                          |  49 +-
 kernel/nscommon.c                                  |  52 +-
 kernel/nstree.c                                    |  44 +-
 tools/testing/selftests/namespaces/.gitignore      |   2 +
 tools/testing/selftests/namespaces/Makefile        |   6 +-
 .../selftests/namespaces/listns_efault_test.c      | 521 +++++++++++++++++++++
 .../namespaces/regression_pidfd_setns_test.c       | 113 +++++
 8 files changed, 715 insertions(+), 74 deletions(-)
---
base-commit: 8ebfb9896c97ab609222460e705f425cb3f0aad0
change-id: 20251109-namespace-6-19-fixes-5bbff9fc6267


