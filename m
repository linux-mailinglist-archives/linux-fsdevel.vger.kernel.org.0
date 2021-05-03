Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1937180A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 17:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhECPbo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 3 May 2021 11:31:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2989 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhECPbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 11:31:44 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FYmty2rZMz6snwb;
        Mon,  3 May 2021 23:22:50 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 3 May 2021 17:30:48 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Mon, 3 May 2021 17:30:48 +0200
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
Thread-Index: AQHXK5xeSg6sM/30eEKbqlkQ5rVFkKrRv8yAgAAwwJD///RugIAAImfA
Date:   Mon, 3 May 2021 15:30:48 +0000
Message-ID: <d599ddac80a94e4bbcd7973d1fa32235@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-10-roberto.sassu@huawei.com>
         <8493d7e2b0fefa4cd3861bd6b7ee6f2340aa7434.camel@linux.ibm.com>
         <06edfc9f779447b9b93f26628327d1e5@huawei.com>
 <33ddeb6108699f47ba47d5f002403ffeca5f9531.camel@linux.ibm.com>
In-Reply-To: <33ddeb6108699f47ba47d5f002403ffeca5f9531.camel@linux.ibm.com>
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
> Sent: Monday, May 3, 2021 5:13 PM
> On Mon, 2021-05-03 at 14:48 +0000, Roberto Sassu wrote:
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
> >
> > The status is always reset if evm_protect_xattr() returns 0. This does not
> > change.
> >
> > Not making INTEGRITY_PASS_IMMUTABLE conditional would cause issues.
> > Suppose that the status is INTEGRITY_FAIL. Writing the same xattr would
> > cause evm_protect_xattr() to return 0 and the HMAC to be updated.
> 
> This example is mixing security.evm types.  Please clarify.

What I meant is that returning 0 when the xattr does not change should
be done only in the positive cases: for INTEGRITY_PASS it is not needed,
for INTEGRITY_PASS_IMMUTABLE it is needed as otherwise
evm_protect_xattr() would return -EPERM.

If your proposal was to return 0 only when the xattr does not change,
without checking the current status, we risk that someone does an
offline attack to corrupt xattrs and when the system is online, he simply
rewrites the same corrupted xattrs to obtain a valid HMAC.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> > > I'm wondering if making INTEGRITY_PASS_IMMUTABLE conditional would
> > > prevent the file from being resigned.
> >
> > INTEGRITY_FAIL_IMMUTABLE should be enough to continue the
> > operation.
> 
> Agreed.
> 
> Mimi

