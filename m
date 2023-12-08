Return-Path: <linux-fsdevel+bounces-5297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA1809C76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 07:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C891C20CDE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 06:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6ABDDAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vFi4gQ/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A271A10F1;
	Thu,  7 Dec 2023 21:15:33 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231208051528epoutp02f62a22e4a1f9a0a100e07eed1efdcf05~ew2BpykZD0396703967epoutp02L;
	Fri,  8 Dec 2023 05:15:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231208051528epoutp02f62a22e4a1f9a0a100e07eed1efdcf05~ew2BpykZD0396703967epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702012528;
	bh=h/zNPKebJjgO3x5YIRu6IEuCHAp9uLbx3pzG4mbKSf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vFi4gQ/kmltJ31PjSs93GXeTc4zEQJ8EUPB8wtUye4DSZ8ye4Z84KJhU4VLa1tdbW
	 n82Cm9mKUZCC7uB0WwZczZQij8Ka6ubfVZ2WSzO9GFY1C7E0Wq1zsjlKzBEfZWPYtj
	 BJmfAd+Q+26HxX+xxcd4rIcqrMvx79FS4oSWW7YU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20231208051527epcas2p47b86be684c740372ea3f5c271c6a602e~ew2A9XM9o1077210772epcas2p4c;
	Fri,  8 Dec 2023 05:15:27 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.69]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SmfV62jDmz4x9Q3; Fri,  8 Dec
	2023 05:15:26 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E7.2F.18994.E66A2756; Fri,  8 Dec 2023 14:15:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231208051525epcas2p3dabd33e6844640d4cec22b13d3d5b03c~ew1-bHXo_2679126791epcas2p3H;
	Fri,  8 Dec 2023 05:15:25 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231208051525epsmtrp100d30e5016e029475cf483a79abdde32~ew1-ZZi1j1106611066epsmtrp1g;
	Fri,  8 Dec 2023 05:15:25 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-09-6572a66e29b0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1B.E5.07368.D66A2756; Fri,  8 Dec 2023 14:15:25 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231208051525epsmtip2180f600b636fbdc8a47553f868a430be~ew1-CImH-2215922159epsmtip2F;
	Fri,  8 Dec 2023 05:15:25 +0000 (GMT)
