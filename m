Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8924BDA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 15:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgHTNKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 09:10:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728762AbgHTNJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:09:38 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KD2CXq030836;
        Thu, 20 Aug 2020 09:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=o9TyYL3CUeDWcjaJivIo7lPu6CidluEG3TmZxmgWp4Q=;
 b=tF9K4dnoe+BjKneJP99iaqGFfTRP40FfgD8gdygX817JQDRMlKn+yAZeSdM5kc1ZsMPE
 u8UZfScQeBb0xRmJa7P1lVf+8fCAhaHIm9Hh0pIhZYT5FpYsn4ikM05bY1/ErH656Qpg
 9h8NclhTnGAjlsQApADXJsm+KiBXHiW4qSTQJfUX+/wBtv7PbaTaQXHPHtPToEKyxVks
 QgRCqHjpGRa8rDdqSHkQdwgDpmVKH9o4nXn8yVvxAwgY0DvLyptUe4pFo+yGYQJxGrVz
 rKeB6JtpR5o1ZiuBng/xi0uCfZuxHID1zTmb4adqd5m1S7MvdkAQxw50tcHANZ7QCe2i hQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3314mx4jky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 09:09:33 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KD4xsQ015558;
        Thu, 20 Aug 2020 13:09:30 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3304ujsxas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 13:09:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07KD9Saf56295740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 13:09:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93ECD4C040;
        Thu, 20 Aug 2020 13:09:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F1CA4C046;
        Thu, 20 Aug 2020 13:09:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Aug 2020 13:09:27 +0000 (GMT)
Subject: Re: [RFC 1/1] ext4: Optimize ext4 DAX overwrites
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <cover.1597855360.git.riteshh@linux.ibm.com>
 <696f5386f1c306e769be409c8b1d90a3358bbf8d.1597855360.git.riteshh@linux.ibm.com>
 <20200820125300.GK1902@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 20 Aug 2020 18:39:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200820125300.GK1902@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200820130927.7F1CA4C046@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_03:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200104
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/20/20 6:23 PM, Jan Kara wrote:
> On Thu 20-08-20 17:06:28, Ritesh Harjani wrote:
>> Currently in case of DAX, we are starting a transaction
>> everytime for IOMAP_WRITE case. This can be optimized
>> away in case of an overwrite (where the blocks were already
>> allocated). This could give a significant performance boost
>> for multi-threaded random writes.
>>
>> Reported-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> Thanks for returning to this and I'm glad to see how much this helped :)
> BTW, I'd suspect there could be also significant contention and cache line
> bouncing on j_state_lock and transaction's atomic counters...

ok, will try and profile to see if this happens.


> 
>> ---
>>   fs/ext4/ext4.h  | 1 +
>>   fs/ext4/file.c  | 2 +-
>>   fs/ext4/inode.c | 8 +++++++-
>>   3 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 42f5060f3cdf..9a2138afc751 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -3232,6 +3232,7 @@ extern const struct dentry_operations ext4_dentry_ops;
>>   extern const struct inode_operations ext4_file_inode_operations;
>>   extern const struct file_operations ext4_file_operations;
>>   extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
>> +extern bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len);
>>   
>>   /* inline.c */
>>   extern int ext4_get_max_inline_size(struct inode *inode);
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index 2a01e31a032c..51cd92ac1758 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -188,7 +188,7 @@ ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
>>   }
>>   
>>   /* Is IO overwriting allocated and initialized blocks? */
>> -static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
>> +bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
>>   {
>>   	struct ext4_map_blocks map;
>>   	unsigned int blkbits = inode->i_blkbits;
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 10dd470876b3..f0ac0ee9e991 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3423,6 +3423,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>   	int ret;
>>   	struct ext4_map_blocks map;
>>   	u8 blkbits = inode->i_blkbits;
>> +	bool overwrite = false;
>>   
>>   	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>>   		return -EINVAL;
>> @@ -3430,6 +3431,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>   	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
>>   		return -ERANGE;
>>   
>> +	if (IS_DAX(inode) && (flags & IOMAP_WRITE) &&
>> +	    ext4_overwrite_io(inode, offset, length))
>> +		overwrite = true;
> 
> So the patch looks correct but using ext4_overwrite_io() seems a bit
> foolish since under the hood it does ext4_map_blocks() only to be able to
> decide whether to call ext4_map_blocks() once again with exactly the same
> arguments :). So I'd rather slightly refactor the code in
> ext4_iomap_begin() to avoid this double calling of ext4_map_blocks() for
> the fast path.

Yes, agreed. Looking at the numbers I was excited to post out the RFC
for discussion. Will make above changes and post. :)


With DIO, we need to detect overwrite case early in
ext4_dio_write_iter() to determine whether we need shared or excl.
locks - so probably for DIO case we still need overwrite check in
ext4_dio_write_iter()

Thanks for review!!
-ritesh


> 
> 								Honza
> 
>>   	/*
>>   	 * Calculate the first and last logical blocks respectively.
>>   	 */
>> @@ -3437,13 +3441,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>   	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>>   			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>>   
>> -	if (flags & IOMAP_WRITE)
>> +	if ((flags & IOMAP_WRITE) && !overwrite)
>>   		ret = ext4_iomap_alloc(inode, &map, flags);
>>   	else
>>   		ret = ext4_map_blocks(NULL, inode, &map, 0);
>>   
>>   	if (ret < 0)
>>   		return ret;
>> +	if (IS_DAX(inode) && overwrite)
>> +		WARN_ON(!(map.m_flags & EXT4_MAP_MAPPED));
>>   
>>   	ext4_set_iomap(inode, iomap, &map, offset, length);
>>   
>> -- 
>> 2.25.4
>>
