Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50729413D26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhIUWAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 18:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbhIUWAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:00:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B190C061575
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 14:58:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u18so3147150lfd.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3LA4/O2mCyOef4VI1WFdoR8n1dGVVw7qzM7cBS6DVhU=;
        b=uz74/2S9fGGuaG1ODTSPcqBPXWYPIeYWZ5doyMS2bRw5AX5Q0Ua+uMdim4ZuJxyrxA
         jJZQO4P96OqxH5cKvegadiVeIhPzNJbdYGDNOj6HudiXM/SjkCNrO1WvHS6o1vufFzsX
         2aSN3AaXAf4xQbbvR+FPssTEArjutFFJ66GH7RUNHyFCNozOqySWjjTExvVocPFb39xr
         6cGXTnJkbxFWnWohqMtGSjOnjJQnu/xNRG5R8l2FsElk/Lpvl66TfQOcwUYfJ1TTZ5xS
         XHIL9Tea6doFMlP16r8MNgBnWMAMa0JaH2OsWma5jit+qxznz4qqyPPj9R612HR9czFp
         8TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3LA4/O2mCyOef4VI1WFdoR8n1dGVVw7qzM7cBS6DVhU=;
        b=ovVferYX9DWpuoJmoCGXMuij4T9VOqSHjopYzMcNytiVVkSQvQ1X4VorJSnwHquUOT
         Nv2jShfT47ES1fb8XCBRoVio7/yiFQQxp2USbW2198R7ce1xyPteYjtQOq9hq3dHarG6
         eJHRW/3KMzyry5PTGL9p/ff4z5n1xZ14bM1RfeId99Tja1gvUiCJplUL5rAcjRiPV1m2
         d1OG3pU4ZZ4OjsL0FEfJxklpOPQzR34LP9hSirE/EJTimznBd+tiHmYR8D005LU7cAHH
         zqWa7TKUaHidI6HgKV5CcJU0m37sC01HnE/FeSJH+BW/LgansWY5alg5EThqXeOe9yx0
         07qw==
X-Gm-Message-State: AOAM530oxUF20PUzR4hUPbQQSnJkk5PUGRoNTWiMylX28dPuFOOx7Rn7
        PEPrDzRY7v0QZVzRN7YiWqmX2g==
X-Google-Smtp-Source: ABdhPJwDR/A8UmkVQG/A20LQ6G5BoWJFTrnWNencwdMb7p0WPRY497q9Nuc+l8sjchxpIRdzv87pHg==
X-Received: by 2002:a2e:86ce:: with SMTP id n14mr11214294ljj.211.1632261509754;
        Tue, 21 Sep 2021 14:58:29 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q7sm16555ljg.137.2021.09.21.14.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:58:29 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5DF1710305C; Wed, 22 Sep 2021 00:58:30 +0300 (+03)
Date:   Wed, 22 Sep 2021 00:58:30 +0300
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
Message-ID: <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:43:59PM -0500, Tom Lendacky wrote:
> On 9/21/21 4:34 PM, Kirill A. Shutemov wrote:
> > On Tue, Sep 21, 2021 at 11:27:17PM +0200, Borislav Petkov wrote:
> > > On Wed, Sep 22, 2021 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
> > > > I still believe calling cc_platform_has() from __startup_64() is totally
> > > > broken as it lacks proper wrapping while accessing global variables.
> > > 
> > > Well, one of the issues on the AMD side was using boot_cpu_data too
> > > early and the Intel side uses it too. Can you replace those checks with
> > > is_tdx_guest() or whatever was the helper's name which would check
> > > whether the the kernel is running as a TDX guest, and see if that helps?
> > 
> > There's no need in Intel check this early. Only AMD need it. Maybe just
> > opencode them?
> 
> Any way you can put a gzipped/bzipped copy of your vmlinux file somewhere I
> can grab it from and take a look at it?

You can find broken vmlinux and bzImage here:

https://drive.google.com/drive/folders/1n74vUQHOGebnF70Im32qLFY8iS3wvjIs?usp=sharing

Let me know when I can remove it.

-- 
 Kirill A. Shutemov
