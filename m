Return-Path: <linux-fsdevel+bounces-10493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7BC84BA01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CBD1C2149E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5CD134CC7;
	Tue,  6 Feb 2024 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2XIgYV5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7F13341C;
	Tue,  6 Feb 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234313; cv=none; b=pbqKQWgtjVhQA+x0/Bmvjlj6NI8y+RWRFkcnBCcdJwrkSOsjQcRUMChQvjnZk1JBjX65lYTCn8AUMdAHgHdcUPynUhhn2N556HLhc0moiWz0gpU3PwAYzX3ylmVq718k9cf14m4N5C2geNUmtu75GAkp7ih1TnKnq6A0gyI+QvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234313; c=relaxed/simple;
	bh=WdwluaSLh8sAnwZ6h5MzuKg4CBtdQ3PsupRCDtlsMvg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XS22CJsBuOqnJzIj+8C7S3STPDc/OORsvPlGfIvTZzqhDZkUsiSlNtEwmC/Y079KbvTkVz8bKG0gTtmY8lo1L+w7Dvfq+um1vtPDKtWQXIyDbVNN9Q1Nqw/frUP9sTadZtXyL/mxRZyDsebbJClEJ1nXDJwE5AN1QqK94MdsIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2XIgYV5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so3923933b3a.1;
        Tue, 06 Feb 2024 07:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707234310; x=1707839110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=60TmduK0iJQPPgcv9orCiJ06VXM4KEt2Kw35slBcbb8=;
        b=P2XIgYV568YgwRE2wR90G4KToN4N5FLmLv6xLSRztW4yghXPDgIZyoZ3/WutMU0yp1
         4WeDae8ZVUZkyZeqYIVcwC+jZ3S0onEWG7moBnr/4pTFOwJQQdMpbNN4bZMiWZE0YSSR
         dzOQN/2WfB1J91gb1WGZX9oEhtERJud2/2wzdEJWGqhCXyXt8UWeoprOGfqTQY9axm5O
         spqvGZ9DUdT5Ecpd0Xxei6YC8iDKjWNkr3/2pO442QlreHK8Qs3e3p6AhUrK06rrucAU
         biw8Z2uGd2/2s9dEf6dyVsC483aFgZh4KltU4HOOb6oED2JZYG8O6YjGMXKvmXCY/e+5
         1r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707234310; x=1707839110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60TmduK0iJQPPgcv9orCiJ06VXM4KEt2Kw35slBcbb8=;
        b=I46pw6lwh63WmYM0osNNR47bhmarkf2D2wlqB04f72NgFoqijLBWOV7H6pOwVokRhn
         pM5kjVnWZiYs8URRQ4GQ+MabiURbA1V/Dz7FpLNeVaJEzh3fIH9KPBxbg2YcpFgEGoNh
         P+4c+hw7pUsBivbtNduHqdSMDduntJLp+ThXwVSvuekKvcpn5qz9P4HzZ00Apdqz2oFP
         QuesqnFWcylLS10IXNxPmZOc1kfi0rg3jYpCN0Xj48SXzGjG9ZN0z7FI64DpyuPNrj/i
         yV+cUXb3pDBV75jg2h0SkC+DnQTz5gqI1JhoX+FgAi0OGPgY6xWOW7Mv3e6hNJd+6qWe
         8Sbg==
X-Gm-Message-State: AOJu0YwioT2+E7NUbLowm1i472gwTXRGLUkxV7jVUqd0nXz8qFdLuT8/
	FpoC1NwBA0BaTMAsPIai7y94IxnwgqNF6230khmpD9jJoD5EPeE1qklvwBn6PWJdpiRljM0H5aQ
	5pu9e3T/JLlDWoeCBNE1UnESdQL4=
X-Google-Smtp-Source: AGHT+IHyHFDCn8RmDwlrIgyQIb0DsPxVWzm+uh9VKEaBk+SSiCMo7jUQ+8U/MnnWXEKLXJoUUnuioTVvKU1XTTyZMp8=
X-Received: by 2002:a62:d401:0:b0:6df:fa71:f044 with SMTP id
 a1-20020a62d401000000b006dffa71f044mr2298082pfh.0.1707234309885; Tue, 06 Feb
 2024 07:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Tue, 6 Feb 2024 23:44:58 +0800
Message-ID: <CABOYnLyPn2KRSNf2rYxg11zY1Fb-yoRMqGb1jY7kaMnUVrZ4BQ@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data_end (2)
To: syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, I reproduced this bug and comfired in the latest upstream.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

Notice, I use the different kernel config with syzbot dashboard.
kernel version:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=
=3D99bd3cb0d12e85d5114425353552121ec8f93adc
kernel config: https://gist.githubusercontent.com/xrivendell7/3e47849a9a19d=
ebf45b5829f04977c71/raw/5ec6eeb6a572480575903151e17ea9fc36fc22c4/config
with KASAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.4=
0

