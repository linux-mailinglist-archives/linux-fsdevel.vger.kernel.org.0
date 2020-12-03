Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4086E2CE17C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 23:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgLCWUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 17:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgLCWUM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:20:12 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCA9C061A51
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 14:19:32 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f16so3322738otl.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 14:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QIvdaXMerZjHKN16VIAknaqTSxjYn/RYpNcQZGlB0eM=;
        b=lqkpuDgPEmdoc2666gMa9RbwXHp9urjMEjXlMv/r516+5uWHSkWLdJrQOrUi/dLCY3
         WytTyd9zO8543c5RUqrF+D8FAOdOzmhAQ33L5+OoDxlyUo6yuB5mTN9lanUW3vU6iW80
         br/N7YjPVtGNfTQNwk2ShkWO92y58G2ZqZhW+0CRLpvLUBTTJ1T5HF9D++K+jB3LqgdV
         UUxOpE8g5qPxY78om6kXySy4HykQQnj5C92TrhqtBQk1oNm/Ag3KKIkR9o+MiScHAjkj
         rTMsxB+p9+/T/x+UEfLjSDy9LH0vDXXfxLTsL1XSYMQPf6k/SC9wpTEW4qzrVLiC6poB
         tkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QIvdaXMerZjHKN16VIAknaqTSxjYn/RYpNcQZGlB0eM=;
        b=US7oBgoVzacRgi7Vtx9R001E/yIWawZQewBCKgwmiVLCnFkMXCMj51Ve3wNfPJe/NQ
         veqn9pMiAV42poE1JS5BdqhJvKODx225avmOiFSDQne/HulJ9PF9OyFmFlVIQmLo/LbD
         C7s91yKdlnHybkLYzFC42dlsSPeJsxiXPcTZ0EjApGkue25rM2qg3PQNi9e0eQMRZ27k
         XCV2Ju0n+AhnzQ/J/8I9on94jMIy1NfeQLYoJapcKWseefyqQcKhK1+m3DLw+6L8O62r
         owDk5tFWhXk1OHLd5GbCsXm76LHwk3ZQrjD6fEU/jr/nSoiSlORa4PFR8pjeewSZrs4B
         3uyg==
X-Gm-Message-State: AOAM532GxS2Kc2IQDCUqqwwZ1ypFiwX3deakC73NmH3qvUOxZzuNqI7d
        qOg4tXnT3otP2MHOeMhDoX1ZlA==
X-Google-Smtp-Source: ABdhPJz+sexSHIB+05eqb2T1lZzhZyEx7yf1cjHtX9/Ed5S5Uku8jnBQFjK+/kyd4vQhQAGU1GWwig==
X-Received: by 2002:a9d:6312:: with SMTP id q18mr1194866otk.264.1607033971283;
        Thu, 03 Dec 2020 14:19:31 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t21sm172229otr.77.2020.12.03.14.19.29
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Dec 2020 14:19:30 -0800 (PST)
Date:   Thu, 3 Dec 2020 14:19:19 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Qian Cai <qcai@redhat.com>
cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
In-Reply-To: <e4616d748b2137d05376eb517b4c8d675bc11712.camel@redhat.com>
Message-ID: <alpine.LSU.2.11.2012031415090.13206@eggly.anvils>
References: <20201112212641.27837-1-willy@infradead.org> <alpine.LSU.2.11.2011160128001.1206@eggly.anvils> <20201117153947.GL29991@casper.infradead.org> <alpine.LSU.2.11.2011170820030.1014@eggly.anvils> <20201117191513.GV29991@casper.infradead.org>
 <20201117234302.GC29991@casper.infradead.org> <20201125023234.GH4327@casper.infradead.org> <bb95be97-2a50-b345-fc2c-3ff865b60e08@samsung.com> <CGME20201203172725eucas1p2fddec1d269c55095859d490942b78b93@eucas1p2.samsung.com> <0107bae8-baaa-9d39-5349-8174cb8abbbe@samsung.com>
 <e4616d748b2137d05376eb517b4c8d675bc11712.camel@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 3 Dec 2020, Qian Cai wrote:
