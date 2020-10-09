Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3003128835A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 09:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgJIHTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 03:19:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12064 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730467AbgJIHTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:19:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099739hD107032;
        Fri, 9 Oct 2020 03:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=p2pWVivhzwZ6RbpF1JW6TIXrP3pLZCok8uts5LE2kkE=;
 b=UR9a1xG6ldrVswK5oBNFROJytRiYEltqhGH/zv6I7jh/yKyiNOGS+GAlUA6pzF3+57UE
 SHmlw0hx9V4hbnhwft/edg8nGC/354BrKkgm5nK5MLDeTygkit8D3s1/fXh/s19xp0LX
 G33BFHvAGPzIuLxwQCnPR0xjZTfVaqMsCbuMTf4Qtqkn+IlpqrImf63SBF9r8nfx8u7j
 7GndG/gBhrSvfg1iD0916uXC7joXAIBHapJrcGgDlbZgpRK5vdxfmceN2zFMiL4KOzuf
 Pg/fus9Ol1so2F+fxNRWc6UmfrAIxygnvFxkrnF19+ESmfs30ZoEibIOmJqW1qikJdGh Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342jyurs3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 03:19:00 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 099749gj111511;
        Fri, 9 Oct 2020 03:18:59 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342jyurs2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 03:18:59 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0997DeQC015607;
        Fri, 9 Oct 2020 07:18:57 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3429hrg6tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 07:18:57 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0997ItcL34734500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Oct 2020 07:18:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78D0742052;
        Fri,  9 Oct 2020 07:18:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED02842064;
        Fri,  9 Oct 2020 07:18:53 +0000 (GMT)
Received: from [9.199.46.138] (unknown [9.199.46.138])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Oct 2020 07:18:53 +0000 (GMT)
Subject: Re: [PATCH 1/1] ext4: Fix bs < ps issue reported with dioread_nolock
 mount opt
To:     sedat.dilek@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jack@suse.cz, anju@linux.vnet.ibm.com,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
References: <af902b5db99e8b73980c795d84ad7bb417487e76.1602168865.git.riteshh@linux.ibm.com>
 <CA+icZUVPXFkc7ow5-vF4bxggE63LqQkmaXA6m9cAZVCOnbS1fQ@mail.gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <22e5c5f9-c06b-5c49-d165-8f194aad107b@linux.ibm.com>
Date:   Fri, 9 Oct 2020 12:48:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+icZUVPXFkc7ow5-vF4bxggE63LqQkmaXA6m9cAZVCOnbS1fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_02:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090046
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/9/20 12:16 PM, Sedat Dilek wrote:
> On Thu, Oct 8, 2020 at 5:56 PM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>>
>> left shifting m_lblk by blkbits was causing value overflow and hence
>> it was not able to convert unwritten to written extent.
>> So, make sure we typecast it to loff_t before do left shift operation.
>> Also in func ext4_convert_unwritten_io_end_vec(), make sure to initialize
>> ret variable to avoid accidentally returning an uninitialized ret.
>>
>> This patch fixes the issue reported in ext4 for bs < ps with
>> dioread_nolock mount option.
>>
>> Fixes: c8cc88163f40df39e50c ("ext4: Add support for blocksize < pagesize in dioread_nolock")
> 
> Fixes: tag should be 12 digits (see [1]).
> ( Seen while walking through ext-dev Git commits. )


Thanks Sedat, I guess it should be minimum 12 chars [1]

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n177

-ritesh
