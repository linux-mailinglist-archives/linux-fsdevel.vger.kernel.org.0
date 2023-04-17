Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3156E4AE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjDQOIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 10:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjDQOIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:08:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D517EDA;
        Mon, 17 Apr 2023 07:07:33 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HCqiBF006625;
        Mon, 17 Apr 2023 14:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=laoXS98o4L49IyYojK48ave0JpcBP4QNQBAEUKLJsqQ=;
 b=Yxk+/6UtyQ2VoxtSYIMywS5JS8/eo7yZIh49cUs3tiKaBPVzr2HoT1BAEm4W30JuHyM0
 3w7NyJ4iC4wiKmB80IlpAWZMkh081xrcSokaJNaTy200tkb/i1juDRPy2KMm3tVgOVKq
 JxtEUqkAfUkVgw/TUu28gwtyY5O/ZuwQE5oIbO9Ly5iX0T3/tDy6SvkhxnWppzME/8wz
 wD6JDvdpbvl6h6lPcXTQ13ZASmXxSmyewCGLmiVq5xqqGFPa6Fvsh4unJAVFXc5oiDW3
 MO2847gxTIciCA6I5Ng7Jt9uKQYy/Ul0HHD/+ZtVVTmk0KvgEqctaEh1BqN2cqe3dARq YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3q12vkg8cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:07:10 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33HDQZSB024433;
        Mon, 17 Apr 2023 14:07:10 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3q12vkg8c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:07:10 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33HC5u5D029086;
        Mon, 17 Apr 2023 14:07:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3pykj760v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:07:09 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33HE77Gr8651388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 14:07:07 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 971C858056;
        Mon, 17 Apr 2023 14:07:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE94758062;
        Mon, 17 Apr 2023 14:07:05 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Apr 2023 14:07:05 +0000 (GMT)
Message-ID: <496ba5fc-9c0b-a906-2373-5ac061d6da3a@linux.ibm.com>
Date:   Mon, 17 Apr 2023 10:07:05 -0400
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
X-Proofpoint-GUID: vaSjj_r0eeuQAYQrTvAwNhKeBSsvRQyk
X-Proofpoint-ORIG-GUID: 9Zb0X9YUjnhtVPWptrW6DyL4kDDUKdjv
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_08,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170126
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
> 
> -----------------------8<---------------------------
> 
> [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> 
> IMA currently accesses the i_version out of the inode directly when it
> does a measurement. This is fine for most simple filesystems, but can be
> problematic with more complex setups (e.g. overlayfs).
> 
> Make IMA instead call vfs_getattr_nosec to get this info. This allows
> the filesystem to determine whether and how to report the i_version, and
> should allow IMA to work properly with a broader class of filesystems in
> the future.
> 
> Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   security/integrity/ima/ima_api.c  |  9 ++++++---
>   security/integrity/ima/ima_main.c | 12 ++++++++----
>   2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index d3662f4acadc..c45902e72044 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -13,7 +13,6 @@
>   #include <linux/fs.h>
>   #include <linux/xattr.h>
>   #include <linux/evm.h>
> -#include <linux/iversion.h>
>   #include <linux/fsverity.h>
>   
>   #include "ima.h"
> @@ -246,10 +245,11 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>   	struct inode *inode = file_inode(file);
>   	const char *filename = file->f_path.dentry->d_name.name;
>   	struct ima_max_digest_data hash;
> +	struct kstat stat;
>   	int result = 0;
>   	int length;
>   	void *tmpbuf;
> -	u64 i_version;
> +	u64 i_version = 0;
>   
>   	/*
>   	 * Always collect the modsig, because IMA might have already collected
> @@ -268,7 +268,10 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>   	 * to an initial measurement/appraisal/audit, but was modified to
>   	 * assume the file changed.
>   	 */
> -	i_version = inode_query_iversion(inode);
> +	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
> +				   AT_STATX_SYNC_AS_STAT);
> +	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> +		i_version = stat.change_cookie;
>   	hash.hdr.algo = algo;
>   	hash.hdr.length = hash_digest_size[algo];
>   
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index d66a0a36415e..365db0e43d7c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -24,7 +24,6 @@
>   #include <linux/slab.h>
>   #include <linux/xattr.h>
>   #include <linux/ima.h>
> -#include <linux/iversion.h>
>   #include <linux/fs.h>
>   
>   #include "ima.h"
> @@ -164,11 +163,16 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
>   
>   	mutex_lock(&iint->mutex);
>   	if (atomic_read(&inode->i_writecount) == 1) {
> +		struct kstat stat;
> +
>   		update = test_and_clear_bit(IMA_UPDATE_XATTR,
>   					    &iint->atomic_flags);
> -		if (!IS_I_VERSION(inode) ||
> -		    !inode_eq_iversion(inode, iint->version) ||
> -		    (iint->flags & IMA_NEW_FILE)) {
> +		if ((iint->flags & IMA_NEW_FILE) ||
> +		    vfs_getattr_nosec(&file->f_path, &stat,
> +				      STATX_CHANGE_COOKIE,
> +				      AT_STATX_SYNC_AS_STAT) ||
> +		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> +		    stat.change_cookie != iint->version) {
>   			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
>   			iint->measured_pcrs = 0;
>   			if (update)

I tested this in the OpenBMC setup with overlayfs acting as rootfs. It works now as expected.

Tested-by: Stefan Berger <stefanb@linux.ibm.com>

