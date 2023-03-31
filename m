Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBABF6D1EE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 13:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjCaLT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 07:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjCaLT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:19:56 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911D1C1DB
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 04:19:54 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230331111951euoutp028a74e5db5fe5c543dec45f2108d0fc43~RfQPSb8BI2806328063euoutp02L
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 11:19:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230331111951euoutp028a74e5db5fe5c543dec45f2108d0fc43~RfQPSb8BI2806328063euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680261591;
        bh=rotXHmLJ+3RmVvig7nNDjJgCDFpn3JfHaBhmEOHV1xU=;
        h=Date:From:Subject:To:CC:In-Reply-To:References:From;
        b=AvRRY729uZ3p9BOnTZjG0mklUGgK5XB+IKF3dmfyY5XDjb39MYGjmQOAm49/+82gB
         9WtlEF7EpqRA9qgU2pF6dWQF93zQvcLCbuFwBoDFqYd3eX5bN5/GYzkEOO8iLXdURn
         yEWKU+bOWK1EdwpOm6GTukN/krDcvk/xbqvSwrFM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230331111950eucas1p20fd7a4a982cb8f666bb7d574d0950f24~RfQO6FUKT0705007050eucas1p2y;
        Fri, 31 Mar 2023 11:19:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3A.5A.09503.6D1C6246; Fri, 31
        Mar 2023 12:19:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230331111950eucas1p24613fe162e4c64b427fc13182914c84e~RfQOVp2I91172711727eucas1p2t;
        Fri, 31 Mar 2023 11:19:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230331111950eusmtrp289d12c6234d5114b90c0f2c48cde8703~RfQOU7ns72314123141eusmtrp2a;
        Fri, 31 Mar 2023 11:19:50 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-d9-6426c1d6a538
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FF.85.09583.6D1C6246; Fri, 31
        Mar 2023 12:19:50 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230331111950eusmtip22bed4ddfdecd2e651183996406d37c70~RfQOHI4Uw2857728577eusmtip2N;
        Fri, 31 Mar 2023 11:19:50 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 31 Mar 2023 12:19:48 +0100
Message-ID: <3b116359-d346-a63c-1a78-f95ad1912dfe@samsung.com>
Date:   Fri, 31 Mar 2023 13:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
From:   Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/5] zram: remove the call to page_endio in the bio
 end_io handler
To:     Minchan Kim <minchan@kernel.org>
CC:     <martin@omnibond.com>, <axboe@kernel.dk>,
        <akpm@linux-foundation.org>, <hubcap@omnibond.com>,
        <willy@infradead.org>, <viro@zeniv.linux.org.uk>,
        <senozhatsky@chromium.org>, <brauner@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <mcgrof@kernel.org>, <linux-block@vger.kernel.org>,
        <gost.dev@samsung.com>, <linux-mm@kvack.org>,
        <devel@lists.orangefs.org>, Christoph Hellwig <hch@lst.de>