TITLE: kernel BUG in ext4_write_inline_data_end
------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:235!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 8926 Comm: 0fe-1 Not tainted 6.8.0-rc1-00208-g6a3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 4
RIP: 0010:ext4_write_inline_data fs/ext4/inline.c:235 [inline]
RIP: 0010:ext4_write_inline_data_end+0x8ff/0x910 fs/ext4/inline.c:773
Code: ff 0f 0b e9 2c fd ff ff 31 ff e8 dc ed a0 ff 0f 0b 31 5
RSP: 0018:ffff88814fc7f3a0 EFLAGS: 00010293
RAX: ffffffff81a200cf RBX: 000000000000003c RCX: 000000000000
RDX: 0000000000000000 RSI: ffff888149114b40 RDI: 000000000000
RBP: ffff88814fc7f4e0 R08: ffffffff81a1fab0 R09: 1ffff1102936
R10: ffffed102939c247 R11: ffffed102939c247 R12: ffffea000560
R13: ffff8881574aafe0 R14: 0000000000000000 R15: 000000000000
FS:  00007f3853cff6c0(0000) GS:ffff88823bd00000(0000) knlGS:0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 000000000f4fb000 CR4: 000000000070
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000000
PKRU: 55555554
Call Trace:
 <TASK>
 ext4_da_write_end+0x1a9/0x800 fs/ext4/inode.c:3028
 generic_perform_write+0x2c9/0x4a0 mm/filemap.c:3941
 ext4_buffered_write_iter+0x9e/0x210 fs/ext4/file.c:299
 ext4_file_write_iter+0x16d/0x12e0 fs/ext4/file.c:698
 call_write_iter include/linux/fs.h:2085 [inline]
 iter_file_splice_write+0x792/0xc10 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x17f/0x2e0 fs/splice.c:1164
 splice_direct_to_actor+0x3dd/0x770 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x18e/0x220 fs/splice.c:1233
 do_sendfile+0x46f/0xa30 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64 fs/read_write.c:1348 [inline]
 __x64_sys_sendfile64+0x151/0x190 fs/read_write.c:1348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x59/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Remember to run this repro.txt with the command: syz-execprog -repeat
0 ./repro.txt and wait for about 3-4minus, the bug triggered very
steady.

=3D* repro.c =3D*
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <setjmp.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>
#include <linux/loop.h>

#ifndef __NR_memfd_create
#define __NR_memfd_create 319
#endif

static unsigned long long procid;

static void sleep_ms(uint64_t ms) {
  usleep(ms * 1000);
}

static uint64_t current_time_ms(void) {
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void use_temporary_dir(void) {
  char tmpdir_template[] =3D "./syzkaller.XXXXXX";
  char* tmpdir =3D mkdtemp(tmpdir_template);
  if (!tmpdir)
    exit(1);
  if (chmod(tmpdir, 0777))
    exit(1);
  if (chdir(tmpdir))
    exit(1);
}

static void thread_start(void* (*fn)(void*), void* arg) {
  pthread_t th;
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setstacksize(&attr, 128 << 10);
  int i =3D 0;
  for (; i < 100; i++) {
    if (pthread_create(&th, &attr, fn, arg) =3D=3D 0) {
      pthread_attr_destroy(&attr);
      return;
    }
    if (errno =3D=3D EAGAIN) {
      usleep(50);
      continue;
    }
    break;
  }
  exit(1);
}

typedef struct {
  int state;
} event_t;

static void event_init(event_t* ev) {
  ev->state =3D 0;
}

static void event_reset(event_t* ev) {
  ev->state =3D 0;
}

static void event_set(event_t* ev) {
  if (ev->state)
    exit(1);
  __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
  syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev) {
  while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev) {
  return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout) {
  uint64_t start =3D current_time_ms();
  uint64_t now =3D start;
  for (;;) {
    uint64_t remain =3D timeout - (now - start);
    struct timespec ts;
    ts.tv_sec =3D remain / 1000;
    ts.tv_nsec =3D (remain % 1000) * 1000 * 1000;
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts)=
;
    if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
      return 1;
    now =3D current_time_ms();
    if (now - start > timeout)
      return 0;
  }
}

static bool write_file(const char* file, const char* what, ...) {
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] =3D 0;
  int len =3D strlen(buf);
  int fd =3D open(file, O_WRONLY | O_CLOEXEC);
  if (fd =3D=3D -1)
    return false;
  if (write(fd, buf, len) !=3D len) {
    int err =3D errno;
    close(fd);
    errno =3D err;
    return false;
  }
  close(fd);
  return true;
}

//% This code is derived from puff.{c,h}, found in the zlib development. Th=
e
//% original files come with the following copyright notice:

//% Copyright (C) 2002-2013 Mark Adler, all rights reserved
//% version 2.3, 21 Jan 2013
//% This software is provided 'as-is', without any express or implied
//% warranty.  In no event will the author be held liable for any damages
//% arising from the use of this software.
//% Permission is granted to anyone to use this software for any purpose,
//% including commercial applications, and to alter it and redistribute it
//% freely, subject to the following restrictions:
//% 1. The origin of this software must not be misrepresented; you must not
//%    claim that you wrote the original software. If you use this software
//%    in a product, an acknowledgment in the product documentation would b=
e
//%    appreciated but is not required.
//% 2. Altered source versions must be plainly marked as such, and must not=
 be
//%    misrepresented as being the original software.
//% 3. This notice may not be removed or altered from any source distributi=
on.
//% Mark Adler    madler@alumni.caltech.edu

//% BEGIN CODE DERIVED FROM puff.{c,h}

#define MAXBITS 15
#define MAXLCODES 286
#define MAXDCODES 30
#define MAXCODES (MAXLCODES + MAXDCODES)
#define FIXLCODES 288

