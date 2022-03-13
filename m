Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627F24D74E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 12:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiCMLFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Mar 2022 07:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiCMLFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Mar 2022 07:05:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6978F7892A;
        Sun, 13 Mar 2022 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647169423;
        bh=yRF2pfqd2jSigZZZnogYtkaHrzgYLOIe/AIX/yoqLgY=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=DvT7Qa5YlQ9/FuqNrDTEd+7QhyqI1YwGYxuCK0bHr47d8r+0xEWCn8ayMjbO7py/J
         fssp4MRS6YJjO0NZ3Mgxy/ACP48eO9hvSOPwRPBBiI63C2YOI6Y7DFjehd744hvHYU
         iyYFMkOmi1QTIuQQETZV/LzVlTm6mPJ5k75xRnWc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbIx-1nKrQz1wLj-009fqT; Sun, 13
 Mar 2022 12:03:43 +0100
Message-ID: <d8ea4246-8271-d3c4-2e4d-70d2c1369a05@gmx.com>
Date:   Sun, 13 Mar 2022 19:03:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
References: <88a5d138-68b0-da5f-8b08-5ddf02fff244@gmx.com>
 <Yi3NkBf0EUiG2Ys2@casper.infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Better read bio error granularity?
In-Reply-To: <Yi3NkBf0EUiG2Ys2@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7N7Y+GXcGUd3TgJDXOtNCc1oJ2z91BRD6n8d/n6BDmlX17YIewj
 nkZ+hCr5dlz3BDOnkRPWJ3I7Mv8wuP8+8eprXEtbMrVxf4M/4nPj6wGMnQiFPUk655tkUjW
 F/yZg3Ryo+LVlnX4+Rdi++L7ZZdP++R62XP2Z0tL7uGqyY+v+zVpbZ+JSIzzNlkEtyviF/m
 usdNQxoNBDZtATQcXmG5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U/xHFkHs1hQ=:5An6tQIa5ut3kHJLOBEAGu
 ObY7J7H6D9lzUsClRdU5TJzIhQRosTMfPBEa7VPpgKDvuoX6QYooNq3te7PWedd20uM+jn62N
 XCpM7v+/tL6kmIkl+T+kqTrbnffhUrEYvWQLZeCMNW8DwZqlRCfuvf09EyDwqxpe8R/B+ikTI
 t+rSDs1pPJIu+4v3X6f2qUG5IpjUdq//qU1O6WZPDvaDJDNLhHmJdO5DFET4xAbOuXrGDmwTy
 dXQrkyJANStVI77npyIwUGnx5tchFxR2YlgF+UfdM8nMA8xqWInz42h3VqjXCIuWjit0YCnin
 MhWfK0f+ZgOljXZVCjePRGsfp7wKDXxzs/bfHvErQNgUxGWl2PABXu2XD6IEfTyI6la8fnXOu
 FcBu3oCR08GkRf3qHY7syemHKy0nDl61k5XwzpDxWg3t/e+qDuO2VtLhLMDXsBJt9Rh3tSzW9
 k0w7V9BiqsuO1nbgWDVa3+dxrO/vX7q0wahMePTKHf7nT2zizSEVRXJpnKxKYQw8S6WnnWWOA
 rL1IW+yAz67vYMQgkUR8N26FSFAUpHC8b6WlqqUNBTZ8RiDfewLVBd49c4iEuZd94kWR92m13
 QX1D0IGOPmFfANBOm3skUOSnMBMhJiOi1M9LLS11WkTChyAwQzQXanrl3sPDGBZRXs81MPuNS
 LapAXLN+E50sqbCn65JeD1PCW1XEnd1gGuZMCGj+HWfmi1aeYrBKQw4VcCsUzTQc8QoaaoAXI
 fD2euA4LPIxuIJFsW4Ikijtn23ws+fi6mZWY/Dx9C2Do2r+LS2bE3q+TNhQI8pYsUyxqJvZB/
 XzjphZwB2/t43Vf3D6R0TN5J91d+uaez3ZnXMtnGeLnhL2Dx9vwhXAAqsRAygqLd7xCTWq4UY
 CVU0DsEwxbbT2qYMMQ27QJGP1/YA8KeeDrj8w097VzPT9UpEYMksPL/2RD+cEqwtqIgF4u8Ei
 COC0bO68X+xDkm4YY8Nx5mL04ddvSN03lFfY4ZfZrw32lvU0dHDUVWL3G4rVIlcBZWK235CqV
 ZEfq/u8XVmakoWR21wPwvzRbCw2+4OLpdA5AhP6WUcnypyUgQrSI5ZygUFyrZCzUmMWF91qeY
 dU5I4hQqihdjy4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/3/13 18:55, Matthew Wilcox wrote:
> On Sun, Mar 13, 2022 at 06:24:32PM +0800, Qu Wenruo wrote:
>> Since if any of the split bio got an error, the whole bio will have
>> bi_status set to some error number.
>>
>> This is completely fine for write bio, but I'm wondering can we get a
>> better granularity by introducing per-bvec bi_status or using page stat=
us?
>>
>>
>> One situation is, for fs like btrfs or dm device like dm-verify, if a
>> large bio is submitted, say a 128K one, and one of the page failed to
>> pass checksum/hmac verification.
>>
>> Then the whole 128K will be marked error, while in fact the rest 124K
>> are completely fine.
>>
>>
>> Can this be solved by something like per-vec bi_status, or using page
>> error status to indicate where exactly the error is?
>
> In general, I think we want to keep this simple; the BIO has an error.
> If the user wants more fine granularity on the error, they can resubmit
> a smaller I/O, or hopefully some day we get a better method of reporting
> errors to the admin than "some random program got EIO".

Indeed this looks much simpler.

>
> Specifically for the page cache (which I hope is what you meant by
> "page error status", because we definitely can't use that for DIO),

Although what I exactly mean is PageError flag.

For DIO the pages are not mapping to any inode, but it shouldn't prevent
us from using PageError flag I guess?

> the intent is that ->readahead can just fail and not set any of the
> pages Uptodate.  Then we come along later, notice there's a page in
> the cache and call ->readpage on it and get the error for that one
> page.  The other 31 pages should read successfully.

This comes a small question, what is prevent the fs to submit a large
bio containing the 32 pages again, other than reading them page by page?

Just because of that page is there, but not Uptodate?

>
> (There's an awkward queston to ask about large folios here, and what
> we might be able to do around sub-folio or even sub-page or sub-block
> reads that happen to not touch the bytes which are in an error region,
> but let's keep the conversation about pages for now).
>
Yeah, that can go crazy pretty soon.

Like iomap or btrfs, they all use page::private to store extra bitmaps
for those cases, thus it really impossible to use PageError flag.
Thus I intentionally skip them here.

Thank you very much for the quick and helpful reply,
Qu
