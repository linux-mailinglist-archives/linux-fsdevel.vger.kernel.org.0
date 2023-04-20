Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628446E93A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 14:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjDTMFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjDTMFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:05:48 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF13C22
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 05:05:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230420120539euoutp02e0f1ac4615d13e4d07c5aa8baf7786ec~Xox77qCjr3221032210euoutp02O
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 12:05:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230420120539euoutp02e0f1ac4615d13e4d07c5aa8baf7786ec~Xox77qCjr3221032210euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681992339;
        bh=PDAHfvBURb1vh6jKBSw1+E6vaJyw6Ln5c2y6xwyycZ4=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=GnQNPB2z5gpo8EO0KbEHQzJeikaiDJRyEEmeATXMpv86KDN1TQ79+FH9ZRxJ/tZXA
         IoLlUlp7E7XNpmkuSICbZge6SN46I/J8BMaVA04mmhNyi+EP5ux8b/B0u+wMVgy4g0
         h1dllHIqPfdegMMBBjD44guJiHe8uMsiYNGT3jQI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230420120539eucas1p16cdf70087eadbb8f6aa9b42c4b0711ec~Xox7t3BvL3016130161eucas1p1c;
        Thu, 20 Apr 2023 12:05:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 98.C1.10014.29A21446; Thu, 20
        Apr 2023 13:05:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230420120538eucas1p14eed4e1e9d3df62a8c32a60a6bc7beec~Xox7aWVsw2494324943eucas1p1M;
        Thu, 20 Apr 2023 12:05:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230420120538eusmtrp155a17801edb085695cebf63a07c62bd3~Xox7Z0xaz1835018350eusmtrp1Q;
        Thu, 20 Apr 2023 12:05:38 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-29-64412a92d579
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D4.D1.34412.29A21446; Thu, 20
        Apr 2023 13:05:38 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230420120538eusmtip2f5c04ecf9eaf72deaaa633ab8c98897b~Xox7NyEKA2584925849eusmtip2I;
        Thu, 20 Apr 2023 12:05:38 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 20 Apr 2023 13:05:37 +0100
Message-ID: <2466fa23-a817-1dee-b89f-fcbeaca94a9e@samsung.com>
Date:   Thu, 20 Apr 2023 14:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH] mm/filemap: allocate folios according to the blocksize
To:     Hannes Reinecke <hare@suse.de>
CC:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mcgrof@kernel.org>, SSDR Gost Dev <gost.dev@samsung.com>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230414134908.103932-1-hare@suse.de>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOd1JWo4pBlc7rCz2LJrEZLFn70kW
        i8u75rBZ3JjwlNHi9485bA6sHptXaHlsWtXJ5rH5dLXH501yASxRXDYpqTmZZalF+nYJXBmP
        FrxgLDgsU3Fq+2amBsbTol2MnBwSAiYSbft/MXcxcnEICaxglHjZs5MRwvnCKPF132wo5zOj
        xNKd65lgWl5s2ckOkVjOKPFl1i5muKot88+xQjg7GSVmnPkK1sIrYCex5/s2RhCbRUBVYkpL
        GxtEXFDi5MwnLCC2qEC0xOJ9U8BsYQFviUP7e8HqRQSUJD62HwJbxwxy4dOOfewgCWYBcYlb
        T+YDLeDgYBPQkmjsBAtzChhLvDx7jRWiRF5i+9s5zBBnK0pMuvmeFcKulTi15RYTyEwJgRcc
        Ej1bnjBCJFwk9j+Zxw5hC0u8Or4FypaROD25hwXCrpZ4euM3M0RzC6NE/871bCBHSAhYS/Sd
        yQExmQU0Jdbv0oeIOkoc+aEEYfJJ3HgrCHEZn8SkbdOZJzCqzkIKiFlI/pqF5IFZCDMXMLKs
        YhRPLS3OTU8tNs5LLdcrTswtLs1L10vOz93ECEwxp/8d/7qDccWrj3qHGJk4GA8xSnAwK4nw
        nnG1ShHiTUmsrEotyo8vKs1JLT7EKM3BoiTOq217MllIID2xJDU7NbUgtQgmy8TBKdXA1HVd
        U+ja5YgOs5shdxLnX+Tw9+TnNZ3m/30Ns8F8g2+zqvaLnb6p8PHmsikdLccjmeLXnl7379/6
        9y4nVvad+vptZqoT17QHjLoOaaurTpWZPvz+Tlg78Vj9i/nGN5esk1glKRhfz63w3fNw1Tab
        9SfNDWI877s3cxxRmbny7MKsf4mrG14clfyy/KxL2TlnBu5Drw7orbC9sHvh3coay7XZ6z+k
        qk+dvHBRvsUqQ8eJaxcekWjI5V9w1djVPPdgyBEhBtU8Xr6gZ7EPgsUnXzyQ+IFjnpCVo4aB
        /mJ5l3cn1u8O6lkot3zpL7G5h23CpD+7T1TUNXmrO1NFeuIchXvFX2bc0bohdztq56aZV/Yq
        sRRnJBpqMRcVJwIAwTOh5KADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7qTtBxTDOb0aFjsWTSJyWLP3pMs
        Fpd3zWGzuDHhKaPF7x9z2BxYPTav0PLYtKqTzWPz6WqPz5vkAlii9GyK8ktLUhUy8otLbJWi
        DS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIeLXjBWHBYpuLU9s1MDYynRbsY
        OTkkBEwkXmzZyd7FyMUhJLCUUWLu3zXMEAkZiY1frrJC2MISf651sUEUfWSUePm2kRXC2cko
        sfbFRSaQKl4BO4k937cxgtgsAqoSU1ra2CDighInZz5hAbFFBaIlbiz/BlYvLOAtcWh/L1i9
        iICSxMf2Q2BnMAusYJR42rEP6qY2Rom3uxrAJjELiEvcejIfqJuDg01AS6Kxkx0kzClgLPHy
        7DVWiBJNidbtv9khbHmJ7W/nQL2jKDHp5nuod2olPv99xjiBUXQWkvtmIdkwC8moWUhGLWBk
        WcUoklpanJueW2ykV5yYW1yal66XnJ+7iREYn9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8J5x
        tUoR4k1JrKxKLcqPLyrNSS0+xGgKDKSJzFKiyfnABJFXEm9oZmBqaGJmaWBqaWasJM7rWdCR
        KCSQnliSmp2aWpBaBNPHxMEp1cAUHnQo/sw6UaOtfqs8FryL+ynttH0Ki578q6wDdXIseYe7
        ew7OU5b5/CF4z2557mfFAjmXdx154dS3MD/SJ1JOZHpExxWNjiDNVynJ8/dLnVGWa9RpuLD/
        wsfMvo0zf0nunzPJVCLJT953Y/t+zc+8z1pSLuxKd0pVl/ZyjyuZu+szq6a56Jpt7u4d907u
        u9O7P9nGovnZKTnpTSISrfEr3oRd/PLHcI3YF4PQZkmeF4XVXy/NO8f1J+u3SLbDCZcj23aU
        f12yb3LFeZ3e53rzv2zJ1ysxmKZ7tVT8gjVP0tmPyzQyzHt+J015a3X1274b3Vo5xr+KfHh/
        8B4+sGqX/eUu/awFbl8nWtbcuHtAiaU4I9FQi7moOBEAsgsPXlgDAAA=
