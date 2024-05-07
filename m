Return-Path: <linux-fsdevel+bounces-18869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0945B8BD992
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 04:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F761F22904
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 02:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA43C6BA;
	Tue,  7 May 2024 02:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHosAp/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64646A4;
	Tue,  7 May 2024 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715050348; cv=none; b=oWMBN5rmzZXp770dR+6SBP77aFCrLN2Z5aMKnnd5HZQQ4+XW4cWlPBvQGRq/41EifUtkXqB5mkGxzkMxDqkBWOaX1FBxGkbFNjzPtKkB3prIUrXJrU38M11WiRgBOSb9u8I7adaD54yMeZdZeWH/tzI6+bs0ARD2UiNaJtTVbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715050348; c=relaxed/simple;
	bh=osWRR8ILRApfoOYrJqMMj8C2HO0SUHXpA0wCKRzOqOk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l5bsp9SIKspCpRRLh8uzr1Yg5UceOl9wi2KFQmiAf2+nhrmr8L1Cil3yQ6Y8FrMEozn1cmVjtl7o5GPa/UI66F1ugX672+6juzudNw7k0xonUx0B8Nt7+bdzoJGid2Md6g4bvhoVS+w4kcn8R1yJiLKJfDAun5RvrBdLD700RGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHosAp/+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so1792041b3a.3;
        Mon, 06 May 2024 19:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715050345; x=1715655145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7aOEz7Lw84ijSlxODwX3Ak39yw0PaQVngA0Tu1/tT94=;
        b=XHosAp/+m98a+8Cx8wSEfKVx3iBpsnkHcxnn3cArx2Qjkmu2yWzsC2b6qkiLFx/yuw
         MThKUc/Hb4pp5PbUXez18lTeYykXN12+4yWF7o6FMe3kP6fzSa8nWLVqlXge4iN4NfpI
         NbkfYS02kHTcSZkNc9izaCKtVrGwdC99nZSEyFOwTtTUz992a0J4nDNh0ALMpLuINpBs
         E29MXS59eiAJqjEStKNnIAzNNjOT8z5Yhk7arpOnW2Z/R5UW4t4qIR8lDUVyMaz0azZg
         VrRhjM4tVEY610uRhLRffAU+CAbosEN4JoZ/W93CLfaCcD0XaI7sXtCFz8sfb0JlOnDn
         +feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715050345; x=1715655145;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aOEz7Lw84ijSlxODwX3Ak39yw0PaQVngA0Tu1/tT94=;
        b=C6Enf0c27Jb3xBokj25NbGi9yUSmLm65AOG/7xfNK0KO+MptRdqR7Rfs8kxCrJq6+Z
         X8zwaboqtLMQpD2qQstdBz4AHgP/Cg5J7lfDgip2CaQdUzwxBO/p27JKd0ST7/V0IVla
         5AONV/2GTqK4z1pSU95qpTdnzWOaUOUDV76tjCUa7a+U09nPSceNMbh8BKt8mI3Z01LZ
         o9KY76WMRRmwTVgU5/ieeC1oah6qEset5wFjo1mTFInk3vQctrVPd2HhrcfxgsRed4Kx
         nraMzczOdmP6OnZU+3vi86zvWVtbKKWeR/SeP+gq2zW7mSDjkvJefENzmOoWe5Qzbq/H
         gpMg==
X-Forwarded-Encrypted: i=1; AJvYcCVRiBreI9aUb8PGYXhPxfVZVRMQjCNOZZdI4KJbHRrHtmeQ7K7oFcvSJIOwqs96pPID5BMKuhsH2NXq/GhAzFKXBMbvE/80A30HFfVn
X-Gm-Message-State: AOJu0YyNJSEvsyplyg+2IH4udgZRocNHMs0IBU24U8ruJ4RNQAoovLgh
	SQ5zUiY8K7LVI4eB0WeFdwi1btoo3f92UlQ0TDEoquz3AcaeHcS4iRiJcjkIRhuK2EtPjSHardF
	qcTWuGF//Cdcsnhcge8DJ35JOQTufoTzR
