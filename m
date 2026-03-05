Return-Path: <linux-fsdevel+bounces-79525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFj9DRYSqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:30:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 884D521945B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E765A301BCCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9FD368260;
	Thu,  5 Mar 2026 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wvf9MiR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9B2882C5;
	Thu,  5 Mar 2026 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753421; cv=none; b=dA0eWZXczU6hMMMaFevbdwxMaewOpBXGfwFxjMis+NbNK5AnseuU0933c3y5O9VEBPqTjgNhaxAhkFm1iOXnSYKYx4mdEQKF819ML+srVQ87P1wmiqMTALVdk9r/bjrZlmcHQTlIAVnaI90HjW8ttRZ3gMic477EuW8omVt9xoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753421; c=relaxed/simple;
	bh=ZsAGlBz1CyKV2VvyptIgwFqZAWzj9f2Brv8ig855zX4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iqm+qR43+pWikJGQgikI8CzS+itJo740rkEw42/RGyDfYwyxR369kSB3mnZ3V5/Ru2wRhu63jiwnyA6r9oT/Ox0XDjUyHiH1ofxjkiI/HsyCALh5xxQtUvNBH4iMreX5vZZlmjpnGnywJwse6pkQ9nShAJxz2BxMLEvSPDD+FPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wvf9MiR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E153C116C6;
	Thu,  5 Mar 2026 23:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753421;
	bh=ZsAGlBz1CyKV2VvyptIgwFqZAWzj9f2Brv8ig855zX4=;
	h=From:Subject:Date:To:Cc:From;
	b=Wvf9MiR42vNZ6Fo5J9RVqMowipmzpNNVVs5Fhz0jKb9UXdLQ1MtMBOOYNJsk9IhJj
	 sL8GsjczGqp1bdxLT3/5s/aViG9923n5PD5wkecy84uW6s+y+ZZnFPH6E9Qhz+ZV2T
	 +0jszuOpBYNYli77HyND0WKyfNrpIogxWs9+thZJckBkCdUlbl0DvmV9Pdn0c6dF1K
	 PaP88NGD7uYSIuGKbdQGp8ZRYCRc423MatCCkKejHpqvHmYIKMDgb9Wkxjq5E67YiF
	 vdpbP3mDCL8xHa9zDbE+fw9hzjLPBOxuVXNvgJo07jJJlpKWItkAcTPJ+iu4eiMWMp
	 vH9/dCXkhg7IA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 00/23] fs,kthread: start all kthreads in nullfs
Date: Fri, 06 Mar 2026 00:30:03 +0100
Message-Id: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPwRqmkC/32Oy26DMBBFfyWadR35gbHpKlKlfkC3URa2GYILM
 dWYkEQR/x4g+y7v1dwz5wkZKWKGz90TCKeY45CWID92EFqXzshivWSQXJZcccVuA3WsG1tCV7N
 07fsmM2u0s8o0hagsLMs/wibeN+oRfr6/4PQu89X/YhhX3nrmXUbmyaXQrtXF5RFpHwQ3xupg0
 Nbe+VoEYRUXTgRVSl0UXhtbSitXQhvzONBjs5/E9u5f0Ukwvtii1pWvCmX0oUNK2O8HOsNpnuc
 XkJL0/hABAAA=
X-Change-ID: 20260303-work-kthread-nullfs-875a837f4198
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=7184; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZsAGlBz1CyKV2VvyptIgwFqZAWzj9f2Brv8ig855zX4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuK0PZjwbccHB5a9Z2ff+XNQY9uWq0eUBWzcQxgfH
 V6R73d7f0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE+PYw/OFbyXxbSrftp6Tb
 sTnqxxOj6zWPf2Hmnxil1mcYKnv3zh1GhrbI1jlz18WfEKqJqQqKuvlj5+2THJullonHfSvWm7S
 0lwkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 884D521945B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79525-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,localhost:email,msgid.link:url]
X-Rspamd-Action: no action

Summary:

* all kthreads are isolated in a separate SB_KERNMOUNT of nullfs.
  -> no lookup of anything else, no mounting on top of it, completely
  isolated.
* init has a separate fs_struct from all kthreads
* scoped_with_init_fs() allows a kthread to temporarily assume init's
  fs_struct for filesystem operations.

So this is a bit of a crazy series. When the kernel is started it
roughly goes like this:

init_task
==> create pid 1 (systemd etc.)
==> pid 2 (kthreadd)

After this point all kthreads and PID 1 share the same filesystem state.
That obviously already came up when we discussed pivot_root() as this
allows pivot_root() to rewrite the fs_struct of all kthreads.

This rewriting is really weird and mostly done so kthread can use init's
filesystem state when they would like to. But this really should be
discouraged. The rewriting should also stop completely. I worked a bit
to get rid of it in a more fundamental way. Is it crazy? Yes. Is it
likely broken? Yes. Does it at least boot? Yes.

Instead of sharing fs_struct between kernel threads and pid 1, pid 1
get's a completely separate fs_struct. All kthreads continue sharing
init_fs as before and pid 1's fs_struct is isolated from kthread's
filesystem state. IOW, userspace init cannot affect kthreads filesystem
state anymore and kthreads cannot affect userspace's filesystem state
anymore - without explicit opt-in.

All kthreads are anchored in a kernel internal mount of nullfs that
cannot be mounted on and that cannot be used to follow other mounts.
It's a completely private mount that insulates kthreads.

