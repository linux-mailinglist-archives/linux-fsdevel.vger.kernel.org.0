Return-Path: <linux-fsdevel+bounces-79220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIHDK9jopmnjZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:57:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1CD1F0DDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE3D33175D0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BEA3563CD;
	Tue,  3 Mar 2026 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7Ddz3pt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3990350297;
	Tue,  3 Mar 2026 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545761; cv=none; b=r7HZDhCPFiwsbCLUhQlqv8GEPUHJEmcgojSD0lzTTYP0Mdf7Kpj8hHNrmEjCNrnYZ+OjRIe5Wb6MjP0gyG6+TVJdmZQLnWsOrD8vLE71XVHYnGqfn9j+ouKroO+e9XZdct2FiFy2+RJG9/KMKtQPBuyLn2iCcx5+/CCKoeddv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545761; c=relaxed/simple;
	bh=ji1PvWyFnRrZtkXCbjWNXgplsuSMpjo/cV/91Lc7r48=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hy1A5bynIONchcqOaY/unWd9DUfvfnZH/cX0Q7Lwz7rDHl3++8BZ2JYuMb0CHFNEaUTBJiIBCpqx4r1OJJmsulU2k2BRWS2QormHbkXk8f3VRx6cG/uV43OCKj+F2CTKT/zq2+vi3XfA9CZ18y4af/lL4waH9Q+wpDDMox341M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7Ddz3pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1294BC19422;
	Tue,  3 Mar 2026 13:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545761;
	bh=ji1PvWyFnRrZtkXCbjWNXgplsuSMpjo/cV/91Lc7r48=;
	h=From:Subject:Date:To:Cc:From;
	b=I7Ddz3pt/PgZnNWjIUoHac8mYUtfl6ge1P5yvnOp3XvvKGmech54Zpro9UhEWyThx
	 prnWaR39PoVYlT0GU2VlXo7yVejRo/g+SE0blQswA0Q+96BuCvEXRo3DsvUafJjdXj
	 vKhq0Uo9BPXMKVkXXGVMjXDUtRmAhIcpxj/833tntfrGeFN7JKX8dYbUbwuG6S6n4D
	 sSYPkhf054pKRuiRUgZwy4KWUcXcmtuMyBmuunhgZ7CtSG9aWVblmSZpHJzyn1vYxO
	 RVZ1ZzFkxPaUClgo0Q9f9ZNsApdIauWIwIaqnPNH1hkc6SNHpdqEG38cmpDM44xMQN
	 SqNd3ApwtqP2Q==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC DRAFT POC 00/11] fs,kthread: isolate all kthreads in
 nullfs
Date: Tue, 03 Mar 2026 14:49:11 +0100
Message-Id: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANfmpmkC/yWMwQ6CMBAFf6XZszUFVNCbwXDVEG/GQ4EtrZBiu
 oAmhH+3yHHey8wEhM4gwYlN4HA0ZDrrIdgwKLW0NXJTeYZQhAcRiYh/OtfwptcOZcXt0LaKeBL
 vZRLFahccE/Dm26Ey33/1AXmWskt+zu7sdk3hud40FC8s+6W8CIUk5IWTttTLNCraroF5/gFdk
 TTnogAAAA==
X-Change-ID: 20260303-work-kthread-nullfs-875a837f4198
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=40824; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ji1PvWyFnRrZtkXCbjWNXgplsuSMpjo/cV/91Lc7r48=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3avnn3Gk/b6PwV/bv3VKgiqEg/+Ka++Z92PO5ueq
 9v5Rb+81FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRNRUM/91Pv227MiX7sOyP
 SbHtH1u65LTf7srKnS/qoM+lKJwYco3hf1pL35ki/7B/Zio8unGvIqVXXrYTm/umX3rPtZjERZe
 NmQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: DC1CD1F0DDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79220-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,localhost:email]
X-Rspamd-Action: no action

So this is a bit of a crazy series and I've played around with it for
some time and I kinda need to move on to other stuff so I'm sending out
where I've left this as it's overall in a shape where the approach and
idea can be grasped. There's some kthread cleanups at the beginning as
well that are mostly unrelated but fell out of this work as this
whole approach of dumping ever more special helper functions is not very
sustainable. But anyway...

... When the kernel is started it roughly goes like this:

init_task
==> create pid 1 (systemd etc.)
==> pid 2 (kthreadd)

After this point all kthreads and PID 1 share the same filesystem state.
That obviously already came up when we discussed pivot_root() as this
allows pivot_root() to rewrite the fs_struct of all kthreads.

I kinda hate this rewriting the implicit sharing which is abused left
and right - but who knows maybe others really like it - so I worked a
bit to get rid of it in a more fundamental way. Is it crazy? Yes. Is it
likely broken? Yes. Does it at least boot? Yes.

Instead of sharing fs_struct between kernel threads and pid 1 we give
pid a separate userspace_init_fs struct. All kthreads continue sharing
init_fs as before and userspace_init_fs is isolated from kthread's
filesystem state. IOW, userspace init cannot affect kthreads filesystem
state anymore and kthreads cannot affect userspace's filesystem state
anymore - without explicit opt-in.

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
use LOOKUP_IN_INIT which will grab userspace_init_fs and use that for
root or pwd. Note that we can't just walk up to the topmost mount
otherwise someone in userspace can do mount -t tmpfs tmpfs / and mess
with a kthreads lookup state. We also sometimes might need the working
directory.

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

