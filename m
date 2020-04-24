Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7150B1B8218
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 00:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgDXWji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 18:39:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbgDXWji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 18:39:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OMWj5i139670;
        Fri, 24 Apr 2020 18:39:22 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30k7rnqbee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 18:39:21 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03OMZm80004249;
        Fri, 24 Apr 2020 22:39:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 30fs659mdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 22:39:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03OMcAPX60621138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 22:38:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D466B4C05C;
        Fri, 24 Apr 2020 22:39:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5EB74C059;
        Fri, 24 Apr 2020 22:39:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.185.245])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Apr 2020 22:39:15 +0000 (GMT)
Subject: Re: [PATCH 2/2] iomap: bmap: Remove the WARN and return the proper
 block address
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e2e09c5d840458b4ace6f9b31429ceefd9c1df01.1587670914.git.riteshh@linux.ibm.com>
 <20200424174815.GF6733@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 25 Apr 2020 04:09:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200424174815.GF6733@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200424223915.D5EB74C059@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_13:2020-04-24,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240165
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/24/20 11:18 PM, Darrick J. Wong wrote:
> On Fri, Apr 24, 2020 at 12:52:18PM +0530, Ritesh Harjani wrote:
>> iomap_bmap() could be called from either of these two paths.
>> Either when a user is calling an ioctl_fibmap() interface to get
>> the block mapping address or by some filesystem via use of bmap()
>> internal kernel API.
>> bmap() kernel API is well equipped with handling of u64 addresses.
>>
>> WARN condition in iomap_bmap_actor() was mainly added to warn all
>> the fibmap users. But now that in previous patch we have directly added
>> this WARN condition for all fibmap users and also made sure to return 0
>> as block map address in case if addr > INT_MAX.
>> So we can now remove this logic from here.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   fs/iomap/fiemap.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
>> index bccf305ea9ce..d55e8f491a5e 100644
>> --- a/fs/iomap/fiemap.c
>> +++ b/fs/iomap/fiemap.c
>> @@ -117,10 +117,7 @@ iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
>>   
>>   	if (iomap->type == IOMAP_MAPPED) {
>>   		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
>> -		if (addr > INT_MAX)
>> -			WARN(1, "would truncate bmap result\n");
> 
> Frankly I would've combined these two patches to make it more obvious
> that we're hoisting a FIBMAP constraint check from iomap into the ioctl
> handler.

Sure, let me combine the two in v2.

Thanks!!
-ritesh

> 
> --D
> 
>> -		else
>> -			*bno = addr;
>> +		*bno = addr;
>>   	}
>>   	return 0;
>>   }
>> -- 
>> 2.21.0
>>
