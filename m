Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C33C24D129
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgHUJJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 05:09:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36800 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbgHUJJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:09:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07L94TYM184971;
        Fri, 21 Aug 2020 05:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=g6D81fjAjzolDRs4TMpcl3zql7MrdCXnnXbsd2Bw0Uw=;
 b=rbrs1TW/Ktbt8v4E6b5FgMaH6CBNDFOYt+yK5tnULi1Vt4cxZmV2URgtnc7zHnFldRHF
 hAjGOk7EH1PoX+rxEPOHH/Jqo9fUJVSC1ubH/q1Vv8ybPdnAikUJUip1iK5tvEUr7Iy/
 9SJXXqf/GBgNL0m7ecnE44ZSO/xoPjRqh0Zvuoj8KRaP1J25TIdtuj9acUzi8UQvzgfb
 kAD3793WcIF5r3QG+gUqbdBpXy+Oak3S2GcsQEs3RHdqAyO7dgpm1m7lxATdM6dIWlqH
 EhfwJvaqCVUzm9PI7LSBECG6t2mRuj1Le6rNmIUN6e3U3ao4P4JU8setBmZq8RhZAgjZ rA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 331an7mekx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 05:09:39 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07L92hT5002103;
        Fri, 21 Aug 2020 09:09:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 330tbvtv5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 09:09:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07L99Zad27984142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 09:09:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A36CD4C058;
        Fri, 21 Aug 2020 09:09:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BDF04C04A;
        Fri, 21 Aug 2020 09:09:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Aug 2020 09:09:34 +0000 (GMT)
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
 <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
 <20200821060025.GA31091@infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 21 Aug 2020 14:39:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200821060025.GA31091@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200821090934.4BDF04C04A@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_06:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=879 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210080
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/21/20 11:30 AM, Christoph Hellwig wrote:
> On Fri, Aug 21, 2020 at 10:15:33AM +0530, Ritesh Harjani wrote:
>> Please correct me here, but as I see, bio has only these two limits
>> which it checks for adding page to bio. It doesn't check for limits
>> of /sys/block/<dev>/queue/* no? I guess then it could be checked
>> by block layer below b4 submitting the bio?
> 
> The bio does not, but the blk-mq code will split the bios when mapping
> it to requests, take a look at blk_mq_submit_bio and __blk_queue_split.

Thanks :)

> 
> But while the default limits are quite low, they can be increased
> siginificantly, which tends to help with performance and is often
> also done by scripts shipped by the distributions.
> 
>> This issue was first observed while running a fio run on a system with
>> huge memory. But then here is an easy way we figured out to trigger the
>> issue almost everytime with loop device on my VM setup. I have provided
>> all the details on this below.
> 
> Can you wire this up for xfstests?
> 

Sure, will do that.
I do see generic/460 does play with such vm dirty_ratio params which
this test would also require to manipulate to trigger this issue.


Thanks for the suggestion!
-ritesh
