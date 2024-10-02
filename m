Return-Path: <linux-fsdevel+bounces-30755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC3398E1B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 19:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8791C22949
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42FF1D1739;
	Wed,  2 Oct 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMwUKeGH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EE1D1311;
	Wed,  2 Oct 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890487; cv=none; b=HFx1daP8xy/7agOLOyrp51TOx+x8uTe5F44s1cRxJJnCrPMxnYgISTWBQmhqA9CwWP88coedyE0RD+D/79P6ai9FfuDpoAZH7wqVulew3RVLg4IG2hxGj4vNHleVYZUXhbFkX6dsz5M4NtyUtEcNmz68NLQ/V0SIvRZGIhl/LR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890487; c=relaxed/simple;
	bh=UDF0Ot2Gn1pXG+DxULTeJYGNEZUw++55M4ayrj9HmDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AK5EOUibsiojU2QACF1sZ/MRmeEP61160hfBOpjAVzpx51+7Wd9wHiPFfWufIJGItX4NFQ8C+EZ78xo4FpktrK2UYdeCVQgkGjaUB+jYDnKpHuVVT+jO+sNQ5KOVQfUY11NktKHW9ZoIOIrDmvyEvGuYllYi4cg9sIoFtnULoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMwUKeGH; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb7f5f9fb7so837136d6.1;
        Wed, 02 Oct 2024 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727890484; x=1728495284; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lce+O4QgD9HDkDtMS7iA2RN59W1hoY4ZGmk5prbPGD0=;
        b=HMwUKeGHvi2UVufWLArM95zwsT0bRFULdfh5XEJagAY7s89CzsVOJe+twkPFofSZiW
         qMC7t/3S5o7wHBDG3jHhJ6wSIE42JiN+iQhZid9XVb/CxA3mSqe66Op8VMF0yeze2Em+
         UadP8zbE0NcQthXFGOjPHxgJ444guH/qQqsqKCjcVVY3wp+t4S6IqplpjGp2zygA+kZD
         ylWl6eHt4DPIc1fwwxDpVQwMXbW51f0ZJyQkjfZE/vcvU6iIW5U+CZarOcFCZrmjEkar
         9w6SA4sDrPKkifxMXJ1QKbi8JS6NiVuq/pC3Wb9z3f6nQT67Nh1tyP3+D+/dGmEoyRqF
         5rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727890484; x=1728495284;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lce+O4QgD9HDkDtMS7iA2RN59W1hoY4ZGmk5prbPGD0=;
        b=EuLNMLlwpvUHdjIeNWBIMGEmIP5BIYgzEW80ForaTbPzSI6QcAWLkzp3or2Jht2LPn
         hx9SIqcw+xqWqS9smximNVbQEcVMzNTs5NjOo23RZhiJWhxZDjY73yu0tJLzAt2gOlab
         OgOCI3DL2nluNZohvztqZtirjelVOru5VOKuTVNH4sLsL0+LGBoazcQo15l97aWn7hYa
         c7tThGGiFtTcsvKA0FbhdTO8w7yZ7natIVuyozwkyhMVD1+8jRTp2LGUadrqT7eqXNK0
         UK+i2cy/w6jdjVOl78RvaUpzn+F+iVWCOyVuNPlIWXMxwk6P0rWjK/DaFqZiKWMCd53X
         BVcA==
X-Forwarded-Encrypted: i=1; AJvYcCUE7Hb9VpWXuP33w6yCMS0nAe4lJTok+IzdFIXGyryeblUIbBFSBBgCeE68fPiBDhIkjBbn0mj+gYxGvB6j@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCZy82kKmHNULrBRO1r5Mdx5osHaFqpiofCdxYyZ6+um0fiWg
	1tv8f5l+ll2EEaFmTcGw7a75WokYe9QVqo4UxBfcsXJdnobEcoKxRWE8OJXO9ZIdUiDlx9kOIWH
	e5wPzMVPIX0cVXwhjI/HHJyJpnKoOUiVTut4=
