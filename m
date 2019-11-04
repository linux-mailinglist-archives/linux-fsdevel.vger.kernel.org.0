Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 554DCEDCB2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfKDKiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:38:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbfKDKiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:38:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA4AVYh5128498
        for <linux-fsdevel@vger.kernel.org>; Mon, 4 Nov 2019 05:38:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w2habjtrw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2019 05:38:07 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 4 Nov 2019 10:38:05 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Nov 2019 10:38:02 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA4Ac1uh48824450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Nov 2019 10:38:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C45D74C052;
        Mon,  4 Nov 2019 10:38:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4085C4C046;
        Mon,  4 Nov 2019 10:37:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.82.150])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Nov 2019 10:37:58 +0000 (GMT)
Subject: Re: [RFC 0/5] Ext4: Add support for blocksize < pagesize for
 dioread_nolock
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
 <20191023232614.GB1124@mit.edu>
 <20191029071925.60AABA405B@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20191103191606.GB8037@mit.edu> <20191104101623.GB27115@bobrowski>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 4 Nov 2019 16:07:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191104101623.GB27115@bobrowski>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19110410-0012-0000-0000-000003607AF0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110410-0013-0000-0000-0000219BCEF3
Message-Id: <20191104103759.4085C4C046@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911040102
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/4/19 3:46 PM, Matthew Bobrowski wrote:
> On Sun, Nov 03, 2019 at 02:16:06PM -0500, Theodore Y. Ts'o wrote:
>> On Tue, Oct 29, 2019 at 12:49:24PM +0530, Ritesh Harjani wrote:
>>>
>>> So it looks like these failed tests does not seem to be because of this
>>> patch series. But these are broken in general for at least 1K blocksize.
>>
>> Agreed, I failed to add them to the exclude list for diread_nolock_1k.
>> Thanks for pointing that out!
>>
>> After looking through these patches, it looks good.  So, I've landed
>> this series on the ext4 git tree.
>>
>> There are some potential conflicts with Matthew's DIO using imap patch
>> set.  I tried resolving them in the obvious way (see the tt/mb-dio
>> branch[1] on ext4.git), and unfortunately, there is a flaky test
>> failure with generic/270 --- 2 times out 30 runs of generic/270, the
>> file system is left inconsistent, with problems found in the block
>> allocation bitmap.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=tt/mb-dio
>>
>> I've verified that generic/270 isn't a problem on -rc3, and it's not a
>> problem with just your patch series.  So, it's almost certain it's
>> because I screwed up the merge.  I applied each of Matthew's patch one
>> at a time, and conflict was in changes in ext4_end_io_dio, which is
>> dropped in Matthew's patch.  It wasn't obvious though where the
>> dioread-nolock-1k change should be applied in Matthew's patch series.
>> Could you take a look?  Thanks!!
> 
> Hang on a second.
> 
> Are we not prematurely merging this series in with master? I thought
> that this is something that should've come after the iomap direct I/O
> port, no? The use of io_end's within the new direct I/O implementation
> are effectively redundant...

It sure may be giving a merge conflict (due to io_end structure).
But this dioread_nolock series was not dependent over iomap series.

-ritesh