X-CMS-MailID: 20230420120538eucas1p14eed4e1e9d3df62a8c32a60a6bc7beec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230414134914eucas1p1f0b08409dce8bc946057d0a4fa7f1601
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230414134914eucas1p1f0b08409dce8bc946057d0a4fa7f1601
References: <CGME20230414134914eucas1p1f0b08409dce8bc946057d0a4fa7f1601@eucas1p1.samsung.com>
        <20230414134908.103932-1-hare@suse.de>
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To keep this thread alive and get some direction on the next steps, I made some changes
with which I am able to do **buffered reads** with fio on brd with logical block size > 4k.

Along with your patches (this patch and the brd patches), I added the following diff:

diff --git a/fs/mpage.c b/fs/mpage.c
index 242e213ee064..2e0c066d72d3 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -161,7 +161,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
        struct folio *folio = args->folio;
        struct inode *inode = folio->mapping->host;
        const unsigned blkbits = inode->i_blkbits;
-       const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
+       const unsigned blocks_per_page = folio_size(folio) >> blkbits;
        const unsigned blocksize = 1 << blkbits;
        struct buffer_head *map_bh = &args->map_bh;
        sector_t block_in_file;
diff --git a/mm/readahead.c b/mm/readahead.c
index 47afbca1d122..2e42b5127f4c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -210,7 +210,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
        unsigned long index = readahead_index(ractl);
        gfp_t gfp_mask = readahead_gfp_mask(mapping);
        unsigned long i;
-
+       int order = 0;
        /*
         * Partway through the readahead operation, we will have added
         * locked pages to the page cache, but will not yet have submitted
@@ -223,6 +223,9 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
         */
        unsigned int nofs = memalloc_nofs_save();

+       if (mapping->host->i_blkbits > PAGE_SHIFT)
+               order = mapping->host->i_blkbits - PAGE_SHIFT;
+
        filemap_invalidate_lock_shared(mapping);
        /*
         * Preallocate as many pages as we will need.
@@ -245,7 +248,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
                        continue;
                }

-               folio = filemap_alloc_folio(gfp_mask, 0);
+               folio = filemap_alloc_folio(gfp_mask, order);
                if (!folio)
                        break;
                if (filemap_add_folio(mapping, folio, index + i,
@@ -259,7 +262,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
                if (i == nr_to_read - lookahead_size)
                        folio_set_readahead(folio);
                ractl->_workingset |= folio_test_workingset(folio);
-               ractl->_nr_pages++;
+               ractl->_nr_pages += folio_nr_pages(folio);
        }


And with that (drum roll):

root@debian:~# cat /sys/block/ram0/queue/logical_block_size
8192
root@debian:~# fio -bs=8k -iodepth=8 -rw=read -ioengine=io_uring -size=200M -name=io_uring_1
-filename=/dev/ram0
io_uring_1: (g=0): rw=read, bs=(R) 8192B-8192B, (W) 8192B-8192B, (T) 8192B-8192B, ioengine=io_uring,
iodepth=8
fio-3.33
Starting 1 process

io_uring_1: (groupid=0, jobs=1): err= 0: pid=450: Thu Apr 20 11:34:10 2023
  read: IOPS=94.8k, BW=741MiB/s (777MB/s)(40.0MiB/54msec)

<snip>

Run status group 0 (all jobs):
   READ: bw=741MiB/s (777MB/s), 741MiB/s-741MiB/s (777MB/s-777MB/s), io=40.0MiB (41.9MB), run=54-54msec

Disk stats (read/write):
  ram0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%


**Questions on the future work**:

As willy pointed out, we have to do this `order = mapping->host->i_blkbits - PAGE_SHIFT` in
many places. Should we pursue something that willy suggested: encapsulating order in the
mapping->flags as a next step?[1]


[1] https://lore.kernel.org/lkml/ZDty+PQfHkrGBojn@casper.infradead.org/