This series makes performing mountains of filesystem work such as path
lookup and file opening and so on from kthreads hard - painfully so. I
think this is a benefit because it takes the idea of just offloading
_security sensitive_ operations in init's filesystem state and
running random binaries or opening and creating files to kthreads
difficult behind the shed... And imho it should.

The only remaining kernel tasks that actually share init's filesystem
state are usermodhelpers - as they execute random binaries in the root
filesystem. Another concept we should really show the back of the shed.

This gives a lot stronger guarantees than what we have now. This also
makes path lookup from kthreads fail by default. IOW, it won't be
possible anymore to just lookup random stuff in init's filesytem state
without explicitly opting in to that.

The places that need to perform lookup in init's filesystem state may
use scoped_with_init_fs() which will temporarily override the caller's
fs_struct with init's fs_struct.

We now also warn and notice when pid 1 simply stops sharing filesystem
state with us, i.e., abandons it's userspace_init_fs.

On older kernels if PID 1 unshared its filesystem state with us the
kernel simply used the stale fs_struct state implicitly pinning
anything that PID 1 had last used. Even if PID 1 might've moved on to
some completely different fs_struct state and might've even unmounted
the old root.

This has hilarious consequences: Think continuing to dump coredump
state into an implicitly pinned directory somewhere. Calling random
binaries in the old rootfs via usermodehelpers.

Be aggressive about this: We simply reject operating on stale
fs_struct state by reverting userspace_init_fs to nullfs. Every kworker
that does lookups after this point will fail. Every usermodehelper call
will fail. This is a lot stronger but I wouldn't know what it means for
pid 1 to simply stop sharing its fs state with the kernel. Clearly it
wanted to separate so cut all ties.

I've went through the kernel and looked at hopefully everything that
does path lookup from kthreads (workqueues, ...).

TL;DR:

==== PID 1 (systemd) ====

  root@localhost:~# stat --file-system /proc/1/root
    File: "/proc/1/root"
      ID: e3cb00dd533cd3d7 Namelen: 255     Type: ext2/ext3

  root@localhost:~# cat /proc/1/mountinfo | wc -l
  30

==== PID 2 (kthreadd) ====

  root@localhost:~# stat --file-system /proc/2/root
    File: "/proc/2/root"
      ID: 200000000 Namelen: 255     Type: nullfs

  root@localhost:~# cat /proc/2/mountinfo | wc -l
  0

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Remove LOOKUP_IN_INIT in favor of scoped_with_init_fs().
- Link to v1: https://patch.msgid.link/20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org

---
Christian Brauner (23):
      fs: notice when init abandons fs sharing
      fs: add scoped_with_init_fs()
      rnbd: use scoped_with_init_fs() for block device open
      crypto: ccp: use scoped_with_init_fs() for SEV file access
      scsi: target: use scoped_with_init_fs() for ALUA metadata
      scsi: target: use scoped_with_init_fs() for APTPL metadata
      btrfs: use scoped_with_init_fs() for update_dev_time()
      coredump: use scoped_with_init_fs() for coredump path resolution
      fs: use scoped_with_init_fs() for kernel_read_file_from_path_initns()
      ksmbd: use scoped_with_init_fs() for share path resolution
      ksmbd: use scoped_with_init_fs() for filesystem info path lookup
      ksmbd: use scoped_with_init_fs() for VFS path operations
      initramfs: use scoped_with_init_fs() for rootfs unpacking
      af_unix: use scoped_with_init_fs() for coredump socket lookup
      fs: add real_fs to track task's actual fs_struct
      fs: make userspace_init_fs a dynamically-initialized pointer
      fs: stop sharing fs_struct between init_task and pid 1
      fs: add umh argument to struct kernel_clone_args
      fs: add kthread_mntns()
      devtmpfs: create private mount namespace
      nullfs: make nullfs multi-instance
      fs: start all kthreads in nullfs
      fs: stop rewriting kthread fs structs

 drivers/base/devtmpfs.c           |  2 +-
 drivers/block/rnbd/rnbd-srv.c     |  4 +-
 drivers/crypto/ccp/sev-dev.c      | 12 ++---
 drivers/target/target_core_alua.c |  6 ++-
 drivers/target/target_core_pr.c   |  4 +-
 fs/btrfs/volumes.c                | 11 ++++-
 fs/coredump.c                     | 11 ++---
 fs/fs_struct.c                    | 96 ++++++++++++++++++++++++++++++++++++++-
 fs/kernel_read_file.c             |  9 +---
 fs/namespace.c                    | 40 ++++++++++++++--
 fs/nullfs.c                       |  7 +--
 fs/smb/server/mgmt/share_config.c |  4 +-
 fs/smb/server/smb2pdu.c           |  4 +-
 fs/smb/server/vfs.c               | 14 ++++--
 include/linux/fs_struct.h         | 34 ++++++++++++++
 include/linux/init_task.h         |  1 +
 include/linux/mount.h             |  1 +
 include/linux/sched.h             |  1 +
 include/linux/sched/task.h        |  1 +
 init/init_task.c                  |  1 +
 init/initramfs.c                  | 12 +++--
 init/main.c                       | 10 +++-
 kernel/fork.c                     | 41 +++++++++++------
 net/unix/af_unix.c                | 17 +++----
 24 files changed, 266 insertions(+), 77 deletions(-)
---
base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
change-id: 20260303-work-kthread-nullfs-875a837f4198


