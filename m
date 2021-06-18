Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3313AD013
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhFRQMa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 12:12:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3289 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhFRQM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:12:29 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G63TD4KPRz6GBQh;
        Fri, 18 Jun 2021 23:57:04 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:18 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Fri, 18 Jun 2021 18:10:18 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
CC:     Stefan Berger <stefanb@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
Thread-Topic: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
Thread-Index: AQHXYrKvlTGLZUZH2kigEMb4WxB9T6sWlCeAgAExqRCAAG34gIAAxn6AgADWAICAACLg0A==
Date:   Fri, 18 Jun 2021 16:10:18 +0000
Message-ID: <f8de8f604a4c46ea934ce0a67363b7f4@huawei.com>
References: <ee75bde9a17f418984186caa70abd33b@huawei.com>
         <20210616132227.999256-1-roberto.sassu@huawei.com>
         <6e1c9807-d7e8-7c26-e0ee-975afa4b9515@linux.ibm.com>
         <9cb676de40714d0288f85292c1f1a430@huawei.com>
         <d822efcc0bb05178057ab2f52293575124cde1fc.camel@linux.ibm.com>
         <CAHC9VhTv6Zn8gYaB6cG4wPzy_Ty0XjOM-QL4cZ525RnhFY4bTQ@mail.gmail.com>
 <c92d0ac71a8db8bb016a7e94b83c193956d71a26.camel@linux.ibm.com>
In-Reply-To: <c92d0ac71a8db8bb016a7e94b83c193956d71a26.camel@linux.ibm.com>
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
> Sent: Friday, June 18, 2021 6:04 PM
> On Thu, 2021-06-17 at 23:18 -0400, Paul Moore wrote:
> > On Thu, Jun 17, 2021 at 11:28 AM Mimi Zohar <zohar@linux.ibm.com>
> wrote:
> > > On Thu, 2021-06-17 at 07:09 +0000, Roberto Sassu wrote:
> >
> > ...
> >
> > > > An alternative would be to do the EVM verification twice if the
> > > > first time didn't succeed (with vfs_getxattr_alloc() and with the
> > > > new function that behaves like vfs_getxattr()).
> > >
> > > Unfortunately, I don't see an alternative.
> >
> > ... and while unfortunate, the impact should be non-existant if you
> > are using the right tools to label files or ensuring that you are
> > formatting labels properly if doing it by hand.
> >
> > Handling a corner case is good, but I wouldn't add a lot of code
> > complexity trying to optimize it.
> 
> From userspace it's really difficult to understand the EVM signature
> verification failure is due to the missing NULL.
> 
> Roberto, I just pushed the "evm: output EVM digest calculation info"
> patch to the next-integrity-testing branch, which includes some
> debugging.   Instead of this patch, which returns the raw xattr data,
> how about adding additional debugging info in evm_calc_hmac_or_hash()
> indicating the size discrepancy between the raw xattr and the LSM
> returned xattr?

Good idea. Will do it.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Mimi

