Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BED6E1AF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 06:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjDNEHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 00:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDNEHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:07:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2B4EE0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 21:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tv+CDHQFvPKKZxgkjLcvB69sMHqucHbBd3BQ0wZ/t0M=; b=F/IwI1ymt2MmhmHHJUgmZLoaHl
        c7g/JlW+QqBmLS8XETO0uMxvg1smjIXRN9UQJxKpYCHincZDcXe8FiLJoqWqMssCy8zWW7LMYr9dK
        4G84jtRC8IgV2aNFsos1C2Nu7bljSFgk5ddEqUx+ev93GFr8nfJdD1m9DxyImrQfKVKXuZNYe1RFw
        SuPZ47PY5St/jUezOFqeGvm4/4t0/iJ5NnS7ArBH7qAYNFbNcp2qSj3NKnWFfVx6txntW93gYftNZ
        aISMSjBOEbedQ9JjTs/1rcpSk/8H3KmW8scYVcksWvYRPKutQPXPF7W8A0eeANzO4uwP2uis4JVMy
        UBejYs+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnAiJ-008Qwi-Gw; Fri, 14 Apr 2023 04:07:07 +0000
Date:   Fri, 14 Apr 2023 05:07:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: sequential 1MB mmap read ends in 1 page sync read-ahead
Message-ID: <ZDjRayNGU1zYn1pw@casper.infradead.org>
References: <aae918da-833f-7ec5-ac8a-115d66d80d0e@fastmail.fm>
 <df5c4698-46e1-cbfe-b1f6-cc054b12f6fe@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df5c4698-46e1-cbfe-b1f6-cc054b12f6fe@fastmail.fm>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:33:09PM +0200, Bernd Schubert wrote:
> Sorry, forgot to add Andrew and linux-mm into CC.
> 
> On 4/13/23 23:27, Bernd Schubert wrote:
> > Hello,
> > 
> > I found a weird mmap read behavior while benchmarking the fuse-uring
> > patches.
> > I did not verify yet, but it does not look fuse specific.
> > Basically, I started to check because fio results were much lower
> > than expected (better with the new code, though)
> > 
> > fio cmd line:
> > fio --size=1G --numjobs=1 --ioengine=mmap --output-format=normal,terse
> > --directory=/scratch/dest/ --rw=read multi-file.fio
> > 
> > 
> > bernd@squeeze1 test2>cat multi-file.fio
> > [global]
> > group_reporting
> > bs=1M
> > runtime=300
> > 
> > [test]
> > 
> > This sequential fio sets POSIX_MADV_SEQUENTIAL and then does memcpy
> > beginning at offset 0 in 1MB steps (verified with additional
> > logging in fios engines/mmap.c).
> > 
> > And additional log in fuse_readahead() gives
> > 
> > [ 1396.215084] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64
> > index=0
> > [ 1396.237466] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64
> > index=255
> > [ 1396.263175] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1
> > index=254
> > [ 1396.282055] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1
> > index=253
> > ... <count is always 1 page>
> > [ 1496.353745] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1
> > index=64
> > [ 1496.381105] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64
> > index=511
> > [ 1496.397487] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1
> > index=510
> > [ 1496.416385] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1
> > index=509
> > ... <count is always 1 page>
> > 
> > Logging in do_sync_mmap_readahead()
> > 
> > [ 1493.130764] do_sync_mmap_readahead:3015 ino=132 index=0 count=0
> > ras_start=0 ras_size=0 ras_async=0 ras_ra_pages=64 ras_mmap_miss=0
> > ras_prev_pos=-1
> > [ 1493.147173] do_sync_mmap_readahead:3015 ino=132 index=255 count=0
> > ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0
> > ras_prev_pos=-1
> > [ 1493.165952] do_sync_mmap_readahead:3015 ino=132 index=254 count=0
> > ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0
> > ras_prev_pos=-1
> > [ 1493.185566] do_sync_mmap_readahead:3015 ino=132 index=253 count=0
> > ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0
> > ras_prev_pos=-1
> > ...
> > [ 1496.341890] do_sync_mmap_readahead:3015 ino=132 index=64 count=0
> > ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0
> > ras_prev_pos=-1
> > [ 1496.361385] do_sync_mmap_readahead:3015 ino=132 index=511 count=0
> > ras_start=96 ras_size=64 ras_async=64 ras_ra_pages=64 ras_mmap_miss=0
> > ras_prev_pos=-1
> > 
> > 
> > So we can see from fuse that it starts to read at page index 0, wants
> > 64 pages (which is actually the double of bdi read_ahead_kb), then
> > skips index 64...254) and immediately goes to index 255. For the mmaped
> > memcpy pages are missing and then it goes back in 1 page steps to get
> > these.
> > 
> > A workaround here is to set read_ahead_kb in the bdi to a larger
> > value, another workaround might be (untested) to increase the read-ahead
> > window. Either of these two seem to be workarounds for the index order
> > above.
> > 
> > I understand that read-ahead gets limited by the bdi value (although
> > exceeded above), but why does it go back in 1 page steps? My expectation
> > would have been
> > 
> > index=0  count=32 (128kb read-head)
> > index=32 count=32
> > index=64 count=32

What I see with XFS is:

             fio-27518   [005] .....   276.565025: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x23a8c ofs=0 order=2
             fio-27518   [005] .....   276.565035: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x19868 ofs=16384 order=2
             fio-27518   [005] .....   276.565036: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x237fc ofs=32768 order=2
             fio-27518   [005] .....   276.565038: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x27518 ofs=49152 order=2
             fio-27518   [005] .....   276.565039: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x14c7c ofs=65536 order=2
             fio-27518   [005] .....   276.565040: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x14338 ofs=81920 order=2
             fio-27518   [005] .....   276.565041: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x201fc ofs=98304 order=2
             fio-27518   [005] .....   276.565042: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x1fb98 ofs=114688 order=2
             fio-27518   [005] .....   276.565044: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x14510 ofs=131072 order=2
             fio-27518   [005] .....   276.565045: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x1e88c ofs=147456 order=2
             fio-27518   [005] .....   276.565046: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x26f00 ofs=163840 order=2

...

 dev 8:32 ino 44 pfn=0x14f30 ofs=262144 order=4
             fio-27518   [005] .....   276.567718: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x145a0 ofs=327680 order=4
             fio-27518   [005] .....   276.567720: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x15730 ofs=393216 order=4
             fio-27518   [005] .....   276.567722: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x15e30 ofs=458752 order=4
             fio-27518   [005] .....   276.567942: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x18b00 ofs=524288 order=6
             fio-27518   [005] .....   276.569982: mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x15e40 ofs=786432 order=6

... it then gets "stuck" at order-6, which is expected for a 256kB
readahead window.

This is produced by:

echo 1 >/sys/kernel/tracing/events/filemap/mm_filemap_add_to_page_cache/enable
fio --size=1G --numjobs=1 --ioengine=mmap --output-format=normal,terse --directory=/mnt/scratch/ --rw=read multi-file.fio
echo 0 >/sys/kernel/tracing/events/filemap/mm_filemap_add_to_page_cache/enable
less /sys/kernel/tracing/trace

