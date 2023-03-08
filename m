Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714C76B0D50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 16:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjCHPtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 10:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjCHPtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:49:03 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D733D900;
        Wed,  8 Mar 2023 07:49:02 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328ET1TE028366;
        Wed, 8 Mar 2023 15:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hCC44BACeHTpBrtTCbvi2vDdjSusd2FhmfPyMLc7Kyw=;
 b=jDAmEA5dBrO1F+IO1NxZw/IxZYsUhrpFgvuN2ETX7gbna22nWu2DNGUWrXIE5TzWjqT7
 aOjuz140/l4QIpCYTe8g1sLEPF9VzmQxduVC3D+rE32SqFzuNgxeyOrCDw7lhUYjdX49
 yhsQnnmoSRiC5/DDW1Y2ktsz49fuQ1WHZaRAfeGsHkIXi0IlGBxqqp4UXmG++OHMIFrn
 9YqIUol1d3oqMt2qA3rffqmRLgAP+xNRxdUCRMMoEfXlhrNEMjiCRtrnzOuHUSCcVelE
 ssS0xN2G/snsqk7ubI+Jr7J3sTiypJ2eSvhWr7j+VR3P1fHhpWlWV35PXpmE64ubZwli Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6k0byddt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:48:43 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328DUU3p027000;
        Wed, 8 Mar 2023 15:48:38 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6k0byd4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:48:38 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 328Dx5YH022788;
        Wed, 8 Mar 2023 15:47:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3p6fkxmy7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:47:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328FltiL4063854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 15:47:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 762DA58053;
        Wed,  8 Mar 2023 15:47:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 089B558059;
        Wed,  8 Mar 2023 15:47:53 +0000 (GMT)
Received: from sig-9-77-134-135.ibm.com (unknown [9.77.134.135])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 15:47:52 +0000 (GMT)
Message-ID: <999d55baac7ac182fe46e5ddf9981e6f77da91fe.camel@linux.ibm.com>
Subject: Re: [PATCH 18/28] security: Introduce path_post_mknod hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 08 Mar 2023 10:47:52 -0500
In-Reply-To: <20230303181842.1087717-19-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303181842.1087717-19-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7i4GTeglYni6AFcaU1RB2v3phOzD-FyV
X-Proofpoint-GUID: AdILcLb06jQOAtMWXfOpCfW9j8hFQFqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_09,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=968
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303080133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto,

On Fri, 2023-03-03 at 19:18 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the path_post_mknod hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/namei.c                    |  2 ++
>  include/linux/lsm_hook_defs.h |  3 +++
>  include/linux/security.h      |  9 +++++++++
>  security/security.c           | 19 +++++++++++++++++++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 41f7fdf4657..3f2747521d3 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3980,6 +3980,8 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  					  dentry, mode, 0);
>  			break;
>  	}
> +	if (!error)
> +		security_path_post_mknod(idmap, &path, dentry, mode, dev);

Even though the original code uses "if (!error) ...",  consider using
"if (error) goto ..." here.

-- 
thanks,

Mimi


