Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06D845CAEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 18:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbhKXR2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 12:28:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:40281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240975AbhKXR2H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637774668;
        bh=v5vytf8zHiT2jvsxFFxYHbRqNbhlp30OQgY9NmAlIws=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=NxlcQyDg3MONQIljHewblkSx1x361bjrdMrjoR8MIAzyJtFmm6JCq7Rx9/JF3H0dS
         gnD4s6GPdldxn10YVUOGTArDA2V07sTLF8VD0W38JFlL9dYquynQg7HQaaYljYWnZr
         XGhJDgpoNsUNdIAVAJokqdO8WRoX/C6f2Mf4Wdo0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.103]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JqV-1mqCzN26fB-000OLR; Wed, 24
 Nov 2021 18:24:28 +0100
Message-ID: <2035e3e639ac13e4a3be770f3567f244e88b66f4.camel@gmx.de>
Subject: Re: [PATCH 3/8] mm/vmscan: Throttle reclaim when no progress is
 being made
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Nov 2021 18:24:21 +0100
In-Reply-To: <20211124103221.GD3366@techsingularity.net>
References: <20211022144651.19914-1-mgorman@techsingularity.net>
         <20211022144651.19914-4-mgorman@techsingularity.net>
         <20211124011912.GA265983@magnolia>
         <20211124103221.GD3366@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UGrE5elq/4n2CM5WsDQ+BvOLwfO4BetVAUpGeX1s3pFfuu16Ww3
 GdCEG7pc2NoAjqyB8pf0g9AbopcRJ4yxRcnJLjV+GbfljBfjwAtwu8NiH+tN8Pe6KHRoXuI
 FpBbLqRWnNWi/eDbQuE1jgKJ2/+OuOJGZJrs2uKtNcCY5Obna3m0at3c5pl5RwWzaZNFWi7
 MbZ2RI1Vl7s0xJnpNawjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:W++fQ0FMKFs=:hAGeJe8wZ57nB/Ar9UwXdq
 TOSXTXw3748e6I9stlZHDkFOFZifNeCz+xFpYONhIVGDWMdfP3HpJRribzVWDT6vqt99DOnDP
 VtPXF89/FF2XQ8jWQs4fFjrizGsPmAk9RSvZMcDvKZ8/kMd1Uw0yZdGYMOp55Y3MaT7U6ce5Q
 UZKIHVjJQzxAjf7P+huuovpzX/uOrHu+HICXvGB6xwb7lhIcK/AyA8IviMhSbIMtIh/KR+HhR
 aA2Nra5TImJ8Qui4F+cT1NsMMmiuL435P3/3cLaqhMLbQfmfV561AzVUQt7XwI4ykHDGhjbZL
 0/hzVjH6MT5QU8+eP1MPlGGo1cwb4mKyNaMSHJYdGa4X9RYeYX205Ojzvs+UhL+0M8giyVW4j
 sP2br+hHn07Xs8/Ou51Owt5AGZQxeaqW0LpDOaYiL9flouarVkqdoLjjt3zY03Jbun0+EhKmO
 vt9hOlpj0qYoKldSzAVcvRZw4atOjAd9/8LVOWjZqBLWtHxBkDG/38En5UiRDm500/TYfak67
 nucAWaI17UPVMk1gpRau7//AXfL/ygafiTY83lS0UNUVfgltWjJacnCH5gZOteUq+tp0LItjP
 TJPP56yhOyle90FfJZi/Q/HE+Y5xfBwtYLVus0d89Spb/BAJKs6H7+JYvjyLSgdMhbfQwEvfc
 2EH1wlPvfinzyAk5t01BzXtRo3yep/55h74ZG/tYi4/6Q/WUqhPUCH/nQDxSnPZBEmEZOoDmw
 vOe6f+jN0AWftctCcQYEQayAgGLKQd5jrC4X1ejxVzks/nfQ8Aj7X1+rq0TIdcp26mwaQ/22j
 HDjNMkQiEVz9I2r+tLVYpA+UiOtuO1/JxNqL1TBWaTM5H090RzArWzXY0CoibZbmEFWa05cN1
 vdFuAJTz5diEfeZkjPU32aXI7ZG0byFD/jmbJ+yg9vsR9zHnLCas2jaRSSWVKKNNv/gv9p7E+
 TwZd3QlUDpmSPy99JwgIvCi5ng5U0V2kB+acIJkbxXJfpJDgVvMtSYR7a7cpMeQoy4EcPDXkd
 WAla8eA77KMdHAeXjdJdZWLEgmbjMu0li2lStqesEeh9bKFlY42Gad7nNC/Gj0vf8lpCi7Xuc
 u/p9c9nlOUQFr0=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-11-24 at 10:32 +0000, Mel Gorman wrote:
> On Tue, Nov 23, 2021 at 05:19:12PM -0800, Darrick J. Wong wrote:
>
> > AFAICT the system is mostly idle, but it's difficult to tell because p=
s
> > and top also get stuck waiting for this cgroup for whatever reason.
>
> But this is surprising because I expect that ps and top are not running
> within the cgroup. Was /proc/PID/stack readable?

Probably this.

crash> ps | grep UN
   4418   4417   4  ffff8881cae66e40  UN   0.0    7620    980  memcg_test_=