Date: Fri, 8 Dec 2023 14:03:44 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 11/27] arm64: mte: Reserve tag storage memory
Message-ID: <20231208050340.GA1359878@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZWxxJipc2STxHHKn@raptor>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTdxjH/d1drwUtOarG36pjpDo3UKB1VH6oEJcZc8aNkS3bZEvEWi6A
	lrbplTlGArgxZKggKDgqkjqgoNaUtKCzQGVQedsMkTcjqGwqRJkUVleZILrWw8X/Pvk+zzfP
	Wx4BLhriiwWpaj2jUytUEtKfuNgeIg9Tm3SMtK54CaqwmEl08mw/iRxdSjRf0sFHffcGvdLD
	gwSaMh0ByGOZxdHYsUYc/Wp0EWjMXUigUUcthm4XlRLo0vgkhiYa2gmUb/cQyHpviIeaW7oJ
	1G+vINEd8wseclquEehyRTcPHXeNA1RVuxb1tRoxVPr0EYmKbt0gUefRVgw58v/AvLmXMHTQ
	OUWi8pERgPKdT3DU8vwpgRqvzvBR7i05ullTz9/6Nm2uNAN6brYE0LmOYT5ttKbTuc5JHm2r
	C6Wt534kaau7hE/fGmom6a6f5gj6TE4pTtuqs+kHtnJATzkGSdr2Wyb92BoUT325f0sKo0hi
	dMGMWqlJSlUnx0h2fpr4QaJ8o1QWJotGUZJgtSKNiZFs+zA+bHuqyrtMSfDXClW6V4pXsKwk
	InaLTpOuZ4JTNKw+RsJok1TaKG04q0hj09XJ4WpGv0kmlW6QexP37E85Mp5Hau3x31xsN5I5
	wBhTAPwEkIqEdtcNvAD4C0RUM4DNfxtwX0BEuQF84YzjAk8ALLPN4K8czprzBBdoAdD1oHjB
	PgZg7UAe8GUR1BronjXwfUxS78CuBtNLfRkVAe82TgCfAad6SHj71O9YARAIllI0vHRf5ssR
	UuGwoqeXx3Eg7C6/T/jYj1oLh11NfJ8XUoX+sKrVDLiWtsGqE/8s8FI40dnA51gMHxblLTAL
	L1a1Y5w5B0Bb/ujCPO9Bw/ihl2acSoF3XScIX0OQWg2dwwQnB8D89nk+Jwthfp6Ic66GV0yV
	BMdvwLsXDvE4puHNulk+t5TvMTjyrAw/BoIMr81jeK0ax+uhsclNGrwlcGolrH0u4DAEWuwR
	RsA7B8SMlk1LZpQbtLIwNXPg/ysrNWlW8PLBQj/6BfxlmQ9vA5gAtAEowCXLhKpeDSMSJiky
	vmV0mkRduoph24Dce6BiXLxcqfF+qFqfKIuMlkZu3CiL2iCXRklWCO/8cDpJRCUr9Mx+htEy
	ulc+TOAnzsFwsswTCE9svRq/aNusuMdiWfdFbMSfozXHF+/N2l2XkaqJ3tGGwMrFWX6ZCRmD
	11IPdIwmlD87Ff0wwFgXFDytO9RbMr48e9Ve3cDRot3lrYsc9Z9Mny92v7lml2M0avHPS/q/
	W9/Xd3hdS+y/ecKmwsGg+abAPd3KkI7krMdXLuwMmNG+Jeyd7MI3denj5q4Mac646cMrPjfl
	1VTb2WCZudqm2rfPdPL08K64j5+umdzc3Tb4yEBfEBdWzoiE2QNW9Vfg7LtHRuyeGXfL0JR/
	TJWt5vpY+ZMdns0rMqer2c+W96/yRAZqIzPlvbPre0o6FSECR8W96/v0uWP17OX3E64OSAg2
	RSELxXWs4j8GZoSn6QQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH7/s8z549zDgf0OoBT6tl07gER3Z9Qvx5dH077ZdH3eU/uYNH
	Zm5jbYAFZuBRN7ychMcx1lKkZDnWoRuDGGwqDBikKTJ/8EOsppxo22oE3jBmTOryv/e936/X
	568PQyYaBMnMLlUBr1HJFGJaRLV0iZ9apWzQ8KtdXUvB1GSloebEIA1ubw7MVvUI4ZL/8lw1
	UUZBqOFLBFNNMyTcqnSQcLYuSMGtsJ6CG24zAdcPVVPQOh4g4E5zFwU65xQFNv8VAXS4+igY
	dJpoGLM+EICn6TwFbaY+ARwOjiP41iyBS2fqCKiO/E7DodGrNPQePEOAW/cLMce2ElDmCdFQ
	OzKCQOeZJsEVjVDg6L4nhPLRl2Do+Enhxuew9YgV4fszVQiXu4eFuM5WiMs9AQG2f5+CbZYK
	GtvCVUI8eqWDxl7DfQofK60msf27z/Btey3CIfdlGtt/KsGTtmVvs9tFmbm8YlcRr0lbv0Mk
	P/dVG62eeePjlou9glIUyTiA4hiOXcN5jjdSB5CISWTbEddk6KbnhyTOONlHzOdF3I1yj2Ae
	8iNuyt7/EKLY5Vx4xiiMZZpdwXmbG1AsL2bTuN8cd1BMINlzNKdvNM7ZDLOIxVzrTWmMiWdT
	OVP/hX+Pfk5ws/WHifkhgeurvUnFMsmmcNeiE0TMJdklnDnKxOo4VsINB9uFlYg1PmIYHzGM
	/xt1iLSgJF6tVeYpc6RqqYrfk6qVKbWFqrzUnHylDT18npSVP6Kxo9HUTkQwqBNxDCleHK+4
	kM8nxufKPinmNfkfaAoVvLYTLWEo8ZPxUsPXuYlsnqyA383zal7z30owccmlxKa3HhPtfMcy
	XVGCnMqRHf7te36QXNy31rV8tW9an57eu8399O2sL8Lm7op7qL5G9nORdXe2aYO5bY0mOtQ1
	9ffpDZbxN4s3nX91TJ695dn2glNZEtf7gScWLm35yB36Q1f6q6/Z7u1NWud9RiUfqFqv3bbW
	WRSxTgZO6jdLiLKVlfZh0Z+qiX5fx/70dcvuWg5if/31uy++cOTDVZW5K/4q9iSoIXmjIjN0
	dSz53fZswueoURDvDeNrNSULF7z+/Cnr0Kc7z57uyay18obwy4GELeMDqozm1xQPOnxBvc6x
	+cQrWZ1y17Gtk8yChowRdcQ/4Exr3P/N4z37yvZOhPcGB2fFlFYuk6aQGq3sHz+TVwurAwAA