X-Google-Smtp-Source: AGHT+IFM9A2s+pwE+IHbT52666EpyuP/sbkDeRnW7/cWZKgOQFzlWVlaKKSvXVqNP5mVUrTT0emIWNkqlrXO67LGB3Q=
X-Received: by 2002:a05:6214:41a0:b0:6cb:3a7b:96b9 with SMTP id
 6a1803df08f44-6cb81a05676mr47423046d6.15.1727890483575; Wed, 02 Oct 2024
 10:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com>
In-Reply-To: <CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 2 Oct 2024 22:34:32 +0500
Message-ID: <CABXGCsOw5_9o1rCweNd6i+P_R3TqaJbMLqEXqRO1NfZAVGyqOg@mail.gmail.com>
Subject: Re: 6.12/BUG: KASAN: slab-use-after-free in m_next at fs/proc/task_mmu.c:187
To: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 3:28=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
> I am testing kernel snapshots on Fedora Rawhide and Today with build
> on commit de5cb0dcb74c I saw for the first time "KASAN:
> slab-use-after-free in m_next+0x13b".
> Unfortunately it is not clear what triggered this problem because it
> happened after 21 hour uptime.
>
> Full trace looks like:
> input: Noble FoKus Mystique (AVRCP) as /devices/virtual/input/input26
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in m_next+0x13b/0x170
> Read of size 8 at addr ffff8885609b40f0 by task htop/3847
>
> CPU: 14 UID: 1000 PID: 3847 Comm: htop Tainted: G        W    L
> -------  ---  6.12.0-0.rc0.20240923gitde5cb0dcb74c.9.fc42.x86_64+debug
> #1
> Tainted: [W]=3DWARN, [L]=3DSOFTLOCKUP
> Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING WIFI,
> BIOS 3040 09/12/2024
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x84/0xd0
>  ? m_next+0x13b/0x170
>  print_report+0x174/0x505
>  ? m_next+0x13b/0x170
>  ? __virt_addr_valid+0x231/0x420
>  ? m_next+0x13b/0x170
>  kasan_report+0xab/0x180
>  ? m_next+0x13b/0x170
>  m_next+0x13b/0x170
>  seq_read_iter+0x8e5/0x1130
>  seq_read+0x2b4/0x3c0
>  ? __pfx_seq_read+0x10/0x10
>  ? inode_security+0x54/0xf0
>  ? rw_verify_area+0x3b2/0x5e0
>  vfs_read+0x165/0xa20
>  ? __pfx_vfs_read+0x10/0x10
>  ? ktime_get_coarse_real_ts64+0x41/0xd0
>  ? local_clock_noinstr+0xd/0x100
>  ? __pfx_lock_release+0x10/0x10
>  ksys_read+0xfb/0x1d0
>  ? __pfx_ksys_read+0x10/0x10
>  ? ktime_get_coarse_real_ts64+0x41/0xd0
>  do_syscall_64+0x97/0x190
>  ? __lock_acquire+0xdcd/0x62c0
>  ? __pfx___lock_acquire+0x10/0x10
>  ? __pfx___lock_acquire+0x10/0x10
>  ? __pfx___lock_acquire+0x10/0x10
>  ? audit_filter_inodes.part.0+0x12d/0x220
>  ? local_clock_noinstr+0xd/0x100
>  ? __pfx_lock_release+0x10/0x10
>  ? rcu_is_watching+0x12/0xc0
>  ? kfree+0x27c/0x4d0
>  ? audit_reset_context+0x8c5/0xee0
>  ? lockdep_hardirqs_on_prepare+0x171/0x400
>  ? do_syscall_64+0xa3/0x190
>  ? lockdep_hardirqs_on+0x7c/0x100
>  ? do_syscall_64+0xa3/0x190
>  ? do_syscall_64+0xa3/0x190
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f4190dcac36
> Code: 89 df e8 2d c1 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 15
> 83 e2 39 83 fa 08 75 0d e8 32 ff ff ff 66 90 48 8b 45 10 0f 05 <48> 8b
> 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
> RSP: 002b:00007ffcde82b690 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007f4190ce3740 RCX: 00007f4190dcac36
> RDX: 0000000000000400 RSI: 000055bf5e823a20 RDI: 0000000000000005
> RBP: 00007ffcde82b6a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007f4190f44fd0
> R13: 00007f4190f44e80 R14: 000055bf5e823e20 R15: 000055bf5ecc9160
>  </TASK>
>
> Allocated by task 176289:
>  kasan_save_stack+0x30/0x50
>  kasan_save_track+0x14/0x30
>  __kasan_slab_alloc+0x6e/0x70
>  kmem_cache_alloc_noprof+0x15a/0x3d0
>  vm_area_dup+0x23/0x190
>  __split_vma+0x137/0xd40
>  vms_gather_munmap_vmas+0x29d/0xfc0
>  mmap_region+0x35a/0x1f50
>  do_mmap+0x8e7/0x1020
>  vm_mmap_pgoff+0x178/0x2f0
>  __do_fast_syscall_32+0x86/0x110
>  do_fast_syscall_32+0x32/0x80
>  sysret32_from_system_call+0x0/0x4a
>
> Freed by task 0:
>  kasan_save_stack+0x30/0x50
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x70
>  __kasan_slab_free+0x37/0x50
>  kmem_cache_free+0x1a7/0x5a0
>  rcu_do_batch+0x3fd/0x1120
>  rcu_core+0x636/0x9b0
>  handle_softirqs+0x1e9/0x8d0
>  __irq_exit_rcu+0xbb/0x1c0
>  irq_exit_rcu+0xe/0x30
>  sysvec_apic_timer_interrupt+0xa1/0xd0
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20
>
> Last potentially related work creation:
>  kasan_save_stack+0x30/0x50
>  __kasan_record_aux_stack+0x8e/0xa0
>  __call_rcu_common.constprop.0+0xf4/0x10d0
>  vma_complete+0x720/0x10b0
>  commit_merge+0x42a/0x1310
>  vma_expand+0x313/0xad0
>  vma_merge_new_range+0x2cd/0xec0
>  mmap_region+0x432/0x1f50
>  do_mmap+0x8e7/0x1020
>  vm_mmap_pgoff+0x178/0x2f0
>  __do_fast_syscall_32+0x86/0x110
>  do_fast_syscall_32+0x32/0x80
>  sysret32_from_system_call+0x0/0x4a
>
> The buggy address belongs to the object at ffff8885609b40f0
>  which belongs to the cache vm_area_struct of size 176
> The buggy address is located 0 bytes inside of
>  freed 176-byte region [ffff8885609b40f0, ffff8885609b41a0)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5609=
b4
> head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> memcg:ffff88814d36d001
> flags: 0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> page_type: f5(slab)
> raw: 0017ffffc0000040 ffff888108113d40 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000000220022 00000001f5000000 ffff88814d36d001
> head: 0017ffffc0000040 ffff888108113d40 dead000000000100 dead000000000122
> head: 0000000000000000 0000000000220022 00000001f5000000 ffff88814d36d001
> head: 0017ffffc0000001 ffffea0015826d01 ffffffffffffffff 0000000000000000
> head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8885609b3f80: 00 00 00 00 00 00 00 00 00 00 00 00task_mmu 00 00 00 0=
0
>  ffff8885609b4000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff8885609b4080: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fa fb
>                                                              ^
>  ffff8885609b4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8885609b4180: fb fb fb fb fc fc fc fc fc fc fc fc 00 00 00 00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Disabling lock debugging due to kernel taint
>
> > sh /usr/src/kernels/(uname -r)/scripts/faddr2line /lib/debug/lib/module=
s/(uname -r)/vmlinux m_next+0x13b
> m_next+0x13b/0x170:
> proc_get_vma at fs/proc/task_mmu.c:136
> (inlined by) m_next at fs/proc/task_mmu.c:187
>
> > cat -n /usr/src/debug/kernel-6.11-8833-gde5cb0dcb74c/linux-6.12.0-0.rc0=
.20240923gitde5cb0dcb74c.9.fc42.x86_64/fs/proc/task_mmu.c | sed -n '182,192=
 p'