X-Google-Smtp-Source: AGHT+IExyHvTxnkx1K1JGh+ufyWFGse2LZ+Qi6gygIhvv4CU5fzI2BCvccL8aDyImv2GVVW3bVY2RViwHkTg15Lr00A=
X-Received: by 2002:a05:6a21:1a9:b0:1a3:bd8a:141f with SMTP id
 le41-20020a056a2101a900b001a3bd8a141fmr14030771pzb.54.1715050345082; Mon, 06
 May 2024 19:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: lee bruce <xrivendell7@gmail.com>
Date: Tue, 7 May 2024 10:52:13 +0800
Message-ID: <CABOYnLwAe+hVUNe+bsYeKJJQ-G9svs7dR2ymZDh0PsfqFNMm2A@mail.gmail.com>
Subject: WARNING in fuse_request_end
To: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc: yue sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello, I found a new bug titled "WARNING in fuse_request_end" and
comfirmed in the lastest upstream.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
kernel: upstream dccb07f2914cdab2ac3a5b6c98406f765acab803(lastest)
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=7144b4fe7fbf5900
with KASAN enabled
compiler: gcc (GCC) 13.2.1 20231011

TITLE: WARNING in fuse_request_end
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8264 at fs/fuse/dev.c:300
fuse_request_end+0x685/0x7e0 fs/fuse/dev.c:300
Modules linked in:
CPU: 0 PID: 8264 Comm: ab2 Not tainted 6.9.0-rc7-00012-gdccb07f2914c #27
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
RIP: 0010:fuse_request_end+0x685/0x7e0 fs/fuse/dev.c:300
Code: ff 3c 03 0f 8f d6 fd ff ff 4c 89 ff e8 24 31 f9 fe e9 c9 fd ff
ff e8 1a 8b 9c fe 90 0f 0b 90 e9 a9 fa ff ff e8 0c 8b 9c fe 90 <0f> 0b
90 e9 e6 fa ff ff 48 89 34 24 e8 fa 30 f9 fe 48 8b 34 24 e9
RSP: 0018:ffffc9000eb17a60 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880342cc008 RCX: ffffffff82f20b6a
RDX: ffff88802fa79ec0 RSI: ffffffff82f21084 RDI: 0000000000000007
RBP: ffff8880342cc038 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000000 R12: ffff888029989000
R13: ffff88802cc39740 R14: 0000000000000100 R15: ffff8880342cc038
FS: 00007febdf6d96c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002200 CR3: 000000001fe6c000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
<TASK>
fuse_dev_do_read.constprop.0+0xd36/0x1dd0 fs/fuse/dev.c:1334
fuse_dev_read+0x166/0x200 fs/fuse/dev.c:1367
call_read_iter include/linux/fs.h:2104 [inline]
new_sync_read fs/read_write.c:395 [inline]
vfs_read+0x85b/0xba0 fs/read_write.c:476
ksys_read+0x12f/0x260 fs/read_write.c:619
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xce/0x260 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x439ae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007febdf6d91f8 EFLAGS: 00000213 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007febdf6d96c0 RCX: 0000000000439ae9
RDX: 0000000000002020 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 00007febdf6d9220 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000213 R12: ffffffffffffffb0
R13: 000000000000006e R14: 00007ffde3c37740 R15: 00007ffde3c37828
</TASK>

=* repro.c =*
#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <setjmp.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>
#include <linux/loop.h>

#ifndef __NR_memfd_create
#define __NR_memfd_create 319
#endif

static unsigned long long procid;