struct puff_state {
  unsigned char* out;
  unsigned long outlen;
  unsigned long outcnt;
  const unsigned char* in;
  unsigned long inlen;
  unsigned long incnt;
  int bitbuf;
  int bitcnt;
  jmp_buf env;
};
static int puff_bits(struct puff_state* s, int need) {
  long val =3D s->bitbuf;
  while (s->bitcnt < need) {
    if (s->incnt =3D=3D s->inlen)
      longjmp(s->env, 1);
    val |=3D (long)(s->in[s->incnt++]) << s->bitcnt;
    s->bitcnt +=3D 8;
  }
  s->bitbuf =3D (int)(val >> need);
  s->bitcnt -=3D need;
  return (int)(val & ((1L << need) - 1));
}
static int puff_stored(struct puff_state* s) {
  s->bitbuf =3D 0;
  s->bitcnt =3D 0;
  if (s->incnt + 4 > s->inlen)
    return 2;
  unsigned len =3D s->in[s->incnt++];
  len |=3D s->in[s->incnt++] << 8;
  if (s->in[s->incnt++] !=3D (~len & 0xff) ||
      s->in[s->incnt++] !=3D ((~len >> 8) & 0xff))
    return -2;
  if (s->incnt + len > s->inlen)
    return 2;
  if (s->outcnt + len > s->outlen)
    return 1;
  for (; len--; s->outcnt++, s->incnt++) {
    if (s->in[s->incnt])
      s->out[s->outcnt] =3D s->in[s->incnt];
  }
  return 0;
}
struct puff_huffman {
  short* count;
  short* symbol;
};
static int puff_decode(struct puff_state* s, const struct puff_huffman* h) =
{
  int first =3D 0;
  int index =3D 0;
  int bitbuf =3D s->bitbuf;
  int left =3D s->bitcnt;
  int code =3D first =3D index =3D 0;
  int len =3D 1;
  short* next =3D h->count + 1;
  while (1) {
    while (left--) {
      code |=3D bitbuf & 1;
      bitbuf >>=3D 1;
      int count =3D *next++;
      if (code - count < first) {
        s->bitbuf =3D bitbuf;
        s->bitcnt =3D (s->bitcnt - len) & 7;
        return h->symbol[index + (code - first)];
      }
      index +=3D count;
      first +=3D count;
      first <<=3D 1;
      code <<=3D 1;
      len++;
    }
    left =3D (MAXBITS + 1) - len;
    if (left =3D=3D 0)
      break;
    if (s->incnt =3D=3D s->inlen)
      longjmp(s->env, 1);
    bitbuf =3D s->in[s->incnt++];
    if (left > 8)
      left =3D 8;
  }
  return -10;
}
static int puff_construct(struct puff_huffman* h, const short* length, int =
n) {
  int len;
  for (len =3D 0; len <=3D MAXBITS; len++)
    h->count[len] =3D 0;
  int symbol;
  for (symbol =3D 0; symbol < n; symbol++)
    (h->count[length[symbol]])++;
  if (h->count[0] =3D=3D n)
    return 0;
  int left =3D 1;
  for (len =3D 1; len <=3D MAXBITS; len++) {
    left <<=3D 1;
    left -=3D h->count[len];
    if (left < 0)
      return left;
  }
  short offs[MAXBITS + 1];
  offs[1] =3D 0;
  for (len =3D 1; len < MAXBITS; len++)
    offs[len + 1] =3D offs[len] + h->count[len];
  for (symbol =3D 0; symbol < n; symbol++)
    if (length[symbol] !=3D 0)
      h->symbol[offs[length[symbol]]++] =3D symbol;
  return left;
}
static int puff_codes(struct puff_state* s,
                      const struct puff_huffman* lencode,
                      const struct puff_huffman* distcode) {
  static const short lens[29] =3D {3,  4,  5,  6,   7,   8,   9,   10,  11,=
 13,
                                 15, 17, 19, 23,  27,  31,  35,  43,  51, 5=
9,
                                 67, 83, 99, 115, 131, 163, 195, 227, 258};
  static const short lext[29] =3D {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2=
, 2,
                                 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0};
  static const short dists[30] =3D {
      1,    2,    3,    4,    5,    7,    9,    13,    17,    25,
      33,   49,   65,   97,   129,  193,  257,  385,   513,   769,
      1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577};
  static const short dext[30] =3D {0, 0, 0,  0,  1,  1,  2,  2,  3,  3,
                                 4, 4, 5,  5,  6,  6,  7,  7,  8,  8,
                                 9, 9, 10, 10, 11, 11, 12, 12, 13, 13};
  int symbol;
  do {
    symbol =3D puff_decode(s, lencode);
    if (symbol < 0)
      return symbol;
    if (symbol < 256) {
      if (s->outcnt =3D=3D s->outlen)
        return 1;
      if (symbol)
        s->out[s->outcnt] =3D symbol;
      s->outcnt++;
    } else if (symbol > 256) {
      symbol -=3D 257;
      if (symbol >=3D 29)
        return -10;
      int len =3D lens[symbol] + puff_bits(s, lext[symbol]);
      symbol =3D puff_decode(s, distcode);
      if (symbol < 0)
        return symbol;
      unsigned dist =3D dists[symbol] + puff_bits(s, dext[symbol]);
      if (dist > s->outcnt)
        return -11;
      if (s->outcnt + len > s->outlen)
        return 1;
      while (len--) {
        if (dist <=3D s->outcnt && s->out[s->outcnt - dist])
          s->out[s->outcnt] =3D s->out[s->outcnt - dist];
        s->outcnt++;
      }
    }
  } while (symbol !=3D 256);
  return 0;
}
static int puff_fixed(struct puff_state* s) {
  static int virgin =3D 1;
  static short lencnt[MAXBITS + 1], lensym[FIXLCODES];
  static short distcnt[MAXBITS + 1], distsym[MAXDCODES];
  static struct puff_huffman lencode, distcode;
  if (virgin) {
    lencode.count =3D lencnt;
    lencode.symbol =3D lensym;
    distcode.count =3D distcnt;
    distcode.symbol =3D distsym;
    short lengths[FIXLCODES];
    int symbol;
    for (symbol =3D 0; symbol < 144; symbol++)
      lengths[symbol] =3D 8;
    for (; symbol < 256; symbol++)
      lengths[symbol] =3D 9;
    for (; symbol < 280; symbol++)
      lengths[symbol] =3D 7;
    for (; symbol < FIXLCODES; symbol++)
      lengths[symbol] =3D 8;
    puff_construct(&lencode, lengths, FIXLCODES);
    for (symbol =3D 0; symbol < MAXDCODES; symbol++)
      lengths[symbol] =3D 5;
    puff_construct(&distcode, lengths, MAXDCODES);
    virgin =3D 0;
  }
  return puff_codes(s, &lencode, &distcode);
}
static int puff_dynamic(struct puff_state* s) {
  static const short order[19] =3D {16, 17, 18, 0, 8,  7, 9,  6, 10, 5,
                                  11, 4,  12, 3, 13, 2, 14, 1, 15};
  int nlen =3D puff_bits(s, 5) + 257;
  int ndist =3D puff_bits(s, 5) + 1;
  int ncode =3D puff_bits(s, 4) + 4;
  if (nlen > MAXLCODES || ndist > MAXDCODES)
    return -3;
  short lengths[MAXCODES];
  int index;
  for (index =3D 0; index < ncode; index++)
    lengths[order[index]] =3D puff_bits(s, 3);
  for (; index < 19; index++)
    lengths[order[index]] =3D 0;
  short lencnt[MAXBITS + 1], lensym[MAXLCODES];
  struct puff_huffman lencode =3D {lencnt, lensym};
  int err =3D puff_construct(&lencode, lengths, 19);
  if (err !=3D 0)
    return -4;
  index =3D 0;
  while (index < nlen + ndist) {
    int symbol;
    int len;
    symbol =3D puff_decode(s, &lencode);
    if (symbol < 0)
      return symbol;
    if (symbol < 16)
      lengths[index++] =3D symbol;
    else {
      len =3D 0;
      if (symbol =3D=3D 16) {
        if (index =3D=3D 0)
          return -5;
        len =3D lengths[index - 1];
        symbol =3D 3 + puff_bits(s, 2);
      } else if (symbol =3D=3D 17)
        symbol =3D 3 + puff_bits(s, 3);
      else
        symbol =3D 11 + puff_bits(s, 7);
      if (index + symbol > nlen + ndist)
        return -6;
      while (symbol--)
        lengths[index++] =3D len;
    }
  }
  if (lengths[256] =3D=3D 0)
    return -9;
  err =3D puff_construct(&lencode, lengths, nlen);
  if (err && (err < 0 || nlen !=3D lencode.count[0] + lencode.count[1]))
    return -7;
  short distcnt[MAXBITS + 1], distsym[MAXDCODES];
  struct puff_huffman distcode =3D {distcnt, distsym};
  err =3D puff_construct(&distcode, lengths + nlen, ndist);
  if (err && (err < 0 || ndist !=3D distcode.count[0] + distcode.count[1]))
    return -8;
  return puff_codes(s, &lencode, &distcode);
}
static int puff(unsigned char* dest,
                unsigned long* destlen,
                const unsigned char* source,
                unsigned long sourcelen) {
  struct puff_state s =3D {
      .out =3D dest,
      .outlen =3D *destlen,
      .outcnt =3D 0,
      .in =3D source,
      .inlen =3D sourcelen,
      .incnt =3D 0,
      .bitbuf =3D 0,
      .bitcnt =3D 0,
  };
  int err;
  if (setjmp(s.env) !=3D 0)
    err =3D 2;
  else {
    int last;
    do {
      last =3D puff_bits(&s, 1);
      int type =3D puff_bits(&s, 2);
      err =3D type =3D=3D 0 ? puff_stored(&s)
                      : (type =3D=3D 1 ? puff_fixed(&s)
                                   : (type =3D=3D 2 ? puff_dynamic(&s) : -1=
));
      if (err !=3D 0)
        break;
    } while (!last);
  }
  *destlen =3D s.outcnt;
  return err;
}

