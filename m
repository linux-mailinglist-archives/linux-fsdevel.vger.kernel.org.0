Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A7345AFC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 00:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhKWXKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 18:10:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:50653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhKWXKm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637708843;
        bh=poAXb4E5nX2Wv7O/wHXlEUMVzQsMmd13N7EewkqUMHs=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=EkxYx+ErlgWvq5xGt6edGqWPNuww4kuVrlwr7kibCVPDzePTEyAmnDQtkMffAxl+H
         h9K3MaKpEbkN7BUHZQH1/UoCxKeldcGUWEc0buujJFBLKy/WR4mwefuEGENG7mXBwA
         nI6eFQ9s143Z10rYZ48kZ36E4BdI1XOtIIQ9T1DE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhD2Y-1mCjZA2yqQ-00eOwX; Wed, 24
 Nov 2021 00:07:23 +0100
Message-ID: <133792e9-b89b-bc82-04fe-41202c3453a5@gmx.com>
Date:   Wed, 24 Nov 2021 07:07:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
 <YZybvlheyLGAadFF@infradead.org>
 <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
 <YZyiuFxAeKE/WMrR@infradead.org>
 <cca20bcb-1674-f99d-d504-b7fc928e227a@gmx.com>
 <PH0PR04MB74169757F9CF740289B790C49B609@PH0PR04MB7416.namprd04.prod.outlook.com>
 <YZz6jAVXun8yC/6k@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
In-Reply-To: <YZz6jAVXun8yC/6k@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qASjRyYRjJnLkrnZlSVGlZAZgsTMuJmguDInPrNNx+V3HgKz2ZX
 JgTDvELnCmstXDimn/HR4QUbvaruhP53LS61RyZb1dGMlCVEiHplGwdca7UsjCw3xv9Z/QH
 y7U/eA+HElDgXJ2TxGJzoioVeGNjOa2BN89ufziw6WSp1ohfvJTta7fy/XxIrwqwv8hoyMI
 5RvfLURk3X0mZv+Cm544A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3eFqAMexTz4=:m1BNluKfSjwvib3xt17B7Z
 jM/IPlEZdsfA8QOqYFXaNVeAwzvc4BDQBddJt6bRMILr0A3W2toL2M7m5aHN7h7nh2Nu7Dr6g
 rDezAhQAL7Ggd7h66IScupMbbpFBdV/+i7wKv5nb+NbsMOAfSeH5gOP8gu1R+RPLfQQQa7axM
 fz6/qcnmsYcnj/QUsdcmgmlIQPxE0FGX2dllBTtWhYLfM1mqhEPlE+yGANuJ4HJ+piv/O7bHz
 VIGpLhAMjzbitwYfbf1v6Ym19/jB6h7NPBynGe8Pr+tBshlhHG8ALgCCT133Ne7N5p+TOq99F
 Evjiruoy2blCDoCfUNx4q12Khy3bFSiqK8OI2vEqlUAa//JnHAzSRioq02MblIA4rrycizDll
 550kFYesOZ4MSslJuvd4iuOI69Vf+uImi/ZZDFppuTzotBwre75iVT7wWTsa+3pMUZGXmOBEh
 2y5vJo5I193b7Ojvbvfpk8v4eNPpf+cmr24k+6iQrgz4qYFMgAFuvK+YhmvevPU23yuiqyBle
 1YqGsxC5pjNq+PIDbc+YHwiE2tTumno8cUj0PAWuqwnZFDsTCosDN8EJ1rD55oWMauSskEg6h
 ++K4Hz/0pdkrEjuRSemfldT877XDqVZHma1sdfz/6J58p6s/Dld0eHAbgQPKuL0DZiUZDuC4X
 7j5yLGvODBRLWhWdvujli/qdFxO/fO5QE1XvNQPBVpsI4IL9+GgneYp//tUdZJzP9kDcl06Px
 4gehT7Ntz9msNwTOnbxwxVdqUTWRLtbvL4j+nzqWmourG5Rtcab6p9ISq19zWAqKdqE6bAtqD
 6tZvkgDqscfJ0OnIBoQciYJBh2Og8zGRhnvdjwKisPnmlrrzPXL8xlyXs4BCpsYTTo6GPDz1h
 cmJrbizN0m9HyQvBUpvemKKVmjyKCMTDvOVOSWvbD2/WsSXfsN5CW+4g3wMyGWDDVsBuzUCDZ
 eY/glM/WDnhVR6E0SMhuBd4wpj+WVVIyj5mV1YMSZvntlPm6KEfGgB9cw1swvBq1YPjdWCYhP
 wXivyJjXQ5evZV3iX4tmDwZnFcyJbXnCkwZMAwTEbI7o0i8D5ddjzGGhCfIxo8/UOZv9Sc7Bx
 b3iZRCOl0nqISA=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/11/23 22:28, hch@infradead.org wrote:
> On Tue, Nov 23, 2021 at 11:39:11AM +0000, Johannes Thumshirn wrote:
>> I think we have to differentiate two cases here:
>> A "regular" REQ_OP_ZONE_APPEND bio and a RAID stripe REQ_OP_ZONE_APPEND
>> bio. The 1st one (i.e. the regular REQ_OP_ZONE_APPEND bio) can't be spl=
it
>> because we cannot guarantee the order the device writes the data to dis=
k.

That's correct.

But if we want to move all bio split into chunk layer, we want a initial
bio without any limitation, and then using that bio to create real
REQ_OP_ZONE_APPEND bios with proper size limitations.

>> For the RAID stripe bio we can split it into the two (or more) parts th=
at
>> will end up on _different_ devices. All we need to do is a) ensure it
>> doesn't cross the device's zone append limit and b) clamp all
>> bi_iter.bi_sector down to the start of the target zone, a.k.a sticking =
to
>> the rules of REQ_OP_ZONE_APPEND.
>
> Exactly.  A stacking driver must never split a REQ_OP_ZONE_APPEND bio.
> But the file system itself can of course split it as long as each split
> off bio has it's own bi_end_io handler to record where it has been
> written to.
>

This makes me wonder, can we really forget the zone thing for the
initial bio so we just create a plain bio without any special
limitation, and let every split condition be handled in the lower layer?

Including raid stripe boundary, zone limitations etc.

(yeah, it's still not pure stacking driver, but it's more
stacking-driver like).

In that case, the missing piece seems to be a way to convert a splitted
plain bio into a REQ_OP_ZONE_APPEND bio.

Can this be done without slow bvec copying?

Thanks,
Qu