The only really unfortunate place is initramfs unpacking because it runs
mostly from a workqueue but if there' "too much work" pending it will
fallback to synchronous in-task execution. Ideally it just always go
async instead of this weird fallback.

TL;DR:

root@localhost:~# stat --file-system /proc/1/root
  File: "/proc/1/root"
    ID: e3cb00dd533cd3d7 Namelen: 255     Type: ext2/ext3

root@localhost:~# stat --file-system /proc/2/root
  File: "/proc/2/root"
    ID: 200000000 Namelen: 255     Type: nullfs

=========================================================================
Here's my review. It's long and ugly, I might have missed stuff:
=========================================================================

==== 1. devtmpfs -- kdevtmpfs kthread ====
Dedicated kthread sharing init_fs (nullfs).

```
kernel_init_freeable()                            # PID 1
  -> do_basic_setup()
    -> driver_init()
      -> devtmpfs_init()
        -> kthread_run(devtmpfsd, &err, "kdevtmpfs")
          -> devtmpfsd()                          # kdevtmpfs kthread context
            -> devtmpfs_setup()                   # runs IN the kthread
            -> devtmpfs_work_loop()               # runtime loop IN the kthread
```

`devtmpfs_setup()` runs inside the kdevtmpfs kthread, NOT PID 1. However, it is
safe because:

- `ksys_unshare(CLONE_NEWNS)` implies `CLONE_FS` giving the kthread a
  **private** copy of init_fs.
- `init_mount("devtmpfs", "/", ...)` mounts devtmpfs over the nullfs root
- `init_chdir("/.."); init_chroot(".")` chroots into the devtmpfs mount

All runtime paths (`handle_create`, `handle_remove`, `create_path`,
`delete_path`) operate within this private chroot via
`devtmpfs_work_loop()`.

**No conversion needed**

==== 2. ksmbd -- `ksmbd-io` workqueue

Let's ignore for a second that this basically does all I/O from
kthread context and the security implications of this...

Heaviest subsystem user. Every SMB file operation goes through workqueue
path lookups. Per-connection kthreads (`ksmbd_conn_handler_loop`) read
requests and dispatch to the `ksmbd-io` workqueue via
`handle_ksmbd_work()`.

**Converted to LOOKUP_IN_INIT**

==== 3. nfsd -- kthreads + laundromat workqueue ====

nfsd service threads are kthreads spawned via `kthread_create_on_node` in
`svc_new_thread()`. The `nfsd()` threadfn is passed through
`svc_create_pooled()` -> `serv->sv_threadfn`.

**Service kthreads (`nfsd()` threadfn):**

The nfsd kthreads call `unshare_fs_struct()` on startup for umask control
(`current->fs->umask = 0`), not for path lookups. NFS request handling
dispatches through `svc_recv()` -> NFS procedure handlers which use
**filehandle-based resolution** (`fh_verify()` etc.) relative to export
mount points. They never resolve paths from `current->fs->root`.

**No conversion needed**

==== 4. kernel_init (PID 1 before execve) ====

All `init_*()` wrappers in `fs/init.c` do `kern_path()` or
`filename_create()`/`filename_parentat()`. The lookup API table is
listed once here; the callchains below show every path that reaches them
from PID 1.

**Callchain 1: kernel_init() direct**

```
kernel_init()
  -> do_sysctl_args()
    -> process_sysctl_arg()
      -> file_open_root_mnt()                    # uses kern_mount'd procfs, not fs_struct
```

**Callchain 2: kernel_init_freeable() direct**

```
kernel_init()                                    # PID 1
  -> kernel_init_freeable()
    -> console_on_rootfs()
      -> filp_open("/dev/console", ...)
    -> init_eaccess(ramdisk_execute_command)
      -> kern_path()
```

**Callchain 3: prepare_namespace() -> mount_root()**

```
kernel_init()                                    # PID 1
  -> kernel_init_freeable()
    -> prepare_namespace()
      -> mount_root()
        -> mount_root_generic()
          -> do_mount_root()
            -> init_mount()
            -> init_chdir("/")
        -> mount_nodev_root()
          -> do_mount_root()
            -> init_mount()
            -> init_chdir("/")
        -> mount_nfs_root()
          -> do_mount_root()
            -> init_mount()
            -> init_chdir("/")
        -> mount_cifs_root()
          -> do_mount_root()
            -> init_mount()
            -> init_chdir("/")
        -> mount_block_root()
          -> create_dev()
            -> init_unlink()
            -> init_mknod()
          -> mount_root_generic()
            -> do_mount_root()
              -> init_mount()
              -> init_chdir("/")
```

**Callchain 4: prepare_namespace() -> initrd_load()**

```
kernel_init()                                    # PID 1
  -> kernel_init_freeable()
    -> prepare_namespace()
      -> initrd_load()
        -> create_dev()
          -> init_unlink()
          -> init_mknod()
        -> rd_load_image()
          -> filp_open() (x2)
          -> init_unlink()
```

**Callchain 5: prepare_namespace() -> devtmpfs_mount()**

```
kernel_init()                                    # PID 1
  -> kernel_init_freeable()
    -> prepare_namespace()
      -> devtmpfs_mount()
        -> init_mount("devtmpfs", "dev", ...)
```

Note: this is `devtmpfs_mount()` called from PID 1 context (mounts
devtmpfs at /dev after the real root is mounted). Distinct from
`devtmpfs_setup()` which runs in the kdevtmpfs kthread (section 1).