//% END CODE DERIVED FROM puff.{c,h}

#define ZLIB_HEADER_WIDTH 2

static int puff_zlib_to_file(const unsigned char* source,
                             unsigned long sourcelen,
                             int dest_fd) {
  if (sourcelen < ZLIB_HEADER_WIDTH)
    return 0;
  source +=3D ZLIB_HEADER_WIDTH;
  sourcelen -=3D ZLIB_HEADER_WIDTH;
  const unsigned long max_destlen =3D 132 << 20;
  void* ret =3D mmap(0, max_destlen, PROT_WRITE | PROT_READ,
                   MAP_PRIVATE | MAP_ANON, -1, 0);
  if (ret =3D=3D MAP_FAILED)
    return -1;
  unsigned char* dest =3D (unsigned char*)ret;
  unsigned long destlen =3D max_destlen;
  int err =3D puff(dest, &destlen, source, sourcelen);
  if (err) {
    munmap(dest, max_destlen);
    errno =3D -err;
    return -1;
  }
  if (write(dest_fd, dest, destlen) !=3D (ssize_t)destlen) {
    munmap(dest, max_destlen);
    return -1;
  }
  return munmap(dest, max_destlen);
}

static int setup_loop_device(unsigned char* data,
                             unsigned long size,
                             const char* loopname,
                             int* loopfd_p) {
  int err =3D 0, loopfd =3D -1;
  int memfd =3D syscall(__NR_memfd_create, "syzkaller", 0);
  if (memfd =3D=3D -1) {
    err =3D errno;
    goto error;
  }
  if (puff_zlib_to_file(data, size, memfd)) {
    err =3D errno;
    goto error_close_memfd;
  }
  loopfd =3D open(loopname, O_RDWR);
  if (loopfd =3D=3D -1) {
    err =3D errno;
    goto error_close_memfd;
  }
  if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
    if (errno !=3D EBUSY) {
      err =3D errno;
      goto error_close_loop;
    }
    ioctl(loopfd, LOOP_CLR_FD, 0);
    usleep(1000);
    if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
      err =3D errno;
      goto error_close_loop;
    }
  }
  close(memfd);
  *loopfd_p =3D loopfd;
  return 0;

error_close_loop:
  close(loopfd);
error_close_memfd:
  close(memfd);
error:
  errno =3D err;
  return -1;
}