static void sleep_ms(uint64_t ms)
{
 usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts))
   exit(1);
 return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg)
{
 pthread_t th;
 pthread_attr_t attr;
 pthread_attr_init(&attr);
 pthread_attr_setstacksize(&attr, 128 << 10);
 int i = 0;
 for (; i < 100; i++) {
   if (pthread_create(&th, &attr, fn, arg) == 0) {
     pthread_attr_destroy(&attr);
     return;
   }
   if (errno == EAGAIN) {
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

static void event_init(event_t* ev)
{
 ev->state = 0;
}

static void event_reset(event_t* ev)
{
 ev->state = 0;
}

static void event_set(event_t* ev)
{
 if (ev->state)
   exit(1);
 __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
 syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev)
{
 while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
   syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev)
{
 return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout)
{
 uint64_t start = current_time_ms();
 uint64_t now = start;
 for (;;) {
   uint64_t remain = timeout - (now - start);
   struct timespec ts;
   ts.tv_sec = remain / 1000;
   ts.tv_nsec = (remain % 1000) * 1000 * 1000;
   syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
   if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
     return 1;
   now = current_time_ms();
   if (now - start > timeout)
     return 0;
 }
}

//% This code is derived from puff.{c,h}, found in the zlib development. The
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
//%    in a product, an acknowledgment in the product documentation would be
//%    appreciated but is not required.
//% 2. Altered source versions must be plainly marked as such, and must not be
//%    misrepresented as being the original software.
//% 3. This notice may not be removed or altered from any source distribution.
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
static int puff_bits(struct puff_state* s, int need)
{
 long val = s->bitbuf;
 while (s->bitcnt < need) {
   if (s->incnt == s->inlen)
     longjmp(s->env, 1);
   val |= (long)(s->in[s->incnt++]) << s->bitcnt;
   s->bitcnt += 8;
 }
 s->bitbuf = (int)(val >> need);
 s->bitcnt -= need;
 return (int)(val & ((1L << need) - 1));
}
static int puff_stored(struct puff_state* s)
{
 s->bitbuf = 0;
 s->bitcnt = 0;
 if (s->incnt + 4 > s->inlen)
   return 2;
 unsigned len = s->in[s->incnt++];
 len |= s->in[s->incnt++] << 8;
 if (s->in[s->incnt++] != (~len & 0xff) ||
     s->in[s->incnt++] != ((~len >> 8) & 0xff))
   return -2;
 if (s->incnt + len > s->inlen)
   return 2;
 if (s->outcnt + len > s->outlen)
   return 1;
 for (; len--; s->outcnt++, s->incnt++) {
   if (s->in[s->incnt])
     s->out[s->outcnt] = s->in[s->incnt];
 }
 return 0;
}
struct puff_huffman {
 short* count;
 short* symbol;
};
static int puff_decode(struct puff_state* s, const struct puff_huffman* h)
{
 int first = 0;
 int index = 0;
 int bitbuf = s->bitbuf;
 int left = s->bitcnt;
 int code = first = index = 0;
 int len = 1;
 short* next = h->count + 1;
 while (1) {
   while (left--) {
     code |= bitbuf & 1;
     bitbuf >>= 1;
     int count = *next++;
     if (code - count < first) {
       s->bitbuf = bitbuf;
       s->bitcnt = (s->bitcnt - len) & 7;
       return h->symbol[index + (code - first)];
     }
     index += count;
     first += count;
     first <<= 1;
     code <<= 1;
     len++;
   }
   left = (MAXBITS + 1) - len;
   if (left == 0)
     break;
   if (s->incnt == s->inlen)
     longjmp(s->env, 1);
   bitbuf = s->in[s->incnt++];
   if (left > 8)
     left = 8;
 }
 return -10;
}
static int puff_construct(struct puff_huffman* h, const short* length, int n)
{
 int len;
 for (len = 0; len <= MAXBITS; len++)
   h->count[len] = 0;
 int symbol;
 for (symbol = 0; symbol < n; symbol++)
   (h->count[length[symbol]])++;
 if (h->count[0] == n)
   return 0;
 int left = 1;
 for (len = 1; len <= MAXBITS; len++) {
   left <<= 1;
   left -= h->count[len];
   if (left < 0)
     return left;
 }
 short offs[MAXBITS + 1];
 offs[1] = 0;
 for (len = 1; len < MAXBITS; len++)
   offs[len + 1] = offs[len] + h->count[len];
 for (symbol = 0; symbol < n; symbol++)
   if (length[symbol] != 0)
     h->symbol[offs[length[symbol]]++] = symbol;
 return left;
}
static int puff_codes(struct puff_state* s, const struct puff_huffman* lencode,
                     const struct puff_huffman* distcode)
{
 static const short lens[29] = {3,  4,  5,  6,   7,   8,   9,   10,  11, 13,
                                15, 17, 19, 23,  27,  31,  35,  43,  51, 59,
                                67, 83, 99, 115, 131, 163, 195, 227, 258};
 static const short lext[29] = {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2,
                                2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0};
 static const short dists[30] = {
     1,    2,    3,    4,    5,    7,    9,    13,    17,    25,
     33,   49,   65,   97,   129,  193,  257,  385,   513,   769,
     1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577};
 static const short dext[30] = {0, 0, 0,  0,  1,  1,  2,  2,  3,  3,
                                4, 4, 5,  5,  6,  6,  7,  7,  8,  8,
                                9, 9, 10, 10, 11, 11, 12, 12, 13, 13};
 int symbol;
 do {
   symbol = puff_decode(s, lencode);
   if (symbol < 0)
     return symbol;
   if (symbol < 256) {
     if (s->outcnt == s->outlen)
       return 1;
     if (symbol)
       s->out[s->outcnt] = symbol;
     s->outcnt++;
   } else if (symbol > 256) {
     symbol -= 257;
     if (symbol >= 29)
       return -10;
     int len = lens[symbol] + puff_bits(s, lext[symbol]);
     symbol = puff_decode(s, distcode);
     if (symbol < 0)
       return symbol;
     unsigned dist = dists[symbol] + puff_bits(s, dext[symbol]);
     if (dist > s->outcnt)
       return -11;
     if (s->outcnt + len > s->outlen)
       return 1;
     while (len--) {
       if (dist <= s->outcnt && s->out[s->outcnt - dist])
         s->out[s->outcnt] = s->out[s->outcnt - dist];
       s->outcnt++;
     }
   }
 } while (symbol != 256);
 return 0;
}
static int puff_fixed(struct puff_state* s)
{
 static int virgin = 1;
 static short lencnt[MAXBITS + 1], lensym[FIXLCODES];
 static short distcnt[MAXBITS + 1], distsym[MAXDCODES];
 static struct puff_huffman lencode, distcode;
 if (virgin) {
   lencode.count = lencnt;
   lencode.symbol = lensym;
   distcode.count = distcnt;
   distcode.symbol = distsym;
   short lengths[FIXLCODES];
   int symbol;
   for (symbol = 0; symbol < 144; symbol++)
     lengths[symbol] = 8;
   for (; symbol < 256; symbol++)
     lengths[symbol] = 9;
   for (; symbol < 280; symbol++)
     lengths[symbol] = 7;
   for (; symbol < FIXLCODES; symbol++)
     lengths[symbol] = 8;
   puff_construct(&lencode, lengths, FIXLCODES);
   for (symbol = 0; symbol < MAXDCODES; symbol++)
     lengths[symbol] = 5;
   puff_construct(&distcode, lengths, MAXDCODES);
   virgin = 0;
 }
 return puff_codes(s, &lencode, &distcode);
}
static int puff_dynamic(struct puff_state* s)
{
 static const short order[19] = {16, 17, 18, 0, 8,  7, 9,  6, 10, 5,
                                 11, 4,  12, 3, 13, 2, 14, 1, 15};
 int nlen = puff_bits(s, 5) + 257;
 int ndist = puff_bits(s, 5) + 1;
 int ncode = puff_bits(s, 4) + 4;
 if (nlen > MAXLCODES || ndist > MAXDCODES)
   return -3;
 short lengths[MAXCODES];
 int index;
 for (index = 0; index < ncode; index++)
   lengths[order[index]] = puff_bits(s, 3);
 for (; index < 19; index++)
   lengths[order[index]] = 0;
 short lencnt[MAXBITS + 1], lensym[MAXLCODES];
 struct puff_huffman lencode = {lencnt, lensym};
 int err = puff_construct(&lencode, lengths, 19);
 if (err != 0)
   return -4;
 index = 0;
 while (index < nlen + ndist) {
   int symbol;
   int len;
   symbol = puff_decode(s, &lencode);
   if (symbol < 0)
     return symbol;
   if (symbol < 16)
     lengths[index++] = symbol;
   else {
     len = 0;
     if (symbol == 16) {
       if (index == 0)
         return -5;
       len = lengths[index - 1];
       symbol = 3 + puff_bits(s, 2);
     } else if (symbol == 17)
       symbol = 3 + puff_bits(s, 3);
     else
       symbol = 11 + puff_bits(s, 7);
     if (index + symbol > nlen + ndist)
       return -6;
     while (symbol--)
       lengths[index++] = len;
   }
 }
 if (lengths[256] == 0)
   return -9;
 err = puff_construct(&lencode, lengths, nlen);
 if (err && (err < 0 || nlen != lencode.count[0] + lencode.count[1]))
   return -7;
 short distcnt[MAXBITS + 1], distsym[MAXDCODES];
 struct puff_huffman distcode = {distcnt, distsym};
 err = puff_construct(&distcode, lengths + nlen, ndist);
 if (err && (err < 0 || ndist != distcode.count[0] + distcode.count[1]))
   return -8;
 return puff_codes(s, &lencode, &distcode);
}
static int puff(unsigned char* dest, unsigned long* destlen,
               const unsigned char* source, unsigned long sourcelen)
{
 struct puff_state s = {
     .out = dest,
     .outlen = *destlen,
     .outcnt = 0,
     .in = source,
     .inlen = sourcelen,
     .incnt = 0,
     .bitbuf = 0,
     .bitcnt = 0,
 };
 int err;
 if (setjmp(s.env) != 0)
   err = 2;
 else {
   int last;
   do {
     last = puff_bits(&s, 1);
     int type = puff_bits(&s, 2);
     err = type == 0 ? puff_stored(&s)
                     : (type == 1 ? puff_fixed(&s)
                                  : (type == 2 ? puff_dynamic(&s) : -1));
     if (err != 0)
       break;
   } while (!last);
 }
 *destlen = s.outcnt;
 return err;
}

//% END CODE DERIVED FROM puff.{c,h}

#define ZLIB_HEADER_WIDTH 2

static int puff_zlib_to_file(const unsigned char* source,
                            unsigned long sourcelen, int dest_fd)
{
 if (sourcelen < ZLIB_HEADER_WIDTH)
   return 0;
 source += ZLIB_HEADER_WIDTH;
 sourcelen -= ZLIB_HEADER_WIDTH;
 const unsigned long max_destlen = 132 << 20;
 void* ret = mmap(0, max_destlen, PROT_WRITE | PROT_READ,
                  MAP_PRIVATE | MAP_ANON, -1, 0);
 if (ret == MAP_FAILED)
   return -1;
 unsigned char* dest = (unsigned char*)ret;
 unsigned long destlen = max_destlen;
 int err = puff(dest, &destlen, source, sourcelen);
 if (err) {
   munmap(dest, max_destlen);
   errno = -err;
   return -1;
 }
 if (write(dest_fd, dest, destlen) != (ssize_t)destlen) {
   munmap(dest, max_destlen);
   return -1;
 }
 return munmap(dest, max_destlen);
}

static int setup_loop_device(unsigned char* data, unsigned long size,
                            const char* loopname, int* loopfd_p)
{
 int err = 0, loopfd = -1;
 int memfd = syscall(__NR_memfd_create, "syzkaller", 0);
 if (memfd == -1) {
   err = errno;
   goto error;
 }
 if (puff_zlib_to_file(data, size, memfd)) {
   err = errno;
   goto error_close_memfd;
 }
 loopfd = open(loopname, O_RDWR);
 if (loopfd == -1) {
   err = errno;
   goto error_close_memfd;
 }
 if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
   if (errno != EBUSY) {
     err = errno;
     goto error_close_loop;
   }
   ioctl(loopfd, LOOP_CLR_FD, 0);
   usleep(1000);
   if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
     err = errno;
     goto error_close_loop;
   }
 }
 close(memfd);
 *loopfd_p = loopfd;
 return 0;

error_close_loop:
 close(loopfd);
error_close_memfd:
 close(memfd);
error:
 errno = err;
 return -1;
}

static long syz_mount_image(volatile long fsarg, volatile long dir,
                           volatile long flags, volatile long optsarg,
                           volatile long change_dir,
                           volatile unsigned long size, volatile long image)
{
 unsigned char* data = (unsigned char*)image;
 int res = -1, err = 0, loopfd = -1, need_loop_device = !!size;
 char* mount_opts = (char*)optsarg;
 char* target = (char*)dir;
 char* fs = (char*)fsarg;
 char* source = NULL;
 char loopname[64];
 if (need_loop_device) {
   memset(loopname, 0, sizeof(loopname));
   snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid);
   if (setup_loop_device(data, size, loopname, &loopfd) == -1)
     return -1;
   source = loopname;
 }
 mkdir(target, 0777);
 char opts[256];
 memset(opts, 0, sizeof(opts));
 if (strlen(mount_opts) > (sizeof(opts) - 32)) {
 }
 strncpy(opts, mount_opts, sizeof(opts) - 32);
 if (strcmp(fs, "iso9660") == 0) {
   flags |= MS_RDONLY;
 } else if (strncmp(fs, "ext", 3) == 0) {
   bool has_remount_ro = false;
   char* remount_ro_start = strstr(opts, "errors=remount-ro");
   if (remount_ro_start != NULL) {
     char after = *(remount_ro_start + strlen("errors=remount-ro"));
     char before = remount_ro_start == opts ? '\0' : *(remount_ro_start - 1);
     has_remount_ro = ((before == '\0' || before == ',') &&
                       (after == '\0' || after == ','));
   }
   if (strstr(opts, "errors=panic") || !has_remount_ro)
     strcat(opts, ",errors=continue");
 } else if (strcmp(fs, "xfs") == 0) {
   strcat(opts, ",nouuid");
 }
 res = mount(source, target, fs, flags, opts);
 if (res == -1) {
   err = errno;
   goto error_clear_loop;
 }
 res = open(target, O_RDONLY | O_DIRECTORY);
 if (res == -1) {
   err = errno;
   goto error_clear_loop;
 }
 if (change_dir) {
   res = chdir(target);
   if (res == -1) {
     err = errno;
   }
 }

error_clear_loop:
 if (need_loop_device) {
   ioctl(loopfd, LOOP_CLR_FD, 0);
   close(loopfd);
 }
 errno = err;
 return res;
}

