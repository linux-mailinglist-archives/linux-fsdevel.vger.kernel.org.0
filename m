Return-Path: <linux-fsdevel+bounces-71785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F045CD1D8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 21:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21B8F3001BE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A80281368;
	Fri, 19 Dec 2025 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6xlbBY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012112D3A60
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177547; cv=none; b=CNM2dnoKSfNEHihEODqjCNs44q0X4dyyF6eD0LlWyo/Suqofb2NgR4nlJpKgZBAn+IY9LvbJZIR12t4x00fD+m/azNzK95jzTL0WqA696e3ckzJ5G1iy18eDQR7ATIdY1dP+Lj0DLP5wV1ojREdlFy8hyrRn9JIrbZRlDUly3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177547; c=relaxed/simple;
	bh=1UnP1phlC1N1TzoJ+erXdvhZj4LIIeRmGQfpPPyOIYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfJSnVnEgKxOguBRn/f7XsLKOIUBfoVNCO67anbrbIvCcz30pzAMIVbzDqUMNC8DahafMorouYiGAqBMB7pxOXZRrAs0RvWeNKFPIZ6svxkkAcXXWNRQodmIG1TegtN2kNgUP9pAbR3S4NC7IYtYyhy3S2PthObHSD87eQN1pSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6xlbBY+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766177545; x=1797713545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1UnP1phlC1N1TzoJ+erXdvhZj4LIIeRmGQfpPPyOIYU=;
  b=J6xlbBY+dHeYJl002ree9tnIIH8rDFsW/XntnI/KQE46usbhuo7T/ORt
   gs1lGVbTshbCksA95zrdldG2Narb4daNo+D1UHxppi+jn1CdS1u06Duy9
   EDZJc0oORTZT1SV4UHuDqOk0Z8t5ASOqz6rGJWusL8ulLz9EAti8iby8w
   d33Yyb1EOpRTU/7t9dIAXg1ISK31CAZ330iVUR+28CGqYWgUVatm2WieZ
   0jn4nSJJjB88PazXrAuRTnAn4x2t6agi29GHsqshg/qa0JqAl7SWDdb3m
   5ACVxzPChTpWN8WgLhrIxYJkx5SwsQY2G7ZTfVHFIZVcOSktucQW+iPto
   Q==;
X-CSE-ConnectionGUID: vSn2u5uMSFiaPYBrxWwCrw==
X-CSE-MsgGUID: NKWigXQbQbem5wCFLyeKoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="78856563"
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="78856563"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 12:52:24 -0800
X-CSE-ConnectionGUID: 98Uh3zVhTE+23i7eXdgOKA==
X-CSE-MsgGUID: bx3AzxBJRcaevFLfuS8vuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="199196097"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.111.100]) ([10.125.111.100])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 12:52:22 -0800
Message-ID: <a2ce2849-e572-404c-9713-9283a43c09fe@intel.com>
Date: Fri, 19 Dec 2025 12:52:21 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arch/*: increase lowmem size to avoid highmem use
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andreas Larsson <andreas@gaisler.com>, Christophe Leroy
 <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>,
 Matthew Wilcox <willy@infradead.org>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Michal Simek <monstr@monstr.eu>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nishanth Menon <nm@ti.com>, Lucas Stach <l.stach@pengutronix.de>
References: <20251219161559.556737-1-arnd@kernel.org>
 <20251219161559.556737-2-arnd@kernel.org>
 <a3f22579-13ee-4479-a5fd-81c29145c3f3@intel.com>
 <bad18ad8-93e8-4150-a85e-a2852e243363@app.fastmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <bad18ad8-93e8-4150-a85e-a2852e243363@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 12:20, Arnd Bergmann wrote:
>> For simplicity, I think this can just be:
>>
>> -	default VMSPLIT_3G
>> +	default VMSPLIT_2G
>>
>> I doubt the 2G vs. 2G_OPT matters in very many cases. If it does, folks
>> can just set it in their config manually.
>>
>> But, in the end, I don't this this matters all that much. If you think
>> having x86 be consistent with ARM, for example, is more important and
>> ARM really wants this complexity, I can live with it.
> Yes, I think we do want the default of VMSPLIT_3G_OPT for
> configs that have neither highmem nor lpae, otherwise the most
> common embedded configs go from 3072 MiB to 1792 MiB of virtual
> addressing, and that is much more likely to cause regressions
> than the 2816 MiB default.
> 
> It would be nice to not need the VMSPLIT_2G default for PAE/LPAE,
> but that seems like a larger change.

The only thing we'd "regress" would be someone who is repeatedly
starting from scratch with a defconfig and expecting defconfig to be the
same all the time. I honestly think that's highly unlikely.

If folks are upgrading and _actually_ exposed to regressions, they've
got an existing config and won't be hit by these defaults at *all*. They
won't actually regress.

In other words, I think we can be a lot more aggressive about defaults
than with the feature set we support. I'd much rather add complexity in
here for solving a real problem, like if we have armies of 32-bit x86
users constantly starting new projects from scratch and using defconfigs.

I'd _really_ like to keep the defaults as simple as possible.