static long syz_mount_image(volatile long fsarg,
                            volatile long dir,
                            volatile long flags,
                            volatile long optsarg,
                            volatile long change_dir,
                            volatile unsigned long size,
                            volatile long image) {
  unsigned char* data =3D (unsigned char*)image;
  int res =3D -1, err =3D 0, loopfd =3D -1, need_loop_device =3D !!size;
  char* mount_opts =3D (char*)optsarg;
  char* target =3D (char*)dir;
  char* fs =3D (char*)fsarg;
  char* source =3D NULL;
  char loopname[64];
  if (need_loop_device) {
    memset(loopname, 0, sizeof(loopname));
    snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid);
    if (setup_loop_device(data, size, loopname, &loopfd) =3D=3D -1)
      return -1;
    source =3D loopname;
  }
  mkdir(target, 0777);
  char opts[256];
  memset(opts, 0, sizeof(opts));
  if (strlen(mount_opts) > (sizeof(opts) - 32)) {
  }
  strncpy(opts, mount_opts, sizeof(opts) - 32);
  if (strcmp(fs, "iso9660") =3D=3D 0) {
    flags |=3D MS_RDONLY;
  } else if (strncmp(fs, "ext", 3) =3D=3D 0) {
    bool has_remount_ro =3D false;
    char* remount_ro_start =3D strstr(opts, "errors=3Dremount-ro");
    if (remount_ro_start !=3D NULL) {
      char after =3D *(remount_ro_start + strlen("errors=3Dremount-ro"));
      char before =3D remount_ro_start =3D=3D opts ? '\0' : *(remount_ro_st=
art - 1);
      has_remount_ro =3D ((before =3D=3D '\0' || before =3D=3D ',') &&
                        (after =3D=3D '\0' || after =3D=3D ','));
    }
    if (strstr(opts, "errors=3Dpanic") || !has_remount_ro)
      strcat(opts, ",errors=3Dcontinue");
  } else if (strcmp(fs, "xfs") =3D=3D 0) {
    strcat(opts, ",nouuid");
  }
  res =3D mount(source, target, fs, flags, opts);
  if (res =3D=3D -1) {
    err =3D errno;
    goto error_clear_loop;
  }
  res =3D open(target, O_RDONLY | O_DIRECTORY);
  if (res =3D=3D -1) {
    err =3D errno;
    goto error_clear_loop;
  }
  if (change_dir) {
    res =3D chdir(target);
    if (res =3D=3D -1) {
      err =3D errno;
    }
  }

error_clear_loop:
  if (need_loop_device) {
    ioctl(loopfd, LOOP_CLR_FD, 0);
    close(loopfd);
  }
  errno =3D err;
  return res;
}

#define FS_IOC_SETFLAGS _IOW('f', 2, long)
static void remove_dir(const char* dir) {
  int iter =3D 0;
  DIR* dp =3D 0;
retry:
  while (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW) =3D=3D 0) {
  }
  dp =3D opendir(dir);
  if (dp =3D=3D NULL) {
    if (errno =3D=3D EMFILE) {
      exit(1);
    }
    exit(1);
  }
  struct dirent* ep =3D 0;
  while ((ep =3D readdir(dp))) {
    if (strcmp(ep->d_name, ".") =3D=3D 0 || strcmp(ep->d_name, "..") =3D=3D=
 0)
      continue;
    char filename[FILENAME_MAX];
    snprintf(filename, sizeof(filename), "%s/%s", dir, ep->d_name);
    while (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW) =3D=3D 0) {
    }
    struct stat st;
    if (lstat(filename, &st))
      exit(1);
    if (S_ISDIR(st.st_mode)) {
      remove_dir(filename);
      continue;
    }
    int i;
    for (i =3D 0;; i++) {
      if (unlink(filename) =3D=3D 0)
        break;
      if (errno =3D=3D EPERM) {
        int fd =3D open(filename, O_RDONLY);
        if (fd !=3D -1) {
          long flags =3D 0;
          if (ioctl(fd, FS_IOC_SETFLAGS, &flags) =3D=3D 0) {
          }
          close(fd);
          continue;
        }
      }
      if (errno =3D=3D EROFS) {
        break;
      }
      if (errno !=3D EBUSY || i > 100)
        exit(1);
      if (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW))
        exit(1);
    }
  }
  closedir(dp);
  for (int i =3D 0;; i++) {
    if (rmdir(dir) =3D=3D 0)
      break;
    if (i < 100) {
      if (errno =3D=3D EPERM) {
        int fd =3D open(dir, O_RDONLY);
        if (fd !=3D -1) {
          long flags =3D 0;
          if (ioctl(fd, FS_IOC_SETFLAGS, &flags) =3D=3D 0) {
          }
          close(fd);
          continue;
        }
      }
      if (errno =3D=3D EROFS) {
        break;
      }
      if (errno =3D=3D EBUSY) {
        if (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW))
          exit(1);
        continue;
      }
      if (errno =3D=3D ENOTEMPTY) {
        if (iter < 100) {
          iter++;
          goto retry;
        }
      }
    }
    exit(1);
  }
}

static void kill_and_wait(int pid, int* status) {
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i =3D 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
      return;
    usleep(1000);
  }
  DIR* dir =3D opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent =3D readdir(dir);
      if (!ent)
        break;
      if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =
=3D=3D 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd =3D open(abort, O_WRONLY);
      if (fd =3D=3D -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) !=3D pid) {
  }
}

static void reset_loop() {
  char buf[64];
  snprintf(buf, sizeof(buf), "/dev/loop%llu", procid);
  int loopfd =3D open(buf, O_RDWR);
  if (loopfd !=3D -1) {
    ioctl(loopfd, LOOP_CLR_FD, 0);
    close(loopfd);
  }
}

static void setup_test() {
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
  if (symlink("/dev/binderfs", "./binderfs")) {
  }
}

struct thread_t {
  int created, call;
  event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg) {
  struct thread_t* th =3D (struct thread_t*)arg;
  for (;;) {
    event_wait(&th->ready);
    event_reset(&th->ready);
    execute_call(th->call);
    __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
    event_set(&th->done);
  }
  return 0;
}

