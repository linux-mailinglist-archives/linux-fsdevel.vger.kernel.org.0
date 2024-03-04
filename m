Return-Path: <linux-fsdevel+bounces-13434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37E86FC75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 09:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F97B225A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CA6383B6;
	Mon,  4 Mar 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j21QXRRR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23820323;
	Mon,  4 Mar 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542287; cv=none; b=Y4ny3QQgeB/CjjJ2j81Y17ZdHVvX8shIy2s/4zPWHUxXmqdUeTBmjIwsz0APWsvQWT5z1YY/tE/Iehu0CDSoVvZ/CRU3V/1vKK5EdRXz0nedqglHaYZq1Ut7Xf5z3UYsce5ODuICglkRYbq1DMpmcKoK04sQzmRQqyEZVJAhdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542287; c=relaxed/simple;
	bh=w2eZsthnjoEvUHMk1iP4V1pVzzXUa40FNFENGYsiBmI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=j/Fk5zc/A9KIMmUZFyJCTWmWhTauB8slt9ptMMxaV2wo5HIWK5LKVRTjeXIxr2f+sLJ9jAstLAT53YTNs6xkgTWJwhHqHD9Bfh+Jhw8FoHdEs5gPuMXGVtGAke5jWG6Iv7mXKifuc4mScMRyx5tTGXZ3hWnvrLsHyU0z0N+cc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j21QXRRR; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce2aada130so3762066a12.1;
        Mon, 04 Mar 2024 00:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709542285; x=1710147085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2+UgTHUCsIErlBv9OhJxPkdYfmt79DFlNGrnlohbh1E=;
        b=j21QXRRRIRKqfQ4uwrOw6gdGtlR1imHhGwthlXHmajmoW9glRmhBXusWbldqCWTsUP
         iwsXuWHM7wEH025EYWGdexND9x5pjSAN4d0C9JHenxcymWiN8Iygm7mi89J0jf1I26D4
         9PaIsxzMFHN8bUdB/svVBMCPIyrIb+OFhaglUCA6mgjTmloIZzrcAxyAi4UaLtEwOpCm
         3N/rY5nOiopdyGIFVomMMGnVKWYRhvCHJoWIbBYbvPhNbnpfpnMY7ItHW2X+lLt02Omj
         d3gV57b38AhzKP3qO7PvxiebucA26rOXX1HiXjsYWwCvoCpyL2rMGaUea6VF9XOjE453
         fGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709542285; x=1710147085;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+UgTHUCsIErlBv9OhJxPkdYfmt79DFlNGrnlohbh1E=;
        b=kzt6C76OmhQkdHa2iDkKPxmfj7LqVpdiP8/taI7ctlHxzLWhyk3ezCnUDNd7/boaNJ
         MLy44ZmCrChWJn1uwpS2KgJ15hVa1yA33tUM1THiCwKj8V4I8a+psFea/5qtro50/fXD
         vPT3+eHnHLQtj9KIhH9K+NPZIXJkakr7AJkUXZisBz8n8mg4EaEdDeGgRN14IsT8uEha
         tQpKsqy8tRFOQR0OXSq3n7cycLuERayZlDWhVtta9kVyA/MQf1te8p4a+JrLurfmfb37
         iLE+PyGSDejmod/qu3J7M5ULuV4r8g1t7HtxUTGpfxc7nYCmXI8FHa6oVUi1psU4F4yi
         7qFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRcnWId7Ft+2ztah0t91APCpW1eMmYW3OCu2UdlFjcpf2vI3yHcJt6UXL0M6HHtZbsOifWk2Tg2KIGrfki4PVebhEjyvgzM//pUPGZ7w==
X-Gm-Message-State: AOJu0YzyYjf2QwKctOFKJvv3CRZOctydH2Q+22ks/AyRrlhkRlnBEJnT
	X37/wtr/etstFzJuDv8/RKYLA0zgg+bWYY9yhqpRe/1MEGjPSPgZl4PKrRGN9chwafdYMHOh2N9
	jJu2FK+bTmctcgkdc993Miyqn8kY59x0F+IhENA==
X-Google-Smtp-Source: AGHT+IG/WHORUUKN6bktKirGMjGC09OenzoX8zsU5V+2b+6/aCuHyh5YJtOO2VVGbPqSJC53qZUoIqYUxrIsERw0UbM=
X-Received: by 2002:a17:90a:d258:b0:299:14c9:94f0 with SMTP id
 o24-20020a17090ad25800b0029914c994f0mr5409755pjw.11.1709542284844; Mon, 04
 Mar 2024 00:51:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Mon, 4 Mar 2024 16:51:13 +0800