>    182 {
>    183 if (*ppos =3D=3D -2UL) {
>    184 *ppos =3D -1UL;
>    185 return NULL;
>    186 }
>    187 return proc_get_vma(m->private, ppos);
>    188 }
>    189
>    190 static void m_stop(struct seq_file *m, void *v)
>    191 {
>    192 struct proc_maps_private *priv =3D m->private;
>
> > git blame fs/proc/task_mmu.c -L 182,192
> Blaming lines: 100% (11/11), done.
> a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 182) {
> c4c84f06285e4 (Matthew Wilcox (Oracle) 2022-09-06 19:48:57 +0000 183)
>  if (*ppos =3D=3D -2UL) {
> c4c84f06285e4 (Matthew Wilcox (Oracle) 2022-09-06 19:48:57 +0000 184)
>          *ppos =3D -1UL;
> c4c84f06285e4 (Matthew Wilcox (Oracle) 2022-09-06 19:48:57 +0000 185)
>          return NULL;
> c4c84f06285e4 (Matthew Wilcox (Oracle) 2022-09-06 19:48:57 +0000 186)   }
> c4c84f06285e4 (Matthew Wilcox (Oracle) 2022-09-06 19:48:57 +0000 187)
>  return proc_get_vma(m->private, ppos);
> a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 188) }
> a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 189)
> a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 190)
> static void m_stop(struct seq_file *m, void *v)
> a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 191) {
> a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 192)
>  struct proc_maps_private *priv =3D m->private;
>
> Hmm this line hasn't changed for two years.
>
> Machine spec: https://linux-hardware.org/?probe=3D323b76ce48
> I attached below full kernel log and build config.
>
> Can anyone figure out what happened or should we wait for the second
> manifestation of this issue?
>

