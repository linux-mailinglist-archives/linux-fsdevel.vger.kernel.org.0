Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5EE6BCBEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 11:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCPKFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCPKFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:05:14 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A80BD307
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 03:05:00 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230316100457euoutp027a8228c9417d41a7624025130bd3619c~M3jkW7y071364713647euoutp02S
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 10:04:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230316100457euoutp027a8228c9417d41a7624025130bd3619c~M3jkW7y071364713647euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678961097;
        bh=TMw+9AyRMY3IpEST341SKDZ0elM1RO9CzU7qONouV+A=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=YX4BOjEIGa5SkSDCjGj3NjJHqbrC6YKuVp/tqCRke4afaJ2h0VhJKSv4JRN0RRYPD
         NcXoFtSseyJC4LJylb1VD/uIGToBT86s04Neo3HiyT2MhtZNOksmMYICSLjSB+WnqX
         uXYmTkELdYRv2AD6GUIPPU5rce50AFmoifBfqKbE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230316100457eucas1p144962f53096753a8192c0310fd9f7d97~M3jj-oK9M2167621676eucas1p1W;
        Thu, 16 Mar 2023 10:04:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 49.CB.10014.9C9E2146; Thu, 16
        Mar 2023 10:04:57 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230316100457eucas1p2977db74c92789e819c4c73317f416d6e~M3jjkJGy82873928739eucas1p2d;
        Thu, 16 Mar 2023 10:04:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230316100457eusmtrp2fc0d0830c89a8846340c35be075619d6~M3jjjW-AP1646716467eusmtrp2U;
        Thu, 16 Mar 2023 10:04:57 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-2e-6412e9c9ec2a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 26.98.08862.8C9E2146; Thu, 16
        Mar 2023 10:04:56 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230316100456eusmtip13efb4e34effca374a15e8f87a85445ec~M3jjTpQcJ0110101101eusmtip1W;
        Thu, 16 Mar 2023 10:04:56 +0000 (GMT)
