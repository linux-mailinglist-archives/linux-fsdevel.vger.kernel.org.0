Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293312CF037
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 16:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbgLDPAh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 4 Dec 2020 10:00:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2209 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDPAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:00:37 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CnbQB1sBRz67LGf;
        Fri,  4 Dec 2020 22:56:50 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 4 Dec 2020 15:59:54 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2106.002;
 Fri, 4 Dec 2020 15:59:54 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH v3 06/11] evm: Ignore INTEGRITY_NOLABEL if no HMAC key is
 loaded
Thread-Topic: [PATCH v3 06/11] evm: Ignore INTEGRITY_NOLABEL if no HMAC key is
 loaded
Thread-Index: AQHWuAyPc3OXOTvUVE6QYcHvma97kKnl6NcAgADOOtCAAEQzgIAAKDSg
Date:   Fri, 4 Dec 2020 14:59:54 +0000
Message-ID: <f36fa4c332b14ca2ba17a17d44fbe8cb@huawei.com>
References: <20201111092302.1589-1-roberto.sassu@huawei.com>
         <20201111092302.1589-7-roberto.sassu@huawei.com>
         <b9f1a31e9b2dfb7a7167574a39652932263488e8.camel@linux.ibm.com>
         <3c628dc54804469597a72d03c33e8315@huawei.com>
 <0eec775cf5c44f646defe33aec5f241a06844d3a.camel@linux.ibm.com>
In-Reply-To: <0eec775cf5c44f646defe33aec5f241a06844d3a.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Friday, December 4, 2020 2:05 PM
> On Fri, 2020-12-04 at 08:05 +0000, Roberto Sassu wrote:
> > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > > Sent: Thursday, December 3, 2020 9:43 PM
> > > Hi Roberto,
> > >
> > > On Wed, 2020-11-11 at 10:22 +0100, Roberto Sassu wrote:
> > > > When a file is being created, LSMs can set the initial label with the
> > > > inode_init_security hook. If no HMAC key is loaded, the new file will
> have
> > > > LSM xattrs but not the HMAC.
> > > >
> > > > Unfortunately, EVM will deny any further metadata operation on new
> > > files,
> > > > as evm_protect_xattr() will always return the INTEGRITY_NOLABEL
> error.
> > > This
> > > > would limit the usability of EVM when only a public key is loaded, as
> > > > commands such as cp or tar with the option to preserve xattrs won't
> work.
> > > >
> > > > Ignoring this error won't be an issue if no HMAC key is loaded, as the
> > > > inode is locked until the post hook, and EVM won't calculate the HMAC
> on
> > > > metadata that wasn't previously verified. Thus this patch checks if an
> > > > HMAC key is loaded and if not, ignores INTEGRITY_NOLABEL.
> > >
> > > I'm not sure what problem this patch is trying to solve.
> > > evm_protect_xattr() is only called by evm_inode_setxattr() and
> > > evm_inode_removexattr(), which first checks whether
> > > EVM_ALLOW_METADATA_WRITES is enabled.
> >
> > The idea is to also support EVM verification when only a public key
> > is loaded. An advantage to do that is that for example we can prevent
> > accidental metadata changes when the signature is portable.
> 
> Right, there are a couple of  scenarios.  Let's be more specific as to
> which scenario this patch is addressing.
> 
> - a public key is loaded and EVM_ALLOW_METADATA_WRITES is enabled,
> - a public key is loaded and EVM_ALLOW_METADATA_WRITES is disabled,
> - an HMAC key is loaded
> 
> For the first and last case, this patch shouldn't be necessary.  Only
> the second case, with EVM_ALLOW_METADATA_WRITES disabled, probably
> does
> not work.  I would claim that is working as designed.

If there is no HMAC key loaded and a file is created, I think EVM should
not expect an HMAC and return an error. If we do metadata verification
only when an HMAC key is loaded, we miss a functionality that could be
useful also when only a public key is loaded.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