Finally I spotted that this issue is caused by the Steam client.
And usually happens after downloading game updates.
Looks like Steam client runs some post update scripts which cause
slab-use-after-free in m_next.

Git bisect found the first bad commit:
commit f8d112a4e657c65c888e6b8a8435ef61a66e4ab8 (HEAD)
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Fri Aug 30 00:00:54 2024 -0400

    mm/mmap: avoid zeroing vma tree in mmap_region()

    Instead of zeroing the vma tree and then overwriting the area, let the
    area be overwritten and then clean up the gathered vmas using
    vms_complete_munmap_vmas().

    To ensure locking is downgraded correctly, the mm is set regardless of
    MAP_FIXED or not (NULL vma).

    If a driver is mapping over an existing vma, then clear the ptes before
    the call_mmap() invocation.  This is done using the vms_clean_up_area()
    helper.  If there is a close vm_ops, that must also be called to ensure
    any cleanup is done before mapping over the area.  This also means that
    calling open has been added to the abort of an unmap operation, for now=
.

    Since vm_ops->open() and vm_ops->close() are not always undo each other
    (state cleanup may exist in ->close() that is lost forever), the code
    cannot be left in this way, but that change has been isolated to anothe=
r
    commit to make this point very obvious for traceability.

    Temporarily keep track of the number of pages that will be removed and
    reduce the charged amount.

    This also drops the validate_mm() call in the vma_expand() function.  I=
t
    is necessary to drop the validate as it would fail since the mm map_cou=
nt
    would be incorrect during a vma expansion, prior to the cleanup from
    vms_complete_munmap_vmas().

    Clean up the error handing of the vms_gather_munmap_vmas() by calling t=
he
    verification within the function.

    Link: https://lkml.kernel.org/r/20240830040101.822209-15-Liam.Howlett@o=
racle.com
    Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
    Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
    Cc: Bert Karwatzki <spasswolf@web.de>
    Cc: Jeff Xu <jeffxu@chromium.org>
    Cc: Jiri Olsa <olsajiri@gmail.com>
    Cc: Kees Cook <kees@kernel.org>
    Cc: Lorenzo Stoakes <lstoakes@gmail.com>
    Cc: Mark Brown <broonie@kernel.org>
    Cc: Matthew Wilcox <willy@infradead.org>
    Cc: "Paul E. McKenney" <paulmck@kernel.org>
    Cc: Paul Moore <paul@paul-moore.com>
    Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
    Cc: Suren Baghdasaryan <surenb@google.com>
    Cc: Vlastimil Babka <vbabka@suse.cz>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

 mm/mmap.c | 57 +++++++++++++++++++++++++++------------------------------
 mm/vma.c  | 54 ++++++++++++++++++++++++++++++++++++++++++------------
 mm/vma.h  | 22 ++++++++++++++++------
 3 files changed, 85 insertions(+), 48 deletions(-)

--=20
Best Regards,
Mike Gavrilov.

