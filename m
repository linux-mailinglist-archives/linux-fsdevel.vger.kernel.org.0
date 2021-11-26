Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7766F45EE05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 13:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377513AbhKZMie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 07:38:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:35299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234618AbhKZMgb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637929988;
        bh=D0W9oat8aTWLnbs0dnCYqXVNE5mKmOnXTYbD8CsfL24=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=C7/ioq5a9mu305GYBanD4gd0XBeNJZo1ELTlUbRe0cbQbtfW2QFd6bQ8nSguMuwGi
         RjW4B0sNEyXSiln4ILPS8fuzLVn2/t68yD/rKyShB8Jd5wIFrjP5ggpIMXfvbGG/Yi
         M77KSrHOEiS+qc/sAD3sx8NSMtOZynRNUb4MFMaE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mplbx-1mGRva14FJ-00qBEQ; Fri, 26
 Nov 2021 13:33:08 +0100
Message-ID: <c44de3dc-b7a6-5872-2fe5-05488e93db05@gmx.com>
Date:   Fri, 26 Nov 2021 20:33:02 +0800
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
X-Provags-ID: V03:K1:091WRRDrxH/2yMPKg6Uo+uTz4mJSDtRMoLxqluII1/bR8fmw6ug
 ey6sTGGxndUgaxgmXx45ESq1eN7eMHvyWiPdr4O215tz7ZJjyhOM2tixFoPk90t9tT4/GYD
 MuNyyDqaroLrSjDE2efwqgvc7Ye9N6e/D5h4C9fZ8lVzQ1pX8GoK3FLRg/ODCUML9kgHtOU
 uzDMRwtCdaDVb4dzAOFvg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ytDR6jOTwN8=:hcjBD9ySYG7BNMMLIZgzQ7
 V9aBPZKqgJ9mvYMUce8XKUZjGcU2+Scc2nVPqVw0efAhDgi6y/7tDDnp/aWp4zitcECBKaHyg
 5wGZSq8hD3Ap7pYxFRiJbMHRToWGUP0xwGdQKkkSmm19ZzE2pZV9F/59CEjM4HU70XcyshRlh
 v5ksP9ZRz7kG93x6c1DVqE7TfWULqk6r6moCXbhzW34TYA8GfvjpOWmfGxS07SQc6FAp6mE2I
 q9YS8q0h/M2z/J4GLqU3VR/SD9TtX8BemsqfHNr0ldRsuClHL7pJnrA+tYQu6mdYmISWnb3qM
 hELKRlMj8GEWcP56ku4/055AHvMIpIctogou84v08qE+xaXxhl7SpbjTQV56EzMC8J/o9H0Hv
 XKo+111ElgmINQo3aEdDE7b/w4mP/CmWQK3gDpT7u7/oHH/h1TZcrVh9DC4zzYf2XbzqZPDgd
 k5XDKR+tHSht88KHBBqNrh+jJrkAy4q6Ry9Cz5QzteKms8G901nfQI4S2vewJCLOCNbtxFSqV
 MK+BNZlojbmFVsype/dibNmVL71ND8ErkNY2hcR5EMpv+af+IeNu3at5H7UBgw6XeBwn40lkM
 vZt+cw8f4tpr08GFBqWHlzbsmR/uh6/OQ7/LVXO148ba9dCZw+FN+wHirl9CKOH9KDXPLIfFR
 fSP27aU9JnhtzA956rz1ZtKIZ1hueSSfc/drYU3KVZSvMOhBNP17P4LXJFkT18zpodXY0Y7M9
 Mtvk0re8y7j4xxs71Dzeo/+5OjbocLSjoJmvsyzOB+stffftD/n9Ze+Nos5OmehgxSRhspmjy
 LN9Ig+wL4xeIZPOveu1Op4UZcyk2pfR1R+iQJPYiyhE2l+3NgfTXCjO5tGpDuzOucDAkTb4gU
 tBi95qm4VLy71x0vsV1EvT7Av48ITBtgWAoAExGnVPFoOhX1hBn0YRBnqpEOYl10WumttLbjU
 aVf5Wblms5vXd27mr8QQdHQ4QLkpF3Zt3RpxZ8trD5mr6amHWNQNg7wPtrR0U4+OQVOR833/m
 chem1+6prG0AfbCs6qgZ9bgZYHWXHkZq8F0U/61xlad3oxsrCKC7ySz2cVeLgIwYNRgUvwNxB
 iizgrvKDlYnoWo=
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

Does this also mean, we need to save a bi_iter before bio submission, so
that at endio time, we can iterate only the split part of the bio?

Or we have to go back to bio_chain() method, and rely on the parent bio
to iterate all bvecs...

Thanks,
Qu
