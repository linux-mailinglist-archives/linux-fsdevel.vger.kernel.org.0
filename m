Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD06EAB200
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 07:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391537AbfIFFR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 01:17:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732721AbfIFFR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:17:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x865H9Zb046506
        for <linux-fsdevel@vger.kernel.org>; Fri, 6 Sep 2019 01:17:25 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uuew2kp2v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 01:17:25 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 6 Sep 2019 06:17:23 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Sep 2019 06:17:20 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x865HIZr50855988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Sep 2019 05:17:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B66BDA4066;
        Fri,  6 Sep 2019 05:17:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A87CDA4054;
        Fri,  6 Sep 2019 05:17:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Sep 2019 05:17:17 +0000 (GMT)
Subject: Re: [RFC] - vfs: Null pointer dereference issue with symlink create
 and read of symlink
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Gao Xiang <hsiangkao@aol.com>, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, wugyuan@cn.ibm.com
References: <20190903115827.0A8A0A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20190903125946.GA11069@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190903134129.EC5E6A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
 <9b3433ebec78bb99690fd4805b329266edf21686.camel@kernel.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 6 Sep 2019 10:47:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9b3433ebec78bb99690fd4805b329266edf21686.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090605-0016-0000-0000-000002A75AA1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090605-0017-0000-0000-00003307D1EA
Message-Id: <20190906051717.A87CDA4054@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909060059
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/4/19 8:09 PM, Jeff Layton wrote:
>>> It seems much similar to
>>> https://lore.kernel.org/r/20190419084810.63732-1-houtao1@huawei.com/
>>
>> Thanks, yes two same symptoms with different use cases.
>> But except the fact that here, we see the issue with GPFS quite
>> frequently. So let's hope that we could have some solution to this
>> problem in upstream.
>>
> 
> Agreed. Looks a lot like the same issue.
> 
>>   From the thread:-
>>   >> We could simply use d_really_is_negative() there, avoiding all that
>>   >> mess.  If and when we get around to whiteouts-in-dcache (i.e. if
>>   >> unionfs series gets resurrected), we can revisit that
>>
>> I didn't get this part. Does it mean, d_really_is_negative can only be
>> used, once whiteouts-in-dcache series is resurrected?
>> If yes, meanwhile could we have any other solution in place?
>>
> 
> I think Al was saying that you could change this to use
> d_really_is_negative now but the whiteouts-in-dcache series would have
> to deal with that. That series seems to be stalled for the time being,
> so I wouldn't let it stop you from changing this.
> 
> It wouldn't hurt to put in some comments with this change too, to make
> sure everyone understands why that's being used there.

Thanks Jeff. I did look at the thread again and yes you are right.
I have created the patch and added some comments as per your suggestion. 
Once it is tested again internally (although it does looks like it 
should work fine), I will post the patch.

Appreciate your help!!

-ritesh

