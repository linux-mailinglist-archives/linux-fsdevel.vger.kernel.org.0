Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD93E40CCC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhIOStI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhIOStI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:49:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F9DC061574;
        Wed, 15 Sep 2021 11:47:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d0700f7a2811245428a79.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:700:f7a2:8112:4542:8a79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DD591EC0257;
        Wed, 15 Sep 2021 20:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631731663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lm6vQs2/Rhr3v+Gkqez9mosqAUPoKD4IW0wHjidPrGY=;
        b=XN5RscNfsftBTFcuRzGdY1iuAMSDX6NKtwpYReOnfaZk/QSrf/8VqAHOkAjfLPxC1UO6qn
        9BHTplTlRlxpF7vtQWQch60eAekg1676yowhlJTxL/nJGxhj8z9rv3ulfK5vkpFuCcwh8v
        CPa1Q28irpOcNBFG98fwkSAbgq7mLSg=
Date:   Wed, 15 Sep 2021 20:47:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
        kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-graphics-maintainer@vmware.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
Message-ID: <YUI/yaut2f9ZoJBd@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic>
 <87lf3yk7g4.fsf@mpe.ellerman.id.au>
 <YUHGDbtiGrDz5+NS@zn.tnic>
 <f8388f18-5e90-5d0f-d681-0b17f8307dd4@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8388f18-5e90-5d0f-d681-0b17f8307dd4@csgroup.eu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 07:18:34PM +0200, Christophe Leroy wrote:
> Could you please provide more explicit explanation why inlining such an
> helper is considered as bad practice and messy ?

Tom already told you to look at the previous threads. Let's read them
together. This one, for example:

https://lore.kernel.org/lkml/YSScWvpXeVXw%2Fed5@infradead.org/

| > To take it out of line, I'm leaning towards the latter, creating a new
| > file that is built based on the ARCH_HAS_PROTECTED_GUEST setting.
| 
| Yes.  In general everytime architectures have to provide the prototype
| and not just the implementation of something we end up with a giant mess
| sooner or later.  In a few cases that is still warranted due to
| performance concerns, but i don't think that is the case here.

So I think what Christoph means here is that you want to have the
generic prototype defined in a header and arches get to implement it
exactly to the letter so that there's no mess.

As to what mess exactly, I'd let him explain that.

> Because as demonstrated in my previous response some days ago, taking that
> outline ends up with an unneccessary ugly generated code and we don't
> benefit front GCC's capability to fold in and opt out unreachable code.

And this is real fast path where a couple of instructions matter or what?

set_memory_encrypted/_decrypted doesn't look like one to me.

> I can't see your point here. Inlining the function wouldn't add any
> ifdeffery as far as I can see.

If the function is touching defines etc, they all need to be visible.
If that function needs to call other functions - which is the case on
x86, perhaps not so much on power - then you need to either ifdef around
them or provide stubs with ifdeffery in the headers. And you need to
make them global functions instead of keeping them static to the same
compilation unit, etc, etc.

With a separate compilation unit, you don't need any of that and it is
all kept in that single file.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