**Callchain 6: prepare_namespace() -> pivot + umount**

```
kernel_init()                                    # PID 1
  -> kernel_init_freeable()
    -> prepare_namespace()
      -> init_pivot_root(".", ".")               # kern_path() x2
      -> init_umount(".", MNT_DETACH)            # kern_path()
```

**Callchain 7: prepare_namespace() -> md_run_setup()**

```
kernel_init()                                    # PID 1
  -> kernel_init_freeable()
    -> prepare_namespace()
      -> md_run_setup()
        -> md_setup_drive()
          -> init_stat()
```

**Callchain 8: do_basic_setup() -> do_initcalls() (rootfs_initcall)**

```
kernel_init()                                    # PID 1
  -> kernel_init_freeable()
    -> do_basic_setup()
      -> do_initcalls()
        -> rootfs_initcall(default_rootfs)
          -> default_rootfs()
            -> init_mkdir("/dev", 0755)
            -> init_mknod("/dev/console", ...)
            -> init_mkdir("/root", 0700)
```

Only used when `CONFIG_BLK_DEV_INITRD` is not set (no initramfs).

PID 1 uses pid1_fs which points to the initramfs (set by
`init_chroot_to_overmount()` at the start of `kernel_init()`). The
correct context is available so nothing to worry about.

**No conversion needed**

==== 5. Initramfs/initrd unpacking -- async kworker ====

`do_populate_rootfs()` runs as `async_schedule_domain()` callback
(kworker). When `initramfs_async=0` it runs synchronously in
`kernel_init` context instead.

**Async workqueue creation:**

```
async_init()
  -> alloc_workqueue("async", WQ_UNBOUND, 0)      # line 359
```

**Async scheduling chain (how do_populate_rootfs ends up in kworker):**

```
kernel_init()                                     # PID 1
  -> init_fs()                                    # init/main.c -- switches PID 1 to pid1_fs (rootfs)
  -> kernel_init_freeable()
    -> do_basic_setup()
      -> do_initcalls()
        -> rootfs_initcall(populate_rootfs)        # init/initramfs.c:791
          -> populate_rootfs()                     # init/initramfs.c:782
            -> async_schedule_domain(do_populate_rootfs, NULL, &initramfs_domain)  # line 784
              -> async_schedule_node_domain()      # include/linux/async.h:69
                -> __async_schedule_node_domain()  # kernel/async.c:150
                  -> INIT_WORK(&entry->work, async_run_entry_fn)  # line 162
                  -> entry->func = do_populate_rootfs              # line 163
                  -> queue_work_node(node, async_wq, &entry->work) # line 180
                    -> kworker picks up work item  # async_wq = "async" WQ_UNBOUND workqueue
                      -> async_run_entry_fn()      # kernel/async.c:122
                        -> entry->func(entry->data, entry->cookie) # line 139
                          -> do_populate_rootfs(NULL, cookie)  # RUNS IN KWORKER CONTEXT
```

Note: `async_schedule_node_domain()` has an OOM fallback that runs
`func(data, newcookie)` synchronously in the caller's context (PID 1)
if `kzalloc` fails or `entry_count > MAX_WORK` (kernel/async.c:215-221).
In that case the function runs safely in PID 1. The async kworker case
is the one that needs conversion.

Work items execute in kworker kthreads (children of kthreadd, share init_fs).
The kworker's `current->fs` is `init_fs` which now points to **nullfs**.

**Callchain 1: do_name() regular file creation (S_ISREG)**

```
do_populate_rootfs()                                # kworker context (async_wq)
  -> unpack_to_rootfs(__initramfs_start, __initramfs_size)  # init/initramfs.c:721
    -> write_buffer()                               # init/initramfs.c:465
      -> actions[GotName] = do_name()               # init/initramfs.c:361
        -> clean_path(collected, mode)              # init/initramfs.c:378
          -> init_stat(path, &st, AT_SYMLINK_NOFOLLOW)  # init/initramfs.c:337
            -> kern_path()                          # fs/init.c:150
              -> filename_lookup(AT_FDCWD, ...)     # fs/namei.c:2836
                -> path_lookupat()                  # fs/namei.c:2813
                  -> path_init()                    # fs/namei.c:2673
                    -> nd_jump_root()               # absolute paths
                      -> set_root()                 # uses current->fs = init_fs (NULLFS)
          -> init_rmdir(path)                       # init/initramfs.c:340 (if S_ISDIR)
            -> filename_rmdir(AT_FDCWD, name)       # fs/init.c:194
              -> filename_parentat() -> path_parentat() -> path_init() -> current->fs (NULLFS)
          -> init_unlink(path)                      # init/initramfs.c:342 (if not S_ISDIR)
            -> filename_unlinkat(AT_FDCWD, name)    # fs/init.c:182
              -> filename_parentat() -> path_parentat() -> path_init() -> current->fs (NULLFS)
        -> maybe_link()                             # init/initramfs.c:380
          -> find_link()                            # init/initramfs.c:90 (hardlink hash lookup)
          [if hardlink found:]
            -> clean_path(collected, 0)             # same as above (init_stat/init_rmdir/init_unlink)
            -> init_link(old, collected)            # init/initramfs.c:352
              -> filename_linkat(AT_FDCWD, old, AT_FDCWD, new, 0)  # fs/init.c:169
                -> filename_lookup(olddfd, old, ...)  # -> path_lookupat() -> path_init() -> NULLFS
                -> filename_create(newdfd, new, ...)   # -> filename_parentat() -> path_init() -> NULLFS
          [if not hardlink:]
        -> filp_open(collected, O_WRONLY|O_CREAT|O_LARGEFILE, mode)  # init/initramfs.c:385
          -> file_open_name()                       # fs/open.c:1338
            -> do_file_open(AT_FDCWD, name, &op)   # fs/open.c:1322
              -> path_openat()                      # fs/namei.c:4821
                -> path_init()                      # -> nd_jump_root() -> set_root() -> NULLFS
        -> vfs_fchown(wfile, uid, gid)              # init/initramfs.c:391 (on already-open file, SAFE)
        -> vfs_fchmod(wfile, mode)                  # init/initramfs.c:392 (on already-open file, SAFE)
        -> vfs_truncate(&wfile->f_path, body_len)   # init/initramfs.c:394 (on already-open path, SAFE)
```

