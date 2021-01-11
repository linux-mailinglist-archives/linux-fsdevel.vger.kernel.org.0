Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66EC2F0EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 10:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbhAKJRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 04:17:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbhAKJRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:17:32 -0500
Date:   Mon, 11 Jan 2021 10:16:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610356608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LEXe/B0Q3kSQ+pyi11QVzunFEXSDJfyzRctZD/mSGwY=;
        b=uCnnwbctZA1rQ3V0p2kZu+d3zaZFHTKUJPOo76b5D7cuxWEOXVJdpIqiLFP5aTXpvIjv9s
        qwAvW5WhwffRTnvcztEi2+1v/oENxwE79UOubMC7jJKeubOBD6zsvQUL74GztGQIAKB8HO
        BT4sxjhTakFs4dVqAQh6GY6Sn14JBtplCvPA2cmstH/p72FEB2TnSYVyeSL8sjTNI80v3T
        oCsDUl6wYJXQ9QueQxoB6wuP+fNUTobWuAtyizRQCOtZthAqYs4ojlXRNfsr2J83hANEKU
        KrLFmoV7Ai9vVG4RtXD3Lh/qUjXo6jULZnNtu/UYw3EhRXUZtNRGRg4NMuxugQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610356608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LEXe/B0Q3kSQ+pyi11QVzunFEXSDJfyzRctZD/mSGwY=;
        b=aQ0P+BB77W0OA8uLsIQDcnYrwKkOka8jvG0VLRGl2/Wpm04Edp57/CM7syBgLiKrsJkDcC
        9SLKzMSTP9RzBiAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Cercueil <paul@crapouillou.net>, tglx@linutronix.de,
        airlied@linux.ie, airlied@redhat.com, akpm@linux-foundation.org,
        arnd@arndb.de, bcrl@kvack.org, bristot@redhat.com,
        bsegall@google.com, bskeggs@redhat.com, chris@zankel.net,
        christian.koenig@amd.com, clm@fb.com, davem@davemloft.net,
        deanbo422@gmail.com, dietmar.eggemann@arm.com,
        dri-devel@lists.freedesktop.org, dsterba@suse.com,
        green.hu@gmail.com, hch@lst.de, intel-gfx@lists.freedesktop.org,
        jcmvbkbc@gmail.com, josef@toxicpanda.com, juri.lelli@redhat.com,
        kraxel@redhat.com, linux-aio@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        mgorman@suse.de, mingo@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com,
        nouveau@lists.freedesktop.org, paulmck@kernel.org,
        paulus@samba.org, peterz@infradead.org, ray.huang@amd.com,
        rodrigo.vivi@intel.com, rostedt@goodmis.org,
        sparclinux@vger.kernel.org, spice-devel@lists.freedesktop.org,
        sroland@vmware.com, torvalds@linuxfoundation.org,
        vgupta@synopsys.com, vincent.guittot@linaro.org,
        viro@zeniv.linux.org.uk, virtualization@lists.linux-foundation.org,
        x86@kernel.org
Subject: Re: [patch V3 13/37] mips/mm/highmem: Switch to generic kmap atomic
Message-ID: <20210111091646.hkugbtlcced3vmno@linutronix.de>
References: <JUTMMQ.NNFWKIUV7UUJ1@crapouillou.net>
 <20210108235805.GA17543@alpha.franken.de>
 <20210109003352.GA18102@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210109003352.GA18102@alpha.franken.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-01-09 01:33:52 [+0100], Thomas Bogendoerfer wrote:
> On Sat, Jan 09, 2021 at 12:58:05AM +0100, Thomas Bogendoerfer wrote:
> > On Fri, Jan 08, 2021 at 08:20:43PM +0000, Paul Cercueil wrote:
> > > Hi Thomas,
> > > 
> > > 5.11 does not boot anymore on Ingenic SoCs, I bisected it to this commit.
> > > 
> > > Any idea what could be happening?
> > 
> > not yet, kernel crash log of a Malta QEMU is below.
> 
> update:
> 
> This dirty hack lets the Malta QEMU boot again:
> 
> diff --git a/mm/highmem.c b/mm/highmem.c
> index c3a9ea7875ef..190cdda1149d 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -515,7 +515,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
>  	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
>  	BUG_ON(!pte_none(*(kmap_pte - idx)));
>  	pteval = pfn_pte(pfn, prot);
> -	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
> +	set_pte(kmap_pte - idx, pteval);
>  	arch_kmap_local_post_map(vaddr, pteval);
>  	current->kmap_ctrl.pteval[kmap_local_idx()] = pteval;
>  	preempt_enable();
> 
> set_pte_at() tries to update cache and could do an kmap_atomic() there.
So the old implementation used set_pte() while the new one uses
set_pte_at().

> Not sure, if this is allowed at this point.
The problem is the recursion
  kmap_atomic() -> __update_cache() -> kmap_atomic()

and kmap_local_idx_push() runs out if index space before stack space.

I'm not sure if the __update_cache() worked for highmem. It has been
added for that in commit
   f4281bba81810 ("MIPS: Handle highmem pages in __update_cache")

but it assumes that the address returned by kmap_atomic() is the same or
related enough for flush_data_cache_page() to work.

> Thomas.
> 

Sebastian