> On Thu, 2020-12-03 at 18:27 +0100, Marek Szyprowski wrote:
> > On 03.12.2020 16:46, Marek Szyprowski wrote:
> > > On 25.11.2020 03:32, Matthew Wilcox wrote:
> > > > On Tue, Nov 17, 2020 at 11:43:02PM +0000, Matthew Wilcox wrote:
> > > > > On Tue, Nov 17, 2020 at 07:15:13PM +0000, Matthew Wilcox wrote:
> > > > > > I find both of these functions exceptionally confusing.  Does this
> > > > > > make it easier to understand?
> > > > > Never mind, this is buggy.  I'll send something better tomorrow.
> > > > That took a week, not a day.  *sigh*.  At least this is shorter.
> > > > 
> > > > commit 1a02863ce04fd325922d6c3db6d01e18d55f966b
> > > > Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Date:   Tue Nov 17 10:45:18 2020 -0500
> > > > 
> > > >      fix mm-truncateshmem-handle-truncates-that-split-thps.patch
> > > 
> > > This patch landed in todays linux-next (20201203) as commit 
> > > 8678b27f4b8b ("8678b27f4b8bfc130a13eb9e9f27171bcd8c0b3b"). Sadly it 
> > > breaks booting of ANY of my ARM 32bit test systems, which use initrd. 
> > > ARM64bit based systems boot fine. Here is example of the crash:
> > 
> > One more thing. Reverting those two:
> > 
> > 1b1aa968b0b6 mm-truncateshmem-handle-truncates-that-split-thps-fix-fix
> > 
> > 8678b27f4b8b mm-truncateshmem-handle-truncates-that-split-thps-fix
> > 
> > on top of linux next-20201203 fixes the boot issues.
> 
> We have to revert those two patches as well to fix this one process keeps
> running 100% CPU in find_get_entries() and all other threads are blocking on the
> i_mutex almost forever.
> 
> [  380.735099] INFO: task trinity-c58:2143 can't die for more than 125 seconds.
> [  380.742923] task:trinity-c58     state:R  running task     stack:26056 pid: 2143 ppid:  1914 flags:0x00004006
> [  380.753640] Call Trace:
> [  380.756811]  ? find_get_entries+0x339/0x790
> find_get_entry at mm/filemap.c:1848
> (inlined by) find_get_entries at mm/filemap.c:1904
> [  380.761723]  ? __lock_page_or_retry+0x3f0/0x3f0
> [  380.767009]  ? shmem_undo_range+0x3bf/0xb60
> [  380.771944]  ? unmap_mapping_pages+0x96/0x230
> [  380.777036]  ? find_held_lock+0x33/0x1c0
> [  380.781688]  ? shmem_write_begin+0x1b0/0x1b0
> [  380.786703]  ? unmap_mapping_pages+0xc2/0x230
> [  380.791796]  ? down_write+0xe0/0x150
> [  380.796114]  ? do_wp_page+0xc60/0xc60
> [  380.800507]  ? shmem_truncate_range+0x14/0x80
> [  380.805618]  ? shmem_setattr+0x827/0xc70
> [  380.810274]  ? notify_change+0x6cf/0xc30
> [  380.814941]  ? do_truncate+0xe2/0x180
> [  380.819335]  ? do_truncate+0xe2/0x180
> [  380.823741]  ? do_sys_openat2+0x5c0/0x5c0
> [  380.828484]  ? do_sys_ftruncate+0x2e2/0x4e0
> [  380.833417]  ? trace_hardirqs_on+0x1c/0x150
> [  380.838335]  ? do_syscall_64+0x33/0x40
> [  380.842828]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

Thanks for trinitizing.  If you have time, please would you try
replacing the shmem_undo_range() in mm/shmem.c by the version I gave in

https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2012031305070.12944@eggly.anvils/T/#mc15d60a2166f80fe284a18d4758eb4c04cc3255d

That will not help at all with the 32-bit booting issue,
but it does have a good chance of placating trinity.

Thanks,
Hugh
