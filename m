Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89D02CE0BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 22:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501985AbgLCV2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 16:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2501902AbgLCV2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607030829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H7Mm/6EXCVJ8tG/xaBGfr+cnnz3Hg2rwH1kgaolaAUc=;
        b=FB9ln8cTapSN/ufc1f0oaYVmye2WKPfJql+TM4y7T1qCRVikiPQgFXe3F5/JSfUYoqdzs/
        Gbma6pu4yidD9zcy9HnN4RWp5pk0uVbDhccAI6gAlx+t6ljZoOQ8tE8bSxMO+Fljp2AdVf
        kZJMwVHXfq8iUrO/61KsrOuXqDQ1GDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-lBCaUBWVN2O19EkBkV9yEg-1; Thu, 03 Dec 2020 16:27:05 -0500
X-MC-Unique: lBCaUBWVN2O19EkBkV9yEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A4FF800D55;
        Thu,  3 Dec 2020 21:27:03 +0000 (UTC)
Received: from ovpn-66-132.rdu2.redhat.com (unknown [10.10.67.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE4619C46;
        Thu,  3 Dec 2020 21:27:01 +0000 (UTC)
Message-ID: <e4616d748b2137d05376eb517b4c8d675bc11712.camel@redhat.com>
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
From:   Qian Cai <qcai@redhat.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Date:   Thu, 03 Dec 2020 16:27:01 -0500
In-Reply-To: <0107bae8-baaa-9d39-5349-8174cb8abbbe@samsung.com>
References: <20201112212641.27837-1-willy@infradead.org>
         <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
         <20201117153947.GL29991@casper.infradead.org>
         <alpine.LSU.2.11.2011170820030.1014@eggly.anvils>
         <20201117191513.GV29991@casper.infradead.org>
         <20201117234302.GC29991@casper.infradead.org>
         <20201125023234.GH4327@casper.infradead.org>
         <bb95be97-2a50-b345-fc2c-3ff865b60e08@samsung.com>
         <CGME20201203172725eucas1p2fddec1d269c55095859d490942b78b93@eucas1p2.samsung.com>
         <0107bae8-baaa-9d39-5349-8174cb8abbbe@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-12-03 at 18:27 +0100, Marek Szyprowski wrote:
> Hi
> 
> On 03.12.2020 16:46, Marek Szyprowski wrote:
> > On 25.11.2020 03:32, Matthew Wilcox wrote:
> > > On Tue, Nov 17, 2020 at 11:43:02PM +0000, Matthew Wilcox wrote:
> > > > On Tue, Nov 17, 2020 at 07:15:13PM +0000, Matthew Wilcox wrote:
> > > > > I find both of these functions exceptionally confusing.  Does this
> > > > > make it easier to understand?
> > > > Never mind, this is buggy.  I'll send something better tomorrow.
> > > That took a week, not a day.  *sigh*.  At least this is shorter.
> > > 
> > > commit 1a02863ce04fd325922d6c3db6d01e18d55f966b
> > > Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Date:   Tue Nov 17 10:45:18 2020 -0500
> > > 
> > >      fix mm-truncateshmem-handle-truncates-that-split-thps.patch
> > 
> > This patch landed in todays linux-next (20201203) as commit 
> > 8678b27f4b8b ("8678b27f4b8bfc130a13eb9e9f27171bcd8c0b3b"). Sadly it 
> > breaks booting of ANY of my ARM 32bit test systems, which use initrd. 
> > ARM64bit based systems boot fine. Here is example of the crash:
> 
> One more thing. Reverting those two:
> 
> 1b1aa968b0b6 mm-truncateshmem-handle-truncates-that-split-thps-fix-fix
> 
> 8678b27f4b8b mm-truncateshmem-handle-truncates-that-split-thps-fix
> 
> on top of linux next-20201203 fixes the boot issues.

We have to revert those two patches as well to fix this one process keeps
running 100% CPU in find_get_entries() and all other threads are blocking on the
i_mutex almost forever.

[  380.735099] INFO: task trinity-c58:2143 can't die for more than 125 seconds.
[  380.742923] task:trinity-c58     state:R  running task     stack:26056 pid: 2143 ppid:  1914 flags:0x00004006
[  380.753640] Call Trace:
[  380.756811]  ? find_get_entries+0x339/0x790
find_get_entry at mm/filemap.c:1848
(inlined by) find_get_entries at mm/filemap.c:1904
[  380.761723]  ? __lock_page_or_retry+0x3f0/0x3f0
[  380.767009]  ? shmem_undo_range+0x3bf/0xb60
[  380.771944]  ? unmap_mapping_pages+0x96/0x230
[  380.777036]  ? find_held_lock+0x33/0x1c0
[  380.781688]  ? shmem_write_begin+0x1b0/0x1b0
[  380.786703]  ? unmap_mapping_pages+0xc2/0x230
[  380.791796]  ? down_write+0xe0/0x150
[  380.796114]  ? do_wp_page+0xc60/0xc60
[  380.800507]  ? shmem_truncate_range+0x14/0x80
[  380.805618]  ? shmem_setattr+0x827/0xc70
[  380.810274]  ? notify_change+0x6cf/0xc30
[  380.814941]  ? do_truncate+0xe2/0x180
[  380.819335]  ? do_truncate+0xe2/0x180
[  380.823741]  ? do_sys_openat2+0x5c0/0x5c0
[  380.828484]  ? do_sys_ftruncate+0x2e2/0x4e0
[  380.833417]  ? trace_hardirqs_on+0x1c/0x150
[  380.838335]  ? do_syscall_64+0x33/0x40
[  380.842828]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  380.848870]

