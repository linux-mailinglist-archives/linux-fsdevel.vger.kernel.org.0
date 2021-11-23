Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F8C45A102
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 12:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhKWLM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 06:12:56 -0500
Received: from mout.gmx.net ([212.227.15.18]:41185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233112AbhKWLMx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637665776;
        bh=GFsasHE3doMoUcgAgAVueOwc5xBHUN1uYTfYU61MMYM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Sx6mi2T6qPgdz0E3RWjkWlj6kxl08lP9bp9w0NnRq2C+Lh37LARvwTbFdnpaBaPO+
         V9ELJrZ1eTJAzt3gkSLhbRZT38ftZ4yh2A6fVYsrqFtmAvz2aDxgZIofLCoWEWj3hE
         6WzeemVtwp9wOdSoLF4oaOhMxS0g4tS8hOm/dHm8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnJlW-1mNscN3N9o-00jJ6Q; Tue, 23
 Nov 2021 12:09:36 +0100
Message-ID: <cca20bcb-1674-f99d-d504-b7fc928e227a@gmx.com>
Date:   Tue, 23 Nov 2021 19:09:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        dm-devel@redhat.com,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
 <YZybvlheyLGAadFF@infradead.org>
 <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
 <YZyiuFxAeKE/WMrR@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YZyiuFxAeKE/WMrR@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HN//ZkQPKk205NHjFSinz9cJfVRdC850H1mx05Acxk53rparwCi
 THWLh7ECQl09R8O3i2SHZfue9ctPG7sMtzbjQdU1NXvOwem1mCixxmIY4h/368gE88m1g6i
 xa0qPj2B9c76RgCnDjDrwbKdW+yA3ROIVDFMVUVehUnWWmGVptPGVcgS0vE/60msg661avu
 DwVXVrnGCMRCpuZ4beLlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9uqijgn8QXY=:smpjZLHq/cyEW3Ror2zHlo
 CHI2OaQcspc0mNJiqVe6T5sqqzWrf0j43BEzk5OyjXDKotnZWT/bvxYuGbjNbtUjW7eOnwdCg
 zSILJ3rHytgmxxjYOjfEAfbnyZ+2wvP5GtexpGxxHrspTkp/hIHlpr2JCvwHhPftUhBrMQtj7
 WwewyxJ0z+q9fQqkH9O4Q6Uy/N8jbGT2cffrV+90Stat2QTChOFdThnhcOQ4Bb+eWUtzwb6bF
 kE+Rfsp7Igde9SGTcCJf/0HfL6eqHApgbadneQUysbB+m/+xitvLN8S8atNsz/1PwvLz0DnCA
 TXEtzJpS6tnTx7X0TsH2gu4TpodpYy5tUoXqAZlTTtL0FQP+YUhb4nOATiAxNLJlPDEIvEeel
 da5qYse1xKhk9ru8vEn4EV40YOY1G1rnzS8RIwi/HYL8b3G9pY6FHhBtMXzpwE+RmKwu5bjRw
 C1bSCQ05qi6FAeT84lPnlTFGtotOXtBCk0vNtLIg219eFARg4xQiPkefU/buCyyXvDBi3yNsG
 M0VxXK6a7BVeX8zLUjKA3/NkJhfvEVLKSOQwWURRLZMUuL/IekgKGBhrOQd8iGwQKq5EpCil8
 RxIyFNfCfTAppS8C5iUoSvAo9PotD4lrjWVCawleBDw7hMvHUFdbmLvRF5ru3W/cHovmUeClQ
 rdkM5PDL3BsRij3Bl4aXmMKh2G6yfBAMpAKB8t2yTDa9Q+dPKCTn+9/1JiEw4Bm3TcbHObzYd
 k2wZeVqzcwFMrLNs9GINSMurbMsNirjUMsrswLuPdWVO0NqAkHLIgIiud1AlVWI98Li5VI+MW
 N0Nb5pMUPTMfgMtA+ZKX6Q7+eb6Y7fbR8PZmbuEGMdQIAGVB82taJx7uY7Ms0lu3nk1B8mwFW
 R436fY59baX0pWDrTo+UKbvdflCIadXBPuNValyGz1QssiPoyZWjO+pekypHXwYjhq2X5Nrq4
 ITb+ylQ2ZpoieGyRmgMEWp/ekEq7+gb/5tesvA3DRo+GMp9kZ65QvXCGpCJfPXmXzPoa0SSpD
 w4k3MS21d6bAvSHlUfSL/Vxuj4m915VDLGqN1bL+RMsFh1ufZblH21llnLaRSFjrzmf8jKJpT
 Hk1SIa8cE1MjBs=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/11/23 16:13, Christoph Hellwig wrote:
> On Tue, Nov 23, 2021 at 04:10:35PM +0800, Qu Wenruo wrote:
>> Without bio_chain() sounds pretty good, as we can still utilize
>> bi_end_io and bi_private.
>>
>> But this also means, we're now responsible not to release the source bi=
o
>> since it has the real bi_io_vec.
>
> Just call bio_inc_remaining before submitting the cloned bio, and then
> call bio_endio on the root bio every time a clone completes.
>
Yeah, that sounds pretty good for regular usage.

But there is another very tricky case involved.

For btrfs, it supports zoned device, thus we have special calls sites to
switch between bio_add_page() and bio_add_zoned_append_page().

But zoned write can't not be split, nor there is an easy way to directly
convert a regular bio into a bio with zoned append pages.

Currently if we go the slow path, by allocating a new bio, then add
pages from original bio, and advance the original bio, we're able to do
the conversion from regular bio to zoned append bio.

Any idea on this corner case?

Thanks,
Qu
