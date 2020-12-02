Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA972CB78C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 09:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbgLBIoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 03:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbgLBIoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:44:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C60C0613CF;
        Wed,  2 Dec 2020 00:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qmSLHouQM2P7C/nzGPHzgkRWhU9yyeNULaubi1YcUK4=; b=BDv/pPxbI6MKX2RB0o+RosxH0Y
        4OaXrTqdUhMYwcCaQ3Oc2jGg8ST3NrG/2c3N09dEs9RN6NEK4BelKnhNkjCIDt/b9dxc7ZIWueQJp
        dkSQ6lhbVrH628gjNhgTrUVZvl39O8uWHe1G8tlF0KVfeMFKgmwfFiNKseD6gQFVPvZ/BSbPZATth
        qu5vTEo5K7GZg4COBcUFaM+ThCFigi+BTR6w34SAnNX4eVixI+Wn0YhV24dP7dYZCURiDJv80Sr6S
        waZY6NUGQOKnuB3nF9ALZWqw2cr6LwOW4NbQ+C0bP4qP5XC0ftkvYJQG/Bkd9adYDQ73zgA/qjOYQ
        M/CLTQfw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkNjS-00076w-H8; Wed, 02 Dec 2020 08:43:26 +0000
Date:   Wed, 2 Dec 2020 08:43:26 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
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
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
Message-ID: <20201202084326.GA26573@infradead.org>
References: <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
 <20201117062316.GB370813@kernel.org>
 <a7d01146-77f9-d363-af99-af3aee3789b4@physik.fu-berlin.de>
 <20201201102901.GF557259@kernel.org>
 <e3d5d791-8e4f-afcc-944c-24f66f329bd7@physik.fu-berlin.de>
 <20201201121033.GG557259@kernel.org>
 <49a2022c-f106-55ec-9390-41307a056517@physik.fu-berlin.de>
 <20201201135623.GA751215@kernel.org>
 <59351dbb-96cc-93b2-f2ec-b8968e935845@kernel.dk>
 <CAMuHMdWRc8W7U0LKyH9u1hdMuN515PCZiTEJ12FrDaCx-eTdaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWRc8W7U0LKyH9u1hdMuN515PCZiTEJ12FrDaCx-eTdaQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 04:33:01PM +0100, Geert Uytterhoeven wrote:
> > That's a lot of typos in that patch... I wonder why the buildbot hasn't
> > complained about this. Thanks for fixing this up! I'm going to fold this
> > into the original to avoid the breakage.
> 
> Does lkp@intel.com do ia64 builds? Yes, it builds zx1_defconfig.

I've never got results.  Which is annoying, as debian doesn't ship an
ia64 cross toolchain either, and I can't find any pre-built one that
works for me.
