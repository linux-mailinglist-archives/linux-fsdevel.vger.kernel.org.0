Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78CB2B59B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 07:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgKQGX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 01:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgKQGX1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 01:23:27 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DA1C223AB;
        Tue, 17 Nov 2020 06:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605594206;
        bh=i6knV0DMO2RXQJYhiZxatZGtoKHulkxOl5sSaGDS0gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qAUA5RVCTP0npaeRBIO8YpdBuUTgIPD0QBwHOr2UeiElqlVtKRczsIc13jS9qXhSM
         /m8cTkIY+QMvxEbuFwI36fTIAAvpIJ9fhQtB5SdUWJTnAGZetOklMyr9EQ9DA4BJIQ
         QteWhvERMCEW1EUrOIOHXVbp4uevZfdG2TI7hGQ8=
Date:   Tue, 17 Nov 2020 08:23:16 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
Message-ID: <20201117062316.GB370813@kernel.org>
References: <20201101170454.9567-1-rppt@kernel.org>
 <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Adrian,

On Tue, Nov 17, 2020 at 06:24:51AM +0100, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 11/1/20 6:04 PM, Mike Rapoport wrote:
> > It's been a while since DISCONTIGMEM is generally considered deprecated,
> > but it is still used by four architectures. This set replaces DISCONTIGMEM
> > with a different way to handle holes in the memory map and marks
> > DISCONTIGMEM configuration as BROKEN in Kconfigs of these architectures with
> > the intention to completely remove it in several releases.
> > 
> > While for 64-bit alpha and ia64 the switch to SPARSEMEM is quite obvious
> > and was a matter of moving some bits around, for smaller 32-bit arc and
> > m68k SPARSEMEM is not necessarily the best thing to do.
> > 
> > On 32-bit machines SPARSEMEM would require large sections to make section
> > index fit in the page flags, but larger sections mean that more memory is
> > wasted for unused memory map.
> > 
> > Besides, pfn_to_page() and page_to_pfn() become less efficient, at least on
> > arc.
> > 
> > So I've decided to generalize arm's approach for freeing of unused parts of
> > the memory map with FLATMEM and enable it for both arc and m68k. The
> > details are in the description of patches 10 (arc) and 13 (m68k).
> 
> Apologies for the late reply. Is this still relevant for testing?
> 
> I have already successfully tested v1 of the patch set, shall I test v2?

There were minor differences only for m68k between the versions. I've
verified them on ARAnyM but if you have a real machine a run there would
be nice.

> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> 
> 

-- 
Sincerely yours,
Mike.
