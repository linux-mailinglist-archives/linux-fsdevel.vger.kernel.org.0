Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9075B63A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 00:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiILWYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 18:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiILWYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:24:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEDE65F1;
        Mon, 12 Sep 2022 15:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663021436;
        bh=dVYey6kX8HxM0ATJ7S2IOLNNMkzqjNlLh6p6O+I09XY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=S0glBTIY8L2NP9l24Fv/nKR1VzAJeQnaLF0Oa54qSeh8Q4gnCPSvwQZjXiZiEN5RV
         J1uBswZjjrVLgdBxDtBeAzXpRVlrxusc+yIvBHFv80WPOOq1Bnf/O+RnE/RNEKATSU
         kdwEw3crfczPYRP+w25cr8qRg0n2rM8nWh3a+EqE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt757-1pM80o1pnd-00tXXT; Tue, 13
 Sep 2022 00:23:56 +0200
Message-ID: <375416d7-a847-faf4-cbf6-fd5ab2294408@gmx.com>
Date:   Tue, 13 Sep 2022 06:23:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 07/17] btrfs: allow btrfs_submit_bio to split bios
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
 <20220901074216.1849941-8-hch@lst.de>
 <9a34f412-59eb-7bcd-5d09-7afd468c81af@gmx.com> <20220912135528.GA723@lst.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220912135528.GA723@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oAwZpdzWYQU52gb+G5mQ6usxncW5NmPCnahO5XD7fRUhLqU1qaT
 Cs5dqRX/nRKQEYOtb5hzvOFJTMjb7OUQp2mF5dIu1QCbFiKdBAOFZQsIC42vAPdO0AOGAwA
 VP49BHL3zQgr0RvEDwdAueqFD8PeUnCJ9HhEH8Am/fMRTJRJ/GKx1rCRQOGz8OUzdz1S1sY
 ci8K8Q4vVS+Hc5lg1Uglw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UMUYDL5RZ+0=:G4XJJqiQpLov4gyrYpRgWj
 tpHMO17zwg1SFQtZpeeTyYRfGAfTxOpGv/oTGQDz8lVSI+RMK7QIwsklScBEHS3pm08sXbadv
 mxMxcYN7sxkgC/ApjOqO9wwGF792xUDe3O+avWhLiMNScwBwHevJd9y9moqKntQH8w0jVabfF
 ABcQhIcnVkf8m4MYiQbwNf6oKfaLW9lt/kSgn/2R6NTPAPw1r3Id1Wzu9PFad8VLLx07hMa1P
 i0mtKFhIZ1pD0JiBF08mAER/YDTgZkqJQu9O/dk3Z++Iw1JTPbZbBhaCOpRUSqmVPVcVeLAoX
 ZwPuIAY1bhEJW3vschl9EJep0D75fqe8IUMDhKiCCghqGCXh8CakEVvIykrTv8hWQsm411oSD
 gRURdpB35V6gP2N+gRKbGuGPFubPf5Arlx9Ezc19G+MBRDcCPKHLb8IRqIhlndq62fx6GjA2G
 AvEErzOymfCBCWvOHCLqtDuzBtZiIVPJmuJaiIE3b5sWvte/YgrasMvti416wSzolw9hp/zoO
 +Cmkd8J1eGvwZLyxOgYq6IPXzYP2BuIOuN7XDCQF2x2HLqOqMecR4ZkTZa7tV6uR84cikUIKm
 vtcjPULVAkMfT6vvLMNf4WVoIvz9tawBqdzgj1jVOzevCdpQxP3fS87ycEr/tV9yjG7PXDI3d
 ddFZDN5FLlYtV/a5wFd+BUz1xsMFbokcHUJRz+7WQVHcmRC5FW88t2pBhJEHxarfj+9bv0QK5
 oQS2YxZ/QQy0DmVL5L7wUPEC0dstOo+X9LFNvYDY533u2CPWJr+q/rTwhD8CeQ23NaN5jvKRZ
 r48YbkqV4eAkJ2Jq/6xYIS3JfIAyaU+gEyEXvcIvDslGa0PXGBRwhD2q3RhwcVBsq006QIGNX
 0FYgGi+mztDZOSA90rJAi7Dnc0sGUapwa1gK367JZCImVK1SFz65JBjcOp0OXNuHznGQNMhZv
 66s11mKI5iSx2HKN2EiaLMsGS+2NVVIDtut0/PfmxsA6gGM19CnQpMp0t4zdsNtlW2AWCGGZ+
 qC+z0uxDUO25QJ8x+7KfbDmzCA02G6zEbAEvrRWnFCeUfWPDZgqokvAfDy4UK1elnLkVbUbKY
 cKod32b2GOhyovjZnOUGAj8RqUOChJViMIz/yauDgCWnR/+OOlFToBFMQvWaaR19sRCwvOxlM
 senDHYkwiUWgfcERR81PRjml8c
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/9/12 21:55, Christoph Hellwig wrote:
> On Mon, Sep 12, 2022 at 08:20:37AM +0800, Qu Wenruo wrote:
>> Sorry for the late reply, but I still have a question related the
>> chained bio way.
>>
>> Since we go the chained method, it means, if we hit an error for the
>> splitted bio, the whole bio will be marked error.
>
> The only chained bios in the sense of using bio chaining are the
> writes to the multiple legs of mirrored volumes.
>
>> Especially for read bios, that can be a problem (currently only for
>> RAID10 though), which can affect the read repair behavior.
>>
>> E.g. we have a 4-disks RAID10 looks like this:
>>
>> Disk 1 (unreliable): Mirror 1 of logical range [X, X + 64K)
>> Disk 2 (reliable):   Mirror 2 of logical range [X, X + 64K)
>> Disk 3 (reliable):   Mirror 1 of logical range [X + 64K, X + 128K)
>> Disk 4 (unreliable): Mirror 2 of logical range [X + 64K, X + 128K)
>>
>> And we submit a read for range [X, X + 128K)
>>
>> The first 64K will use mirror 1, thus reading from Disk 1.
>> The second 64K will also use mirror 1, thus read from Disk 2.
>>
>> But the first 64K read failed due to whatever reason, thus we mark the
>> whole range error, and needs to go repair code.
>
> With the code posted in this series that is not what happens.  Instead
> the checksum validation and then repair happen when the read from
> mirror 1 / disk 1 completes, but before the results are propagated
> up.  That was the prime reason why I had to move the repair code
> below btrfs_submit_bio (that it happend to removed code and consolidate
> the exact behavior is a nice side-effect).
>
>> Does the read-repair code now has something to compensate the chained
>> behavior?
>
> It doesn't compensate it, but it is invoked at a low enough level so
> that this problem does not happen.

You're completely right, it's the 4th patch putting the verification
code into the endio function, thus the verification is still done
per-splitted-bio.

I really should review the whole series in one go...

Then it looks pretty good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
