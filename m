Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9CA414C09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhIVOdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 10:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhIVOdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:33:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FE3C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 07:31:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i25so12823493lfg.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ayCGrHt4GWDBHksaWpDlFPsTDgmCQyv1ZQQyBUlWV+I=;
        b=vKVQE5RUe8kMs0wun4XuDGO3eTujOGs2RwESdLhyIqK2JwxlqZrlSJy3MrsXJkRafX
         gBAYy/nccugQKoUll1gn8VoFbzjQhjrLzptB1R76SapyouDJT5ZGJIWbG+FX4hwJyS6V
         RHRd5aepSbIC42CmHtd5u+dR4xuEL++muo/z0NTk8BMGL92wAA2PmP9KOi2aYe71/Bfr
         QklC4Nhk0K/0QbQiJZijepS1OZ+jtAxihfchh+jQ4jf5+4U17tQ1xXPBbmD5a5nhc0Gd
         SVGSB9p7xAW0QvKqL518rFLXTD4w7KZA2wBif/Kp2RKz31Lh+5HyNQaqaSmkfOyisrNC
         k+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ayCGrHt4GWDBHksaWpDlFPsTDgmCQyv1ZQQyBUlWV+I=;
        b=hSAMwmkPYz0j1f8zi2gIW+5HQkdvEpG3qCfrb4441NDvT/u/AkGFM7Mc6oSCrGeqOp
         i4gjmDD/t3cZJqbryuj+1njbhtp6RxGxpYmgjggd9kykbktkD+teAxntOcFYEdDKl4mF
         7PMfBFmVFXyfgyK+4g4HdKAhideEVADDEo9+An3n4hQqYMVMfxxOPaMnkWTHqssalB3F
         r5Jk/QvyfNS1r3WIN18Rz3nY2cI+7fYPuwMuca3IO3CkCsof6v1FlvMoNlHg8U4iIbvk
         OuwSShq/CPsmHmCO0gRkWKYMnw8dX0dRgDdgYjf6ZuB2hWrvlj9nTv2agOSu8HRBAKRd
         1m5g==
X-Gm-Message-State: AOAM531/kol+zHYMACA13D+5Sqdpnui1wZ0BdHUhmfN8glRkU/FGJLX0
        y5BwplRc+INaHPz7xnA42TwgC79YnX4ICA==
X-Google-Smtp-Source: ABdhPJz3SPlP/oK9QpFHL+xKtQ0nQUgNyOd556PIkN1KxMSQUqIwOiDbPwtupEbWOJByEgde/ChetQ==
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr35155713ljp.199.1632321016184;
        Wed, 22 Sep 2021 07:30:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y9sm205960lfl.240.2021.09.22.07.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:30:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E147C10304D; Wed, 22 Sep 2021 17:30:15 +0300 (+03)
Date:   Wed, 22 Sep 2021 17:30:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
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
Message-ID: <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
References: <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
 <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 08:40:43AM -0500, Tom Lendacky wrote:
> On 9/21/21 4:58 PM, Kirill A. Shutemov wrote:
> > On Tue, Sep 21, 2021 at 04:43:59PM -0500, Tom Lendacky wrote:
> > > On 9/21/21 4:34 PM, Kirill A. Shutemov wrote:
> > > > On Tue, Sep 21, 2021 at 11:27:17PM +0200, Borislav Petkov wrote:
> > > > > On Wed, Sep 22, 2021 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
> > > > > > I still believe calling cc_platform_has() from __startup_64() is totally
> > > > > > broken as it lacks proper wrapping while accessing global variables.
> > > > > 
> > > > > Well, one of the issues on the AMD side was using boot_cpu_data too
> > > > > early and the Intel side uses it too. Can you replace those checks with
> > > > > is_tdx_guest() or whatever was the helper's name which would check
> > > > > whether the the kernel is running as a TDX guest, and see if that helps?
> > > > 
> > > > There's no need in Intel check this early. Only AMD need it. Maybe just
> > > > opencode them?
> > > 
> > > Any way you can put a gzipped/bzipped copy of your vmlinux file somewhere I
> > > can grab it from and take a look at it?
> > 
> > You can find broken vmlinux and bzImage here:
> > 
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdrive.google.com%2Fdrive%2Ffolders%2F1n74vUQHOGebnF70Im32qLFY8iS3wvjIs%3Fusp%3Dsharing&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7C1c7adf380cbe4c1a6bb708d97d4af6ff%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637678583935705530%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=gA30x%2Bfu97tUx0p2UqI8HgjiL8bxDbK1GqgJBbUrUE4%3D&amp;reserved=0
> > 
> > Let me know when I can remove it.
> 
> Looking at everything, it is all RIP relative addressing, so those
> accesses should be fine.

Not fine, but waiting to blowup with random build environment change.

> Your image has the intel_cc_platform_has()
> function, does it work if you remove that call? Because I think it may be
> the early call into that function which looks like it has instrumentation
> that uses %gs in __sanitizer_cov_trace_pc and %gs is not setup properly
> yet. And since boot_cpu_data.x86_vendor will likely be zero this early it
> will match X86_VENDOR_INTEL and call into that function.

Right removing call to intel_cc_platform_has() or moving it to
cc_platform.c fixes the issue.

-- 
 Kirill A. Shutemov
