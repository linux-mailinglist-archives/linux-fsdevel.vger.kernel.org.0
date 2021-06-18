Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8D3ACFCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 18:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhFRQG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 12:06:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235724AbhFRQGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:06:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IG45dr088167;
        Fri, 18 Jun 2021 12:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=f0ceIPiYDxY/booagKQSwOn88XfgJKGtoIutFEB+Cjs=;
 b=Xh0g8a/JdFKWjh1pa6DJZMSzNkpGOwnVLdQ1kOXceSR4Rh3Vwhzay+YlDMPmA2z3H83A
 zmu6+dFK+xHyewV9jcr+/g9H/iOpO7Ojz1+3k6gm7YLJyk6FXalRsz04RlWU+mKEl3h+
 Y641lxUpBOK8czXEBko1/Ml1nqDZ+CpYdbeObvm1HOprUZdrYrZtYzHhB9y2NMXQ8uDG
 UB6FXJPItSz8MW6iiDV3ViFULSmJmbiNAZzVOc3M2gNoD8D97MgQtVRt/EtvyS8Kp7zg
 E32poU4B33G/dTUBwurwi5hNSenz1PoHCmAvepIRgqHMG5VGyqDrPQ/OsX24Cn1aCNVj MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398xd6gng4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 12:04:30 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15IG4THq094487;
        Fri, 18 Jun 2021 12:04:29 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398xd6gnem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 12:04:29 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IG4QeY015728;
        Fri, 18 Jun 2021 16:04:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 394m6h9vp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 16:04:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IG4OkL20644140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:04:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D393A4064;
        Fri, 18 Jun 2021 16:04:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E6E6A4060;
        Fri, 18 Jun 2021 16:04:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.93.34])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 16:04:22 +0000 (GMT)
Message-ID: <c92d0ac71a8db8bb016a7e94b83c193956d71a26.camel@linux.ibm.com>
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
Date:   Fri, 18 Jun 2021 12:04:21 -0400
In-Reply-To: <CAHC9VhTv6Zn8gYaB6cG4wPzy_Ty0XjOM-QL4cZ525RnhFY4bTQ@mail.gmail.com>
References: <ee75bde9a17f418984186caa70abd33b@huawei.com>
         <20210616132227.999256-1-roberto.sassu@huawei.com>
         <6e1c9807-d7e8-7c26-e0ee-975afa4b9515@linux.ibm.com>
         <9cb676de40714d0288f85292c1f1a430@huawei.com>
         <d822efcc0bb05178057ab2f52293575124cde1fc.camel@linux.ibm.com>
         <CAHC9VhTv6Zn8gYaB6cG4wPzy_Ty0XjOM-QL4cZ525RnhFY4bTQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AdhDHHaCU3yaVieHCH-VrseouUkXcA_2
X-Proofpoint-ORIG-GUID: CkEmq2yFkV_GcP0onKt5fShi-ls-1vh3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_07:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180094
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-06-17 at 23:18 -0400, Paul Moore wrote:
> On Thu, Jun 17, 2021 at 11:28 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Thu, 2021-06-17 at 07:09 +0000, Roberto Sassu wrote:
> 
> ...
> 
> > > An alternative would be to do the EVM verification twice if the
> > > first time didn't succeed (with vfs_getxattr_alloc() and with the
> > > new function that behaves like vfs_getxattr()).
> >
> > Unfortunately, I don't see an alternative.
> 
> ... and while unfortunate, the impact should be non-existant if you
> are using the right tools to label files or ensuring that you are
> formatting labels properly if doing it by hand.
> 
> Handling a corner case is good, but I wouldn't add a lot of code
> complexity trying to optimize it.

From userspace it's really difficult to understand the EVM signature
verification failure is due to the missing NULL.

Roberto, I just pushed the "evm: output EVM digest calculation info"
patch to the next-integrity-testing branch, which includes some
debugging.   Instead of this patch, which returns the raw xattr data,
how about adding additional debugging info in evm_calc_hmac_or_hash()
indicating the size discrepancy between the raw xattr and the LSM
returned xattr?

thanks,

Mimi

