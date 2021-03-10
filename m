Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF733334D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 06:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhCJFUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 00:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhCJFUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:20:37 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51753C06174A;
        Tue,  9 Mar 2021 21:20:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DwL4j4Sq1z9sVt;
        Wed, 10 Mar 2021 16:20:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1615353635;
        bh=hRcUlrx6WVs6H6bysWKFjU5tqR/J0nyX9yzAP97GJsQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=J7tJEgWYlgdvVYjfzFG1g90s1EOtAnSSXBRLQ734Q2HRbgzt8b5qMsfcT75CaJw/5
         k2iXGDhutq9tOyXtkr9ZdT6+Kw3xBnr49WyYm1ThfwbSXS49oSisxLyUici9Us3TE5
         HtEU/wSHCFC/s0gViktBCnLKaTQ6q/J6g7vI7Yf82084Vpw7jSTqhvDbOhMgyxxI9w
         06Bw6yZRBta9uSCCaIQ2c7wKj4hZxuCWKQRB2mMVm8bhHalhKoBF9ueKaVIbelzwFf
         39/YMJZ9zGzrte7RuLUNxyCLzwS8ZoBCqvCyhYy1dJsJ4rr7rf2eQnVXaCuVc8iu5b
         xcUsluM3pIA9g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/6] mm: Generalize SYS_SUPPORTS_HUGETLBFS (rename as
 ARCH_SUPPORTS_HUGETLBFS)
In-Reply-To: <1615185706-24342-3-git-send-email-anshuman.khandual@arm.com>
References: <1615185706-24342-1-git-send-email-anshuman.khandual@arm.com>
 <1615185706-24342-3-git-send-email-anshuman.khandual@arm.com>
Date:   Wed, 10 Mar 2021 16:20:19 +1100
Message-ID: <874khjr3e4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Anshuman Khandual <anshuman.khandual@arm.com> writes:
> SYS_SUPPORTS_HUGETLBFS config has duplicate definitions on platforms that
> subscribe it. Instead, just make it a generic option which can be selected
> on applicable platforms. Also rename it as ARCH_SUPPORTS_HUGETLBFS instead.
> This reduces code duplication and makes it cleaner.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm/Kconfig                       | 5 +----
>  arch/arm64/Kconfig                     | 4 +---
>  arch/mips/Kconfig                      | 6 +-----
>  arch/parisc/Kconfig                    | 5 +----
>  arch/powerpc/Kconfig                   | 3 ---
>  arch/powerpc/platforms/Kconfig.cputype | 6 +++---

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
