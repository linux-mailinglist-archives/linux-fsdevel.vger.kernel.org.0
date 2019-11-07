Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497B4F2D37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 12:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbfKGLQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 06:16:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26030 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388178AbfKGLQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:16:25 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7B8x0g035074
        for <linux-fsdevel@vger.kernel.org>; Thu, 7 Nov 2019 06:16:23 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w41w6wtdb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2019 06:16:22 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 7 Nov 2019 11:16:04 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 11:16:01 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7BG0dv64356470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 11:16:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04EA6A4053;
        Thu,  7 Nov 2019 11:16:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEC5FA4059;
        Thu,  7 Nov 2019 11:15:58 +0000 (GMT)
Received: from [9.199.158.214] (unknown [9.199.158.214])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Nov 2019 11:15:58 +0000 (GMT)
Subject: Re: [RFC 0/5] Ext4: Add support for blocksize < pagesize for
 dioread_nolock
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
 <20191106172302.GE12685@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 7 Nov 2019 16:45:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191106172302.GE12685@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19110711-0028-0000-0000-000003B383DA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110711-0029-0000-0000-00002475E350
Message-Id: <20191107111558.DEC5FA4059@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070114
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/6/19 10:53 PM, Jan Kara wrote:
> On Wed 16-10-19 13:07:06, Ritesh Harjani wrote:
>> This patch series adds the support for blocksize < pagesize for
>> dioread_nolock feature.
>>
>> Since in case of blocksize < pagesize, we can have multiple
>> small buffers of page as unwritten extents, we need to
>> maintain a vector of these unwritten extents which needs
>> the conversion after the IO is complete. Thus, we maintain
>> a list of tuple <offset, size> pair (io_end_vec) for this &
>> traverse this list to do the unwritten to written conversion.
>>
>> Appreciate any reviews/comments on this patches.
> 
> I know Ted has merged the patches already so this is just informational but
> I've read the patches and they look fine to me. Thanks for the work! I was

Appreciate your help too for valuable feedback & pointers at various places.


> just thinking that we could actually make the vector tracking more
> efficient because the io_end always looks like:
> 
> one-big-extent-to-fully-write + whatever it takes to fully write out the
> last page
> 
> So your vectors could be also expressed as "extent to write" + bitmap of
> blocks written in the last page. And 64-bits are enough for the bitmap for
> anything ext4 supports so we could easily save allocation of ioend_vec etc.
> Just a suggestion.

Yes, sounds good to me. Although slab allocations are also fast.
However I agree this should be more efficient and will also avoid the
list management and or list pointer traversal.

Sure, will work over this optimization once I get some closure on some
ongoing open items.


Thanks & appreciate your feedback.
ritesh

