Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467CD6ACC43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 19:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCFSQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 13:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCFSQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:16:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FBB6F63F;
        Mon,  6 Mar 2023 10:15:34 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326EUeor007186;
        Mon, 6 Mar 2023 16:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bqD1fQf93A6+PaLYS1ZatZURmW6WTInu6NJMIouFU7U=;
 b=s0BkIkhtcb1oglvI6BqMSVe0Bpi6YaPQ2uU4pH0EOVstHKuJcHwYXsGRK1REFdeSh4/Q
 oiGS7TtjJP8WrermVftdH4oU40JA7cH2WEkXwJLKX5rR7Xy7Omk17aPN4RQTRloogO7U
 c1uirCEEWyrI4EnUTxyCNp76S6Lb8gNSeA7v/wDTbiVCdfEZTs+anoq+U450kGxmvqMt
 RCGqUNserq4U0VxGn2v671W9H9TDgS7RqkYQ2FQiH2ja4YrHorky8ybZuQSeXv1hc+/s
 CHEMs3AK59+DhwaZ5h6HaM4Q7HaHsCPpu/A538m8ouQubCGZ9olG69kj8GtAfdNt7FvR 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4ysdshg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:16:49 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326EbGbm005496;
        Mon, 6 Mar 2023 16:16:48 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4ysdshfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:16:48 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326DoL6X017299;
        Mon, 6 Mar 2023 16:16:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3p41ak9kf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:16:47 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326GGkAF58982828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 16:16:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37C3058067;
        Mon,  6 Mar 2023 16:16:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F34B58065;
        Mon,  6 Mar 2023 16:16:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 16:16:44 +0000 (GMT)
Message-ID: <2dcc460c-73ff-d468-0c43-63ccbe0c4f9e@linux.ibm.com>
Date:   Mon, 6 Mar 2023 11:16:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 21/28] security: Introduce inode_post_remove_acl hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
 <20230303181842.1087717-22-roberto.sassu@huaweicloud.com>
 <6393eb31-5eb3-cb1c-feb7-2ab347703042@linux.ibm.com>
 <7bde74e6e5ccf24b2a2bd9dc2bbfcae5c424eac7.camel@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <7bde74e6e5ccf24b2a2bd9dc2bbfcae5c424eac7.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MWaLbIaI9NdMBOq3S9HXS4e_XU0QxD-l
X-Proofpoint-GUID: nqChop_acBrGbOPxx8sFOam96JFy-FH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/6/23 10:34, Roberto Sassu wrote:
> On Mon, 2023-03-06 at 10:22 -0500, Stefan Berger wrote:
>>
>> On 3/3/23 13:18, Roberto Sassu wrote:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
>>> the inode_post_remove_acl hook.
>>>
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>> ---
>>>    
>>> +/**
>>> + * security_inode_post_remove_acl() - Update inode sec after remove_acl op
>>> + * @idmap: idmap of the mount
>>> + * @dentry: file
>>> + * @acl_name: acl name
>>> + *
>>> + * Update inode security field after successful remove_acl operation on @dentry
>>> + * in @idmap. The posix acls are identified by @acl_name.
>>> + */
>>> +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
>>> +				    struct dentry *dentry, const char *acl_name)
>>> +{
>>> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>>> +		return;
>>
>> Was that a mistake before that EVM and IMA functions did not filtered out private inodes?
> 
> Looks like that. At least for hooks that are not called from
> security.c.

It seems like that all security_* functions are filtering on private inodes. Anonymous inodes have them and some filesystem set the S_PRIVATE flag. So it may not make a difference fro IMA and EVM then.

     Stefan

> 
> Thanks
> 
> Roberto
> 