struct thread_t {
 int created, call;
 event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
 struct thread_t* th = (struct thread_t*)arg;
 for (;;) {
   event_wait(&th->ready);
   event_reset(&th->ready);
   execute_call(th->call);
   __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
   event_set(&th->done);
 }
 return 0;
}

static void loop(void)
{
 int i, call, thread;
 for (call = 0; call < 7; call++) {
   for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
        thread++) {
     struct thread_t* th = &threads[thread];
     if (!th->created) {
       th->created = 1;
       event_init(&th->ready);
       event_init(&th->done);
       event_set(&th->done);
       thread_start(thr, th);
     }
     if (!event_isset(&th->done))
       continue;
     event_reset(&th->done);
     th->call = call;
     __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
     event_set(&th->ready);
     event_timedwait(&th->done, 50);
     break;
   }
 }
 for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
   sleep_ms(1);
}

uint64_t r[2] = {0xffffffffffffffff, 0xffffffffffffffff};

void execute_call(int call)
{
 intptr_t res = 0;
 switch (call) {
 case 0:
   memcpy((void*)0x20001cc0, "memory.events\000", 14);
   res = syscall(__NR_openat, /*fd=*/0xffffff9c, /*file=*/0x20001cc0ul,
                 /*flags=*/0x275aul, /*mode=*/0ul);
   if (res != -1)
     r[0] = res;
   break;
 case 1:
   memcpy((void*)0x20000100, "/dev/fuse\000", 10);
   res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul,
                 /*file=*/0x20000100ul, /*flags=*/2ul, /*mode=*/0ul);
   if (res != -1)
     r[1] = res;
   break;
 case 2:
   memcpy((void*)0x20000080, "fuse\000", 5);
   memcpy((void*)0x200000c0, "./file1\000", 8);
   memcpy((void*)0x20006380, "fd", 2);
   *(uint8_t*)0x20006382 = 0x3d;
   sprintf((char*)0x20006383, "0x%016llx", (long long)r[1]);
   *(uint8_t*)0x20006395 = 0x2c;
   memcpy((void*)0x20006396, "rootmode", 8);
   *(uint8_t*)0x2000639e = 0x3d;
   sprintf((char*)0x2000639f, "%023llo", (long long)0x4000);
   *(uint8_t*)0x200063b6 = 0x2c;
   memcpy((void*)0x200063b7, "user_id", 7);
   *(uint8_t*)0x200063be = 0x3d;
   sprintf((char*)0x200063bf, "%020llu", (long long)0);
   *(uint8_t*)0x200063d3 = 0x2c;
   memcpy((void*)0x200063d4, "group_id", 8);
   *(uint8_t*)0x200063dc = 0x3d;
   sprintf((char*)0x200063dd, "%020llu", (long long)0);
   *(uint8_t*)0x200063f1 = 0x2c;
   *(uint8_t*)0x200063f2 = 0;
   syz_mount_image(/*fs=*/0x20000080, /*dir=*/0x200000c0, /*flags=*/0,
                   /*opts=*/0x20006380, /*chdir=*/0, /*size=*/0, /*img=*/0);
   break;
 case 3:
   syscall(__NR_read, /*fd=*/r[1], /*buf=*/0x20000140ul, /*len=*/0x2020ul);
   break;
 case 4:
   *(uint32_t*)0x20002200 = 0x28;
   *(uint32_t*)0x20002204 = 7;
   *(uint64_t*)0x20002208 = 0;
   *(uint64_t*)0x20002210 = 0;
   *(uint64_t*)0x20002218 = 0;
   *(uint64_t*)0x20002220 = 0;
   syscall(__NR_write, /*fd=*/r[1], /*arg=*/0x20002200ul, /*len=*/0x28ul);
   break;
 case 5:
   syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x3000ul, /*prot=*/0ul,
           /*flags=*/0x12ul, /*fd=*/r[0], /*offset=*/0ul);
   break;
 case 6:
   syscall(__NR_read, /*fd=*/r[1], /*buf=*/0x20000140ul, /*len=*/0x2020ul);
   break;
 }
}
int main(void)
{
 syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 loop();
 return 0;
}


=* repro.txt =*
r0 = openat$cgroup_ro(0xffffffffffffff9c,
&(0x7f0000001cc0)='memory.events\x00', 0x275a, 0x0)
r1 = openat$fuse(0xffffffffffffff9c, &(0x7f0000000100), 0x2, 0x0)
syz_mount_image$fuse(&(0x7f0000000080),
&(0x7f00000000c0)='./file1\x00', 0x0, &(0x7f0000006380)={{'fd', 0x3d,
r1}, 0x2c, {'rootmode', 0x3d, 0x4000}}, 0x0, 0x0, 0x0)
read$FUSE(r1, &(0x7f0000000140)={0x2020}, 0x2020)
write$FUSE_NOTIFY_INVAL_INODE(r1, &(0x7f0000002200)={0x28, 0x7}, 0x28)
mmap(&(0x7f0000000000/0x3000)=nil, 0x3000, 0x0, 0x12, r0, 0x0)
read$FUSE(r1, &(0x7f0000000140)={0x2020}, 0x2020)


Please also see:
https://gist.github.com/xrivendell7/346cb2c74cf5da4cad54cbdc8d1f0ded

I hope it helps.
Best regards.
xingwei Lee

