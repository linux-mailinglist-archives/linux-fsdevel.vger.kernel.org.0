Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A42A371597
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhECNBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 09:01:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233986AbhECNB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 09:01:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143Ciuam074034;
        Mon, 3 May 2021 09:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VBYXCUgBG6tpCE1oAj8zm21J5gsUJSrdkssfdve2mUg=;
 b=LkHSdUMOisuFb/2BIB59J+kakiD0aL3Tl+JLjPUDm6iYy/+brddSnswmSHkQfttmejzX
 CfBTwiV682GfkoGiignGP0Jrr6GCgYzzO475csWrofSsiVazXPl0vNietaekQYA57jQ1
 64qbxkiSNO9Lzx0Z2R2SZUYWr78NCKzY2tT91RuYncMz0ArO+cc39lqlyWBICI2hitQD
 AQKVft2Wce+u1JDrAoedjW6R1vfFuF9y/cvpbDEgUe1lzUFwdd49ZGF3Km2khUFto8jK
 EZnJOn4GYDFdEixIx+G9Ju+kRwmeEfFmpOsR8DvLzIc6IMj1N9Ius9HnGKtyCubFnyH6 tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ahexrdqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 09:00:30 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143CjH8A075075;
        Mon, 3 May 2021 09:00:29 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ahexrdp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 09:00:29 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143CruP8006093;
        Mon, 3 May 2021 13:00:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 388xm88d46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 13:00:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143D0P1G23658850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 13:00:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0440542041;
        Mon,  3 May 2021 13:00:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD1DF4207A;
        Mon,  3 May 2021 13:00:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.45.89])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 13:00:22 +0000 (GMT)
Message-ID: <8493d7e2b0fefa4cd3861bd6b7ee6f2340aa7434.camel@linux.ibm.com>
Subject: Re: [PATCH v5 09/12] evm: Allow setxattr() and setattr() for
 unmodified metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 03 May 2021 09:00:21 -0400
In-Reply-To: <20210407105252.30721-10-roberto.sassu@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-10-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vGrctZS8HvxjKgZ809KL71I2AfjvSWwm
X-Proofpoint-ORIG-GUID: 6ecU4B-a0jF7CXqDHMvUrDnxco7OPWtt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_07:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030087
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-04-07 at 12:52 +0200, Roberto Sassu wrote:

> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> @@ -389,6 +473,11 @@ static int evm_protect_xattr(struct user_namespace *mnt_userns,
>  	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
>  		return 0;
>  
> +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> +	    !evm_xattr_change(mnt_userns, dentry, xattr_name, xattr_value,
> +			      xattr_value_len))
> +		return 0;
> +

If the purpose of evm_protect_xattr() is to prevent allowing an invalid
security.evm xattr from being re-calculated and updated, making it
valid, INTEGRITY_PASS_IMMUTABLE shouldn't need to be conditional.  Any
time there is an attr or xattr change, including setting it to the
existing value, the status flag should be reset.

I'm wondering if making INTEGRITY_PASS_IMMUTABLE conditional would
prevent the file from being resigned.

>  	if (evm_status != INTEGRITY_PASS)
>  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>  				    dentry->d_name.name, "appraise_metadata",

This would then be updated to if not INTEGRITY_PASS or
INTEGRITY_PASS_IMMUTABLE.  The subsequent "return" would need to be
updated as well.

thanks,

Mimi