X-CMS-MailID: 20231208051525epcas2p3dabd33e6844640d4cec22b13d3d5b03c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_931d8_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231119165840epcas2p2c99f1dd358f716c103c16f47cc23bf2a
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
	<CGME20231119165840epcas2p2c99f1dd358f716c103c16f47cc23bf2a@epcas2p2.samsung.com>
	<20231119165721.9849-12-alexandru.elisei@arm.com>
	<20231129084424.GA2988384@tiffany> <ZWxxJipc2STxHHKn@raptor>

------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_931d8_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi, 

I'm sorry for the late response, I was on vacation.

On Sun, Dec 03, 2023 at 12:14:30PM +0000, Alexandru Elisei wrote:
> Hi,
> 
> On Wed, Nov 29, 2023 at 05:44:24PM +0900, Hyesoo Yu wrote:
> > Hello.
> > 
> > On Sun, Nov 19, 2023 at 04:57:05PM +0000, Alexandru Elisei wrote:
> > > Allow the kernel to get the size and location of the MTE tag storage
> > > regions from the DTB. This memory is marked as reserved for now.
> > > 
> > > The DTB node for the tag storage region is defined as:
> > > 
> > >         tags0: tag-storage@8f8000000 {
> > >                 compatible = "arm,mte-tag-storage";
> > >                 reg = <0x08 0xf8000000 0x00 0x4000000>;
> > >                 block-size = <0x1000>;
> > >                 memory = <&memory0>;	// Associated tagged memory node
> > >         };
> > >
> > 
> > How about using compatible = "shared-dma-pool" like below ?
> > 
> > &reserved_memory {
> > 	tags0: tag0@8f8000000 {
> > 		compatible = "arm,mte-tag-storage";
> >         	reg = <0x08 0xf8000000 0x00 0x4000000>;
> > 	};
> > }
> > 
> > tag-storage {
> >         compatible = "arm,mte-tag-storage";
> > 	memory-region = <&tag>;
> >         memory = <&memory0>;
> > 	block-size = <0x1000>;
> > }
> > 
> > And then, the activation of CMA would be performed in the CMA code.
> > We just can get the region information from memory-region and allocate it directly
> > like alloc_contig_range, take_page_off_buddy. It seems like we can remove a lots of code.
>

Sorry, that example was my mistake. Actually I wanted to write like this. 

&reserved_memory {
	tags0: tag0@8f8000000 {
		compatible = "shared-dma-pool";
        	reg = <0x08 0xf8000000 0x00 0x4000000>;
		reusable;
	};
}

tag-storage {
        compatible = "arm,mte-tag-storage";
 	memory-region = <&tag>;
        memory = <&memory0>;
	block-size = <0x1000>;
}


