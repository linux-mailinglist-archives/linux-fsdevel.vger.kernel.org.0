Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFB16E31C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 11:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfGSJGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 05:06:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:40453 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfGSJGM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:06:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 02:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,281,1559545200"; 
   d="gz'50?scan'50,208,50";a="173449124"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Jul 2019 02:06:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hoOq4-000C5Z-Sa; Fri, 19 Jul 2019 17:06:04 +0800
Date:   Fri, 19 Jul 2019 17:05:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     kbuild-all@01.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH 2/3] DMA mapping: Move SME handling to x86-specific files
Message-ID: <201907191711.8BlpwBo2%lkp@intel.com>
References: <20190712053631.9814-3-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mutjwo5hrmw3257i"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190712053631.9814-3-bauerman@linux.ibm.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--mutjwo5hrmw3257i
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Thiago,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.2 next-20190718]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Thiago-Jung-Bauermann/Remove-x86-specific-code-from-generic-headers/20190715-063006
config: s390-allnoconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/dma/swiotlb.c: In function 'swiotlb_tbl_map_single':
>> kernel/dma/swiotlb.c:461:6: error: implicit declaration of function 'mem_encrypt_active'; did you mean 'set_cpu_active'? [-Werror=implicit-function-declaration]
     if (mem_encrypt_active())
         ^~~~~~~~~~~~~~~~~~
         set_cpu_active
   cc1: some warnings being treated as errors

vim +461 kernel/dma/swiotlb.c