**Callchain 2: do_name() directory creation (S_ISDIR)**

```
do_populate_rootfs()                                # kworker context
  -> unpack_to_rootfs()
    -> write_buffer() -> do_name()
      -> clean_path(collected, mode)                # init/initramfs.c:378 (same as callchain 1)
      -> init_mkdir(collected, mode)                # init/initramfs.c:398
        -> filename_mkdirat(AT_FDCWD, name, mode)   # fs/init.c:188
          -> filename_create(AT_FDCWD, name, ...)   # fs/namei.c:4903
            -> filename_parentat(AT_FDCWD, name, ...)  # fs/namei.c:2900
              -> __filename_parentat()              # fs/namei.c:2875
                -> path_parentat()                  # fs/namei.c:2858
                  -> path_init()                    # -> nd_jump_root() -> set_root() -> NULLFS
      -> init_chown(collected, uid, gid, 0)         # init/initramfs.c:399
        -> kern_path(filename, LOOKUP_FOLLOW, &path)  # fs/init.c:106
          -> filename_lookup(AT_FDCWD, ...)         # -> path_lookupat() -> path_init() -> NULLFS
      -> init_chmod(collected, mode)                # init/initramfs.c:400
        -> kern_path(filename, LOOKUP_FOLLOW, &path)  # fs/init.c:123
          -> filename_lookup(AT_FDCWD, ...)         # -> path_lookupat() -> path_init() -> NULLFS
      -> dir_add(collected, name_len, mtime)        # init/initramfs.c:401 (saves for later dir_utime)
```

**Callchain 3: do_name() device/pipe/socket creation (S_ISBLK/S_ISCHR/S_ISFIFO/S_ISSOCK)**

```
do_populate_rootfs()                                # kworker context
  -> unpack_to_rootfs()
    -> write_buffer() -> do_name()
      -> clean_path(collected, mode)                # init/initramfs.c:378 (same as callchain 1)
      -> maybe_link()                               # init/initramfs.c:404
        [if not hardlink:]
      -> init_mknod(collected, mode, rdev)          # init/initramfs.c:405
        -> filename_mknodat(AT_FDCWD, name, mode, dev)  # fs/init.c:162
          -> filename_create(AT_FDCWD, name, ...)   # fs/namei.c:4903
            -> filename_parentat()                  # -> path_parentat() -> path_init() -> NULLFS
      -> init_chown(collected, uid, gid, 0)         # init/initramfs.c:406
        -> kern_path()                              # -> filename_lookup() -> path_init() -> NULLFS
      -> init_chmod(collected, mode)                # init/initramfs.c:407
        -> kern_path()                              # -> filename_lookup() -> path_init() -> NULLFS
      -> do_utime(collected, mtime)                 # init/initramfs.c:408
        -> init_utimes(filename, t)                 # init/initramfs.c:136
          -> kern_path(filename, 0, &path)          # fs/init.c:202
            -> filename_lookup(AT_FDCWD, ...)       # -> path_lookupat() -> path_init() -> NULLFS
```

**Callchain 4: do_symlink() symlink creation (S_ISLNK)**

```
do_populate_rootfs()                                # kworker context
  -> unpack_to_rootfs()
    -> write_buffer()
      -> actions[GotSymlink] = do_symlink()         # init/initramfs.c:436
        -> clean_path(collected, 0)                 # init/initramfs.c:445
          -> init_stat() -> kern_path()             # -> path_init() -> NULLFS
          -> init_rmdir() or init_unlink()          # -> filename_parentat() -> path_init() -> NULLFS
        -> init_symlink(collected + N_ALIGN(name_len), collected)  # init/initramfs.c:446
          -> filename_symlinkat(old, AT_FDCWD, new)  # fs/init.c:176
            -> filename_create(AT_FDCWD, new, ...)  # fs/namei.c:4903
              -> filename_parentat()                # -> path_parentat() -> path_init() -> NULLFS
        -> init_chown(collected, uid, gid, AT_SYMLINK_NOFOLLOW)  # init/initramfs.c:447
          -> kern_path(filename, 0, &path)          # fs/init.c:106 (lookup_flags = 0, no LOOKUP_FOLLOW)
            -> filename_lookup(AT_FDCWD, ...)       # -> path_lookupat() -> path_init() -> NULLFS
        -> do_utime(collected, mtime)               # init/initramfs.c:448
          -> init_utimes(filename, t)               # init/initramfs.c:136
            -> kern_path(filename, 0, &path)        # fs/init.c:202
              -> filename_lookup(AT_FDCWD, ...)     # -> path_lookupat() -> path_init() -> NULLFS
```