> Played with reserved_mem a bit. I don't think that's the correct path
> forward.
> 
> The location of the tag storage is a hardware property, independent of how
> Linux is configured.
> 
> early_init_fdt_scan_reserved_mem() is called from arm64_memblock_init(),
> **after** the kernel enforces an upper address for various reasons. One of
> the reasons can be that it's been compiled with 39 bits VA.
> 

I'm not sure about this part. What is the upper address enforced by the kernel ?
Where can I check the code ? Do you means that memblock_end_of_DRAM() ?  

> After early_init_fdt_scan_reserved_mem() returns, the kernel sets the
> maximum address, stored in the variable "high_memory".
>
> What can happen is that tag storage is present at an address above the
> maximum addressable by the kernel, and the CMA code will trigger an
> unrecovrable page fault.
> 
> I was able to trigger this with the dts change:
> 
> diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> index 60472d65a355..201359d014e4 100644
> --- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> +++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> @@ -183,6 +183,13 @@ vram: vram@18000000 {
>                         reg = <0x00000000 0x18000000 0 0x00800000>;
>                         no-map;
>                 };
> +
> +
> +               linux,cma {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0x100 0x0 0x00 0x4000000>;
> +                       reusable;
> +               };
>         };
> 
>         gic: interrupt-controller@2f000000 {
> 
> And the error I got:
> 
> [    0.000000] Reserved memory: created CMA memory pool at 0x0000010000000000, size 64 MiB
> [    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
> [    0.000000] OF: reserved mem: 0x0000010000000000..0x0000010003ffffff (65536 KiB) map reusable linux,cma
> [..]
> [    0.793193] WARNING: CPU: 0 PID: 1 at mm/cma.c:111 cma_init_reserved_areas+0xa8/0x378
> [..]
> [    0.806945] Unable to handle kernel paging request at virtual address 00000001fe000000
> [    0.807277] Mem abort info:
> [    0.807277]   ESR = 0x0000000096000005
> [    0.807693]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.808110]   SET = 0, FnV = 0
> [    0.808443]   EA = 0, S1PTW = 0
> [    0.808526]   FSC = 0x05: level 1 translation fault
> [    0.808943] Data abort info:
> [    0.808943]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [    0.809360]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    0.809776]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    0.810221] [00000001fe000000] user address but active_mm is swapper
> [..]
> [    0.820887] Call trace:
> [    0.821027]  cma_init_reserved_areas+0xc4/0x378
> [    0.821443]  do_one_initcall+0x7c/0x1c0
> [    0.821860]  kernel_init_freeable+0x1bc/0x284
> [    0.822277]  kernel_init+0x24/0x1dc
> [    0.822693]  ret_from_fork+0x10/0x20
> [    0.823554] Code: 9127a29a cb813321 d37ae421 8b030020 (f8636822)
> [    0.823554] ---[ end trace 0000000000000000 ]---
> [    0.824360] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    0.824443] SMP: stopping secondary CPUs
> [    0.825193] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> Should reserved mem check if the reserved memory is actually addressable by
> the kernel if it's not "no-map"? Should cma fail gracefully if
> !pfn_valid(base_pfn)? Shold early_init_fdt_scan_reserved_mem() be moved
> because arm64_bootmem_init()? I don't have the answer to any of those. And
> I got a kernel panic because the kernel cannot address that memory (39 bits
> VA). I don't know what would happen if the upper limit is reduced for
> another reason.
> 

My answer may not be accurate because I don't understand what this upper limit is.
Is this a problem caused by the tag storage area not being included in the memory node ?

The reason for not including it in the memory node is to enable static mte when dmte
initilization fails, right ? I think I missed that. I thought the tag storage is included
in the memory node and registered as cma.

> What I think should happen:
> 
> 1. Add the tag storage memory before any limits are enforced by
> arm64_bootmem_init().
>
> 2. Call cma_declare_contiguous_nid() after arm64_bootmem_init(), because
> the function will check the memory limit.
> 
> 3. Have an arch initcall that checks that the CMA regions corresponding to
> the tag storage have been activated successfully (cma_init_reserved_areas()
> is a core initcall). If not, then don't enable tag storage.
> 
> How does that sound to you?
> 
> Thanks,
> Alex
> 