Message-ID: <CABOYnLwY5Y499j=JgWtk9ksRneOzLoH_G9dYZTwXi=UvLbUsSg@mail.gmail.com>
Subject: WARNING in vfs_getxattr_alloc
To: linux-kernel@vger.kernel.org
Cc: samsun1006219@gmail.com, linux-fsdevel@vger.kernel.org, 
	syzkaller@googlegroups.com, jack@suse.cz, viro@zeniv.linux.org.uk, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello I found a issue in latest linux 6.7.rc8 titled "WARNING in
vfs_getxattr_alloc".

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: sam sun <samsun1006219@gmail.com>

kernel: lastest linux 6.7.rc8 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=4a65fa9f077ead01
with KASAN enabled
compiler: gcc (GCC) 12.2.0

TITLE: WARNING in vfs_getxattr_alloc------------[ cut here ]------------
WARNING: CPU: 1 PID: 8212 at mm/page_alloc.c:4543
__alloc_pages+0x3ab/0x4a0 mm/page_alloc.c:4543
Modules linked in:
CPU: 1 PID: 8212 Comm: 586 Not tainted 6.8.0-rc7 #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
RIP: 0010:__alloc_pages+0x3ab/0x4a0 mm/page_alloc.c:4543
Code: ff ff 00 0f 84 2f fe ff ff 80 ce 01 e9 27 fe ff ff 83 fe 0a 0f
86 3a fd ff ff 80 3d 66 9d 73 0c 00 75 09 cf
RSP: 0018:ffffc90010f7f7f0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000040c40 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000011 RDI: 0000000000040c40
RBP: 1ffff920021efeff R08: 0000000000000001 R09: ffffed100376f8a4
R10: ffffc90010f7f9b0 R11: 0000000000000000 R12: 0000000000000011
R13: 0000000000000000 R14: 0000000000000c40 R15: 00000000ffffffff
FS: 0000000000cbc380(0000) GS:ffff88823bc00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200012c0 CR3: 0000000016f84000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
<TASK>
__alloc_pages_node include/linux/gfp.h:238 [inline]
alloc_pages_node include/linux/gfp.h:261 [inline]
__kmalloc_large_node+0x7f/0x1a0 mm/slub.c:3926
__do_kmalloc_node mm/slub.c:3969 [inline]
__kmalloc_node_track_caller.cold+0x5/0xe2 mm/slub.c:4001
__do_krealloc mm/slab_common.c:1187 [inline]
krealloc+0x5d/0x100 mm/slab_common.c:1220
vfs_getxattr_alloc+0x1d1/0x300 fs/xattr.c:399
cap_inode_getsecurity+0xc8/0x700 security/commoncap.c:402
security_inode_getsecurity+0xaa/0x100 security/security.c:2502
xattr_getsecurity fs/xattr.c:346 [inline]
vfs_getxattr+0x170/0x1b0 fs/xattr.c:446
do_getxattr+0x1a7/0x330 fs/xattr.c:739
getxattr+0xeb/0x150 fs/xattr.c:772
path_getxattr+0xd2/0x150 fs/xattr.c:788
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x78/0x1c0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x431869
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 48
RSP: 002b:00007fff81cc9318 EFLAGS: 00000246 ORIG_RAX: 00000000000000c0
RAX: ffffffffffffffda RBX: 00007fff81cc9508 RCX: 0000000000431869
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000020000000
RBP: 00007fff81cc9330 R08: 0000000000003928 R09: 0000000000003928
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff81cc94f8 R14: 0000000000000001 R15: 0000000000000001
</TASK>


=* repro.c =*
#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

uint64_t r[4] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff,
                 0xffffffffffffffff};

