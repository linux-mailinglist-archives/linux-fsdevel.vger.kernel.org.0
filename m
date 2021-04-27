Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34A236C1AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhD0JZ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 05:25:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2921 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhD0JZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 05:25:54 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FTx0s5fX5z77b5Y;
        Tue, 27 Apr 2021 17:14:37 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 11:25:09 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Tue, 27 Apr 2021 11:25:09 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
Thread-Topic: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
Thread-Index: AQHXEdMA2oN9D131skWV9JJ8Z5VEUap1limAgFHPEQCAAOj3gA==
Date:   Tue, 27 Apr 2021 09:25:09 +0000
Message-ID: <7a39600c24a740838dca24c20af92c1a@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
         <20210305151923.29039-5-roberto.sassu@huawei.com>
         <c3bb1069-c732-d3cf-0dde-7a83b3f31871@schaufler-ca.com>
 <93858a47a29831ca782c8388faaa43c8ffc3f5cd.camel@linux.ibm.com>
In-Reply-To: <93858a47a29831ca782c8388faaa43c8ffc3f5cd.camel@linux.ibm.com>
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
> Sent: Monday, April 26, 2021 9:49 PM
> On Fri, 2021-03-05 at 09:30 -0800, Casey Schaufler wrote:
> > On 3/5/2021 7:19 AM, Roberto Sassu wrote:
> > > ima_inode_setxattr() and ima_inode_removexattr() hooks are called before
> an
> > > operation is performed. Thus, ima_reset_appraise_flags() should not be
> > > called there, as flags might be unnecessarily reset if the operation is
> > > denied.
> > >
> > > This patch introduces the post hooks ima_inode_post_setxattr() and
> > > ima_inode_post_removexattr(), and adds the call to
> > > ima_reset_appraise_flags() in the new functions.
> >
> > I don't see anything wrong with this patch in light of the way
> > IMA and EVM have been treated to date.
> >
> > However ...
> >
> > The special casing of IMA and EVM in security.c is getting out of
> > hand, and appears to be unnecessary. By my count there are 9 IMA
> > hooks and 5 EVM hooks that have been hard coded. Adding this IMA
> > hook makes 10. It would be really easy to register IMA and EVM as
> > security modules. That would remove the dependency they currently
> > have on security sub-system approval for changes like this one.
> > I know there has been resistance to "IMA as an LSM" in the past,
> > but it's pretty hard to see how it wouldn't be a win.
> 
> Somehow I missed the new "lsm=" boot command line option, which
> dynamically allows enabling/disabling LSMs, being upstreamed.  This
> would be one of the reasons for not making IMA/EVM full LSMs.

Hi Mimi

one could argue why IMA/EVM should receive a special
treatment. I understand that this was a necessity without
LSM stacking. Now that LSM stacking is available, I don't
see any valid reason why IMA/EVM should not be managed
by the LSM infrastructure.

> Both IMA and EVM file data/metadata is persistent across boots.  If
> either one or the other is not enabled the file data hash or file
> metadata HMAC will not properly be updated, potentially preventing the
> system from booting when re-enabled.  Re-enabling IMA and EVM would
> require "fixing" the mutable file data hash and HMAC, without any
> knowledge of what the "fixed" values should be.  Dave Safford referred
> to this as "blessing" the newly calculated values.

IMA/EVM can be easily disabled in other ways, for example
by moving the IMA policy or the EVM keys elsewhere.

Also other LSMs rely on a dynamic and persistent state
(for example for file transitions in SELinux), which cannot be
trusted anymore if LSMs are even temporarily disabled.

If IMA/EVM have to be enabled to prevent misconfiguration,
I think the same can be achieved if they are full LSMs, for
example by preventing that the list of enabled LSMs changes
at run-time.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