**Callchain 5: dir_utime() directory timestamp fixup (CONFIG_INITRAMFS_PRESERVE_MTIME)**

```
do_populate_rootfs()                                # kworker context
  -> unpack_to_rootfs()
    [at end of unpack_to_rootfs, after all cpio entries processed:]
    -> dir_utime()                                  # init/initramfs.c:567
      -> list_for_each_entry_safe(de, ...)          # init/initramfs.c:168
        -> do_utime(de->name, de->mtime)            # init/initramfs.c:170
          -> init_utimes(filename, t)               # init/initramfs.c:136
            -> kern_path(filename, 0, &path)        # fs/init.c:202
              -> filename_lookup(AT_FDCWD, ...)     # fs/namei.c:2836
                -> path_lookupat()                  # -> path_init() -> NULLFS
```

**Callchain 6: populate_initrd_image() non-cpio initrd (CONFIG_BLK_DEV_RAM)**

```
do_populate_rootfs()                                # kworker context
  -> unpack_to_rootfs((char *)initrd_start, ...)    # init/initramfs.c:733 (returns error for non-cpio)
  [err != NULL && CONFIG_BLK_DEV_RAM:]
  -> populate_initrd_image(err)                     # init/initramfs.c:736
    -> filp_open("/initrd.image", O_WRONLY|O_CREAT|O_LARGEFILE, 0700)  # init/initramfs.c:705
      -> file_open_name(name, flags, mode)          # fs/open.c:1338
        -> do_file_open(AT_FDCWD, name, &op)       # fs/open.c:1322
          -> path_openat(&nd, op, flags)            # fs/namei.c:4821
            -> path_init(&nd, flags)                # fs/namei.c:2673
              -> nd_jump_root()                     # absolute path "/"
                -> set_root()                       # uses current->fs = init_fs (NULLFS)
    -> xwrite(file, ...)                            # init/initramfs.c:709 (write to already-open file, SAFE)
    -> fput(file)                                   # init/initramfs.c:714
```

**Callchain 7: do_name() hardlink via maybe_link()**

```
do_populate_rootfs()                                # kworker context
  -> unpack_to_rootfs()
    -> write_buffer() -> do_name()
      -> clean_path(collected, mode)                # init/initramfs.c:378 (same as callchain 1)
      [S_ISREG(mode):]
      -> maybe_link()                               # init/initramfs.c:380
        -> find_link(major, minor, ino, mode, collected)  # init/initramfs.c:90
          [returns non-NULL old name for nlink >= 2 and matching hash entry:]
        -> clean_path(collected, 0)                 # init/initramfs.c:351
          -> init_stat() -> kern_path()             # -> path_init() -> NULLFS
          -> init_rmdir() or init_unlink()          # -> path_init() -> NULLFS
        -> init_link(old, collected)                # init/initramfs.c:352
          -> filename_linkat(AT_FDCWD, old, AT_FDCWD, new, 0)  # fs/init.c:169
            -> filename_lookup(AT_FDCWD, old, 0, &old_path, NULL)  # fs/namei.c:5816
              -> path_lookupat() -> path_init()     # -> NULLFS
            -> filename_create(AT_FDCWD, new, &new_path, 0)  # fs/namei.c:5822
              -> filename_parentat() -> path_parentat() -> path_init()  # -> NULLFS
```

When `initramfs_async=1` (the default), `do_populate_rootfs()` runs
in an async kworker. The kworker's `current->fs` is `init_fs` which
now points to **nullfs**. All path lookups resolve "/" against the
nullfs root.

The rootfs (initramfs) is overmounted on top of nullfs's root dentry.
However, `path_init()` does **not** follow overmounts when establishing
the starting point — it sets `nd->path` to the raw `current->fs->root`
(nullfs root dentry on nullfs vfsmount). Mount following only occurs
during component-by-component traversal in `link_path_walk()` via
`step_into()` -> `handle_mounts()`. Since the starting dentry is the
nullfs root (below the overmount), component lookups call nullfs's
`->lookup` which returns -ENOENT (nullfs has no directory entries).

**Result: all `init_*()` and `filp_open()` calls will fail with -ENOENT
in async kworker context.**

When `initramfs_async=0`, `populate_rootfs()` calls
`wait_for_initramfs()` which calls `async_synchronize_cookie_domain()`
to wait for the async work to complete. But the work was already queued
to the async_wq workqueue — `wait_for_initramfs` does not change which
context runs the work. The work still runs in a kworker.

However, there is the OOM fallback: if `kzalloc` fails in
`async_schedule_node_domain()`, the function runs synchronously in PID 1
context (safe).

**Converted to LOOKUP_IN_INIT**

==== 6. Firmware loader -- system workqueue ====

Reached via `request_firmware_nowait()` -> workqueue ->
`request_firmware_work_func()`, and also via synchronous
`request_firmware()` from any kthread caller (428+ callers across
drivers).

Already uses `kernel_read_file_from_path_initns()` which calls
`init_root()`.

**Converted**

==== 7. IMA/EVM integrity -- kernel_init kthread ===

  kernel_init()                           # init/main.c
    -> kernel_init_freeable()
         -> integrity_load_keys()         # hook, called when rootfs is ready
              +- ima_load_x509()
              |    -> integrity_load_x509()
              |         -> kernel_read_file_from_path()   # NOT _initns
              +- evm_load_x509()          # if !CONFIG_IMA_LOAD_X509
                   -> integrity_load_x509()
                        -> kernel_read_file_from_path()   # NOT _initns

