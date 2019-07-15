Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEC226919C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391726AbfGOOaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 10:30:46 -0400
Received: from verein.lst.de ([213.95.11.211]:33049 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391714AbfGOOaq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:30:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C945368B05; Mon, 15 Jul 2019 16:30:39 +0200 (CEST)
Date:   Mon, 15 Jul 2019 16:30:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
Message-ID: <20190715143039.GA6892@lst.de>
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-4-bauerman@linux.ibm.com> <20190712150912.3097215e.pasic@linux.ibm.com> <87tvbqgboc.fsf@morokweng.localdomain> <20190715160317.7e3dfb33.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715160317.7e3dfb33.pasic@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 15, 2019 at 04:03:17PM +0200, Halil Pasic wrote:
> > I thought about that but couldn't put my finger on a general concept.
> > Is it "guest with memory inaccessible to the host"?
> > 
> 
> Well, force_dma_unencrypted() is a much better name thatn sev_active():
> s390 has no AMD SEV, that is sure, but for virtio to work we do need to
> make our dma accessible to the hypervisor. Yes, your "guest with memory
> inaccessible to the host" shows into the right direction IMHO.
> Unfortunately I don't have too many cycles to spend on this right now.

In x86 it means that we need to remove dma encryption using
set_memory_decrypted before using it for DMA purposes.  In the SEV
case that seems to be so that the hypervisor can access it, in the SME
case that Tom just fixes it is because there is an encrypted bit set
in the physical address, and if the device doesn't support a large
enough DMA address the direct mapping code has to encrypt the pages
used for the contigous allocation.

> Being on cc for your patch made me realize that things got broken on
> s390. Thanks! I've sent out a patch that fixes protvirt, but we are going
> to benefit from your cleanups. I think with your cleanups and that patch
> of mine both sev_active() and sme_active() can be removed. Feel free to
> do so. If not, I can attend to it as well.

Yes, I think with the dma-mapping fix and this series sme_active and
sev_active should be gone from common code.  We should also be able
to remove the exports x86 has for them.

I'll wait a few days and will then feed the dma-mapping fix to Linus,
it might make sense to either rebase Thiagos series on top of the
dma-mapping for-next branch, or wait a few days before reposting.
