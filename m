Return-Path: <linux-fsdevel+bounces-16650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E81418A0911
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 09:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B7B23898
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 07:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3419F13DDBA;
	Thu, 11 Apr 2024 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTYuvZ1a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0513DB9C;
	Thu, 11 Apr 2024 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819088; cv=none; b=pz7J1oJHNI8Tdf5eJfAsMR7pbwdl1H136aqH1fdwVQf8bXYP06AXPCKe8AZEfrbCHxdepq2DfTTRTKOks+a7/KqIirI/kKU9VAWm0O6ksckYUl1eB5lYI8BhiBrSex88wnk+EfjN5vV6i4TCDKwC4fFkz+aoov8/Je9IVzA5ufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819088; c=relaxed/simple;
	bh=eaGcbvdodetM59RTCgz6L5qL2UrvWr2CoUuW1lwd3bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtKA+bX0VwLwDgthcRP62J0lgohYEqusUc9MS23/ftcMUL4d+EHiUA5qqgSO0H6XEm7Fv3DoYAE7mUw26Iv0p9olfaRYpK1C+uL3flaQwV4ki4ZmSbJjvVAske1WSVKKq1lku08TnokDkHOisbdYwBmeczstHYL5e2bnoWFf36M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTYuvZ1a; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d09bd434so8390128e87.1;
        Thu, 11 Apr 2024 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819085; x=1713423885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FucNyXYncjy7kwHBxXtuX2PTVIjahh5aNMYaH57AMg=;
        b=UTYuvZ1aExqOipFHtFuN8KzJO4E4AWbu6FxNUb7owJpv3qsVnL7/VUcjLYev7cqQdT
         C0KdFsgddYTVH91UgAvJCz8L/imYx5r42lOry6b2On0JW+/0Kmu2ZAzn5rZXXr9xPt2N
         OXuMQbNTg/Cx0IPc5+YASoAA5OYw5m6B63IlDdOeqxzEPY7+Uebi8yUv526+XUAmYXI0
         3cs0wAalcNzO8UmUYGeEX3HydEa7kcJJA6yWiiF9zxURjC/sjF2ks/DHP2UQxhUbUswP
         PceqctzJ0GPyKmWXGQGyWo0lxrjiBe6TlzJXAiuu0zI++SMXnqgZEcGIt5DvfjT0Dqhr
         1+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819085; x=1713423885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FucNyXYncjy7kwHBxXtuX2PTVIjahh5aNMYaH57AMg=;
        b=QSJ6LWijzbMz60ISqiIzHNxE4R3V098tZEV9/0NEdCjAqIWE2Rnw3OiU7D/UPPGE/y
         7fjGQMWCzoOIfyUf3ZLGII+2nwvzMe8evFAiC5flefFGs0ht2CR4u/rC6guHDbkNoYHS
         7A5SXpsIE+54XuslrcSIuR4MI9+KEhsonBDPzUS/h+S0qzYz/utILnbEp2AI5XwtzApd
         2QYaebq+eTX1O+FATpvbABt71b8Pqsxl6HUX2hnzOZY1L+q4vhwTEkvycPYJdLcbrKkY
         Ef2+T9nZ3dNPbhOruAxQPbLxvRB5VLyZcG9p0MibusDvKx3JiSmhtgCuSwxzPSq1uXZ/
         LHPw==
X-Forwarded-Encrypted: i=1; AJvYcCXr3ZHjDwMfDTFNUAjHzUA8U8bndYN0QiSyuUAoxWWm6bze2M5O5XQ50Fkm4b6PikPd7SmgrhXd2UzyRRY5STz4EnrGy2SM5joa2iWbhGlrz7mIh/cdX0yPRUDsU2RbecO8n185V4qnxoWiuw==
X-Gm-Message-State: AOJu0YwminvGlR5xUvQor6FbjdmUg2MJqfzvkEkao7Wq68MkmpPDE4Wf
	FvQLxWN33sN1rzR3z55WfioQwhSHypRqG0vYcQB7jwq/SSmkIAZ+RRSzUyaEolGCMBZhjhsxf2H
	m1PIVrwLYI2r7naj5vrZhqyq6jTosQJxI
X-Google-Smtp-Source: AGHT+IHmAZYzKLlo9ZRZ5MSvjVVpsdnlztH3Eugi/K9/tCqxLHp4ecBXsf/lMLuZBLv8YTSMB7qbYfKqcDr0XYnbEcc=
X-Received: by 2002:a2e:9b4b:0:b0:2d4:6c52:23d5 with SMTP id
 o11-20020a2e9b4b000000b002d46c5223d5mr2927189ljj.50.1712819084262; Thu, 11
 Apr 2024 00:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org> <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org> <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org> <20221018223042.GJ2703033@dread.disaster.area>
 <Y1AWXiJdyjdLmO1E@casper.infradead.org> <20221019220424.GO2703033@dread.disaster.area>
 <Y1HDDu3UV0L3cDwE@casper.infradead.org> <20221101071721.GV2703033@dread.disaster.area>
