Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0734AE8EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 13:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392840AbfIJLQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 07:16:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730546AbfIJLQk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:16:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8ABBwKv117813
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2019 07:16:39 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ux9w49ur7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2019 07:16:39 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 10 Sep 2019 12:16:37 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Sep 2019 12:16:34 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8ABGXf232833564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 11:16:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F0E74C044;
        Tue, 10 Sep 2019 11:16:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08C5A4C052;
        Tue, 10 Sep 2019 11:16:31 +0000 (GMT)
Received: from [9.199.159.63] (unknown [9.199.159.63])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Sep 2019 11:16:30 +0000 (GMT)
Subject: Re: [PATCH v2 2/6] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
 <c1e9b23ced988587dfec399021a5b62983745842.1567978633.git.mbobrowski@mbobrowski.org>
 <20190909081729.3555C42041@d06av24.portsmouth.uk.ibm.com>
 <20190910102643.GA9013@bobrowski>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 10 Sep 2019 16:46:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190910102643.GA9013@bobrowski>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091011-4275-0000-0000-00000363EAB9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091011-4276-0000-0000-000038763E83
Message-Id: <20190910111631.08C5A4C052@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=667 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100113
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/10/19 3:56 PM, Matthew Bobrowski wrote:
> On Mon, Sep 09, 2019 at 01:47:28PM +0530, Ritesh Harjani wrote:
>> On 9/9/19 4:49 AM, Matthew Bobrowski wrote:
>>> +static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
>>> +				       ssize_t len, size_t count)
>>> +{
>>> +	handle_t *handle;
>>> +	bool truncate = false;
>>> +	ext4_lblk_t written_blk, end_blk;
>>> +	int ret = 0, blkbits = inode->i_blkbits;
>>> +
>>> +	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
>>> +	if (IS_ERR(handle)) {
>>> +		ret = PTR_ERR(handle);
>>> +		goto orphan_del;
>>> +	}
>>> +
>>> +	if (ext4_update_inode_size(inode, offset + len))
>>> +		ext4_mark_inode_dirty(handle, inode);
>>> +
>>> +	/*
>>> +	 * We may need truncate allocated but not written blocks
>>> +	 * beyond EOF.
>>> +	 */
>>> +	written_blk = ALIGN(offset + len, 1 << blkbits);
>>> +	end_blk = ALIGN(offset + len + count, 1 << blkbits);
>>
>> why add len in end_blk calculation?
>> shouldn't this be like below?
>> 	end_blk = ALIGN(offset + count, 1 << blkbits);
> 
> I don't believe that would be entirely correct. The reason being is that the
> 'end_blk' is meant to represent the last logical block which we should expect
> to have used for the write operation. So, we have the 'offset' which
> represents starting point, 'len' which is the amount of data that has been
> written, and 'count' which is the amount of data that we still have left over
> in the 'iter', if any.
> 

Agree. Yes, I see that you are passing iov_iter_count(from) as a param,
after the dax write.


> The count in the 'iter' is decremented as that data is copied from it. So if > we did use 'offset' + 'count', in the instance of a short write, we
> potentially wouldn't truncate any of the allocated but not written blocks. I
> guess this would hold true for the DAX code path at this point, seeing as
> though for the DIO case we pass in '0'.

Agreed.


> 
>>> +/*
>>> + * The inode may have been placed onto the orphan list or has had
>>> + * blocks allocated beyond EOF as a result of an extension. We need to
>>> + * ensure that any necessary cleanup routines are performed if the
>>> + * error path has been taken for a write.
>>> + */
>>> +static int ext4_handle_failed_inode_extension(struct inode *inode, loff_t size)
>>> +{
>>> +	int ret = 0;
>>
>> No need of ret anyways.
>>
>>
>>> +	handle_t *handle;
>>> +
>>> +	if (size > i_size_read(inode))
>>> +		ext4_truncate_failed_write(inode);
>>> +
>>> +	if (!list_empty(&EXT4_I(inode)->i_orphan)) {
>>> +		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
>>> +		if (IS_ERR(handle)) {
>>> +			if (inode->i_nlink)
>>> +				ext4_orphan_del(NULL, inode);
>>> +			return PTR_ERR(handle);
>>> +		}
>>> +		if (inode->i_nlink)
>>> +			ext4_orphan_del(handle, inode);
>>> +		ext4_journal_stop(handle);
>>> +	}
>>> +	return ret;
>>
>> can directly call for `return 0;`
> 
> True.
> 
> --<M>--
> 