1b548f667c1487d lib/swiotlb.c           Jeremy Fitzhardinge   2008-12-16  442  
e05ed4d1fad9e73 lib/swiotlb.c           Alexander Duyck       2012-10-15  443  phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
e05ed4d1fad9e73 lib/swiotlb.c           Alexander Duyck       2012-10-15  444  				   dma_addr_t tbl_dma_addr,
e05ed4d1fad9e73 lib/swiotlb.c           Alexander Duyck       2012-10-15  445  				   phys_addr_t orig_addr, size_t size,
0443fa003fa199f lib/swiotlb.c           Alexander Duyck       2016-11-02  446  				   enum dma_data_direction dir,
0443fa003fa199f lib/swiotlb.c           Alexander Duyck       2016-11-02  447  				   unsigned long attrs)
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  448  {
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  449  	unsigned long flags;
e05ed4d1fad9e73 lib/swiotlb.c           Alexander Duyck       2012-10-15  450  	phys_addr_t tlb_addr;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  451  	unsigned int nslots, stride, index, wrap;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  452  	int i;
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  453  	unsigned long mask;
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  454  	unsigned long offset_slots;
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  455  	unsigned long max_slots;
53b29c336830db4 kernel/dma/swiotlb.c    Dongli Zhang          2019-04-12  456  	unsigned long tmp_io_tlb_used;
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  457  
ac2cbab21f318e1 lib/swiotlb.c           Yinghai Lu            2013-01-24  458  	if (no_iotlb_memory)
ac2cbab21f318e1 lib/swiotlb.c           Yinghai Lu            2013-01-24  459  		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
ac2cbab21f318e1 lib/swiotlb.c           Yinghai Lu            2013-01-24  460  
d7b417fa08d1187 lib/swiotlb.c           Tom Lendacky          2017-10-20 @461  	if (mem_encrypt_active())
aa4d0dc3e029b79 kernel/dma/swiotlb.c    Thiago Jung Bauermann 2019-07-12  462  		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
648babb7078c631 lib/swiotlb.c           Tom Lendacky          2017-07-17  463  
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  464  	mask = dma_get_seg_boundary(hwdev);
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  465  
eb605a5754d050a lib/swiotlb.c           FUJITA Tomonori       2010-05-10  466  	tbl_dma_addr &= mask;
eb605a5754d050a lib/swiotlb.c           FUJITA Tomonori       2010-05-10  467  
eb605a5754d050a lib/swiotlb.c           FUJITA Tomonori       2010-05-10  468  	offset_slots = ALIGN(tbl_dma_addr, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
a5ddde4a558b3bd lib/swiotlb.c           Ian Campbell          2008-12-16  469  
a5ddde4a558b3bd lib/swiotlb.c           Ian Campbell          2008-12-16  470  	/*
a5ddde4a558b3bd lib/swiotlb.c           Ian Campbell          2008-12-16  471   	 * Carefully handle integer overflow which can occur when mask == ~0UL.
a5ddde4a558b3bd lib/swiotlb.c           Ian Campbell          2008-12-16  472   	 */
b15a3891c916f32 lib/swiotlb.c           Jan Beulich           2008-03-13  473  	max_slots = mask + 1
b15a3891c916f32 lib/swiotlb.c           Jan Beulich           2008-03-13  474  		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
b15a3891c916f32 lib/swiotlb.c           Jan Beulich           2008-03-13  475  		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  476  
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  477  	/*
602d9858f07c72e lib/swiotlb.c           Nikita Yushchenko     2017-01-11  478  	 * For mappings greater than or equal to a page, we limit the stride
602d9858f07c72e lib/swiotlb.c           Nikita Yushchenko     2017-01-11  479  	 * (and hence alignment) to a page size.
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  480  	 */
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  481  	nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
602d9858f07c72e lib/swiotlb.c           Nikita Yushchenko     2017-01-11  482  	if (size >= PAGE_SIZE)
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  483  		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  484  	else
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  485  		stride = 1;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  486  
34814545890db60 lib/swiotlb.c           Eric Sesterhenn       2006-03-24  487  	BUG_ON(!nslots);
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  488  
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  489  	/*
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  490  	 * Find suitable number of IO TLB entries size that will fit this
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  491  	 * request and allocate a buffer from that IO TLB pool.
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  492  	 */
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  493  	spin_lock_irqsave(&io_tlb_lock, flags);
60513ed06a41049 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  494  
60513ed06a41049 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  495  	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
60513ed06a41049 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  496  		goto not_found;
60513ed06a41049 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  497  
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  498  	index = ALIGN(io_tlb_index, stride);
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  499  	if (index >= io_tlb_nslabs)
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  500  		index = 0;
b15a3891c916f32 lib/swiotlb.c           Jan Beulich           2008-03-13  501  	wrap = index;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  502  
b15a3891c916f32 lib/swiotlb.c           Jan Beulich           2008-03-13  503  	do {
a8522509200b460 lib/swiotlb.c           FUJITA Tomonori       2008-04-29  504  		while (iommu_is_span_boundary(index, nslots, offset_slots,
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  505  					      max_slots)) {
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  506  			index += stride;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  507  			if (index >= io_tlb_nslabs)
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  508  				index = 0;
b15a3891c916f32 lib/swiotlb.c           Jan Beulich           2008-03-13  509  			if (index == wrap)
b15a3891c916f32 lib/swiotlb.c           Jan Beulich           2008-03-13  510  				goto not_found;
681cc5cd3efbeaf lib/swiotlb.c           FUJITA Tomonori       2008-02-04  511  		}
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  512  
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  513  		/*
a7133a15587b892 lib/swiotlb.c           Andrew Morton         2008-04-29  514  		 * If we find a slot that indicates we have 'nslots' number of
a7133a15587b892 lib/swiotlb.c           Andrew Morton         2008-04-29  515  		 * contiguous buffers, we allocate the buffers from that slot
a7133a15587b892 lib/swiotlb.c           Andrew Morton         2008-04-29  516  		 * and mark the entries as '0' indicating unavailable.
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  517  		 */
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  518  		if (io_tlb_list[index] >= nslots) {
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  519  			int count = 0;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  520  
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  521  			for (i = index; i < (int) (index + nslots); i++)
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  522  				io_tlb_list[i] = 0;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  523  			for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE - 1) && io_tlb_list[i]; i--)
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  524  				io_tlb_list[i] = ++count;
e05ed4d1fad9e73 lib/swiotlb.c           Alexander Duyck       2012-10-15  525  			tlb_addr = io_tlb_start + (index << IO_TLB_SHIFT);
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  526  
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  527  			/*
a7133a15587b892 lib/swiotlb.c           Andrew Morton         2008-04-29  528  			 * Update the indices to avoid searching in the next
a7133a15587b892 lib/swiotlb.c           Andrew Morton         2008-04-29  529  			 * round.
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  530  			 */
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  531  			io_tlb_index = ((index + nslots) < io_tlb_nslabs
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  532  					? (index + nslots) : 0);
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  533  
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  534  			goto found;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  535  		}
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  536  		index += stride;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  537  		if (index >= io_tlb_nslabs)
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  538  			index = 0;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  539  	} while (index != wrap);
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  540  
b15a3891c916f32 lib/swiotlb.c           Jan Beulich           2008-03-13  541  not_found:
53b29c336830db4 kernel/dma/swiotlb.c    Dongli Zhang          2019-04-12  542  	tmp_io_tlb_used = io_tlb_used;
53b29c336830db4 kernel/dma/swiotlb.c    Dongli Zhang          2019-04-12  543  
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  544  	spin_unlock_irqrestore(&io_tlb_lock, flags);
d0bc0c2a31c9500 lib/swiotlb.c           Christian König       2018-01-04  545  	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
53b29c336830db4 kernel/dma/swiotlb.c    Dongli Zhang          2019-04-12  546  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
53b29c336830db4 kernel/dma/swiotlb.c    Dongli Zhang          2019-04-12  547  			 size, io_tlb_nslabs, tmp_io_tlb_used);
b907e20508d0246 kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  548  	return DMA_MAPPING_ERROR;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  549  found:
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  550  	io_tlb_used += nslots;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  551  	spin_unlock_irqrestore(&io_tlb_lock, flags);
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  552  
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  553  	/*
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  554  	 * Save away the mapping from the original address to the DMA address.
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  555  	 * This is needed when we sync the memory.  Then we sync the buffer if
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  556  	 * needed.
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  557  	 */
bc40ac66988a772 lib/swiotlb.c           Becky Bruce           2008-12-22  558  	for (i = 0; i < nslots; i++)
e05ed4d1fad9e73 lib/swiotlb.c           Alexander Duyck       2012-10-15  559  		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
0443fa003fa199f lib/swiotlb.c           Alexander Duyck       2016-11-02  560  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
0443fa003fa199f lib/swiotlb.c           Alexander Duyck       2016-11-02  561  	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
af51a9f1848ff50 lib/swiotlb.c           Alexander Duyck       2012-10-15  562  		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  563  
e05ed4d1fad9e73 lib/swiotlb.c           Alexander Duyck       2012-10-15  564  	return tlb_addr;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  565  }
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  566  
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  567  /*
d0c8ba40c6cc0fe lib/swiotlb.c           Yisheng Xie           2018-05-07  568   * tlb_addr is the physical address of the bounce buffer to unmap.
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  569   */
61ca08c3220032d lib/swiotlb.c           Alexander Duyck       2012-10-15  570  void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
0443fa003fa199f lib/swiotlb.c           Alexander Duyck       2016-11-02  571  			      size_t size, enum dma_data_direction dir,
0443fa003fa199f lib/swiotlb.c           Alexander Duyck       2016-11-02  572  			      unsigned long attrs)
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  573  {
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  574  	unsigned long flags;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  575  	int i, count, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
61ca08c3220032d lib/swiotlb.c           Alexander Duyck       2012-10-15  576  	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
61ca08c3220032d lib/swiotlb.c           Alexander Duyck       2012-10-15  577  	phys_addr_t orig_addr = io_tlb_orig_addr[index];
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  578  
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  579  	/*
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  580  	 * First, sync the memory before unmapping the entry
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  581  	 */
8e0629c1d4ce86c lib/swiotlb.c           Jan Beulich           2014-06-02  582  	if (orig_addr != INVALID_PHYS_ADDR &&
0443fa003fa199f lib/swiotlb.c           Alexander Duyck       2016-11-02  583  	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
8e0629c1d4ce86c lib/swiotlb.c           Jan Beulich           2014-06-02  584  	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
af51a9f1848ff50 lib/swiotlb.c           Alexander Duyck       2012-10-15  585  		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_FROM_DEVICE);
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  586  
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  587  	/*
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  588  	 * Return the buffer to the free list by setting the corresponding
af901ca181d92aa lib/swiotlb.c           André Goddard Rosa    2009-11-14  589  	 * entries to indicate the number of contiguous entries available.
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  590  	 * While returning the entries to the free list, we merge the entries
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  591  	 * with slots below and above the pool being returned.
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  592  	 */
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  593  	spin_lock_irqsave(&io_tlb_lock, flags);
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  594  	{
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  595  		count = ((index + nslots) < ALIGN(index + 1, IO_TLB_SEGSIZE) ?
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  596  			 io_tlb_list[index + nslots] : 0);
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  597  		/*
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  598  		 * Step 1: return the slots to the free list, merging the
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  599  		 * slots with superceeding slots
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  600  		 */
8e0629c1d4ce86c lib/swiotlb.c           Jan Beulich           2014-06-02  601  		for (i = index + nslots - 1; i >= index; i--) {
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  602  			io_tlb_list[i] = ++count;
8e0629c1d4ce86c lib/swiotlb.c           Jan Beulich           2014-06-02  603  			io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
8e0629c1d4ce86c lib/swiotlb.c           Jan Beulich           2014-06-02  604  		}
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  605  		/*
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  606  		 * Step 2: merge the returned slots with the preceding slots,
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  607  		 * if available (non zero)
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  608  		 */
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  609  		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  610  			io_tlb_list[i] = ++count;
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  611  
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  612  		io_tlb_used -= nslots;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  613  	}
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  614  	spin_unlock_irqrestore(&io_tlb_lock, flags);
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  615  }
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  616  
fbfda893eb570bb lib/swiotlb.c           Alexander Duyck       2012-10-15  617  void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
fbfda893eb570bb lib/swiotlb.c           Alexander Duyck       2012-10-15  618  			     size_t size, enum dma_data_direction dir,
d7ef1533a90f432 lib/swiotlb.c           Konrad Rzeszutek Wilk 2010-05-28  619  			     enum dma_sync_target target)
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  620  {
fbfda893eb570bb lib/swiotlb.c           Alexander Duyck       2012-10-15  621  	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
fbfda893eb570bb lib/swiotlb.c           Alexander Duyck       2012-10-15  622  	phys_addr_t orig_addr = io_tlb_orig_addr[index];
bc40ac66988a772 lib/swiotlb.c           Becky Bruce           2008-12-22  623  
8e0629c1d4ce86c lib/swiotlb.c           Jan Beulich           2014-06-02  624  	if (orig_addr == INVALID_PHYS_ADDR)
8e0629c1d4ce86c lib/swiotlb.c           Jan Beulich           2014-06-02  625  		return;
fbfda893eb570bb lib/swiotlb.c           Alexander Duyck       2012-10-15  626  	orig_addr += (unsigned long)tlb_addr & ((1 << IO_TLB_SHIFT) - 1);
df336d1c7b6fd51 lib/swiotlb.c           Keir Fraser           2007-07-21  627  
de69e0f0b38a467 lib/swiotlb.c           John W. Linville      2005-09-29  628  	switch (target) {
de69e0f0b38a467 lib/swiotlb.c           John W. Linville      2005-09-29  629  	case SYNC_FOR_CPU:
de69e0f0b38a467 lib/swiotlb.c           John W. Linville      2005-09-29  630  		if (likely(dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
af51a9f1848ff50 lib/swiotlb.c           Alexander Duyck       2012-10-15  631  			swiotlb_bounce(orig_addr, tlb_addr,
fbfda893eb570bb lib/swiotlb.c           Alexander Duyck       2012-10-15  632  				       size, DMA_FROM_DEVICE);
34814545890db60 lib/swiotlb.c           Eric Sesterhenn       2006-03-24  633  		else
34814545890db60 lib/swiotlb.c           Eric Sesterhenn       2006-03-24  634  			BUG_ON(dir != DMA_TO_DEVICE);
de69e0f0b38a467 lib/swiotlb.c           John W. Linville      2005-09-29  635  		break;
de69e0f0b38a467 lib/swiotlb.c           John W. Linville      2005-09-29  636  	case SYNC_FOR_DEVICE:
de69e0f0b38a467 lib/swiotlb.c           John W. Linville      2005-09-29  637  		if (likely(dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
af51a9f1848ff50 lib/swiotlb.c           Alexander Duyck       2012-10-15  638  			swiotlb_bounce(orig_addr, tlb_addr,
fbfda893eb570bb lib/swiotlb.c           Alexander Duyck       2012-10-15  639  				       size, DMA_TO_DEVICE);
34814545890db60 lib/swiotlb.c           Eric Sesterhenn       2006-03-24  640  		else
34814545890db60 lib/swiotlb.c           Eric Sesterhenn       2006-03-24  641  			BUG_ON(dir != DMA_FROM_DEVICE);
de69e0f0b38a467 lib/swiotlb.c           John W. Linville      2005-09-29  642  		break;
de69e0f0b38a467 lib/swiotlb.c           John W. Linville      2005-09-29  643  	default:
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  644  		BUG();
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  645  	}
de69e0f0b38a467 lib/swiotlb.c           John W. Linville      2005-09-29  646  }
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  647  
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  648  /*
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  649   * Create a swiotlb mapping for the buffer at @phys, and in case of DMAing
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  650   * to the device copy the data into it as well.
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  651   */
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  652  bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  653  		size_t size, enum dma_data_direction dir, unsigned long attrs)
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  654  {
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  655  	trace_swiotlb_bounced(dev, *dma_addr, size, swiotlb_force);
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  656  
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  657  	if (unlikely(swiotlb_force == SWIOTLB_NO_FORCE)) {
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  658  		dev_warn_ratelimited(dev,
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  659  			"Cannot do DMA to address %pa\n", phys);
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  660  		return false;
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  661  	}
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  662  
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  663  	/* Oh well, have to allocate and map a bounce buffer. */
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  664  	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  665  			*phys, size, dir, attrs);
b907e20508d0246 kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  666  	if (*phys == DMA_MAPPING_ERROR)
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  667  		return false;
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  668  
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  669  	/* Ensure that the address returned is DMA'ble */
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  670  	*dma_addr = __phys_to_dma(dev, *phys);
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  671  	if (unlikely(!dma_capable(dev, *dma_addr, size))) {
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  672  		swiotlb_tbl_unmap_single(dev, *phys, size, dir,
c4dae366925f929 kernel/dma/swiotlb.c    Christoph Hellwig     2018-08-20  673  			attrs | DMA_ATTR_SKIP_CPU_SYNC);
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  674  		return false;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  675  	}
309df0c503c35fb lib/swiotlb.c           Arthur Kepner         2008-04-29  676  
55897af63091ebc kernel/dma/swiotlb.c    Christoph Hellwig     2018-12-03  677  	return true;
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  678  }
^1da177e4c3f415 arch/ia64/lib/swiotlb.c Linus Torvalds        2005-04-16  679  
abe420bfae528c9 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  680  size_t swiotlb_max_mapping_size(struct device *dev)
abe420bfae528c9 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  681  {
abe420bfae528c9 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  682  	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
abe420bfae528c9 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  683  }
492366f7b423725 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  684  
492366f7b423725 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  685  bool is_swiotlb_active(void)
492366f7b423725 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  686  {
492366f7b423725 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  687  	/*
492366f7b423725 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  688  	 * When SWIOTLB is initialized, even if io_tlb_start points to physical
492366f7b423725 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  689  	 * address zero, io_tlb_end surely doesn't.
492366f7b423725 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  690  	 */
492366f7b423725 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  691  	return io_tlb_end != 0;
492366f7b423725 kernel/dma/swiotlb.c    Joerg Roedel          2019-02-07  692  }
45ba8d5d061b134 kernel/dma/swiotlb.c    Linus Torvalds        2019-03-10  693  
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  694  #ifdef CONFIG_DEBUG_FS
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  695  
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  696  static int __init swiotlb_create_debugfs(void)
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  697  {
1be51474f99bcfd kernel/dma/swiotlb.c    Greg Kroah-Hartman    2019-06-12  698  	struct dentry *root;
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  699  
1be51474f99bcfd kernel/dma/swiotlb.c    Greg Kroah-Hartman    2019-06-12  700  	root = debugfs_create_dir("swiotlb", NULL);
1be51474f99bcfd kernel/dma/swiotlb.c    Greg Kroah-Hartman    2019-06-12  701  	debugfs_create_ulong("io_tlb_nslabs", 0400, root, &io_tlb_nslabs);
1be51474f99bcfd kernel/dma/swiotlb.c    Greg Kroah-Hartman    2019-06-12  702  	debugfs_create_ulong("io_tlb_used", 0400, root, &io_tlb_used);
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  703  	return 0;
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  704  }
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  705  
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  706  late_initcall(swiotlb_create_debugfs);
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  707  
71602fe6d4e9291 kernel/dma/swiotlb.c    Dongli Zhang          2019-01-18  708  #endif

:::::: The code at line 461 was first introduced by commit
:::::: d7b417fa08d1187923c270bc33a3555c2fcff8b9 x86/mm: Add DMA support for SEV memory encryption

:::::: TO: Tom Lendacky <thomas.lendacky@amd.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mutjwo5hrmw3257i
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
yCwe68SI/we8+VugylcAAA==

--mutjwo5hrmw3257i--
