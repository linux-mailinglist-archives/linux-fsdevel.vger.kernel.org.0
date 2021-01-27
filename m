Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA283305300
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 07:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhA0GPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 01:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhA0Fsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 00:48:32 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC64C061793
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 21:46:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id j21so424593pls.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 21:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pGwLX141izLDvx1hQTGiiwKO086AeFCYCtYAmNWi9wI=;
        b=AmTdH3IG4UQzJndI1D27UQJWy8ntwz3x96fLaGYHHI8DDA6H+Y68FXg1U5+ek6ovCn
         BQskNvflja4Kqe4HWtn3w42joJ9YUlN577FkgtA2wn8h4A+gee/IgXId+fkal+R9QLJn
         Na2PxVzgvj5x+O52bGPuCVBbamCyvJdweyNcbR3LECVkeySnNjL82VUJ/YR5uOBQj289
         qijz8MXoF7zeIeGbr1pzM0INdKa2u6ikLS6t9DFsADUNGVZIqVyByhitCvhByTi3r9Cb
         GFO8v3dk3dOPI8NCgIEvoLfRAsoSe8tDBOqTLpl21rRUuC+KF1FC+PjiJRruBMdfA3J+
         e4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pGwLX141izLDvx1hQTGiiwKO086AeFCYCtYAmNWi9wI=;
        b=Ab6Sx475EEmC82OHXGctfCUC7bX1b/W4iGUAGAQ3uu5mMRQcIoBH1zLTlQrzk6JcKu
         TZ23arSlLWnfuDSaUORN+8iDLVzpc7Nva33vK+TLvBmrFLrJ+zxKhM6Gyw9qfwmEOeLV
         Iyy6NpVDFYNrCkJ39ddit6B2H8vrrpgG9Pk3Y4jqVFia3roX3eNkr/ui/N+3dJDU0dca
         uUUvcyPQ6oC7Gy6MtUXfZ+SyrswN554VKoVRfHfrLGXZSoaRlEBzUxoJhyryVuidHVf4
         hMz9L6v453ulDgX6u14CIwMFQmvWUCTxUk3I/1sBn9H7axrvcX4J6imo/cpQ53tVU2S6
         RqfQ==
X-Gm-Message-State: AOAM531hnebkhNWEGCJaPK0Py2YzgCcVW5dfnh2otdPuFqETPeK3EM0f
        MhIJ75mO/pR+MBq1Hh8hOn/saw==
X-Google-Smtp-Source: ABdhPJzlYhGFSdTqcPKE8K2PIdYf+VA6n3sx73gQUwIFBNusPJfAV5LCpnY0tYvL1n4CZqElayMtXA==
X-Received: by 2002:a17:902:e8c9:b029:de:a2c7:e661 with SMTP id v9-20020a170902e8c9b02900dea2c7e661mr9611617plg.76.1611726379718;
        Tue, 26 Jan 2021 21:46:19 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 145sm840907pge.88.2021.01.26.21.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 21:46:18 -0800 (PST)
Date:   Tue, 26 Jan 2021 21:46:18 -0800 (PST)
X-Google-Original-Date: Tue, 26 Jan 2021 21:46:11 PST (-0800)
Subject:     Re: [PATCH v15 03/11] riscv/Kconfig: make direct map manipulation options depend on MMU
In-Reply-To: <20210123110041.GE6332@kernel.org>
CC:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        luto@kernel.org, Arnd Bergmann <arnd@arndb.de>, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, david@redhat.com,
        elena.reshetova@intel.com, hpa@zytor.com, mingo@redhat.com,
        jejb@linux.ibm.com, kirill@shutemov.name, willy@infradead.org,
        mark.rutland@arm.com, rppt@linux.ibm.com, mtk.manpages@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>, peterz@infradead.org,
        rick.p.edgecombe@intel.com, guro@fb.com, shakeelb@google.com,
        shuah@kernel.org, tglx@linutronix.de, tycho@tycho.ws,
        will@kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, lkp@intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rppt@kernel.org
Message-ID: <mhng-0c84abc1-8ac8-4142-be1c-a269d8b345f8@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 23 Jan 2021 03:00:41 PST (-0800), rppt@kernel.org wrote:
> On Fri, Jan 22, 2021 at 08:12:30PM -0800, Palmer Dabbelt wrote:
>> On Wed, 20 Jan 2021 10:06:04 PST (-0800), rppt@kernel.org wrote:
>> > From: Mike Rapoport <rppt@linux.ibm.com>
>> >
>> > ARCH_HAS_SET_DIRECT_MAP and ARCH_HAS_SET_MEMORY configuration options have
>> > no meaning when CONFIG_MMU is disabled and there is no point to enable them
>> > for the nommu case.
>> >
>> > Add an explicit dependency on MMU for these options.
>> >
>> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> > Reported-by: kernel test robot <lkp@intel.com>
>> > ---
>> >  arch/riscv/Kconfig | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index d82303dcc6b6..d35ce19ab1fa 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -25,8 +25,8 @@ config RISCV
>> >  	select ARCH_HAS_KCOV
>> >  	select ARCH_HAS_MMIOWB
>> >  	select ARCH_HAS_PTE_SPECIAL
>> > -	select ARCH_HAS_SET_DIRECT_MAP
>> > -	select ARCH_HAS_SET_MEMORY
>> > +	select ARCH_HAS_SET_DIRECT_MAP if MMU
>> > +	select ARCH_HAS_SET_MEMORY if MMU
>> >  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
>> >  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>> >  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>>
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> LMK if you want this to go in via the RISC-V tree, otherwise I'm going to
>> assume it's going in along with the rest of these.  FWIW I see these in other
>> architectures without the MMU guard.
>
> Except arm, they all always have MMU=y and arm selects only
> ARCH_HAS_SET_MEMORY and has empty stubs for those when MMU=n.

OK, maybe I just checked ARM, then.  I was just making sure.

> Indeed I might have been over zealous adding ARCH_HAS_SET_MEMORY dependency
> on MMU, as riscv also has these stubs, but I thought that making this
> explicit is a nice thing.

It seems reasonable to me.

Thanks!