static void execute_one(void) {
  int i, call, thread;
  for (call =3D 0; call < 7; call++) {
    for (thread =3D 0; thread < (int)(sizeof(threads) / sizeof(threads[0]))=
;
         thread++) {
      struct thread_t* th =3D &threads[thread];
      if (!th->created) {
        th->created =3D 1;
        event_init(&th->ready);
        event_init(&th->done);
        event_set(&th->done);
        thread_start(thr, th);
      }
      if (!event_isset(&th->done))
        continue;
      event_reset(&th->done);
      th->call =3D call;
      __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
      event_set(&th->ready);
      if (call =3D=3D 4 || call =3D=3D 5)
        break;
      event_timedwait(&th->done, 50 + (call =3D=3D 0 ? 4000 : 0));
      break;
    }
  }
  for (i =3D 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++=
)
    sleep_ms(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
  int iter =3D 0;
  for (;; iter++) {
    char cwdbuf[32];
    sprintf(cwdbuf, "./%d", iter);
    if (mkdir(cwdbuf, 0777))
      exit(1);
    reset_loop();
    int pid =3D fork();
    if (pid < 0)
      exit(1);
    if (pid =3D=3D 0) {
      if (chdir(cwdbuf))
        exit(1);
      setup_test();
      execute_one();
      exit(0);
    }
    int status =3D 0;
    uint64_t start =3D current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
        break;
      sleep_ms(1);
      if (current_time_ms() - start < 5000)
        continue;
      kill_and_wait(pid, &status);
      break;
    }
    remove_dir(cwdbuf);
  }
}

uint64_t r[2] =3D {0xffffffffffffffff, 0xffffffffffffffff};

