Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E03B4BA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfIQKMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 06:12:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727240AbfIQKMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:12:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8HA5aD0060246
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 06:12:29 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v2vx7stbw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 06:12:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 17 Sep 2019 11:12:27 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Sep 2019 11:12:22 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8HACLFJ19136644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 10:12:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B04C55205A;
        Tue, 17 Sep 2019 10:12:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3568352052;
        Tue, 17 Sep 2019 10:12:20 +0000 (GMT)
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        darrick.wong@oracle.com
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916121248.GD4005@infradead.org> <20190916223741.GA5936@bobrowski>
 <20190917090016.266CB520A1@d06av21.portsmouth.uk.ibm.com>
 <20190917090233.GB29487@infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 17 Sep 2019 15:42:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190917090233.GB29487@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091710-0008-0000-0000-000003176F8B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091710-0009-0000-0000-00004A35ECD0
Message-Id: <20190917101220.3568352052@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=686 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170103
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/17/19 2:32 PM, Christoph Hellwig wrote:
> On Tue, Sep 17, 2019 at 02:30:15PM +0530, Ritesh Harjani wrote:
>> So if we have a delayed buffered write to a file,
>> in that case we first only update inode->i_size and update
>> i_disksize at writeback time
>> (i.e. during block allocation).
>> In that case when we call for ext4_dio_write_iter
>> since offset + len > i_disksize, we call for ext4_update_i_disksize().
>>
>> Now if writeback for some reason failed. And the system crashes, during the
>> DIO writes, after the blocks are allocated. Then during reboot we may have
>> an inconsistent inode, since we did not add the inode into the
>> orphan list before we updated the inode->i_disksize. And journal replay
>> may not succeed.
>>
>> 1. Can above actually happen? I am still not able to figure out the
>>     race/inconsistency completely.
>> 2. Can you please help explain under what other cases
>>     it was necessary to call ext4_update_i_disksize() in DIO write paths?
>> 3. When will i_disksize be out-of-sync with i_size during DIO writes?
> 
> None of the above seems new in this patchset, does it?  That being said


In original code before updating i_disksize in ext4_direct_IO_write,
we used to add the inode into the orphan list (which will mark the iloc
dirty and also update the ondisk inode size). Only then we update the 
i_disksize to inode->i_size (which still I don't understand the
reason to put inside open journal handle).

So in case if the crash happens, then in the recovery, we can replay the
journal and we truncate any extra blocks beyond i_size.
(ext4_orphan_cleanup()).


In new iomap implementation (i.e. this patchset), we are doing this in
reverse.

We first call for ext4_update_i_disksize() in ext4_dio_write_iter(),
and then in ext4_iomap_begin() after ext4_map_blocks(),
we add the inode to orphan list, which I am not really sure whether it 
is really consistent with on disk size??



> I found the early size update odd.  XFS updates the on-disk size only
> at I/O completion time to deal with various races including the
> potential exposure of stale data.
> 

Yes, can't really say why it is the case in ext4.
That's mostly what I wanted to understand from previous queries.


-ritesh

