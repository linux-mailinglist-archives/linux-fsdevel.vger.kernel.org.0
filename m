Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE07F371229
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 09:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhECH40 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 3 May 2021 03:56:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2984 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECH4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 03:56:25 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FYZr86b8mz6wlK1;
        Mon,  3 May 2021 15:49:44 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 3 May 2021 09:55:30 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Mon, 3 May 2021 09:55:30 +0200
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
Thread-Index: AQHXK5xdbQY13c/E0Ea5lrgi3mZG3arQ6VCAgAChtnA=
Date:   Mon, 3 May 2021 07:55:29 +0000
Message-ID: <c12f18094cc0479faa3f0f152b4964de@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-7-roberto.sassu@huawei.com>
 <b8790b57e289980d4fe1133d15203ce016d2319d.camel@linux.ibm.com>
In-Reply-To: <b8790b57e289980d4fe1133d15203ce016d2319d.camel@linux.ibm.com>
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
> Sent: Monday, May 3, 2021 2:13 AM
> Hi Roberto,
> 
> On Wed, 2021-04-07 at 12:52 +0200, Roberto Sassu wrote:
> > When a file is being created, LSMs can set the initial label with the
> > inode_init_security hook. If no HMAC key is loaded, the new file will have
> > LSM xattrs but not the HMAC. It is also possible that the file remains
> > without protected xattrs after creation if no active LSM provided it.
> >
> > Unfortunately, EVM will deny any further metadata operation on new files,
> > as evm_protect_xattr() will always return the INTEGRITY_NOLABEL error, or
> > INTEGRITY_NOXATTRS if no protected xattrs exist. This would limit the
> > usability of EVM when only a public key is loaded, as commands such as cp
> > or tar with the option to preserve xattrs won't work.
> >
> > This patch ignores these errors when they won't be an issue, if no HMAC
> key
> > is loaded and cannot be loaded in the future (which can be enforced by
> > setting the EVM_SETUP_COMPLETE initialization flag).
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/evm/evm_main.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/integrity/evm/evm_main.c
> b/security/integrity/evm/evm_main.c
> > index 998818283fda..6556e8c22da9 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -90,6 +90,24 @@ static bool evm_key_loaded(void)
> >  	return (bool)(evm_initialized & EVM_KEY_MASK);
> >  }
> >
> > +/*
> > + * Ignoring INTEGRITY_NOLABEL/INTEGRITY_NOXATTRS is safe if no HMAC
> key
> > + * is loaded and the EVM_SETUP_COMPLETE initialization flag is set.
> > + */
> > +static bool evm_ignore_error_safe(enum integrity_status evm_status)
> > +{
> > +	if (evm_initialized & EVM_INIT_HMAC)
> > +		return false;
> > +
> > +	if (!(evm_initialized & EVM_SETUP_COMPLETE))
> > +		return false;
> > +
> > +	if (evm_status != INTEGRITY_NOLABEL && evm_status !=
> INTEGRITY_NOXATTRS)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  static int evm_find_protected_xattrs(struct dentry *dentry)
> >  {
> >  	struct inode *inode = d_backing_inode(dentry);
> > @@ -354,6 +372,8 @@ static int evm_protect_xattr(struct dentry *dentry,
> const char *xattr_name,
> >  				    -EPERM, 0);
> >  	}
> >  out:
> > +	if (evm_ignore_error_safe(evm_status))
> > +		return 0;
> 
> I agree with the concept, but the function name doesn't provide enough
> context.  Perhaps defining a function more along the lines of
> "evm_hmac_disabled()" would be more appropriate and at the same time
> self documenting.

Since the function checks if the passed error can be ignored,
would evm_ignore_error_hmac_disabled() also be ok?

> >  	if (evm_status != INTEGRITY_PASS)
> >  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> d_backing_inode(dentry),
> >  				    dentry->d_name.name,
> "appraise_metadata",
> > @@ -515,7 +535,8 @@ int evm_inode_setattr(struct dentry *dentry, struct
> iattr *attr)
> >  		return 0;
> >  	evm_status = evm_verify_current_integrity(dentry);
> >  	if ((evm_status == INTEGRITY_PASS) ||
> > -	    (evm_status == INTEGRITY_NOXATTRS))
> > +	    (evm_status == INTEGRITY_NOXATTRS) ||
> > +	    (evm_ignore_error_safe(evm_status)))
> 
> It would also remove the INTEGRITY_NOXATTRS test duplication here.

Ok.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Mimi
> 
> >  		return 0;
> >  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> d_backing_inode(dentry),
> >  			    dentry->d_name.name, "appraise_metadata",

