Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621304E4D01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbiCWHAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 03:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCWHAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:00:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C314186F1;
        Tue, 22 Mar 2022 23:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648018755;
        bh=9PGxySqIwSrPZnPxsTwA1vXAzLST7mxkt1wOyUdRReE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=Q7TCWLLxXdNmVHp/6xGm2I+adS3oeJBowedSJMDwQOQ/w4lP3LzP15v5gohhOC6I9
         2s8DVHyAsaxjEjrHWaQP7pFPkTJ645oFZP3DqFfWE/M9OLKlF7uivpk4tqxIV0sF0e
         eqVzCw5y0fg8Tpal1wuZrvgjUJm27oUjBf7B1qgg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7iCW-1o9oTh0KVW-014mMh; Wed, 23
 Mar 2022 07:59:15 +0100
Message-ID: <ebb61597-dc43-2e81-2106-e448145f212c@gmx.com>
Date:   Wed, 23 Mar 2022 14:59:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-29-hch@lst.de>
 <d9062a7d-c83c-06d7-50ac-272ffc0788f1@gmx.com>
 <20220323061339.GJ24302@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 28/40] btrfs: do not allocate a btrfs_io_context in
 btrfs_map_bio
In-Reply-To: <20220323061339.GJ24302@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UOJPDJj/NAcT2gIOdVJgMIld+Fkfdy5/kuPP1I3JFdfrmBwVLVR
 U3cQKT7YuHCtu9z5d5pasFzg9JkpTi3SgzzQjwZkQgFQGeQ3tXP7wrF/T5JS+t7J8tBcxQV
 eikVjNtC+E4M6vsAYiBi5tHkpjiElZ6MyvdopZP8YtfydAxzPTiwBQ2DUkVqYC01Xax8B0I
 rwWAob9Cw9SHl0EBoKUnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4ee319k9EnA=:kZwj4SB+3QEad4p8g7Ih/Y
 cUVqp4lYgwOSFwQHYOLdmr2e3OCplwi2UyjGqH2UHhRNWO+WAxLxFj7K2fMNyOWDXv3ZglyGw
 fvL3ESuUFgVN0r4T9hDMWtVYjms3xGd3jWb81PGg2F/KlzelfQ06jaqhqXvGaRxKiOBWN6qky
 75nB6STiecVTx40J3oppG0DWWdPegfxPncriXCC1k2DXyCCWrlBgVGzOXKo94M2xLgmakrp3c
 XxJI0HOPeT8GVpSUeFlodlpFupPFuZibDC+8VjNO5AwwHuEI6NBLpRe29iGvbAckB2HhXOznC
 S5ZH36tW6r6rUNG4XCLsIOGTQFtkknzhNSOKES0Y+rYlJ8OnhOZekKEBhBhPbVhYj93+kNkkK
 t5apcdPYCHNOCYTxHo/MhvbM7M15ookVqkF3JIIKOhUsHv+lKOI6KeDxgdcvu0uSc9hyfRrLK
 Y3bsdibgnXgpPAMIypENZW6JdYoXmLSt+GnVeN0MhezMMhmDhShFZCPFl9o4YPdzlsqvezigh
 hqdvSZv8wUBwdY0qr5n5l8Vw1BqUmRnYptO0o0LulYWZZIq/OTaNXIdWJy6NTF5fZ7JIixDB3
 RtT1d4wh2I1MZV8tBIZxE15B3x5Kb9JPoo2aTgHCERiJrjn2rFncvpFrMEfaYYcK3n20MP3hm
 zUFCzTmjNa01Rd7Aajg9attLiDveEAKQ7+S6lkn4s4GS9/uonatcxlOQ6NL5oyhUEPIZKviBk
 LN1YZHnQISXJurTspbc4joOe8l39u9KnTE28oWL0X+ASwDyPSjf+RTiFkzQVLg56zE0iwFTWk
 q0p6IoQZREm4RCDxEvJp00GA9lQ5kI8FZ2or3Y06Nhm6rsSxhFQghnBQNFoaTIS3RzRrZMkdg
 Bylo1j6I7LtHVwLbZfaRd/hBwK0qLO26e+jIoRg50x2VPZgLruU1l+P0PS6fsY4R1t63vSFR+
 XfZulCyiBIIqZB2BJzbszRIm3egZ8eETGmScZEYnNVqr8MI811Z+MSbMy+ZM0Ll2WxmRaqBUL
 x+u0jsJ+w58XeWCYXuoa6fwbKQBwz9CT1AtqvaegMWXUjxjrOjQdRqHxZuinCa9ZV69S02nfV
 hg06jKtWSK/ux8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/3/23 14:13, Christoph Hellwig wrote:
> On Wed, Mar 23, 2022 at 09:14:06AM +0800, Qu Wenruo wrote:
>> Really not a fan of enlarging btrfs_bio again and again.
>>
>> Especially for the btrfs_bio_stripe and btrfs_bio_stripe * part.
>>
>> Considering how many bytes we waste for SINGLE profile, now we need an
>> extra pointer which we will never really use.
>
> How do we waste memory?  We stop allocating the btrfs_io_context now
> which can be quite big.

Doesn't we waste the embedded __stripe if we choose to use the pointer one=
?
And vice versus.


And for SINGLE profile, we don't really need btrfs_bio_stripe at all, we
can fast-path just setting bdev and bi_sector, and submit without even
overriding its endio/private.

Thanks,
Qu