This is called from PID 1 before init is exec'd where we are chrooted into
the initramfs. The correct context will be available so nothing to worry about.

**No conversion needed**

==== 8. Btrfs -- `btrfs-devrepl` kthread ====

**Kthread creation:**

```
open_ctree() / btrfs_remount_rw()                 # mount/remount context
  -> btrfs_start_pre_rw_mount()                    # fs/btrfs/disk-io.c:3038
    -> btrfs_resume_dev_replace_async()            # fs/btrfs/dev-replace.c:1188
      -> kthread_run(btrfs_dev_replace_kthread, ..., "btrfs-devrepl")  # line 1237
         -> kthread_create() -> kthreadd -> kernel_thread(CLONE_FS|CLONE_FILES|SIGCHLD)
```

Dedicated kthread sharing init_fs (nullfs).

**Callchain 1 (kthread -- NEEDS CONVERSION):**

```
btrfs_dev_replace_kthread()                        # fs/btrfs/dev-replace.c:1239 [kthread context]
  -> btrfs_scrub_dev()
  -> btrfs_dev_replace_finishing()                 # fs/btrfs/dev-replace.c:856
    -> btrfs_scratch_superblocks()                 # fs/btrfs/volumes.c:2266
      -> update_dev_time()                         # fs/btrfs/volumes.c:2119
        -> kern_path()
```

**Callchain 2 (kthread, error path -- NEEDS CONVERSION):**

```
btrfs_dev_replace_kthread()                        # fs/btrfs/dev-replace.c:1239 [kthread context]
  -> btrfs_dev_replace_finishing()                 # fs/btrfs/dev-replace.c:856
    -> btrfs_destroy_dev_replace_tgtdev()          # fs/btrfs/volumes.c:2512 (error/cleanup)
      -> btrfs_scratch_superblocks()               # fs/btrfs/volumes.c:2266
        -> update_dev_time()                       # fs/btrfs/volumes.c:2119
          -> kern_path()
```

**Callchain 3 (ioctl DEV_REPLACE_CMD_START -- SAFE: user context):**

```
btrfs_ioctl()                                      # user syscall context
  -> btrfs_ioctl_dev_replace()                     # fs/btrfs/ioctl.c:3112
    -> btrfs_dev_replace_by_ioctl()                # fs/btrfs/dev-replace.c:730
      -> btrfs_dev_replace_start()                 # fs/btrfs/dev-replace.c:584
        -> btrfs_dev_replace_finishing()            # fs/btrfs/dev-replace.c:856
          -> btrfs_scratch_superblocks()            # fs/btrfs/volumes.c:2266
            -> update_dev_time()                    # fs/btrfs/volumes.c:2119
              -> kern_path()
```

**Callchain 4 (ioctl DEV_REPLACE_CMD_START, error -- SAFE: user context):**

```
btrfs_ioctl()
  -> btrfs_ioctl_dev_replace()                     # fs/btrfs/ioctl.c:3112
    -> btrfs_dev_replace_by_ioctl()                # fs/btrfs/dev-replace.c:730
      -> btrfs_dev_replace_start()                 # fs/btrfs/dev-replace.c:584
        -> btrfs_destroy_dev_replace_tgtdev()      # error/leave path, line 711
          -> btrfs_scratch_superblocks()
            -> update_dev_time()
              -> kern_path()
```

**Callchain 5 (ioctl DEV_REPLACE_CMD_START, nested error -- SAFE: user context):**

```
btrfs_ioctl()
  -> btrfs_ioctl_dev_replace()                     # fs/btrfs/ioctl.c:3112
    -> btrfs_dev_replace_by_ioctl()
      -> btrfs_dev_replace_start()
        -> btrfs_dev_replace_finishing()
          -> btrfs_destroy_dev_replace_tgtdev()    # error within finishing
            -> btrfs_scratch_superblocks()
              -> update_dev_time()
                -> kern_path()
```

**Callchain 6 (ioctl DEV_REPLACE_CMD_CANCEL -- SAFE: user context):**

```
btrfs_ioctl()
  -> btrfs_ioctl_dev_replace()                     # fs/btrfs/ioctl.c:3112
    -> btrfs_dev_replace_cancel()                  # fs/btrfs/dev-replace.c:1075
      -> btrfs_destroy_dev_replace_tgtdev()        # fs/btrfs/volumes.c:2512
        -> btrfs_scratch_superblocks()
          -> update_dev_time()
            -> kern_path()
```

**Callchain 7 (ioctl BTRFS_IOC_RM_DEV -- SAFE: user context):**

```
btrfs_ioctl()
  -> btrfs_ioctl_rm_dev()                          # fs/btrfs/ioctl.c:2582
    -> btrfs_rm_device()                           # fs/btrfs/volumes.c:2288
      -> btrfs_scratch_superblocks()               # fs/btrfs/volumes.c:2266
        -> update_dev_time()
          -> kern_path()
```

**Callchain 8 (ioctl BTRFS_IOC_RM_DEV_V2 -- SAFE: user context):**

```
btrfs_ioctl()
  -> btrfs_ioctl_rm_dev_v2()                       # fs/btrfs/ioctl.c:2514
    -> btrfs_rm_device()                           # fs/btrfs/volumes.c:2288
      -> btrfs_scratch_superblocks()
        -> update_dev_time()
          -> kern_path()
```

