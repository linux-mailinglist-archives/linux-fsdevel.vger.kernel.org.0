Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0611CE791
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 23:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgEKVhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 17:37:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgEKVhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 17:37:03 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BLX31O014735;
        Mon, 11 May 2020 17:36:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30wrw4ev5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 17:36:56 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04BLZpxi021911;
        Mon, 11 May 2020 17:36:55 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30wrw4ev56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 17:36:55 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04BLPMWh000485;
        Mon, 11 May 2020 21:36:54 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55d4y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 21:36:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04BLapNm2752984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 21:36:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B467F42047;
        Mon, 11 May 2020 21:36:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CADE42041;
        Mon, 11 May 2020 21:36:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.225.244])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 May 2020 21:36:50 +0000 (GMT)
Message-ID: <1589233010.5091.49.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "david.safford@gmail.com" <david.safford@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jmorris@namei.org" <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Mon, 11 May 2020 17:36:50 -0400
In-Reply-To: <414644a0be9e4af880452f4b5079aba1@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
         <1588794293.4624.21.camel@linux.ibm.com>
         <1588799408.4624.28.camel@linux.ibm.com>
         <ab879f9e66874736a40e9c566cadc272@huawei.com>
         <1588864628.5685.78.camel@linux.ibm.com>
         <750ab4e0990f47e4aea10d0e580b1074@huawei.com>
         <1588884313.5685.110.camel@linux.ibm.com>
         <84e6acad739a415aa3e2457b5c37979f@huawei.com>
         <1588957684.5146.70.camel@linux.ibm.com>
         <414644a0be9e4af880452f4b5079aba1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_10:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110159
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-05-11 at 14:13 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Friday, May 8, 2020 7:08 PM
> > On Fri, 2020-05-08 at 10:20 +0000, Roberto Sassu wrote:
> > > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > > > On Thu, 2020-05-07 at 16:47 +0000, Roberto Sassu wrote:
> > 
> > <snip>
> > 
> > > > > > the file metadata to the file data.  The IMA and EVM policies really
> > > > > > need to be in sync.
> > > > >
> > > > > It would be nice, but at the moment EVM considers also files that are
> > > > > not selected by the IMA policy. An example of why this is a problem is
> > > > > the audit service that fails to start when it tries to adjust the
> > permissions
> > > > > of the log files. Those files don't have security.evm because they are
> > > > > not appraised by IMA, but EVM denies the operation.
> > > >
> > > > No, this is a timing issue as to whether or not the builtin policy or
> > > > a custom policy has been loaded.  A custom policy could exclude the
> > > > log files based on LSM labels, but they are included in the builtin
> > > > policy.
> > >
> > > Yes, I was referring to a custom policy. In this case, EVM will not adapt
> > > to the custom policy but still verifies all files. If access control is done
> > > exclusively by IMA at the time evm_verifyxattr() is called, we wouldn't
> > > need to add security.evm to all files.
> > 
> > Roberto, EVM is only triggered by IMA, unless you've modified the
> > kernel to do otherwise.
> 
> EVM would deny xattr/attr operations even if IMA is disabled in the
> kernel configuration. For example, evm_setxattr() returns the value
> from evm_protect_xattr(). IMA is not involved there.

Commit ae1ba1676b88 ("EVM: Allow userland to permit modification of
EVM-protected metadata") introduced EVM_ALLOW_METADATA_WRITES to allow
writing the EVM portable and immutable file signatures. 

> 
> > I'm not interested in a complicated solution, just one that addresses
> > the new EVM immutable and portable signature.  It might require EVM
> > HMAC, IMA differentiating between a new file and an existing file, or:q

> > it might require writing the new EVM signature last, after all the
> > other xattrs or metadata are updated.  Please nothing that changes
> > existing expectations.
> 
> Ok. Introducing the new status INTEGRITY_FAIL_IMMUTABLE, as I
> mentioned in '[PATCH] ima: Allow imasig requirement to be satisfied by
> EVM portable signatures' seems to have an additional benefit. We
> could introduce an additional exception in evm_protect_xattr(), other
> than INTEGRITY_NOXATTRS, as we know that xattr/attr update won't
> cause HMAC update.

Refer to Documentation/ABI/testing/evm describes on how to permit
writing the security.evm signatures.
> 
> However, it won't work unless the IMA policy says that the file should
> be appraised when the mknod() system call is executed. Otherwise,
> integrity_iint_cache is not created for the file and the IMA_NEW_FILE
> flag is not set.
> 
> Granting an exception for INTEGRITY_FAIL_IMMUTABLE solves the case
> where security.evm is the first xattr set. If a protected xattr is the first to
> be added, then we also have to handle the INTEGRITY_NOLABEL error.
> It should be fine to add an exception for this error if the HMAC key is not
> loaded.
> 
> This still does not solve all problems. INTEGRITY_NOLABEL cannot be
> ignored if the HMAC key is loaded, which means that all files need to be
> protected by EVM to avoid issues like the one I described (auditd).

The application still needs to defer writing the EVM portable and
immutable file signatures until after all the other xattrs are written
otherwise it won't validate.

Mimi
