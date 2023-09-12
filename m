Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C617079D617
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbjILQUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 12:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjILQUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:20:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B562310E7;
        Tue, 12 Sep 2023 09:20:12 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CFwVEZ009758;
        Tue, 12 Sep 2023 16:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OU5X+ywlBGi0Cq66yvBzsLeNnGqPKL1F+bDp2X6ASbk=;
 b=NXWb1rycbzdFsLmHjfLavD78DrP0d+b39YbLpyIxFw/dnfJfutei/3TaOw/6cQy3Sqqc
 WukgYle17sYBMtBb9otGBPVeOLCX2WU43zeGHH8BonXTJVj7NxbosA4JowBcGY5lL6py
 4jNVEuS4y5yR3kFYkaA9My6rc8OECltDWVECg5vjboWf6AR2/6+42yPMcznAH229DP40
 nmrUS2sYkHEIhtPbwcnk/ekwtczKeR5xS+mkoZ5m2pllTo4MiHaI7Cz2j/7ofv8zqqPg
 Ruj8+oxhYtiR9cwziEjdn3774SlMSMyVjjbeIxci8t4pJAgwk+8/2gsukNcklun1v9X8 hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2u3gs29a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 16:19:32 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38CFwiqq009986;
        Tue, 12 Sep 2023 16:19:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2u3gs28q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 16:19:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38CFxncY002779;
        Tue, 12 Sep 2023 16:19:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hkvchs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 16:19:29 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38CGJSBZ4522700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 16:19:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E84E58056;
        Tue, 12 Sep 2023 16:19:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF7265803F;
        Tue, 12 Sep 2023 16:19:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Sep 2023 16:19:26 +0000 (GMT)
Message-ID: <82486de4-2917-afb6-2ae3-6ea7f1346dc0@linux.ibm.com>
Date:   Tue, 12 Sep 2023 12:19:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 25/25] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
 <20230904134049.1802006-6-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904134049.1802006-6-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aAyehIvhZvfb09muPbWZQIe5a9y5srC6
X-Proofpoint-ORIG-GUID: NiIkQ0Xddo7ctSZhQz6cjyAvKBZ1UWmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_14,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=736
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxscore=0 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120134
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/4/23 09:40, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Before the security field of kernel objects could be shared among LSMs with
> the LSM stacking feature, IMA and EVM had to rely on an alternative storage
> of inode metadata. The association between inode metadata and inode is
> maintained through an rbtree.
>
> With the reservation mechanism offered by the LSM infrastructure, the
> rbtree is no longer necessary, as each LSM could reserve a space in the
> security blob for each inode. Thus, request from the 'integrity' LSM a
> space in the security blob for the pointer of inode metadata
> (integrity_iint_cache structure).
>
> Prefer this to allocating the integrity_iint_cache structure directly, as
> IMA would require it only for a subset of inodes. Always allocating it
> would cause a waste of memory.
>
> Introduce two primitives for getting and setting the pointer of
> integrity_iint_cache in the security blob, respectively
> integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
> the code more understandable, as they directly replace rbtree operations.
>
> Locking is not needed, as access to inode metadata is not shared, it is per
> inode.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>
> @@ -145,10 +91,8 @@ static void integrity_inode_free(struct inode *inode)
>   	if (!IS_IMA(inode))
>   		return;

I think you can remove this check !IS_IMA()  as well since the next 
function called here integrity_iint_find() already has this check:

struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
{
         if (!IS_IMA(inode))
                 return NULL;

         return integrity_inode_get_iint(inode);
}


>   
> -	write_lock(&integrity_iint_lock);
> -	iint = __integrity_iint_find(inode);
> -	rb_erase(&iint->rb_node, &integrity_iint_tree);
> -	write_unlock(&integrity_iint_lock);
> +	iint = integrity_iint_find(inode);         <--------------
> +	integrity_inode_set_iint(inode, NULL);
>   
>   	iint_free(iint);
>   }
