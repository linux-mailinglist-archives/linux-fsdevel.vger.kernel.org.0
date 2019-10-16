Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A8AD9111
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 14:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393110AbfJPMfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 08:35:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728490AbfJPMfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:35:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9GCSh4U146918
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 08:35:16 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vp2c0tes6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 08:35:15 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 16 Oct 2019 13:35:13 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 13:35:11 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9GCZARi44433520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 12:35:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34023A4068;
        Wed, 16 Oct 2019 12:35:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E80DA405C;
        Wed, 16 Oct 2019 12:35:08 +0000 (GMT)
Received: from [9.199.158.105] (unknown [9.199.158.105])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 12:35:08 +0000 (GMT)
Subject: Re: [RFC 1/2] ext4: Move ext4 bmap to use iomap infrastructure.
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        tytso@mit.edu, mbobrowski@mbobrowski.org,
        linux-fsdevel@vger.kernel.org
References: <20190820130634.25954-1-riteshh@linux.ibm.com>
 <20190820130634.25954-2-riteshh@linux.ibm.com>
 <20191016083108.GA30337@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 16 Oct 2019 18:05:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191016083108.GA30337@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101612-0020-0000-0000-0000037994F9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101612-0021-0000-0000-000021CFB900
Message-Id: <20191016123508.5E80DA405C@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/16/19 2:01 PM, Jan Kara wrote:
> On Tue 20-08-19 18:36:33, Ritesh Harjani wrote:
>> ext4_iomap_begin is already implemented which provides
>> ext4_map_blocks, so just move the API from
>> generic_block_bmap to iomap_bmap for iomap conversion.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> This seems to have fallen through the cracks. The patch looks OK, feel free
> to add:

Np. Thanks for the review :)


> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 	
> 								Honza
> 
>> ---
>>   fs/ext4/inode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 420fe3deed39..d6a34214e9df 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3355,7 +3355,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>>   			return 0;
>>   	}
>>   
>> -	return generic_block_bmap(mapping, block, ext4_get_block);
>> +	return iomap_bmap(mapping, block, &ext4_iomap_ops);
>>   }
>>   
>>   static int ext4_readpage(struct file *file, struct page *page)
>> -- 
>> 2.21.0
>>

