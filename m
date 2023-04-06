Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDEB6DA5CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 00:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbjDFW11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjDFW10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:27:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30EA7EC6;
        Thu,  6 Apr 2023 15:27:25 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336L1kNm024134;
        Thu, 6 Apr 2023 22:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tp0ZMX9fedTeOqsKlgu0LboxYUsAYjzLrcmCZQUaefg=;
 b=JoBzb4Vv6GrgeKf8CrIrIir+Oz6TANBZOl20nyPiZH4PsxcKYB3Uq08D/vl9of7q1PwH
 eSS+mLbLN4L1OMRKRr2zRgbnDHBlu08WQBTirVHhIj7EopC1mKMyl3V4zbEB+e1ogoYC
 IPziTaddarFtOB1jdqTq9Bz7zPLK4VH647CfCONpzYYB0KdWZhFAVbnd1trkWgf6jEaG
 ItxItv1Jtybvb5PjnBCUNfIUcNiwdX/V0EGz4auJkssi/RSA22VyCojFppR+kh2naxRu
 sOYWGr82A0N47aVhkbzZB6G2FsDUW4OH4dqeHZX7aOjEtpCXGh/IYLEAyg7MoOftwHiF sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3psta9uer1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 22:27:20 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 336MRKm5016417;
        Thu, 6 Apr 2023 22:27:20 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3psta9ueqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 22:27:20 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336MDCe7016957;
        Thu, 6 Apr 2023 22:27:19 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3ppc89c37y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 22:27:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 336MRH8A7864842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Apr 2023 22:27:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9A715803F;
        Thu,  6 Apr 2023 22:27:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EBBF58061;
        Thu,  6 Apr 2023 22:27:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  6 Apr 2023 22:27:17 +0000 (GMT)
Message-ID: <b78a9cd9-f3ab-3834-991c-3c15590dcbd8@linux.ibm.com>
Date:   Thu, 6 Apr 2023 18:27:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
 <20230406-diffamieren-langhaarig-87511897e77d@brauner>
 <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
 <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
 <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
 <20230406-wasser-zwanzig-791bc0bf416c@brauner>
 <546145ecbf514c4c1a997abade5f74e65e5b1726.camel@kernel.org>
 <45a9c575-0b7e-f66a-4765-884865d14b72@linux.ibm.com>
 <60339e3bd08a18358ac8c8a16dc67c74eb8ba756.camel@kernel.org>
 <d61ed13b-0fd2-0283-96d2-0ff9c5e0a2f9@linux.ibm.com>
 <4f739cc6847975991874d56ef9b9716c82cf62a3.camel@kernel.org>
 <7d8f05e26dc7152dfad771dfc867dec145aa054b.camel@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <7d8f05e26dc7152dfad771dfc867dec145aa054b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L000C40uecQVektj65LivkFRw4HDW1oS
X-Proofpoint-ORIG-GUID: nAcuqTFzyn3mas3y2tFBMlAeYKDG1jyw
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304060194
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/6/23 18:04, Jeff Layton wrote:
> On Thu, 2023-04-06 at 17:24 -0400, Jeff Layton wrote:
>> On Thu, 2023-04-06 at 16:22 -0400, Stefan Berger wrote:
>>>
>>> On 4/6/23 15:37, Jeff Layton wrote:
>>>> On Thu, 2023-04-06 at 15:11 -0400, Stefan Berger wrote:
>>>>>
>>>>> On 4/6/23 14:46, Jeff Layton wrote:
>>>>>> On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
>>>>>>> On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
>>>>>
>>>>>>
>>>>>> Correct. As long as IMA is also measuring the upper inode then it seems
>>>>>> like you shouldn't need to do anything special here.
>>>>>
>>>>> Unfortunately IMA does not notice the changes. With the patch provided in the other email IMA works as expected.
>>>>>
>>>>
>>>>
>>>> It looks like remeasurement is usually done in ima_check_last_writer.
>>>> That gets called from __fput which is called when we're releasing the
>>>> last reference to the struct file.
>>>>
>>>> You've hooked into the ->release op, which gets called whenever
>>>> filp_close is called, which happens when we're disassociating the file
>>>> from the file descriptor table.
>>>>
>>>> So...I don't get it. Is ima_file_free not getting called on your file
>>>> for some reason when you go to close it? It seems like that should be
>>>> handling this.
>>>
>>> I would ditch the original proposal in favor of this 2-line patch shown here:
>>>
>>> https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
>>>
>>>
>>
>> Ok, I think I get it. IMA is trying to use the i_version from the
>> overlayfs inode.
>>
>> I suspect that the real problem here is that IMA is just doing a bare
>> inode_query_iversion. Really, we ought to make IMA call
>> vfs_getattr_nosec (or something like it) to query the getattr routine in
>> the upper layer. Then overlayfs could just propagate the results from
>> the upper layer in its response.
>>
>> That sort of design may also eventually help IMA work properly with more
>> exotic filesystems, like NFS or Ceph.
>>
>>
>>
> 
> Maybe something like this? It builds for me but I haven't tested it. It
> looks like overlayfs already should report the upper layer's i_version
> in getattr, though I haven't tested that either:


Thank you! I will give it a try once I am back.

     Stefan
