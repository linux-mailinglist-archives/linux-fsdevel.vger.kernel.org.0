Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9589F0772
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 21:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfKEU6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 15:58:36 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44933 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEU6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:58:36 -0500
X-Originating-IP: 78.194.159.98
Received: from gandi.net (unknown [78.194.159.98])
        (Authenticated sender: thibaut@sautereau.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 614DF60005;
        Tue,  5 Nov 2019 20:58:30 +0000 (UTC)
Date:   Tue, 5 Nov 2019 21:58:30 +0100
From:   Thibaut Sautereau <thibaut@sautereau.fr>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        cgroups@vger.kernel.org
Subject: Re: NULL pointer deref in put_fs_context with unprivileged LXC
Message-ID: <20191105205830.GA871@gandi.net>
References: <20191010213512.GA875@gandi.net>
 <20191011141403.ghjptf4nrttgg7jd@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20191011141403.ghjptf4nrttgg7jd@wittgenstein>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Oct 11, 2019 at 04:14:05PM +0200, Christian Brauner wrote:
> On Thu, Oct 10, 2019 at 11:35:12PM +0200, Thibaut Sautereau wrote:
> > Since v5.1 and as of v5.3.5, I get the following oops every single time
> > I start an *unprivileged* LXC container:
> > 
> > 	BUG: kernel NULL pointer dereference, address: 0000000000000043
> > 	#PF: supervisor read access in kernel mode
> > 	#PF: error_code(0x0000) - not-present page
> > 	PGD 0 P4D 0 
> > 	Oops: 0000 [#1] SMP PTI
> > 	CPU: 3 PID: 3789 Comm: systemd Tainted: G                T 5.3.5 #5
> > 	RIP: 0010:put_fs_context+0x13/0x180
> > 	Code: e4 31 c9 eb c8 e8 1d d6 dc ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 41 54 55 48 89 fd 53 48 8b b>
> > 	RSP: 0018:ffffc90000777e10 EFLAGS: 00010286
> > 	RAX: 00000000fffffff3 RBX: 0000000000000000 RCX: ffffc90000777d6c
> > 	RDX: 0000000000000000 RSI: ffff8884062331e8 RDI: fffffffffffffff3
> > 	RBP: ffff8883e772dc00 R08: ffff88840d6bc680 R09: 0000000000000001
> > 	R10: 0000000000000000 R11: 0000000000000001 R12: fffffffffffffff3
> > 	R13: ffff888405ad2860 R14: ffff8883e772dc00 R15: 0000000000000027
> > 	FS:  00007998d1444980(0000) GS:ffff88840f980000(0000) knlGS:0000000000000000
> > 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	CR2: 0000000000000043 CR3: 000000040d236003 CR4: 00000000001606e0
> > 	Call Trace:
> > 	 do_mount+0x2f6/0xab0
> > 	 ksys_mount+0x79/0xc0
> > 	 __x64_sys_mount+0x1d/0x30
> > 	 do_syscall_64+0x68/0x666
> > 	 entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 	RIP: 0033:0x7998d23aafea
> > 	Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 4>
> > 	RSP: 002b:00007ffd4b0c8bc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> > 	RAX: ffffffffffffffda RBX: 00005ae352a55a30 RCX: 00007998d23aafea
> > 	RDX: 00005ae3529fe0b3 RSI: 00005ae3529fe0d5 RDI: 00005ae3529fe0b3
> > 	RBP: 0000000000000007 R08: 00005ae3529fe0ca R09: 00005ae35433fb20
> > 	R10: 000000000000000e R11: 0000000000000246 R12: 00000000fffffffe
> > 	R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
> > 	Modules linked in:
> > 	CR2: 0000000000000043
> > 	---[ end trace 66de701522a6be46 ]---
> > 	RIP: 0010:put_fs_context+0x13/0x180
> > 	Code: e4 31 c9 eb c8 e8 1d d6 dc ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 41 54 55 48 89 fd 53 48 8b b>
> > 	RSP: 0018:ffffc90000777e10 EFLAGS: 00010286
> > 	RAX: 00000000fffffff3 RBX: 0000000000000000 RCX: ffffc90000777d6c
> > 	RDX: 0000000000000000 RSI: ffff8884062331e8 RDI: fffffffffffffff3
> > 	RBP: ffff8883e772dc00 R08: ffff88840d6bc680 R09: 0000000000000001
> > 	R10: 0000000000000000 R11: 0000000000000001 R12: fffffffffffffff3
> > 	R13: ffff888405ad2860 R14: ffff8883e772dc00 R15: 0000000000000027
> > 	FS:  00007998d1444980(0000) GS:ffff88840f980000(0000) knlGS:0000000000000000
> > 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	CR2: 0000000000000043 CR3: 000000040d236003 CR4: 00000000001606e0
> > 
> > According to GDB:
> > 	$ gdb fs/fs_context.o
> > 	(gdb) l *put_fs_context+0x13
> > 	0xa53 is in put_fs_context (fs/fs_context.c:494).
> > 	489	void put_fs_context(struct fs_context *fc)
> > 	490	{
> > 	491		struct super_block *sb;
> > 	492
> > 	493		if (fc->root) {
> > 	494			sb = fc->root->d_sb;
> > 	495			dput(fc->root);
> > 	496			fc->root = NULL;
> > 	497			deactivate_super(sb);
> > 	498		}
> > 
> > 	$ gdb fs/namespace.o
> > 	(gdb) l *do_mount+0x2f6
> > 	0x5506 is in do_mount (fs/namespace.c:2796).
> > 	2791			err = vfs_get_tree(fc);
> > 	2792		if (!err)
> > 	2793			err = do_new_mount_fc(fc, path, mnt_flags);
> > 	2794
> > 	2795		put_fs_context(fc);
> > 	2796		return err;
> > 	2797	}
> > 	2798
> > 	2799	int finish_automount(struct vfsmount *m, struct path *path)
> > 	2800	{
> > 
> > 
> > I don't face this issue when starting the same container as a
> > privileged one. I tried to strace the container when launched in
> > foreground and the following snippet may be related to the problem:
> > 
> > 	[pid 35813] openat(AT_FDCWD, "/sys/fs", O_RDONLY|O_CLOEXEC|O_PATH|O_DIRECTORY) = 4
> > 	[pid 35813] name_to_handle_at(4, "cgroup", {handle_bytes=128}, 0x7ffcdf6ebac4, AT_SYMLINK_FOLLOW) = -1 EOPNOTSUPP (Operation not supported)
> > 	[pid 35813] name_to_handle_at(4, "", {handle_bytes=128}, 0x7ffcdf6ebac4, AT_EMPTY_PATH) = -1 EOPNOTSUPP (Operation not supported)
> > 	[pid 35813] openat(4, "cgroup", O_RDONLY|O_CLOEXEC|O_PATH) = 5
> > 	[pid 35813] openat(AT_FDCWD, "/proc/self/fdinfo/5", O_RDONLY|O_CLOEXEC) = 6
> > 	[pid 35813] fstat(6, {st_mode=S_IFREG|0400, st_size=0, ...}) = 0
> > 	[pid 35813] fstat(6, {st_mode=S_IFREG|0400, st_size=0, ...}) = 0
> > 	[pid 35813] read(6, "pos:\t0\nflags:\t012000000\nmnt_id:\t"..., 2048) = 36
> > 	[pid 35813] read(6, "", 1024)           = 0
> > 	[pid 35813] close(6)                    = 0
> > 	[pid 35813] close(5)                    = 0
> > 	[pid 35813] openat(AT_FDCWD, "/proc/self/fdinfo/4", O_RDONLY|O_CLOEXEC) = 5
> > 	[pid 35813] fstat(5, {st_mode=S_IFREG|0400, st_size=0, ...}) = 0
> > 	[pid 35813] fstat(5, {st_mode=S_IFREG|0400, st_size=0, ...}) = 0
> > 	[pid 35813] read(5, "pos:\t0\nflags:\t012200000\nmnt_id:\t"..., 2048) = 36
> > 	[pid 35813] read(5, "", 1024)           = 0
> > 	[pid 35813] close(5)                    = 0
> > 	[pid 35813] newfstatat(4, "cgroup", {st_mode=S_IFDIR|0555, st_size=0, ...}, 0) = 0
> > 	[pid 35813] newfstatat(4, "", {st_mode=S_IFDIR|0755, st_size=0, ...}, AT_EMPTY_PATH) = 0
> > 	[pid 35813] close(4)                    = 0
> > 	[pid 35813] stat("/sys/fs", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> > 	[pid 35813] mkdir("/sys/fs/cgroup", 0755) = -1 EEXIST (File exists)
> > 	[pid 35813] stat("/sys/fs/cgroup", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> > 	[pid 35813] mount("tmpfs", "/sys/fs/cgroup", "tmpfs", MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_STRICTATIME, "mode=755") = 0
> > 	[pid 35813] statfs("/sys/fs/cgroup/", {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=2032290, f_bfree=2032290, f_bavail=2032290, f_files=2032290, f_ffree=2032289, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_NOSUID|ST_NODEV|ST_NOEXEC}) = 0
> > 	[pid 35813] statfs("/sys/fs/cgroup/unified/", 0x7ffcdf6ebc10) = -1 ENOENT (No such file or directory)
> > 	[pid 35813] statfs("/sys/fs/cgroup/systemd/", 0x7ffcdf6ebc10) = -1 ENOENT (No such file or directory)
> > 	[pid 35813] openat(AT_FDCWD, "/proc/1/cmdline", O_RDONLY|O_CLOEXEC) = 4
> > 	[pid 35813] prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
> > 	[pid 35813] mmap(NULL, 2101248, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7999ced5b000
> > 	[pid 35813] fstat(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> > 	[pid 35813] read(4, "/sbin/init\0", 1024) = 11
> > 	[pid 35813] read(4, "", 1024)           = 0
> > 	[pid 35813] mremap(0x7999ced5b000, 2101248, 4096, MREMAP_MAYMOVE) = 0x7999ced5b000
> > 	[pid 35813] close(4)                    = 0
> > 	[pid 35813] munmap(0x7999ced5b000, 4096) = 0
> > 	[pid 35813] openat(AT_FDCWD, "/", O_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 4
> > 	[pid 35813] openat(4, "sys", O_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 5
> > 	[pid 35813] fstat(5, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> > 	[pid 35813] close(4)                    = 0
> > 	[pid 35813] openat(5, "fs", O_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 4
> > 	[pid 35813] fstat(4, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> > 	[pid 35813] close(5)                    = 0
> > 	[pid 35813] openat(4, "cgroup", O_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 5
> > 	[pid 35813] fstat(5, {st_mode=S_IFDIR|0755, st_size=40, ...}) = 0
> > 	[pid 35813] close(4)                    = 0
> > 	[pid 35813] openat(5, "unified", O_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH) = -1 ENOENT (No such file or directory)
> > 	[pid 35813] close(5)                    = 0
> > 	[pid 35813] stat("/sys/fs/cgroup", {st_mode=S_IFDIR|0755, st_size=40, ...}) = 0
> > 	[pid 35813] mkdir("/sys/fs/cgroup/unified", 0755) = 0
> > 	[pid 35813] mount("cgroup2", "/sys/fs/cgroup/unified", "cgroup2", MS_NOSUID|MS_NODEV|MS_NOEXEC, "nsdelegate") = ?
> > 	[pid 35813] +++ killed by SIGKILL +++
> > 
> > I've been trying to reproduce by playing with user namespaces and
> > cgroup2 mounts but I didn't succeed. Only an lxc-start of an
> > unprivileged container causes an oops (every single time). I wanted to
> > dive into the code but I hadn't looked at this part of the kernel since
> > the recent rework of file system mounting internals, thus I've been
> > postponing that for weeks now and I thought it was time to report the
> > bug anyway. Sorry for the lack of more detailed info :/
> 
> No worries.
> Let's add David to this.
> 
> Thanks
> Christian

Thanks.

Has anyone been able to reproduce?

Using the attached patch, I got the following logs:

	fs_context: DEBUG: fc = ffff8883c50e3180
	fs_context: DEBUG: fc->root = ffff888364552580
	fs_context: DEBUG: fc->source = none
	fs_context: DEBUG: fc->root->d_sb = ffff88837ce95500
	fs_context: DEBUG: fc = ffff8883c50e2f00
	fs_context: DEBUG: fc->root = ffff8883cb8d06e0
	fs_context: DEBUG: fc->source = proc
	fs_context: DEBUG: fc->root->d_sb = ffff88837f01a200
	fs_context: DEBUG: fc = ffff8883c50e3540
	fs_context: DEBUG: fc->root = ffff8883645534a0
	fs_context: DEBUG: fc->source = sysfs
	fs_context: DEBUG: fc->root->d_sb = ffff88837ce90000
	fs_context: DEBUG: fc = ffff8883c50e2640
	fs_context: DEBUG: fc->root = ffff88833cbf94a0
	fs_context: DEBUG: fc->source = devpts
	fs_context: DEBUG: fc->root->d_sb = ffff88837ea61100
	fs_context: DEBUG: fc = ffff88837c0b7e00
	fs_context: DEBUG: fc->root = ffff888342247b80
	fs_context: DEBUG: fc->source = tmpfs
	fs_context: DEBUG: fc->root->d_sb = ffff88837eb8a200
	fs_context: DEBUG: fc = ffff88837c0b7680
	fs_context: DEBUG: fc->root = ffff888342247080
	fs_context: DEBUG: fc->source = tmpfs
	fs_context: DEBUG: fc->root->d_sb = ffff88837c500000
	fs_context: DEBUG: fc = ffff88837c0b7b80
	fs_context: DEBUG: fc->root = ffff888342246160
	fs_context: DEBUG: fc->source = tmpfs
	fs_context: DEBUG: fc->root->d_sb = ffff88837c51b300
	fs_context: DEBUG: fc = ffff88837c0b72c0
	fs_context: DEBUG: fc->root = ffff888342247a20
	fs_context: DEBUG: fc->source = tmpfs
	fs_context: DEBUG: fc->root->d_sb = ffff88837c361100
	fs_context: DEBUG: fc = ffff88837c0b7900
	fs_context: DEBUG: fc->root = fffffffffffffff3
	fs_context: DEBUG: fc->source = cgroup2
	kasan: CONFIG_KASAN_INLINE enabled
	kasan: GPF could be caused by NULL-ptr deref or user memory access
	general protection fault: 0000 [#2] SMP KASAN PTI
	CPU: 1 PID: 3959 Comm: systemd Tainted: G      D         T 5.3.8+ #12
	Hardware name: Gigabyte Technology Co., Ltd. Z97P-D3/Z97P-D3, BIOS F5 05/30/2014
	RIP: 0010:put_fs_context.cold+0xa9/0x179
	Code: 03 48 c1 e0 2a 80 3c 02 00 0f 85 b9 00 00 00 48 8b 9d 98 00 00 00 b8 ff ff 37 00 48 c1 e0 2a 48 8d 7b 50 48 89 fa 48 c1 ea 03 <80> 3c 02 00 74 05 e8 d5 c1 ef ff 48 8b 73 50 48 c7 c7 e0 35 50 83
	RSP: 0018:ffff88837f18fcb8 EFLAGS: 00010202
	RAX: dffffc0000000000 RBX: fffffffffffffff3 RCX: 0000000000000000
	RDX: 0000000000000008 RSI: ffffed107a015ee2 RDI: 0000000000000043
	RBP: ffff88837c0b7900 R08: 0000000000000027 R09: ffffed107a015ee2
	R10: ffffed107a015ee3 R11: 0000000000000000 R12: ffff88837c0b7998
	R13: ffff88837c0b79c0 R14: ffff88837c0b7900 R15: ffff88837f18fd68
	FS:  0000741e8147a980(0000) GS:ffff8883d0080000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 0000741e81279000 CR3: 00000003c1bd0002 CR4: 00000000001606e0
	Call Trace:
	 do_mount+0x739/0x1660
	 ? copy_mount_string+0x20/0x20
	 ? __kasan_kmalloc.constprop.0+0xc3/0xd0
	 ? __kasan_kmalloc.constprop.0+0xc3/0xd0
	 ksys_mount+0x79/0xc0
	 __x64_sys_mount+0xb5/0x150
	 do_syscall_64+0xe7/0x1287
	 ? syscall_return_slowpath+0x8f0/0x8f0
	 ? trace_hardirqs_off_thunk+0x1a/0x20
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe
	RIP: 0033:0x741e823e0fea
	Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 48
	RSP: 002b:00007ffe0e738948 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
	RAX: ffffffffffffffda RBX: 000057eea0dd9a30 RCX: 0000741e823e0fea
	RDX: 000057eea0d820b3 RSI: 000057eea0d820d5 RDI: 000057eea0d820b3
	RBP: 0000000000000007 R08: 000057eea0d820ca R09: 000057eea1dd3b20
	R10: 000000000000000e R11: 0000000000000246 R12: 00000000fffffffe
	R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
	Modules linked in:
	---[ end trace 914fc1428888c43a ]---
	RIP: 0010:put_fs_context.cold+0xa9/0x179
	Code: 03 48 c1 e0 2a 80 3c 02 00 0f 85 b9 00 00 00 48 8b 9d 98 00 00 00 b8 ff ff 37 00 48 c1 e0 2a 48 8d 7b 50 48 89 fa 48 c1 ea 03 <80> 3c 02 00 74 05 e8 d5 c1 ef ff 48 8b 73 50 48 c7 c7 e0 35 50 83
	RSP: 0018:ffff88837f17fcb8 EFLAGS: 00010202
	RAX: dffffc0000000000 RBX: fffffffffffffff3 RCX: 0000000000000000
	RDX: 0000000000000008 RSI: ffffed107a015ee2 RDI: 0000000000000043
	RBP: ffff88833bcd03c0 R08: 0000000000000027 R09: ffffed107a015ee2
	R10: ffffed107a015ee3 R11: 0000000000000000 R12: ffff88833bcd0458
	R13: ffff88833bcd0480 R14: ffff88833bcd03c0 R15: ffff88837f17fd68
	FS:  0000741e8147a980(0000) GS:ffff8883d0080000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 0000741e81279000 CR3: 00000003c1bd0002 CR4: 00000000001606e0

0xfffffffffffffff3 seems to be a weird value for fc->root. This would
imply that the fc->root dereference to get fc->root->d_sb is causing the
bug, and confirm that the issue is related to cgroup2 mounting.

-- 
Thibaut Sautereau

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="0001-DEBUG.patch"

From 1c71dca8a567749bb246d7de37cb99934a820293 Mon Sep 17 00:00:00 2001
From: Thibaut Sautereau <thibaut@sautereau.fr>
Date: Wed, 30 Oct 2019 23:12:51 +0100
Subject: [PATCH] DEBUG

---
 fs/fs_context.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 87c2c9687d90..37c8d2b43ac8 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -491,6 +491,10 @@ void put_fs_context(struct fs_context *fc)
 	struct super_block *sb;
 
 	if (fc->root) {
+		pr_err("DEBUG: fc = %px\n", fc);
+		pr_err("DEBUG: fc->root = %px\n", fc->root);
+		pr_err("DEBUG: fc->source = %s\n", fc->source);
+		pr_err("DEBUG: fc->root->d_sb = %px\n", fc->root->d_sb);
 		sb = fc->root->d_sb;
 		dput(fc->root);
 		fc->root = NULL;
-- 
2.24.0


--LZvS9be/3tNcYl/X--
