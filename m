Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD536B084D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 14:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjCHNSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 08:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCHNRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:17:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC40394760;
        Wed,  8 Mar 2023 05:14:22 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328BCCaG017227;
        Wed, 8 Mar 2023 13:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DDya8KHWHSr+5LXFEtSadqnhaQ4lHkZDT8S2YAyfe/Y=;
 b=auCENqIntmm0A1BsxKuDmcYtdTvppvJDgVPE+SHx+7OGNeS/taxLpu2Q01pa/7JTWEAt
 +R1Knw7d3q1rZ1lKtssB2sKzeowWtHQg6TeBvBhhdzJQYwVLQTq2NHbUXUMF+QPxT2Ds
 iLZJJ3+y1Kb5nqi3Nly1JgYHBwV6ppXx8KDIKcGYOvvioLrgDEYd4+xDVVRM22gPVuwU
 lt4u5fwiiFcXDypA/uhVMZHz0xWbFcEsccSTSVjp+/hpE68SZd8gL8/9MEVpe0oFt6Ys
 eIyjinhPGBjpns9d8T0uoqh0UK3c4xIkbowqdmb+K1R4V6BLlDhruUHIr+IQ12zf7vOE bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6s9a2pyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 13:13:34 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328BjWTg011563;
        Wed, 8 Mar 2023 13:13:34 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6s9a2pxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 13:13:34 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 328CFKVJ011865;
        Wed, 8 Mar 2023 13:13:32 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3p6gbv3tfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 13:13:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328DDUcW20447792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 13:13:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C59F058059;
        Wed,  8 Mar 2023 13:13:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 263B558043;
        Wed,  8 Mar 2023 13:13:28 +0000 (GMT)
Received: from sig-9-77-134-135.ibm.com (unknown [9.77.134.135])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 13:13:28 +0000 (GMT)
Message-ID: <a0320926ebfe732dabc4e53c3a35ede450c75474.camel@linux.ibm.com>
Subject: Re: [PATCH 23/28] security: Introduce LSM_ORDER_LAST
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
Date:   Wed, 08 Mar 2023 08:13:27 -0500
In-Reply-To: <20230303182602.1088032-1-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303182602.1088032-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: avdfNnHmEZqY1uVYuUhCo4zAiJ8gOvMX
X-Proofpoint-GUID: Mze5PduXBAbVrIyKXgxIaLuxWOWA6wDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto,

On Fri, 2023-03-03 at 19:25 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs willing to be
> the last, e.g. the 'integrity' LSM, without changing the kernel command
> line or configuration.

Please reframe this as a bug fix for 79f7865d844c ("LSM: Introduce
"lsm=" for boottime LSM selection") and upstream it first, with
'integrity' as the last LSM.   The original bug fix commit 92063f3ca73a
("integrity: double check iint_cache was initialized") could then be
removed.

> 
> As for LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled and put
> at the end of the LSM list in no particular order.

^Similar to LSM_ORDER_FIRST ...

And remove "in no particular order".

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h |  1 +
>  security/security.c       | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 21a8ce23108..05c4b831d99 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -93,6 +93,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>  enum lsm_order {
>  	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
>  	LSM_ORDER_MUTABLE = 0,
> +	LSM_ORDER_LAST = 1,
>  };
>  
>  struct lsm_info {
> diff --git a/security/security.c b/security/security.c
> index 322090a50cd..24f52ba3218 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -284,9 +284,9 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		bool found = false;
>  
>  		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> -			if (lsm->order == LSM_ORDER_MUTABLE &&
> -			    strcmp(lsm->name, name) == 0) {
> -				append_ordered_lsm(lsm, origin);
> +			if (strcmp(lsm->name, name) == 0) {
> +				if (lsm->order == LSM_ORDER_MUTABLE)
> +					append_ordered_lsm(lsm, origin);
>  				found = true;
>  			}
>  		}
> @@ -306,6 +306,12 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  		}
>  	}
>  
> +	/* LSM_ORDER_LAST is always last. */
> +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> +		if (lsm->order == LSM_ORDER_LAST)
> +			append_ordered_lsm(lsm, "   last");
> +	}
> +
>  	/* Disable all LSMs not in the ordered list. */
>  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>  		if (exists_ordered_lsm(lsm))

-- 
thanks,

Mimi

