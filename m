Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050F22DA3F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 00:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408130AbgLNXLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 18:11:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38116 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgLNXLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:11:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BENAER7189852;
        Mon, 14 Dec 2020 23:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZgfrS8asxPlKxf8u6E3lDMqj0dpzTas5DAUZTX/96BU=;
 b=ZnX+NbRmkt3P7jsWAPa6BvcMOAZZYFq1Hff0h1wvDoeEPFigPucFXj98wb2X5ATI9G84
 XTpexSXEWT1BGdBkRjCbk4J7b6eOURSeTjZX7qFCs50y72nvnhiHeLuUFBpnx60VFqxB
 aoYSwZNGDJAKEOr+Dpr7hKUHeKKod1o+VTXIrYye4sr0ORwN0M7JDh5hmNrRqnXQhXFU
 gCfhZu5rew5DULgEawMMwPN+PfjnqlopsWVaV1y6+Ru+v2jUEWgoyjTIcDJWvAd2kSUt
 ndyJemYjVLleGDNfrOo1AOxdAwq05CPEsHW7uU8hJxuLCdUTbpGfKRj73s/7b7v6M9EK bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35cn9r7x03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 23:10:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEN58bf096736;
        Mon, 14 Dec 2020 23:10:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35d7em461d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 23:10:44 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BENAhq1002957;
        Mon, 14 Dec 2020 23:10:43 GMT
Received: from dhcp-10-159-135-62.vpn.oracle.com (/10.159.135.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Dec 2020 15:10:43 -0800
Subject: Re: [PATCH RFC 0/8] dcache: increase poison resistance
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Waiman Long <longman@redhat.com>,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        matthew.wilcox@oracle.com
References: <158893941613.200862.4094521350329937435.stgit@buzz>
 <97ece625-2799-7ae6-28b5-73c52c7c497b@oracle.com>
 <CALYGNiN2F8gcKX+2nKOi1tapquJWfyzUkajWxTqgd9xvd7u1AA@mail.gmail.com>
 <d116ead4-f603-7e0c-e6ab-e721332c9832@oracle.com>
 <CALYGNiM8Fp=ZV8S6c2L50ne1cGhE30PrT-C=4nfershvfAgP+Q@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <04b4d5cf-780d-83a9-2b2b-80ae6029ae2c@oracle.com>
Date:   Mon, 14 Dec 2020 15:10:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CALYGNiM8Fp=ZV8S6c2L50ne1cGhE30PrT-C=4nfershvfAgP+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140154
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/20 11:43 PM, Konstantin Khlebnikov wrote:

>
>
> On Sun, Dec 13, 2020 at 9:52 PM Junxiao Bi <junxiao.bi@oracle.com 
> <mailto:junxiao.bi@oracle.com>> wrote:
>
>     On 12/11/20 11:32 PM, Konstantin Khlebnikov wrote:
>
>     > On Thu, Dec 10, 2020 at 2:01 AM Junxiao Bi
>     <junxiao.bi@oracle.com <mailto:junxiao.bi@oracle.com>
>     > <mailto:junxiao.bi@oracle.com <mailto:junxiao.bi@oracle.com>>>
>     wrote:
>     >
>     >     Hi Konstantin,
>     >
>     >     We tested this patch set recently and found it limiting negative
>     >     dentry
>     >     to a small part of total memory. And also we don't see any
>     >     performance
>     >     regression on it. Do you have any plan to integrate it into
>     >     mainline? It
>     >     will help a lot on memory fragmentation issue causing by
>     dentry slab,
>     >     there were a lot of customer cases where sys% was very high
>     since
>     >     most
>     >     cpu were doing memory compaction, dentry slab was taking too
>     much
>     >     memory
>     >     and nearly all dentry there were negative.
>     >
>     >
>     > Right now I don't have any plans for this. I suspect such
>     problems will
>     > appear much more often since machines are getting bigger.
>     > So, somebody will take care of it.
>     We already had a lot of customer cases. It made no sense to leave so
>     many negative dentry in the system, it caused memory fragmentation
>     and
>     not much benefit.
>
>
> Dcache could grow so big only if the system lacks of memory pressure.
>
> Simplest solution is a cronjob which provinces such pressure by
> creating sparse file on disk-based fs and then reading it.
> This should wash away all inactive caches with no IO and zero chance 
> of oom.
Sound good, will try.
>
>     >
>     > First part which collects negative dentries at the end list of
>     > siblings could be
>     > done in a more obvious way by splitting the list in two.
>     > But this touches much more code.
>     That would add new field to dentry?
>
>
> Yep. Decision is up to maintainers.
>
>     >
>     > Last patch isn't very rigid but does non-trivial changes.
>     > Probably it's better to call some garbage collector thingy
>     periodically.
>     > Lru list needs pressure to age and reorder entries properly.
>
>     Swap the negative dentry to the head of hash list when it get
>     accessed?
>     Extra ones can be easily trimmed when swapping, using GC is to reduce
>     perf impact?
>
>
> Reclaimer/shrinker scans denties in LRU lists, it's an another list.

Ah, you mean GC to reclaim from LRU list. I am not sure it could catch 
up the speed of negative dentry generating.

Thanks,

Junxiao.

> My patch used order in hash lists is a very unusual way. Don't be 
> confused.
>
> There are four lists
> parent - siblings
> hashtable - hashchain
> LRU
> inode - alias
>
>
>     Thanks,
>
>     Junxioao.
>
>     >
>     > Gc could be off by default or thresholds set very high (50% of
>     ram for
>     > example).
>     > Final setup could be left up to owners of large systems, which
>     needs
>     > fine tuning.
>
