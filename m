Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316F0413C85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 23:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhIUVfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhIUVfb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:35:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC2C06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 14:34:02 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i25so3112393lfg.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=onYH57UKgRX2y9FA652B6Jil/Y6sRo6kbtM4byaxFbk=;
        b=eBVF3W3VBl8/Kcc3edgbmiaMz5aGtiFcsghvZhSejZhbmeEyK5UQw/1PFkiQyXYHaG
         ep1Qe79XGKoddakjbluJzSSdU6e7ItIa/VyOBVU9ai0Bymzz3iDJtyFjRD39EIPM25vz
         4qz0qSZamNXJd68fq5IJpTDDpau43+mSfg2XWhoKoGxbOFiuRtiRYE7GfxGmSUDaHEJg
         E7kAQREHoi4We6KjgT1K6PZUTHBzzEa/WGaKq/wElm+NwA9Dj3BI08sAZJBTPlkJn2D7
         eFgy10WdV1zv/1WS3CBekNlpT18oJkYC++DPHzSZnogr5FAXrL71q6vwYz/oJyJkBY1z
         HMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=onYH57UKgRX2y9FA652B6Jil/Y6sRo6kbtM4byaxFbk=;
        b=OnHHBpw4/8JCH378yzEMOulD0MXdunsVUsUbVEJy0HI8mzWusTl8rIEWJiBaxovj8w
         zrywTw/VIiwHWHMTHZyuAUqsDg1tkdTYHb8iuv2B5IxhfpEoZAna+Zol+nvN2xh7jfp4
         j1TG2OAah1w2LnskBGB0wgBvhSl3Xtz/w248JX9WPp+0unx3bv8HxnbodiC/fXI1IxiF
         eKs6TPbQHierUnQ09MSMNFxz2MIXlICv9N7GLSR9x072bz68my9VozAHSsgHll1xN2oE
         nbTWl+lQ5y51IsYcAmEuuWOqFZIfQrtdwlXc18cqz7WuKvO/9/Scn1t5YsM+yVy0wWMN
         XzZw==
X-Gm-Message-State: AOAM532ujGwM8miZNLpeP0tICitRzRB8nexdPPwJ4hzqNMlEaaD6p52D
        e/O64qhgWfD5wGQYVJJdUCKwyA==
X-Google-Smtp-Source: ABdhPJwdW58yGabAJZgobn6vaDrfqJrmQRLjEbi4LByZcJNYEBlALvg49HirVUieAeO4lwAN455DSA==
X-Received: by 2002:a05:6512:3096:: with SMTP id z22mr19350411lfd.167.1632260040535;
        Tue, 21 Sep 2021 14:34:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t14sm16618lfp.15.2021.09.21.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:34:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3890410305C; Wed, 22 Sep 2021 00:34:01 +0300 (+03)
Date:   Wed, 22 Sep 2021 00:34:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUpONYwM4dQXAOJr@zn.tnic>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:27:17PM +0200, Borislav Petkov wrote:
> On Wed, Sep 22, 2021 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
> > I still believe calling cc_platform_has() from __startup_64() is totally
> > broken as it lacks proper wrapping while accessing global variables.
> 
> Well, one of the issues on the AMD side was using boot_cpu_data too
> early and the Intel side uses it too. Can you replace those checks with
> is_tdx_guest() or whatever was the helper's name which would check
> whether the the kernel is running as a TDX guest, and see if that helps?

There's no need in Intel check this early. Only AMD need it. Maybe just
opencode them?

-- 
 Kirill A. Shutemov
