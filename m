Return-Path: <linux-fsdevel+bounces-71808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A67CACD3DAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Dec 2025 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82C2630072B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Dec 2025 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCB1244665;
	Sun, 21 Dec 2025 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZt8jayi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E31397
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Dec 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766309425; cv=none; b=SMu8LGdJJBThkivxFTclwVPdScuFCqIITu+e+QsRPYDMM0RDAX6i2AVa84No/JRQMVomW173UN8Hc5ED0BtmC9PxkHcqwzpPZ9V8F5GIMVOc8vGRA2QSxHJh5YBaNq/sJSjoBxYwJUSQV5tgO+7tntk9lfUKus1fRuQVQKs3B24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766309425; c=relaxed/simple;
	bh=dynri6cO7Epp0o2N9qQ3cdoFscVQqJSuLqeok3MBBiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8oCO2MeLkHMWYUcjl95SIoHKZMOmSh0wb82w9OM6D23XCy5HgJxZFUCzJpZc0mtrS9cGmz+B8B5E0rAck+lty5pTEE1dSGaLBWClNcHTWYSlshUq948fgKMQouGIgPjhw5+7oaALJy/pycQeUsD2mnP8dyVMM8kAs6zZgaKXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZt8jayi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84754C4CEFB;
	Sun, 21 Dec 2025 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766309425;
	bh=dynri6cO7Epp0o2N9qQ3cdoFscVQqJSuLqeok3MBBiM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aZt8jayi0KTKlYfeM8PXcjFeXS/nexnOlW7wp5qpXy8jeA90IS+dY96x2qy1rT5xO
	 FHl5hVlhatmZm8PdARiR984pcX5Xnvb/DN3H8anneFIS8urkPCN+tf5dstcWVRW0gb
	 MtpipYZ4/nTh4uvDJud/EwfAeYoY6eMvezzyrEHIwa4jQVN+kGDWFX9QlrkXMmlhHg
	 +/MzLZJiX1cgSGhR6cIHSoivnfh4RJpQU3BWUmReDCQIKKfO8emvBUqYksawYAEan6
	 IemtDz7JnMnQaHpRMNWXo27R+S6bUs2yHEAc+/muXldZEic5H52t16UN2Lx8FHINn3
	 pxRdGiibDmVHQ==
Message-ID: <4aecb94f-e283-4720-96e5-1837352c3329@kernel.org>
Date: Sun, 21 Dec 2025 10:30:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arch/*: increase lowmem size to avoid highmem use
To: Dave Hansen <dave.hansen@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Arnd Bergmann <arnd@kernel.org>, linux-mm@kvack.org
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
 Michal Simek <monstr@monstr.eu>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nishanth Menon <nm@ti.com>, Lucas Stach <l.stach@pengutronix.de>
References: <20251219161559.556737-1-arnd@kernel.org>
 <20251219161559.556737-2-arnd@kernel.org>
 <a3f22579-13ee-4479-a5fd-81c29145c3f3@intel.com>
 <bad18ad8-93e8-4150-a85e-a2852e243363@app.fastmail.com>
 <a2ce2849-e572-404c-9713-9283a43c09fe@intel.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <a2ce2849-e572-404c-9713-9283a43c09fe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 21:52, Dave Hansen wrote:
> On 12/19/25 12:20, Arnd Bergmann wrote:
>>> For simplicity, I think this can just be:
>>>
>>> -	default VMSPLIT_3G
>>> +	default VMSPLIT_2G
>>>
>>> I doubt the 2G vs. 2G_OPT matters in very many cases. If it does, folks
>>> can just set it in their config manually.
>>>
>>> But, in the end, I don't this this matters all that much. If you think
>>> having x86 be consistent with ARM, for example, is more important and
>>> ARM really wants this complexity, I can live with it.
>> Yes, I think we do want the default of VMSPLIT_3G_OPT for
>> configs that have neither highmem nor lpae, otherwise the most
>> common embedded configs go from 3072 MiB to 1792 MiB of virtual
>> addressing, and that is much more likely to cause regressions
>> than the 2816 MiB default.
>>
>> It would be nice to not need the VMSPLIT_2G default for PAE/LPAE,
>> but that seems like a larger change.
> 
> The only thing we'd "regress" would be someone who is repeatedly
> starting from scratch with a defconfig and expecting defconfig to be the
> same all the time. I honestly think that's highly unlikely.
> 
> If folks are upgrading and _actually_ exposed to regressions, they've
> got an existing config and won't be hit by these defaults at *all*. They
> won't actually regress.
> 
> In other words, I think we can be a lot more aggressive about defaults
> than with the feature set we support. I'd much rather add complexity in
> here for solving a real problem, like if we have armies of 32-bit x86
> users constantly starting new projects from scratch and using defconfigs.
> 
> I'd _really_ like to keep the defaults as simple as possible.

I agree with that. In particular in areas where there is the chance that 
we could count the number of people that actually care about that with 
one hand (in binary ;) ).

-- 
Cheers

David

