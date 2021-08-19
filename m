Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9818B3F16C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 11:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbhHSJyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 05:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSJyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:54:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15F7C061575;
        Thu, 19 Aug 2021 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=30I+7nEm5zbvXFaNjeCP/URwvn0lUxkdZ8/N2SFqU4g=; b=hdp6qYYIiawPbHWzGgJGbeGDoL
        TskujUOUgkw5fqQ32Dq09FqOv51wvLWbNrcrdw3wg7CGsAtqwE0y+rW5EzXhdMJx/nO7U+/vDSAxy
        ZGC4r6aC4wc44wp1pn/5iT/tBmcMPk/3CafPQ6Y6Tjjhb6zYRI/6S5OA4cG/Qk8BIe9OYWnnx7d8w
        7GhnTeyRi2ZmTBFWwHRyV84JdQ6eKrGvxUZFLENaT0zcmJ62SNY0OjvyFBg+eHiiFyXh1CKCQ5zLg
        4phvLD2DSvHmVFPqRiYmTfBtb2/AVqElq02npejAimvBLZXPdunESEx0AVEqb2PzRTbXPbtdOrilL
        U+nUWJXA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGejF-004tP2-Ci; Thu, 19 Aug 2021 09:53:07 +0000
Date:   Thu, 19 Aug 2021 10:52:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
Message-ID: <YR4p9TqKTLdN1A96@infradead.org>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 11:59:22AM -0500, Tom Lendacky wrote:
> While the name suggests this is intended mainly for guests, it will
> also be used for host memory encryption checks in place of sme_active().

Which suggest that the name is not good to start with.  Maybe protected
hardware, system or platform might be a better choice?

> +static inline bool prot_guest_has(unsigned int attr)
> +{
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	if (sme_me_mask)
> +		return amd_prot_guest_has(attr);
> +#endif
> +
> +	return false;
> +}

Shouldn't this be entirely out of line?

> +/* 0x800 - 0x8ff reserved for AMD */
> +#define PATTR_SME			0x800
> +#define PATTR_SEV			0x801
> +#define PATTR_SEV_ES			0x802

Why do we need reservations for a purely in-kernel namespace?

And why are you overoading a brand new generic API with weird details
of a specific implementation like this?
