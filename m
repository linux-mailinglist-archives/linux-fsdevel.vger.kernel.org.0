Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6724352E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 09:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHMHqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 03:46:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40902 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMHqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:46:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07D7g8vu134750;
        Thu, 13 Aug 2020 07:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1MX3Zx2lAV/2UR78cqQ4np2FmrbW68MrXye6TvNF6z8=;
 b=XEX2+JsCOP1FjleAxNmKy6cPA1aTpr1Z4OyqsAMbOpR1U9kQf9by8BeNhbZvc4kqcFh1
 4vOjOyd1fjK+72rPNgPcGr+w9e6JIvZqfpk1NXgiK/iBlJlYd4uEsL7FlWNqC511EBOT
 xB2P0g4XD5gqZi/e57oxndVb122DQ/laY4yuIa+q135HAHhJ5QhW3LI5MnqW3hTr53Lp
 b8OU0Y99hecJjRiOEyM3kB3bp0r96UTrvj0VFCmf87qZZ/0aP5D+ufUdI0t0EhAzHZYu
 m29xKqSo1KFjftHQC3jKk8j1fAbWwRmi1zD/0kidNxc00WfTUU4NvCO0TFHhNCKdG1hK vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32t2ydwdn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Aug 2020 07:46:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07D7bZUY014534;
        Thu, 13 Aug 2020 07:46:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32u3h4vbse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 07:46:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07D7kKTL008965;
        Thu, 13 Aug 2020 07:46:22 GMT
Received: from [10.191.2.179] (/10.191.2.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Aug 2020 07:46:20 +0000
Subject: Re: [PATCH] block: insert a general SMP memory barrier before
 wake_up_bit()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <20200813024438.13170-1-jian.w.wen@oracle.com>
 <20200813073115.GA15436@infradead.org>
From:   Jacob Wen <jian.w.wen@oracle.com>
Message-ID: <0a1d9db5-dc5f-5718-048d-861385ce2832@oracle.com>
Date:   Thu, 13 Aug 2020 15:46:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813073115.GA15436@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130058
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/13/20 3:31 PM, Christoph Hellwig wrote:
> On Thu, Aug 13, 2020 at 10:44:38AM +0800, Jacob Wen wrote:
>> wake_up_bit() uses waitqueue_active() that needs the explicit smp_mb().
> Sounds like the barrier should go into wake_up_bit then..

wake_up_bit() doesn't know which one to chose: smp_mb__after_atomic() or 
smp_mb().

>
>> Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
>> ---
>>   fs/block_dev.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 0ae656e022fd..e74980848a2a 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -1175,6 +1175,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
>>   	/* tell others that we're done */
>>   	BUG_ON(whole->bd_claiming != holder);
>>   	whole->bd_claiming = NULL;
>> +	smp_mb();
>>   	wake_up_bit(&whole->bd_claiming, 0);
>>   }
>>   
>> -- 
>> 2.17.1
>>
> ---end quoted text---
