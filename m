Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4B25ACB74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 08:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiIEGvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 02:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbiIEGvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:51:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6907533A3A;
        Sun,  4 Sep 2022 23:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662360684;
        bh=aCkUoDcz+0S/knsVOCXxVbUhZtdPXBPSlBS/nLiocmk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RfqCKAGhvLeg9HU1ZbdRUbfwpWjV0/KW453O1BJAnNkz504qTJv3W9sqRcgnT5fGw
         ZAbKo2O8HRnwr/LXuHKNznq6gVMCpj6Oiod1on5W81ppqphnhrX3ShnpAPJlgaJ0yu
         hc71+RhYAziCHVrX52IAZwfMgSaaTawtzyeUujjg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQnF-1oaKD01BwD-00GsRB; Mon, 05
 Sep 2022 08:51:24 +0200
Message-ID: <b2297d71-db55-6c5f-30b1-bec1cf7db29a@gmx.com>
Date:   Mon, 5 Sep 2022 14:51:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 01/17] block: export bio_split_rw
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-2-hch@lst.de>
 <de16bd58-3f14-01d9-9de5-6a79792c62c7@gmx.com> <20220905064431.GC2092@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220905064431.GC2092@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JxVaik9GDKTSmwUu2KAZe3jOV1fP7QJIYR8FQ8VfFwXg75yNfUZ
 9kZeChqnAP0zS/yrWrytNVBzC19vGldeQMRFor4BKdlMM0qFHFifgT8H3PZPTYCvAhngEYy
 2H/nIE7y0dI0/F3hZSh0TmWyIhsTOLnfIgH7FjZXNjKPnBwWNWjiyrOylbooLopR3S3/Aoa
 weo2eqk2Zb7UjyA6r67Jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JUH5FBdXMZI=:x7MiPWKVDRfQwq1ST8EYGI
 eSb/g722iTShJ7uCfF5m+uCcJiybCo5vRWKnlBhrJhhlEUNCk2iHXEepdEu+PPuYYtsK3BSi3
 MR7g8JQqaMQPOt9pgG81UA04OuglAlz/ohmKRdno7oCpAcahVpEzsVGwdFWRW/TyuYz4GmnJY
 zHbPFWZfU6Xhao/p/emey2vlng9E+Hw+Fsh9yjZi7q1hKUy0Id+AoXMfHt7Df7C+FaIrkg0UH
 nIBGSdqi+jIksNifbhMEtxDb7xUKZ4ajTFCgJd5aAgYCAx/ekegNsSj5p7OshNSzz5fpdvLVr
 7M3uuvtzHDcBicgCJovhZnJVkRvuA6Itex8XI7idND50MkYMbXyidqNIwHWsqQ8E8jOBqn7cz
 ddO9jAHDASdAtw6aXAzAcWzZ8TVBNtw13ajVH+zP/446JwdbKwhwDpLqIhoI/dW1Qs9ap/clk
 7OV9jJGA+ODWE7twPbpwZZfd9PsXB7DuCr/mxxHiyJeROafZ67xUT00C74A5QmjeigkTBYS+o
 Bl5KbAH/aJ/hHFNLc377huGOVqDGwitpNpu7LUSmYLKDT3eZvh6oabho78a5Gobl8JUa5VeWN
 UYBuqG1zRo213OH75x3yb0X2hrZlcmHeqmSS9pyhZpvf1FDn5S3xN6oe7b1FU1OuvEzEz86pg
 NTLIPYbWi1Xgd90HGPXWOLz6ZLOGxKZf481+yRu5XBtp/rvKBlG0t23MrPyJuTeq8rCCCJKIe
 x6gbeVaJeknCEd8FAJ0RIhvQVYUz+WqtF6vq4WXQGOWW83OfLSv8mr8ppORsNN8YbB5nyDKyB
 EQTMeL2A21bajdc2YG+ZCtj1nIMHnJ976fgrz9mHSQY0Fo86LxZH0Ks64MODYGNC9lDjftE+O
 zhTwuVJrdTTJySaeFABbELgbSo5E7Ea8woXP2KiDbvrHGWnP6DJVvnyIHuaPJsIL65CP6i46s
 P//Gj/4y0SgWqmAwp8r3/ygY9eW1kOa++kako8qdzPTk0n3idJnpqdn/5ItfDShHreIKa91eY
 FXvV7Oub2rCn8olPPntx4xkumKX7bV1ACV4g4CaZBVJcD01BN3hs7pOxAwsXxyTKm1C+l5NUT
 tvZ5xMGBsOAa/wJUxseUt0+0WIKlZwCe5oZOU4AsjSi6KY+rtoQEvP4TllVYVyQdvyBVckRqd
 8jp+oZyZJ999jBNuti2Wzl7Jw2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/9/5 14:44, Christoph Hellwig wrote:
> On Thu, Sep 01, 2022 at 04:54:32PM +0800, Qu Wenruo wrote:
>> I found the queue_limits structure pretty scary, while we only have ver=
y
>> limited members used in this case:
>>
>> - lim->virt_boundary_mask
>>    Used in bvec_gap_to_prev()
>>
>> - lim->max_segments
>>
>> - lim->seg_boundary_mask
>> - lim->max_segment_size
>>    Used in bvec_split_segs()
>>
>> - lim->logical_block_size
>>
>> Not familiar with block layer, thus I'm wondering do btrfs really need =
a
>> full queue_limits structure to call bio_split_rw().
>
> Well, the queue limits is what the block layer uses for communicating
> the I/O size limitations, and thus both bio_split_rw and the stacking
> layer helpers operate on it.
>
>> Or can we have a simplified wrapper?
>
> I don't think we can simplify anything here.  The alternative would
> be to open code the I/O path logic, which means a lot more code that
> needs to be maintained and has a high probability to get out of sync
> with the block layer logic.  So I'd much rather share this code
> between everything that stacks block devices, be that to represent
> another block device on the top like dm/md or for a 'direct' stacking
> in the file system like btrfs does.
>
>> IIRC inside btrfs we only need two cases for bio split:
>>
>> - Split for stripe boundary
>>
>> - Split for OE/zoned boundary
>
> No.  For zoned devices we all limitations for bio, basically all that
> you mentioned above.

OK, that explains the reason for the full queue_limits exported.

Then it makes sense to me now.

Thanks,
Qu