Received: from [192.168.8.107] (106.210.248.172) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 16 Mar 2023 10:04:55 +0000
Message-ID: <d6cde35e-359a-e837-d2e0-f2bd362f2c3e@samsung.com>
Date:   Thu, 16 Mar 2023 11:04:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.8.0
Subject: Re: [RFC PATCH 1/3] filemap: convert page_endio to folio_endio
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     <hubcap@omnibond.com>, <senozhatsky@chromium.org>,
        <martin@omnibond.com>, <willy@infradead.org>, <minchan@kernel.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <axboe@kernel.dk>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <gost.dev@samsung.com>, <mcgrof@kernel.org>,
        <devel@lists.orangefs.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZBHcl8Pz2ULb4RGD@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djP87onXwqlGGz8I2IxZ/0aNovVd/vZ
        LF4f/sRosX/zFCaL0xMWMVm03+1jsth7S9tiz96TLBaXd81hs7i35j+rxcn1/5ktbkx4ymix
        7Ot7dovdGxexWZz/e5zV4vePOWwOAh6zGy6yeGxeoeVx+Wypx6ZVnWwemz5NYvc4MeM3i0fD
        1FtsHr9u32H1+LxJzmPTk7dMAVxRXDYpqTmZZalF+nYJXBlPXtxiL2iQrHh0MKmBsVOwi5GT
        Q0LARGL5oX3sXYxcHEICKxglZr78xAzhfGGUuL7kDztIlZDAZ0aJ7xMKYTr2vG5igyhazijR
        9fk7M1zRiVeSEIndjBJzl85mA0nwCthJ9O/4BDaJRUBV4lb3HmaIuKDEyZlPWLoYOThEBaIk
        XrwuAzGFBdwlPu7KA6lgFhCXuPVkPhOILSKgKXFreTvYccwCS5kldj1YzgRSzyagJdHYyQ5i
        cgroSsz6VA7RqinRuv03O4QtL7H97RxmiPOVJea83gFl10qc2nKLCWSkhMAjTokVG5pZIBIu
        End29zJC2MISr45vYYewZST+74S4R0KgWuLpjd/MEM0tjBL9O9ezgRwhIWAt0XcmB8J0lDg6
        WwPC5JO48VYQ4hw+iUnbpjNPYFSdhRQMs5A8PAvJB7OQfLCAkWUVo3hqaXFuemqxcV5quV5x
        Ym5xaV66XnJ+7iZGYAo8/e/41x2MK1591DvEyMTBeIhRgoNZSYQ3nEUgRYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjivtu3JZCGB9MSS1OzU1ILUIpgsEwenVANTPefjJ2wFmxm2PN79Vv2a0XOd
        q438+498PMjiO7mu3d+3Ka9fU/L0w/iu8DjmPs8v3OvnxjEo9qjJLeCblMfDrzWf49PvlLp1
        X/ZJfuIzDn3RlOP6xtNvxs3Lxi5t34u80t5N0ZLQ7/j6cn/mZl/JPcLznzNlH5T/vPB9xFGz
        H2kR0RVB2s+vCJddkbmheHH/gY/eAerPs/LfLL+pfPjHFvni5cb/ZmRHMbIUuS+aKDXrV2WL
        4EGPsnlq6gJFmQ+dnZ9M84hXn7bM5V23e9fD9ZnzF8+zmtL/3b1y/vsnb7aLHuQtOCLeE1rE
        dfbgyS6P59rSciZWmmcm+wq84W3dOql+z2Wl9lQdjvPSgbuVWIozEg21mIuKEwFYu4V+8AMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsVy+t/xu7onXgqlGFy7ZWIxZ/0aNovVd/vZ
        LF4f/sRosX/zFCaL0xMWMVm03+1jsth7S9tiz96TLBaXd81hs7i35j+rxcn1/5ktbkx4ymix
        7Ot7dovdGxexWZz/e5zV4vePOWwOAh6zGy6yeGxeoeVx+Wypx6ZVnWwemz5NYvc4MeM3i0fD
        1FtsHr9u32H1+LxJzmPTk7dMAVxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZG
        pkr6djYpqTmZZalF+nYJehlPXtxiL2iQrHh0MKmBsVOwi5GTQ0LARGLP6yY2EFtIYCmjxIXr
        +hBxGYlPVz6yQ9jCEn+udQHVcAHVfGSUeLCmmQmiYTejRNOpdBCbV8BOon/HJ7AGFgFViVvd
        e5gh4oISJ2c+YQGxRQWiJJ7eOQQU5+AQFnCX+LgrDyTMLCAucevJfLCRIgKaEreWtzOD7GIW
        WMws8WT9XCaIxY8YJZYem80I0swmoCXR2MkOYnIK6ErM+lQOMUdTonX7b3YIW15i+9s5zBD3
        K0vMeb0Dyq6V+Pz3GeMERtFZSK6bheSMWUhGzUIyagEjyypGkdTS4tz03GJDveLE3OLSvHS9
        5PzcTYzA5LHt2M/NOxjnvfqod4iRiYPxEKMEB7OSCG84i0CKEG9KYmVValF+fFFpTmrxIUZT
        YBBNZJYSTc4Hpq+8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQam
        zKXL2o5x3FFTrGAU9Dn4O8hzedQe7k8Z4S/ahBlFY2NTqjRMnnYyddW7NicJJb6s4HTv+uo8
        K+OVgUB8RFje1clqq6YdCX4xaY/exm+9IfVG33ct3XH7e1jbvr8Wc1/Enrj7yEZnRoPBhdN6
        /+04jrM2LmKXqgxI+mRzwUnVfJ6sw6qADfcUyiWm8M33Otuaq1K2ypipcv1Vjf/NCwJ7fJr7
        9v3gWzAhjG+ZxJXyLfWvWt+ev7bPe+nmPjWtT/Y7NkheOr5FYNfke767/jXPEBf8O/me5dR6
        rwf/X+WmxN/eJqjdLzuxf9flKvk/etPaIzT4i+Y8YM5dE/qcl/OwkMWMzOL6lkN5n2MkmvSV
        WIozEg21mIuKEwFKVlB5pwMAAA==
