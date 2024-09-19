Return-Path: <linux-fsdevel+bounces-29697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B79B97C6AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 11:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082E01F25473
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2B512E48;
	Thu, 19 Sep 2024 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KxWAU0sA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D962F19ABAC;
	Thu, 19 Sep 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737124; cv=none; b=LgLmlWIy42DJ5sit182sj+P0WqRpjewBxYsEg4IP/7xVCfHCU3m6S7yn9W9n+RvbSyIk9kpJP3Zg3ZhjTOCkidIUdkpXLnnVdXAd7Mb4x+lbx+t9wEWH1rA7oIoEFpSRZuZ6CSDATN9jCn1ItcRZctiGV0bu8gUh2k+1/DDgwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737124; c=relaxed/simple;
	bh=GRaM6wOTqW6/lUjG+bM3shCBbIIJiMeQtQqlr5Drc4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmRBHRY27XRbqMzYDdAYXombqU+c8EsqBe8Qug6utnWNZhW+A5hdInAoJWANi7c4tzI3NkR8rRp+1/pWyeG/Sih6ECz9w+rce/GhaMoQTUWaobV1SqyW0OtR3NOY4WDCI2Jpbo2Qdu4/qiZ4IL9wAe54MIDvCljOPRYYKCYn2V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KxWAU0sA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XSYMeRXWsqrG7F+YI4a+nTQDZpFZ8nCNoB9zSp4g67c=; b=KxWAU0sAe0pRV5nAR7txSNGzJO
	XItJFBQrVuo5+4RSvbrFlqhDYvmkcSNIXEF68oEPTYwT+q2A1ztZDqeCU7pgQ5zkeuBwY9fqcBchi
	4tvviAn87X1iy16W61vx5GnGCbZRricPB3EC7Ak7ApdDDKI/kEIyNBWxUtRDWMmFwgziStsxXWAxP
	xnQJ5ixS87mwS0FPpD6dgfSy2lwrJdqsOXeSEhaUnKkK+5R2prDQOPpvO6fPHZovTNcqWgnlTPRQs
	7ljx1NENkRmTCWVNLz+cyLfxQ+KwhrA2wFu4yR38fJzRWYlqoMw/lW9y+mYenxEqWEJk1iom421Zq
	bTaPfakA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59440)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1srDBz-0000GJ-37;
	Thu, 19 Sep 2024 10:11:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1srDBn-0001Rd-0M;
	Thu, 19 Sep 2024 10:11:03 +0100
Date: Thu, 19 Sep 2024 10:11:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Muchun Song <muchun.song@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 7/7] mm: Use pgdp_get() for accessing PGD entries
Message-ID: <ZuvqpvJ6ht4LCuB+@shell.armlinux.org.uk>
References: <20240917073117.1531207-8-anshuman.khandual@arm.com>
 <202409190310.ViHBRe12-lkp@intel.com>
 <8f43251a-5418-4c54-a9b0-29a6e9edd879@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f43251a-5418-4c54-a9b0-29a6e9edd879@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 19, 2024 at 01:25:08PM +0530, Anshuman Khandual wrote:
> arm (32) platform currently overrides pgdp_get() helper in the platform but
> defines that like the exact same version as the generic one, albeit with a
> typo which can be fixed with something like this.

pgdp_get() was added to arm in eba2591d99d1 ("mm: Introduce
pudp/p4dp/pgdp_get() functions") with the typo you've spotted. It seems
it was added with no users, otherwise the error would have been spotted
earlier. I'm not a fan of adding dead code to the kernel for this
reason.

> Regardless there is another problem here. On arm platform there are multiple
> pgd_t definitions available depending on various configs but some are arrays
> instead of a single data element, although platform pgdp_get() helper remains
> the same for all.
> 
> arch/arm/include/asm/page-nommu.h:typedef unsigned long pgd_t[2];
> arch/arm/include/asm/pgtable-2level-types.h:typedef struct { pmdval_t pgd[2]; } pgd_t;
> arch/arm/include/asm/pgtable-2level-types.h:typedef pmdval_t pgd_t[2];
> arch/arm/include/asm/pgtable-3level-types.h:typedef struct { pgdval_t pgd; } pgd_t;
> arch/arm/include/asm/pgtable-3level-types.h:typedef pgdval_t pgd_t;
> 
> I guess it might need different pgdp_get() variants depending applicable pgd_t
> definition. Will continue looking into this further but meanwhile copied Russel
> King in case he might be able to give some direction.

That's Russel*L*, thanks.

32-bit arm uses, in some circumstances, an array because each level 1
page table entry is actually two descriptors. It needs to be this way
because each level 2 table pointed to by each level 1 entry has 256
entries, meaning it only occupies 1024 bytes in a 4096 byte page.

In order to cut down on the wastage, treat the level 1 page table as
groups of two entries, which point to two consecutive 1024 byte tables
in the level 2 page.

The level 2 entry isn't suitable for the kernel's use cases (there are
no bits to represent accessed/dirty and other important stuff that the
Linux MM wants) so we maintain the hardware page tables and a separate
set that Linux uses in the same page. Again, the software tables are
consecutive, so from Linux's perspective, the level 2 page tables
have 512 entries in them and occupy one full page.

This is documented in arch/arm/include/asm/pgtable-2level.h

However, what this means is that from the software perspective, the
level 1 page table descriptors are an array of two entries, both of
which need to be setup when creating a level 2 page table, but only
the first one should ever be dereferenced when walking the tables,
otherwise the code that walks the second level of page table entries
will walk off the end of the software table into the actual hardware
descriptors.

I've no idea what the idea is behind introducing pgd_get() and what
it's semantics are, so I can't comment further.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

