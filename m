Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3518ABD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 05:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCSEgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 00:36:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726614AbgCSEgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 00:36:49 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02J4XxZZ116736
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 00:36:48 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu7wdm92u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 00:36:48 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 19 Mar 2020 04:36:46 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Mar 2020 04:36:42 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02J4ZeEZ41025806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 04:35:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45A355204E;
        Thu, 19 Mar 2020 04:36:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.46.3])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C505752050;
        Thu, 19 Mar 2020 04:36:39 +0000 (GMT)
Subject: Re: [PATCH] ext4: Check for non-zero journal inum in
 ext4_calculate_overhead
To:     Eric Sandeen <sandeen@sandeen.net>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, Harish Sriram <harish@linux.ibm.com>
References: <20200316093038.25485-1-riteshh@linux.ibm.com>
 <c43090c0-ce45-0737-68a5-ffe3e362012e@sandeen.net>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 19 Mar 2020 10:06:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c43090c0-ce45-0737-68a5-ffe3e362012e@sandeen.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031904-0016-0000-0000-000002F39DE1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031904-0017-0000-0000-0000335725B6
Message-Id: <20200319043639.C505752050@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_10:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190017
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/18/20 11:57 PM, Eric Sandeen wrote:
> On 3/16/20 4:30 AM, Ritesh Harjani wrote:
>> While calculating overhead for internal journal, also check
>> that j_inum shouldn't be 0. Otherwise we get below error with
>> xfstests generic/050 with external journal (XXX_LOGDEV config) enabled.
>>
>> It could be simply reproduced with loop device with an external journal
>> and marking blockdev as RO before mounting.
>>
>> [ 3337.146838] EXT4-fs error (device pmem1p2): ext4_get_journal_inode:4634: comm mount: inode #0: comm mount: iget: illegal inode #
>> ------------[ cut here ]------------
>> generic_make_request: Trying to write to read-only block-device pmem1p2 (partno 2)
> 
> I think this 2nd error comes from:
> 
> static void save_error_info(struct super_block *sb, const char *func,
>                              unsigned int line)
> {
>          __save_error_info(sb, func, line);
>          ext4_commit_super(sb, 1);
> }
> 
> __save_error_info() returns if bdev_read_only() but then we try to commit the super
> anyway.  Shouldn't save_error_info() return early if bdev_read_only()?
> 
> (that'd be a separate patch, I'll send it)

Thanks. Sounds good to me.


> 
> -Eric
> 