X-CMS-MailID: 20230316100457eucas1p2977db74c92789e819c4c73317f416d6e
X-Msg-Generator: CA
X-RootMTR: 20230315123234eucas1p2503d83ad0180cecde02e924d7b143535
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315123234eucas1p2503d83ad0180cecde02e924d7b143535
References: <20230315123233.121593-1-p.raghav@samsung.com>
        <CGME20230315123234eucas1p2503d83ad0180cecde02e924d7b143535@eucas1p2.samsung.com>
        <20230315123233.121593-2-p.raghav@samsung.com>
        <ZBHcl8Pz2ULb4RGD@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On 2023-03-15 15:56, Christoph Hellwig wrote:
> Can we take a step back and figure out if page_endio is a good
> idea to start with?
> 
> The zram usage seems clearly wrong to me.  zram is a block driver
> and does not own the pages, so it shouldn't touch any of the page
> state.  It seems like this mostly operates on it's own
> pages allocated using alloc_page so the harm might not be horrible
> at least.
> 
It looks like this endio function is called when alloc_page is used (for
partial IO) to trigger writeback from the user space `echo "idle" >
/sys/block/zram0/writeback`.

I don't understand when you say the harm might not be horrible if we don't
call folio_endio here. Do you think it is just safe to remove the call to
folio_endio function?

> orangefs uses it on readahead pages, with ret known for the whole
> iteration.  So one quick loop for the success and one for the
> failure case would look simpler an more obvious.
> 
Got it. Something like this?

@@ -266,18 +266,23 @@ static void orangefs_readahead(struct
readahead_control *rac)
        iov_iter_xarray(&iter, ITER_DEST, i_pages, offset,
readahead_length(rac));

        /* read in the pages. */
-       if ((ret = wait_for_direct_io(ORANGEFS_IO_READ, inode,
-                       &offset, &iter, readahead_length(rac),
-                       inode->i_size, NULL, NULL, rac->file)) < 0)
+       if ((ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &offset, &iter,
+                                     readahead_length(rac), inode->i_size,
+                                     NULL, NULL, rac->file)) < 0) {
                gossip_debug(GOSSIP_FILE_DEBUG,
-                       "%s: wait_for_direct_io failed. \n", __func__);
-       else
-               ret = 0;
+                            "%s: wait_for_direct_io failed. \n", __func__);

-       /* clean up. */
-       while ((page = readahead_page(rac))) {
-               page_endio(page, false, ret);
-               put_page(page);
+               while ((folio = readahead_folio(rac))) {
+                       folio_clear_uptodate(folio);
+                       folio_set_error(folio);
+                       folio_unlock(folio);
+               }
+               return;
+       }
+
+       while ((folio = readahead_folio(rac))) {
+               folio_mark_uptodate(folio);
+               folio_unlock(folio);
        }
 }

> mpage really should use separate end_io handler for read vs write
> as well like most other aops do.
> 

I don't know if this is the right abstraction to do the switch, but let me
know what you think:
@@ -59,7 +59,8 @@ static void mpage_end_io(struct bio *bio)
static struct bio *mpage_bio_submit(struct bio *bio)
 {
-       bio->bi_end_io = mpage_end_io;
+       bio->bi_end_io = (op_is_write(bio_op(bio))) ? mpage_write_end_io :
+                                                     mpage_read_end_io;
        guard_bio_eod(bio);
        submit_bio(bio);
        return NULL;
And mpage_{write,read}_end_io will iterate over the folio and call the
respective functions.

> So overall I'd be happier to just kill the helper.
