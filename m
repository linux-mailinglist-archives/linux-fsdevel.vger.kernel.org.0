Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD0E6AC929
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 18:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCFRFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 12:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCFRFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:05:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B573B3D8;
        Mon,  6 Mar 2023 09:05:14 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Grmaf028606;
        Mon, 6 Mar 2023 17:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9fwut7cchp02SvWrPlKzA6oBFeUUHP84/EXlPGky2TE=;
 b=k0gNDBfTwQW3vyjWT/ijvwW6qeJ6ANOMcqeWOTwBWgNNlgwEVsoCGvf+hSi48gRB+PDJ
 CcNYH2fjwjvnDmC39179r+xfrzFpqX25cxVJF02zmpcljJoQBcIsguwRauHGxPQjY2ab
 gT/19qLIAyeCLoP0PIznwJgLUqiqWUczge/rzZcPel+jUbt4jLi8TUiORudjSwQXlSpl
 p3OeoD5RIoRhJFNu+LRVJ1fOyRfx/LdxPnSeSoSm/PjVOVnGQgoqmtLr5GBbup6rdQKK
 qMxPZYJ7jMFN8jzAPmKQ4N2VcZVoxepN2TyAFN/4f1vsJ3DC67dsA/pbKlVoMoPGjSUe 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4ysdtsp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 17:04:10 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326GrqmX028974;
        Mon, 6 Mar 2023 17:04:10 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4ysdtsna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 17:04:10 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326G6SCo008231;
        Mon, 6 Mar 2023 17:04:08 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3p417vpb9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 17:04:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326H47kv33292952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 17:04:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23DF958056;
        Mon,  6 Mar 2023 17:04:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D510258052;
        Mon,  6 Mar 2023 17:04:05 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 17:04:05 +0000 (GMT)
Message-ID: <ecb168e5-e85f-73ee-7bc4-c13d0ea8811e@linux.ibm.com>
Date:   Mon, 6 Mar 2023 12:04:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 11/28] evm: Complete description of evm_inode_setattr()
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
 <20230303181842.1087717-12-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230303181842.1087717-12-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tdl_ZydG-xod2mnK8Dhh08bROd0UrR0R
X-Proofpoint-GUID: HSaRWRe_WkZkCmRwBMWU1ooE5oYAhPqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060151
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/3/23 13:18, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add the description for missing parameters of evm_inode_setattr() to
> avoid the warning arising with W=n compile option.
> 
> Fixes: 817b54aa45db ("evm: add evm_inode_setattr to prevent updating an invalid security.evm")
> Fixes: c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Among the previous patches I think there were 2 fixes like this one you could possibly also split off.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   security/integrity/evm/evm_main.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 1155a58ae87..8b5c472f78b 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -798,7 +798,9 @@ static int evm_attr_change(struct mnt_idmap *idmap,
>   
>   /**
>    * evm_inode_setattr - prevent updating an invalid EVM extended attribute
> + * @idmap: idmap of the mount
>    * @dentry: pointer to the affected dentry
> + * @attr: iattr structure containing the new file attributes
>    *
>    * Permit update of file attributes when files have a valid EVM signature,
>    * except in the case of them having an immutable portable signature.
