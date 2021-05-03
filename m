Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3D2371812
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhECPdu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 3 May 2021 11:33:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2990 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhECPdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 11:33:47 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FYmxL2qmLz6snwd;
        Mon,  3 May 2021 23:24:54 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 3 May 2021 17:32:52 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Mon, 3 May 2021 17:32:52 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: RE: [PATCH v5 09/12] evm: Allow setxattr() and setattr() for
 unmodified metadata
Thread-Topic: [PATCH v5 09/12] evm: Allow setxattr() and setattr() for
 unmodified metadata
Thread-Index: AQHXK5xeSg6sM/30eEKbqlkQ5rVFkKrRv8yAgABEE/D//+S7AIAAIuSw
Date:   Mon, 3 May 2021 15:32:52 +0000
Message-ID: <b0bfaf2352b045dfaf443ae3af73b60e@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-10-roberto.sassu@huawei.com>
         <8493d7e2b0fefa4cd3861bd6b7ee6f2340aa7434.camel@linux.ibm.com>
         <fcd2932bc2a841c2aa7fcbdaee94e0a5@huawei.com>
 <cf12878833c82710ad4356e7d023cf51241f3cc8.camel@linux.ibm.com>
In-Reply-To: <cf12878833c82710ad4356e7d023cf51241f3cc8.camel@linux.ibm.com>
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
> Sent: Monday, May 3, 2021 5:26 PM
> On Mon, 2021-05-03 at 15:11 +0000, Roberto Sassu wrote:
> > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > > Sent: Monday, May 3, 2021 3:00 PM
> > > On Wed, 2021-04-07 at 12:52 +0200, Roberto Sassu wrote:
> > >
> > > > diff --git a/security/integrity/evm/evm_main.c
> > > b/security/integrity/evm/evm_main.c
> > > > @@ -389,6 +473,11 @@ static int evm_protect_xattr(struct
> > > user_namespace *mnt_userns,
> > > >  	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
> > > >  		return 0;
> > > >
> > > > +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> > > > +	    !evm_xattr_change(mnt_userns, dentry, xattr_name, xattr_value,
> > > > +			      xattr_value_len))
> > > > +		return 0;
> > > > +
> > >
> > > If the purpose of evm_protect_xattr() is to prevent allowing an invalid
> > > security.evm xattr from being re-calculated and updated, making it
> > > valid, INTEGRITY_PASS_IMMUTABLE shouldn't need to be conditional.
> Any
> > > time there is an attr or xattr change, including setting it to the
> > > existing value, the status flag should be reset.
> > >
> > > I'm wondering if making INTEGRITY_PASS_IMMUTABLE conditional would
> > > prevent the file from being resigned.
> > >
> > > >  	if (evm_status != INTEGRITY_PASS)
> > > >  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> > > d_backing_inode(dentry),
> > > >  				    dentry->d_name.name,
> > > "appraise_metadata",
> > >
> > > This would then be updated to if not INTEGRITY_PASS or
> > > INTEGRITY_PASS_IMMUTABLE.  The subsequent "return" would need to
> be
> > > updated as well.
> >
> > I agree on the first suggestion, to reduce the number of log messages.
> > For the second, if you meant that we should return 0 if the status is
> > INTEGRITY_PASS_IMMUTABLE, I thought we wanted to deny xattr
> > changes when there is an EVM portable signature.
> 
> Why?  I must be missing something.  As long as we're not relying on the
> cached status, allowing the file metadata to be updated shouldn't be an
> issue.

We may want to prevent accidental changes, for example.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
