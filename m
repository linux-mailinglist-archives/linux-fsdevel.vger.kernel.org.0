Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0512416F8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245387AbhIXJxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 05:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245320AbhIXJxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:53:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCADC061574;
        Fri, 24 Sep 2021 02:51:51 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0dd600d43e805889b23e24.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d600:d43e:8058:89b2:3e24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC4151EC0301;
        Fri, 24 Sep 2021 11:51:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632477106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=chSLn6PIxzKxo322BTSR3wKHxsK14lHDAqUJBVwt9Eo=;
        b=CfbAAofZ6R9ns5NFPki+7QaitPLpejuXdZJnxlWVBsvBowrNUxHEqrUKe2Y/BdplMet7fD
        Nq3F50WTgrfr42U+7z5YTTrv+pRjCylIw87rlK6B7Va1B8V8LlSqHAb6L8QXwsedXXkhcz
        4vGmH2JazfBltplsu+R4klbu0kJ61KI=
Date:   Fri, 24 Sep 2021 11:51:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
Message-ID: <YU2fsCblZVQpgMvC@zn.tnic>
References: <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
 <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
 <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
 <YUuJZ2qOgbdpfk6N@zn.tnic>
 <20210922210558.itofvu3725dap5xx@box.shutemov.name>
 <YUzFj+yH79XRc3F3@zn.tnic>
 <20210924094132.gxyqp4z3qdk5w4j6@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210924094132.gxyqp4z3qdk5w4j6@box.shutemov.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 12:41:32PM +0300, Kirill A. Shutemov wrote:
> On Thu, Sep 23, 2021 at 08:21:03PM +0200, Borislav Petkov wrote:
> > On Thu, Sep 23, 2021 at 12:05:58AM +0300, Kirill A. Shutemov wrote:
> > > Unless we find other way to guarantee RIP-relative access, we must use
> > > fixup_pointer() to access any global variables.
> > 
> > Yah, I've asked compiler folks about any guarantees we have wrt
> > rip-relative addresses but it doesn't look good. Worst case, we'd have
> > to do the fixup_pointer() thing.
> > 
> > In the meantime, Tom and I did some more poking at this and here's a
> > diff ontop.
> > 
> > The direction being that we'll stick both the AMD and Intel
> > *cc_platform_has() call into cc_platform.c for which instrumentation
> > will be disabled so no issues with that.
> > 
> > And that will keep all that querying all together in a single file.
> 
> And still do cc_platform_has() calls in __startup_64() codepath?
> 
> It's broken.
> 
> Intel detection in cc_platform_has() relies on boot_cpu_data.x86_vendor
> which is not initialized until early_cpu_init() in setup_arch(). Given
> that X86_VENDOR_INTEL is 0 it leads to false-positive.

Yeah, Tom, I had the same question yesterday.

/me looks in his direction.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
