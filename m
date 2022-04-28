Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5A513910
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349352AbiD1P4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 11:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbiD1P4l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE5A2B82E3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651161203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XqXhJC5Ml0EN6/FSXB7t8SRorKZyuF/uH/ULRu7IhKw=;
        b=MuR6AcpZvvb68FKjMTdOyXp3MO0PTZOtSCnOMFjYEFjJfNgkqXYDsKDB1u6aB7I7Z9KVNe
        Kir7XsQVcSJSImW88A4ero+XyLU6V+0Q5Ku8aY5pZsWLChpTaB3I88tMRoDjO/YMNORBMX
        sul8EXuXkrFV4NlIH944A72+j4oMqGA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-2euhQd0mPS-6s-FjFagMQw-1; Thu, 28 Apr 2022 11:53:22 -0400
X-MC-Unique: 2euhQd0mPS-6s-FjFagMQw-1
Received: by mail-qv1-f72.google.com with SMTP id bu6-20020ad455e6000000b004563a74e3f9so4011368qvb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 08:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XqXhJC5Ml0EN6/FSXB7t8SRorKZyuF/uH/ULRu7IhKw=;
        b=P1Ksh75lVAqhqijKdlSd89GGTDqFTZn/nZKthNIV8uXTmS5XTFBnrZ9tsaSOh+mErR
         IRJq7tOUXpkpIkvm0Wm6ptVtWU/sP2Nhq4y6V4lbZ8FH+WHp0A9p2iTaYMpEQlSeQl8w
         kgEqT9SwhdFHjEgaSkApSV37Awclbh4rurZQGKkmggehCzMbueT6aSIXjDW5IexkXCUW
         QhFWhvKOrbImuXad24Y/UcGQ9gJwrVIl4T1u9IxSMktvymGVnLGGVhFb/P+cD5KKuTIr
         /qRiEWtfNpqYkbQdjnt/LGuVYMLhvSiTH9Fob3DgHzovvNX5fE7o7cQsPPOH+sFuWQ37
         oZ4A==
X-Gm-Message-State: AOAM5327AfGqjGobji2U88hbcmDP4Jk6ZG5x2qLzk24LobM0rara7Sev
        Yi7gwlQJ73hgOisf98H4HqGBFzX2CiTmuWuUOP3h8wZGavuJyw02VoT1rP72OJuv9upG+fgCOCF
        L4wBsP2DfgI41TlC8NTNackLs3w==
X-Received: by 2002:ad4:5e8b:0:b0:456:351c:cfcb with SMTP id jl11-20020ad45e8b000000b00456351ccfcbmr16151325qvb.97.1651161201719;
        Thu, 28 Apr 2022 08:53:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy832EJWOXf2xhXBD7p3V5MMiovNzvrjur/kuJ3YOfHPC56sZWsOAXt4LWFwHuwrXWaeSU0jA==
X-Received: by 2002:ad4:5e8b:0:b0:456:351c:cfcb with SMTP id jl11-20020ad45e8b000000b00456351ccfcbmr16151301qvb.97.1651161201343;
        Thu, 28 Apr 2022 08:53:21 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm206728qtx.58.2022.04.28.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:53:20 -0700 (PDT)
Date:   Thu, 28 Apr 2022 11:53:18 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <Ymq4brjhBcBvcfIs@bfoster>
References: <20220413033425.GM16799@magnolia>
 <YlbjOPEQP66gc1WQ@casper.infradead.org>
 <20220418174747.GF17025@magnolia>
 <20220422215943.GC17025@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422215943.GC17025@magnolia>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:59:43PM -0700, Darrick J. Wong wrote:
