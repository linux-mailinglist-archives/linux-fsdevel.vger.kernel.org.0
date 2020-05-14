Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C751D32C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 16:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgENOZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 10:25:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60873 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENOZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 10:25:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200514142536euoutp0182228a127b2b9774276d0f6e4590921b~O6zYxX-ZA2823528235euoutp01c
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 14:25:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200514142536euoutp0182228a127b2b9774276d0f6e4590921b~O6zYxX-ZA2823528235euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589466336;
        bh=VtAYupjDYOT6wcRX4a+idj2p/Ul8+u+WfufBE0nAEFw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YYY6jaxoJJJBm6fT181duIiXIOCmk8iX0s3SWwYbl5ZdVyoIVMyVmQzpYHMV/dnM0
         cP/PKS6oWKE+eVNMg3fTAKSTFqUZpyTyweZonFzekAVZ8r/R1aQiMuPkTqqIUZpH+5
         0zt+xiemXm1sx3Pzu1IKr6bfkiOFvBY8ZI/nM5+U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200514142536eucas1p196a362f82e4a0bd06e9a3d3f40ace3b9~O6zYmljUs0331303313eucas1p1F;
        Thu, 14 May 2020 14:25:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 54.5F.61286.0E45DBE5; Thu, 14
        May 2020 15:25:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200514142535eucas1p273584e72416843ab0c643ec0701ec6f2~O6zYQ8iG90687606876eucas1p29;
        Thu, 14 May 2020 14:25:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200514142535eusmtrp128c135d76dd944f8cc4733a4dfae64d9~O6zYQXljJ0037500375eusmtrp1R;
        Thu, 14 May 2020 14:25:35 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-dc-5ebd54e06a04
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8F.4D.08375.FD45DBE5; Thu, 14
        May 2020 15:25:35 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200514142535eusmtip21db80ded3f90c20289a3cdea69610122~O6zX_RkuJ3077830778eusmtip2H;
        Thu, 14 May 2020 14:25:35 +0000 (GMT)
Subject: Re: [PATCH 11/20] amifb: get rid of pointless access_ok() calls
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f6fcfa46-6271-45ea-37c2-62bcf0a607cb@samsung.com>
Date:   Thu, 14 May 2020 16:25:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200514140720.GB23230@ZenIV.linux.org.uk>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87oPQvbGGSzcyWuxZ+9JFovLu+aw
        WTzqe8tucf7vcVYHFo8TM36zeHzeJOex6clbpgDmKC6blNSczLLUIn27BK6Mzj23mQueCVRc
        XtHA1sC4nLeLkYNDQsBE4tOC8C5GLg4hgRWMElsPNzNBOF8YJfo+TmOBcD4zSky/dp+xi5ET
        rOPmpGY2iMRyRomrJ24zQzhvGSUmvjnICjJXWMBD4vfeepAGEQFViR13J7KC2MwChRIb73wF
        G8QmYCUxsX0VmM0rYCdxoOkQWA0LUH37/k0sILaoQITEpweHWSFqBCVOznwCFucUsJB48GcD
        M8RMcYlbT+YzQdjyEtvfzgG7R0Kgm11izsxTzBBXu0g8+TWDCcIWlnh1fAs7hC0jcXpyDwtE
        wzpGib8dL6C6tzNKLJ/8jw2iylrizrlfbCCfMQtoSqzfpQ8RdpRY/nQtIyQg+SRuvBWEOIJP
        YtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auZJ5AqPSLCSvzULyziwk78xC2LuAkWUVo3hqaXFu
        emqxYV5quV5xYm5xaV66XnJ+7iZGYEI5/e/4px2MXy8lHWIU4GBU4uG1uLU7Tog1say4MvcQ
        owQHs5IIr996oBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTByc
        Ug2M3WXO9TOmntvC7333p5DJsot1MjH3930PTmGUuna/fcHCr1s6uQvm/mPdGClZEHXe4wRX
        g6S0jbbt7yWqMrJtkxp8Dsnn7lvlZe/NEcakmFS4jXmNQd7DnEC3c2cN7mRc+/d96YT5M947
        GZ0S3FBTbjHNYiHP9tCf23MlH905eFtV20CydbGTEktxRqKhFnNRcSIAaUfv0iQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7r3Q/bGGXx5YWKxZ+9JFovLu+aw
        WTzqe8tucf7vcVYHFo8TM36zeHzeJOex6clbpgDmKD2bovzSklSFjPziElulaEMLIz1DSws9
        IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mzj23mQueCVRcXtHA1sC4nLeLkZNDQsBE4uak
        ZrYuRi4OIYGljBJNp9ewdDFyACVkJI6vL4OoEZb4c62LDcQWEnjNKLFvih5IibCAh8TvvfUg
        YREBVYkddyeygtjMAoUS7VO/s0CMvMkksfPoBhaQBJuAlcTE9lWMIDavgJ3EgaZDYA0sQM3t
        +zeB1YgKREgc3jELqkZQ4uTMJ2BxTgELiQd/NjBDLFCX+DPvEpQtLnHryXwmCFteYvvbOcwT
        GIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMn23Hfm7ewXhp
        Y/AhRgEORiUeXotbu+OEWBPLiitzDzFKcDArifD6rQcK8aYkVlalFuXHF5XmpBYfYjQFem4i
        s5Rocj4wtvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTCmHI0r
        M9idXra2+dLUuVrN1oEnN035rCu7IWbBtTJunod8CpdMpFt/zY6TkZa0u+ucLRsZrNC2XIPx
        Bv9UnzmKCcEWssH2c+aurhRxfDLR5OIl1UNd4u3hxVs33O+qSXJfcSpN+2ltQ4FAEV/J7ZtJ
        r8SdsxbZ7br0cNev6adjQgxUlr36PFWJpTgj0VCLuag4EQBLCsjVtQIAAA==
