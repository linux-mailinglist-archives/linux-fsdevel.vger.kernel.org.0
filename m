Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79027275E03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 18:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIWQzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 12:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbgIWQzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600880109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUSm6Jd9kppSRElqFCFSMQvc3MYe1vIAEmLYr4crmdc=;
        b=ELcMngBHPT+lcEDaIAYbWY0KmSw4kNg9AhwRAwi6KeDqR3Hhd2ipo1yOf1hCa0CFDYrB6U
        siLH4ZSDqFsLkqa0F9yTGT7ZAIDxDlwMSZTR2XS4m0DKSRAIiLrSNexDNieWL1C+6Za02P
        ntl1szzFNwZ7zH2OCK+rQy7UywoN8gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-F9xQiLQkO7iC0xbWG9znvg-1; Wed, 23 Sep 2020 12:55:05 -0400
X-MC-Unique: F9xQiLQkO7iC0xbWG9znvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 003F4801F9A;
        Wed, 23 Sep 2020 16:55:03 +0000 (UTC)
Received: from ovpn-66-35.rdu2.redhat.com (unknown [10.10.67.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A380E1002C04;
        Wed, 23 Sep 2020 16:55:00 +0000 (UTC)
Message-ID: <ff8f882fe320e53f5f429fc9a9d4ed85410d7972.camel@redhat.com>
Subject: Re: [PATCH v2 5/9] iomap: Support arbitrarily many blocks per page
From:   Qian Cai <cai@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Dave Chinner <dchinner@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Date:   Wed, 23 Sep 2020 12:55:00 -0400
In-Reply-To: <20200923024859.GM32101@casper.infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
         <20200910234707.5504-6-willy@infradead.org>
         <163f852ba12fd9de5dec7c4a2d6b6c7cdb379ebc.camel@redhat.com>
         <20200922170526.GK32101@casper.infradead.org>
         <95bd1230f2fcf01f690770eb77696862b8fb607b.camel@redhat.com>
         <20200923024859.GM32101@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-09-23 at 03:48 +0100, Matthew Wilcox wrote:
> I'm out of ideas.  Maybe I'll wake up with a better idea in the morning.
> I've been trying to reproduce this on x86 with a 1kB block size
> filesystem, and haven't been able to yet.  Maybe I'll try to setup a
> powerpc cross-compilation environment tomorrow.

Another data point is that this can be reproduced on both arm64 and powerpc
(both have 64k-size pages) by running this LTP test case:

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/preadv2/preadv203.c

[ 2397.723289] preadv203 (80525): drop_caches: 3
[ 2400.796402] XFS (loop0): Unmounting Filesystem
[ 2401.431293] ------------[ cut here ]------------
[ 2401.431411] WARNING: CPU: 0 PID: 80501 at fs/iomap/buffered-io.c:78 iomap_page_release+0x250/0x270
[ 2401.431435] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_spapr_tce vfio vfio_spapr_eeh loop kvm_hv kvm ip_tables x_tables sd_mod bnx2x mdio ahci libahci tg3 libphy libata firmware_class dm_mirror dm_reg
ion_hash dm_log dm_mod
[ 2401.431534] CPU: 0 PID: 80501 Comm: preadv203 Not tainted 5.9.0-rc6-next-20200923+ #4
[ 2401.431567] NIP:  c000000000473b30 LR: c0000000004739ec CTR: c000000000473e80
[ 2401.431590] REGS: c0000011a7bbf7a0 TRAP: 0700   Not tainted  (5.9.0-rc6-next-20200923+)
[ 2401.431613] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 44000244  XER: 20040000
[ 2401.431655] CFAR: c000000000473a24 IRQMASK: 0 
               GPR00: c00000000029b6a8 c0000011a7bbfa30 c000000007e87e00 0000000000000005 
               GPR04: 0000000000000000 0000000000000005 0000000000000005 0000000000000000 
               GPR08: c00c000806f1f587 087fff8000000037 0000000000000001 c00000000875e028 
               GPR12: c000000000473e80 c00000000c180000 0000000000000000 0000000000000000 
               GPR16: 0000000000000000 c0000011a7bbfbb0 c0000011a7bbfbc0 0000000000000000 
               GPR20: c000000000a4aad8 0000000000000000 0000000000000000 000000000000000f 
               GPR24: ffffffffffffffff c0000011a7bbfb38 c0000011a7bbfac0 0000000000000000 
               GPR28: 0000000000000001 c000000ea4fe0a28 0000000000000000 c00c0008071b46c0 
[ 2401.431856] NIP [c000000000473b30] iomap_page_release+0x250/0x270
[ 2401.431878] LR [c0000000004739ec] iomap_page_release+0x10c/0x270
[ 2401.431899] Call Trace:
[ 2401.431926] [c0000011a7bbfa30] [c0000011a7bbfac0] 0xc0000011a7bbfac0 (unreliable)
[ 2401.431962] [c0000011a7bbfa70] [c00000000029b6a8] truncate_cleanup_page+0x188/0x2e0
[ 2401.431987] [c0000011a7bbfaa0] [c00000000029c62c] truncate_inode_pages_range+0x23c/0x9f0
[ 2401.432023] [c0000011a7bbfcc0] [c0000000003d9588] evict+0x1e8/0x200
[ 2401.432055] [c0000011a7bbfd00] [c0000000003c64b0] do_unlinkat+0x2d0/0x3a0
[ 2401.432081] [c0000011a7bbfdc0] [c00000000002a458] system_call_exception+0xf8/0x1d0
[ 2401.432097] [c0000011a7bbfe20] [c00000000000d0a8] system_call_common+0xe8/0x218
[ 2401.432120] Instruction dump:
[ 2401.432140] 3c82f8ba 388490b8 4be655b1 60000000 0fe00000 60000000 60000000 60000000 
[ 2401.432176] 0fe00000 4bfffea8 60000000 60000000 <0fe00000> 4bfffef4 60000000 60000000 
[ 2401.432213] CPU: 0 PID: 80501 Comm: preadv203 Not tainted 5.9.0-rc6-next-20200923+ #4
[ 2401.432245] Call Trace:
[ 2401.432255] [c0000011a7bbf590] [c000000000644778] dump_stack+0xec/0x144 (unreliable)
[ 2401.432284] [c0000011a7bbf5d0] [c0000000000b0a24] __warn+0xc4/0x144
[ 2401.432298] [c0000011a7bbf660] [c000000000643388] report_bug+0x108/0x1f0
[ 2401.432331] [c0000011a7bbf700] [c000000000021714] program_check_exception+0x104/0x2e0
[ 2401.432359] [c0000011a7bbf730] [c000000000009664] program_check_common_virt+0x2c4/0x310
[ 2401.432385] --- interrupt: 700 at iomap_page_release+0x250/0x270
                   LR = iomap_page_release+0x10c/0x270
[ 2401.432420] [c0000011a7bbfa30] [c0000011a7bbfac0] 0xc0000011a7bbfac0 (unreliable)
[ 2401.432446] [c0000011a7bbfa70] [c00000000029b6a8] truncate_cleanup_page+0x188/0x2e0
[ 2401.432470] [c0000011a7bbfaa0] [c00000000029c62c] truncate_inode_pages_range+0x23c/0x9f0
[ 2401.432505] [c0000011a7bbfcc0] [c0000000003d9588] evict+0x1e8/0x200
[ 2401.432528] [c0000011a7bbfd00] [c0000000003c64b0] do_unlinkat+0x2d0/0x3a0
[ 2401.432552] [c0000011a7bbfdc0] [c00000000002a458] system_call_exception+0xf8/0x1d0
[ 2401.432576] [c0000011a7bbfe20] [c00000000000d0a8] system_call_common+0xe8/0x218
[ 2401.432599] irq event stamp: 210662
[ 2401.432619] hardirqs last  enabled at (210661): [<c0000000008d32bc>] _raw_spin_unlock_irq+0x3c/0x70
[ 2401.432652] hardirqs last disabled at (210662): [<c00000000000965c>] program_check_common_virt+0x2bc/0x310
[ 2401.432688] softirqs last  enabled at (210280): [<c000000000547de4>] xfs_buf_find.isra.31+0xb54/0x1060
[ 2401.432722] softirqs last disabled at (210278): [<c0000000005476fc>] xfs_buf_find.isra.31+0x46c/0x1060


