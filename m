Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006931BB785
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 09:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgD1HaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 03:30:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726253AbgD1HaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:30:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S73jID118684;
        Tue, 28 Apr 2020 03:30:05 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mh332h84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 03:30:05 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03S7PSPe014807;
        Tue, 28 Apr 2020 07:30:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 30mcu6wkkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 07:30:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03S7U1Mv62194072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 07:30:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AA4C11C058;
        Tue, 28 Apr 2020 07:30:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 439AA11C04C;
        Tue, 28 Apr 2020 07:29:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.36])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Apr 2020 07:29:57 +0000 (GMT)
Subject: Re: [PATCH 1/2] fibmap: Warn and return an error in case of block >
 INT_MAX
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
 <20200424191739.GA217280@gmail.com>
 <20200424225425.6521D4C040@d06av22.portsmouth.uk.ibm.com>
 <20200424234058.GA29705@bombadil.infradead.org>
 <20200424234647.GX6749@magnolia>
 <20200425070335.B43334C046@d06av22.portsmouth.uk.ibm.com>
 <20200427010444.GF2040@dread.disaster.area>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 28 Apr 2020 12:59:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200427010444.GF2040@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200428072958.439AA11C04C@d06av25.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_03:2020-04-27,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280056
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/27/20 6:34 AM, Dave Chinner wrote:
> On Sat, Apr 25, 2020 at 12:33:34PM +0530, Ritesh Harjani wrote:
>>
>>
>> On 4/25/20 5:16 AM, Darrick J. Wong wrote:
>>> On Fri, Apr 24, 2020 at 04:40:58PM -0700, Matthew Wilcox wrote:
>>>> On Sat, Apr 25, 2020 at 04:24:24AM +0530, Ritesh Harjani wrote:
>>>>> Ok, I see.
>>>>> Let me replace WARN() with below pr_warn() line then. If no objections,
>>>>> then will send this in a v2 with both patches combined as Darrick
>>>>> suggested. - (with Reviewed-by tags of Jan & Christoph).
>>>>>
>>>>> pr_warn("fibmap: this would truncate fibmap result\n");
>>>>
>>>> We generally don't like userspace to be able to trigger kernel messages
>>>> on demand, so they can't swamp the logfiles.  printk_ratelimited()?
>>>
>>> Or WARN_ON_ONCE...
>>
>> So, Eric was mentioning WARN_** are mostly for kernel side of bugs.
>> But this is mostly a API fault which affects user side and also to
>> warn the user about the possible truncation in the block fibmap
>> addr.
>> Also WARN_ON_ONCE, will be shown only once and won't be printed for
>> every other file for which block addr > INT_MAX.
>>
>> I think we could go with below. If ok, I could post this in v2.
>>
>> pr_warn_ratelimited("fibmap: would truncate fibmap result\n");
> 
> Please include the process ID, the superblock ID and the task name
> that is triggering this warning. Otherwise the administrator will
> have no clue what is generating it and so won't be able to fix it...
> 
Thanks for the suggestion. I will make it like below then.
Will send a v2 soon.

+		pr_warn_ratelimited("[%s/%d] FS (%s): would truncate fibmap result\n",
+				    current->comm, task_pid_nr(current),
+				    sb->s_id);
+
