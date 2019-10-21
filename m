Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3BDF3FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 19:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfJURR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 13:17:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34202 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJURR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:17:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9LHE46M001776;
        Mon, 21 Oct 2019 17:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=OpkRaCWF2qDBVykaI/XxNsWSb7anFkMjeWBRhjnn1YI=;
 b=I2zxo+ej7j+p1paawN/abGNrusvpJymcnhtFTpvuZ3kK4vU7f9yg0Dg0QEd17iqi5ji9
 /lmFRM9Ki8mzBx4+OAARaDorxg0rkAOaVnfNeOCMb7YyVDtP44UFy0KwR7ADqGtzcawx
 3/ycbQ0MDA4osNdCbxAxz+PqtMvehbmoBLEiXQpJoJGEvpRp3jYw1QEZ6ErTsTbildL8
 Z7NZXqhGejiOdfoBcZXLLR4UtHSVo1aQtT6nVzOMFLwq4hLTQoXr1c+eaSflfAMH8Y2t
 9FxjMKvWDDNHdbatX9NZmZqO+WMcLD+4ul1mb6cXRisPY+qfJNQWKAzuwCa8Lwnn1i8s OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vqteph6dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Oct 2019 17:17:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9LH9TcB081920;
        Mon, 21 Oct 2019 17:17:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vrcmnjbws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Oct 2019 17:17:19 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9LHHF4m004720;
        Mon, 21 Oct 2019 17:17:18 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 10:17:14 -0700
Subject: Re: [PATCH] hugetlbfs: add O_TMPFILE support
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Piotr Sarna <p.sarna@tlen.pl>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
References: <22c29acf9c51dae17802e1b05c9e5e4051448c5c.1571129593.git.p.sarna@tlen.pl>
 <20191015105055.GA24932@dhcp22.suse.cz>
 <766b4370-ba71-85a2-5a57-ca9ed7dc7870@oracle.com>
Message-ID: <eb6206ee-eb2e-ffbc-3963-d80eec04119c@oracle.com>
Date:   Mon, 21 Oct 2019 10:17:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <766b4370-ba71-85a2-5a57-ca9ed7dc7870@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=954
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210164
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/15/19 4:37 PM, Mike Kravetz wrote:
> On 10/15/19 3:50 AM, Michal Hocko wrote:
>> On Tue 15-10-19 11:01:12, Piotr Sarna wrote:
>>> With hugetlbfs, a common pattern for mapping anonymous huge pages
>>> is to create a temporary file first.
>>
>> Really? I though that this is normally done by shmget(SHM_HUGETLB) or
>> mmap(MAP_HUGETLB). Or maybe I misunderstood your definition on anonymous
>> huge pages.
>>
>>> Currently libraries like
>>> libhugetlbfs and seastar create these with a standard mkstemp+unlink
>>> trick,
> 
> I would guess that much of libhugetlbfs was writen before MAP_HUGETLB
> was implemented.  So, that is why it does not make (more) use of that
> option.
> 
> The implementation looks to be straight forward.  However, I really do
> not want to add more functionality to hugetlbfs unless there is specific
> use case that needs it.

It was not my intention to shut down discussion on this patch.  I was just
asking if there was a (new) use case for such a change.  I am checking with
our DB team as I seem to remember them using the create/unlink approach for
hugetlbfs in one of their upcoming models.  

Is there a new use case you were thinking about?
-- 
Mike Kravetz
