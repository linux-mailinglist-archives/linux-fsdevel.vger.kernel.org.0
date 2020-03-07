Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD9D17CA2A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 02:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCGBJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 20:09:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37968 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCGBJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 20:09:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0270xSfu089023;
        Sat, 7 Mar 2020 01:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jZ/9waIGl3FuS/HeKNiN38qC4SIq/ljoQkSPu9FdPf8=;
 b=Uqs0s22zrTEyv0b7mZ6uR92KBRV+hDQZyS/SZQiDnL7G8R9y8dakPYUR8NdJm/DePhqC
 Q2c4t32fLC00Y/1D+Xctdb4lydFk+pIGcgIT6XI+GKSONNQY7mIQmbj8M5fG9kK/tfBL
 9mtqxay+7QRBJxDY9Mg6Jqx6rBqT82qIkJ0qUJi5ONbTPG4y7jPujNrsvbpqzIS6RoMp
 YtcsgSG39WelIKtN9gPBi8/EKSL0YO+4f+8ZFUzw1xFQu6UG/vuio2nWnXHUkdr4j3LL
 TIghQTqX/nRg2rcl0qAKXXCSb0XSkxKkpsgBG53/IW/PRpQHDjxPImEgtJtzR2HjRI3/ Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yghn3syrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 01:08:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02716utR147358;
        Sat, 7 Mar 2020 01:08:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ym0quu3wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 01:08:24 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 027184eq023779;
        Sat, 7 Mar 2020 01:08:04 GMT
Received: from [10.11.0.40] (/10.11.0.40)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Mar 2020 17:08:04 -0800
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
To:     Nishanth Menon <nm@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tero Kristo <t-kristo@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-team@fb.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
References: <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk>
 <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
 <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com>
 <20200306203439.peytghdqragjfhdx@kahuna>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <7b179d51-3d08-53f5-9b6e-552869f8ed78@oracle.com>
Date:   Fri, 6 Mar 2020 17:08:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200306203439.peytghdqragjfhdx@kahuna>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003070004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003070003
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/6/20 12:34 PM, Nishanth Menon wrote:
> On 13:11-20200226, santosh.shilimkar@oracle.com wrote:
>> +Nishant, Tero
>>
>> On 2/26/20 1:01 PM, Arnd Bergmann wrote:
>>> On Wed, Feb 26, 2020 at 7:04 PM <santosh.shilimkar@oracle.com> wrote:
>>>>
>>>> On 2/13/20 8:52 AM, Arnd Bergmann wrote:
>>>>> On Wed, Feb 12, 2020 at 9:50 AM Russell King - ARM Linux admin
>>>>> <linux@armlinux.org.uk> wrote:
>>>>
>>>> The Keystone generations of SOCs have been used in different areas and
>>>> they will be used for long unless says otherwise.
>>>>
>>>> Apart from just split of lowmem and highmem, one of the peculiar thing
>>>> with Keystome family of SOCs is the DDR is addressable from two
>>>> addressing ranges. The lowmem address range is actually non-cached
>>>> range and the higher range is the cacheable.
>>>
>>> I'm aware of Keystone's special physical memory layout, but for the
>>> discussion here, this is actually irrelevant for the discussion about
>>> highmem here, which is only about the way we map all or part of the
>>> available physical memory into the 4GB of virtual address space.
>>>
>>> The far more important question is how much memory any users
>>> (in particular the subset that are going to update their kernels
>>> several years from now) actually have installed. Keystone-II is
>>> one of the rare 32-bit chips with fairly wide memory interfaces,
>>> having two 72-bit (with ECC) channels rather than the usual one
>>>    or two channels of 32-bit DDR3. This means a relatively cheap
>>> 4GB configuration using eight 256Mx16 chips is possible, or
>>> even a 8GB using sixteen or eighteen 512Mx8.
>>>
>>> Do you have an estimate on how common these 4GB and 8GB
>>> configurations are in practice outside of the TI evaluation
>>> board?
>>>
>>  From my TI memories, many K2 customers were going to install
>> more than 2G memory. Don't remember 8G, but 4G was the dominant
>> one afair. Will let Nishant/Tero elaborate latest on this.
>>
> 
> Thanks for the headsup, it took a little to dig up the current
> situation:
> 
> ~few 1000s still relevant spread between 4G and 8G (confirmed that both
> are present, relevant and in use).
> 
> I wish we could sunset, but unfortunately, I am told(and agree)
> that we should'nt just leave products (and these are long term
> products stuck in critical parts in our world) hanging in the air, and
> migrations to newer kernel do still take place periodically (the best
> I can talk in public forum at least).
> 
Thanks Nishant !!