**Callchain 9 (ioctl BTRFS_IOC_ADD_DEV -- SAFE: user context):**

```
btrfs_ioctl()
  -> btrfs_ioctl_add_dev()                         # fs/btrfs/ioctl.c:2455
    -> btrfs_init_new_device()                     # fs/btrfs/volumes.c:2802
      -> update_dev_time()                         # fs/btrfs/volumes.c:2119
        -> kern_path()
```

Only callchains 1 and 2 (the `btrfs-devrepl` kthread and its error
path) need conversion. All other paths are ioctl/user syscall context.

**Converted to LOOKUP_IN_INIT**

==== 9. SCSI Target (LIO) -- target workqueues ====

Via `target_queued_submit_work` / `target_complete_ok_work` workqueues.

**Workqueue creation:**

```
module_init(target_core_init_configfs)            # drivers/target/target_core_configfs.c:3852
  -> init_se_kmem_caches()                        # drivers/target/target_core_transport.c:60
    -> alloc_workqueue("target_completion", WQ_MEM_RECLAIM|WQ_PERCPU, 0)  # line 128
    -> alloc_workqueue("target_submission", WQ_MEM_RECLAIM|WQ_PERCPU, 0)  # line 133
```

Work items execute in kworker kthreads (children of kthreadd, share init_fs).

**Converted to LOOKUP_IN_INIT**

==== 10. RNBD server -- RDMA CQ workqueue (IB_POLL_WORKQUEUE) ====

**Workqueue creation:**

The underlying workqueue is `ib_comp_wq`:

```
module_init(ib_core_init)                         # drivers/infiniband/core/device.c:2994
  -> alloc_workqueue("ib-comp-wq",
       WQ_HIGHPRI|WQ_MEM_RECLAIM|WQ_SYSFS|WQ_PERCPU, 0)  # line 3007
```

At connection time, CQ completion work is bound to `ib_comp_wq`:

```
rtrs_srv_rdma_cm_handler()
  -> create_con()                                 # drivers/infiniband/ulp/rtrs/rtrs-srv.c:1704
    -> rtrs_cq_qp_create(..., IB_POLL_WORKQUEUE)  # line 1759
      -> ib_alloc_cq() -> __ib_alloc_cq()         # drivers/infiniband/core/cq.c:212
        -> cq->comp_wq = ib_comp_wq               # line 276
```

Work items execute in kworker kthreads (children of kthreadd, share init_fs).

**Converted to LOOKUP_IN_INIT**

==== 11. NFS client pNFS block layout -- rpciod/nfsiod workqueue (potentially) ====

**Workqueue creation:**

```
module_init(init_nfs_fs)                          # fs/nfs/inode.c:2809
  -> nfsiod_start()                               # fs/nfs/inode.c:2620
    -> alloc_workqueue("nfsiod", WQ_MEM_RECLAIM|WQ_UNBOUND, 0)  # line 2627
```

Work items execute in kworker kthreads (children of kthreadd, share init_fs).

**Converted to LOOKUP_IN_INIT**

==== 12. NFS4 referral -- automount ====

`nfs4_submount()` is an automount callback triggered during path walk.
Always user process context.

**No conversion needed**

==== 13. Cachefiles -- fscache cookie workers ====

The fscache cookie worker path is workqueue context:

```
fscache_cookie_worker() [work_struct]
  -> fscache_cookie_state_machine()
    -> fscache_perform_lookup() -> cachefiles_lookup_cookie()
       -> cachefiles_look_up_object() -> lookup_one_positive_unlocked()
    -> fscache_perform_invalidation() -> cachefiles_invalidate_cookie()
       -> cachefiles_bury_object() -> lookup_one()
```

However, `lookup_one()` and `lookup_one_positive_unlocked()` are **dentry-level
lookups** relative to a parent dentry. They do NOT use
`current->fs->root` for path resolution. 

The `cachefiles_add_cache()` -> `kern_path()` path is daemon ioctl context
(user process).

**No conversion needed**

==== 14. Audit subsystem -- netlink handler ====

The `kern_path()` calls are all reached via:

```
audit_receive() -> audit_receive_msg() -> audit_trim_trees() / audit_tag_tree()
```

`audit_receive()` is a netlink callback running in the **context of the
userspace process** (auditctl) that sent the netlink message. The
`prune_tree_thread` kthread (launched by `audit_launch_prune()`) calls
`prune_one()` which does NOT do path lookups. **No conversion needed.**

==== 15. AMD SEV -- `__init` path ====

Uses `init_root()` via `open_file_as_root()` -> `file_open_root()`
(drivers/crypto/ccp/sev-dev.c:265).

**Converted**

==== 16. Overlayfs -- VFS operation context ====

Triggered from `ovl_open()` / `ovl_d_real()` -- inherits caller's
context.

Uses `vfs_path_lookup(layer->mnt->mnt_root, layer->mnt, ...)` with an
explicit root/vfsmount. Does not go through fs_struct root at all.

**No conversion needed.**

==== 17. Module init (kthread context when built-in) ====

Note: `early_boot_devpath()` uses `early_lookup_bdev()` (not `kern_path`)
for the device lookup, but then calls `init_unlink()` and `init_mknod()`
which perform path lookups via `filename_unlinkat()` and
`filename_mknodat()`.