I think this is a good way to utilize the cma code !

Thanks,
Regards.

> > > +	ret = tag_storage_of_flat_read_u32(node, "block-size", &block_size_bytes);
> > > +	if (ret || block_size_bytes == 0) {
> > > +		pr_err("Invalid or missing 'block-size' property");
> > > +		return -EINVAL;
> > > +	}
> > > +	region->block_size = get_block_size_pages(block_size_bytes);
> > > +	if (range_len(tag_range) % region->block_size != 0) {
> > > +		pr_err("Tag storage region size 0x%llx is not a multiple of block size %u",
> > > +		       PFN_PHYS(range_len(tag_range)), region->block_size);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > 
> > I was confused about the variable "block_size", The block size declared in the device tree is
> > in bytes, but the actual block size used is in pages. I think the term "block_size" can cause
> > confusion as it might be interpreted as bytes. If possible, I suggest changing the term "block_size"
> > to something more readable, such as "block_nr_pages" (This is just a example!)
> > 
> > Thanks,
> > Regards.
>>

What do you think about this ?

Thanks,
Regards.

> > > +	ret = tag_storage_of_flat_read_u32(mem_node, "numa-node-id", &nid);
> > > +	if (ret)
> > > +		nid = numa_node_id();
> > > +
> > > +	ret = memblock_add_node(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)),
> > > +				nid, MEMBLOCK_NONE);
> > > +	if (ret) {
> > > +		pr_err("Error adding tag memblock (%d)", ret);
> > > +		return ret;
> > > +	}
> > > +	memblock_reserve(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)));
> > > +
> > > +	pr_info("Found tag storage region 0x%llx-0x%llx, block size %u pages",
> > > +		PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end), region->block_size);
> > > +
> > > +	num_tag_regions++;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void __init mte_tag_storage_init(void)
> > > +{
> > > +	struct range *tag_range;
> > > +	int i, ret;
> > > +
> > > +	ret = of_scan_flat_dt(fdt_init_tag_storage, NULL);
> > > +	if (ret) {
> > > +		for (i = 0; i < num_tag_regions; i++) {
> > > +			tag_range = &tag_regions[i].tag_range;
> > > +			memblock_remove(PFN_PHYS(tag_range->start), PFN_PHYS(range_len(tag_range)));
> > > +		}
> > > +		num_tag_regions = 0;
> > > +		pr_info("MTE tag storage region management disabled");
> > > +	}
> > > +}
> > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > index 417a8a86b2db..1b77138c1aa5 100644
> > > --- a/arch/arm64/kernel/setup.c
> > > +++ b/arch/arm64/kernel/setup.c
> > > @@ -42,6 +42,7 @@
> > >  #include <asm/cpufeature.h>
> > >  #include <asm/cpu_ops.h>
> > >  #include <asm/kasan.h>
> > > +#include <asm/mte_tag_storage.h>
> > >  #include <asm/numa.h>
> > >  #include <asm/scs.h>
> > >  #include <asm/sections.h>
> > > @@ -342,6 +343,12 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> > >  			   FW_BUG "Booted with MMU enabled!");
> > >  	}
> > >  
> > > +	/*
> > > +	 * Must be called before memory limits are enforced by
> > > +	 * arm64_memblock_init().
> > > +	 */
> > > +	mte_tag_storage_init();
> > > +
> > >  	arm64_memblock_init();
> > >  
> > >  	paging_init();
> > > -- 
> > > 2.42.1
> > > 
> > > 
> 
> 
> 

------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_931d8_
Content-Type: text/plain; charset="utf-8"


------enUWWt6WoF-Ggb2-rjyEux7skZ5dSWJ5iC_e377tM680ja-K=_931d8_--

