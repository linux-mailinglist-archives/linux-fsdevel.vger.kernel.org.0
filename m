Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF77372AC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 15:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhEDNRB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 4 May 2021 09:17:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2993 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhEDNRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 09:17:00 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FZKnd07R0z6xhr1;
        Tue,  4 May 2021 21:05:09 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 15:16:03 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Tue, 4 May 2021 15:16:03 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 06/12] evm: Ignore INTEGRITY_NOLABEL/INTEGRITY_NOXATTRS
 if conditions are safe
Thread-Topic: [PATCH v5 06/12] evm: Ignore
 INTEGRITY_NOLABEL/INTEGRITY_NOXATTRS if conditions are safe
Thread-Index: AQHXK5xdbQY13c/E0Ea5lrgi3mZG3arQ6VCAgAChtnCAAGkoMP//5ewAgAGXDOA=
Date:   Tue, 4 May 2021 13:16:03 +0000
Message-ID: <1869963c94574fd1b026b304acdd308e@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-7-roberto.sassu@huawei.com>
         <b8790b57e289980d4fe1133d15203ce016d2319d.camel@linux.ibm.com>
         <c12f18094cc0479faa3f0f152b4964de@huawei.com>
         <33cad84d2f894ed5a05a3bd6854f73a0@huawei.com>
 <a2ca7317b672c63a40743268b641dd73661c3329.camel@linux.ibm.com>
In-Reply-To: <a2ca7317b672c63a40743268b641dd73661c3329.camel@linux.ibm.com>
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
> Sent: Monday, May 3, 2021 4:35 PM
> On Mon, 2021-05-03 at 14:15 +0000, Roberto Sassu wrote:
> 
> > > > >  	if (evm_status != INTEGRITY_PASS)
> > > > >  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > > > d_backing_inode(dentry),
> > > > >  				    dentry->d_name.name,
> > > > "appraise_metadata",
> > > > > @@ -515,7 +535,8 @@ int evm_inode_setattr(struct dentry *dentry,
> > > struct
> > > > iattr *attr)
> > > > >  		return 0;
> > > > >  	evm_status = evm_verify_current_integrity(dentry);
> > > > >  	if ((evm_status == INTEGRITY_PASS) ||
> > > > > -	    (evm_status == INTEGRITY_NOXATTRS))
> > > > > +	    (evm_status == INTEGRITY_NOXATTRS) ||
> > > > > +	    (evm_ignore_error_safe(evm_status)))
> > > >
> > > > It would also remove the INTEGRITY_NOXATTRS test duplication here.
> > >
> > > Ok.
> >
> > Actually, it does not seem a duplication. Currently, INTEGRITY_NOXATTRS
> > is ignored also when the HMAC key is loaded.
> 
> The existing INTEGRITY_NOXATTRS exemption is more general and includes
> the new case of when EVM HMAC is disabled.  The additional exemption is
> only needed for INTEGRITY_NOLABEL, when EVM HMAC is disabled.

Unfortunately, evm_ignore_error_safe() is called by both evm_protect_xattr()
and evm_inode_setattr(). The former requires an exemption also for
INTEGRITY_NOXATTRS.

I would keep the function as it is. In the worst case, when the status is
INTEGRITY_NOXATTRS in evm_inode_setattr(), the function will not
be called.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
