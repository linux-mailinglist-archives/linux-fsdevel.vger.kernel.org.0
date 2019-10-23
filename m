Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60042E1044
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 04:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbfJWC6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 22:58:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53666 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733043AbfJWC6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:58:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N2rSK7067277;
        Wed, 23 Oct 2019 02:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=2Up8um5UIS0VhuMduC1NXXp0gaaP6t0HuUDLRAHsUvM=;
 b=ajFwd5JQWrXwpeiJePU8s4LEpwEIM1ib800J6VbMzBTS2mh+BaD0zzoKpk9EmGwry5bM
 O1gzfQUK9rJG3KFbRQKOU3dO0IgkwJDZBnLwfyE9SkKNL3fnN8W7UTyYEy9kaL+eX4ha
 6GdJS+EdHxVJoSxOHEd0Jleda79vhMci8con7D/e0vbIbWlyp7JSOn0fsz/MJSwcfm/Q
 0ktZJhLGkShucagqW05vM/fRTN3rQqi2dZcu3PlRbIQVkl1qTYpjs+/qXdVnaAXkSqEm
 f7zbIuCJWfVy+HgJkaVFXgXC+jXbOSO0Wuu+mOprFZB4RRAz/VxsdJID9vaUk52IBcxO Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vqswtjh57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 02:58:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N2rDGj098504;
        Wed, 23 Oct 2019 02:56:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vsx242q9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 02:56:04 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9N2tx9r002359;
        Wed, 23 Oct 2019 02:56:02 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 19:55:59 -0700
Subject: Re: [PATCH] hugetlbfs: add O_TMPFILE support
To:     Piotr Sarna <p.sarna@tlen.pl>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
References: <22c29acf9c51dae17802e1b05c9e5e4051448c5c.1571129593.git.p.sarna@tlen.pl>
 <20191015105055.GA24932@dhcp22.suse.cz>
 <766b4370-ba71-85a2-5a57-ca9ed7dc7870@oracle.com>
 <eb6206ee-eb2e-ffbc-3963-d80eec04119c@oracle.com>
 <c0415816-2682-7bf5-2c82-43c3a8941a54@tlen.pl>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d29bc957-a074-22f6-51d7-e043719d5f98@oracle.com>
Date:   Tue, 22 Oct 2019 19:55:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c0415816-2682-7bf5-2c82-43c3a8941a54@tlen.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230028
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/22/19 12:09 AM, Piotr Sarna wrote:
> On 10/21/19 7:17 PM, Mike Kravetz wrote:
>> On 10/15/19 4:37 PM, Mike Kravetz wrote:
>>> On 10/15/19 3:50 AM, Michal Hocko wrote:
>>>> On Tue 15-10-19 11:01:12, Piotr Sarna wrote:
>>>>> With hugetlbfs, a common pattern for mapping anonymous huge pages
>>>>> is to create a temporary file first.
>>>>
>>>> Really? I though that this is normally done by shmget(SHM_HUGETLB) or
>>>> mmap(MAP_HUGETLB). Or maybe I misunderstood your definition on anonymous
>>>> huge pages.
>>>>
>>>>> Currently libraries like
>>>>> libhugetlbfs and seastar create these with a standard mkstemp+unlink
>>>>> trick,
>>>
>>> I would guess that much of libhugetlbfs was writen before MAP_HUGETLB
>>> was implemented.  So, that is why it does not make (more) use of that
>>> option.
>>>
>>> The implementation looks to be straight forward.  However, I really do
>>> not want to add more functionality to hugetlbfs unless there is specific
>>> use case that needs it.
>>
>> It was not my intention to shut down discussion on this patch.  I was just
>> asking if there was a (new) use case for such a change.  I am checking with
>> our DB team as I seem to remember them using the create/unlink approach for
>> hugetlbfs in one of their upcoming models.
>>
>> Is there a new use case you were thinking about?
>>
> 
> Oh, I indeed thought it was a shutdown. The use case I was thinking about was in Seastar, where the create+unlink trick is used for creating temporary files (in a generic way, not only for hugetlbfs). I simply intended to migrate it to a newer approach - O_TMPFILE. However,
> for the specific case of hugetlbfs it indeed makes more sense to skip it and use mmap's MAP_HUGETLB, so perhaps it's not worth it to patch a perfectly good and stable file system just to provide a semi-useful flag support. My implementation of tmpfile for hugetlbfs is straightforward indeed, but the MAP_HUGETLB argument made me realize that it may not be worth the trouble - especially that MAP_HUGETLB is here since 2.6 and O_TMPFILE was introduced around v3.11, so the mmap way looks more portable.
> 
> tldr: I'd be very happy to get my patch accepted, but the use case I had in mind can be easily solved with MAP_HUGETLB, so I don't insist.

If you really are after something like 'anonymous memory' for Seastar,
then MAP_HUGETLB would be the better approach.

I'm still checking with Oracle DB team as they may have a use for O_TMPFILE
in an upcoming release.  In their use case, they want an open fd to work with.
If it looks like they will proceed in this direction, we can work to get
your patch moved forward.

Thanks,
-- 
Mike Kravetz