Content-Language: en-US
In-Reply-To: <ZCYSincU0FlULyWJ@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djP87rXDqqlGPT2mVjMWb+GzWL13X42
        i9eHPzFa7N88hcli5eqjTBbtd/uYLPbe0rbYs/cki8XlXXPYLO6t+c9qcXL9f2aLGxOeMlos
        +/qe3WL3xkVsFuf/Hme1+P1jDpuDgMfshossHptXaHlcPlvqsWlVJ5vHpk+T2D1OzPjN4tEw
        9Rabx+6bDWwev27fYfX4vEnOY9OTt0wB3FFcNimpOZllqUX6dglcGct7jrIVzJCo+HLwGGsD
        4wuhLkYODgkBE4lDbRpdjFwcQgIrGCX+9K9nhXC+MEpcW3OQGcL5zCgx9dxMoAwnWMeZlhPs
        EInljBLP3y9AqFp7ZT5U/05GiW8t/9hAWngF7CRurHnACGKzCKhKXP45GyouKHFy5hMWEFtU
        IEqi7/YmVpCj2AS0JBo72UHCwgIREofebgdrFRFQkfjz9B8jyHxmgfXMEq/mdzOBJJgFxCVu
        PZkPZnMC9f5vWwsV15Ro3f6bHcKWl9j+dg4zxAuKEpNuvod6p1bi1JZbTCBDJQQ+cUrsPnOT
        BSLhItH8+hcjhC0s8er4FnYIW0bi/06IZRIC1RJPb/xmhmhuYZTo37meDRKs1hJ9Z3Igahwl
        Hm/fyQoR5pO48VYQ4h4+iUnbpjNPYFSdhRQUs5C8MwvJC7OQvLCAkWUVo3hqaXFuemqxYV5q
        uV5xYm5xaV66XnJ+7iZGYGI8/e/4px2Mc1991DvEyMTBeIhRgoNZSYS30Fg1RYg3JbGyKrUo
        P76oNCe1+BCjNAeLkjivtu3JZCGB9MSS1OzU1ILUIpgsEwenVAOTxfLryhr3K3vmX5eX0o50
        NpV9fvHmfal3IbflHoQ82Xq0uzVL1HKxovWLfWphIekP57zckqotdvOPZv1+u/wrx0wu65e9
        uxW9/NZW2/5vTzbHHtV7x/jXPVW+MrQ+X3Mdx/mnvu57JTKXzFz56f992TNBYTl5DMlbP2oY
        rnzDWLM/eGdlzIec7tp3jinBh86qquYeFFDINbn7bFprFMdzOZ2fje/MhJUSqr3V93Jxhs3P
        mns8b8NVC8ud1+MTmiq8laNaruYEr/k9JfhISfTpkjeLlj22er1o0qJE3cL5JzntM3cUPFZf
        uOWx3Q2TLTN9FXv+cydJ6B3ZXKPX+OFSY4GEos/c/U9jo9782PNOiaU4I9FQi7moOBEAQgNM
        2PsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsVy+t/xe7rXDqqlGNxdymsxZ/0aNovVd/vZ
        LF4f/sRosX/zFCaLlauPMlm03+1jsth7S9tiz96TLBaXd81hs7i35j+rxcn1/5ktbkx4ymix
        7Ot7dovdGxexWZz/e5zV4vePOWwOAh6zGy6yeGxeoeVx+Wypx6ZVnWwemz5NYvc4MeM3i0fD
        1FtsHrtvNrB5/Lp9h9Xj8yY5j01P3jIFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZ
        GpvHWhmZKunb2aSk5mSWpRbp2yXoZSzvOcpWMEOi4svBY6wNjC+Euhg5OSQETCTOtJxgB7GF
        BJYyStz+ZwwRl5H4dOUjO4QtLPHnWhdbFyMXUM1HRokVWyawQDg7GSW61m5iBKniFbCTuLHm
        AZjNIqAqcfnnbDaIuKDEyZlPWEBsUYEoic8HWoCmcnCwCWhJNHaCLRAWiJBYOmEqM4gtIqAi
        8efpP0aQ+cwC65klXs3vZoJYdptR4vW2K2BDmQXEJW49mc8EYnMCDfrftpYJIq4p0br9NzuE
        LS+x/e0cZogXFCUm3XzPCmHXSnz++4xxAqPoLCT3zUIydhaSUbOQjFrAyLKKUSS1tDg3PbfY
        SK84Mbe4NC9dLzk/dxMjMJ1sO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMJbaKyaIsSbklhZlVqU
        H19UmpNafIjRFBhIE5mlRJPzgQktryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUg
        tQimj4mDU6qBSSpjwktRzxjNpadr/3tNfdRfs3X6a56jcR0LWBdnnplclO3S3fT/3am+pnOb
        RXcumTYp9QjTwsdPX8gvahDUqbi2SbWV1Ux8PXPmfskJ7NZfAze3z29MPOUySbevff+K9TOb
        l0/fJ787OobxyhzX5QvZYicrhWet+3p8mfU8Fdfawo1feLzt583zDivWSX87j//ccr88mUTl
        lwG6k82mPJdau/LRL7V1U4oPSU7NnyDUGH+OV4Nz/rv5a5WLFPZe/bF68X/GtmsFs7ec2Xau
        esczi87QyTNOfov50RgdzXew5JfJQd+Vs/Tlb89wurzpgdn3/dr+Cd2xBXLHfv/+WZ4UfPqS
        YMW/kumNB2qm6XUpsRRnJBpqMRcVJwIApiMYd7ADAAA=
