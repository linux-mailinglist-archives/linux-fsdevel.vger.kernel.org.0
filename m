Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D03AB87B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhFQQIT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 12:08:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3263 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhFQQIG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:06 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5RQj1tPMz6K6XT;
        Thu, 17 Jun 2021 23:52:45 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 18:05:55 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Thu, 17 Jun 2021 18:05:55 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
Thread-Topic: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
Thread-Index: AQHXYrKvlTGLZUZH2kigEMb4WxB9T6sWlCeAgAExqRCAAG34gIAAI+uA
Date:   Thu, 17 Jun 2021 16:05:55 +0000
Message-ID: <9e2d4091e6604077aad1225afa5b9805@huawei.com>
References: <ee75bde9a17f418984186caa70abd33b@huawei.com>
         <20210616132227.999256-1-roberto.sassu@huawei.com>
         <6e1c9807-d7e8-7c26-e0ee-975afa4b9515@linux.ibm.com>
         <9cb676de40714d0288f85292c1f1a430@huawei.com>
 <d822efcc0bb05178057ab2f52293575124cde1fc.camel@linux.ibm.com>
In-Reply-To: <d822efcc0bb05178057ab2f52293575124cde1fc.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Thursday, June 17, 2021 5:28 PM
> On Thu, 2021-06-17 at 07:09 +0000, Roberto Sassu wrote:
> > > From: Stefan Berger [mailto:stefanb@linux.ibm.com]
> > > Sent: Wednesday, June 16, 2021 4:40 PM
> > > On 6/16/21 9:22 AM, Roberto Sassu wrote:
> > > > vfs_getxattr() differs from vfs_setxattr() in the way it obtains the xattr
> > > > value. The former gives precedence to the LSMs, and if the LSMs don't
> > > > provide a value, obtains it from the filesystem handler. The latter does
> > > > the opposite, first invokes the filesystem handler, and if the filesystem
> > > > does not support xattrs, passes the xattr value to the LSMs.
> > > >
> > > > The problem is that not necessarily the user gets the same xattr value
> that
> > > > he set. For example, if he sets security.selinux with a value not
> > > > terminated with '\0', he gets a value terminated with '\0' because
> SELinux
> > > > adds it during the translation from xattr to internal representation
> > > > (vfs_setxattr()) and from internal representation to xattr
> > > > (vfs_getxattr()).
> > > >
> > > > Normally, this does not have an impact unless the integrity of xattrs is
> > > > verified with EVM. The kernel and the user see different values due to
> the
> > > > different functions used to obtain them:
> > > >
> > > > kernel (EVM): uses vfs_getxattr_alloc() which obtains the xattr value
> from
> > > >                the filesystem handler (raw value);
> > > >
> > > > user (ima-evm-utils): uses vfs_getxattr() which obtains the xattr value
> > > >                        from the LSMs (normalized value).
> > >
> > > Maybe there should be another implementation similar to
> > > vfs_getxattr_alloc() (or modify it) to behave like vfs_getxattr() but do
> > > the memory allocation part so that the kernel sees what user space see
> > > rather than modifying it with your patch so that user space now sees
> > > something different than what it has been for years (previous
> > > NUL-terminated SELinux xattr may not be NUL-terminated anymore)?
> >
> > I'm concerned that this would break HMACs/digital signatures
> > calculated with raw values.
> 
> Which would happen if the LSM is not enabled (e.g. "lsm=" boot command
> line option).

For files created after switching to the new behavior, yes, because
EVM could eventually get the label without '\0' from the filesystem
handler.

However, it would happen also for files created before switching to
the new behavior, since the HMAC could have been calculated without
'\0' and after switching it would be calculated with '\0'.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> > An alternative would be to do the EVM verification twice if the
> > first time didn't succeed (with vfs_getxattr_alloc() and with the
> > new function that behaves like vfs_getxattr()).
> 
> Unfortunately, I don't see an alternative.
> 
> thanks,
> 
> Mimi