> On Mon, Apr 18, 2022 at 10:47:47AM -0700, Darrick J. Wong wrote:
> > On Wed, Apr 13, 2022 at 03:50:32PM +0100, Matthew Wilcox wrote:
> > > On Tue, Apr 12, 2022 at 08:34:25PM -0700, Darrick J. Wong wrote:
> > > > Hmm.  Two nights in a row I've seen the following crash.  Has anyone
> > > > else seen this, or should I keep digging?  This is a fairly boring
> > > > x86_64 VM with a XFS v5 filesystem + rmapbt.
> > > 
> > > I have not seen this before.  I test with:
> > > MKFS_OPTIONS  -- -f -m reflink=1,rmapbt=1 -i sparse=1 -b size=1024 /dev/sdc
> > > 
> > > Maybe I should try a 4096 byte block size.
> > > 
> > > > mm/filemap.c:1653 is the BUG in:
> > > > 
> > > > void folio_end_writeback(struct folio *folio)
> > > > {
> > > > 	/*
> > > > 	 * folio_test_clear_reclaim() could be used here but it is an
> > > > 	 * atomic operation and overkill in this particular case.
> > > > 	 * Failing to shuffle a folio marked for immediate reclaim is
> > > > 	 * too mild a gain to justify taking an atomic operation penalty
> > > > 	 * at the end of every folio writeback.
> > > > 	 */
> > > > 	if (folio_test_reclaim(folio)) {
> > > > 		folio_clear_reclaim(folio);
> > > > 		folio_rotate_reclaimable(folio);
> > > > 	}
> > > > 
> > > > 	/*
> > > > 	 * Writeback does not hold a folio reference of its own, relying
> > > > 	 * on truncation to wait for the clearing of PG_writeback.
> > > > 	 * But here we must make sure that the folio is not freed and
> > > > 	 * reused before the folio_wake().
> > > > 	 */
> > > > 	folio_get(folio);
> > > > 	if (!__folio_end_writeback(folio))
> > > > >>>>		BUG();
> > > 
> > > Grr, that should have been a VM_BUG_ON_FOLIO(1, folio) so we get useful
> > > information about the folio (like whether it has an iop, or what order
> > > the folio is).  Can you make that change and try to reproduce?
> > 
> > > What's going on here is that we've called folio_end_writeback() on a
> > > folio which does not have the writeback flag set.  That _should_ be
> > > impossible, hence the use of BUG().  Either we've called
> > > folio_end_writeback() twice on the same folio, or we neglected to set
> > > the writeback flag on the folio.  I don't immediately see why either
> > > of those two things would happen.
> > 
> > Well, I made that change and rebased to -rc3 to see if reverting that
> > ZERO_PAGE thing would produce better results, I think I just got the
> > same crash.  Curiously, the only VM that died this time was the one
> > running the realtime configuration, but it's still generic/068:
> > 
> > FSTYP         -- xfs (debug)
> > PLATFORM      -- Linux/x86_64 oci-mtr28 5.18.0-rc3-djwx #rc3 SMP PREEMPT_DYNAMIC Sun Apr 17 14:42:49 PDT 2022
> > MKFS_OPTIONS  -- -f -rrtdev=/dev/sdb4 -llogdev=/dev/sdb2 -m reflink=0,rmapbt=0, -d rtinherit=1, /dev/sda4
> > MOUNT_OPTIONS -- -ortdev=/dev/sdb4 -ologdev=/dev/sdb2 /dev/sda4 /opt
> > 
> > I don't know if it'll help, but here's the sequence of tests that we
> > were running just prior to crashing:
> > 
> > generic/445      3s
> > generic/225      76s
> > xfs/306  22s
> > xfs/290  3s
> > generic/155     [not run] Reflink not supported by test filesystem type: xfs
> > generic/525      6s
> > generic/269      89s
> > generic/1206    [not run] xfs_io swapext -v vfs -s 64k -l 64k ioctl support is missing
> > xfs/504  198s
> > xfs/192 [not run] Reflink not supported by scratch filesystem type: xfs
> > xfs/303  1s
> > generic/346      6s
> > generic/512      5s
> > xfs/227  308s
> > generic/147     [not run] Reflink not supported by test filesystem type: xfs
> > generic/230     [not run] Quotas not supported on realtime test device
> > generic/008      4s
> > generic/108      4s
> > xfs/264  12s
> > generic/200     [not run] Reflink not supported by scratch filesystem type: xfs
> > generic/493     [not run] Dedupe not supported by scratch filesystem type: xfs
> > xfs/021  5s
> > generic/672     [not run] Reflink not supported by scratch filesystem type: xfs
> > xfs/493  5s
> > xfs/146  13s
> > xfs/315 [not run] Reflink not supported by scratch filesystem type: xfs
> > generic/068     
> > 
> > And the dmesg output:
> > 
> > run fstests generic/068 at 2022-04-17 16:57:16
> > XFS (sda4): Mounting V5 Filesystem
> > XFS (sda4): Ending clean mount
> > page:ffffea0004a39c40 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x128e71
> > flags: 0x17ff80000000000(node=0|zone=2|lastcpupid=0xfff)
> > raw: 017ff80000000000 0000000000000000 ffffffff00000203 0000000000000000
> > raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> > page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/mm.h:1164!
> > invalid opcode: 0000 [#1] PREEMPT SMP
> > CPU: 3 PID: 1094085 Comm: 3:0 Tainted: G        W         5.18.0-rc3-djwx #rc3 0a707744ee7c555d54e50726c5b02515710a6aae
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
> > Workqueue: xfs-conv/sda4 xfs_end_io [xfs]
> > RIP: 0010:folio_end_writeback+0xd0/0x110
> > Code: 80 60 02 fb 48 89 ef e8 5e 6d 01 00 8b 45 34 83 c0 7f 83 f8 7f 0f 87 6a ff ff ff 48 c7 c6 40 c7 e2 81 48 89 ef e8 30 69 04 00 <0f> 0b 48 89 ee e8 b6 51 02 00 eb 9a 48 c7 c6 c0 ad e5 81 48 89 ef
> > RSP: 0018:ffffc900084f3d48 EFLAGS: 00010246
> > RAX: 000000000000005c RBX: 0000000000001000 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff81e56da3 RDI: 00000000ffffffff
> > RBP: ffffea0004a39c40 R08: 0000000000000000 R09: ffffffff8205fe40
> > R10: 0000000000017578 R11: 00000000000175f0 R12: 0000000000004000
> > R13: ffff88814dc5cd40 R14: 000000000000002e R15: ffffea0004a39c40
> > FS:  0000000000000000(0000) GS:ffff88843fd80000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f2b0ea47010 CR3: 000000043f00c000 CR4: 00000000001506a0
> > Call Trace:
> >  <TASK>
> >  iomap_finish_ioend+0x1ee/0x6a0
> >  iomap_finish_ioends+0x69/0x100
> >  xfs_end_ioend+0x5a/0x160 [xfs e8251de1111d7958449fd159d84af12a2afc12f2]
> >  xfs_end_io+0xb1/0xf0 [xfs e8251de1111d7958449fd159d84af12a2afc12f2]
> >  process_one_work+0x1df/0x3c0
> >  ? rescuer_thread+0x3b0/0x3b0
> >  worker_thread+0x53/0x3b0
> >  ? rescuer_thread+0x3b0/0x3b0
> >  kthread+0xea/0x110
> >  ? kthread_complete_and_exit+0x20/0x20
> >  ret_from_fork+0x1f/0x30
> >  </TASK>
> > Modules linked in: xfs dm_zero btrfs blake2b_generic xor lzo_compress lzo_decompress zlib_deflate raid6_pq zstd_compress dm_delay dm_snapshot dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_flakey libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 auth_rpcgss oid_registry xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq sch_fq_codel ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
> > Dumping ftrace buffer:
> >    (ftrace buffer empty)
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:folio_end_writeback+0xd0/0x110
> > Code: 80 60 02 fb 48 89 ef e8 5e 6d 01 00 8b 45 34 83 c0 7f 83 f8 7f 0f 87 6a ff ff ff 48 c7 c6 40 c7 e2 81 48 89 ef e8 30 69 04 00 <0f> 0b 48 89 ee e8 b6 51 02 00 eb 9a 48 c7 c6 c0 ad e5 81 48 89 ef
> > RSP: 0018:ffffc900084f3d48 EFLAGS: 00010246
> > RAX: 000000000000005c RBX: 0000000000001000 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff81e56da3 RDI: 00000000ffffffff
> > RBP: ffffea0004a39c40 R08: 0000000000000000 R09: ffffffff8205fe40
> > R10: 0000000000017578 R11: 00000000000175f0 R12: 0000000000004000
> > R13: ffff88814dc5cd40 R14: 000000000000002e R15: ffffea0004a39c40
> > FS:  0000000000000000(0000) GS:ffff88843fd80000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f2b0ea47010 CR3: 000000043f00c000 CR4: 00000000001506a0
> 
> Hmm.  I think you might be on to something about this being some
> mis-interaction when multi-page folios get truncated or possibly just
> split?  The VM_BUG_ON points to pfn 0x206a79, which I /think/ is the
> second page of the four-page folio starting with pfn=0x206a78?
> 

The above is the variant of generic/068 failure I was reproducing and
used to bisect [1]. With some additional tracing added to ioend
completion, what I'm seeing is that the bio_for_each_folio_all() bvec
iteration basically seems to go off the rails. What happens more
specifically is that at some point during the loop, bio_next_folio()
actually lands into the second page of the just processed folio instead
of the actual next folio (i.e. as if it's walking to the next page from
the head page of the folio instead of to the next 16k folio). I suspect
completion is racing with some form of truncation/reclaim/invalidation
here, what exactly I don't know, that perhaps breaks down the folio and
renders the iteration (bio_next_folio() -> folio_next()) unsafe. To test
that theory, I open coded and modified the loop to something like the
following:

                for (bio_first_folio(&fi, bio, 0); fi.folio; ) {
                        f = fi.folio;
                        l = fi.length;
                        bio_next_folio(&fi, bio);
                        iomap_finish_folio_write(inode, f, l, error);
                        folio_count++;
                }

... to avoid accessing folio metadata after writeback is cleared on it
and this seems to make the problem disappear (so far, I'll need to let
this spin for a while longer to be completely confident in that).

Brian

[1] https://lore.kernel.org/linux-xfs/YmlOfJljvI49sZyW@bfoster/

>     <...>-5263      3..... 276242022us : page_ref_mod: pfn=0x206a70 flags=referenced|uptodate|lru|active|private|writeback|head count=6 mapcount=0 mapping=ffff888125e5d868 mt=1 val=1
>     <...>-5263      3..... 276242023us : page_ref_mod_and_test: pfn=0x206a70 flags=referenced|uptodate|lru|active|private|head count=5 mapcount=0 mapping=ffff888125e5d868 mt=1 val=-1 ret=0
>     <...>-5263      3..... 276242023us : page_ref_mod: pfn=0x206a74 flags=referenced|uptodate|lru|active|private|writeback|head count=6 mapcount=0 mapping=ffff888125e5d868 mt=1 val=1
>     <...>-5263      3..... 276242024us : page_ref_mod_and_test: pfn=0x206a74 flags=referenced|uptodate|lru|active|private|head count=5 mapcount=0 mapping=ffff888125e5d868 mt=1 val=-1 ret=0
>     <...>-5263      3..... 276242025us : page_ref_mod: pfn=0x206a78 flags=referenced|uptodate|lru|active|private|writeback|head count=6 mapcount=0 mapping=ffff888125e5d868 mt=1 val=1
>    fstest-12612     2..... 276242082us : page_ref_mod_unless: pfn=0x206a70 flags=referenced|uptodate|lru|active|private|head count=6 mapcount=0 mapping=ffff888125e5d868 mt=1 val=1 ret=1
>    fstest-12612     2..... 276242083us : page_ref_mod_unless: pfn=0x206a74 flags=referenced|uptodate|lru|active|private|head count=6 mapcount=0 mapping=ffff888125e5d868 mt=1 val=1 ret=1
>    fstest-12612     2..... 276242083us : page_ref_mod_unless: pfn=0x206a78 flags=referenced|uptodate|lru|active|private|head count=7 mapcount=0 mapping=ffff888125e5d868 mt=1 val=1 ret=1
>    fstest-12612     2..... 276242084us : page_ref_mod_unless: pfn=0x206a7c flags=referenced|uptodate|lru|active|private|writeback|head count=6 mapcount=0 mapping=ffff888125e5d868 mt=1 val=1 ret=1
>    fstest-12612     2..... 276242084us : page_ref_mod_and_test: pfn=0x206a7c flags=referenced|uptodate|lru|active|private|writeback|head count=5 mapcount=0 mapping=ffff888125e5d868 mt=1 val=-1 ret=0
>    fstest-12612     2..... 276242094us : page_ref_mod_and_test: pfn=0x206a70 flags=locked|referenced|uptodate|lru|active|head count=5 mapcount=0 mapping=ffff888125e5d868 mt=1 val=-1 ret=0
>    fstest-12612     2..... 276242094us : page_ref_mod_and_test: pfn=0x206a74 flags=locked|referenced|uptodate|lru|active|head count=5 mapcount=0 mapping=ffff888125e5d868 mt=1 val=-1 ret=0
>    fstest-12612     2..... 276242094us : page_ref_mod_and_test: pfn=0x206a78 flags=locked|referenced|uptodate|lru|active|head count=6 mapcount=0 mapping=ffff888125e5d868 mt=1 val=-1 ret=0
>    fstest-12612     2..... 276242102us : page_ref_mod_and_test: pfn=0x206a70 flags=locked|referenced|uptodate|lru|active|head count=1 mapcount=0 mapping=0000000000000000 mt=1 val=-4 ret=0
>    fstest-12612     2..... 276242102us : page_ref_mod_and_test: pfn=0x206a74 flags=locked|referenced|uptodate|lru|active|head count=1 mapcount=0 mapping=0000000000000000 mt=1 val=-4 ret=0
>    fstest-12612     2..... 276242102us : page_ref_mod_and_test: pfn=0x206a78 flags=locked|referenced|uptodate|lru|active|head count=2 mapcount=0 mapping=0000000000000000 mt=1 val=-4 ret=0
>    fstest-12612     2..... 276242110us : page_ref_mod_and_test: pfn=0x206a70 flags=referenced|uptodate|lru|active|head count=0 mapcount=0 mapping=0000000000000000 mt=1 val=-1 ret=1
>    fstest-12612     2..... 276242111us : page_ref_mod_and_test: pfn=0x206a74 flags=referenced|uptodate|lru|active|head count=0 mapcount=0 mapping=0000000000000000 mt=1 val=-1 ret=1
>    fstest-12612     2..... 276242112us : page_ref_mod_and_test: pfn=0x206a78 flags=referenced|uptodate|lru|active|head count=1 mapcount=0 mapping=0000000000000000 mt=1 val=-1 ret=0
>    fstest-12612     2..... 276242112us : page_ref_mod_unless: pfn=0x206a7c flags=referenced|uptodate|lru|active|private|writeback|head count=6 mapcount=0 mapping=ffff888125e5d868 mt=1 val=1 ret=1
>    fstest-12612     2..... 276242112us : page_ref_mod_and_test: pfn=0x206a7c flags=referenced|uptodate|lru|active|private|writeback|head count=5 mapcount=0 mapping=ffff888125e5d868 mt=1 val=-1 ret=0
>    fstest-12612     2..... 276242119us : page_ref_mod_unless: pfn=0x206a7c flags=referenced|uptodate|lru|active|private|writeback|head count=6 mapcount=0 mapping=ffff888125e5d868 mt=1 val=1 ret=1
>     <...>-5263      3..... 276242194us : page_ref_mod_and_test: pfn=0x206a78 flags=referenced|uptodate|lru|active|head count=0 mapcount=0 mapping=0000000000000000 mt=1 val=-1 ret=1
>     <...>-5263      3d..1. 276242208us : console: [  309.491317] page:ffffea00081a9e40 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x206a79
> 
> In which case, that output reduces to:
> 
>     <...>-5263      3..... 276242025us : page_ref_mod: pfn=0x206a78 flags=referenced|uptodate|lru|active|private|writeback|head count=6 mapcount=0 mapping=ffff888125e5d868 mt=1 val=1
>    fstest-12612     2..... 276242083us : page_ref_mod_unless: pfn=0x206a78 flags=referenced|uptodate|lru|active|private|head count=7 mapcount=0 mapping=ffff888125e5d868 mt=1 val=1 ret=1
>    fstest-12612     2..... 276242094us : page_ref_mod_and_test: pfn=0x206a78 flags=locked|referenced|uptodate|lru|active|head count=6 mapcount=0 mapping=ffff888125e5d868 mt=1 val=-1 ret=0
>    fstest-12612     2..... 276242102us : page_ref_mod_and_test: pfn=0x206a78 flags=locked|referenced|uptodate|lru|active|head count=2 mapcount=0 mapping=0000000000000000 mt=1 val=-4 ret=0
>    fstest-12612     2..... 276242112us : page_ref_mod_and_test: pfn=0x206a78 flags=referenced|uptodate|lru|active|head count=1 mapcount=0 mapping=0000000000000000 mt=1 val=-1 ret=0
>     <...>-5263      3..... 276242194us : page_ref_mod_and_test: pfn=0x206a78 flags=referenced|uptodate|lru|active|head count=0 mapcount=0 mapping=0000000000000000 mt=1 val=-1 ret=1
>     <...>-5263      3d..1. 276242208us : console: [  309.491317] page:ffffea00081a9e40 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x206a79
> 
> Clearly the mapping gets torn off of this folio before time index
> 276242102us while it still has refcount==6.  It's curious that lost the
> writeback bit at the first line.
> 
> Unfortunately, the VM_BUG_ON means that the kernel dumps the ftrace
> buffer and crashes, so I can't actually do anything with the incomplete
> trace-cmd files that were recorded earlier.
> 
> --D
> 
> > --D
> > 
> > > 
> > > > 
> > > > 
> > > > --D
> > > > 
> > > > run fstests generic/068 at 2022-04-12 17:57:11
> > > > XFS (sda3): Mounting V5 Filesystem
> > > > XFS (sda3): Ending clean mount
> > > > XFS (sda4): Mounting V5 Filesystem
> > > > XFS (sda4): Ending clean mount
> > > > ------------[ cut here ]------------
> > > > kernel BUG at mm/filemap.c:1653!
> > > > invalid opcode: 0000 [#1] PREEMPT SMP
> > > > CPU: 0 PID: 1349866 Comm: 0:116 Tainted: G        W         5.18.0-rc2-djwx #rc2 19cc48221d47ada6c8e5859639b6a0946c9a3777
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
> > > > Workqueue: xfs-conv/sda4 xfs_end_io [xfs]
> > > > RIP: 0010:folio_end_writeback+0x79/0x80
> > > > Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
> > > > RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
> > > > RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
> > > > RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
> > > > RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
> > > > R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
> > > > R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
> > > > FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00007f5b067d0000 CR3: 000000010d1bb000 CR4: 00000000001506b0
> > > > Call Trace:
> > > >  <TASK>
> > > >  iomap_finish_ioend+0x19e/0x560
> > > >  iomap_finish_ioends+0x69/0x100
> > > >  xfs_end_ioend+0x5a/0x160 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
> > > >  xfs_end_io+0xb1/0xf0 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
> > > >  process_one_work+0x1df/0x3c0
> > > >  ? rescuer_thread+0x3b0/0x3b0
> > > >  worker_thread+0x53/0x3b0
> > > >  ? rescuer_thread+0x3b0/0x3b0
> > > >  kthread+0xea/0x110
> > > >  ? kthread_complete_and_exit+0x20/0x20
> > > >  ret_from_fork+0x1f/0x30
> > > >  </TASK>
> > > > Modules linked in: dm_snapshot dm_bufio dm_zero dm_flakey xfs libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 auth_rpcgss oid_registry xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq sch_fq_codel ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
> > > > Dumping ftrace buffer:
> > > >    (ftrace buffer empty)
> > > > ---[ end trace 0000000000000000 ]---
> > > > RIP: 0010:folio_end_writeback+0x79/0x80
> > > > Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
> > > > RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
> > > > RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
> > > > RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
> > > > RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
> > > > R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
> > > > R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
> > > > FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00007f4b94008278 CR3: 0000000101ac9000 CR4: 00000000001506b0
> > > > 
> 

