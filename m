Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2072D3717F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhECP1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 11:27:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230484AbhECP1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 11:27:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143F3xDo166381;
        Mon, 3 May 2021 11:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=uSWnVxT/L88NctnVRLA+CAYwlolKVdmnpGyQBzBdW5g=;
 b=SEc0sdhEMtmCm/MN+xcx9Xlo+VrdENuJx9l8u2mX5dPQTTKhZeJjGtKJ1cS6Fy5+YGyt
 pxitc4q7XbvUrShJlt4qMQBDKk9JqEhI9V2MmlRwNurDvsQ4vuh5QAPr4s74rx2DRS4N
 3e1VC+v2TCeaZnUQSa5gsEGYWInA0Dkws/RH8MUMeey5OKlbcmMiam/ZDU1cdr0dYSMb
 lUu8NjDP1Qhg/UxIzPJtFs2j6s9xJmFjjmlvtJjgLu/707B85tMOvFTq2U9T5IgpDZS9
 ReDOjl3G92pMd8PFt8v9FnkVvrMnByrMk/SdNy5/KU2jCZ5AvtKYBcYBLpUxuZFKrvM/ tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ajaqtyej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 11:26:43 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143F4QRW169743;
        Mon, 3 May 2021 11:26:43 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ajaqtydt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 11:26:43 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143FLgQ5024871;
        Mon, 3 May 2021 15:26:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 388xm88e7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 15:26:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143FQcFU17236448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 15:26:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC8DBAE04D;
        Mon,  3 May 2021 15:26:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC997AE045;
        Mon,  3 May 2021 15:26:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.45.89])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 15:26:35 +0000 (GMT)
Message-ID: <cf12878833c82710ad4356e7d023cf51241f3cc8.camel@linux.ibm.com>
Subject: Re: [PATCH v5 09/12] evm: Allow setxattr() and setattr() for
 unmodified metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 03 May 2021 11:26:24 -0400
In-Reply-To: <fcd2932bc2a841c2aa7fcbdaee94e0a5@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-10-roberto.sassu@huawei.com>
         <8493d7e2b0fefa4cd3861bd6b7ee6f2340aa7434.camel@linux.ibm.com>
         <fcd2932bc2a841c2aa7fcbdaee94e0a5@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CJKpKBCc5dQXzHiLp-Zy9QG0A4TfuLl-
X-Proofpoint-GUID: OSj9jIQZ-xsdgT5sgo0KaAa6-ERQhQ7H
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_10:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030104
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-05-03 at 15:11 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Monday, May 3, 2021 3:00 PM
> > On Wed, 2021-04-07 at 12:52 +0200, Roberto Sassu wrote:
> > 
> > > diff --git a/security/integrity/evm/evm_main.c
> > b/security/integrity/evm/evm_main.c
> > > @@ -389,6 +473,11 @@ static int evm_protect_xattr(struct
> > user_namespace *mnt_userns,
> > >  	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
> > >  		return 0;
> > >
> > > +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> > > +	    !evm_xattr_change(mnt_userns, dentry, xattr_name, xattr_value,
> > > +			      xattr_value_len))
> > > +		return 0;
> > > +
> > 
> > If the purpose of evm_protect_xattr() is to prevent allowing an invalid
> > security.evm xattr from being re-calculated and updated, making it
> > valid, INTEGRITY_PASS_IMMUTABLE shouldn't need to be conditional.  Any
> > time there is an attr or xattr change, including setting it to the
> > existing value, the status flag should be reset.
> > 
> > I'm wondering if making INTEGRITY_PASS_IMMUTABLE conditional would
> > prevent the file from being resigned.
> > 
> > >  	if (evm_status != INTEGRITY_PASS)
> > >  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > d_backing_inode(dentry),
> > >  				    dentry->d_name.name,
> > "appraise_metadata",
> > 
> > This would then be updated to if not INTEGRITY_PASS or
> > INTEGRITY_PASS_IMMUTABLE.  The subsequent "return" would need to be
> > updated as well.
> 
> I agree on the first suggestion, to reduce the number of log messages.
> For the second, if you meant that we should return 0 if the status is
> INTEGRITY_PASS_IMMUTABLE, I thought we wanted to deny xattr
> changes when there is an EVM portable signature.

Why?  I must be missing something.  As long as we're not relying on the
cached status, allowing the file metadata to be updated shouldn't be an
issue.

Mimi

