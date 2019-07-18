Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338FD6CB24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 10:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfGRIoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 04:44:18 -0400
Received: from verein.lst.de ([213.95.11.211]:57873 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfGRIoS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:44:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D492968B05; Thu, 18 Jul 2019 10:44:16 +0200 (CEST)
Date:   Thu, 18 Jul 2019 10:44:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v3 5/6] fs/core/vmcore: Move sev_active() reference to
 x86 arch code
Message-ID: <20190718084416.GD24562@lst.de>
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <20190718032858.28744-6-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718032858.28744-6-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:28:57AM -0300, Thiago Jung Bauermann wrote:
> Secure Encrypted Virtualization is an x86-specific feature, so it shouldn't
> appear in generic kernel code because it forces non-x86 architectures to
> define the sev_active() function, which doesn't make a lot of sense.
> 
> To solve this problem, add an x86 elfcorehdr_read() function to override
> the generic weak implementation. To do that, it's necessary to make
> read_from_oldmem() public so that it can be used outside of vmcore.c.
> 
> Also, remove the export for sev_active() since it's only used in files that
> won't be built as modules.

I have to say I find the __weak overrides of the vmcore files very
confusing and which we'd have a better scheme there.  But as this fits
into that scheme and allows to remove the AMD SME vs SEV knowledge from
the core I'm fine with it.

Reviewed-by: Christoph Hellwig <hch@lst.de>
