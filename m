Return-Path: <linux-fsdevel+bounces-42112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C9CA3C70A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 19:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8CF3AABB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C616214A6A;
	Wed, 19 Feb 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LTG+FjzA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787812147E8;
	Wed, 19 Feb 2025 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988569; cv=none; b=MCY/SdI/47UNEFXiycESsSIacxKO4VjwIGjF42JvG5Uwfj4yvoTg4p/8m4LIjbeJ5KJkg873+WOZ6/7RoM41giPtorc9zoTeEP21OwlAAAgbIGUkyV3ClfKSR2ZrJPu0x/zXgNBYMyKuM0BZuTUyM5naN6C/e3/K+M37P++5V34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988569; c=relaxed/simple;
	bh=89pN2lzpnqx4pWKh5CtnkftsUiCXfM/YS4po5Dm9sWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQU8+XjZgPha3R01o/VSKaL1HGD+lZhgWBhWkp96kJJKlZvJaKS6igzluVVhw6nIe8S7pAUQT5dU8GB9Kc5eVn6VscgxImjh8jf5aV/Mh/iznGzjZbIUUER7SUgmviHjZMPsb8rf9W1Kia2MQ6fu1GCrJyoL/4ghVTAqff0sgms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LTG+FjzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE1AC4CED1;
	Wed, 19 Feb 2025 18:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739988569;
	bh=89pN2lzpnqx4pWKh5CtnkftsUiCXfM/YS4po5Dm9sWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTG+FjzABQ7n7DrisxPtoZmA2zEvi4uzF9hzOHHpMb5sB6eWt5cCLd8cAhHAzbPe6
	 EYcNhRG2vo3DAhoUmQtN7iN8JrDv9YWu1AM8OPan6/tSHDfSZ2iIqHyxJDXow5aU8K
	 a9XJsPDHtMBPOu16IiImWiw7pN+dh4YezumkgO+w=
Date: Wed, 19 Feb 2025 19:09:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>, willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
Message-ID: <2025021959-koala-flypaper-1ad5@gregkh>
References: <20250206155234.095034647@linuxfoundation.org>
 <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
 <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com>
 <Z7Xj-zIe-Sa1syG7@arm.com>
 <Z7YSYArXkRFEy6FO@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7YSYArXkRFEy6FO@arm.com>

