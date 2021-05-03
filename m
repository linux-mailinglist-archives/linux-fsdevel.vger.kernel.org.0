Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D7B371869
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhECPtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 11:49:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230236AbhECPtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 11:49:14 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143FXFOj083905;
        Mon, 3 May 2021 11:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QY8Fwva9jUAcObQQsHazOSmDv+lc05cpJZ4JdnaU6Pg=;
 b=q+nusEJGIyennrSNy+sGRwLw5a8qtR7A1j1sQLfkjk87VK7v1sFs4HuJRnFxcmfcfGAP
 hATpUZljHbXTUp3s9tHFZcZxXdPSq8zhiRyNjBwjB0C1rXQqCt8udPTO1f+JPhJBXDB9
 RmVFJlGWZAvH6sE+vMVCyIY/xqT9Yb+K267vMT2aRP8vTb7f/NqLMo0GVAHUwVN0wI/V
 KPRYfzLo72X1gMyNKAYLVwjlQp7JWpWD1POddMkr/brakcyostxctnd2aFqNXL2CHXEl
 KbKiyHY4XTrDg1k3Olmh5eQM7DreLvlKLEJHPc0eWydlKBWjMhqRUZG9Blts2MSoZEtH ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38akutgfh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 11:48:15 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143FXGfi084082;
        Mon, 3 May 2021 11:48:13 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38akutgfgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 11:48:12 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143Fb20N028891;
        Mon, 3 May 2021 15:48:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 388xm8rsma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 15:48:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143FlhJK33358216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 15:47:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A14F11C04A;
        Mon,  3 May 2021 15:48:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14C3C11C04C;
        Mon,  3 May 2021 15:48:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.45.89])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 15:48:05 +0000 (GMT)
Message-ID: <d48e3595d0a39cc0ac82519c1c444eeacc8b8c58.camel@linux.ibm.com>
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
Date:   Mon, 03 May 2021 11:48:04 -0400
In-Reply-To: <b0bfaf2352b045dfaf443ae3af73b60e@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-10-roberto.sassu@huawei.com>
         <8493d7e2b0fefa4cd3861bd6b7ee6f2340aa7434.camel@linux.ibm.com>
         <fcd2932bc2a841c2aa7fcbdaee94e0a5@huawei.com>
         <cf12878833c82710ad4356e7d023cf51241f3cc8.camel@linux.ibm.com>
         <b0bfaf2352b045dfaf443ae3af73b60e@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v-k7iafBdxqr1f3U7Ucp7k5fB8Guv1JS
X-Proofpoint-ORIG-GUID: DruteI17ux7fFn6dLtJ1yRwr2BsQX5dX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_10:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030105
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-05-03 at 15:32 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Monday, May 3, 2021 5:26 PM
> > On Mon, 2021-05-03 at 15:11 +0000, Roberto Sassu wrote:
> > > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > > > Sent: Monday, May 3, 2021 3:00 PM
> > > > On Wed, 2021-04-07 at 12:52 +0200, Roberto Sassu wrote:
> > > >
> > > > > diff --git a/security/integrity/evm/evm_main.c
> > > > b/security/integrity/evm/evm_main.c
> > > > > @@ -389,6 +473,11 @@ static int evm_protect_xattr(struct
> > > > user_namespace *mnt_userns,
> > > > >  	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
> > > > >  		return 0;
> > > > >
> > > > > +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> > > > > +	    !evm_xattr_change(mnt_userns, dentry, xattr_name, xattr_value,
> > > > > +			      xattr_value_len))
> > > > > +		return 0;
> > > > > +
> > > >
> > > > If the purpose of evm_protect_xattr() is to prevent allowing an invalid
> > > > security.evm xattr from being re-calculated and updated, making it
> > > > valid, INTEGRITY_PASS_IMMUTABLE shouldn't need to be conditional.
> > Any
> > > > time there is an attr or xattr change, including setting it to the
> > > > existing value, the status flag should be reset.
> > > >
> > > > I'm wondering if making INTEGRITY_PASS_IMMUTABLE conditional would
> > > > prevent the file from being resigned.
> > > >
> > > > >  	if (evm_status != INTEGRITY_PASS)
> > > > >  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > > > d_backing_inode(dentry),
> > > > >  				    dentry->d_name.name,
> > > > "appraise_metadata",
> > > >
> > > > This would then be updated to if not INTEGRITY_PASS or
> > > > INTEGRITY_PASS_IMMUTABLE.  The subsequent "return" would need to
> > be
> > > > updated as well.
> > >
> > > I agree on the first suggestion, to reduce the number of log messages.
> > > For the second, if you meant that we should return 0 if the status is
> > > INTEGRITY_PASS_IMMUTABLE, I thought we wanted to deny xattr
> > > changes when there is an EVM portable signature.
> > 
> > Why?  I must be missing something.  As long as we're not relying on the
> > cached status, allowing the file metadata to be updated shouldn't be an
> > issue.
> 
> We may want to prevent accidental changes, for example.

Let's keep it simple, getting the basics working properly first.  Then
we can decide if this is something that we really want/need to defend
against.

thanks,

Mimi