void execute_call(int call) {
  intptr_t res =3D 0;
  switch (call) {
    case 0:
      memcpy((void*)0x20000780, "ext4\000", 5);
      memcpy((void*)0x20000240, "./file0\000", 8);
      memcpy(
          (void*)0x20000f40,
          "\x78\x9c\xec\xdd\xdd\x6b\x5b\xe5\x1f\x00\xf0\xef\x49\xdf\xd6\x6e=
\xbf"
          "\x5f\x2b\x08\x3a\xaf\x0a\x82\x16\xc6\x52\x3b\xeb\xa6\xe0\xc5\xc4=
\x0b"
          "\x11\x1c\x0c\xf4\xda\xad\xa4\x59\x99\x4d\x9b\xd1\xa4\x63\x2d\x05=
\x37"
          "\x44\xf0\x46\x50\xf1\x42\xd0\x9b\x5d\xfb\x32\xef\xbc\xf5\xe5\x56=
\xff"
          "\x0b\x2f\x64\x63\x6a\x37\x9c\x78\x21\x95\x93\x9e\x74\xd9\x9a\x64=
\xe9"
          "\xd6\x97\x8d\x7c\x3e\x70\x9a\xe7\xc9\x39\xe9\xf7\xf9\xe6\x39\x2f=
\xcf"
          "\xc9\x39\x24\x01\x74\xad\xd1\xf4\x4f\x2e\xe2\x60\x44\x7c\x94\x44=
\x0c"
          "\x67\xcf\x27\x11\xd1\x57\x2b\xf5\x46\x1c\x5f\x5f\xee\xd6\xea\x4a=
\x21"
          "\x9d\x92\x58\x5b\x7b\xf3\x8f\xa4\xb6\xcc\xcd\xd5\x95\x42\x34\xbc=
\x26"
          "\xb5\x3f\xab\x3c\x19\x11\x3f\xbe\x1f\x71\x28\xb7\x39\x6e\x65\x69=
\x79"
          "\x76\xaa\x54\x2a\x2e\x64\xf5\xf1\xea\xdc\xb9\xf1\xca\xd2\xf2\xe1=
\xb3"
          "\x73\x53\x33\xc5\x99\xe2\xfc\xd1\x89\xc9\xc9\x23\xc7\x5e\x38\x76=
\x74"
          "\xfb\x72\xfd\xeb\x97\xe5\x03\xd7\x3e\x7e\xed\xd9\x6f\x8e\xff\xf3=
\xde"
          "\x13\x57\x3e\xfc\x29\x89\xe3\x71\x20\x9b\xd7\x98\xc7\x76\x19\x8d=
\xd1"
          "\xec\x3d\xe9\x4b\xdf\xc2\x3b\xbc\xba\xdd\xc1\xf6\x58\xb2\xd7\x0d=
\xe0"
          "\xbe\xa4\x9b\x66\xcf\xfa\x56\x1e\x07\x63\x38\x7a\x6a\xa5\x16\x06=
\x77"
          "\xb3\x65\x00\xc0\x4e\x79\x37\x22\xd6\x00\x80\x2e\x93\x38\xfe\x03=
\x40"
          "\x97\xa9\x7f\x0e\x70\x73\x75\xa5\x50\x9f\xda\x7c\x5c\xd0\xe6\xe2=
\xc0"
          "\xa3\xe9\xfa\x2b\x11\xb1\x6f\x3d\xff\xfa\xf5\xcd\xf5\x39\xbd\xd9=
\x35"
          "\xbb\x7d\xb5\xeb\xa0\x43\x37\x93\x3b\x92\x4f\x22\x62\x64\x1b\xe2=
\x8f"
          "\x46\xc4\x17\xdf\xbd\xfd\x55\x3a\xc5\x0e\x5d\x87\x04\x68\xe6\xe2=
\xa5"
          "\x88\x38\x3d\x32\xba\x79\xff\x9f\x6c\xba\x67\x61\xab\x9e\xeb\x60=
\x99"
          "\xd1\xbb\xea\x0d\xfb\xbf\xfe\x07\x0c\x0f\xdc\xc3\xf7\xe9\xf8\xe7=
\xc5"
          "\x66\xe3\xbf\xdc\xc6\xf8\x27\x9a\x8c\x7f\x06\x9a\x6c\xbb\xf7\xa3=
\xcd"
          "\xf6\x9f\xc9\x5d\xdd\x86\x30\x2d\xa5\xe3\xbf\x97\x1b\xee\x6d\xbb=
\xd5"
          "\x90\x7f\x66\xa4\x27\xab\xfd\xaf\x36\xe6\xeb\x4b\xce\x9c\x2d\x15=
\xd3"
          "\x7d\xdb\xff\x23\x62\x2c\xfa\x06\xd2\xfa\x44\x9b\x18\x63\x37\xfe=
\xbd"
          "\xd1\x6a\x5e\xe3\xf8\xef\xcf\x4f\xde\xf9\x32\x8d\x9f\x3e\xde\x5e=
\x22"
          "\x77\xb5\x77\xe0\xce\xd7\x4c\x4f\x55\xa7\x1e\x24\xe7\x46\xd7\x2f=
\x45"
          "\x3c\xd5\xdb\x2c\xff\x64\xa3\xff\x93\x16\xe3\xdf\x93\x1d\xc6\x78=
\xfd"
          "\xa5\x0f\x3e\x6f\x35\x2f\xcd\x3f\xcd\xb7\x3e\x6d\xce\x7f\x67\xad=
\x5d"
          "\x8e\x78\xa6\x69\xff\xdf\xbe\xa3\x2d\x69\x7b\x7f\xe2\x78\x6d\x75=
\x18"
          "\xaf\xaf\x14\x4d\x7c\xfb\xeb\x67\x43\xad\xe2\x37\xf6\x7f\x3a\xa5=
\xf1"
          "\xeb\xe7\x02\xbb\x21\xed\xff\xa1\xf6\xf9\x8f\x24\x8d\xf7\x6b\x56=
\xb6"
          "\x1e\xe3\xe7\xcb\xc3\x3f\xb4\x9a\x77\xef\xfc\x9b\xaf\xff\xfd\xc9=
\x5b"
          "\xb5\x72\x7d\x90\x70\x61\xaa\x5a\x5d\x98\x88\xe8\x4f\xde\xd8\xfc=
\xfc"
          "\x91\xdb\xaf\xad\xd7\xeb\xcb\xa7\xf9\x8f\x3d\xdd\xdf\x74\xfb\x6f=
\xb7"
          "\xfe\xa7\xe7\x84\xa7\x3b\xcc\xbf\xf7\xda\xef\x5f\x6f\x54\xee\x3a=
\xf1"
          "\x7e\x18\xfa\x7f\x7a\x4b\xfd\xbf\xf5\xc2\x95\x5b\xb3\x3d\xad\xe2=
\x77"
          "\xd6\xff\x93\xb5\xd2\x58\xf6\x4c\x27\xfb\xbf\x4e\x1b\xf8\x20\xef=
\x1d"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x74\x2a\x17\x11\x07\x22\xc9\xe5\x37\xca\xb9\x5c\x3e\xbf=
\xfe"
          "\x1b\xde\x8f\xc7\x50\xae\x54\xae\x54\x0f\x9d\x29\x2f\xce\x4f\x47=
\xed"
          "\xb7\xb2\x47\xa2\x2f\x57\xff\xaa\xcb\xe1\x86\xef\x43\x9d\xc8\xbe=
\x0f"
          "\xbf\x5e\x3f\x72\x57\xfd\xf9\x88\x78\x2c\x22\x3e\x1d\x18\xac\xd5=
\xf3"
          "\x85\x72\x69\x7a\xaf\x93\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x80\xcc\xfe\x16\xbf\xff\x9f\xfa\x6d\x60\xaf\x5b\x07=
\x00"
          "\xec\x98\x7d\x7b\xdd\x00\x00\x60\xd7\x39\xfe\x03\x40\xf7\xd9\xda=
\xf1"
          "\x7f\x70\xc7\xda\x01\x00\xec\x1e\xe7\xff\x00\xd0\x7d\x1c\xff\x01=
\xa0"
          "\xfb\x38\xfe\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\xb0\xc3\x4e\x9e\x38\x91\x4e\x6b\x7f\xaf\xae\x14\xd2=
\xfa"
          "\xf4\xf9\xa5\xc5\xd9\xf2\xf9\xc3\xd3\xc5\xca\x6c\x7e\x6e\xb1\x90=
\x2f"
          "\x94\x17\xce\xe5\x67\xca\xe5\x99\x52\x31\x5f\x28\xcf\xb5\xfc\x47=
\x17"
          "\xd7\x1f\x4a\xe5\xf2\xb9\xc9\x98\x5f\xbc\x30\x5e\x2d\x56\xaa\xe3=
\x95"
          "\xa5\xe5\x53\x73\xe5\xc5\xf9\xea\xa9\xb3\x73\x53\x33\xc5\x53\xc5=
\xbe"
          "\x5d\xcb\x0c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x3a\x57\x59\x5a\x9e\x9d\x2a\x95\x8a\x0b\x0a\xdd\x57\xe8\xc9\x56=
\x82"
          "\x87\xa5\x3d\x0a\x0f\x51\xa1\x71\x2f\x31\xb8\x37\x3b\x27\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00"
          "\x00\x00\x80\x47\xc0\x7f\x01\x00\x00\xff\xff\x51\xe3\x2f\x55",
          1919);
      syz_mount_image(/*fs=3D*/0x20000780, /*dir=3D*/0x20000240, /*flags=3D=
*/0,
                      /*opts=3D*/0x20000000, /*chdir=3D*/1, /*size=3D*/0x77=
f,
                      /*img=3D*/0x20000f40);
      break;
    case 1:
      memcpy((void*)0x20000000, "./bus\000", 6);
      res =3D syscall(__NR_open, /*file=3D*/0x20000000ul, /*flags=3D*/0x601=
42ul,
                    /*mode=3D*/0ul);
      if (res !=3D -1)
        r[0] =3D res;
      break;
    case 2:
      memcpy((void*)0x20007f80, "./bus\000", 6);
      res =3D syscall(__NR_open, /*file=3D*/0x20007f80ul, /*flags=3D*/0x145=
142ul,
                    /*mode=3D*/0ul);
      if (res !=3D -1)
        r[1] =3D res;
      break;
    case 3:
      syscall(__NR_ftruncate, /*fd=3D*/r[1], /*len=3D*/0x2007ffbul);
      break;
    case 4:
      *(uint64_t*)0x20000040 =3D 0;
      syscall(__NR_sendfile, /*fdout=3D*/r[0], /*fdin=3D*/r[1],
              /*off=3D*/0x20000040ul,
              /*count=3D*/4ul);
      break;
    case 5:
      syscall(__NR_sendfile, /*fdout=3D*/r[0], /*fdin=3D*/r[1], /*off=3D*/0=
ul,
              /*count=3D*/0x1000000201005ul);
      break;
    case 6:
      syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0xb36000ul,
              /*prot=3D*/2ul,
              /*flags=3D*/0x28011ul, /*fd=3D*/r[1], /*offset=3D*/0ul);
      break;
  }
}
int main(void) {
  syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul, /*prot=
=3D*/7ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  use_temporary_dir();
  loop();
  return 0;
}

