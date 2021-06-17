Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4ADA3AB77B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 17:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhFQPaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 11:30:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232257AbhFQPaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:30:22 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HF3HfG023885;
        Thu, 17 Jun 2021 11:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=B5VyyTlpO5CWTD+3XudEaDgMMTv1yACF6z5CahQ2DIU=;
 b=gQT7QubTv+Ka2B7ACzCO4BYwZhvt7AberwLPhzS6ajKIx+qJVAGPO+7hGgWQ7qq6PEFL
 9dZsleclcluVIS2mn3IUE8fBWHmJfsqomT5D5tVP5SIu1aDaiSvsalW/nRo6KN0/2gXj
 EPMMPAZDhI6KRc8h/3G6NwM8l5iPG36M1dcnjCV5YtFQVlbDBO9mEvqjarIcUjTBNcD/
 f42Ebk+xJn3RPOJYc6BS43F8O4712+l6SenLtkWTSaiZuLxbj82R+WkqFH5tBXv704QR
 PyCQez73mwj+vzfLKTe9XeLzWO+InecUrh0gY2EhZpWKWy/8S+6KYn6dFjyFG7EkZ0yj cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3987hkbws2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 11:28:07 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15HF3eIv029293;
        Thu, 17 Jun 2021 11:28:07 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3987hkbwr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 11:28:07 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15HFRZoH013773;
        Thu, 17 Jun 2021 15:28:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 394mj91j61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 15:28:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15HFS2WG30212590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 15:28:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53B7711C052;
        Thu, 17 Jun 2021 15:28:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58EE811C04A;
        Thu, 17 Jun 2021 15:28:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.34.125])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jun 2021 15:28:00 +0000 (GMT)
Message-ID: <d822efcc0bb05178057ab2f52293575124cde1fc.camel@linux.ibm.com>
Subject: Re: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Date:   Thu, 17 Jun 2021 11:27:59 -0400
In-Reply-To: <9cb676de40714d0288f85292c1f1a430@huawei.com>
References: <ee75bde9a17f418984186caa70abd33b@huawei.com>
         <20210616132227.999256-1-roberto.sassu@huawei.com>
         <6e1c9807-d7e8-7c26-e0ee-975afa4b9515@linux.ibm.com>
         <9cb676de40714d0288f85292c1f1a430@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lRZmVtAh7jKl-0j2JO-JPd-N0B_lzhWX
X-Proofpoint-ORIG-GUID: t0JJjBXIxLsvFzMMht6ohgmQa3Iwa8OC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_13:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170096
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-06-17 at 07:09 +0000, Roberto Sassu wrote:
> > From: Stefan Berger [mailto:stefanb@linux.ibm.com]
> > Sent: Wednesday, June 16, 2021 4:40 PM
> > On 6/16/21 9:22 AM, Roberto Sassu wrote:
> > > vfs_getxattr() differs from vfs_setxattr() in the way it obtains the xattr
> > > value. The former gives precedence to the LSMs, and if the LSMs don't
> > > provide a value, obtains it from the filesystem handler. The latter does
> > > the opposite, first invokes the filesystem handler, and if the filesystem
> > > does not support xattrs, passes the xattr value to the LSMs.
> > >
> > > The problem is that not necessarily the user gets the same xattr value that
> > > he set. For example, if he sets security.selinux with a value not
> > > terminated with '\0', he gets a value terminated with '\0' because SELinux
> > > adds it during the translation from xattr to internal representation
> > > (vfs_setxattr()) and from internal representation to xattr
> > > (vfs_getxattr()).
> > >
> > > Normally, this does not have an impact unless the integrity of xattrs is
> > > verified with EVM. The kernel and the user see different values due to the
> > > different functions used to obtain them:
> > >
> > > kernel (EVM): uses vfs_getxattr_alloc() which obtains the xattr value from
> > >                the filesystem handler (raw value);
> > >
> > > user (ima-evm-utils): uses vfs_getxattr() which obtains the xattr value
> > >                        from the LSMs (normalized value).
> > 
> > Maybe there should be another implementation similar to
> > vfs_getxattr_alloc() (or modify it) to behave like vfs_getxattr() but do
> > the memory allocation part so that the kernel sees what user space see
> > rather than modifying it with your patch so that user space now sees
> > something different than what it has been for years (previous
> > NUL-terminated SELinux xattr may not be NUL-terminated anymore)?
> 
> I'm concerned that this would break HMACs/digital signatures
> calculated with raw values.

Which would happen if the LSM is not enabled (e.g. "lsm=" boot command
line option).

> 
> An alternative would be to do the EVM verification twice if the
> first time didn't succeed (with vfs_getxattr_alloc() and with the
> new function that behaves like vfs_getxattr()).

Unfortunately, I don't see an alternative.

thanks,

Mimi

