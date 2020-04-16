Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938211ABA1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 09:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439495AbgDPHjT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 03:39:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439328AbgDPHjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:39:17 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03G7YWSX063299
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 03:39:12 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ebg3kupv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 03:39:12 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 16 Apr 2020 08:38:32 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Apr 2020 08:38:28 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03G7bwF544499322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 07:37:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8670DA405C;
        Thu, 16 Apr 2020 07:39:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A1E3A405F;
        Thu, 16 Apr 2020 07:39:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.90.179])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Apr 2020 07:38:59 +0000 (GMT)
Subject: Re: [RFC 1/1] ext4: Fix overflow case for map.m_len in
 ext4_iomap_begin_*
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org, adilger@dilger.ca,
        darrick.wong@oracle.com, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-unionfs@vger.kernel.org,
        syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
References: <00000000000048518b05a2fef23a@google.com>
 <dea98f0b07e16de219d8741c1fefc7cb476cb482.1586681010.git.riteshh@linux.ibm.com>
 <20200414155013.GF28226@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 16 Apr 2020 13:08:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200414155013.GF28226@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20041607-0016-0000-0000-00000305759E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041607-0017-0000-0000-000033697825
Message-Id: <20200416073901.8A1E3A405F@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_02:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=889
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160045
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Sorry Jan and others. Please ignore this patch.
I will resend a proper one after making sure it is tested via syzbot.

On 4/14/20 9:20 PM, Jan Kara wrote:
> On Sun 12-04-20 14:54:35, Ritesh Harjani wrote:
>> EXT4_MAX_LOGICAL_BLOCK - map.m_lblk + 1 in case when
>> map.m_lblk (offset) is 0 could overflow an unsigned int
>> and become 0.
>>
>> Fix this.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> Reported-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
>> Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
>> ---
>>   fs/ext4/inode.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index e416096fc081..d630ec7a9c8e 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3424,6 +3424,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>   	int ret;
>>   	struct ext4_map_blocks map;
>>   	u8 blkbits = inode->i_blkbits;
>> +	loff_t len;
>>   
>>   	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>>   		return -EINVAL;
>> @@ -3435,8 +3436,11 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>   	 * Calculate the first and last logical blocks respectively.
>>   	 */
>>   	map.m_lblk = offset >> blkbits;
>> -	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>> +	len = min_t(loff_t, (offset + length - 1) >> blkbits,
>>   			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>> +	if (len > EXT4_MAX_LOGICAL_BLOCK)
>> +		len = EXT4_MAX_LOGICAL_BLOCK;
>> +	map.m_len = len;
>>   
>>   	if (flags & IOMAP_WRITE)
>>   		ret = ext4_iomap_alloc(inode, &map, flags);
>> @@ -3524,6 +3528,7 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>>   	bool delalloc = false;
>>   	struct ext4_map_blocks map;
>>   	u8 blkbits = inode->i_blkbits;
>> +	loff_t len
>>   
>>   	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>>   		return -EINVAL;
>> @@ -3541,8 +3546,11 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>>   	 * Calculate the first and last logical block respectively.
>>   	 */
>>   	map.m_lblk = offset >> blkbits;
>> -	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>> +	len = min_t(loff_t, (offset + length - 1) >> blkbits,
>>   			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>> +	if (len > EXT4_MAX_LOGICAL_BLOCK)
>> +		len = EXT4_MAX_LOGICAL_BLOCK;
>> +	map.m_len = len;
>>   
>>   	/*
>>   	 * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
>> -- 
>> 2.21.0
>>