Built-in `module_init` runs in PID 1 context . Module loaded at runtime
runs in modprobe context (user process, safe).

**No conversion needed.**

==== 18. EROFS -- mount operation ====

`erofs_fc_get_tree()` is the `.get_tree` callback in `erofs_context_ops`
(`fs/erofs/super.c:884`), invoked via `vfs_get_tree()`.

The `filp_open()` call happens only on the `CONFIG_EROFS_FS_BACKED_BY_FILE`
path, when `get_tree_bdev_flags()` returns `-ENOTBLK` and the source is a
regular file.

**kthread path (boot-time root mount):**

```
kernel_init_freeable()
  -> prepare_namespace()
    -> mount_root()
      -> mount_root_generic() / mount_nodev_root()
        -> do_mount_root()
          -> init_mount()
            -> path_mount()
              -> do_new_mount()
                -> vfs_get_tree()
                  -> erofs_fc_get_tree()
```

This is reachable when erofs is used as the root filesystem
(`rootfstype=erofs`). At this point PID 1 is spawned via
`user_mode_thread(kernel_init, ...)` but has not yet exec'd the
userspace init binary. It will have the correct lookup context as
we chrooted into initramfs.

**No conversion needed.**

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (11):
      kthread: refactor __kthread_create_on_node() to take a struct argument
      kthread: remove unused flags argument from kthread worker creation API
      kthread: add extensible kthread_create()/kthread_run() pattern
      fs: notice when init abandons fs sharing
      fs: add LOOKUP_IN_INIT
      fs: add file_open_init()
      block: add bdev_file_open_init()
      fs: allow to pass lookup flags to filename_*()
      fs: add init_root()
      tree-wide: make all kthread path lookups to use LOOKUP_IN_INIT
      fs: isolate all kthreads in nullfs

 arch/x86/kvm/i8254.c                               |   2 +-
 block/bdev.c                                       |  60 ++++++--
 crypto/crypto_engine.c                             |   2 +-
 drivers/block/rnbd/rnbd-srv.c                      |   2 +-
 drivers/char/misc_minor_kunit.c                    |   2 +-
 drivers/cpufreq/cppc_cpufreq.c                     |   2 +-
 drivers/crypto/ccp/sev-dev.c                       |   4 +-
 drivers/dpll/zl3073x/core.c                        |   2 +-
 drivers/gpu/drm/drm_vblank_work.c                  |   6 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |   4 +-
 drivers/gpu/drm/i915/gt/selftest_execlists.c       |   2 +-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |   4 +-
 drivers/gpu/drm/i915/gt/selftest_slpc.c            |   2 +-
 drivers/gpu/drm/i915/selftests/i915_request.c      |  12 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c       |   2 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |   2 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   2 +-
 drivers/gpu/drm/msm/msm_kms.c                      |   2 +-
 .../media/platform/chips-media/wave5/wave5-vpu.c   |   2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |   4 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c          |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   4 +-
 drivers/platform/chrome/cros_ec_spi.c              |   2 +-
 drivers/ptp/ptp_clock.c                            |   2 +-
 drivers/spi/spi.c                                  |   2 +-
 drivers/target/target_core_alua.c                  |   2 +-
 drivers/target/target_core_pr.c                    |   2 +-
 drivers/usb/gadget/function/uvc_video.c            |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |   4 +-
 drivers/watchdog/watchdog_dev.c                    |   2 +-
 fs/btrfs/volumes.c                                 |   6 +-
 fs/coredump.c                                      |   8 +-
 fs/erofs/zdata.c                                   |   2 +-
 fs/fs_struct.c                                     |  92 ++++++++++++
 fs/init.c                                          |  23 +--
 fs/internal.h                                      |  18 ++-
 fs/kernel_read_file.c                              |   4 +-
 fs/namei.c                                         |  71 +++++----
 fs/namespace.c                                     |   4 -
 fs/nfs/blocklayout/dev.c                           |   4 +-
 fs/open.c                                          |  25 +++
 fs/smb/server/mgmt/share_config.c                  |   3 +-
 fs/smb/server/smb2pdu.c                            |   2 +-
 fs/smb/server/vfs.c                                |   6 +-
 include/linux/blkdev.h                             |   2 +
 include/linux/fs.h                                 |   1 +
 include/linux/fs_struct.h                          |   5 +
 include/linux/init_task.h                          |   1 +
 include/linux/kthread.h                            |  97 +++++++-----
 include/linux/namei.h                              |   3 +-
 include/linux/sched/task.h                         |   1 +
 init/initramfs.c                                   |   4 +-
 init/initramfs_test.c                              |   4 +-
 init/main.c                                        |  10 +-
 io_uring/fs.c                                      |  10 +-
 kernel/fork.c                                      |  40 +++--
 kernel/kthread.c                                   | 167 ++++++++++++++-------
 kernel/rcu/tree.c                                  |   4 +-
 kernel/sched/ext.c                                 |   2 +-
 kernel/workqueue.c                                 |   2 +-
 net/dsa/tag_ksz.c                                  |   4 +-
 net/dsa/tag_ocelot_8021q.c                         |   2 +-
 net/dsa/tag_sja1105.c                              |   4 +-
 net/unix/af_unix.c                                 |   4 +-
 66 files changed, 526 insertions(+), 257 deletions(-)
---
base-commit: 10047142d6ce3b8562546c61f3cf57f852b9b950
change-id: 20260303-work-kthread-nullfs-875a837f4198


