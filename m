Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23EF2CB7A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 09:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgLBIr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 03:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgLBIr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:47:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCB7C0613CF;
        Wed,  2 Dec 2020 00:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EgWbwhZanvcG3KDeapbwhWc86PAn7HkZxY3ELBxHx7c=; b=jFFK4+AenZ8fG43jB6uYB1OVZc
        U2ORttouuxGAcrpVnQ/4DgFb7rK/0XjR9MXteR2VE5qgh5UOuTWpmiF+Dt3Ie93nc64B1/PzU5U6m
        rxry57k0/IZnU8nQmFKzgLH4GfXQEXYWEXXMWqEjf0RZz3MX0cdkV1F+EI3Plew988r7LOYtU/hb3
        67fEvzDLswKqZ4dMNM6vQICEpWo7AqyiDFrzxq61UPOyZjx9A+HC5IY9XNJk3HVus//9sPZW+nCFi
        8BzyDcO4IchhjQ6h5DQTd3a3NtY48VtlxXAa/Oyq+zpXcFp07vAQK4e+S8sfjGaBNEN4SBgFh6YBm
        5JU3U6sw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkNmc-0007Mi-JA; Wed, 02 Dec 2020 08:46:42 +0000
Date:   Wed, 2 Dec 2020 08:46:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux MM <linux-mm@kvack.org>, Will Deacon <will@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>, Meelis Roos <mroos@linux.ee>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Matt Turner <mattst88@gmail.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
Message-ID: <20201202084642.GA28110@infradead.org>
References: <a7d01146-77f9-d363-af99-af3aee3789b4@physik.fu-berlin.de>
 <20201201102901.GF557259@kernel.org>
 <e3d5d791-8e4f-afcc-944c-24f66f329bd7@physik.fu-berlin.de>
 <20201201121033.GG557259@kernel.org>
 <49a2022c-f106-55ec-9390-41307a056517@physik.fu-berlin.de>
 <20201201135623.GA751215@kernel.org>
 <59351dbb-96cc-93b2-f2ec-b8968e935845@kernel.dk>
 <CAMuHMdWRc8W7U0LKyH9u1hdMuN515PCZiTEJ12FrDaCx-eTdaQ@mail.gmail.com>
 <20201202084326.GA26573@infradead.org>
 <efc13ee8-ec6c-a807-d866-99f72a94e3f5@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efc13ee8-ec6c-a807-d866-99f72a94e3f5@physik.fu-berlin.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 09:45:24AM +0100, John Paul Adrian Glaubitz wrote:
> > I've never got results.  Which is annoying, as debian doesn't ship an
> > ia64 cross toolchain either, and I can't find any pre-built one that
> > works for me.
> 
> The ia64 toolchain available from kernel.org works for me for cross-building
> a kernel that boots on my RX2600.
> 
> It's just not a fully-fledged toolchain due to the limitations with libunwind.

Actually, you are right, I did manage to finally get that working a
while ago.  I think openrisc is the one where I failed to get anything
to work at all now that I think of it.
