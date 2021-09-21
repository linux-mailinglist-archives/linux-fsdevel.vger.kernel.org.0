Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B89413C64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhIUV3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhIUV27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:28:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B90C061574;
        Tue, 21 Sep 2021 14:27:31 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d0600329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CB1E1EC0298;
        Tue, 21 Sep 2021 23:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632259645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HXcn7LT43EyI/VYeLTnH1Qd3b5wYsdaJA0//PHHSfsc=;
        b=OSIhfYe68bzttksCnMk+avj6tZ+h4tBMINOo2W8/aumfuz3RoNhLatTyBpzB6yt0AqLDnp
        +jYGIzzJLoH6YSlJ4+1KcrUtnhTc+kXLBVMf4ZSBydclwpMsNpLhjWeePqX2kcuqKDC1hy
        JXlhLsIy5paOCgT/wSp0R+OVjNLpltQ=
Date:   Tue, 21 Sep 2021 23:27:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
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
Message-ID: <YUpONYwM4dQXAOJr@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
> I still believe calling cc_platform_has() from __startup_64() is totally
> broken as it lacks proper wrapping while accessing global variables.

Well, one of the issues on the AMD side was using boot_cpu_data too
early and the Intel side uses it too. Can you replace those checks with
is_tdx_guest() or whatever was the helper's name which would check
whether the the kernel is running as a TDX guest, and see if that helps?

Thx.

-- 
Regards/Gruss,
    Boris.

