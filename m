Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5812D8F8D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 19:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgLMSxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 13:53:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34804 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgLMSw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 13:52:58 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BDInnv5095008;
        Sun, 13 Dec 2020 18:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=m+agSRCv2C7vA1smCTi9nr9ItANyGc4Iz5+EOO7ykN8=;
 b=CjylZuqN6lVabLCFgLdzeaUdMmE3xSDWWJXAUzymzlsZoiR8Uggp2G2dekEfTWR61N28
 23zeynROsAP/N9YlLT84VY7IO/NnFh0vyZxx8Om6KsS4HtSKjdkkxPRxKUfw7xZGMOYP
 gIzWg5iVPBF+ctewxhnCj616R4St2fK4mmQJSdzYGyoYfCWnoxGj5s/H9tVtsvO6yL+B
 1kr0CSLGGJa7nls4iZrmXO2EPRkxvs6M1OfAHgwIIbRzGw6kFHBZOfsaKL9tG4zG2T7I
 pzzEcV8OWET8Jy9mx2/3BdQuaf+7M1ljYZGQSV3s3Tk9/0ZqZrRbk1a+GQlhZSMIsIHu 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35cntktnan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 13 Dec 2020 18:52:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BDIf3Rd045988;
        Sun, 13 Dec 2020 18:50:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35d7ejqw4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Dec 2020 18:50:04 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BDIo3tt021888;
        Sun, 13 Dec 2020 18:50:03 GMT
Received: from Junxiaos-MacBook-Pro.local (/73.231.9.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 13 Dec 2020 10:50:02 -0800
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
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <d116ead4-f603-7e0c-e6ab-e721332c9832@oracle.com>
Date:   Sun, 13 Dec 2020 10:49:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CALYGNiN2F8gcKX+2nKOi1tapquJWfyzUkajWxTqgd9xvd7u1AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012130147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012130148
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/20 11:32 PM, Konstantin Khlebnikov wrote:

> On Thu, Dec 10, 2020 at 2:01 AM Junxiao Bi <junxiao.bi@oracle.com 
> <mailto:junxiao.bi@oracle.com>> wrote:
>
>     Hi Konstantin,
>
>     We tested this patch set recently and found it limiting negative
>     dentry
>     to a small part of total memory. And also we don't see any
>     performance
>     regression on it. Do you have any plan to integrate it into
>     mainline? It
>     will help a lot on memory fragmentation issue causing by dentry slab,
>     there were a lot of customer cases where sys% was very high since
>     most
>     cpu were doing memory compaction, dentry slab was taking too much
>     memory
>     and nearly all dentry there were negative.
>
>
> Right now I don't have any plans for this. I suspect such problems will
> appear much more often since machines are getting bigger.
> So, somebody will take care of it.
We already had a lot of customer cases. It made no sense to leave so 
many negative dentry in the system, it caused memory fragmentation and 
not much benefit.
>
> First part which collects negative dentries at the end list of 
> siblings could be
> done in a more obvious way by splitting the list in two.
> But this touches much more code.
That would add new field to dentry?
>
> Last patch isn't very rigid but does non-trivial changes.
> Probably it's better to call some garbage collector thingy periodically.
> Lru list needs pressure to age and reorder entries properly.

Swap the negative dentry to the head of hash list when it get accessed? 
Extra ones can be easily trimmed when swapping, using GC is to reduce 
perf impact?

Thanks,

Junxioao.

>
> Gc could be off by default or thresholds set very high (50% of ram for 
> example).
> Final setup could be left up to owners of large systems, which needs 
> fine tuning.
