Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAAC3AD117
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 19:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhFRRYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 13:24:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11134 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235807AbhFRRYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:24:33 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IH4FiH069311;
        Fri, 18 Jun 2021 13:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CZfr7uMYRrnNfPYQsUrgOexzfNfFPUR4wuHHN0MIa/Y=;
 b=tR4sEZDAIGAsHAI98VdohXr2fnLgI3K6ZGL9XyBYstKpjz8PT1HWXsQVrzycFdMy9RMW
 VQj66sSLHxZcD49vcSCpa6I25ErPF1h/KZkyV0aLBwt57KTV1+IRPSkS9wbrWid9u1HO
 dU0JxjCh/3SXiPY2FDzwJyDIX2TyUyz8qgJfB6bbG2nnKzX8lGLfc94gX0nq62sBoYJi
 oFe+pAo8jCjrdLAbU1lL/mkaahcyxgyikSDRlinVMcuUM9oRmwKC8IKcwGnI9XcQFGQW
 PwbVUhdytdZGJq45Qbv9GbQJENnysx4src5ls5tjf68Gaml2yB/nHoGZ0k4wc52dsOPj qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398xk42dne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 13:22:15 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15IH4RUE072513;
        Fri, 18 Jun 2021 13:22:15 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398xk42dmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 13:22:14 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IHDHYm016853;
        Fri, 18 Jun 2021 17:22:13 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 394m6h9w5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 17:22:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IHMANQ20971802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 17:22:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A15F5A4060;
        Fri, 18 Jun 2021 17:22:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FEA4A405C;
        Fri, 18 Jun 2021 17:22:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.93.34])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 17:22:08 +0000 (GMT)
Message-ID: <2a57faec7fcc69cc1ae6939930adafa5eb164e0c.camel@linux.ibm.com>
Subject: Re: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Date:   Fri, 18 Jun 2021 13:22:07 -0400
In-Reply-To: <CAHC9VhRb_Xg11c-qhQUY_KPf6dyHn06NYACigjN4ee+p8NtB6A@mail.gmail.com>
References: <ee75bde9a17f418984186caa70abd33b@huawei.com>
         <20210616132227.999256-1-roberto.sassu@huawei.com>
         <6e1c9807-d7e8-7c26-e0ee-975afa4b9515@linux.ibm.com>
         <9cb676de40714d0288f85292c1f1a430@huawei.com>
         <d822efcc0bb05178057ab2f52293575124cde1fc.camel@linux.ibm.com>
         <CAHC9VhTv6Zn8gYaB6cG4wPzy_Ty0XjOM-QL4cZ525RnhFY4bTQ@mail.gmail.com>
         <c92d0ac71a8db8bb016a7e94b83c193956d71a26.camel@linux.ibm.com>
         <CAHC9VhRb_Xg11c-qhQUY_KPf6dyHn06NYACigjN4ee+p8NtB6A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -qghBSUzKP886Dw21Oc7aqDouAJOgV6E
X-Proofpoint-GUID: 3FIqQmJU-kr9FUpqww-lxB5Ok5Tjk7R1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_10:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106180100
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-06-18 at 12:35 -0400, Paul Moore wrote:
> On Fri, Jun 18, 2021 at 12:04 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Thu, 2021-06-17 at 23:18 -0400, Paul Moore wrote:
> > > On Thu, Jun 17, 2021 at 11:28 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Thu, 2021-06-17 at 07:09 +0000, Roberto Sassu wrote:
> > >
> > > ...
> > >
> > > > > An alternative would be to do the EVM verification twice if the
> > > > > first time didn't succeed (with vfs_getxattr_alloc() and with the
> > > > > new function that behaves like vfs_getxattr()).
> > > >
> > > > Unfortunately, I don't see an alternative.
> > >
> > > ... and while unfortunate, the impact should be non-existant if you
> > > are using the right tools to label files or ensuring that you are
> > > formatting labels properly if doing it by hand.
> > >
> > > Handling a corner case is good, but I wouldn't add a lot of code
> > > complexity trying to optimize it.
> >
> > From userspace it's really difficult to understand the EVM signature
> > verification failure is due to the missing NULL.
> 
> I would argue that any signature verification failure, regardless of
> the mechanism, is hard to understand.  It either passes or it fails,
> and if it fails good luck trying to determine what exactly isn't
> matching up; especially if you really don't know the Right Value.

In this case, the discussion is about signing and verifying file meta-
data hashes.  With EVM portable and immutable signatures, the file
meta-data is known.  The userspace tool evmct is able to verify the
file meta-data signature, which the kernel rejects.

> What I mean by the corner case was the fact that the recommended tools
> should always do the right thing with respect to '\0' termination,
> this should really only be an issue if someone is winging it and doing
> it by hand or with their own tools.

I'm not disagreeing with you.  However, it's still annoying, confusing,
and really frustrating.   That's why we're at least including debugging
information.  In addtion, Roberto will provide the reason.

thanks,

Mimi