X-CMS-MailID: 20230331111950eucas1p24613fe162e4c64b427fc13182914c84e
X-Msg-Generator: CA
X-RootMTR: 20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1
References: <20230328112716.50120-1-p.raghav@samsung.com>
        <CGME20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1@eucas1p2.samsung.com>
        <20230328112716.50120-2-p.raghav@samsung.com> <ZCYSincU0FlULyWJ@google.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-31 00:51, Minchan Kim wrote:
> On Tue, Mar 28, 2023 at 01:27:12PM +0200, Pankaj Raghav wrote:
>> zram_page_end_io function is called when alloc_page is used (for
>> partial IO) to trigger writeback from the user space. The pages used for
> 
> No, it was used with zram_rw_page since rw_page didn't carry the bio.
> 
>> this operation is never locked or have the writeback set. So, it is safe
> 
> VM had the page lock and wait to unlock.
> 
>> to remove the call to page_endio() function that unlocks or marks
>> writeback end on the page.
>>
>> Rename the endio handler from zram_page_end_io to zram_read_end_io as
>> the call to page_endio() is removed and to associate the callback to the
>> operation it is used in.
> 

I revisited the code again. Let me know if I got it right.

When we trigger writeback, we will always call zram_bvec_read() only if
ZRAM_WB is not set. That means we will only call zram_read_from_zspool() in
__zram_bvec_read when parent bio set to NULL.

static ssize_t writeback_store(struct device *dev, ...
{
if (zram_test_flag(zram, index, ZRAM_WB) ||
                   zram_test_flag(zram, index, ZRAM_SAME) ||
                   zram_test_flag(zram, index, ZRAM_UNDER_WB))
           goto next;
...
if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
...
}

static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
			    struct bio *bio, bool partial_io)
{
....
if (!zram_test_flag(zram, index, ZRAM_WB)) {
        /* Slot should be locked through out the function call */
        ret = zram_read_from_zspool(zram, page, index);
        zram_slot_unlock(zram, index);
} else {
        /* Slot should be unlocked before the function call */
        zram_slot_unlock(zram, index);

        ret = zram_bvec_read_from_bdev(zram, page, index, bio,
                                       partial_io);
}
....
}

> Since zram removed the rw_page and IO comes with bio from now on,
> IIUC, we are fine since every IO will go with chained-IO. Right?
>

We will never call zram_bvec_read_from_bdev() with parent bio set to NULL. IOW, we will always
only hit the bio_chain case in read_from_bdev_async. So we could do the following?:

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b7bb52f8dfbd..2341f4009b0f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -606,15 +606,6 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 	atomic64_dec(&zram->stats.bd_count);
 }

-static void zram_page_end_io(struct bio *bio)
-{
-	struct page *page = bio_first_page_all(bio);
-
-	page_endio(page, op_is_write(bio_op(bio)),
-			blk_status_to_errno(bio->bi_status));
-	bio_put(bio);
-}
-
 /*
  * Returns 1 if the submission is successful.
  */
@@ -634,9 +625,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 		return -EIO;
 	}

-	if (!parent)
-		bio->bi_end_io = zram_page_end_io;
-	else
+	if (parent)
 		bio_chain(bio, parent);

 	submit_bio(bio);