X-CMS-MailID: 20200514142535eucas1p273584e72416843ab0c643ec0701ec6f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200509234610eucas1p258be307cde10392b26c322354db78a9b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200509234610eucas1p258be307cde10392b26c322354db78a9b
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
        <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
        <CGME20200509234610eucas1p258be307cde10392b26c322354db78a9b@eucas1p2.samsung.com>
        <20200509234557.1124086-11-viro@ZenIV.linux.org.uk>
        <6f89732b-fba9-a947-6c61-5d1680747f3b@samsung.com>
        <20200514140720.GB23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/14/20 4:07 PM, Al Viro wrote:
> On Thu, May 14, 2020 at 03:45:09PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>
>> Hi Al,
>>
>> On 5/10/20 1:45 AM, Al Viro wrote:
>>> From: Al Viro <viro@zeniv.linux.org.uk>
>>>
>>> addresses passed only to get_user() and put_user()
>>
>> This driver lacks checks for {get,put}_user() return values so it will
>> now return 0 ("success") even if {get,put}_user() fails.
>>
>> Am I missing something?
> 
> "now" is interesting, considering
> /* We let the MMU do all checking */
> static inline int access_ok(const void __user *addr,
>                             unsigned long size)
> {
>         return 1;
> }
> in arch/m68k/include/asm/uaccess_mm.h
> 
> Again, access_ok() is *NOT* about checking if memory is readable/writable/there
> in the first place.  All it does is a static check that address is in
> "userland" range - on architectures that have kernel and userland sharing the
> address space.  On architectures where we have separate ASI or equivalents
> thereof for kernel and for userland the fscker is always true.
> 
> If MMU will prevent access to kernel memory by uaccess insns for given address
> range, access_ok() is fine with it.  It does not do anything else.
> 
> And yes, get_user()/put_user() callers should handle the fact that those can
> fail.  Which they bloody well can _after_ _success_ of access_ok().  And
> without any races whatsoever.
> 
> IOW, the lack of such checks is a bug, but it's quite independent from the
> bogus access_ok() call.  On any architecture.  mmap() something, munmap()
> it and pass the address where it used to be to that ioctl().  Failing
> get_user()/put_user() is guaranteed, so's succeeding access_ok().
> 
> And that code is built only on amiga, so access_ok() always succeeds, anyway.

Thank you for in-detail explanations, for this patch:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Could you also please take care of adding missing checks for {get,put}_user()
failures later?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
