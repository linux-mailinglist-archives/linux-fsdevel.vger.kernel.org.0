Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F6D6D997B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 16:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbjDFOUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjDFOUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:20:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F2786A8;
        Thu,  6 Apr 2023 07:20:45 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336E3HqY030670;
        Thu, 6 Apr 2023 14:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=L8plKRYXq/lUnBCPQHPtYUtZSWbpoXo5C5FVI1IJWDY=;
 b=S4brrj5/c+nujUTGS55jGpA0UUgyKBYSf1/jmisFa+J6XDkl95Z4rjHjq+1BBxH0L/AP
 Xsb43nwU7WEiA1TmC0G897Gx1+C8doU6kk9i2bZ+/v5crGM07vND4AMFohtvKdvpIL1v
 J4ljhAwJkaKhcoRgK/QHx06irQnjFPqM9f/DzI+tgUeac6WvAaNKn7awShtTMqbmeDQm
 1u6uzdJkqggKseZPDFsi3VmssMlPMTqQUkohRVIDheb4RcKZiazG3l6ZwSXMeE50S/K2
 bF4vAFrSTDm5GJyMIv97lEI0x6br25WvymKXIw/mvY1pNGgXdDnBIU3FBC5vP3AEOhMl 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3psayrwu7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 14:20:41 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 336BiHIY016886;
        Thu, 6 Apr 2023 14:20:40 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3psayrwu6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 14:20:40 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336B8c5A014549;
        Thu, 6 Apr 2023 14:20:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3ppc88ay6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 14:20:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 336EKcHD53870876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Apr 2023 14:20:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 676765805B;
        Thu,  6 Apr 2023 14:20:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F7C158058;
        Thu,  6 Apr 2023 14:20:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  6 Apr 2023 14:20:37 +0000 (GMT)
Message-ID: <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
Date:   Thu, 6 Apr 2023 10:20:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
To:     Paul Moore <paul@paul-moore.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
 <20230406-diffamieren-langhaarig-87511897e77d@brauner>
 <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q3P_7vLviB0y6aC0xfvdIB_lxMeHHrGJ
X-Proofpoint-GUID: axRA0-svgYmFpSpmpbKHeis_USgWT0Jq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_07,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060124
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/6/23 10:05, Paul Moore wrote:
> On Thu, Apr 6, 2023 at 6:26 AM Christian Brauner <brauner@kernel.org> wrote:
>> On Wed, Apr 05, 2023 at 01:14:49PM -0400, Stefan Berger wrote:
>>> Overlayfs fails to notify IMA / EVM about file content modifications
>>> and therefore IMA-appraised files may execute even though their file
>>> signature does not validate against the changed hash of the file
>>> anymore. To resolve this issue, add a call to integrity_notify_change()
>>> to the ovl_release() function to notify the integrity subsystem about
>>> file changes. The set flag triggers the re-evaluation of the file by
>>> IMA / EVM once the file is accessed again.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>   fs/overlayfs/file.c       |  4 ++++
>>>   include/linux/integrity.h |  6 ++++++
>>>   security/integrity/iint.c | 13 +++++++++++++
>>>   3 files changed, 23 insertions(+)
>>>
>>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>>> index 6011f955436b..19b8f4bcc18c 100644
>>> --- a/fs/overlayfs/file.c
>>> +++ b/fs/overlayfs/file.c
>>> @@ -13,6 +13,7 @@
>>>   #include <linux/security.h>
>>>   #include <linux/mm.h>
>>>   #include <linux/fs.h>
>>> +#include <linux/integrity.h>
>>>   #include "overlayfs.h"
>>>
>>>   struct ovl_aio_req {
>>> @@ -169,6 +170,9 @@ static int ovl_open(struct inode *inode, struct file *file)
>>>
>>>   static int ovl_release(struct inode *inode, struct file *file)
>>>   {
>>> +     if (file->f_flags & O_ACCMODE)
>>> +             integrity_notify_change(inode);
>>> +
>>>        fput(file->private_data);
>>>
>>>        return 0;
>>> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
>>> index 2ea0f2f65ab6..cefdeccc1619 100644
>>> --- a/include/linux/integrity.h
>>> +++ b/include/linux/integrity.h
>>> @@ -23,6 +23,7 @@ enum integrity_status {
>>>   #ifdef CONFIG_INTEGRITY
>>>   extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
>>>   extern void integrity_inode_free(struct inode *inode);
>>> +extern void integrity_notify_change(struct inode *inode);
>>
>> I thought we concluded that ima is going to move into the security hook
>> infrastructure so it seems this should be a proper LSM hook?
> 
> We are working towards migrating IMA/EVM to the LSM layer, but there
> are a few things we need to fix/update/remove first; if anyone is
> curious, you can join the LSM list as we've been discussing some of
> these changes this week.  Bug fixes like this should probably remain
> as IMA/EVM calls for the time being, with the understanding that they
> will migrate over with the rest of IMA/EVM.
> 
> That said, we should give Mimi a chance to review this patch as it is
> possible there is a different/better approach.  A bit of patience may
> be required as I know Mimi is very busy at the moment.
> 

There may be a better approach actually by increasing the inode's i_version,
which then should trigger the appropriate path in ima_check_last_writer().
