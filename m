Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9036C8FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 17:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhD0P6o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 11:58:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2932 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhD0P6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:58:43 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FV5qn3nlRz74dD9;
        Tue, 27 Apr 2021 23:52:21 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 17:57:58 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Tue, 27 Apr 2021 17:57:58 +0200
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
Thread-Index: AQHXEdMA2oN9D131skWV9JJ8Z5VEUap1limAgFHPEQCAAOj3gIAAYluAgAAixgA=
Date:   Tue, 27 Apr 2021 15:57:57 +0000
Message-ID: <d783e2703248463f9af68e155ee65c38@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
         <20210305151923.29039-5-roberto.sassu@huawei.com>
         <c3bb1069-c732-d3cf-0dde-7a83b3f31871@schaufler-ca.com>
         <93858a47a29831ca782c8388faaa43c8ffc3f5cd.camel@linux.ibm.com>
         <7a39600c24a740838dca24c20af92c1a@huawei.com>
 <d047d1347e7104162e0e36eb57ade6bba914ea2d.camel@linux.ibm.com>
In-Reply-To: <d047d1347e7104162e0e36eb57ade6bba914ea2d.camel@linux.ibm.com>
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
> Sent: Tuesday, April 27, 2021 5:35 PM
> On Tue, 2021-04-27 at 09:25 +0000, Roberto Sassu wrote:
> > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > > Sent: Monday, April 26, 2021 9:49 PM
> > > On Fri, 2021-03-05 at 09:30 -0800, Casey Schaufler wrote:
> 
> > > > However ...
> > > >
> > > > The special casing of IMA and EVM in security.c is getting out of
> > > > hand, and appears to be unnecessary. By my count there are 9 IMA
> > > > hooks and 5 EVM hooks that have been hard coded. Adding this IMA
> > > > hook makes 10. It would be really easy to register IMA and EVM as
> > > > security modules. That would remove the dependency they currently
> > > > have on security sub-system approval for changes like this one.
> > > > I know there has been resistance to "IMA as an LSM" in the past,
> > > > but it's pretty hard to see how it wouldn't be a win.
> 
> It sholdn't be one way.  Are you willing to also make the existing
> IMA/EVM hooks that are not currently security hooks, security hooks
> too?   And accept any new IMA/EVM hooks would result in new security
> hooks?  Are you also willing to add dependency tracking between LSMs?

I already have a preliminary branch where IMA/EVM are full LSMs.

Indeed, the biggest problem would be to have the new hooks
accepted. I can send the patch set for evaluation to see what
people think.

> > > Somehow I missed the new "lsm=" boot command line option, which
> > > dynamically allows enabling/disabling LSMs, being upstreamed.  This
> > > would be one of the reasons for not making IMA/EVM full LSMs.
> >
> > Hi Mimi
> >
> > one could argue why IMA/EVM should receive a special
> > treatment. I understand that this was a necessity without
> > LSM stacking. Now that LSM stacking is available, I don't
> > see any valid reason why IMA/EVM should not be managed
> > by the LSM infrastructure.
> >
> > > Both IMA and EVM file data/metadata is persistent across boots.  If
> > > either one or the other is not enabled the file data hash or file
> > > metadata HMAC will not properly be updated, potentially preventing the
> > > system from booting when re-enabled.  Re-enabling IMA and EVM would
> > > require "fixing" the mutable file data hash and HMAC, without any
> > > knowledge of what the "fixed" values should be.  Dave Safford referred
> > > to this as "blessing" the newly calculated values.
> >
> > IMA/EVM can be easily disabled in other ways, for example
> > by moving the IMA policy or the EVM keys elsewhere.
> 
> Dynamically disabling IMA/EVM is very different than removing keys and
> preventing the system from booting.  Restoring the keys should result
> in being able to re-boot the system.  Re-enabling IMA/EVM, requires re-
> labeling the filesystem in "fix" mode, which "blesses" any changes made
> when IMA/EVM were not enabled.

Uhm, I thought that if you move the HMAC key for example
and you boot the system, you invalidate all files that change,
because the HMAC is not updated.

> > Also other LSMs rely on a dynamic and persistent state
> > (for example for file transitions in SELinux), which cannot be
> > trusted anymore if LSMs are even temporarily disabled.
> 
> Your argument is because this is a problem for SELinux, make it also a
> problem for IMA/EVM too?!   ("Two wrongs make a right")

To me it seems reasonable to give the ability to people to
disable the LSMs if they want to do so, and at the same time
to try to prevent accidental disable when the LSMs should be
enabled.

> > If IMA/EVM have to be enabled to prevent misconfiguration,
> > I think the same can be achieved if they are full LSMs, for
> > example by preventing that the list of enabled LSMs changes
> > at run-time.
> 
> That ship sailed when "security=" was deprecated in favor of "lsm="
> support, which dynamically enables/disables LSMs at runtime.

Maybe this possibility can be disabled with a new kernel option.
I will think a more concrete solution.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
