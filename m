Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5B31706EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 19:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgBZSFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 13:05:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57414 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgBZSFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:05:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QI3gV4083141;
        Wed, 26 Feb 2020 18:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qXKO8J92zXC1Yk6VbsBzAn5OB4Z+y9gt1UWWLl4AUq8=;
 b=nVHa1z7heHVs9l2OfaOgeGMQj1U6NLYyy+miHyAyt0jqm1PjfYY7O3btec1/u1UA103m
 D5mDtuZ//HE63Pl3M2QOBfZX6w4dKnzNDqaQ6tgKYtAAmG5jEPZkxcj/rX9r/aPo3d82
 6N3BUG2VHy1GvP7Yh4A3XFsC5RfmNLvHDFb3aGSrQlDjN7tl5SMiCKe+sjqsV3/Np/0a
 fFc97oBc3GwBa8o34VFykPslvTGm1gnqlF99qLzS3OOEQeQIWJsnHANJyS5sM19WqSqO
 dwldxTx63bq3aRsQKKrGV+MVL8iw/UI994G5iRIXQktxnKDaqdLzFSpjpg7roNfLvPD4 Xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ydcsrne8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 18:04:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QI25wB183864;
        Wed, 26 Feb 2020 18:04:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ydj4j4587-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 18:04:35 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01QI4JYX029321;
        Wed, 26 Feb 2020 18:04:19 GMT
Received: from [10.209.227.41] (/10.209.227.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Feb 2020 10:04:18 -0800
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
To:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Catalin Marinas <catalin.marinas@arm.com>, kernel-team@fb.com,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk>
 <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
Date:   Wed, 26 Feb 2020 10:04:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/13/20 8:52 AM, Arnd Bergmann wrote:
> On Wed, Feb 12, 2020 at 9:50 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
>>
>> On Tue, Feb 11, 2020 at 05:03:02PM -0800, Linus Torvalds wrote:
>>> On Tue, Feb 11, 2020 at 4:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>
>>>> What's the situation with highmem on ARM?
>>>
>>> Afaik it's exactly the same as highmem on x86 - only 32-bit ARM ever
>>> needed it, and I was ranting at some people for repeating all the
>>> mistakes Intel did.
>>>
>>> But arm64 doesn't need it, and while 32-bit arm is obviosuly still
>>> selling, I think that in many ways the switch-over to 64-bit has been
>>> quicker on ARM than it was on x86. Partly because it happened later
>>> (so all the 64-bit teething pains were dealt with), but largely
>>> because everybody ended up actively discouraging 32-bit on the Android
>>> side.
>>>
>>> There were a couple of unfortunate early 32-bit arm server attempts,
>>> but they were - predictably - complete garbage and nobody bought them.
>>> They don't exist any more.
> 
> I'd generally agree with that, the systems with more than 4GB tended to
> be high-end systems predating the Cortex-A53/A57 that quickly got
> replaced once there were actual 64-bit parts, this would include axm5516
> (replaced with x86-64 cores after sale to Intel), hip04 (replaced
> with arm64), or ecx-2000 (Calxeda bankruptcy).
> 
> The one 32-bit SoC that I can think of that can actually drive lots of
> RAM and is still actively marketed is TI Keystone-2/AM5K2.
> The embedded AM5K2 is listed supporting up to 8GB of RAM, but
> the verison in the HPE ProLiant m800 server could take up to 32GB (!).
> 
> I added Santosh and Kishon to Cc, they can probably comment on how
> long they think users will upgrade kernels on these. I suspect these
> devices can live for a very long time in things like wireless base stations,
> but it's possible that they all run on old kernels anyway by now (and are
> not worried about y2038).
> 
>>> So at least my gut feel is that the arm people don't have any big
>>> reason to push for maintaining HIGHMEM support either.
>>>
>>> But I'm adding a couple of arm people and the arm list just in case
>>> they have some input.
The Keystone generations of SOCs have been used in different areas and
they will be used for long unless says otherwise.

Apart from just split of lowmem and highmem, one of the peculiar thing
with Keystome family of SOCs is the DDR is addressable from two
addressing ranges. The lowmem address range is actually non-cached
range and the higher range is the cacheable.

So apart from LPAE, another change I needed to do back then is to boot
the linux from lowmem with bootstrap MMU tables and then re-create
MMU tables early (mmu init) and use higher range for entire memory so
that L3 cache can be used.

AFAIK, all the derived SOCs from Keystone architecture inherently
use this feature.

Regards,
Santosh
