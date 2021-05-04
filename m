Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7474372BFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 16:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhEDO3S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 4 May 2021 10:29:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2994 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhEDO3R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 10:29:17 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FZMVx5nz0z6wl3H;
        Tue,  4 May 2021 22:22:33 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 16:28:20 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Tue, 4 May 2021 16:28:20 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 07/12] evm: Allow xattr/attr operations for portable
 signatures
Thread-Topic: [PATCH v5 07/12] evm: Allow xattr/attr operations for portable
 signatures
Thread-Index: AQHXK5xd0AHnuLl5+keiWE38ndTKp6rQ6VqAgAKhvZA=
Date:   Tue, 4 May 2021 14:28:20 +0000
Message-ID: <f26f4b6fd3074bb4a6f0f0ff4911a202@huawei.com>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
         <20210407105252.30721-8-roberto.sassu@huawei.com>
 <75e8a4f70dfbbfa4cf5b923ab0ac92768e1e2de5.camel@linux.ibm.com>
In-Reply-To: <75e8a4f70dfbbfa4cf5b923ab0ac92768e1e2de5.camel@linux.ibm.com>
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
> > diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > index 2271939c5c31..2ea0f2f65ab6 100644
> > --- a/include/linux/integrity.h
> > +++ b/include/linux/integrity.h
> >
> > @@ -238,9 +241,12 @@ static enum integrity_status
> evm_verify_hmac(struct dentry *dentry,
> >  		break;
> >  	}
> >
> > -	if (rc)
> > -		evm_status = (rc == -ENODATA) ?
> > -				INTEGRITY_NOXATTRS : INTEGRITY_FAIL;
> > +	if (rc) {
> > +		evm_status = INTEGRITY_NOXATTRS;
> > +		if (rc != -ENODATA)
> > +			evm_status = evm_immutable ?
> > +				     INTEGRITY_FAIL_IMMUTABLE :
> INTEGRITY_FAIL;
> 
> The original code made an exception for the -ENODATA case.   Using a
> ternary operator made sense in that case.   Inverting the test makes
> the code less readable.  Please use the standard "if" statement
> instead.

Did I understand correctly that the code should be:

                evm_status = INTEGRITY_NOXATTRS;
                if (rc != -ENODATA) {
                        evm_status = INTEGRITY_FAIL;
                        if (evm_immutable)
                                evm_status = INTEGRITY_FAIL_IMMUTABLE;
                }

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Mimi