In-Reply-To: <20221101071721.GV2703033@dread.disaster.area>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 11 Apr 2024 15:04:32 +0800
Message-ID: <CAGWkznEsREG3Ok8zDwPkqJoHGv6_0f3KX1um-zL_VH=2EkOu9Q@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com, baocong.liu@unisoc.com, 
	linux-fsdevel@vger.kernel.org, Brian Foster <bfoster@redhat.com>, 
	Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 1, 2022 at 3:17=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Thu, Oct 20, 2022 at 10:52:14PM +0100, Matthew Wilcox wrote:
> > On Thu, Oct 20, 2022 at 09:04:24AM +1100, Dave Chinner wrote:
> > > On Wed, Oct 19, 2022 at 04:23:10PM +0100, Matthew Wilcox wrote:
> > > > On Wed, Oct 19, 2022 at 09:30:42AM +1100, Dave Chinner wrote:
> > > > > This is reading and writing the same amount of file data at the
> > > > > application level, but once the data has been written and kicked =
out
> > > > > of the page cache it seems to require an awful lot more read IO t=
o
> > > > > get it back to the application. i.e. this looks like mmap() is
> > > > > readahead thrashing severely, and eventually it livelocks with th=
is
> > > > > sort of report:
> > > > >
> > > > > [175901.982484] rcu: INFO: rcu_preempt detected stalls on CPUs/ta=
sks:
> > > > > [175901.985095] rcu:    Tasks blocked on level-1 rcu_node (CPUs 0=
-15): P25728
> > > > > [175901.987996]         (detected by 0, t=3D97399871 jiffies, g=
=3D15891025, q=3D1972622 ncpus=3D32)
> > > > > [175901.991698] task:test_write      state:R  running task     st=
ack:12784 pid:25728 ppid: 25696 flags:0x00004002
> > > > > [175901.995614] Call Trace:
> > > > > [175901.996090]  <TASK>
> > > > > [175901.996594]  ? __schedule+0x301/0xa30
> > > > > [175901.997411]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > > > [175901.998513]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > > > [175901.999578]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > > > [175902.000714]  ? xas_start+0x53/0xc0
> > > > > [175902.001484]  ? xas_load+0x24/0xa0
> > > > > [175902.002208]  ? xas_load+0x5/0xa0
> > > > > [175902.002878]  ? __filemap_get_folio+0x87/0x340
> > > > > [175902.003823]  ? filemap_fault+0x139/0x8d0
> > > > > [175902.004693]  ? __do_fault+0x31/0x1d0
> > > > > [175902.005372]  ? __handle_mm_fault+0xda9/0x17d0
> > > > > [175902.006213]  ? handle_mm_fault+0xd0/0x2a0
> > > > > [175902.006998]  ? exc_page_fault+0x1d9/0x810
> > > > > [175902.007789]  ? asm_exc_page_fault+0x22/0x30
> > > > > [175902.008613]  </TASK>
> > > > >
> > > > > Given that filemap_fault on XFS is probably trying to map large
> > > > > folios, I do wonder if this is a result of some kind of race with
> > > > > teardown of a large folio...
> > > >
> > > > It doesn't matter whether we're trying to map a large folio; it
> > > > matters whether a large folio was previously created in the cache.
> > > > Through the magic of readahead, it may well have been.  I suspect
> > > > it's not teardown of a large folio, but splitting.  Removing a
> > > > page from the page cache stores to the pointer in the XArray
> > > > first (either NULL or a shadow entry), then decrements the refcount=
.
> > > >
> > > > We must be observing a frozen folio.  There are a number of places
> > > > in the MM which freeze a folio, but the obvious one is splitting.
> > > > That looks like this:
> > > >
> > > >         local_irq_disable();
> > > >         if (mapping) {
> > > >                 xas_lock(&xas);
> > > > (...)
> > > >         if (folio_ref_freeze(folio, 1 + extra_pins)) {
> > >
> > > But the lookup is not doing anything to prevent the split on the
> > > frozen page from making progress, right? It's not holding any folio
> > > references, and it's not holding the mapping tree lock, either. So
> > > how does the lookup in progress prevent the page split from making
> > > progress?
> >
> > My thinking was that it keeps hammering the ->refcount field in
> > struct folio.  That might prevent a thread on a different socket
> > from making forward progress.  In contrast, spinlocks are designed
> > to be fair under contention, so by spinning on an actual lock, we'd
> > remove contention on the folio.
> >
> > But I think the tests you've done refute that theory.  I'm all out of
> > ideas at the moment.  Either we have a frozen folio from somebody who
> > doesn't hold the lock, or we have someone who's left a frozen folio in
> > the page cache.  I'm leaning towards that explanation at the moment,
> > but I don't have a good suggestion for debugging.
>
> It's something else. I got gdb attached to qemu and single stepped
> the looping lookup. The context I caught this time is truncate after
> unlink:
>
> (gdb) bt
> #0  find_get_entry (mark=3D<optimized out>, max=3D<optimized out>, xas=3D=
<optimized out>) at mm/filemap.c:2014
> #1  find_lock_entries (mapping=3Dmapping@entry=3D0xffff8882445e2118, star=
t=3Dstart@entry=3D25089, end=3Dend@entry=3D18446744073709551614,
>     fbatch=3Dfbatch@entry=3D0xffffc900082a7dd8, indices=3Dindices@entry=
=3D0xffffc900082a7d60) at mm/filemap.c:2095
> #2  0xffffffff8128f024 in truncate_inode_pages_range (mapping=3Dmapping@e=
ntry=3D0xffff8882445e2118, lstart=3Dlstart@entry=3D0, lend=3Dlend@entry=3D-=
1)
>     at mm/truncate.c:364
> #3  0xffffffff8128f452 in truncate_inode_pages (lstart=3D0, mapping=3D0xf=
fff8882445e2118) at mm/truncate.c:452
> #4  0xffffffff8136335d in evict (inode=3Dinode@entry=3D0xffff8882445e1f78=
) at fs/inode.c:666
> #5  0xffffffff813636cc in iput_final (inode=3D0xffff8882445e1f78) at fs/i=
node.c:1747
> #6  0xffffffff81355b8b in do_unlinkat (dfd=3Ddfd@entry=3D10, name=3D0xfff=
f88834170e000) at fs/namei.c:4326
> #7  0xffffffff81355cc3 in __do_sys_unlinkat (flag=3D<optimized out>, path=
name=3D<optimized out>, dfd=3D<optimized out>) at fs/namei.c:4362
> #8  __se_sys_unlinkat (flag=3D<optimized out>, pathname=3D<optimized out>=
, dfd=3D<optimized out>) at fs/namei.c:4355
> #9  __x64_sys_unlinkat (regs=3D<optimized out>) at fs/namei.c:4355
> #10 0xffffffff81e92e35 in do_syscall_x64 (nr=3D<optimized out>, regs=3D0x=
ffffc900082a7f58) at arch/x86/entry/common.c:50
> #11 do_syscall_64 (regs=3D0xffffc900082a7f58, nr=3D<optimized out>) at ar=
ch/x86/entry/common.c:80
> #12 0xffffffff82000087 in entry_SYSCALL_64 () at arch/x86/entry/entry_64.=
S:120
> #13 0x0000000000000000 in ?? ()
>
> The find_lock_entries() call is being asked to start at index
> 25089, and we are spinning on a folio we find because
> folio_try_get_rcu(folio) is failing - the folio ref count is zero.
>
> The xas state on lookup is:
>
> (gdb) p *xas
> $6 =3D {xa =3D 0xffff8882445e2120, xa_index =3D 25092, xa_shift =3D 0 '\0=
00', xa_sibs =3D 0 '\000', xa_offset =3D 4 '\004', xa_pad =3D 0 '\000',
>   xa_node =3D 0xffff888144c15918, xa_alloc =3D 0x0 <fixed_percpu_data>, x=
a_update =3D 0x0 <fixed_percpu_data>, xa_lru =3D 0x0 <fixed_percpu_data>
>
> indicating that we are trying to look up index 25092 (3 pages
> further in than the start of the batch), and the folio that this
> keeps returning is this:
>
> (gdb) p *folio
> $7 =3D {{{flags =3D 24769796876795904, {lru =3D {next =3D 0xffffea0005690=
008, prev =3D 0xffff88823ffd5f50}, {__filler =3D 0xffffea0005690008,
>           mlock_count =3D 1073569616}}, mapping =3D 0x0 <fixed_percpu_dat=
a>, index =3D 18688, private =3D 0x8 <fixed_percpu_data+8>, _mapcount =3D {
>         counter =3D -129}, _refcount =3D {counter =3D 0}, memcg_data =3D =
0}, page =3D {flags =3D 24769796876795904, {{{lru =3D {next =3D 0xffffea000=
5690008,
>               prev =3D 0xffff88823ffd5f50}, {__filler =3D 0xffffea0005690=
008, mlock_count =3D 1073569616}, buddy_list =3D {
>               next =3D 0xffffea0005690008, prev =3D 0xffff88823ffd5f50}, =
pcp_list =3D {next =3D 0xffffea0005690008, prev =3D 0xffff88823ffd5f50}},
>           mapping =3D 0x0 <fixed_percpu_data>, index =3D 18688, private =
=3D 8}, {pp_magic =3D 18446719884544507912, pp =3D 0xffff88823ffd5f50,
>           _pp_mapping_pad =3D 0, dma_addr =3D 18688, {dma_addr_upper =3D =
8, pp_frag_count =3D {counter =3D 8}}}, {
>           compound_head =3D 18446719884544507912, compound_dtor =3D 80 'P=
', compound_order =3D 95 '_', compound_mapcount =3D {counter =3D -30590},
>           compound_pincount =3D {counter =3D 0}, compound_nr =3D 0}, {_co=
mpound_pad_1 =3D 18446719884544507912,
>           _compound_pad_2 =3D 18446612691733536592, deferred_list =3D {ne=
xt =3D 0x0 <fixed_percpu_data>,
>             prev =3D 0x4900 <irq_stack_backing_store+10496>}}, {_pt_pad_1=
 =3D 18446719884544507912, pmd_huge_pte =3D 0xffff88823ffd5f50,
>           _pt_pad_2 =3D 0, {pt_mm =3D 0x4900 <irq_stack_backing_store+104=
96>, pt_frag_refcount =3D {counter =3D 18688}},
>           ptl =3D 0x8 <fixed_percpu_data+8>}, {pgmap =3D 0xffffea00056900=
08, zone_device_data =3D 0xffff88823ffd5f50}, callback_head =3D {
>           next =3D 0xffffea0005690008, func =3D 0xffff88823ffd5f50}}, {_m=
apcount =3D {counter =3D -129}, page_type =3D 4294967167}, _refcount =3D {
>         counter =3D 0}, memcg_data =3D 0}}, _flags_1 =3D 2476979687679590=
4, __head =3D 0, _folio_dtor =3D 3 '\003', _folio_order =3D 8 '\b',
>   _total_mapcount =3D {counter =3D -1}, _pincount =3D {counter =3D 0}, _f=
olio_nr_pages =3D 0}
> (gdb)
>
> The folio has a NULL mapping, and an index of 18688, which means
> even if it was not a folio that has been invalidated or freed, the
> index is way outside the range we are looking for.
>
> If I step it round the lookup loop, xas does not change, and the
> same folio is returned every time through the loop. Perhaps
> the mapping tree itself might be corrupt???
>
> It's simple enough to stop the machine once it has become stuck to
> observe the iteration and dump structures, just tell me what you
> need to know from here...
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com

This bug emerges again and I would like to propose a reproduce
sequence of this bug which has nothing to do with scheduler stuff (
this could be wrong and sorry for wasting your time if so)

Thread_isolate:
1. alloc_contig_range->isolate_migratepages_block isolate a certain of
pages to cc->migratepages
       (folio has refcount: 1 + n (alloc_pages, page_cache))

2. alloc_contig_range->migrate_pages->folio_ref_freeze(folio, 1 +
extra_pins) set the folio->refcnt to 0

3. alloc_contig_range->migrate_pages->xas_split split the folios to
each slot as folio from slot[offset] to slot[offset + sibs]

Thread_truncate:
4. enter the livelock by the chain below
      rcu_read_lock();
        find_get_entry
            folio =3D xas_find
            if(!folio_try_get_rcu)
                xas_reset;
      rcu_read_unlock();

4'. alloc_contig_range->migrate_pages->__split_huge_page which will
modify folio's refcnt to 2 and breaks the livelock but is blocked by
lruvec->lock's contention

If the above call chain makes sense, could we solve this by below
modification which has split_folio and __split_huge_page be atomic by
taking lruvec->lock earlier than now.

int split_huge_page_to_list_to_order(struct page *page, struct list_head *l=
ist,
                                     unsigned int new_order)
{

+        lruvec =3D folio_lruvec_lock(folio);
                if (mapping) {
                        int nr =3D folio_nr_pages(folio);

                        xas_split(&xas, folio, folio_order(folio));
                        if (folio_test_pmd_mappable(folio) &&
                            new_order < HPAGE_PMD_ORDER) {
                                if (folio_test_swapbacked(folio)) {
                                        __lruvec_stat_mod_folio(folio,
                                                        NR_SHMEM_THPS, -nr)=
;
                                } else {
                                        __lruvec_stat_mod_folio(folio,
                                                        NR_FILE_THPS, -nr);
                                        filemap_nr_thps_dec(mapping);
                                }
                        }
                }

                __split_huge_page(page, list, end, new_order);
+        folio_lruvec_unlock(folio);

