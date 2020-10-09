Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98726287FAE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 02:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgJIA60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 20:58:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:23450 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgJIA6Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 20:58:25 -0400
IronPort-SDR: mNat5ftlMF+/aWBh96+2/dYhPUUD6sngEFY7KAD/UadEp78eRPxpHSN4M8HwjPhjBUGjHDTAkF
 MIKXSBnc74wQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="162789248"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="162789248"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 17:58:24 -0700
IronPort-SDR: GltQmS+4InnTbci6lMsS7uuuC/Au3gBVh1CnYduQ9e/hpEY/YA5KVKJ92y8dtUlTQcMasbgIaH
 +DhCc/+CdoIA==
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="328742638"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 17:58:24 -0700
Date:   Thu, 8 Oct 2020 17:58:23 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     yulei.kernel@gmail.com
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: Re: [PATCH 22/35] kvm, x86: Distinguish dmemfs page from mmio page
Message-ID: <20201009005823.GA11151@linux.intel.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <b2b6837785f6786575823c919788464373d3ee05.1602093760.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b6837785f6786575823c919788464373d3ee05.1602093760.git.yuleixzhang@tencent.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:54:12PM +0800, yulei.kernel@gmail.com wrote:
> From: Yulei Zhang <yuleixzhang@tencent.com>
> 
> Dmem page is pfn invalid but not mmio. Support cacheable
> dmem page for kvm.
> 
> Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
> Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 5 +++--
>  include/linux/dmem.h   | 7 +++++++
>  mm/dmem.c              | 7 +++++++
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 71aa3da2a0b7..0115c1767063 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -41,6 +41,7 @@
>  #include <linux/hash.h>
>  #include <linux/kern_levels.h>
>  #include <linux/kthread.h>
> +#include <linux/dmem.h>
>  
>  #include <asm/page.h>
>  #include <asm/memtype.h>
> @@ -2962,9 +2963,9 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
>  			 */
>  			(!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
>  
> -	return !e820__mapped_raw_any(pfn_to_hpa(pfn),
> +	return (!e820__mapped_raw_any(pfn_to_hpa(pfn),
>  				     pfn_to_hpa(pfn + 1) - 1,
> -				     E820_TYPE_RAM);
> +				     E820_TYPE_RAM)) || (!is_dmem_pfn(pfn));

This is wrong.  As is, the logic reads "A PFN is MMIO if it is INVALID &&
(!RAM || !DMEM)".  The obvious fix would be to change it to "INVALID &&
!RAM && !DMEM", but that begs the question of whether or DMEM is reported
as RAM.  I don't see any e820 related changes in the series, i.e. no evidence
that dmem yanks its memory out of the e820 tables, which makes me think this
change is unnecessary.

>  }
>  
>  /* Bits which may be returned by set_spte() */