int main(void) {
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  intptr_t res = 0;
  memcpy((void*)0x200002c0, "./file0\000", 8);
  syscall(__NR_mkdir, /*path=*/0x200002c0ul, /*mode=*/0ul);
  memcpy((void*)0x20000280, "security.capability\000", 20);
  syscall(__NR_setxattr, /*path=*/0ul, /*name=*/0x20000280ul, /*val=*/0ul,
          /*size=*/0ul, /*flags=*/0ul);
  res = syscall(__NR_pipe2, /*pipefd=*/0x20000240ul, /*flags=*/0ul);
  if (res != -1) {
    r[0] = *(uint32_t*)0x20000240;
    r[1] = *(uint32_t*)0x20000244;
  }
  memcpy((void*)0x20000080,
         "\x15\x00\x00\x00\x65\xff\xff\x09\x7b\x00\x00\x08\x00\x39\x50\x32\x30"
         "\x30\x30\x2e\x4c",
         21);
  syscall(__NR_write, /*fd=*/r[1], /*data=*/0x20000080ul, /*size=*/0x15ul);
  res = syscall(__NR_dup, /*oldfd=*/r[1]);
  if (res != -1)
    r[2] = res;
  *(uint32_t*)0x20000100 = 0x18;
  *(uint32_t*)0x20000104 = 0;
  *(uint64_t*)0x20000108 = 0;
  *(uint64_t*)0x20000110 = 0;
  syscall(__NR_write, /*fd=*/r[2], /*arg=*/0x20000100ul, /*len=*/0x18ul);
  memset((void*)0x200012c0, 176, 1);
  syscall(__NR_write, /*fd=*/r[2], /*arg=*/0x200012c0ul, /*len=*/0xb0ul);
  res = syscall(__NR_getresuid, /*ruid=*/0x20000440ul, /*euid=*/0x20000480ul,
                /*suid=*/0x200004c0ul);
  if (res != -1)
    r[3] = *(uint32_t*)0x200004c0;
  memcpy((void*)0x200000c0,
         "\x10\x00\x00\x00\x00\x00\x00\x00\xab\xb7\x1b\x83\x88\x62\x0a\xa1\x53"
         "\xa4\xcb\x6d\x9e\x9e\xb0\x4d\x13\x52\xf4\x1b\xf1\x2c\x22\x04\x9a\xd4"
         "\x34\xcb\x2d\xb6\x63\x7e\x0c\x13",
         42);
  *(uint64_t*)0x200000ea = 0;
  syscall(__NR_write, /*fd=*/r[2], /*arg=*/0x200000c0ul, /*len=*/0x10ul);
  memcpy((void*)0x20000040, "./file0\000", 8);
  memcpy((void*)0x20000b80, "9p\000", 3);
  memcpy((void*)0x20000580, "trans=fd,rfdno=", 15);
  sprintf((char*)0x2000058f, "0x%016llx", (long long)r[0]);
  memcpy((void*)0x200005a1, ",wfdno=", 7);
  sprintf((char*)0x200005a8, "0x%016llx", (long long)r[2]);
  memcpy((void*)0x200005ba, ",privport,access=", 17);
  sprintf((char*)0x200005cb, "%020llu", (long long)r[3]);
  syscall(__NR_mount, /*src=*/0ul, /*dst=*/0x20000040ul, /*type=*/0x20000b80ul,
          /*flags=*/0ul, /*opts=*/0x20000580ul);
  memcpy((void*)0x20000000, "./file0\000", 8);
  syscall(__NR_lgetxattr, /*path=*/0x20000000ul, /*name=*/0x20000280ul,
          /*val=*/0ul, /*size=*/0ul);
  return 0;
}


=* repro.txt =*
mkdir(&(0x7f00000002c0)='./file0\x00', 0x0)
setxattr$security_capability(0x0, &(0x7f0000000280), 0x0, 0x0, 0x0)
pipe2$9p(&(0x7f0000000240)={<r0=>0xffffffffffffffff,
<r1=>0xffffffffffffffff}, 0x0)
write$P9_RVERSION(r1,
&(0x7f0000000080)=ANY=[@ANYBLOB="1500000065ffff097b000008003950323030302e4c"],
0x15)
r2 = dup(r1)
write$FUSE_BMAP(r2, &(0x7f0000000100)={0x18}, 0x18)
write$FUSE_DIRENTPLUS(r2, &(0x7f00000012c0)=ANY=[@ANYBLOB="b0"], 0xb0)
getresuid(&(0x7f0000000440), &(0x7f0000000480), &(0x7f00000004c0)=<r3=>0x0)
write$FUSE_DIRENTPLUS(r2,
&(0x7f00000000c0)=ANY=[@ANYBLOB="1000000000000000abb71b8388620aa153a4cb6d9e9eb04d1352f41bf12c22049ad434cb2db6637e0c13",
@ANYRES64=0x0], 0x10)
mount$9p_fd(0x0, &(0x7f0000000040)='./file0\x00', &(0x7f0000000b80),
0x0, &(0x7f0000000580)=ANY=[@ANYBLOB='trans=fd,rfdno=', @ANYRESHEX=r0,
@ANYBLOB=',wfdno=', @ANYRESHEX=r2, @ANYBLOB=',privport,access=',
@ANYRESDEC=r3])
lgetxattr(&(0x7f0000000000)='./file0\x00', &(0x7f0000000280)=ANY=[], 0x0, 0x0)

Aslo see https://gist.github.com/xrivendell7/1487d0ffb0bc3836c9202da1dd7cff06.

I hope it helps.
Best regards.
xingwei Lee

