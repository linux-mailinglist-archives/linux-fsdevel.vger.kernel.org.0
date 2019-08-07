Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9E85682
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 01:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbfHGXee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 19:34:34 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4202 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbfHGXed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:34:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4b600a0000>; Wed, 07 Aug 2019 16:34:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 07 Aug 2019 16:34:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 07 Aug 2019 16:34:33 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Aug
 2019 23:34:32 +0000
Subject: Re: [PATCH] powerpc: convert put_page() to put_user_page*()
To:     kbuild test robot <lkp@intel.com>, <john.hubbard@gmail.com>
CC:     <kbuild-all@01.org>, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>
References: <20190805023819.11001-1-jhubbard@nvidia.com>
 <201908080609.5QdIClpX%lkp@intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <eb413c9f-0328-271e-7599-a1c073504f1d@nvidia.com>
Date:   Wed, 7 Aug 2019 16:34:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201908080609.5QdIClpX%lkp@intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565220874; bh=aoh0mQBWSJjDZTkXsDLT7mSUCXnBIfsGxB12+qPVeX8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=p41wr3D4+Y3n+Nm4ltunCU+D7vT5RXCg2yQ3Ba4WjuwRYBmZMjB+3Gub9GxPXVRU1
         Zz9g/A5cFijCEOU7FRRcvhjF9VtLkqhmME/dEtR6fojjDyewaejxWsN54PGUGb+7nH
         PdBWMc7o17ax0XC6D919YztkTPHTFLaKlvxr7ywRn2lyklERKBAwjcf12v0YU0EQSl
         lOJm0Ih5EzqXqFr898tFVex/aGijitShEirMpg98XcSa5ANL2gw4wLaku9G4yg81PF
         sUrhvTND8GCKzKYrE0pwBNgPaDyKMhmuzL18iiIYlTk0Oa8b//QA9vndZp6rHC2FlZ
         3042+uGmLkG6w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/7/19 4:24 PM, kbuild test robot wrote:
> Hi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc3 next-20190807]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/john-hubbard-gmail-com/powerpc-convert-put_page-to-put_user_page/20190805-132131
> config: powerpc-allmodconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=powerpc 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kvm/book3s_64_mmu_radix.c: In function 'kvmppc_book3s_instantiate_page':
>>> arch/powerpc/kvm/book3s_64_mmu_radix.c:879:4: error: too many arguments to function 'put_user_pages_dirty_lock'
>        put_user_pages_dirty_lock(&page, 1, dirty);
>        ^~~~~~~~~~~~~~~~~~~~~~~~~

Yep, I should have included the prerequisite patch. But this is obsolete now,
please refer to the larger patchset instead:

   https://lore.kernel.org/r/20190807013340.9706-1-jhubbard@nvidia.com

thanks,
-- 
John Hubbard
NVIDIA