On Wed, Feb 19, 2025 at 05:18:24PM +0000, Catalin Marinas wrote:
> On Wed, Feb 19, 2025 at 02:00:27PM +0000, Catalin Marinas wrote:
> > > On Sat, 8 Feb 2025 at 16:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > Regression on qemu-arm64 and FVP noticed this kernel warning running
> > > > selftests: arm64: check_hugetlb_options test case on 6.6.76-rc1 and
> > > > 6.6.76-rc2.
> > > >
> > > > Test regression: WARNING-arch-arm64-mm-copypage-copy_highpage
> > > >
> > > > ------------[ cut here ]------------
> > > > [   96.920028] WARNING: CPU: 1 PID: 3611 at
> > > > arch/arm64/mm/copypage.c:29 copy_highpage
> > > > (arch/arm64/include/asm/mte.h:87)
> > > > [   96.922100] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
> > > > sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
> > > > [   96.925603] CPU: 1 PID: 3611 Comm: check_hugetlb_o Not tainted 6.6.76-rc2 #1
> > > > [   96.926956] Hardware name: linux,dummy-virt (DT)
> > > > [   96.927695] pstate: 43402009 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> > > > [   96.928687] pc : copy_highpage (arch/arm64/include/asm/mte.h:87)
> > > > [   96.929037] lr : copy_highpage
> > > > (arch/arm64/include/asm/alternative-macros.h:232
> > > > arch/arm64/include/asm/cpufeature.h:443
> > > > arch/arm64/include/asm/cpufeature.h:504
> > > > arch/arm64/include/asm/cpufeature.h:814 arch/arm64/mm/copypage.c:27)
> > > > [   96.929399] sp : ffff800088aa3ab0
> > > > [   96.930232] x29: ffff800088aa3ab0 x28: 00000000000001ff x27: 0000000000000000
> > > > [   96.930784] x26: 0000000000000000 x25: 0000ffff9b800000 x24: 0000ffff9b9ff000
> > > > [   96.931402] x23: fffffc0003257fc0 x22: ffff0000c95ff000 x21: ffff0000c93ff000
> > > > [   96.932054] x20: fffffc0003257fc0 x19: fffffc000324ffc0 x18: 0000ffff9b800000
> > > > [   96.933357] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > > > [   96.934091] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > > > [   96.935095] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> > > > [   96.935982] x8 : 0bfffc0001800000 x7 : 0000000000000000 x6 : 0000000000000000
> > > > [   96.936536] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > > > [   96.937089] x2 : 0000000000000000 x1 : ffff0000c9600000 x0 : ffff0000c9400080
> > > > [   96.939431] Call trace:
> > > > [   96.939920] copy_highpage (arch/arm64/include/asm/mte.h:87)
> > > > [   96.940443] copy_user_highpage (arch/arm64/mm/copypage.c:40)
> > > > [   96.940963] copy_user_large_folio (mm/memory.c:5977 mm/memory.c:6109)
> > > > [   96.941535] hugetlb_wp (mm/hugetlb.c:5701)
> > > > [   96.941948] hugetlb_fault (mm/hugetlb.c:6237)
> > > > [   96.942344] handle_mm_fault (mm/memory.c:5330)
> > > > [   96.942794] do_page_fault (arch/arm64/mm/fault.c:513
> > > > arch/arm64/mm/fault.c:626)
> > > > [   96.943341] do_mem_abort (arch/arm64/mm/fault.c:846)
> > > > [   96.943797] el0_da (arch/arm64/kernel/entry-common.c:133
> > > > arch/arm64/kernel/entry-common.c:144
> > > > arch/arm64/kernel/entry-common.c:547)
> > > > [   96.944229] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
> > > > [   96.944765] el0t_64_sync (arch/arm64/kernel/entry.S:599)
> > > > [   96.945383] ---[ end trace 0000000000000000 ]---
> > 
> > Prior to commit 25c17c4b55de ("hugetlb: arm64: add mte support"), there
> > was no hugetlb support with MTE, so the above code path should not
> > happen - it seems to get a PROT_MTE hugetlb page which should have been
> > prevented by arch_validate_flags(). Or something else corrupts the page
> > flags and we end up with some random PG_mte_tagged set.
> 
> The problem is in the arm64 arch_calc_vm_flag_bits() as it returns
> VM_MTE_ALLOWED for any MAP_ANONYMOUS ignoring MAP_HUGETLB (it's been
> doing this since day 1 of MTE). The implementation does handle the
> hugetlb file mmap() correctly but not the MAP_ANONYMOUS case.
> 
> The fix would be something like below:
> 
> -----------------8<--------------------------
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 5966ee4a6154..8ff5d88c9f12 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -28,7 +28,8 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
>  	 * backed by tags-capable memory. The vm_flags may be overridden by a
>  	 * filesystem supporting MTE (RAM-based).
>  	 */
> -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> +	if (system_supports_mte() &&
> +	    ((flags & MAP_ANONYMOUS) && !(flags & MAP_HUGETLB)))
>  		return VM_MTE_ALLOWED;
> 
>  	return 0;
> -------------------8<-----------------------
> 
> This fix won't make sense for mainline since it supports MAP_HUGETLB
> already.
> 
> Greg, are you ok with a stable-only fix as above or you'd rather see the
> full 25c17c4b55de ("hugetlb: arm64: add mte support") backported?

A stable-only fix for this is fine, thanks!  Can you send it with a
changelog and I'll queue it up.  Does it also need to go to older
kernels as well?

thanks,

greg k-h

