Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84B2B594F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 06:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKQFca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 00:32:30 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:46347 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbgKQFc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 00:32:29 -0500
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 00:32:28 EST
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ketU5-001CTB-2k; Tue, 17 Nov 2020 06:24:53 +0100
Received: from p57bd9382.dip0.t-ipconnect.de ([87.189.147.130] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ketU4-000ZYQ-Qv; Tue, 17 Nov 2020 06:24:52 +0100
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
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
References: <20201101170454.9567-1-rppt@kernel.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
Date:   Tue, 17 Nov 2020 06:24:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201101170454.9567-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.147.130
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On 11/1/20 6:04 PM, Mike Rapoport wrote:
> It's been a while since DISCONTIGMEM is generally considered deprecated,
> but it is still used by four architectures. This set replaces DISCONTIGMEM
> with a different way to handle holes in the memory map and marks
> DISCONTIGMEM configuration as BROKEN in Kconfigs of these architectures with
> the intention to completely remove it in several releases.
> 
> While for 64-bit alpha and ia64 the switch to SPARSEMEM is quite obvious
> and was a matter of moving some bits around, for smaller 32-bit arc and
> m68k SPARSEMEM is not necessarily the best thing to do.
> 
> On 32-bit machines SPARSEMEM would require large sections to make section
> index fit in the page flags, but larger sections mean that more memory is
> wasted for unused memory map.
> 
> Besides, pfn_to_page() and page_to_pfn() become less efficient, at least on
> arc.
> 
> So I've decided to generalize arm's approach for freeing of unused parts of
> the memory map with FLATMEM and enable it for both arc and m68k. The
> details are in the description of patches 10 (arc) and 13 (m68k).

Apologies for the late reply. Is this still relevant for testing?

I have already successfully tested v1 of the patch set, shall I test v2?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