1 <=3D=3D the bad guy
   4419   4417   6  ffff8881cae62f40  UN   0.0    7620    980  memcg_test_=
1
   4420   4417   5  ffff8881cae65e80  UN   0.0    7620    980  memcg_test_=
1
   4421   4417   7  ffff8881cae63f00  UN   0.0    7620    980  memcg_test_=
1
   4422   4417   4  ffff8881cae60000  UN   0.0    7620    980  memcg_test_=
1
   4423   4417   3  ffff888128985e80  UN   0.0    7620    980  memcg_test_=
1
   4424   4417   7  ffff888117f79f80  UN   0.0    7620    980  memcg_test_=
1
   4425   4417   2  ffff888117f7af40  UN   0.0    7620    980  memcg_test_=
1
   4428   2791   6  ffff8881a8253f00  UN   0.0   38868   3568  ps
   4429   2808   4  ffff888100c90000  UN   0.0   38868   3600  ps
crash> bt -sx 4429
PID: 4429   TASK: ffff888100c90000  CPU: 4   COMMAND: "ps"
 #0 [ffff8881af1c3ce0] __schedule+0x285 at ffffffff817ae6c5
 #1 [ffff8881af1c3d68] schedule+0x3a at ffffffff817aed4a
 #2 [ffff8881af1c3d78] rwsem_down_read_slowpath+0x197 at ffffffff817b11a7
 #3 [ffff8881af1c3e08] down_read_killable+0x5c at ffffffff817b142c
 #4 [ffff8881af1c3e18] down_read_killable+0x5c at ffffffff817b142c
 #5 [ffff8881af1c3e28] __access_remote_vm+0x3f at ffffffff8120131f
 #6 [ffff8881af1c3e90] proc_pid_cmdline_read+0x148 at ffffffff812fc9a8
 #7 [ffff8881af1c3ee8] vfs_read+0x92 at ffffffff8126a302
 #8 [ffff8881af1c3f00] ksys_read+0x7d at ffffffff8126a72d
 #9 [ffff8881af1c3f38] do_syscall_64+0x37 at ffffffff817a3f57
#10 [ffff8881af1c3f50] entry_SYSCALL_64_after_hwframe+0x44 at ffffffff8180=
007c
    RIP: 00007f4b50fe8b5e  RSP: 00007ffdd7f6fe38  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 00007f4b5186a010  RCX: 00007f4b50fe8b5e
    RDX: 0000000000020000  RSI: 00007f4b5186a010  RDI: 0000000000000006
    RBP: 0000000000020000   R8: 0000000000000007   R9: 00000000ffffffff
    R10: 0000000000000000  R11: 0000000000000246  R12: 00007f4b5186a010
    R13: 0000000000000000  R14: 0000000000000006  R15: 0000000000000000
    ORIG_RAX: 0000000000000000  CS: 0033  SS: 002b
crash> mm_struct -x ffff8881021b4800
struct mm_struct {
  {
    mmap =3D 0xffff8881ccfe6a80,
    mm_rb =3D {
      rb_node =3D 0xffff8881ccfe61a0
    },
...
    mmap_lock =3D {
      count =3D {
        counter =3D 0x3
      },
      owner =3D {
        counter =3D 0xffff8881cae66e40
...
crash> bt 0xffff8881cae66e40
PID: 4418   TASK: ffff8881cae66e40  CPU: 4   COMMAND: "memcg_test_1"
 #0 [ffff888154097a88] __schedule at ffffffff817ae6c5
 #1 [ffff888154097b10] schedule at ffffffff817aed4a
 #2 [ffff888154097b20] schedule_timeout at ffffffff817b311f
 #3 [ffff888154097b90] reclaim_throttle at ffffffff811d802b
 #4 [ffff888154097bf0] do_try_to_free_pages at ffffffff811da206
 #5 [ffff888154097c40] try_to_free_mem_cgroup_pages at ffffffff811db522
 #6 [ffff888154097cd0] try_charge_memcg at ffffffff81256440
 #7 [ffff888154097d60] obj_cgroup_charge_pages at ffffffff81256c97
 #8 [ffff888154097d88] obj_cgroup_charge at ffffffff8125898c
 #9 [ffff888154097da8] kmem_cache_alloc at ffffffff81242099
#10 [ffff888154097de0] vm_area_alloc at ffffffff8106c87a
#11 [ffff888154097df0] mmap_region at ffffffff812082b2
#12 [ffff888154097e58] do_mmap at ffffffff81208922
#13 [ffff888154097eb0] vm_mmap_pgoff at ffffffff811e259f
#14 [ffff888154097f38] do_syscall_64 at ffffffff817a3f57
#15 [ffff888154097f50] entry_SYSCALL_64_after_hwframe at
ffffffff8180007c
    RIP: 00007f211c36b743  RSP: 00007ffeaac1bd58  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000000000000  RCX: 00007f211c36b743
    RDX: 0000000000000003  RSI: 0000000000001000  RDI: 0000000000000000
    RBP: 0000000000000000   R8: 0000000000000000   R9: 0000000000000000
    R10: 0000000000002022  R11: 0000000000000246  R12: 0000000000000003
    R13: 0000000000001000  R14: 0000000000002022  R15: 0000000000000000
    ORIG_RAX: 0000000000000009  CS: 0033  SS: 002b
crash>