=3D* repro.txt =3D*
syz_mount_image$ext4(&(0x7f0000000780)=3D'ext4\x00',
&(0x7f0000000240)=3D'./file0\x00', 0x0, &(0x7f0000000000)=3DANY=3D[], 0x1,
0x77f, &(0x7f0000000f40)=3D"$eJzs3d1rW+UfAPDvSd/Wbr9fKwg6rwqCFsZSO+um4MXECx=
EcDPTaraRZmU2b0aRjLQU3RPBGUPFC0Jtd+zLvvPXlVv8LL2RjajeceCGVk5502Zpk6daXjXw+c=
JrnyTnp9/nmOS/PyTkkAXSt0fRPLuJgRHyURAxnzycR0Vcr9UYcX1/u1upKIZ2SWFt784+ktszN=
1ZVCNLwmtT+rPBkRP74fcSi3OW5laXl2qlQqLmT18ercufHK0vLhs3NTM8WZ4vzRicnJI8deOHZ=
0+3L965flA9c+fu3Zb47/894TVz78KYnjcSCb15jHdhmN0ew96Uvfwju8ut3B9liy1w3gvqSbZs=
/6Vh4HYzh6aqUWBnezZQDATnk3ItYAgC6TOP4DQJepfw5wc3WlUJ/afFzQ5uLAo+n6KxGxbz3/+=
vXN9Tm92TW7fbXroEM3kzuSTyJiZBvij0bEF9+9/VU6xQ5dhwRo5uKliDg9Mrp5/59sumdhq57r=
YJnRu+oN+7/+BwwP3MP36fjnxWbjv9zG+CeajH8Gmmy796PN9p/JXd2GMC2l47+XG+5tu9WQf2a=
kJ6v9rzbm60vOnC0V033b/yNiLPoG0vpEmxhjN/690Wpe4/jvz0/e+TKNnz7eXiJ3tXfgztdMT1=
WnHiTnRtcvRTzV2yz/ZKP/kxbj35Mdxnj9pQ8+bzUvzT/Ntz5tzn9nrV2OeKZp/9++oy1pe3/ie=
G11GK+vFE18++tnQ63iN/Z/OqXx6+cCuyHt/6H2+Y8kjfdrVrYe4+fLwz+0mnfv/Juv//3JW7Vy=
fZBwYapaXZiI6E/e2Pz8kduvrdfry6f5jz3d33T7b7f+p+eEpzvMv/fa719vVO468X4Y+n96S/2=
/9cKVW7M9reJ31v+TtdJY9kwn+79OG/gg7x0AAAAAAAAAAAAAAAAAAAAAAAAAdCoXEQciyeU3yr=
lcPr/+G96Px1CuVK5UD50pL85PR+23skeiL1f/qsvhhu9Dnci+D79eP3JX/fmIeCwiPh0YrNXzh=
XJpeq+TBwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIDM/ha//5/6bWCvWwcA7Jh9e90A=
AGDXOf4DQPfZ2vF/cMfaAQDsHuf/ANB9HP8BoPs4/gMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALDDTp44kU5rf6+uFNL69Pmlxdny+cPTxcpsfm6xkC=
+UF87lZ8rlmVIxXyjPtfxHF9cfSuXyucmYX7wwXi1WquOVpeVTc+XF+eqps3NTM8VTxb5dywwAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOldZWp6dKpWKCwrdV+jJVoKHpT0KD1GhcS8x=
uDc7JwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAIBHwH8BAAD//1HjL1U=3D")
r0 =3D open(&(0x7f0000000000)=3D'./bus\x00', 0x60142, 0x0)
r1 =3D open(&(0x7f0000007f80)=3D'./bus\x00', 0x145142, 0x0)
ftruncate(r1, 0x2007ffb)
sendfile(r0, r1, &(0x7f0000000040), 0x4) (async)
sendfile(r0, r1, 0x0, 0x1000000201005) (async)
mmap(&(0x7f0000000000/0xb36000)=3Dnil, 0xb36000, 0x2, 0x28011, r1, 0x0)

and see also in
https://gist.github.com/xrivendell7/3e47849a9a19debf45b5829f04977c71

BTW, in the reproducing process, I also reproduced bug titled
kernel BUG in __ext4_journal_stop
https://syzkaller.appspot.com/bug?extid=3Dbdab24d5bf96d57c50b0
and kernel BUG in ext4_do_writepages
https://syzkaller.appspot.com/bug?extid=3Dd1da16f03614058fdc48, they
maybe the same bugs I guess.

I hope it helps.
Best regrads.
xingwei Lee

